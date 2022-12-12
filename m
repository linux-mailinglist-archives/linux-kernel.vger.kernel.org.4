Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3764ABCD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiLLXv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiLLXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:51:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F42DD0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:51:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwohc029986;
        Mon, 12 Dec 2022 23:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=biOqnAf8u9QpTsKfc12CDhDuHfniThUky2Q/bg777/Q=;
 b=nFIg3U2unl/lzhfcMHpM6Z3JBMKSo3XkdNCaWDcCn4szXGa9PT+fJgk3sGs9iacCxI6j
 xhD+rt1tg/XOJnl78WLU7w5QMS+/n0wkz1D3b3JuJslZxwHeR2CzxNWer2UBXJ6ap0sI
 c1hLXIRcrX/uwptOkao6bbfTHQrjIG/neXiVS6rIy1EAUmpV4YDzO07SuCzK/LK6aVJz
 4oCGM7mWQr68Pyc6gQ6lfw30MEylnReau2gHut+Fj22UQcgT4FdR/M242+XOTNHRGXko
 jlOhJc5wcP054Vk/ybiwvRpiwXYNBSVI+YrrdI2CUoAphstnQdv9KvG24JYNXVJkzJMB zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj0944s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 23:50:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCMcYWK018645;
        Mon, 12 Dec 2022 23:50:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjbc4u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 23:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWCEdT6HyA/5UjRNaGxtK5wHvSsboZe+JEu03dSjog4zcynzbcpEi26YWelXFVH0d1RA5g3ytiybw5xAYOpzV4if4MKX3nViy82fzQFPNxCY4a5a8tK/lgOfC+pxD/H+aMwARGIrqy0sGTy2PTIf1Gcg+yYEErUcYQDxdAXkQnNlSGvFwA6RglJp9FdrAPv3JXdhidf9pKlUJ7ngDbyoyKKDohJ2WLHLXxFsu3KVjWdw+QW9MBjXnMdY7pb+xRUffCYDRiCG7ObFxSlO0whQSdm9VONIOeuso/Ar+cbP0XCC+3XarjAz6sgJnihoGhluE72gTYUnp7WtZ9jAJlDlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biOqnAf8u9QpTsKfc12CDhDuHfniThUky2Q/bg777/Q=;
 b=N9RBN9mVMStaGXoLuH6/gAuXR5H+BXq4M2l30AOCQ+Pvt/kUeny+bQ9etPyI0ErBfU6YcxH2YTsDsQI3SXzSEyNfIwlTBE8OG1hUX1UHlnEWro3NlLeX5jooN6+A9sMyTaei2DH1MytJdEqphRo/nogTvPKH17xOhPtMXupGJAo2J4VhV6KS30vH5grvrlduzDFhEMRsy9b3H+fk2CIKCzWxG4UfyWHappyy2miKds9DsYyqWnputOQKljMjuMapyebZNefDTqeHdRWulsbZzo/w4laTEnvwujcpYUc5+N/B+LlxFMS7zOJyIAY7hObSK/kwlqMFJKX9oU7zrJ9XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biOqnAf8u9QpTsKfc12CDhDuHfniThUky2Q/bg777/Q=;
 b=w89JpxMBSyd20h2TAN+G2x16sIvlDETi/dgeJao11VOkmf2d5IrAdZ47MqphWVCfB5VNcHWENScWy3/J3gEgMIIgDwKq1EhiZquIpuX/vZ0oS2wJMpYPkb3OsKBQzhxumP9+XtITp/WZPpf3jRO5qRRk8YU0qwsU6++48GytwPk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 23:50:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 23:50:53 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlb: update vma flag check for hugetlb vma lock
Date:   Mon, 12 Dec 2022 15:50:42 -0800
Message-Id: <20221212235042.178355-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212235042.178355-1-mike.kravetz@oracle.com>
References: <20221212235042.178355-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cedd2ee-c82b-410a-bbc4-08dadc9bb433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5Xi1mk6Uc72myMH+IyMdhZHL83xilDtSjkd4IdhAdtgS1QfpUm11DJrZgQ2Ig1EvuyddQTSh6tj/PH9qM760FcXU8g8ZKJKd5KXfwGZy+pTNI6v/nnN6CTuwsasNU5K9ZhL0tNI00UDZTVf8pm1ydLPUntdWJrHhymeWOdZy74a1Rn1AN1ojFUkSOBHPd6vi/BKYhimhT5QCComiMNalRG6O15Oc/iZYT5TUjhnSHGwErTosCzazWzfbqM28U/M/G1b2ut7EFpp40Gah6Htnt0lj5X1YX3fnoKWw2Nm5zeBV9boxw4vsonN927/uRlKGvcukwtpqxOZeckS5sC4kmUX8k7zyNdDx0g54HbXzHfRwJz0NBcwYYJlC87GhJdO6Qr0uAkgBbPiwKWphr9I9yUgb2VjClKNkfMT7gdWEMVeVlIZci9G0EsexyfMfUKIfY054Up9nIjOaA/oD3SLpzr9Dk2il036z+ncYGbSB/LTBnxMI/wXDYZFYf0uWWgm4qmeJm9IrEeNxrFOVfum7FVjVo1HYOV2LgpPxeS3bYA5CbRPqsd6tD0svCeOuh+MBpGJKZ7wxv+l4R4xNwkrSapqV3/fs0euKWLRfof1EfhTqVLtlnAdpYuxC3b+pSG9KI8JLAWdJMfpq2x0GwieaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(6486002)(478600001)(6666004)(107886003)(2906002)(6506007)(86362001)(36756003)(44832011)(8936002)(26005)(186003)(2616005)(1076003)(38100700002)(6512007)(7416002)(4326008)(83380400001)(41300700001)(5660300002)(54906003)(8676002)(66556008)(66946007)(66476007)(4744005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EmJBN/e8cIhToFlsATEaCUaCA7DQbQLAWrGk+HQ/B3pfVhF73uzjAyNO+AuZ?=
 =?us-ascii?Q?Kf5HU3rxPl1JRxyEsHrktmTM7DcuDThp+Yxpvt9ebftu5yc0PP1DEACUjo4I?=
 =?us-ascii?Q?KYvtUk8r/eWMMdhqAp/plZ5PPVUoiFIFnzbMxsnS9e4TOpe2S9ETY8d81BWD?=
 =?us-ascii?Q?C5TvwPomzLhK43RIkG05WF4WRErNZcKKu/yoKGtpJrhMpTroedkXQLWo0+9g?=
 =?us-ascii?Q?bwrqGYr3C047gMUB6fLl3T7uiMwBHeodUBcypwpREPDqsy/nE0X5jG/+V9Nl?=
 =?us-ascii?Q?9tDje80uvuVe44aI0kzrbBDQKqFHnfehGNzcgvQV1U8AX8HbyQxaXRPHIhwJ?=
 =?us-ascii?Q?augGRBrIM2bYHRbzMxOZmZBp+JnbT0lvAFMabnxCpF3/eTME4zv51EbTyMNS?=
 =?us-ascii?Q?se0DgTgvyz94LXFLFVeeAZYtxvE40cbDpOy/hbA2nxMwcV5n9UOfOgdEdL5c?=
 =?us-ascii?Q?cAOH8S4ATdN8AP026ESOOKOd9oI0PFla+M4Jkgo2PqUTRYW6bsazevFrhHR3?=
 =?us-ascii?Q?rsBwBQNF8+Vk7OEw8RpURYIPw0QuKRtu9ncwJ3dQRydBtWmLc9/Gg3r1Pd2q?=
 =?us-ascii?Q?QGbK+nJHDsIVBPYyPVYNEJqCIfOEC37UpWYeAh/I+fEIYgvMJphp847vof1N?=
 =?us-ascii?Q?1E2XSVovMBgtABjRDYu0JHhF3qnXc8vY4359lXEEQnl378UX3w8/y2Uc2jN3?=
 =?us-ascii?Q?TZqxvvwKUkoRtPee8kYkUTxvyESl6Rrqlwep6QKLvuMtcZRkCprHqLUAqRzI?=
 =?us-ascii?Q?+wMUJ6NMpTWOFs3lK6zzAIxKV/v18dsOTT0nshft0NF134jK3GoA1tBYh8Z4?=
 =?us-ascii?Q?YhG1zaGau/OS353xIXSOkSxKWbnUGtnBdiOgs/FLFkfUI5x7CxxK4kN+lJ8E?=
 =?us-ascii?Q?NYBhGkSX7AS6IJQ4ayo6fctONHoMQniMyBzDyKexa549iwRVv26rmdYJDRdS?=
 =?us-ascii?Q?eIJ5SYWB+wD4rDTz60KqRVnfHPfTM9cUeLsmxsMMEMQGcHKh7QmfxN7n9l+O?=
 =?us-ascii?Q?C3O4+dxb2PngRS8ZHqZGz5g3MUlHtrddP3F+ZGLvnqiNL82ebnztg1xXmheT?=
 =?us-ascii?Q?aDOE+wVjLaWB0rV7bYrggwl52iJA5DInKFqPaZwzOJd/OMbn8PuQ4OFdcKEW?=
 =?us-ascii?Q?I5oVkJGYJuQGYviX89d0YRwa3DnOCy28Z3Axqr4KWib9r98OEpQEIqXqLqMW?=
 =?us-ascii?Q?5FGzn8xDJkIDfxmMOFNGQUo/fCTyPGQyKxOa9Qf1zHHjWkMKYzCmGN3T5fO5?=
 =?us-ascii?Q?2zAez2VT7gvMZnNsIbiQLUcvq2QwUEkrMYbwwbYlIh9MgiR3kITLVVD3XA11?=
 =?us-ascii?Q?zsGbjFDfLMZ7h4R4VoQrb+xA3jbPsL6cVG0UgHyTYIIESKuYwbQ2cHrT+Az0?=
 =?us-ascii?Q?FkeKLoluZlRNiNJSTAr1BlYe18q1pSsJacMcAUg6KO4PWZE9guTUBryYEV8G?=
 =?us-ascii?Q?tpYboBuuw+79stdsEORtc/NIr1Df5hBJfK3sjrFl4SxaeVl18ecCZ9venNUm?=
 =?us-ascii?Q?8O1eF9C5wv3XeKUY2orJHCcm9OrEH22osx+iVPt3PzDC+yyu3xKiLmzRkMDi?=
 =?us-ascii?Q?PUwk88u3v2ZwBHMWhdVRjvxFr/K3k2fx6VpXACPhBbH1H04La91OisvVd6fB?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cedd2ee-c82b-410a-bbc4-08dadc9bb433
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 23:50:52.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTTmYjYwyEJwcnk6FPwSrWUPUhZQ1RYrV0PN/vQ1cCsRVe/qocqpcXu8ghxq2K9XR8N4sOJx0NQCIltvsm6mdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120205
X-Proofpoint-ORIG-GUID: 2wgPm6sAfMmVLjL4Vcu0V40uidWdFKrN
X-Proofpoint-GUID: 2wgPm6sAfMmVLjL4Vcu0V40uidWdFKrN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for whether a hugetlb vma lock exists partially depends on
the vma's flags.  Currently, it checks for either VM_MAYSHARE or
VM_SHARED.  The reason both flags are used is because VM_MAYSHARE was
previously cleared in hugetlb vmas as they are tore down.  This is no
longer the case, and only the VM_MAYSHARE check is required.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c251faeb6f5..985881f9e8cc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -260,8 +260,7 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
  */
 static bool __vma_shareable_lock(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
-		vma->vm_private_data;
+	return vma->vm_flags & VM_MAYSHARE && vma->vm_private_data;
 }
 
 void hugetlb_vma_lock_read(struct vm_area_struct *vma)
-- 
2.38.1

