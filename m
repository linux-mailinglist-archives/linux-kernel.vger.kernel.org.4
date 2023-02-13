Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C249693B86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBMBAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBMBAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:00:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08ABF76C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:00:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CNK9fg022004;
        Mon, 13 Feb 2023 01:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/Tpxre+PTrq6dVqMOHpZmvVszziOwhc3Sn/xMmECV3g=;
 b=KY/TcqgDFf8nl+0jWLr9bYzI1v7Vvr4PtcjHBDhXy4iGRTQT8Czgu4RXrIDWsoqT3vN8
 k4q9cGdiOJJKW8xEPLnlgxGnz24rqrO4jFwpMoVMVJH2QpGkLYQQrsb3BWVJJEGYjZ8J
 uglFzbPmJKc+kGfLU0JtuGtZ/gn3LOelhQYIwyMLvfdoFoiqzjF/LcKNeQHwACwimcX/
 Y98eDGUAMvyD+pMqvOdJO5ecmhFJsuHi3eC5eGULdpeRxjuWU4GeVTcLWkuWJZNCvowH
 OmwTLjwlQasJU1/LCHABcFnxRXAwXqORtH0gmeN6uFLL5AdDQiceJ4NLHal4Vc17fCpI FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t39pjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CML1rn028861;
        Mon, 13 Feb 2023 01:00:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f374rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSsYN+WjE6yE2MGkUZcuY4VEEXGxXQECO/PdlgOw74bUZicWl7ZwQaa5vBcUf05HZ2Y8l1HqbUHMOK889RtP+dvO6AJPshYTHaWJTIkoklP0xdyAYLbAhHC4jISrXOCs3ebyi2EY904FSAdOK2YruSamFJuHLSx97/xd0qO3FdRGpu3cAjql6cY38mOISUc5H9xLv81zhObndqqTRhaNIUaN+V9t+U6ayJUclIfxMDzBXdQd2bvy2DzL72Bj5rlBFGg0QVekondy5Ua7RbMoFf8G0Rt4VQA2fUrLsqdZJioa75WxaOGzBL7uCV/b+WInEwhM56t8y6Z1KePpxh7DcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tpxre+PTrq6dVqMOHpZmvVszziOwhc3Sn/xMmECV3g=;
 b=SR81/20YNG1jYlEYeuzzYkE4k5LxCFvcM3+qqwkdPX0nj78RruiYbSp/u8/sES5kP6QLgbqktwSSMxjzoeWtZYNwo7Nx5FSK2nIJL/biCxEvvcMbNbRjlkwLy1D/ex2J/ozb0HZA2dnX2meob4w23gMJ2uhCGsB7+tNdTanghV2oxdULw2Wo115ArGGMOV4I+YRdIVAnPKs6ioFUMJWiO5AonnzhtLjr0wDgM+5uVtoUjytKHT7FruU8wPq8Xs/CZPMqFA7BBIckqNOjrlqJXI6y8qEF+LVZWfg3dLPhNWGKrVANy5p2WgHG5GWrjsFGJqn3vKjqce8PYJTkSSqSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tpxre+PTrq6dVqMOHpZmvVszziOwhc3Sn/xMmECV3g=;
 b=tiWAq6SsUvH4OyHHpii2mlaDlpAzGeOpM/LQuYTmNAjB3rrc4pkX40LX9WKz7aAHPLOxv4twycGZwZ4Gbugk8ewfF07yDOTgLxjLaLgLmxmA05Uqs+V95vB3P44Y2eIKmi7bxA1VBZ35HWi62AZNzLM7uCfsDcAY1DbmU7V38gE=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Mon, 13 Feb 2023 01:00:33 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:00:33 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 3/5] io_uring: Convert to use setup_thread_fn callout
Date:   Sun, 12 Feb 2023 19:00:18 -0600
Message-Id: <20230213010020.1813-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213010020.1813-1-michael.christie@oracle.com>
References: <20230213010020.1813-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:806:24::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad58e4d-fb23-40f1-7d71-08db0d5db58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7cWLMeF7aoguAK1AtFbjLWieGaUXhBF6faE1BlGEuyECZTjlurdOntxPviH0D8eOyeDVq8cBrBYGsDCS7Zbz+e/MqTso72be3r6BNLGVWJ22JJXk9rMkWjP52sH/fFqwyErYQmXf7MEMX3jJhD8TQZv0iWe3K4vc/G+yOsjtWPmUHHW8nqJWqpKIrsxcoxLKDf9g/KFVKeDIBZtWsbDCT/4bjjEqg1Um2KCVYQUgI3GExo2NZU3zT0Wf1/mRcfmNW0fjVejwL1I2XcI8ptoUB5yn5DSTDAksyuP/UhT4PixFQ4oAD+9aRWx+4gGVS6EO2svmgszXKPhECX0EGQpN/j+p1F8NQvC8ChKXZhomjIMldzVvKY0+TfyNLevCvRKDlb4XPMElwMUmKE1AMZ2ez+LbqViUEaKNvrITjNBo73gifmzk942UlO0t2sddRH1N8vd8J4pGBNcjH9m6qDS0VRphJcd3WZebkCVEv5HVu4e+//zu3v4TXyf+wH5bGNRfXuUpqPEWNBvArtmpNncRO+sSss6sHJnfqBSTL1CfFZFsMuOj+JL95ZrKtX3JBojhegO/BY6BYdICZFeCQv7iPXsrC31bk5MBlP1jF7k2fAZrBa/7iJ3nWMVaHh+8CPjxcjMNCGGJ1yRgM+a1nkTEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(8936002)(36756003)(2906002)(5660300002)(86362001)(2616005)(83380400001)(4326008)(316002)(107886003)(38100700002)(66556008)(66946007)(66476007)(8676002)(41300700001)(6486002)(478600001)(6666004)(1076003)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRdayw9nelWJdnw8gPSSATlqgyVtC9J1exRbgUt1wP3r1RWlvl4I3fxb64c8?=
 =?us-ascii?Q?Oq0XnOFyMoah1VEru744OSYTJ7T+McWf5Dh3lF0ePQVi573130wlqCyswA2n?=
 =?us-ascii?Q?2l74KDEzGzTeRSSoGzvdZbwtCvOabCqr1uOIKTDGGlpN1bLNF5oLfjykXIm4?=
 =?us-ascii?Q?JwI73Q3j9gib5BHxi19VpHtHqTfrahOWpBr0R8h8NKZodxDIkMimXLoHmPeG?=
 =?us-ascii?Q?VU5GVZfjIzym9+QM1r0ViNPfQyqEoIKlcJtyI/Wm+5M522CCce2lqoYm19vH?=
 =?us-ascii?Q?I18TttWcmcj4UE78XvlLgJL2NtDNTXZJCmB2AWvsFwWl1wuPx8Csk+Q754Ot?=
 =?us-ascii?Q?lduslAef/Q/0YdMQtDM7CCbDi6ycVNJtiQq7HZ4MpS4E8wd95bWBlO3nDhdM?=
 =?us-ascii?Q?AFzyJ9KMYI01z/R6Z2qz+YiMqJb/UyNs7yOS9u12KXw9R8N0G0HQ1LOMpN4h?=
 =?us-ascii?Q?f8+es9TTyhkArtTabHi0aHGfz4cLACvw+ikB1z+IWYJuNqNVZgXz6sJ/Ae94?=
 =?us-ascii?Q?lgwdDjPYKhcpzYmOmkR6U6O9nZpg7WN/oyRCsmOmZZj6nr+bf3/umnsJUbV7?=
 =?us-ascii?Q?9KUyfkBt3zIggu5ULq3u/a10jdgSsqk3pKNbHlRW6G2Ps867XrEWFTfKSfAS?=
 =?us-ascii?Q?LLyNFASa3yfWVWSJPBdc6jC5lzaqo0M+I4g+JsTzS3w/a8tVwAfJ7IT/hjG4?=
 =?us-ascii?Q?iVqNvw5eNX/TLMV+VNx/JzHuN9qYwNJ7koGfjboXVkqiC0D5f0GWwZiq53wB?=
 =?us-ascii?Q?cn2NZkhLkJVoM8r81TTbUa4eb6rp7b7zlHi21f4ew71Qk7NDLU4kmYjAu4TP?=
 =?us-ascii?Q?g3v2UJy08lnFec0iFAFF7gG/LHRemEV9Qek8zITkAAZuuuE+DSff8L2TDiO4?=
 =?us-ascii?Q?YoJptvOpC2E7vIVv99Vfnk8zhj7LwM6UeSSYhcX66yENEHv7PmJswAkyEcgW?=
 =?us-ascii?Q?dbm5NBHo21PwFUbNPSMhxA+vexgWlKrJcBm+bucGbBOhjMH5r67LcNLnyJfj?=
 =?us-ascii?Q?1f4iTTS7vjM5Ze/ahcFaSI7ZSl8+qVk4bc4Qdfi9VIavcnwjqde/Bm06PLtH?=
 =?us-ascii?Q?PLdm18zh/3PgQ08V3+L6TipQAbnG4SKmjPe/i6Q42NNdZGclbCqr1ij+dgJc?=
 =?us-ascii?Q?KmXvtzESgwuEVFjmkUf1m00b2QeodGZ6iSuJCQLntjpC0QSqtu8wK9E+rAjL?=
 =?us-ascii?Q?5IggcgAy5vzO+1q1SHlcmVApbBdmkaI9PPRRzZTos86VFze8DMyVqf7mZq+j?=
 =?us-ascii?Q?zvvbaLCmZzeE6tg3Eympmjw9YbcqUTfuKll9sx2RDrhJOF2RXN+nywzbinWe?=
 =?us-ascii?Q?4jAiHZlrVbXpaVcZDAcy/1yjhM4zBhcnK8qeXF0/6ZXxmTKgUvvVT/NgkpVm?=
 =?us-ascii?Q?rPMKQYTSgf9Zao4i1k3Hj+HVDieif0l2Jc7PQqkwBFrP1YxIuQ26CnNtfqgS?=
 =?us-ascii?Q?Sr26jrLbQJsK71jjteod1dAyx3iCnVIxzsb4ltQC/aVoT1lfKcU8nnMlmQ4E?=
 =?us-ascii?Q?Q/tPmWwq4Gd47VbMeqzFntiat1BNjkoSzkx/vVawAx0dp/5NVUNn9Mo4hnoW?=
 =?us-ascii?Q?nyKKvIVmRG0TOX0Svsri7b/3RQNYsejcl4lks9yMnZV8qMwZm9K6+np3AonN?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9zLUP5YlpUPq+fiLRuQAODeMZM7dcBVB5Q9pGG8G8X7jtz7tG5L5/pH9D4NdFIoMcWVeYwuitqUr0je24hs8gh4P1058jdVWa3GdxO54aJtpeH5ycqReHkiglaHIwKbu070GEVNOd3IK0YCpdlTtLnxFMV2ztFHFdfoJ5hd2EHJnbaQYrz4WWv3DdXH9qWSHQ08xVB+u4gkgOrdXv3P8IdYOcsZ6NfmjBmdP4WrsSwCtSXVvpfpWUtgiQAVpzsaqcY/hTipnGdR8G3sLjj3+FveeBgzJCTc9GZD88aEkRCHFg7q3wNSh7mzoSqi0J2Xih0Mye647IZJPSbJd0KvEVIy6hkluaB4ko05Qywdv1jp0Sv8Mpy0xIW2v46GlKKs5DgeEO9cbA/Mdnp9uGniLTJJ1ut1wl1ONcm0OYMcFRX5zPMQ1WySllRvBZaHtV9aXRCSyUTZL+A6OsWfGRg0YNW4+wC9py3E1MdrcYq0i3kMFHo3N0tFiFwDBJ4+7B5MSIMLaBcfFusHDhGiSFwXtH2x5eSWYNgwt2JG8zUDiBq/D2YVocwlgth8YsakkcYWbnQ+IAooduw24ApFtEUe4vaF4HeBJarUxha1Q5++UOPcwIi/c3G4FVzzswjPQIXmaNIKyDT06332arhy7B1P7KLRBegFzkxpIowrSSBd21u8K3nTZvl8/JiBrhuqlp+1S1CMhblwgPUleMw0c8NFTvUFSHIkOzeiQlrJqh/0RfOiXx2prgfSv+dEG4Bb9ElRGBsV4m406Kicxjqn1erlZQueGwwvketx8rDi8zVrAaWhK7ltVXJzdb1SFsBn1e1fB1Ea9QtzMC12HLkcihssI7DF4MP7uBcD2gb8owU0QlZydWOnd8ijB+vyBDZi+iYjA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad58e4d-fb23-40f1-7d71-08db0d5db58e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 01:00:33.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuZB7SzMb4+srIpoPK5HJoFaL0BT/gKeXYhd4HPXZEAX1dqnyEcoULW/AYHdRHeyKlZ+6dzUvl5I5It3uz/8NYLQ+QjqU/qW7ZerStf0mAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130007
X-Proofpoint-GUID: dK3k9qoANbA3NVhSlHf5BtciUWtzrcAr
X-Proofpoint-ORIG-GUID: dK3k9qoANbA3NVhSlHf5BtciUWtzrcAr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts io_uring to use the setup_thread_fn callout so it can set
the task's name during copy_process. It then doesn't need the temp buffer
and will work like kthread and vhost.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 io_uring/io-wq.c  | 11 +++++++----
 io_uring/sqpoll.c | 13 +++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 455df0c0deb5..4981bfd5581f 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -617,13 +617,9 @@ static int io_wqe_worker(void *data)
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 	bool last_timeout = false;
-	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
-	set_task_comm(current, buf);
-
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		long ret;
 
@@ -739,8 +735,15 @@ static inline bool io_should_retry_thread(long err)
 	}
 }
 
+static int io_wqe_setup_thread(struct task_struct *tsk, void *data)
+{
+	snprintf(tsk->comm, TASK_COMM_LEN, "iou-wrk-%d", tsk->pid);
+	return 0;
+}
+
 static struct kernel_clone_fns io_wqe_clone_fns = {
 	.thread_fn	= io_wqe_worker,
+	.setup_thread_fn = io_wqe_setup_thread,
 };
 
 static void create_worker_cont(struct callback_head *cb)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 8d60b9775798..373067a714dc 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -223,12 +223,8 @@ static int io_sq_thread(void *data)
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
-	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
-	set_task_comm(current, buf);
-
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
@@ -312,8 +308,17 @@ static int io_sq_thread(void *data)
 	do_exit(0);
 }
 
+static int io_sq_setup_thread(struct task_struct *tsk, void *data)
+{
+	struct io_sq_data *sqd = data;
+
+	snprintf(tsk->comm, TASK_COMM_LEN, "iou-sqp-%d", sqd->task_pid);
+	return 0;
+}
+
 static struct kernel_clone_fns io_sq_clone_fns = {
 	.thread_fn	= io_sq_thread,
+	.setup_thread_fn = io_sq_setup_thread,
 };
 
 int io_sqpoll_wait_sq(struct io_ring_ctx *ctx)
-- 
2.25.1

