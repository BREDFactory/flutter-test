import "package:flutter/material.dart";
import "dart:convert";
import "dart:core";
import "package:http/http.dart" as http;
import 'package:flutter_github_jobs/screens/DetailsScreen.dart';

class JobListScreen extends StatefulWidget {
  JobListScreen({Key key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  List<Job> jobs = [];
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  Future<List<Job>> fetchJobs() async {
    final response = await http.get("http://jobs.github.com/positions.json?location=${Uri.encodeFull(locationController.text)}&description=${Uri.encodeFull(descriptionController.text)}");
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      List<Job> jobs = [];
      for (var job in result) {
        jobs.add(Job.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception("Failed to load jobs");
    }
  }

  void updateJobs() async {
    setState(() { loading = true; });
    var newJobs = await fetchJobs();
    setState(() { jobs = newJobs; loading = false; });
  }

  Widget makeJobList(List<Job> jobs) {
    return (loading) ? Center(
      child:CircularProgressIndicator(),
    ) : (jobs.length > 0) ? ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, int index) {
        return JobComponent(job: jobs[index]);
      },
    ) : new Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Jobs List Screen'),
          backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.text,
            ),
            RaisedButton(
              onPressed: () { updateJobs(); },
              child: Text(
                'Refresh',
              ),
            ),
            Expanded(child: makeJobList(jobs)),
          ]
        )
      )
    );
  }
}

class Job {
  final String id;
  final String type;
  final String url;
  final String createdAt;
  final String company;
  final String companyUrl;
  final String location;
  final String title;
  final String description;
  final String howToApply;
  final String companyLogo;

  Job({
      this.id,
      this.type,
      this.url,
      this.createdAt,
      this.company,
      this.companyUrl,
      this.location,
      this.title,
      this.description,
      this.howToApply,
      this.companyLogo,
    });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json["id"],
      type: json["type"],
      url: json["url"],
      createdAt: json["created_at"],
      company: json["company"],
      companyUrl: json["company_url"],
      location: json["location"],
      title: json["title"],
      description: json["description"],
      howToApply: json["how_to_apply"],
      companyLogo: json["company_logo"],
    );
  }
}

class JobComponent extends StatelessWidget {
  JobComponent({Key key, this.job}) : super(key: key);

  final Job job;

  Widget makeListTile(Job job) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
            right: new BorderSide(width: 1.0, color: Colors.grey)
          )
        ),
        child: Image.network(
            job?.companyLogo ?? "https://www.amplifiedtelephones.co.uk/user/products/large/image-unavailable-amplified-telephones.jpg",
            height: 65,
            width: 65,
          )
      ),
      title: Text(
        job.title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      // subtitle
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.black, size: 30.0,
      ),
    );
  }

  Widget makeCard(Job job) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTile(job)
      )
    );
  }

  Widget makeTouchableCard(BuildContext context, Job job) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(jobInformation: job))
        );
      },
      child: makeCard(job),
    );
  }

  @override
  Widget build(BuildContext context) {
    return makeTouchableCard(context, job);
  }
}