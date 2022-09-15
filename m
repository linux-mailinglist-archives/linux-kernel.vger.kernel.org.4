Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33075BA1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIOUZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:25:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65380377
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:25:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FHxmjn006400;
        Thu, 15 Sep 2022 20:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+xPgyEE1AFc1Gt6HVsLNTWJ6SlmNfZ0VamDMeaNv6f0=;
 b=nD+NSYxRq5rvndW+9WHjOvLO8B39ip5p09WgNV6YEVHjESvAHNN3ae0NLZzGgrVwwxp3
 nSi8IGTf22IUWN4mU7AucpHj6vPwkCsGRn7SofUyHakev74vbnE4/vwbM56XA/2F54h6
 eDkpub2sAZS9ukazGXId06oPpJqXWgPQAD/he0s7aMVmLUgT7ERbl0ye/abJ8GALlnxZ
 sU4iqPIUXqLnYUeToIf/kr8Av/S1qqJ+QkhjL0Ksn/Qvt3luIL09RtUXLy3w1bksXnUi
 NFuCqNjmFfVjU8vs0EvHGZuIEbFa00e9/eMK1MEJiKzwsHgPg9q+wk2FSd52FJNSg8KU tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xagcac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 20:25:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FHxVwo019683;
        Thu, 15 Sep 2022 20:25:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xf69v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 20:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONXm2jP6kQGxHKAdbqfQJhIpKB4ZEVZit/5ZZR+K/YzJFJjX/tw/8pJEOtmkI32wrW869RRK4JddgH6Vyl1y0/R3o4pmqUfKS0edH7Zh9MqF6ar1/D6IBqHNr3hoKMYqmmM5G1tTZ17LIcFRg6qcqpUMy4przPCbu7BKlAXTibpCG+tgPjlqdTLNY+FmUUEitwJYxqRjJdwpA1A9muzmTWny789G3oy1vnRl7fZ/54mzFKMy75nA/DeN8nnRpE+p42Qd943oKNZ53XZfHNh3hVBqQGK98uv+v9kjIlP8fnw6/m/3rq7EdtvxIl956ZkrJ4dDGnexbu46uS0yFkJnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xPgyEE1AFc1Gt6HVsLNTWJ6SlmNfZ0VamDMeaNv6f0=;
 b=JMnfsmLJaU2KNOMxMkde1Cu7WCk8itnd6NswjMy/f7c1NBKSbf5VmfdWl6L2W4cSi8csYaiEB5f1kZsBeX2VpKYtd+CrPUKJpgdtZBlobkJQcUQe6e/uGGWAeFyhQHGiZ44IwvKOsRntip+Z7VYKNrms6VVcFG3CzhYdAln6s+Tf9hOIzad7euAMPAMxdsWt7y7cPOs2VG0SV/HfHXQFpe0Gg9V+ZlzNxyVYT/KuFVAIo5O7+k7fVUMx3CTY4zGFhNbFupY6XT3WdTXAWE79iFQj64blF8PN+nMKIASa9+tLnP33hd+nqKTKWbxMdTZ4R3Nt/5dz64TuKrtzpv+4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xPgyEE1AFc1Gt6HVsLNTWJ6SlmNfZ0VamDMeaNv6f0=;
 b=gWV3DG4jBfTZA1mP3tFHX7ShxlrgN3QuDFVBtvzGhZcrFCnDxBQ6Y1MGam08DypVrd3WMK3e9ivRdjRO0ImACfKPtPQ9MG1nzRRQQV8JxddQn9da95Ab6Rlh21o0+WJ8GeZmgv16EXQKjs7os1QH7y0xsyhUMdvJDmUqisgLxBc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 20:25:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 20:25:09 +0000
Date:   Thu, 15 Sep 2022 13:25:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 6/9] hugetlb: add vma based lock for pmd sharing
Message-ID: <YyOKIhygl66cG8Yr@monkey>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-7-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914221810.95771-7-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: dde2d60c-7a69-40e7-3c06-08da975862cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMwDIuztdgmBD936tYGAKwC31qBIfFnCUOMatWvm16HtYJGKpV/RJ6ikay47htETvKJRkuPoQvIA4qR4trda5CHHsO3gYzN6D5O2c6o4r99+0l+8u4u5JjNBNCjarVXmsC7DU7+lpq4ONtcdL1QB6Mg2dgc8DjdyWI+ZO5VGqoyADd9e+3b5IMReiPkYrmQgM5LEcBkvK2xB/VGwbtL8GSSg6rmax1EfYTHPVVG4BjltPQ/c78jNnPJ5Lu3YMRdnvqpQhoMEl4/yZf6gT3AMZp+K0Wqa6Qy7NUS0u0zZlgf3iTKH0Eipv6lXATeq6QYpkXzTWVugNz1gJMveBpazxUXeMPjw8EMT70a3fI1hFEng0GCS61DXa4xcfxtsQgXt9p5JgLKPQZhgfXQ6yXdbcPGm27tjQLQ7gUcMmXmJDT2gnvc6k2inYTM5GiEuPMsFgBiaYHVBSjFiFOznoEIYXmCLtDlmC7mrq4hzw55Vbb9BQxK9NVvTgTbToHWRCbZn7P+wNJO0bb+TYzbP9/I1AmnqB8FGC25OatuAcKtP75vDjj0peCLEqhR6++GtT8X2M7fMUrV1PuQCGNnRO0lR0pafYhppNiMCtPFrGM3yU7xkHZUYm2Qkuo/KZPYE4MVEeFDWguGkXeauxog6hWdqsggImgEXh4lYzByrF63PR6fTAjkzrP+ef2/lDL4NhUE7+oLLKzHCRFcPn7J1YQyd5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(6512007)(53546011)(54906003)(186003)(26005)(6506007)(9686003)(86362001)(316002)(41300700001)(7416002)(8936002)(83380400001)(66476007)(44832011)(5660300002)(2906002)(66946007)(66556008)(4326008)(8676002)(38100700002)(6486002)(478600001)(33716001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NpkLik8Hj6h0qyjCmE6GcFcGBOd+r1uWyiv0ispMGtdM2nh8/Qd6hJ8eZnFL?=
 =?us-ascii?Q?f5U/4BfdHJ6Q6jmU6/Wkq5ZqeZ8eyURvioOLcj1/06RHYE9hFWIqn+su03VJ?=
 =?us-ascii?Q?CNyLqlEv/RlwBW52c/jeNKnH2IiDWoWt2oB7+K8dgjbXV5Ad8O+xbzFK/L7R?=
 =?us-ascii?Q?k53wDRo70kJihb8DP+S6i+rzONB2Nd0hNaLVGgjSdcfsuMhPvc1h0o/2ARfi?=
 =?us-ascii?Q?dSo66xM+oS6+2MYBFx4oOEr6DNtpJg4aBV396FKFORzxsFdVT2oz9thjiliZ?=
 =?us-ascii?Q?D3MZxk+/3WkoZLKAvm4RFWe4DkAR9bWKJ3a3TvmE2o7PGYso2qEzyw0mzXup?=
 =?us-ascii?Q?7M4W6wEqdLIlYd1zx1ck8yhDYtmNM/kYRriprO22Mv3RheQnrmBJSoOmIPTW?=
 =?us-ascii?Q?PvAhXKE2I/MNvb6o2e5LDZnr6I3iegaO7gGlVIRsLZW1fUBcasADUQZOKt2d?=
 =?us-ascii?Q?TkcXTCL2BChe5/zvhpiS4SKCMWzfLI1tzpZF59ET1ZyoP+v3BwSicZN9cbAf?=
 =?us-ascii?Q?fiYnkF/myEuTnlkXxV1uTaKkpWbYu3uoLiduChF9Z2bDrCP3hrPAjCzK4b+H?=
 =?us-ascii?Q?gudUV491RPKWnTJPi7/gENl1fZYy/JBNN+lVdQQjaaCLzU+2/Epku4DynHvA?=
 =?us-ascii?Q?x3GnwEi+yhXM2y+71lYDlJkDK5TiRIwZP/u1GRt6Q7jHx8mb+v9pye5gYJAm?=
 =?us-ascii?Q?99cS1pFGJqfmXjnDo2XVV0Us5ggsAF2lmpTcW3zlbtNFAunqjQaqlZ40xNT6?=
 =?us-ascii?Q?mHAG8GrJsqHfchemCBaRptbI7ogYOhsbagPzxd62K1sOFOxpIcI0lYmaN/gg?=
 =?us-ascii?Q?zByzeLJeSgbGnDQEAa6AAM4rgQKfBM5z91mRA54xl3Mjr+eevBhrRz0Amhet?=
 =?us-ascii?Q?OG+cXUbYqdMYBArWhGrCjynteyXDT8FYc9bcCcPFCOdnFej417uIEuvTzXfo?=
 =?us-ascii?Q?RhDXjqhIKvQ0PV9/oZEsMA9vkNVTcyLYSyj3rGFTDHp0DqEIRgoSsbk9US6y?=
 =?us-ascii?Q?CnVE/1w8VkYHMGUtekDCYdOOIKKD7U4r4D4aCyURpYDlXbd6U2Gl5f4d0jGE?=
 =?us-ascii?Q?iPZGs/VLJmDUuY7+PIPTz57TjprgsNrbMQ4aXtiiU3qdxYZUQliusw21qddo?=
 =?us-ascii?Q?SJly93WOKtj7x9ZLoJE6UjIKRP8MVB3QG8nIBTBnYFHpgQytHCSpkyH0jaLF?=
 =?us-ascii?Q?jMs66nNQlK9GgO8U0STI+ZoeYv794wk6qz/vXfG/Zy6PJPl/Y6URtK9EWruk?=
 =?us-ascii?Q?e3g0hz0gJ7bLQnK2MalFvh16+9/WvljBE/xPrkhLdTLYGr2pNEYfrlFRZoCb?=
 =?us-ascii?Q?02Z6xHiQ86TIcfE2kdMWCWIWGL3xvxcG1ZxxVc6w2JP76CW0AFGJ3pMXDdcu?=
 =?us-ascii?Q?Lqn8VlfKRa803ncgvrGraOOc4OpbAdtR83qXMACnKUvjSazFeKqP3/OC06iR?=
 =?us-ascii?Q?hNq0E4QLg/q+nPvAM6CNLwfCrht7phe5t6U3ykMN7yFTq9jtXvynobLzPVf2?=
 =?us-ascii?Q?Haxdq9NmSeA5n4ci22rbvhdru/rjICM5/i+pFbo+bjQD/NgZRRtuwnd6obIy?=
 =?us-ascii?Q?kgTu/jlRK7L9Fekm/rGredC41pE7XojG1eGZCCD9vNS9x4cmjBlKY63odjf4?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde2d60c-7a69-40e7-3c06-08da975862cf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 20:25:09.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlRapCFiPNuHAoQtgUcL3fOfgamJJ+Rujzv5gWMO27XRbFXoJrqXo8MK/9TcctUzpNvmg7tutL/v4UEMCrJ6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209150126
X-Proofpoint-GUID: KlqLTIm09tT7ZvjmX55mQBCxYhVMVnl9
X-Proofpoint-ORIG-GUID: KlqLTIm09tT7ZvjmX55mQBCxYhVMVnl9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/22 15:18, Mike Kravetz wrote:
> Allocate a new hugetlb_vma_lock structure and hang off vm_private_data
> for synchronization use by vmas that could be involved in pmd sharing.
> This data structure contains a rw semaphore that is the primary tool
> used for synchronization.
> 
> This new structure is ref counted, so that it can exist when NOT attached
> to a vma.  This is only helpful in resolving lock ordering issues where
> code may need to obtain the vma_lock while there are no guarantees the
> vma may go away.  By obtaining a ref on the structure, it can be
> guaranteed that at least the rw semaphore will not go away.
> 
> Only add infrastructure for the new lock here.  Actual use will be added
> in subsequent patches.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h |  43 ++++++++-
>  kernel/fork.c           |   6 +-
>  mm/hugetlb.c            | 202 ++++++++++++++++++++++++++++++++++++----
>  mm/rmap.c               |   8 +-
>  4 files changed, 235 insertions(+), 24 deletions(-)

Reviewers - FYI, the following was added to address a build issue caused
by this patch.

From 8b3031350154e8e401ccfbc5e71cb95ef654d017 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 15 Sep 2022 09:33:44 -0700
Subject: [PATCH] hugetlb: fix build issue for missing hugetlb_vma_lock_release

Add a stub for hugetlb_vma_lock_release to build in the case
CONFIG_HUGETLB_PAGE && !CONFIG_ARCH_WANT_HUGE_PMD_SHARE.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2207300791e5..cc7877da18d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7008,6 +7008,10 @@ void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 {
 }
 
+void hugetlb_vma_lock_release(struct kref *kref)
+{
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 }
-- 
2.37.2
