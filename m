Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261376759F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjATQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjATQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C94E511
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:32 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEC49006224;
        Fri, 20 Jan 2023 16:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=k/Q70txJ0reRPGLL6uPSoCov/RdhMDJIe8k8l2lJ2YU=;
 b=jpXHkS4C8dgi8IOcK5HapN6Rs7PIQziXS4QfnauzN410ARZPON9RbZFd/586rGMXKqec
 upEajEoWREVldLBqrakr/UeTe5lZwlvDv/GxBbIFkqRh0iE60DRx7Gu57nD3LjnMDZwy
 lQCdJtjZXBXRMYp+arIxfcdiModn2Y+m2/1BleUxR8c55C9ExrQCr2kGYLTtnh62AnFA
 tZwUP7cC4LLTjz4B2nrJQFNt1WgZ9DIpC45M/PJySQXpdfix5OrtKlcy2dA/roDDUxlc
 UhjzPEVkBytboJ89DOdsYO+mhy9z557dgXLzHczI1Xc3HtjFdEKnVd8Bh6Nv4I9x0hO0 Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFJX5t018694;
        Fri, 20 Jan 2023 16:28:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quja0dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2jLnCZN/UKzoJ0L5vA9lqXHrrvG3XLI3q0PdeybB/nIJTtJcev4UK7jOJUqDYhotQuW+sdrE4RvzLppO4nixxHroh9s55PTJOOfYiCb3FBlxZGdJHjidPGawHmaUyZP8mYjGsNPdsU5tAT1JUH9NTH77T9huCgw3HRed9HnQPinIqgPn9KLK5G9vqfkplGwDD56nSFStZOVnONripyvMWwCblhPVICol/1FUcl1BIiZZ0rGkxDRh34lVXGygE3Ru1Gud2XXGnjeUTt9Nf7SXy/mReqNVkcjBgPKQYuRbgTxnz871EWhytzajq+iXAiYOjFN2DR4r+cJYnwtZn4uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/Q70txJ0reRPGLL6uPSoCov/RdhMDJIe8k8l2lJ2YU=;
 b=SUHb0ko9isEDQb9n84g0YH4z+MPhCfFL24r1PteTvbTZiU01lX69s8po3nanLdPd9BqhbjWNXH/gKF/cyL4U78XhZe9yKPA9Ue96Mni7OmNE3hJYgJrCB1mjPbBLPus2mO4nP9w+3Y4gl4I3V7zEGBFYEfeN2R1QALPen7PGTnZZjGDKUGM+MkLst5xCdGOIdGcp8Y3YbGg/Byik/fbU4I2g7T0NkcSeHIMoBRj4tQ8NlG+eBgPO0eTi37X9AoiqRHSXUqR8Qd4b86qVtpd/9lyz5hJY6HyH52uoFcnLyqXG2OZp624gaiExcjMnz+R+cm/++emY+qvWKhvMKM1IBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/Q70txJ0reRPGLL6uPSoCov/RdhMDJIe8k8l2lJ2YU=;
 b=wcfN4mxUGl9tzgKo3atQr9EoxgzRctlijhw/Bv/qxNdrbX/4wJ/Z6tJTgQ/qX7/SWiR17+0QITOuIkaz6tVPbKnkcxcoTPHK8wusXLI24aH5uFdHA9aVq4JEQTMlZK7ci9GwSqI4AFR//M+ukGFkRTTh35+LAZk2y6nAGoy3WQw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:28:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:15 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 25/49] mmap: Use vmi version of vma_merge()
Date:   Fri, 20 Jan 2023 11:26:26 -0500
Message-Id: <20230120162650.984577-26-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2f539e-69c8-4f3d-4d44-08dafb03548b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mjd6EED5jLnD5CWZSflImMTnHTKAgNIiTP+QcZpZWv1If5vTiZ1HreYrqB/r+eYkCfIKKxljJ9WOHsoN0pW13QXV0+kYiXggntIr1huVvme4j0C8EyS/wTtEPLc0dk2yTAtusAouSAuwvyyuF/vAtoKXQNzZp06e1qYf1AVLFB5vP9oBS7/zVNtkFPpmbY+yIjwbGWzIr39rxcJgFOSxjagtO2WbHXSsNzjSx7Ouo/Co7ZvoPR59XuPHIEK/d/dgqh7Xkg0m3FJeUjnfINfDd2coUtc/xxWmdpld+JOGPvGyTzHCLyWDbTtH9cvgT2ZqDZkspxRNc8GjrX0ZpnD3QjZagqRUaUHTluqYh2n4fDNsxJ9Md2/peyFaeM2Mi1XYCuxIkOCO9N057Pl13AcgUxkyiSTKTkfR9iQqrDIW7Jn24JgIgc2qzMbqrs23VD9ysIXt5N39U4Yxd1SSkwFTw/ODszo/w/Eqjtwuid4OCqQSsrCpXVJkTlAJ/FP1P1z+qO5wcKXTKn9Qn9IX5gMNH8wZreeMUYg/GlMYfhzYkRIGd8mOxHMQ8OGXnSki/rgJnx/tumW8VDktx2rmNHmDnvwNP3I76xCm0pTFrsaNHgqxjUpOmxIHMHf4DcZQ6Spwyk7gIG/A6dIpmmQ8zU3Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKk2j0Xquta+w1lC0mBNYzL0BHQVoloe9AHVUvLAmIlCADf9pC2dapsExAwQ?=
 =?us-ascii?Q?GnVo+wxy17ChHIlZ2HlGgnNiTlpeYImWoBd46u751Uk29A4yqcfdMhhhRKmU?=
 =?us-ascii?Q?JxtbQU8c3SmDw9byDMfxWi+psnk3oojDTELspAOCTNfn056q4So9nydBjNPq?=
 =?us-ascii?Q?6u0Z4ihVIWnKo3SJmzXzoU1x24bUMu9L7gCh8NcsBJ7VyMCD9FpnhAV0YxZ3?=
 =?us-ascii?Q?MU+ln33RW5MqCBGNej6JOOYA7lQ2v1XCOR0ma3p9liwVexG819yJxP1nnpTS?=
 =?us-ascii?Q?lDOkVtxBcFW7kq/XCUO1i9qiNVc0mgMaQ8A/jr3VxrcYNW/wMi+aVSzNthYF?=
 =?us-ascii?Q?rwKBne5QDDKg+FEPM7GtoTvbCGuym9/3skn3T3OB+hq5QoYbMoHZeuLwDh7a?=
 =?us-ascii?Q?qCZkcOAe3pTHHzS3iSrbA42hhLhWnQoGs+yJnE+K/KeACSve0rAuSbG+98on?=
 =?us-ascii?Q?hmMGQrRQFlH3kt+qz5E427vPGzPJY8uq06j5nYRBkwC1D53nsTonyE7mr/z5?=
 =?us-ascii?Q?Frpo5U3hOelS1STNNaRL5lwxF5MCOQPvznXGLafBLviMrMWfKIM3TVz1Fx8+?=
 =?us-ascii?Q?eMNyjZcRGhT+7W4VMH9RmIYbwclNhiCdQmxQyMyyukaGfLigcssb8TFEV/ln?=
 =?us-ascii?Q?Gbfr7PNvEcmtNFjLFxcBSRWwk0+V/ODR70BHRKMPE1llqQAK5OpCBnAAnqr5?=
 =?us-ascii?Q?vnfev8GqUB954qTPb1+UjqUtfP6SfYwM6f9CqqVy9+ETbYCrliY3G6Ttsol+?=
 =?us-ascii?Q?z6nOd5lGxsc0OltT2TKgK7cdJAYAOz1PQFvRvkANEjK4s7Og3vLtkgoYq+6D?=
 =?us-ascii?Q?/Z/31U9HHmDHIcg0Td1udkIdeJDw9gUsXew0VytkvQi8meiwH/xwWdqFMbAq?=
 =?us-ascii?Q?6xxCgmzD2Gc794Krw+C4D0DOJBHy7VSgWeW3obha89VAIESPiyOAYi69twdZ?=
 =?us-ascii?Q?EFEBeNid4Y5KniA9+gjamEbrC7mYLN2GKAX9dRW1P8WY/UnePybf45Wg6k+c?=
 =?us-ascii?Q?8mU4Oypmju+TqKB80FngJAQjkCfZ1CN2al2XRQHwkgFt559JAaeCXZYdoJ3d?=
 =?us-ascii?Q?8V3hy5d8S6bW0itsINuFHPzdD57gI4YtOsTd1a55awC310sYPnY3OJy+SfVQ?=
 =?us-ascii?Q?eyEnd3DB0furXyr94sa0IGeevZJ/TUOjqHbQEixHcfuzLUr3DkLW/HFp/SQj?=
 =?us-ascii?Q?QhQMHco9xJSLeyjvNhSdGX8luJsWFlxCEmeNWD0ebZvpWTZB0hb7zt9joKnP?=
 =?us-ascii?Q?Ah5xJXJtYU1rpOF4O2wTFqj4k/S1th9zvs8l1mXOb+3OI/xE3I3w26MswAlI?=
 =?us-ascii?Q?4UxsHaCmfB3/cxm51Hx/rnowxofRXKHPz1jk+fQ4p9x2a8hb+yMfhRaoj5cq?=
 =?us-ascii?Q?ZWSQgc829xsKN7QPNe6aZ82piEjwleTHiTLHqn9lRur0xd9ZcKM/881j0kQ0?=
 =?us-ascii?Q?fTJZ/WA5zCuBh1rIBzMPk7Fw2YnPmIjlkyeW5MMpTea3iqDGH1ZrKWevBlY8?=
 =?us-ascii?Q?kMJoIPiSBjx0OLUrt81BHyVrG8+xvUL9meI0FGdgpIUCvKDDxMfWarz8wHpj?=
 =?us-ascii?Q?eVTlDC6QgBXNO1+JCefM54rMhW68iFJoaQqWGoOKzoLCKhUw1DYUka2asm6/?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U7z5blOp+oqd07jL8tzzjmeip+Na1tUkuVQoAJVGZWwkQZ3dHH9TiVIQSceOvpLNmB/96VLgOfq+X3aCEe9mSeq0eORMWa5xJjhx/Hh+o4McaG5tbBnw53fRgNXaF19+lBoQThGZh/C9e0FAsagLSlATsV7AXov21hUna3xkxzWQzLzqK4oYIFkNRkhe27X+MDbO401HhHXKskfOor/rXwLpLU0x5c6Pk/4vrAnGCnD2gyUPibdQaY2tO1JHstrpWfNtrFJcn3xY0tQE3j0i9AplZ67GPv2f7eEqmpgTeJTvXNlE/BdIyd5d1L/8BvarR/8DCoY6fwtUm5YQP0mxXNSNPTvvPGPtPQ4e33V5wOnwzFKAnX/CdTI34DwYETQ1NB8MUpsm7akm5nL2nFrRoPN4iycXUbAUoXR0rS2GUlYoSa0Q3NP4qelXXvBGKM712IenvJXkf+G/+oIPxFnYFoD+5nrOzqszcNwphUfVC9sUjBNbxsQUwVsczBFHrd2Ef2KIorBhLkbuQY627uaf7zq9cxz5mxAqZ96aG4fbUkg4LHqJ+baTXgj5Qdjim1r1F0UR9IltjmcDBcc1Rs2p3do2Ft4HvYV17i0t83Hja61Qf18ZWM4Bj126ChO50BVFUPD1YVDtmThuu4kQI1DV4NWqgnjXqyDBSCYSE8iFQX7/+SL7p0VE+SqnHQ4HnRtNVlBXg+CvkFTC4w4SLMibhuCGzkvjSleZYmUma3iQ8DdVosdvG10vE6nRbtGAuVMVc+bm4g1TdmblU65Byz/Z/iYtTUSwaRtAhHa7DTcs9u/TGCnwtNFRl2bgws7KPQC2DseEN928P1pYn6aZVjyB6i01D5l44DFMrVXCu25j1YvkyuhYhJGn44jCjrXgoDUrqbZCmLIrIF7hUqk06zGyKw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2f539e-69c8-4f3d-4d44-08dafb03548b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:14.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH8Ll97lfv2Cezb39Vd6s3Hnp3qbOzukH3CeYsX9ep9HvzP+LMO/X3rvr/mbbtUuSCkFc0+ph6iped8b/F1Wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: lvXrejjw1BixNOZJqcz-2aBnpFC96KNK
X-Proofpoint-GUID: lvXrejjw1BixNOZJqcz-2aBnpFC96KNK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0de180bb4df0..0696bf9e1085 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2693,8 +2693,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge = vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
+				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
+				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3224,6 +3225,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma = true;
+	VMA_ITERATOR(vmi, mm, addr);
 
 	validate_mm_mt(mm);
 	/*
@@ -3239,7 +3241,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+	new_vma = vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
-- 
2.35.1

