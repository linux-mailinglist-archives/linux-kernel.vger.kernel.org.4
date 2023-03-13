Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84466B7571
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCMLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCMLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:11:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE461523;
        Mon, 13 Mar 2023 04:11:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNW0t2008272;
        Mon, 13 Mar 2023 11:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sLC4UuzOmxR6AmfP0OdcdaskgZ3royTr9hU2ZYeBYE4=;
 b=fT+CC722hg4kkA5gEOqAj9XfPTH4j++Un/X9MbzYCrileaR6l2sZNJxRh2sCXwr1VJUn
 KfeLwO7J0jY6AC817O8Amsx1aW1YUNIMGfnPl4R6ATwKnVlsbp52/XIIZ6xwunjHHDnS
 IkLPDhb/tOMQCS3ex8t/nfgMT5IZ+T/2AtxX5K5+tJXe3C7dACI/fb81bInAc5nQxwdy
 uX/W7fVMeiWbCp/BAM0WFJSc5Oq4XVSNotmlRdlDyl/Q3Mv1udvJzgQSLPF2tC22nNVY
 p/N7+7jrzcZueBVGwdXNKAifcouc2fwwedQJ40ca5bSOUE9G7DCm1GcMEdAT5copSku6 rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8ge2uhj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D9FVC0008168;
        Mon, 13 Mar 2023 11:10:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34fm9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/OUOHUXLT+v+6U55RUIm5/7hsRUGEBpb+or1ofnhRTZ/RjAGtbbe0L0B1i2VyIxCFQ9j8VWceEK9/Bb+rHWt+LA5X0/GUBZCsx6/YI/Xefi2Bq4OjtANehTcFd9VLVo6VKCAOvqdN8vQdCwqgW6D17JAaFiNSP9+c/icYrcYCSKu43wgi6zK2hWOMDNM/YqGK79A1Ip0GHYMCQzA4Pfqn3iGu0i6kwWMQambQz9IT55GZEWXde3RrFi+6Flf15ecRT5aDYHdILhZp6QH7LyS0Cab8SmB5YDceUyXh842BUS4Ikc5bkqqbwhDKj8kfMroN3lszIsqRvWSzW+Gvi7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLC4UuzOmxR6AmfP0OdcdaskgZ3royTr9hU2ZYeBYE4=;
 b=nlQuBBChmJN3vc2wPMTWOTYMPIrmOrAoJqoqvTj9eiQNJZAX4zegg7h86plKwp8dFwrJ+FEBITn2/cMHDu0m/S9BwB58TMPVZV5cCXcWPhuf3QloZbe38ME5oMKPCADs5hbWvGVlEBkctX3oqvo7darG16/9ntjpCXumzPZMbkuNjiw28qoyhEqa6DsGC6/C99G9hpPJR1wUEQO+Z41b39SCu2F0FSkLOhOJbvWrJGmHcEFiJYFXU7nY3lOCLSqY2d/JIwVvY7i2Xaj4pYXYlHaQCEQ3D8bEuKYjuSW08WcEd+reEWlPmvn2MQD6zdCMQjRydYIUHBoZWypQPHOL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLC4UuzOmxR6AmfP0OdcdaskgZ3royTr9hU2ZYeBYE4=;
 b=BR9kk23w1TDSJ+3csYfhJZUG5rP5jbo7aTR7xN5i6D791ytRynf0iNueHIfWD1fPRmtdGaiSWpR6yZ6+mxGd615VKeDcX7Ew98RM3dM7FlrKDllu5M5bRRsXoXhJhbo7BOcMmVziY6FeM6Z41ASaEBZXQam/I+4D2L7wy42PcMc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:53 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 7/9] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
Date:   Mon, 13 Mar 2023 11:10:17 +0000
Message-Id: <20230313111019.1521680-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 15439fc5-4b21-49bb-00fc-08db23b39c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aubg+tfMCFh5Z3/9cXLc+MBRYm2h3lYP2Umw5TvA2zFVNJe5VXKWpbSWetsEFDDNsUWGUecYR7+jZ06UMgfGESzVgTlrD+h9CZdzcEAXOAcUUPHUeeowjg6L+96saebc4Lutaatgksx/9Kiv8/WcO5RZ5+YDwnhAnFrkvAObZDK8Y1P5Xb4Avp+OoDxEYA34zpT2Ok7EHmB5k5fJWVmHLJOkf3EOqEWsARB5Pi0IqEdm6QsacPFmr9AkcSmqS977AMYguFtm0sZPMZ1lmGjk2WlnSKer6roBpxaL/tBowziWTieIlDybhTd7jnRaXzOqSZZ5NLPkvyRxU71vc6mJBxOAR5X6cdgEVylRrD/dq/PPpQCEq3ZENLJ8oscj7sQLiVVYXfIYDo6KbLd3CYURYAa6IRRjjN2D4L8jcp5YT47gujGdMFufv70kKQm84+35GPjhX8hP7uZuKfq2We8vLRYvV0f/PKvAkw3x+f8I3XQ25bwgkqSTY1ogrz7tMCsz9K4nRpaBG79XanAwpft4aTdbcEtv7ZYPxsD3/8Ki8hJOC1lP1dZjhtWa4GuxuE25RuM6rWt5sR6YgO8GanyBYR9Uylz2xC1DYi5ccn+d1rIr4xlvigazMhwdq3myjnJLV+iO+fcJeRJ1Tm/5awjQew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?II/XHegazTjzWuPbk/aWE27BVYNt3MFJB9k+bA4B1WH/pr5UOKmkbl2LIjAb?=
 =?us-ascii?Q?8b8udbqpFIcC30HRwHducc10q7rzh08xgthjrAQ9FXqO9cnOCEbqwcxA3Sy0?=
 =?us-ascii?Q?U+mcutrSdCwbCWTACF19e6pR+Vh6Mnimnud9E1uxXkLWkvV0rIVJIAMUQTBN?=
 =?us-ascii?Q?pWZcurAQd0AhxeGfHK2TjfFDdQypXmnB0cSUuBa610vIJPmMl5NTcfQOCblr?=
 =?us-ascii?Q?YpE32CmGHP6NKSsaZfI02FmQonMSO+fMEf2r6qSlt1qHhSxdZBmLcHcZ5OEz?=
 =?us-ascii?Q?hwgF6vUwFx01RDijH65X7nwOKeo2sjaSD/hprBgxxcuTHr57SXAPhwKVJObx?=
 =?us-ascii?Q?qfxhGyFMxFwM9E51aLlWRX70lCo1EbXQB4+7FdNe5g7W3xe/ZtsrP796Pr73?=
 =?us-ascii?Q?vtKGFx3tKtJBpNalHncUn9kAQNVptAPYTsD+59QO0NqaiF8il9JK8ZmJuQLa?=
 =?us-ascii?Q?p8H4Lv/j84fypU63DrI0yhjW4WzpsaAXL7BSzRM126mgXNAF/dH89Wlncg/V?=
 =?us-ascii?Q?ej4gZlm417SocLFooEkNl/SvMl1YWkaO7C/yfW1su9dsfSx3jeTPvP4GbFgX?=
 =?us-ascii?Q?yQklpiyyKRRusveBNJFkxjgKv7JkPctOS8s1aD7iKbTh0c76Q1dfURsnTCSS?=
 =?us-ascii?Q?FUZf+hrCDyrrGnV5TSX/Mf5zpjZNdLcmem8VVInP9k5Am/+Ef9yUVf4xAlWm?=
 =?us-ascii?Q?BI49FRPKJ5vKAEyF8CNkjkZI1gRQ5zr7d+cYv8a7Sv60hpgAL3EcPi189PIT?=
 =?us-ascii?Q?9fI7L/Og+UgxlNty8TPOWxxxIMu8sV1vZnM6p8gBSlkSB+NHJsy+xHccN/lq?=
 =?us-ascii?Q?Xgg5Xym2fBe5Theack94nW5PM0/Hp1X+srKjQVwHoYetIi4IwqE7OCVVVvr2?=
 =?us-ascii?Q?ZJRfvugeujEl9mnuzqKR/QlrBsFVX49cmsENZ5V4+yWrnC81Tv1zdbEIAuxy?=
 =?us-ascii?Q?7oQgcg7DKEzGpz9biVowLuUNO/s+g40Zc4qSbFMn2Idw+zqVHcuA3hKdoTsd?=
 =?us-ascii?Q?HGdUT//DhxTz+TXWUD/hBBdl3bJgiFWTGAuh+8Vxsh+2u0Qgu0BLhUJEpkBI?=
 =?us-ascii?Q?seUihlL0nWOoO6zS29hNl0jhRtjTGcnQWO9croTvjw9eUJeufhikxvjEZb4w?=
 =?us-ascii?Q?vAjeebMLKv8i4fkGIcO9ppiE6XiPiCAItJubhzPsS+4jadW4Qb/j8AmqBQzf?=
 =?us-ascii?Q?mmB9RuyDXmCTS53Qdj7xxQNdeH66gJbFJHR6IihSY6sdt6bQGFx4UBNMQkV6?=
 =?us-ascii?Q?1z9haWiONm1huwm9UmY2CYGdN7ZPsi1eCfxOUQpElhJF2Wqf3+6igSSGGN7M?=
 =?us-ascii?Q?/2lqCe1ELXkpQeznpE2RueyYsitA7Ny7svSNVKKCQQSA+7dgvgKHcp6nEsqn?=
 =?us-ascii?Q?4goM1OiXFM3tRoDweRDTdqmi4E+TTyRPShcleolevaZwRVknJ1uO4rfnzOzl?=
 =?us-ascii?Q?v0yuojhXm0bbgpvUql6ILIyAKUT6qzsJG1Pz9cmVCl6eWrtP+MZQmrBB8u9o?=
 =?us-ascii?Q?i9Q10Ru82CPTowVg0bhFuSQKFSHt8ERvNTPqIq42GxSohR8iHg/PyO/jpfe8?=
 =?us-ascii?Q?iF7M35DyI9oc32mubMHaxEHPWZJdhPHmhMkIOsQRA7hZ4zVSSCVkoL4urgUy?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2nssu87NpWK6dnaIQ9u3q2bjtJnJ7VaDh8c/KbvXTve2PXl5id5ZEkuNJ4gJjB5CwpdIkx9lJvAvq5MCKSeVjWWfPKpemA9hiZ1ZoZvSMUBUrqEw38cMdmKmus7hWOd77kUsjnoOr3D0A+1ivB3SDn9nBxOMiB2OMZu32ijBiUhos+2sIUkzAr/VZOb/W1jBt+zCM2pts6MvWPZ8xuMTaMhhOtpC8EQdzQompYXbMzgvLJ/YlZt14HZMjAWnOeNAcrrSrtRQUH+rAibYwe3Uaz0lT95oCIgoiuUPJXNWeoJS+S+xl41AXCBxUfj8UHwTnN0HM9206OWN05JP76/Dj1x9sC1s85ruakta5gB+a35gxJK9tU2RlxZ8E3ulvQSgYF0OcT01V9evQOhZcXVyzssn6+RcEuDX+h+U6M+cIq7ifTYJvVd43CYcc3hawsZohoQfNqiu9utP1LgqP1ET30rI+pDPRiQ31wGy3E4inGECdYtbFXNPl4Q9248UTH8v22eYAdEWEiURojm8OrmI8VSyKQEtCTUfYZhmlEEwKRuc3gUIaWjL/bvsX/vkdli7g1x+t8DjfoFuT7cXb50FvIaf8wOtN0IiQdtMaHxCG7P/l3TQXp5LeQgxY8wlI4u0jp/47uycUx32/NpMBD05p91gKICFw3qdeDWxoUR5FQqjlUSPE3XMXi72wxi9cjSKCiUa3JcW+OC8eG0ZWHArp87knU3jbtLwUeLPukYPTr3L6+ItmbYTD8T2kGKdAHdx8Jv9Jgk1jzCyD/NU5Jm0e9CUguhKjSCxpwSltqL8ifyfWQe97Um4ChUO7pkrm5lKG2YUUPpJF9d4lNJjBWR7gJIL+sW1EAXPAnvG4REGuFDvzcjpVq0/785ZRaG/29Tsdq7oBaQu+DIHRrXmhikPd+PWYbHaf1ly+NhiY7On5hc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15439fc5-4b21-49bb-00fc-08db23b39c23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:53.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6ozOh8FRcTMqd3qvfGrFuuHon7rliSXZh+lj9nVJ5gEroHAFaaE4ErkmJZohIB6RXOdh/pFn50YxDJeHPpLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130091
X-Proofpoint-GUID: AXiV1dRmGVt5ZcKk87q1Gp28NPSeeLZ_
X-Proofpoint-ORIG-GUID: AXiV1dRmGVt5ZcKk87q1Gp28NPSeeLZ_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating all deferred commands in the submission queue
structures, use blk_mq_tagset_busy_iter(), which is a standard API for
this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 45 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 890241b852ec..cc2da4cc62b5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5324,40 +5324,29 @@ static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
 	return res;
 }
 
+/*
+ * All we can do is set the cmnd as internally aborted and wait for it to
+ * finish. We cannot call scsi_done() as normal completion path may do that.
+ */
+static bool sdebug_stop_cmnd(struct request *rq, void *data)
+{
+	scsi_debug_abort_cmnd(blk_mq_rq_to_pdu(rq));
+
+	return true;
+}
+
 /* Deletes (stops) timers or work queues of all queued commands */
 static void stop_all_queued(void)
 {
-	unsigned long iflags, flags;
-	int j, k;
-	struct sdebug_queue *sqp;
+	struct sdebug_host_info *sdhp;
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
-			if (test_bit(k, sqp->in_use_bm)) {
-				struct sdebug_queued_cmd *sqcp = sqp->qc_arr[k];
-				struct sdebug_scsi_cmd *sdsc;
-				struct scsi_cmnd *scmd;
+	mutex_lock(&sdebug_host_list_mutex);
+	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+		struct Scsi_Host *shost = sdhp->shost;
 
-				if (!sqcp)
-					continue;
-				scmd = sqcp->scmd;
-				if (!scmd)
-					continue;
-				sdsc = scsi_cmd_priv(scmd);
-				spin_lock_irqsave(&sdsc->lock, flags);
-				if (TO_QEUEUED_CMD(scmd) != sqcp) {
-					spin_unlock_irqrestore(&sdsc->lock, flags);
-					continue;
-				}
-				scsi_debug_stop_cmnd(scmd, NULL);
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				sqp->qc_arr[k] = NULL;
-				clear_bit(k, sqp->in_use_bm);
-			}
-		}
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_stop_cmnd, NULL);
 	}
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
-- 
2.35.3

