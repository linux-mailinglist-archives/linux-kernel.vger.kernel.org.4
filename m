Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72502708474
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjERO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjERO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8001725
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IoeR006514;
        Thu, 18 May 2023 14:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AhOimAGqg4GYCjDL7HXRxE6yLE8kYlwv7NuKQQsWpnY=;
 b=m53dTDfcFuVO1WHNG2hQG/CI9cHjTnVSdu8D1mnmz/Dt8VXASMhBsMBgcZnlzoXoEYc+
 HthDK1cg6d68enBogNuh3inI+zSp+RLg0xj7GVLPapzI3irYcCbJf7XhwKVBddHW8vPG
 0nTItAuwVTm0K85bvMoHud3N5Yd6NI1h2ZWCQKczPr+qjNf/f1HAfgXqBSjOLK+JgeWT
 HUsMnCq9vLD7oO6YA/ax5jMT6G0grHDvFFtskapsXNGrKRLdRWyLxNrwRZQInEiPb0T1
 1q6vlhmMkLRnxsIFMYzT3BvwcTbSSqcJefVjMNWSzKqzzuejy9FwkYwsg+RdV9LrUXyt Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye82px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE2jRs025047;
        Thu, 18 May 2023 14:56:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106vmg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2mU2vKrYO1S6FzRw3TzNX79e7C91GV8wF82rzbx/TBb1rzjh6QCuYSsq4s72mG/UxBiyyr+blbvV61oilTwM0xsLUwT4Lpn3AhcffL1bmYDfgWzOFQRHjgJTRRqkd4SpukVWYk1hGwBtdQ0OlU65ymykfVjv9eYVbFcHqQyhatG/QW+h53lUw24Nb8NDqMQ9X7LZ6Ggbowo7TUyje05Duep38D1/80lNGyBm9t9Trlfx1OOBWhIWZ3B1PSMiC+t1ZpkLX4n7Wlj195sywfKnF1NA4LoOmhLTwrZh5dHiIy0hBR+HgZOVnsExN3DM69GZcvHcpf2B0ca7SSeFvVo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhOimAGqg4GYCjDL7HXRxE6yLE8kYlwv7NuKQQsWpnY=;
 b=F4J5TWW9Rj38hg8f0rPBziSyLRQcMGri82nNVu98nTwe+rsUlyFhDG2MknL1UL3GDlzTrUZkBtb6gGazLmzs00Vuy2csiARkbvx0TmEWtyLcRO1qNXCeAe9bfRgTKcD+wTlr8MoOZt6vTYH1Z/lsbfalY5bejHWwqcA9/V3SOnzif5ydA0qTJjjebKOKyozE6VRRIlgogpt3mzILCP+yTDCn2XUjREdsomX6sMzzsMvl+X6e0Q9HGoprO+TWh0q3IrYia4KK9Y6VlmQvJ/YtrDYF1slJUaxp6BtsimlS65RMnAXh2kb6PFJ98gDwBfZS8Da2haT4pfUvRI3i7vxW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhOimAGqg4GYCjDL7HXRxE6yLE8kYlwv7NuKQQsWpnY=;
 b=mxwAgGUcGq8xW7mI6X6RgdUlkgioJIYiReOPdMC6vXu9pp9lkQ4xzzrOqGujQPAq2/uMTMp+alZFJZmug1krWuJmqVdhKgSgguti4INDSopiVzGXSX52Cj4wtHeKtW/zWGzLzPlnF76awnZANKUA3OsSBi9tk9vSk2TrazRYNLo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:27 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 16/35] maple_tree: Make test code work without debug enabled
Date:   Thu, 18 May 2023 10:55:25 -0400
Message-Id: <20230518145544.1722059-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0436.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 14db782c-ec00-42ba-c60e-08db57b00e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+gHL4DrrQLrTIY/+aieMrc2bCLNbBzOptUH/dOueNV1/DVaKpLraqyIXdXOHmInJNRvIYD3hOrUXmVt3YYYSFe/ITXhPI8UFnJ3131CmZgDBBaTycRXGLtfrqp7bpd7V0n10WHcRPhjpTcKo2dYH1OCPF28jLU3thxJhoyugOwc+pOvkSVsdu++ZEhEIxuYHxtvAYzH93uQfK9hMwmYTNXcmIBSueG/Q7kfikbcX7FM+KtLfDMTgLLYc0UThFOoU+L0yJ5t9ORpTJO/DR/8yh4qGp7EbpypldF44cdkw8l5REZy5ngCww8zwAHqlr44yZIU1OcJdPRzJDOzHYz9VhViLJ1NDo3M3B1TzrFcs1ZT/IBr2AC0Eq0YOCRUol8dHxxAqEkDd/FNRLd5N2gs5KGM4WruQLwgl33rX6/tWchLzjDSzVwD0b9KZ1/IGoRD2l+Ezyp/bdS5+/oLAWT22tiWnmHPWqh1KwgBLQlCeDqOTHD3/LHmQTyQvFzv5HJYd/ungeOI8GoB9q14SG0UfqAIHkoVpa7p3nRyVLv4Uk+o/HQ6MTbfkOSqZBK7xUyQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jUalHPnhdcefBAdWO6u6FJ+DJWez0/QJ+S5rsWf3azbLL8YFxwmtgWSjO3kk?=
 =?us-ascii?Q?km4eHPMlA42PFZwVpPB4wgELfe2gQnWMYTsTSoYBBKKFVLmJg9VTiNkeuzYg?=
 =?us-ascii?Q?CVdWkp2RxvP9AHPpQDglwm2vic4mGkFYFAxzkRr5oQUyUZs3uuCYizhOPa2+?=
 =?us-ascii?Q?CZHRXFvCmopqqh0d5yozEe4csZef6iA9ZNL5tkvvzAnUju5ZpXQm5lR/BkXW?=
 =?us-ascii?Q?tGf0kT5gLKwvYQ0fMaNNlfymPu4IXoGIBbtyMAM1rLzsZYoFWdN6gx6rKFov?=
 =?us-ascii?Q?nvoj5MlLHybZjdAtViKK0NbJHcsWjPIaOjjadJqtBevFw7oe5ppXa37SDyyW?=
 =?us-ascii?Q?gEf5EJJKYIIIR700+q0ghHZGQs/AoTy/BUySu3He+BVHxS2L/+C+f8Rfo75B?=
 =?us-ascii?Q?7ljlTwmCpVVi5lu5TMfn/jAHMio8sDInfBOId+cPmO4/GcHlymgklMt5xfXh?=
 =?us-ascii?Q?2WZ4RWP7PKXCbrmqi+DwJvdGviGPmyVYL0x/xL3TPdmdDqy2NKjME5YNnmop?=
 =?us-ascii?Q?DP96iyNGUBpd8XkDkIyfE/wNaTGrhSciUE+sVwV0MivJVWfMQt1A0kyM2d29?=
 =?us-ascii?Q?xRZpTMnXh4dxXVgtM1RfcnEkiMJqrN4wrDoIQyV52ua9UY6H6sp8rOvZPLBV?=
 =?us-ascii?Q?kx6EfIgTLwhqUndBT7RyaVLsvpd9wwD9JMlyMteGSjHP7hkahR1ijS0MIBiR?=
 =?us-ascii?Q?ELqdX5UzTwy6Oh5S+xSMvGz/tgUsjun2ec0RO7zALvgH5HYrduT8GDxkOJJM?=
 =?us-ascii?Q?QIED2cCeIFp+ecMuS+1Fzj4yNIPOe7KONeQhIS7Qc8fFLGiZbGQbcwJs2o6z?=
 =?us-ascii?Q?D1bBz4vHinXFJwUWZjKniIa1IDdotdNCY1MHhInn1gGewlP5PCsB6NopZELa?=
 =?us-ascii?Q?D2yeWeJB1EpG8wsVyBtbTQGsyCh2Dqi99cqT00lOFKTZm8FdYZeARauZxb6L?=
 =?us-ascii?Q?LhRdkqQ7Zm8YVmcf82Db6famO/SUPaySo49iKoCG/JhtqaS+Cy7plzQpFeYQ?=
 =?us-ascii?Q?0Dg5AtD3E4J0FuUYBeZDgCm2LZN2WFW88WLKTq1l/JBGpxCk4+5690JghZSd?=
 =?us-ascii?Q?UnDsi4XIFOkfWCIGEFEgMndIpyZAowWDihm4dwnVjo718LMqUwsHqmIIVbQH?=
 =?us-ascii?Q?oeTj+naxtv3bdBYmA4BSGIbKswuxw0LGLg0999RpjH39TrRCPnyORf+EL6M4?=
 =?us-ascii?Q?tkhkd50OCXZgk4bunduju8z1xgn+YXunXezKI3yFg6dQGW0r8KYoQoO02+oc?=
 =?us-ascii?Q?E2242aj85K5BHpOq29qYRMeJS+LxU4Xtra55SK7/Sgnv4jLO6fI9cNhHKmUC?=
 =?us-ascii?Q?sa8Kac91yUxIMUy9UVpA49WdS0nPxiaPoJnMENodsojrxGtrZbZEz10/eRyE?=
 =?us-ascii?Q?CcIoxELrH8fnvj3OTUTgrLcKIIwqrBMUm9i/PIXAQIoeFUnjstvstv8XPtsL?=
 =?us-ascii?Q?bX9MhGDqMRGkEr8ejc43JKfs6btYrH8rjfAKyNhsTGY3HMpevtkWgXr1K6+P?=
 =?us-ascii?Q?yCyNuAnfQ5DN4WI8q//dZzYjxUaJ8GKvMAoezxInbenLxrmj3AG66etxOrvG?=
 =?us-ascii?Q?mGZ575R+MPH3Cns2kLWvemnWW77UISYw3pBUBmaZbNytQpEmVaeK22aiOAt3?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2eibDAgchlskSxe0ANecozq+meaClm3AbBuHZlH5b86+HGOQMfOKn555MVBfvqM/4htMUUcFFEP+gjYFCtoEN5KDQHwz7c1LWZ9y9PIljbN38SciXCUTMUcURcKhPgCxfEB33KsEGFjPmbB/X+WfDloQ9Ja3K6Kes6BQCOrSG8iMoz4ByAffDdywDE1rayScZW/ESRCbDFiKwqqkQESeGwuOQKzazNZEIrQzLJYn1I9Q4KHM5WvGdEQsqWPbGheEcRCj2KFhYNis+7QkGkufCqBZgb8A12hlSScbGazidSlx+Dd0zE2qHa1Zly7Y6G3rMeH5Cb4aa3CNdiLHJHsciDQMMIalG9LkcpxvIclepj9vO3SUkc/AN2C90hgkrNYcAkoiUjs5r6yfkQ+JzISouooVLrHMd43P2A7+ZWi+LQ+a+PFbYWNuqwTzqqLL77UUK0oQTYkG8anvaLAWJeBGTB0lvkoSCaF6WivTc6so2CADWE/ZK7/ugGPfr4N4E7feX+9aaZyLv3UPC0hnsRx6Hm/Gq+Llt6G+seKjrmEqScnDjAuzvG1j/pzJIDnXJq3yFWeS29U9LmGXvLMQ1jkVNJ4JT7wGRXmrXYtFbOyzGafWg8FtexLw/LTpJdla8jAsbYTGgewNHkTEmwPHvER6B9twLoTPIb9wnPwyE4juRLhCFWuMsA6lj0asVK3KF85RmpvX4v3JPmbpFXDI+y3Kbw4Wq7bq6pDvHKHfyDBJnD0ruFQDlYMv5N5lTVQ2Mca1BN5Z+Z5U3c4+6JO4eqQ3Xp9NFl7CAatQ53gvwY45hjjewn7fRVcKm8pH52MJMvud0hbd2gRXEE9aW9YgFjqzY2jr+oBngm+CtlwRe+2Qn+tOU/1/wfC2dB7M86pNrIg3PCUNrEYTTJ8FkiBoy/jeoQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db782c-ec00-42ba-c60e-08db57b00e85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:27.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFcsQE6dm2uDjeAHU1qcXDXJNUpuDSIsSd8U/7sXwxs97b7lQpLfBzMVzhVup2Kv4IoFaR5vG+Zj/qGZf6GigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: 9aFzYIoYy03ERcOjivn3eoHGHrdh-XxE
X-Proofpoint-GUID: 9aFzYIoYy03ERcOjivn3eoHGHrdh-XxE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test code is less useful without debug, but can still do general
validations.  Define mt_dump(), mas_dump() and mas_wr_dump() as a noop
if debug is not enabled and document it in the test module information
that more information can be obtained with another kernel config option.

MT_BUG_ON() will report a failures without tree dumps, and the output
will be less useful.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/Kconfig.debug                | 10 +++++++---
 lib/test_maple_tree.c            | 27 ++++++++++++++++++++++++---
 tools/testing/radix-tree/maple.c |  1 -
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index be272aa2fc0a..17ba96a3c7bf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2293,9 +2293,13 @@ config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
 config TEST_MAPLE_TREE
-	depends on DEBUG_KERNEL
-	select DEBUG_MAPLE_TREE
-	tristate "Test the Maple Tree code at runtime"
+	tristate "Test the Maple Tree code at runtime or module load"
+	help
+	  Enable this option to test the maple tree code functions at boot, or
+	  when the module is loaded. Enable "Debug Maple Trees" will enable
+	  more verbose output on failures.
+
+	  If unsure, say N.
 
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index d6929270dd36..93b40a78c4f5 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -11,12 +11,33 @@
 #include <linux/module.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
-#ifndef CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_DEBUG_MAPLE_TREE
-#endif
 #define CONFIG_MAPLE_SEARCH
 #define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
 
+#ifndef CONFIG_DEBUG_MAPLE_TREE
+#define mt_dump(mt, fmt)		do {} while (0)
+#define mt_validate(mt)			do {} while (0)
+#define mt_cache_shrink()		do {} while (0)
+#define mas_dump(mas)			do {} while (0)
+#define mas_wr_dump(mas)		do {} while (0)
+atomic_t maple_tree_tests_run;
+atomic_t maple_tree_tests_passed;
+#undef MT_BUG_ON
+
+#define MT_BUG_ON(__tree, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+#endif
+
 /* #define BENCH_SLOT_STORE */
 /* #define BENCH_NODE_STORE */
 /* #define BENCH_AWALK */
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index ebcb3faf85ea..cf37ed9ab6c4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -22,7 +22,6 @@
 #define dump_stack()	assert(0)
 
 #include "../../../lib/maple_tree.c"
-#undef CONFIG_DEBUG_MAPLE_TREE
 #include "../../../lib/test_maple_tree.c"
 
 #define RCU_RANGE_COUNT 1000
-- 
2.39.2

