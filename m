Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833FC6C9C98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjC0HoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjC0Hny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB73AA4;
        Mon, 27 Mar 2023 00:43:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7UWOA011911;
        Mon, 27 Mar 2023 07:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8zn4ye5Wdo3UkBGVsStS8b3TMCzSwtohGd97Hs5Iyrg=;
 b=Ur0apetNVtPBjDOhbq5Eh3Tck259udJKGLB5p/aO/IGGo0wFfmdWk5wna3lJ4NySaoDl
 hsNIo8acPxg3FgFNtKeLlWZup2iJPWHMKRXlVt+ggXsKSRlzbvJD/Z1f7l+eo/kXZ1rN
 3mQA2EizVGcnuPzP/JR/z5oI/tKyL3Xr4ScUovKPftwEYldzfQ4RHrr8kpET3MwBGyEC
 1OGVg7kQ//Vez8G2VC1gQdU7N4eSPgskoNYjlp5K/gkZ4oi/QtELkb12AGP0Yq3qvpRS
 h/EOiHoxRzNiBQ1rBGgYxnGaqA19jRx8dLcxbE2BUNzhvRRS40MjgYELKyjQqkQGtdsp SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6t581pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R6XPrI005430;
        Mon, 27 Mar 2023 07:43:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4d59s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=babxMktU13HMKnbbGrnqYidlqe0USx9HBl5Ut+KHkpe6HU43SC99ERMtFmGqhNgeHPViG35d1WOd768fVrI7lgb9/bM3EcAz7IhSAQRnHIz4XaTfDAwOmTv9eyWvkEMyKp5q1ZlnFP5JnJK+VPVgLcxtPMuZpGdKZq+rB4hnZHigc6yOEFi3yWlzcAo1ZZDL2/wWulIdVa65JnudMecMhbcSu2SaXBr7SRyuQ693ADwrh0E6/aOKk+WCQXeaiFNkMxSlkMETXMw09va5WQ9Zusumekt/oh3lOvpj8ibDrN39O6uIlMDrwC7S1QqYx8Y8vaGVuYRT6t129vGHYC204Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zn4ye5Wdo3UkBGVsStS8b3TMCzSwtohGd97Hs5Iyrg=;
 b=k0wI/QvhJXXeQ/h5C4/vPWvcxegtNPHz4rxfr8KgUBspjuIl2LlKdsoX9UToSTLN9iQX7Q8vCVYDzUwICJwzSEGuOMjIJvVmDRx+xpyAVNUt/a3uNk7xVUq6gl3qXGUdoP7Pfru99/aOVuMp/99w4TXGf1U2vrPMMqUDzIuK9yHuQTbtyG7gpHhieqaecpGlBPalTlSb/865qVNPmgTwFvX7J7ThUZjoqiSpg81+Jpf/mibHA+3ltqYdK7Y+urQ91IyUAyKekeC0gS66P0oi5Krz0TF+4tFOHq15Lk/OTlSj6W9mgWAeBeHQWsn32J87+aDyZeb+512nA3/3rsBMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zn4ye5Wdo3UkBGVsStS8b3TMCzSwtohGd97Hs5Iyrg=;
 b=f9q5GWumHvO/dSbjjIqxq07wuyrvsqUSfWTBrReCS0wytjA2261wWDbTcfKwpJBG3ODl8DK2c2mNDybupsPv1cb3+sFu8YIJUZX4TqIWVu1jevFpzHS5+tDLzphctR8HdFw1P9uEwXFMkgs7C9RuGfnorF8/j81rUBf+HeeoC7s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:26 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 05/11] scsi: scsi_debug: Use scsi_block_requests() to block queues
Date:   Mon, 27 Mar 2023 07:43:04 +0000
Message-Id: <20230327074310.1862889-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:5:335::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fe7fd7-2546-4b96-91b0-08db2e96f2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TE5r4OLaRf3yo5D4HI/G+uUSxsl3AGqVE3vGTFupJjJgkFjW7L61oo7NWGyuD7ynWfDORY+IOE63bLIc3XFY2h9u43Fj6frdcVJ1skSEcgHRF/Nlvyzyssdkig6YSpMx80FolZfZKiSw0Sg6X/VFrUUFTuRBudiZml5oUjr7/273rjmuRJsJbGwhUFlbPQlXEDu6X0LYjzGLN7mIl/d6uSOz5GDrerTpwWCSsm8WzOhQNFvXHn+cF5XYd+0osTrg2M5KaCfTHdGkBEaPSMdwLG0z5pW54SvCC5Pl1nX8vJEndrEy+fddB2XZ+cbhAb6MTsNHhxh3zObNSbhyKublE/Vk08+YDBcuu91CRdkAb08wkfnLV0R3utqzcemH4h+4BJHFjtReD9qgOslQHDKUYyUK+j+kL2qI0ZWAbZe1d7zkiHMbmqc+N5Lm4k9Fi00/uQUhoJ08Ums29+Lpq1NYyyQO9WU/9wWwW5iXDR0iYkH6JGJpo10ksw018N9DMuanqLb+iDxCapDTt6SUVF0Y+5VLg9NTxzXRG4w0ehsgxm5OBy+YtMgNdrz/ENTOfoxn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZjNpru6IEcf3ujOmfZ8CFGzQMqKZEotiZ66ZAPwpsHcRxKf+1QWYBBWerlA?=
 =?us-ascii?Q?xj8RVFH4+ER0n5YaRBUS6Qr6OPFt5WP3nSQZddLnhaEAG72BfmbvVhZQLMte?=
 =?us-ascii?Q?6pipDS8CfIJ4oFBD3gn3VCj2+E4US54dQqZfn1XU18FPqda/+HiIoMQhNzH7?=
 =?us-ascii?Q?VaejWiLgfLQ5lGLhFeXiHLflUq0lRrdUZ/t26DLQUxDdtKtuobapk7gt8Zte?=
 =?us-ascii?Q?EJB3ravJada67DNRNsOdG8ZE68MPYDt1tmGfLE4F7QNTsekQu2ERCHAZy+VW?=
 =?us-ascii?Q?pbfyOamE7FLglMerO6jz03nrCnQq6ZvDYDojRjly6elH8+uKzPgTJdBAugV1?=
 =?us-ascii?Q?QXcVlFZwW/qR/ApI8KGNEZLnT4fwTsF6sC4JwZ4AQkwMJJsmgrNyalwvBpzh?=
 =?us-ascii?Q?go72tLNyFZuqnG39bkHOTl9/0fG6LwQLWEWzYahE4FlZBxHQkCdzsper15Nt?=
 =?us-ascii?Q?YTiJZBMoF29MCEB/2Ym13A8LDgHr5ojROkMLILyGHsn3m6fGacBMIIOOaOSe?=
 =?us-ascii?Q?BQ5PxPM2Tgl0a4c8AD8yEguLWaEmb9GrjNGFsYjydDzH3WQ5KV9SulkhihIP?=
 =?us-ascii?Q?6YzRonyLzh/uImrI4uwVId4QPDbYTNLGkF04BiepgYugc/xHh+2P69wtnBxw?=
 =?us-ascii?Q?Som1Ob7AIr1qSJZ8kxgCXPURX5uDLXVQJrZtKLUSIoirMYkli1MhWA0XfLgX?=
 =?us-ascii?Q?1I6yR6MafJ8dJog0dYtW/A+8vvJ/Y7CRJGFud3mLWzNOmr321IMiTq0L1ThA?=
 =?us-ascii?Q?ogCQmbvPtc4J48IBKQg0zfhiE9Ozb1N4i+S81MiSoi1o5BTsoiHmp3y3UX6b?=
 =?us-ascii?Q?rB8ZCkgqn8j3Vx28vlQi85IYuZ1TmuKdugV4Ey2MLEQLdNoT5ycFKRtd+x4T?=
 =?us-ascii?Q?foA5ygaBj5hUyo9Mt64OsXC3WzY/+bZtXqab8egOnXWwGU6s34+AaL0XvRst?=
 =?us-ascii?Q?unubM9uflHrigVm4ctOKXCJv2WRdjnqaD+YmAre8EZs1oKD3fOPlz3fwY1gg?=
 =?us-ascii?Q?0mOpxPHeMWcDhcIqpMxDNm4xkcsP+ZJQIw9mdf6IbL1RZ6bE2vb9EnzgvKK5?=
 =?us-ascii?Q?NuXE0KQRGvCSOBO13xKu+GCumrXLl8LjVXMHpUN2Ha2FzH+JWW9Uh38RYdUO?=
 =?us-ascii?Q?tCGRf1r3hqcynL7+iph5WVfHda0vfR41ogvRY8f6ScMUIAqcaCEFrgKVZhaD?=
 =?us-ascii?Q?WcpjYsWgZuZxKePzsTSJ/90oHCau73aQTAQfVLFZTon6l1uf+/qbI3vZ1VWC?=
 =?us-ascii?Q?ZATfpO5zhH1rvJzBQVxAGc4KdUc7A1jWwgVVb6CNlJuarEMllKc23bis+nwa?=
 =?us-ascii?Q?aLL/44PYR7mJPnsAgVzoZl6PxZZfQK28PojW/BueUGbqW2owLipeoBB3dKh9?=
 =?us-ascii?Q?MIwSlSLOsd6j8YqzzFhEnIb3MjaaAr3be9KVmwD4M9DZyWkz7qOspddqE/C+?=
 =?us-ascii?Q?4QpJGhBSTuiAZwiYIWirTXBEMEVIappgpk+1zYai39at2qO4dToo0JCJ5+xD?=
 =?us-ascii?Q?JsZPpBEPmnfKJ96FMMHUYhND1swZkH9smKNYlasjvemK10I4SlCdHGyrFZbk?=
 =?us-ascii?Q?F4QaxsWob/0pjLNh1tXNw6typdLDYaUuqKh/1hYW4VJmPS0sSXvh9AdfJDGe?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fHTae4/cR1PPHuejW4LbdzviS6E8Y2q7fIzD8DC23jabWOyAvWbwn6WyMbWlZ9Uxfdnw4gUdyTD894QMFHhPRF0RiL+q69KJ8JxylVf/J36y+hMr0X3hAilnfXkH8Zbl6mbO69AYbxkAzzkzz2ihePtLF5XH6tyRJhNnfFFknMVFZyYrxDyRRmCo+xuqiFjTYvAHgOnEsnRFBwuYdpj+fAWA216ttWzg7uexlZDqUkclBq5sevT7bkWYAFm1A0g52eNM8WHDcQwhTohujB1J1UnA7jNzipjR1QkLSALTf04fpuZcNbO/XC1cA+CiitwYv/rxx9s8mPYM95i5Nxy0zPjj/1+Giox6Ki86I8PObeEnEoKCSsezIM7TlAqwMpKlBEliUksGHw9AmchmWuW+w0dcMO/m20TZD8iMO1OONU1+8pDtzFOPmlv+3+MsyBOcpTTMadhiO4PbjoZPV4RaOszq0Qn0mxMgamdDm73dEzzcoZH2f0W58EI1lh8sFemAE1EYNQ5Icg9IWFtu/fZukGM70AZPqOqCEqxUr1nQEivH3DFWxbkMFD9AQUmzwd5IhVaF+abmS90sbUh4kAE9D2xzYV7uUg3i+1X6vVG10h7ZMWRpmoH8kcOJ9oPiFC+F/A+Gv+WxMb+7iAu2z1qQZjSRMDywkmcRbo8EmSo2dzZ1cL0mGc8z1DCDe+357RfakP4mhoomZYhDb9i4qYJ6iIqUaKAcJjCKKaIfFkq+zm2kb7XbnP7CvDu2KhsHftZLqNMcaRCa53PwXxUeP8GOiP3y431EQRZ+voI/xUn8R4or9mMHXW8MkQBWn5v9FumM0ke41zMOeKHy3nTKVyiLXo0OAGvRLLyuHzGzbYRtiOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fe7fd7-2546-4b96-91b0-08db2e96f2f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:26.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpFwnu6byat4Cf58DJRYTUaRwqBYFbseEiCUEREAVheO4zz2vjUita8EDlVk2ZYMk5z+t3vWLlUyURPgqJ46oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Proofpoint-GUID: IFUrKRRrDa18tkTFR9iD9_mr-UCrAvDo
X-Proofpoint-ORIG-GUID: IFUrKRRrDa18tkTFR9iD9_mr-UCrAvDo
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature to block queues is quite dubious, since it races with in-flight
IO. Indeed, it seems unnecessary for block queues for any times we do so.

Anyway, to keep the same behaviour, use standard SCSI API to stop IO being
sent - scsi_{un}block_requests().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index cd05e2f87417..f53f3e78aaa1 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -359,7 +359,6 @@ struct sdebug_queue {
 	struct sdebug_queued_cmd qc_arr[SDEBUG_CANQUEUE];
 	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
 	spinlock_t qc_lock;
-	atomic_t blocked;	/* to temporarily stop more being queued */
 };
 
 static atomic_t sdebug_cmnd_count;   /* number of incoming commands */
@@ -5494,13 +5493,18 @@ static void sdebug_build_parts(unsigned char *ramp, unsigned long store_size)
 
 static void block_unblock_all_queues(bool block)
 {
-	int j;
-	struct sdebug_queue *sqp;
+	struct sdebug_host_info *sdhp;
 
 	lockdep_assert_held(&sdebug_host_list_mutex);
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
-		atomic_set(&sqp->blocked, (int)block);
+	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+		struct Scsi_Host *shost = sdhp->shost;
+
+		if (block)
+			scsi_block_requests(shost);
+		else
+			scsi_unblock_requests(shost);
+	}
 }
 
 /* Adjust (by rounding down) the sdebug_cmnd_count so abs(every_nth)-1
@@ -5572,10 +5576,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 
 	sqp = get_queue(cmnd);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
-	if (unlikely(atomic_read(&sqp->blocked))) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		return SCSI_MLQUEUE_HOST_BUSY;
-	}
 
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
-- 
2.35.3

