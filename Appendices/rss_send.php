<?php

//rss.php
$connect = new PDO("mysql:host=localhost;dbname=freshrss", "xxxx", "xxxxxxx");

$query = "select id, freshrss.vendortag(newsfeed) as tags,on2itcontext,
 newsfeed, title,pub_date,link from freshrss.on2it_context;";

$statement = $connect->prepare($query);

$statement->execute();

$result = $statement->fetchAll();

header("Content-Type: text/xml;charset=iso-8859-1");

$base_url = "http://15.236.100.110/p/i/";

echo "<?xml version='1.0' encoding='UTF-8' ?>" . PHP_EOL;
echo "<rss version='2.0'>".PHP_EOL;
echo "<channel>".PHP_EOL;
echo "<title>ON2IT cyber news Feed Title | RSS</title>".PHP_EOL;
echo "<link>".$base_url."rss.php</link>".PHP_EOL;
echo "<description>Cloud RSS</description>".PHP_EOL;
echo "<language>en-us</language>".PHP_EOL;

foreach($result as $row)
{
 $publish_Date = date("D, d M Y H:i:s T", strtotime($row["pub_date"]));

 
 echo "<item xmlns:dc='ns:1'>".PHP_EOL;
 echo "<title>".$row["title"]."</title>".PHP_EOL;
 echo "<link>".$row["link"]."/</link>".PHP_EOL;
 echo "<guid>".md5($row["id"])."</guid>".PHP_EOL;
 echo "<pubDate>".$publish_Date."</pubDate>".PHP_EOL;
 echo "<dc:creator>ON2IT-".$row["on2itcontext"].$row["link"].
"</dc:creator>".PHP_EOL;
 echo "<context>".$row["on2itcontext"]."/</context>".PHP_EOL;
 echo "<description><![CDATA[".substr($row["newsfeed"], 0, 500) ."]]>
</description>".PHP_EOL;
 echo "<tags>".$row["link"]."/</tags>".PHP_EOL;

 echo "<category>PHP tutorial</category>".PHP_EOL;
 echo "</item>".PHP_EOL;
}

echo '</channel>'.PHP_EOL;
echo '</rss>'.PHP_EOL;

?>

