package com.wdxxl.lucene;

import java.io.IOException;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

public class LuceneDemo {
    public static void main(String[] args) throws IOException {
        LuceneDemo demo = new LuceneDemo();
        demo.index();
        demo.query();
    }

    public void index() throws IOException {
        Analyzer analyzer = new StandardAnalyzer();

        Directory directory = FSDirectory.getDirectory(System.getProperty("user.dir") + "/lib/lucene143/field", true);
        IndexWriter writer = new IndexWriter(directory, analyzer, true);
        Document doc = null;
        for (int i = 0; i < MockDataUtils.LENGTH; i++) {
            doc = new Document();
            doc.add(new Field("id", MockDataUtils.IDS[i], true, true, true));
            doc.add(new Field("email", MockDataUtils.EMAILS[i], true, true, true));
            doc.add(new Field("content", MockDataUtils.CONTENTS[i], true, true, true));
            doc.add(new Field("name", MockDataUtils.NAMES[i], true, true, true));
            writer.addDocument(doc);
        }
        writer.close();
    }

    public void query() throws IOException {
        Directory directory = FSDirectory.getDirectory(System.getProperty("user.dir") + "/lib/lucene143/field", false);
        IndexReader reader = IndexReader.open(directory);
        System.out.println("numDocs: " + reader.numDocs());
        System.out.println("maxDocs: " + reader.maxDoc());
        BooleanQuery query = new BooleanQuery();
        query.add(new TermQuery(new Term("content", "football")), false, false);

        output(new IndexSearcher(reader), query);
        reader.close();
    }

    private void output(IndexSearcher searcher, Query query) throws IOException {
        TopDocs tds = searcher.search(query, null, 10);
        for (ScoreDoc sd : tds.scoreDocs) {
            Document doc = searcher.doc(sd.doc);
            // sd.score 评分有对应的公式：加权值和文档所出现的次数有关
            System.out.println("(" + sd.doc + "-" + sd.score + ")" + "email:" + doc.get("email") + ",name:"
                    + doc.get("name") + ",content:" + doc.get("content"));
        }
    }

}
