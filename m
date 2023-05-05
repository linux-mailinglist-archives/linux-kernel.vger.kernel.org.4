Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE006F87E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjEERqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjEERqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:46:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB781C0D7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhOIF028094;
        Fri, 5 May 2023 17:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NfmDzbq7UFamW91OO64jYrReNxQsH1mzQQLxfjxVg/Q=;
 b=ZP8+ZhSJAXbTJdciB+8oJSVgUccLls70CKMsCcOwOsxgAY3QyKSNDAjEcZ6eTYyC2LyS
 ctLnWxVunVm0GZ4WbkBrKU3eD21czEimCXdKDDkWNQqNqaqvBBh/qDAvr9Cn4PZGweU2
 Z1mxZ6LL5M2HGGVwpUOvVkexoT4XQC3//u4bSRPQCjitRvoOE5q43cP1L9gfIBVmRFcr
 5CuGDIC/2P/5u+FqjHAB97sl8kT/gZZmojEXdOc1TMYvtMl2rh9Rqq/Tge3pUDOjYQLZ
 qWfYUA2R82tFrkSUgEravMH7UGndj6hIVUZIpzjQs1uuUqZLlY9kMVHQ1U8WQQQa1fFM 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345He9fo024982;
        Fri, 5 May 2023 17:44:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacjk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLNKJgCTcHin+uAAMeAyagptF3y8OP+ZMz6rNlr91HauKRZHtDB8F8IdeWPwoCFUEu4bcefBOhCmZqMWiBb9UVAt00zbNKf8sPngkySC76EB9JOvByDR4sIhAkKMFgPwIotGGhvDaqPvCxW6KCO6Aeo/FS0WUgIltTmxrjWhBBrg51qaGIdGwesoj2e7JnQGOWSg2oSoNfISG/JnsM8urau4iT77s/BiQ8oFQWwyO7o90/5ULVFsT2r6TDr0Iw0XsqRtgEZIdlRoPQf8POZ232L5GQ+FOYPBUlAGjSlp9ll8U+giNsqKlUppQPdIsuJWTmEo7afjtr8yrZB1W7OP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfmDzbq7UFamW91OO64jYrReNxQsH1mzQQLxfjxVg/Q=;
 b=DmckErDdwWXhvyo+ZC2o/RGlKDxyp7yOzd7O5f/EorXyHjmt+fedV7rex0aCwYaTV3q+ovH2DOvaQJTrR6lgbvtg2Qr+t0U9lzxFf/L4iAhtbGWuep/OTQSgNwaCFfK0BHUaeiVUmPA251rR0QLa0ViA5I+5HEOikg4ffSktlBXBw08Oz2xsKAuW59dAFLJkPJ5JdHAKpzWlEzqiFbxwD9mK+H+noHzT1T4ATss8ikKy4lJESDU/lNyDSna8vIq9NGxB8fp3wFFqBcpNMEu9+VAUi3/L+OMoh/U3nPMasExCZF559UvBcRv1tyCMlselH9/g/oerVQTHVTVV9KqjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfmDzbq7UFamW91OO64jYrReNxQsH1mzQQLxfjxVg/Q=;
 b=Xg6L1qf+tAA2pC7xfDExii3mxlVixd2II//7ApiDYlOIk4As4vidkhgYIJj6VgzPnmOHL3NlelflBoQyg93J1S/MXmkGfYWYRVA9tGjW7qPA4usghinCVLXVvujpWjNQDJWAbDFAuXjk3vbbGY+UysmuDz3SY1UBh5YZtoBFOtU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:39 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 24/36] maple_tree: Try harder to keep active node with mas_prev()
Date:   Fri,  5 May 2023 13:41:52 -0400
Message-Id: <20230505174204.2665599-25-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: e98f8859-a07e-4207-fc95-08db4d90668f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AllDO3Cf6kwbtN/LGAbo5DFcbXYwpLuUXxNaohMvXWyFhdQ7P0g4zl6O9Cw3d5Q4CxT7OZLkuyd5p3xh6YBO2LS8sl5dxszlg0BcRfEGFKBvsSing8YXvsndGC2/XQoX1cZVQC5vTK684Xqz55eHG9TBZv46kgaytHvobbLxGq5y1n5kTZToH11Go+ttDOX3ZV0n2FNLb+5B6rca0l5e+lLQ19lMY1S1ptStbLhyIYMimpS3Z9WWbHyqCvzokHBGHiY+/tX//lEK1FGnGjdTpqXK+VVUinfPzq+NoVMKk4moXQvDldULQ7oFfldA0bQo0NgcKtoxbXJqT05TFKNqW5UAWuZbXuTRNj67k2kFAikOw419Udzk3LE5+jiD+rf599mn/1YC00Il2Vi78q5jbme2GFtLn2SLMwvIyHclM64Gt3nFfEsQs9aXUM8C2Was/sR9JpWSIYRDvZOKKP/DkndkgpUcDa5JIuGggsH25aKFQgmABCUIrlnvACyY4disT7uibkzxjICEzuIQ2IDenv8fO9TVm58Jkjm70VvNq5bKgdFmZt8wecmD8wWyU/45J3lirMxxcrCOnJfLAz9AuciuaALowEVjWZqZqiqSwI3fr0BpTOAnf+toTg5Z5ikvI8Bf8PPUiMIkKU/4w0ZHLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yK7d1lFEF9R14JuPmOJrDxPAhvd4RFmtDC8p5NuzTOHuaSPb2w9mxPAkyVWK?=
 =?us-ascii?Q?bJhPMtkMavarFr9QHJOzWFwc7sm8W1TJJxXKo/P2qNyanP/EEJQf8Wuv0ajF?=
 =?us-ascii?Q?2mudcXxzF1b+wYFtBbDOQSmz4WU+ifj9CWR1/1N1FKjjjbQAZ2/G0gUpnfSS?=
 =?us-ascii?Q?iBl6IXLXwrIMuGbH79JCbMB5KwYT+9cfeCGVXunspEqe4Cjc/yAVEl1av+h7?=
 =?us-ascii?Q?mzcMrN4ULrYTZJ3QzKrJQs6qlGUwweOPEyzMEjJqG3NzF8wmBcy3Do+0j9hl?=
 =?us-ascii?Q?TmgenS3RHLrjlEEbHH4W4Lrvfnd9Ah2MJidimdY4ghkGuZzJnU1sVj6X/zn2?=
 =?us-ascii?Q?h5+a92wBLG39RYqEmBtz83R0t4M5OnIkhzQ405cjRA4DS8aCEJUuIpNNgJsg?=
 =?us-ascii?Q?covmlteCOFdoUuo4uMOLHlPWxkDsGwWGSbtEt0xzv+rnN53HJyVD/5BqxjKs?=
 =?us-ascii?Q?FGIF9LWvbUz+/viHj+GrEqjD3yeviY7uv4CWHaE8adQKzG/jRXST5tNLDEXn?=
 =?us-ascii?Q?LzrTJOIWKL5qUcR40ArmbjQMi+3EkW3khSCYnG68NaWscH32G0P3Uqwxh4ZE?=
 =?us-ascii?Q?It8hU2vEQ6yen1mGgwIX1+cAD7g1fFTZFTsNr13PPPbaTVZlU6aZ15QtkDte?=
 =?us-ascii?Q?amgc4NJPpESPU/4gGuGJZs3wkiAAXw8iIY5z28/hQ8XkfsS5jjkFNyUqz3MY?=
 =?us-ascii?Q?wDIVGyTJx2+hISrBO2OWGgEu07irT08Le8JUq8lS2Cu5JkK5SsK4ld/o5Lum?=
 =?us-ascii?Q?s+KQbIjRJ7Ze8qF0BKgLgLO2UNA5VA7SwFNhPYGJy/M2XQBV/VHOAr7QAkZH?=
 =?us-ascii?Q?HZ6UbvvcdFrZU/DdfO3Ow0GrsVmc8Yhf/bero/LlIJeX6Wzx/SHsFGnS534W?=
 =?us-ascii?Q?t+cv35F0HrF0WYke0iYxBPDATNjHVBcAHRFAx8/gBt3HyEdWVs5gQQ2KKfd+?=
 =?us-ascii?Q?asDdTjdvnCibjzdtPkvzyvd9/QgeThvzb6Czde9WttRLBK1zr+6N+uOZsDoA?=
 =?us-ascii?Q?mAlY7/m065KbLQjYTeZJ0aHhOPj0OPg4cioy2sBRLc3p4LsnMBeVSLktNoth?=
 =?us-ascii?Q?BzFJzym1qi3KTYxtj23yjRzO6NAawxwWA7TLdeK33EF1skgBqct25ey8+zWQ?=
 =?us-ascii?Q?DITMArz1J5zCfgNf0hg56Hkn5SsgVnRtJp7wLcL8oUhqotRAxzZdbesCjY0X?=
 =?us-ascii?Q?Kn0+ijhvel8oLk043vDpNQQXRlTcUyeMWfjuRHAYUAe3D4osyvPFoLTplkmY?=
 =?us-ascii?Q?xaE3HFzca944zmYRCvkLUJH1LLR46E4cHhHks94gSdkLHrEAUGCKMfPUSukW?=
 =?us-ascii?Q?s0eZ9qwo35++HBIdiARbztK2tfSHDNXCtFcRoXCSJJHs0QraEYgzhKjrjF6s?=
 =?us-ascii?Q?nVxvurpO++ttG8RqTg5WplFiATcL16gfkd5MeJBPGMHk4iQ0WFNughrRfkO+?=
 =?us-ascii?Q?ZYCPAmuc9AFbeT+I3rseRc1HCfI8Bb7+xeDChIuiUmyNWizxUwn6FHPMuF02?=
 =?us-ascii?Q?KNITFsvGdv45qy7poSHS4vD2NcguGtgN/OmKcRrzut9zO+BRY1WUxoSbja9M?=
 =?us-ascii?Q?mhRh7a45/g3SkjSlIpJbtyfW2anCr4Rl18zV5YlnsN6aSFed7cjejA56yA/7?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IXRZvY0lbodhmE4puQHLlfl9NS99gmPuKLnzMAQ4TLGCXkl8xF2mDJOUJdjUHu1oCsvPUwNMNOarU/wQov9wLCgxGfhEdGZIOK8KeOfLGwjHOHvF6O8zdOjmss0MSf6+ua5/MMlLOph/Bit19d682xwBYCiA8dJZyRO0F6LSE6HaGa39dCB2YS9xaHs/xzPvb0bIa0QofUkAgKJAyF4wAO7WIJAxsfmZrc1Xl6jPFN0rROUOuTDzO9JLX4y3cqbwjK4SI9o/ulKTjSgbwEP4EFynLioIbzPXqRIZXZYTTZkSGnInkifgRWNjCZGuma+fDikLN5vDZDjYxPNeCnQfth7KBijcqV6Vm/UBpaJEOMkHpcqsrOBvR4rCDhE4ZQ2chs4CVqjJSmCIqop7Q+GXOJC1HEDYn5WAbnsGKXEP+lOqJMFH5TWLDUVJ4jqoxA2g3sx/KhXr53iuAQV8E8EJf+E5mymR8q8qhN0+t2yxzJMqPqAL8mvIMlWS9O8Sx2uJbTMEFEGqNa8lBzJ3cZHyESqhLg15IouYDxK5iubk3gHaoudJIWiFX0TCvjAee/ArMbb+uAO2mTF82pCQXUc3uB0EZa9d9SgqevfIUui9w1bUejyMzIYqywBw3NQ/YNl5jth7F2udrKjViK8oXeoDex3wYT2lD9dR0JPd6f95aK9GcbIF+PO+JNLjh+VrRG7i/oFqK2Rre+HDICSF3joc4gzYk4yw9lHPR7jI0/FZC0qBtXOMiJJ2wDCQ0GcN02pCKuBSov26pPgfoddTv4j48P6+PTBbDcP4OppgBQkeDmt1NEHgAYkfen55bcpDh7c6WRzQj/188Pb0J1X8VrVdSrrcNZxa0SaQWfIQrAVIBnfHp+5l2faK7XCnVHiky2ZdhnETJUT/rmylHxL55jWj9g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98f8859-a07e-4207-fc95-08db4d90668f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:39.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33TBx5Ni2UX6cQzCreNTfO524nPkl8K5m7RDzFKVqSQbpOOw2+h20IG7nIzKcJB1BTND7+hQadZKu+OXOQ5mOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: GT13RXUlT69iASCxQKMF734_Hxs1eGIU
X-Proofpoint-ORIG-GUID: GT13RXUlT69iASCxQKMF734_Hxs1eGIU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep a reference to the node when possible with mas_prev().  This will
avoid re-walking the tree.  In keeping a reference to the node, keep the
last/index accurate to the range being referenced.  This means the limit
may be within the range, but the range may extend outside of the limit.

Also fix the single entry tree to respect the range (of 0), or set the
node to MAS_NONE in the case of shifting beyond 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 125 +++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 09142af082148..425ad922bb2d6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4827,7 +4827,7 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 				    unsigned long index)
 {
 	unsigned long pivot, min;
-	unsigned char offset;
+	unsigned char offset, count;
 	struct maple_node *mn;
 	enum maple_type mt;
 	unsigned long *pivots;
@@ -4841,29 +4841,42 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	mn = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
+	count = ma_data_end(mn, mt, pivots, mas->max);
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	if (offset == mt_pivots[mt])
+	offset = mas->offset - 1;
+	if (offset >= mt_slots[mt])
+		offset = mt_slots[mt] - 1;
+
+	if (offset >= count) {
 		pivot = mas->max;
-	else
+		offset = count;
+	} else {
 		pivot = pivots[offset];
+	}
 
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	while (offset && ((!mas_slot(mas, slots, offset) && pivot >= limit) ||
-	       !pivot))
+	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
+		if (pivot >= limit)
+			break;
+	}
+
+	/*
+	 * If the slot was null but we've shifted outside the limits, then set
+	 * the range to the last NULL.
+	 */
+	if (unlikely((pivot < limit) && (offset < mas->offset)))
+		pivot = pivots[++offset];
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
@@ -4872,32 +4885,33 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		goto retry;
 	}
 
-	if (likely(entry)) {
-		mas->offset = offset;
-		mas->last = pivot;
-		mas->index = min;
-	}
+	mas->offset = offset;
+	mas->last = pivot;
+	mas->index = min;
 	return entry;
 }
 
 static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 {
 	void *entry;
+	struct maple_enode *prev_enode;
+	unsigned char prev_offset;
 
-	if (mas->index < min) {
-		mas->index = mas->last = min;
-		mas->node = MAS_NONE;
+	if (mas->index < min)
 		return NULL;
-	}
+
 retry:
+	prev_enode = mas->node;
+	prev_offset = mas->offset;
 	while (likely(!mas_is_none(mas))) {
 		entry = mas_prev_nentry(mas, min, mas->index);
-		if (unlikely(mas->last < min))
-			goto not_found;
 
 		if (likely(entry))
 			return entry;
 
+		if (unlikely(mas->index <= min))
+			return NULL;
+
 		if (unlikely(mas_prev_node(mas, min))) {
 			mas_rewalk(mas, mas->index);
 			goto retry;
@@ -4906,9 +4920,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 		mas->offset++;
 	}
 
-	mas->offset--;
-not_found:
-	mas->index = mas->last = min;
+	mas->node = prev_enode;
+	mas->offset = prev_offset;
 	return NULL;
 }
 
@@ -5957,15 +5970,8 @@ EXPORT_SYMBOL_GPL(mt_next);
  */
 void *mas_prev(struct ma_state *mas, unsigned long min)
 {
-	if (!mas->index) {
-		/* Nothing comes before 0 */
-		mas->last = 0;
-		mas->node = MAS_NONE;
-		return NULL;
-	}
-
-	if (unlikely(mas_is_ptr(mas)))
-		return NULL;
+	if (mas->index <= min)
+		goto none;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
@@ -5973,19 +5979,30 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_is_start(mas)) {
 		mas_walk(mas);
 		if (!mas->index)
-			return NULL;
+			goto none;
 	}
 
-	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->last = 0;
-			return NULL;
-		}
-
+	if (unlikely(mas_is_ptr(mas))) {
+		if (!mas->index)
+			goto none;
 		mas->index = mas->last = 0;
-		return mas_root_locked(mas);
+		return mas_root(mas);
+	}
+
+	if (mas_is_none(mas)) {
+		if (mas->index) {
+			/* Walked to out-of-range pointer? */
+			mas->index = mas->last = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+		return NULL;
 	}
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -6111,8 +6128,16 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
+		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return NULL;
 		}
@@ -6132,14 +6157,30 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			return entry;
 	}
 
-	if (unlikely(!mas_searchable(mas)))
-		return NULL;
+	if (unlikely(!mas_searchable(mas))) {
+		if (mas_is_ptr(mas))
+			goto none;
+
+		if (mas_is_none(mas)) {
+			/*
+			 * Walked to the location, and there was nothing so the
+			 * previous location is 0.
+			 */
+			mas->last = mas->index = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+	}
 
 	if (mas->index < min)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_prev_entry */
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
-- 
2.39.2

