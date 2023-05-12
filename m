Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36FA700EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbjELSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbjELSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:24:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E130F0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:23:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF46E2032414;
        Fri, 12 May 2023 18:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=13GFreuchWmQ+sDqNO0+QXyL2JEdQ/xllgBiPHk5X8s=;
 b=qfbwsdmvMC0FGWu7OUQhwiSilvlV1WzyXYIpy2M+zVZs5l7IO6TOfn562ZwfccegnYQm
 XvD4z7svIVwibkijcE/E5TAtR3UAoYyMzvWrwCiHBT171dtz2PDPY3wYwLMjYnUH/JC8
 GZLHdtR75FgKSBeyAq/jVvhIOQ7bJ3l1YTNSR4LNxB2k86iDPIDlnTJKuRKZzWw3bAgT
 Vd57gkpXdgx7jVNK8d9PVx9k44CeYe3QxOHGEFz3An9uXEa+s2EfQwCz2cImS7yeF+rz
 Xgnt+Swbp860jtsSMwo/Oesw4ctzUyHOM/5x50OgGWml8KPFGzVMWtTSaSXPbyjRth+m /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bm41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH8j5j030909;
        Fri, 12 May 2023 18:22:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81jxgdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZjxQoVghnZTplb+Hpsy0jifY9hjvt4Kmag1ONsBWuMr3f3VtXCP9oHSq28JLDi+O31RY34r9KHN2r9Mv+YzqMYusTs0wFmSmGsQ4QEZAd96wB32WYfkyrrXO8XR6tQycS7zgA1/AJSyRmvD0b0ClMQ8ULVZ8mdklGtXGY3czX2aTy7gTi6uThnkEzDVrL6oRKRGEtBZoBomGemgwtbBemMDy8DftXStesbuZu6eYbiPR3k5/kkTElhixeGu+IOoSqZdK7thQylWaTN0U0pI3MHL0jlRRg9WQynR+NcYQf4RyCBgOpRtFBnK4G5WaXh/2fdXtCCbomhHlwbpyZoRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13GFreuchWmQ+sDqNO0+QXyL2JEdQ/xllgBiPHk5X8s=;
 b=I7A5IGzPC6QY8l+8R8kEI4Re79hnWmXuBRt80Rd+XBHnnNyUVokPD2zGFaVTkkmZcLNGIOp36yn5pE28bHZHDX1pDm4Xi9z02adz4T5VNLBYcf1BS5O+Z+qQ6YX6nERA6jv3MQ0XXNQTbCOhehxm0F73VqxVUSfMupIa5i45bnQHr5L07DtXFEax5EZJxuUoN5N6k15MB1ucWsHwA+sJLO08fI0xSq8TLiRB8XXVVeTZ4o/ad4ups3+4seS5S/e9mHGEtk4LotyGP5Hs7AG+0eEyZQa43V0O/PMwe18BWFxTdtmEXCa3fuuLBv/fZtSheZxJMN+qHyxidrRfcHbGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13GFreuchWmQ+sDqNO0+QXyL2JEdQ/xllgBiPHk5X8s=;
 b=RDfrtIpI3jauhpT7tZ3b7JBDP1XIQyYeSwGq93H7o2UNq8Tt5olrb5CyObQv9Xu8xFFdGLlXHYjGTggGSrPunCOh0aUi3QPoyxNnOfYVb3SbGulzHATT8aGtFvoQFbrnuhq+6nkdU8w8cahlWTv07tYQdnXkLOy7QslkxH+KkiQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:02 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 28/35] maple_tree: Add mas_next_range() and mas_find_range() interfaces
Date:   Fri, 12 May 2023 14:20:29 -0400
Message-Id: <20230512182036.359030-29-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: c40736cb-52f2-4359-4168-08db5315c851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UN+2AWF6lJywoD64bkDjfYZsTsiEbHV5ZvH0QFbVVK60upKhGDYL62aasNpBu8YPKzcnnZDcr8S0L35DTuXGjafW9LcaxuNozG40CjVvWTWlkl4BFqxlVwC8IsKlQ87yQ1a/YGmrxwk3/RfLjRkIlPcOlXf+FURrC+6qYCtxDwXoQmfvq16RM/vDPVQs8sPsWKGurKzm2ssBwtdkgaNq059KgOXkZTRp4jl7lSPW0pVd+WiwIS89A7ztH5rricnUlv325w6lXsmLSxZxIbDpjZBsBVoKXUPdBXYc4GmJWnRjTjdUNyMUGkhlXblj89DvCixcEY4Q8tobLy4doT2mBt37hrzs/fLFhAPGj/kScBXTSXQNKbTxHrj6SZ7usR1bYSpamfg+t/4FyoG8KW6pdFkHYorhQCA0i4hVRUsmpG/lDicI1GiERlnSxfphlGCtL1CpeVWGWybpRfAGi6siRoV6dePjjvVU2OkOYk2YwFKgOqU+mTF/yYZGQE3q/M/cHJQroitP3awuwnLRoh18ej7EJQtj7MP34yZPmUJEEY0lj2yzIOWJ1U4HC+BBMbB4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4AWK/39j9KIS/lCxxntNHTvECputv/NHdjjbN6aXMVixW+SoT15YlSBKmLo?=
 =?us-ascii?Q?Ztx0GtwLqcAgr5ZJYghDESNL4IV88ZA8+DdthCrTrE666ZFHlSv5T+eBEx6Q?=
 =?us-ascii?Q?ANp0xzx9NYCyzreQ6qLoT3KqfWCIyQ7QZXE0vlA6Bqmgsjr83DfJULx4vuou?=
 =?us-ascii?Q?VRG5yu8F6tNG/UAG4mUexCBsTRk0fc/MQgkOUP0yfv8sS2Zswqqk9RUIPEfy?=
 =?us-ascii?Q?BWa0ror3epuSL6npSsTlu4u9K6rnPYbDZu/ZofC4p2ztZsZYhHAuR5083nLV?=
 =?us-ascii?Q?v4ru75Hk7YrMeJ1z/OZOogSyiTmpLRetNuhnJAubdlS9J3Vl+TkpI49gy8BJ?=
 =?us-ascii?Q?EGqiSKFJ1BaB9tWPQc7ZfBvIfONm/y1Ua2d6eM3z4tz6FIQfNKMGMFu1InjQ?=
 =?us-ascii?Q?lLIdawqGhdaRZgqgHUu7SK8dd5jbEHufUZz/9JMWLWILzIYZ/Qfpmpc6dcU7?=
 =?us-ascii?Q?PSiNib90pHSHXj3sJgSrHHPyvWF7QadHwhydH2tfwJjSR1nhQ8ZwgLwRpfUe?=
 =?us-ascii?Q?oNJVbWhFmQy1pSmesaQeshOluWF9HdzvjdErdZULQwYrXQJD7QHoBdz7Il1y?=
 =?us-ascii?Q?v6LEDSYC14GiRfGeleutp+Wz6c8V2+hXVpmtmusiInLYilZpZBfc66oNGMhs?=
 =?us-ascii?Q?I2+SJAI5O/1DCCibnRj3M98NA5Oi95PJj9dDCcgoWOpton5xRR5DPV4MR333?=
 =?us-ascii?Q?LbscrF/959FwdbDB7wW8/L5VSAxUBQYiEyjQiqE8El97hgl2Xq7KvRIVGPUA?=
 =?us-ascii?Q?0EXJivvKzd2QUhq7gZTxzm+q0fcyqgp50Mmhsw9yEXWs7hOPxbgU831dbq3z?=
 =?us-ascii?Q?SBYkXzNifoin9TYfVZ5+Jhok7wu5aShgVR2HpHKbJ/Oaoxu2UeHd6YYMzB2y?=
 =?us-ascii?Q?3eL2DNGey33UPtaxprjuI4KVlc7qDn3X/ZZjW5MornOp4Mi7K+KZ77kBivnX?=
 =?us-ascii?Q?3csT6+QRqHSuTn0iR+iWJIhT3zdefo9ckrJuqRpz5MGdBeQGZOGOsk4lCQXi?=
 =?us-ascii?Q?9p+ocgWw/ABZ14DJpdQqsZPgPuqQTDmerYr39KB+Afz/ouTg9up/aW8krY9G?=
 =?us-ascii?Q?rXiR96eE/BiUYBgM6OiUprWBf8VpXAl+rFfiLU19wUkFPoSgVi7VKGMBGot/?=
 =?us-ascii?Q?foDtAApL0XsPs/ALon2aSXhm96MVNfCPCkBfnIC054rMdJHPVMoMO1iX5lc9?=
 =?us-ascii?Q?qEd8w6YzRFtA3K7c1hiblgd+PfRUx8RV2R8xM6pAakB8f0Lsdd0xXLKsQR8x?=
 =?us-ascii?Q?o8bszrGgq8HZWlztBGfL8XoLhdCP39oJ1r854qNihYSUGH1mpDpRGwKG7tv4?=
 =?us-ascii?Q?7tRqlZTnScXlGyXDcVXSY9c+lgZp2FB+t05iIyURFH6rX62DMpYVrx/1ypCQ?=
 =?us-ascii?Q?irKC5MjGWvCWR2pUsDOqKso/6P4Ir1N4W7VFotQVmeqlGTxaFyXuUp7l1JOD?=
 =?us-ascii?Q?oJATc79dBrzvle+NauoIWCzC6bSoiNjYZDNu43BjbKYmRYieXcctg0uAiIL+?=
 =?us-ascii?Q?QKFs+CHyFiU0NDpeBWYTX0tNOd0a/vR7A8h0qzwYCEw/X6LBJY2MUKzpCGxC?=
 =?us-ascii?Q?zOt0d53aoZJPSP+HJmxc66HbML8D2iM0uSNqRsUk1sygDME1R8Oh0T+Xe6G4?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iENxH6euo7HX5qe/6KLoQfxPgSiF4pVothv7alz+ig6W8OrCQ0re2SdxnH/U+qW+gb2ZI+vQZ/5bvQMir1W+IsQvEr4rpONpWpLOjBh5gk/6hA/ASZJU+L5xSaYCSXM0vDmjENd2PwB5dTYoolmr4/bL5y76NMzblIqeUvy+y6K1tOPU1htUF628eQe13SS558Ic6yF79J/7dUZMwWkMojVCYa8o+h1QFflqKA9wqp+08K//OYoHyoELqKf1JBUk0ATT9/8+KpIrFz4L/bUmdpZCD+wrBxE3VsOxqZbo+bpeIFVvaGGpcimO4h6bacLEm1C0LAKw++sVsCUIw7+Kr1atU8l2/LjgDrYf467el1BfcTp6ydoF1Rdh/pxV8KYViGk2xJoO4yrrNpGRx+b/EdOvOTE3D2u62wSV0Y+vMALNJ6GwFZb97nYDj/yU++zQHDIBKgAPNAfTtGG5/Uowj5wV66BCB+f+baRrNm7JllU3uwBRLIMP6tfSfBtUhbfz03JWtDwVdRQaKVMVlbGCzm+gtncWgThyyG5/0wY2siq+TFFEeTgQpFkqvbRk91eQclJyonL2XmT0sMiLTMp2/QhI/Bz7izJF5DyS3NDesHevR6QsN2UG0/f3bYNgy+c5gz3HEXuG+Xfc10q4+yNkqI3TxHrv61xYRxIlQ/02bp+3ZYWFGji46+k0uSmIdpWPiWAhytpI9U9U3D+Q/A4HfIcc6Bj+ipJFct5TZwk16uA7j11l5pYaWVuGCpV7c4I+XBKGP3bYUM6DJo+Cmf7lJdsVtIA4oFNrGqeSl00Xb87D8v8G/HOt88Z6wrogZrqbeVU0JusLG69lEU22SSZhz9fYgnOdsBWAENiK87afRv6Hi9jQoYAzcOd2bA2wH9Hfp538V4dtcpHzFXfTFUXQGQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40736cb-52f2-4359-4168-08db5315c851
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:02.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXYjMui6/r/L91tvGaYI3zqcUpIIh56UunveqihdzMmfOQ+oLFg5wsy99ddpCHUe7Hv1Eq4KjyXgwb54ZDnAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120153
X-Proofpoint-GUID: _oarWEbw-q986hQ63ZHb4881XKyClYRe
X-Proofpoint-ORIG-GUID: _oarWEbw-q986hQ63ZHb4881XKyClYRe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the next range in the
tree, even if it stores a NULL.  This family of function provides that
functionality by advancing one slot at a time and returning the result,
while mas_contiguous() will iterate over the range and stop on
encountering the first NULL.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  15 ++++
 lib/maple_tree.c           | 172 ++++++++++++++++++++++++++-----------
 2 files changed, 137 insertions(+), 50 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ed92abf4c1fb5..a4cd8f891a090 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -455,6 +455,7 @@ void *mas_erase(struct ma_state *mas);
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
 void mas_store_prealloc(struct ma_state *mas, void *entry);
 void *mas_find(struct ma_state *mas, unsigned long max);
+void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 int mas_preallocate(struct ma_state *mas, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
@@ -467,6 +468,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
 void *mas_next(struct ma_state *mas, unsigned long max);
+void *mas_next_range(struct ma_state *mas, unsigned long max);
 
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
 		   unsigned long size);
@@ -528,6 +530,19 @@ static inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_contiguous() - Iterate over a contiguous range of the maple tree.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__max: maximum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range of the
+ * entry.  The loop will terminate on the first NULL encountered.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_contiguous(__mas, __entry, __max) \
+	while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
 
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 860f82e161661..10b9471a80cdb 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4792,13 +4792,10 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
  */
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
-	void *entry = NULL;
-
 	if (mas->last >= limit)
 		return NULL;
 
-	entry = mas_next_slot(mas, limit, false);
-	return entry;
+	return mas_next_slot(mas, limit, false);
 }
 
 /*
@@ -5885,18 +5882,8 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 }
 EXPORT_SYMBOL_GPL(mas_expected_entries);
 
-/**
- * mas_next() - Get the next entry.
- * @mas: The maple state
- * @max: The maximum index to check.
- *
- * Returns the next entry after @mas->index.
- * Must hold rcu_read_lock or the write lock.
- * Can return the zero entry.
- *
- * Return: The next entry or %NULL
- */
-void *mas_next(struct ma_state *mas, unsigned long max)
+static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
+		void **entry)
 {
 	bool was_none = mas_is_none(mas);
 
@@ -5904,24 +5891,71 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		mas->node = MAS_START;
 
 	if (mas_is_start(mas))
-		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
+		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
 
 	if (mas_is_ptr(mas)) {
+		*entry = NULL;
 		if (was_none && mas->index == 0) {
 			mas->index = mas->last = 0;
-			return mas_root(mas);
+			return true;
 		}
 		mas->index = 1;
 		mas->last = ULONG_MAX;
 		mas->node = MAS_NONE;
-		return NULL;
+		return true;
 	}
 
-	/* Retries on dead nodes handled by mas_next_entry */
-	return mas_next_entry(mas, max);
+	if (mas_is_none(mas))
+		return true;
+	return false;
+}
+
+/**
+ * mas_next() - Get the next entry.
+ * @mas: The maple state
+ * @max: The maximum index to check.
+ *
+ * Returns the next entry after @mas->index.
+ * Must hold rcu_read_lock or the write lock.
+ * Can return the zero entry.
+ *
+ * Return: The next entry or %NULL
+ */
+void *mas_next(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_next_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
+/**
+ * mas_next_range() - Advance the maple state to the next range
+ * @mas: The maple state
+ * @max: The maximum index to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Can return the zero entry.
+ *
+ * Return: The next entry or %NULL
+ */
+void *mas_next_range(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_next_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, true);
+}
+EXPORT_SYMBOL_GPL(mas_next_range);
+
 /**
  * mt_next() - get the next value in the maple tree
  * @mt: The maple tree
@@ -6031,49 +6065,41 @@ void mas_pause(struct ma_state *mas)
 EXPORT_SYMBOL_GPL(mas_pause);
 
 /**
- * mas_find() - On the first call, find the entry at or after mas->index up to
- * %max.  Otherwise, find the entry after mas->index.
+ * mas_find_setup() - Internal function to set up mas_find*().
  * @mas: The maple state
- * @max: The maximum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * @max: The maximum index
+ * @entry: Pointer to the entry
  *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find(struct ma_state *mas, unsigned long max)
+static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (unlikely(mas->last >= max))
-			return NULL;
+			return true;
 
 		mas->index = mas->last;
 		mas->node = MAS_START;
-	}
-
-	if (unlikely(mas_is_paused(mas))) {
+	} else if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->last >= max))
-			return NULL;
+			return true;
 
 		mas->node = MAS_START;
 		mas->index = ++mas->last;
-	}
-
-
-	if (unlikely(mas_is_ptr(mas)))
+	} else if (unlikely(mas_is_ptr(mas)))
 		goto ptr_out_of_range;
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index > max)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 
 	}
 
@@ -6081,23 +6107,69 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		if (unlikely(mas_is_ptr(mas)))
 			goto ptr_out_of_range;
 
-		return NULL;
+		return true;
 	}
 
 	if (mas->index == max)
-		return NULL;
+		return true;
 
-	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return false;
 
 ptr_out_of_range:
 	mas->node = MAS_NONE;
 	mas->index = 1;
 	mas->last = ULONG_MAX;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find() - On the first call, find the entry at or after mas->index up to
+ * %max.  Otherwise, find the entry after mas->index.
+ * @mas: The maple state
+ * @max: The maximum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_find_setup(mas, max, &entry))
+	    return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
+/**
+ * mas_find_range() - On the first call, find the entry at or after
+ * mas->index up to %max.  Otherwise, advance to the next slot mas->index.
+ * @mas: The maple state
+ * @max: The maximum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range(struct ma_state *mas, unsigned long max)
+{
+	void *entry;
+
+	if (mas_find_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, true);
+}
+EXPORT_SYMBOL_GPL(mas_find_range);
+
 /**
  * mas_find_rev: On the first call, find the first non-null entry at or below
  * mas->index down to %min.  Otherwise find the first non-null entry below
-- 
2.39.2

