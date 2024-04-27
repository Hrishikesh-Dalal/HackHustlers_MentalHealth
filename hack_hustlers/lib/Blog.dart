import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class BlogPost {
  final String title;
  final String description;
  final String fullContent;
  final String? imageUrl; // Add this line

  BlogPost({
    required this.title,
    required this.description,
    required this.fullContent,
    this.imageUrl, // Add this line
  });
}

class _BlogState extends State<Blog> {
  // Sample blog posts
  final List<BlogPost> blogPosts = [
    BlogPost(
      title: 'The Idea of Madness',
      description:
          'As a society, how do we understand what is normal and what is pathological?\n\nA researcher and activist urges us to free the idea of ‘madness’ from the symptom-illness-recovery framework.',
      fullContent: '''
Understanding Mental Health: A Conversation with Jayasree Kalathil 

\nJayasree Kalathil, a renowned mental health advocate and researcher, challenges the conventional medical model of understanding mental distress. This summary highlights key points from her interview with Third Eye: 

\nChallenging the Definition of "Madness"\n

\nKalathil advocates for incorporating the lived experiences and perspectives of individuals who have faced mental distress, moving beyond the traditional definitions shaped by psychiatry and societal norms.
\nShe identifies as a survivor of psychiatry and emphasizes the importance of "survivor knowledge" and "Mad Studies" in reshaping our understanding of mental health.

\nEarly Advocacy and the Evolution of Discourse

\nKalathil's involvement in mental health advocacy stemmed from her personal experiences with mental distress, leading her to question the dominant narratives surrounding it. 
\nShe co-founded Aaina, India's first mental health newsletter, to foster open discussions and critical thinking about mental health issues.
\nWhile acknowledging the positive growth of organized mental health advocacy in India, Kalathil expresses concern about the lack of critical engagement with the medical model's limitations.

\nBeyond "Let's Talk": Addressing Systemic Issues\n 

Kalathil critiques the popular "Let's talk about mental health" approach, emphasizing the need to address the societal structures and systemic issues that contribute to mental distress.
\nShe highlights the example of women facing domestic violence, where focusing solely on individual diagnoses of depression overlooks the root causes of their distress.

\nCaste and Mental Health in India

\nKalathil points out the lack of attention given to caste within the mental health discourse in India. 
\nShe acknowledges the emerging voices discussing the intersection of caste and mental health, such as Divya Kandukuri's work with The Blue Dawn, but emphasizes the need for broader engagement with this issue within the mainstream mental health movement.

\nJayasree Kalathil's work underscores the importance of moving beyond clinical definitions and embracing diverse perspectives in understanding and addressing mental health challenges. Her insights encourage a more holistic and inclusive approach that considers the social, cultural, and structural factors that shape our mental well-being.

''',
      imageUrl: 'images/blog1.png',
    ),
    BlogPost(
      title: 'Yoga For Good Mental Health',
      description:
          'Yoga and mental health both are the combination of growing health. Yoga appears to modulate stress response system by reducing perceived stress and anxiety. Though yoga has received less attention in the medical literature it has become increasingly popular in recent decades.',
      fullContent: '''
 HOW YOGA AFFECTS MENTAL HEALTH\n
Yoga's positive benefits on mental health have made it an important practice tool in psychotherapy. It has been shown to:

\nEnhance social well-being: \n  Fosters a sense of belonging and connection with others. 
\nAlleviate symptoms of depression:\n  Improves mood and reduces feelings of sadness and hopelessness.
\nImprove attention and focus:\n  Helps manage attention deficit disorders and enhances concentration.
\nPromote better sleep:\n  Reduces insomnia and promotes restful sleep patterns.
\nReduce anxiety:\n  Provides tools and techniques for managing anxiety and stress.
\nEnhance mood and mindfulness:\n  Increases self-awareness and promotes a positive outlook. 
\nImprove workplace well-being and resilience:\n  Reduces stress and enhances coping mechanisms in work environments.
\nSupport caregivers:\n  Alleviates stress, depression, and low life satisfaction often experienced by caregivers.
\nYoga: A Change Factor for a Peaceful Mindset\n
Yoga induces a state of deep relaxation, calming the nervous system and shifting the body from tension to tranquility. Practices like deep breathing and meditation activate the relaxation response, leading to significant improvements in both physical and mental health.
\nYoga's Impact on Mental Health:
\nReduces anxiety and depression:\n  Promotes feelings of calm and well-being.
\nImproves mood and self-esteem:\n  Increases self-confidence and a positive self-image.
\nEnhances cognitive function:\n  Improves focus, concentration, and memory.
\nReduces social withdrawal:\n  Encourages social connection and belonging. 
\n(Dec 2015, B.N. Gangadhar and Kishan Porandla)
''',
      imageUrl: 'images/blog2.png',
    ),
    BlogPost(
      title: 'Speech Therapy',
      description:
          '“Speech Therapy is an art that deserves to be more widely known. You cannot imagine the acrobatics your tongue mechanically performs in order to produce all the sounds of a language.” ---Jean-Dominique Bauby',
      fullContent: '''
Speech therapy techniques are used to improve communication. These include articulation therapy, language intervention activities, and others depending on the type of speech or language disorder.

\nWHY DO WE NEED SPEECH THERAPY?\n

Speech therapy can address a variety of communication challenges. Here are some common reasons why someone might need speech therapy:

\nArticulation Disorders:** An articulation disorder is the inability to produce certain sounds correctly. A child with this problem might say "thith" instead of "this."
\nFluency Disorders:** A fluency disorder affects the flow, speed, and rhythm of speech. Stuttering and cluttering are examples of fluency disorders.
\nResonance Disorders:** This disorder occurs when a blockage or obstruction in the nasal or oral cavities alters the vibration responsible for voice quality.
\nExpressive Disorders:** People with expressive disorders may have difficulty forming complete sentences or expressing their thoughts clearly.

\nSPEECH THERAPY FOR CHILDREN:\n

Speech therapy for children is tailored to their individual needs, age, and specific disorder. Here are some common practices used:

\nPlay-based Activities:\n Therapists may use play with pictures, books, or objects to stimulate language development.
\nArticulation Therapy:\n This therapy helps children learn to produce sounds correctly.
\nHome Practice:\n Therapists provide instructions and exercises for parents and caregivers to help children practice their speech skills at home.

\nSPEECH THERAPY FOR ADULTS:\n

Speech therapy for adults can address a wider range of communication challenges beyond just articulation. Here are some examples:

\nCognitive Communication:\n This therapy helps adults with problems like memory, problem-solving, and organization improve their communication skills.
\nSocial Communication:\n Therapists can help adults develop strategies for more effective social communication.
\nOral Motor Exercises:\n Exercises to strengthen oral muscles can improve speech clarity and swallowing.

Speech therapy can be a life-changing experience for both children and adults. If you or someone you know is struggling with communication, consider talking to a speech-language pathologist to learn more about how speech therapy can help.
''', // Replace with actual content
      imageUrl: 'images/blog3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 157, 157, 243),
        title: const Text('Blog Page'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: blogPosts.map((post) => _buildBlogPreview(post)).toList(),
        ),
      ),
    );
  }

  Widget _buildBlogPreview(BlogPost post) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 228, 228, 251),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(post.description),
          const SizedBox(height: 0.0),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the full blog post page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullBlogPage(post: post),
                  ),
                );
              },
              child: const Text('Read More >'),
              style: ElevatedButton.styleFrom(
                // foregroundColor: Theme.of(context).primaryColor,  // Uncomment for custom text color
                backgroundColor: Colors.transparent, // Transparent background
                shadowColor: Colors.transparent, // Remove shadow
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullBlogPage extends StatelessWidget {
  final BlogPost post;

  const FullBlogPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(post.description),
            if (post.imageUrl != null)
              Image.asset(
                post.imageUrl!,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text(
              post.fullContent,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
