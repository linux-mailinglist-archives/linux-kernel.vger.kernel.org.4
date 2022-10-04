Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEE5F3B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJDCdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDCdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:33:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FB21806
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:33:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2941EQRq021606;
        Tue, 4 Oct 2022 02:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+R6pVc5IIEZNwmR61oV9X2pjDFi2F/6f7iUdcNIQcAo=;
 b=TgSFUiQUOcliyJAL8UjBye0TyH97chNz0/HNs2NUa1ub09kFLMlKPBxqdpRWMj2MtND5
 xl1loXzjnoYRT9hWRLqO/xVew2LaqtfUg2HpjhT2WaUW7A4vwbfSvVG5VD3ufauyzH4c
 zTnqyDaBmXMEK8CI9ODOzGiNBW0TOGlJZqnICeyI/4LrGOf6i3S9RAGdAy3YdCY7nrCe
 CvNw887n07EPbfQE9BH9am3qHET3SI8P9ZpzqcL3YwP7Hh5arf8HRmoCpdeV32x4bDSg
 jghD4e24YCrs4Kzu4lNqLCDCO9k/tGJUJDTp5GGGGLvN5AIbeCbC9yKpV+MAuSeu/OuN 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea59x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 02:33:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2940H5SL008407;
        Tue, 4 Oct 2022 02:33:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc040n48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 02:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I98oPXgbsbsd0HxihrCxtzTtXLx4Q42C/qgl/YwpN2/cGx9a3k2L91wp6wrRXYeso2Vzyvz0jfBNPFGD2jfWokZdpfYEJUCTeS9Bfg4FaVjjrcPGcxPM+kST0TB+mVsNQdyi0f/9sl1MBieipb4Yk9XSdhTg+HzwEEcKiBVJCiMxQCcUTbp7KnoBqJxw5fvYO5n+cnYwKKhPnwvEdcziDDJyG3RJxY0ClgEj68Wdlm0aJW8UTLiEVCBA+EswayGVNw51lupelwx1Il6jN4aBdl4TiY5BYZ2Gql1EcEJorZ6yre4jsBPU7zo2qVSmR+0KbOZdh6/lbf3kCjlAGag97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R6pVc5IIEZNwmR61oV9X2pjDFi2F/6f7iUdcNIQcAo=;
 b=RGkFYbGEuGCWnw5WI+c98mRMpIV/zQtWV6TEc/sPzfJwMkOVqhj+Cpcbus6XDpWdhBgXieJ+BG42HKyipd8CP3PDKKCJwrdldhaytDZqIbN+D9phBeVByWXWcZBLhfGf5QYxDLNMMrYep3MLzawkUg33DT8FFMZOwbILvSEUM2YlGGxj0BAXtemToHvg9CT6y32ZPx5C8bZwux/LO2tfueoNgHbXEIeAJ8hbKxyQ0xAsfI6gTFhfFpCOrR0B3lzPEA19Xcy5ME5/dCEQJZyNMyIeaBkw5g5TBpzmYsWkp4xFPvMvPaYvLFoAN3ty58xJmaqJiEyh05DxwZz1v/OY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R6pVc5IIEZNwmR61oV9X2pjDFi2F/6f7iUdcNIQcAo=;
 b=wXamJPYO1ZybgdC+re5bchpuPBHx5vPDTXvUIgTy49mCEMPtkopCK1ygUF6w8uYEuhX4R7R9s8aw8eLHpY2aujNfJKJMvJWTk+/fQoasYd4AbpMaQyz+Lj5OGKcQpV5nr74e2DiJkV1dNv3SmGb4zSJpC+3x4RezPZo4KdsIUFI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Tue, 4 Oct 2022 02:33:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 02:33:00 +0000
Date:   Mon, 3 Oct 2022 19:32:58 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/3] mm/hugetlb: Fix race condition of uffd
 missing/minor handling
Message-ID: <YzubWledIOzKHNln@monkey>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-2-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004003705.497782-2-peterx@redhat.com>
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8930ca2a-dfee-446a-dfac-08daa5b0c193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrVYZ+zNC/GrOeIf1z/VxmaL6UP/6VYVCYVpxFOvyvXHGW+bxawsXMPXydi9vDIpRoMEgCpArppVLvNHZnItjJrepy2kEj7IHzk65dBwQj8LtelUKFd5Sm/YKsF40iwnVPPXpBopQdJ2m3xjMFPhv8Bl+uHAiWVaLPZVCbu7+LGUMNiMIPIXR17yIJu0RlhS3NUJkhIp7rkF73U53xQpVutzW+wEKTPNDufx0sLsSH9SD0l081r3lQsUUE/GJjJqA09Q+vGft0NQ8t7peZl7IQJZR5fpxYIvhEdQQyHUs6NTQG01aKkDjxYdydq9JlUXqRwmMmUP2o4RlH9Ym+119ilBAhdSMPpwuK692HgyaFpIAo1Gondj9y90IYca6ck0pLfg95zRHs0S3hT+dLPfU8i3UPMOOH0MML1CJqgeSbTJx01yzIE4yxYNLEqg3l32dOg6As8ZN9O3DyvnPFsVklRNliWkjFUq+A79Pgs4fJ/QqHtEjWEic7U012bB3vxGH1i3uFHtY06dC3hAF7zobV6zWOen1UD40u7qHZtmcstl9JXrsKAdNkkY9qxVEy72neFRPy934sURC5NtXdnzDf11VnlLOI58zOooDI+90iuG/xXUqd+A5Ei+kFo508H2Lw6HQVegTaKjP6DqjQs3ntgRcrcjqDccZouwx4SdZL51X6ku8EY9f1ivTJ5s6vja+SgEp47+2RW0zBMzOnqzIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(53546011)(316002)(6486002)(4326008)(2906002)(6506007)(38100700002)(66946007)(5660300002)(54906003)(83380400001)(41300700001)(478600001)(8676002)(44832011)(86362001)(8936002)(66556008)(6916009)(33716001)(186003)(66476007)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s46HNSFDHSX/UJOItATbqvaVUHLfwWe06RrFzH3Ze9/q+SJOWU7WKT5jEdEn?=
 =?us-ascii?Q?kpvIQiNmDqSMpXaiAORUNTw2BFSMPBJldunVqyit0MlMX11kxhlnFaLQCFU3?=
 =?us-ascii?Q?3MyU+Gg3Qx34AaW6XJJd8BtD8KttYvmILo2mmqN9J29QN52PLRTtC3m96yX3?=
 =?us-ascii?Q?9GZJ8FcUFSz2gM/ucPKhhkSsC3o1Z7wZLkArW09ClvrIOFuMhsDLhYt3c8yF?=
 =?us-ascii?Q?SIx9bbhtLA+NqcFKfCfiU1thW6/QLgKpPk7QLL02QFX7Rjmawyz8ABOzcrMX?=
 =?us-ascii?Q?4RvLyulONdAJt/7tusLSUmODX7eVTsV0sHVNqDZUe8XFsFIWhTZJvZLCtNw8?=
 =?us-ascii?Q?/frIAumvWUkz3Y2RM9e9KSw3BhHgnwbLRKNxdlK9vrJhf6WpFe3aCOoC/o+5?=
 =?us-ascii?Q?bhvpAiObg+Asu5A2OiNrUB3Ipmzw9XSdwnow8Ud3YTReK2ZBTEdEKM99nocD?=
 =?us-ascii?Q?q/r4YeRpDRdm7WJ28pL/hEkzlTw6jD+hzNfMMDMKCtbJkLrd8ah5EJYgd3I8?=
 =?us-ascii?Q?1ZkmmGkRN2mjMPiZqG2c22Vd4ajk90QFZJ+O6AP2gQeRT7W4mHth+58Ab50B?=
 =?us-ascii?Q?SXoQkiHTIjtypucuhPQr/5FRmW3pkTmSWoa0KCPM8WFZMHmYw754BpdLENdN?=
 =?us-ascii?Q?peue6XXFRxXTt8lWa7XzrrGEmNYG97v9rVasDbEbN5m2U+EEdkqhhTZhe6H9?=
 =?us-ascii?Q?u0wpma4Y4dVyZxXQeWYHR/GKhEUUDXywTlkNEHC2jj1IeRs6VMvrbLcS14z7?=
 =?us-ascii?Q?zhRMyZpHaUxo+0UzCELxC3kamED1DrBdPZAFgHTaUZ6sEVnJiJq+GZcekKWe?=
 =?us-ascii?Q?CTmVYq8vWz3HCZzLN2YSfs38ifuNqtUDUNY3UfrPD+o6nWl3JIr4tTrIqVDH?=
 =?us-ascii?Q?pg0u3argtW9y9jZ7gEwJyYxFJR2jgUw/ztS2XH8E/hZxWEwruPTz+UQntN3P?=
 =?us-ascii?Q?/6hj3DHbWWDuxlb6TaQ96Xc4GtiCW8smyG8FPeSst/e5TbKlRYfamNJf4Lx6?=
 =?us-ascii?Q?iMcHLlkUDMv3QrTooS7AKjGLAjBEtsM0C878EF+3KVVzzTQM6jISplM8tejc?=
 =?us-ascii?Q?D0h1aqKmABXkzDGfiPyzImV4a14wQ1IJmsYJaERjhJln6IEFzAmYkfw2VAwQ?=
 =?us-ascii?Q?QkffbMY6xucTO4mex/UKJDekIBTMubTp2TH9/uwZ9JXQugR80QfyUXdrmpiz?=
 =?us-ascii?Q?o90SUFwYb+KnDIR5gr0PQAsR7LkD+UPVaq/Il79aS5yBhuEItIQfTJOUK4XL?=
 =?us-ascii?Q?KngSGOfxglLTWM0EgR/MpAcx7hCu9MgVVPOmcCf6VV+7OycrJSo07+QmzO0t?=
 =?us-ascii?Q?JiPJFh45px7oFUl5dBdgKGyscc/78kjjyrbC4fQ1h09wUhHeDltXpFQakfU5?=
 =?us-ascii?Q?Hp7RVxfeybM1f1A7SGOzgW8iEF6PDrZeNDTE2bB9by9rrWExl1K84YeQNxTh?=
 =?us-ascii?Q?1Suqjz52PVKPfe8pKeBiZ5jvv9y4txjaPiAU365SkIpQlyVq+NvqX4WIqg/s?=
 =?us-ascii?Q?MDIlc0UNv4SXzW8DVGVLDz8WC2B9r7otmHbgGjd9TzjChxZ+DyPqR9IfJ/c8?=
 =?us-ascii?Q?WAjO2lNYC02b4lQlHKwvlLI8ax7ihWLllIRk4wEAiOQggLxPTgfx7HINtwd8?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8930ca2a-dfee-446a-dfac-08daa5b0c193
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 02:33:00.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP2H6QCFhpwn9KQf3ExgcjjDP6/r1RcF+S2VPR18szkHFQtZ5WYL0tzblk7sAOaBTHqJ1fz8VwS32+1iHgLreQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040014
X-Proofpoint-GUID: 7TSdqNizkIX8t8XVTTA-oBBQppZNn-Gj
X-Proofpoint-ORIG-GUID: 7TSdqNizkIX8t8XVTTA-oBBQppZNn-Gj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 20:37, Peter Xu wrote:
> After the recent rework patchset of hugetlb locking on pmd sharing,
> kselftest for userfaultfd sometimes fails on hugetlb private tests with
> unexpected write fault checks.
> 
> It turns out there's nothing wrong within the locking series regarding this
> matter, but it could have changed the timing of threads so it can trigger
> an old bug.
> 
> The real bug is when we call hugetlb_no_page() we're not with the pgtable
> lock.  It means we're reading the pte values lockless.  It's perfectly fine
> in most cases because before we do normal page allocations we'll take the
> lock and check pte_same() again.  However before that, there are actually
> two paths on userfaultfd missing/minor handling that may directly move on
> with the fault process without checking the pte values.
> 
> It means for these two paths we may be generating an uffd message based on
> an unstable pte, while an unstable pte can legally be anything as long as
> the modifier holds the pgtable lock.
> 
> One example, which is also what happened in the failing kselftest and
> caused the test failure, is that for private mappings wr-protection changes
> can happen on one page.  While hugetlb_change_protection() generally
> requires pte being cleared before being changed, then there can be a race
> condition like:
> 
>         thread 1                              thread 2
>         --------                              --------
> 
>       UFFDIO_WRITEPROTECT                     hugetlb_fault
>         hugetlb_change_protection
>           pgtable_lock()
>           huge_ptep_modify_prot_start
>                                               pte==NULL
>                                               hugetlb_no_page
>                                                 generate uffd missing event
>                                                 even if page existed!!
>           huge_ptep_modify_prot_commit
>           pgtable_unlock()
> 
> Fix this by recheck the pte after pgtable lock for both userfaultfd missing
> & minor fault paths.
> 
> This bug should have been around starting from uffd hugetlb introduced, so
> attaching a Fixes to the commit.  Also attach another Fixes to the minor
> support commit for easier tracking.
> 
> Note that userfaultfd is actually fine with false positives (e.g. caused by
> pte changed), but not wrong logical events (e.g. caused by reading a pte
> during changing).  The latter can confuse the userspace, so the strictness
> is very much preferred.  E.g., MISSING event should never happen on the
> page after UFFDIO_COPY has correctly installed the page and returned.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Fixes: 1a1aad8a9b7b ("userfaultfd: hugetlbfs: add userfaultfd hugetlb hook")
> Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
> Co-developed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 6 deletions(-)

Thanks.

Do note that this will not apply on top of "mm: hugetlb: fix UAF in
hugetlb_handle_userfault" which is already in Andrew's tree.  However,
required changes should be simple.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9679fe519b90..fa3fcdb0c4b8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5521,6 +5521,23 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  	return ret;
>  }
>  
> +/*
> + * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
> + * false if pte changed or is changing.
> + */
> +static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
> +			       pte_t *ptep, pte_t old_pte)
> +{
> +	spinlock_t *ptl;
> +	bool same;
> +
> +	ptl = huge_pte_lock(h, mm, ptep);
> +	same = pte_same(huge_ptep_get(ptep), old_pte);
> +	spin_unlock(ptl);
> +
> +	return same;
> +}
> +
>  static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			struct vm_area_struct *vma,
>  			struct address_space *mapping, pgoff_t idx,
> @@ -5562,9 +5579,30 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			goto out;
>  		/* Check for page in userfault range */
>  		if (userfaultfd_missing(vma)) {
> -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> -						       flags, haddr, address,
> -						       VM_UFFD_MISSING);
> +			/*
> +			 * Since hugetlb_no_page() was examining pte
> +			 * without pgtable lock, we need to re-test under
> +			 * lock because the pte may not be stable and could
> +			 * have changed from under us.  Try to detect
> +			 * either changed or during-changing ptes and retry
> +			 * properly when needed.
> +			 *
> +			 * Note that userfaultfd is actually fine with
> +			 * false positives (e.g. caused by pte changed),
> +			 * but not wrong logical events (e.g. caused by
> +			 * reading a pte during changing).  The latter can
> +			 * confuse the userspace, so the strictness is very
> +			 * much preferred.  E.g., MISSING event should
> +			 * never happen on the page after UFFDIO_COPY has
> +			 * correctly installed the page and returned.
> +			 */
> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
> +				ret = hugetlb_handle_userfault(
> +				    vma, mapping, idx, flags, haddr,
> +				    address, VM_UFFD_MISSING);
> +			else
> +				/* Retry the fault */
> +				ret = 0;
>  			goto out;
>  		}
>  
> @@ -5634,9 +5672,14 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		if (userfaultfd_minor(vma)) {
>  			unlock_page(page);
>  			put_page(page);
> -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> -						       flags, haddr, address,
> -						       VM_UFFD_MINOR);
> +			/* See comment in userfaultfd_missing() block above */
> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
> +				ret = hugetlb_handle_userfault(
> +				    vma, mapping, idx, flags, haddr,
> +				    address, VM_UFFD_MINOR);
> +			else
> +				/* Retry the fault */
> +				ret = 0;
>  			goto out;
>  		}
>  	}
> -- 
> 2.37.3
> 
