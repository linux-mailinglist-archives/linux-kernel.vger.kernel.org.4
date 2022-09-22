Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE75E6D00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIVU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIVU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:26:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278AD103FE5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:26:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MKO5Vx025952;
        Thu, 22 Sep 2022 20:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=VMIqIa+WhAFs8xdVDiymn2XGbILGHbLxDUliQ6sSsd8=;
 b=zWs/NkrtBgxKjjqUxQrkiGuVwC3HIE1I8qI1R/K3+Y58Wj6s2XAbSu0TLEey1bymuFor
 P2/tPMNl9wsPpOwqLI13RaEh2RiGbVSNc2y2q8Ip93H6k31EHFe+4Xmc9x/hKKSbWx7+
 0O+bXmCXQ6G0zuQLAZ8BrW8NAe7zfP8NnATbtxawMtrjQ+XPm+AkpFhN1WqIdJbFdZlJ
 JGR+/UQJg6yzgHhHRNGvRHUYlt6UStCmQkd6YpMNNVaFAaW4rW2BUzY9Oa3BWmiL8e3k
 ocPiia0l0ag3lZCCKDJ9HVlpkOLiZHZ6aK0zfeGV9N/Be/ODNwNHgKp0OE5Vr6/mWs2H oQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kxrde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 20:25:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MI2UWQ005679;
        Thu, 22 Sep 2022 20:25:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cr1a4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 20:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXnoGT2LQc7iGMzNyL09rvRlZASdrL2FI3KRTS2yLV3JZ9P8SMZuk3pT/U7taZ0e61QRM4F7FyVNOCS+a6j+oThOmjmOohBXKWby7bPWVn6TMWy/jTJELK1cs1nQnSZVd+hNEWNegxIEdVKRtC5650shqhb/F4YnKpFRBeonSS24EoYmoPXGI1DtMv209xFyyiNgmW8DAYh48cxE263DKw6HBU4VjVKwsH6y3IcuGYyg9c/Rhsjvmik/apj5cZ1BEYMmw6btuUsGFQuLjO3GvWeN8diOuMzbA37aD7yaBIu/fNuXJKqnBIyNSC+lmAg1rTcEICJNszUHl22mA7RtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMIqIa+WhAFs8xdVDiymn2XGbILGHbLxDUliQ6sSsd8=;
 b=hjf98PfCftc0n/QHlOt15VIVcBwNVaeurEMgS88Fp6mZw+5KPXqrqYrPFTOupdHRmjX3iBX4xkEoYtho08CEJHOK4trj4CNtYiK/j9vGYuYvFEjkXkQX5qFn/S2YhMVyGcnhmcHtzq+/9YtNJG87ZWvoqbQpxUR3ZnDanWCXqh96JPEX8+TlIgSxF/t7LGgQDs+p8OD472Fe13lNsonTJEzpFSuLQj7G5RboZHTHM9iz9AXXlJ/s2c9fbuB8+V4JOceRYToLXrCrynqpuneWm0lxXjMPQPc/41t/L8hKjPwOL7SrDqVnmkTlvjBszl29rU4b/TUMPpN0yYNlfFVJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMIqIa+WhAFs8xdVDiymn2XGbILGHbLxDUliQ6sSsd8=;
 b=CllAoY759AZxYmOMbbZRHlTHq/C7ypXZfgikS6FOIDsANs79oSF/cZjOz0W1SLZwf8rwuA76u8sce6mWeD3sCIgu6/XvGkkFuYDURpc5ZSNNZTWB2FI7RGWBldKWcxm3x5EkFY4AL2gRY7Q8CKQvysgkkDyPi1KdgfNxFPi+h0k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 20:25:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 20:25:53 +0000
Date:   Thu, 22 Sep 2022 13:25:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/hugetlb: hugepage migration enhancements
Message-ID: <YyzEz4snl2x51iTY@monkey>
References: <20220921223639.1152392-1-opendmb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921223639.1152392-1-opendmb@gmail.com>
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: f41ae12f-0bfd-4dca-3f41-08da9cd8a5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm0k4UTvyM9vbXkFJ2EuHIvHp67GlOVz+Y2TSqVz2fKUjXq6DgR0sMuIjBZxcIvjzSd9Fo0hajC9aPSdG2hGYtWIMqHXzWw5wcOdf4oZflY3iGIx4tVYYx6mwvGYUNhH3yWCvykkQNfOUdbowGghDDcfidWmSA6XJubX8S8CTjlVchkw1QdZpgMAN7uqwahIDWtSUGreMEvpNDg6KJ/YZf6XJ2D/7htJ63mKNGuzdWGZyaMt9I/dPHY/TB3cVXgOdVxQ3C1z106rUDD12yWgNtKzxryzxSqb9PhLtth+/hDr2dV2byHHPKMjWHUvMl5Rzi6GAuU2ohtata7CokdxIrEMP0fPqM0dZJvDVHZFXoC9DVlpDDNRMdbXrG9t5UfUwOPfVkjyEyGxmUaklPAn1yK3dryN5VrLJESt4Sa92AhH/sG5KvCPB7tODybE97W3ojtWNoi6NneviVxZf90uwvyfY3XLl51romf0GKeQ6DP3yj4kxPoq6oVlZ3G1+SQix5C5A53sHT2FoUVVQgthck4KjCNlsQdGN60ZJULzRoZ02uP6pdHp/80cSCUIP/g5NRifvB7LrJ/YDNTueiFulk9Q/YC/wCLJwLktDOB7lMDU+iCpLJ6smCcRiIJdAoHzzp6HkV1jXsmfGRqkP+y/zG2viw6M/TGdvnC45plgG1KGHp9afdPsJaK0LRQ0WIClF4pU7yw9cCvA0NktzDVnclivJdJmv21LB+FLm0MG+Rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(2906002)(5660300002)(44832011)(8676002)(8936002)(6916009)(54906003)(316002)(66946007)(33716001)(6486002)(966005)(41300700001)(66476007)(478600001)(66556008)(4326008)(26005)(6512007)(9686003)(83380400001)(6506007)(186003)(53546011)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SZfxiFmCvwIThzQcCHMvApWVxETatxOsT7PHu3e4PwZF1o2S9KWFi01OI1N?=
 =?us-ascii?Q?Q7SpS/sbdcgGBpf7fz8a6bm6Dd1cjp6DhiRTlno3GaZvIdyEBQ48bJxEBFYd?=
 =?us-ascii?Q?iHQzS+sQbnhn1nVKfGN9fa0P+gxq690u8IjZlrvsfC6JgEcVtYHRuYnpZV2W?=
 =?us-ascii?Q?KguD2zFAtHDZMWBBqS/c9GWKqH21qI7cH2q/yG1P+ZTWyoNZJAbdIlZeXPtN?=
 =?us-ascii?Q?Y78H3VFMj2bpzMv8C+vSu4Vcsbz8X5RjhNWTWJwGosPl3KMhp3QsmjZi3D+J?=
 =?us-ascii?Q?a5m47+3fn6rF2feuAPWf194yu54yzPqhN86AU/wfmj14KDN2tqDmfrasbqNm?=
 =?us-ascii?Q?l6Mf0IF+7mF7ft9mZTWTRi3ie01v5r3rRQQ6yv7tXM6rCDj8nUtZnQhe6liR?=
 =?us-ascii?Q?R691v4TBrKQPYq8DoBoy4+rXctJ5fCji1EFe1WxfAxAonyz8A2WuCd4I86zo?=
 =?us-ascii?Q?DxOOEkmqkCV7+7tLSjEPmi5iwj8nSivcjAKU+noM0NIX6UPenN2qeIFfsTFk?=
 =?us-ascii?Q?efl8dQUHGEfkFBnacx0S2ihUpXYdWO+AzZZKJfWJnlq3+brZCwluFG1MtVS4?=
 =?us-ascii?Q?Qrpq/6bvgwFzoLuL3oCqwAU1hdi6yI/7YE/1zTiMbDf7bXcIk7r+VOikf3sK?=
 =?us-ascii?Q?weQSdNbDWMBrZWTa8Ykejr/cK80weN7HuTTDN/a8vDz33PEnSvthCGACUmLd?=
 =?us-ascii?Q?uQ6i5Yz5T8eBUsy6NGnkq7dUIg6jkD7mzINaHoc5jH/PGDYwAnR1S8BDMD8e?=
 =?us-ascii?Q?D2IZ8ILj3N2VVz5U3g+erXBrNuIu2TdnS+zBhj22EHm1S1awd5t4uZ8hCak3?=
 =?us-ascii?Q?+YHzzSUKUCKOXCYtO/VdWnt6wT5NRDEjkjrr/8/xmzCe6ueyuVd0ieZ4ZKho?=
 =?us-ascii?Q?rrER4r7e3yzKUUgvXs41+YJFIZcA9WnA5TaOzZWogW09D9cmc0RjzBpGkV6v?=
 =?us-ascii?Q?v+g6O7BB/GO8i/OmeEP33lBrUmYqRA+vtupuqX1xbhUnr633jD1ae8Jvyupr?=
 =?us-ascii?Q?qrnBDT0evR9/4hZEDgHYCJQGBZUCQ8RBsHHYzn9vW8sDjNzCK0IKtz56wu3K?=
 =?us-ascii?Q?VXc9soznHXqnCCtaJdoEEnE3PsMCTrRj372FffFYAWaE5ntUhjM7SfzfMT0S?=
 =?us-ascii?Q?R6rqvjx8uDv9Wx+wjnbV/jEIaJ2ZKQuJykU5Gg5ITObJ/uYH4yfI6eoq1SW3?=
 =?us-ascii?Q?JhpI2PyJ9ii7SioJ+YXVRTyb6zaf2UKbNNsjh1Mnr8GFe6FCAonktfGTkyNG?=
 =?us-ascii?Q?RNqfsOzxE2iTVzfk+y26Xro8a8BJT6DU7k5ueRmqLxgY4XM9sp4V4a6U6U3i?=
 =?us-ascii?Q?dOnV58Z1HewHi8f0CILTr3qFzA9v9EdBPpdckK/AH6eicxptEyNGfLJTixZX?=
 =?us-ascii?Q?dvwB5CQ+sVPPeJRT4gu/g5LVtiJlfYU8nzHf66SambSTZq/7fNl0oEleHWsu?=
 =?us-ascii?Q?bc4qQ2FhfJsR49eFHZXV5T+SA3HdjdYWD0gfIjukEpwCeS6hIDL2oEq45Jbd?=
 =?us-ascii?Q?h/9Mz1oe1N5eu4JBcBqlpKOGSJ4aK+cXH1G7z6ZLfkccux0iYgtP/vn/FRuW?=
 =?us-ascii?Q?AT1KiKg7npuYxOqb++YdBZz6Wx6VrOiiOSF0Ro821CMtQQDtbyE+wvCOku+B?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41ae12f-0bfd-4dca-3f41-08da9cd8a5d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 20:25:53.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWfAcgnyKP5bAjEQyFRXpWEzAqUSD7YETYDP2Q3/KARGdVVwc9iXuO6w3yJiO/4DnylXjKD7UM0A9dAfFABY8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=680
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220131
X-Proofpoint-ORIG-GUID: 0Dkdy6tC9FVmRMx0OFW1wxVNjTvDBI3o
X-Proofpoint-GUID: 0Dkdy6tC9FVmRMx0OFW1wxVNjTvDBI3o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 15:36, Doug Berger wrote:
> This patch set was included as patches [04/21-06/21] in my
> previous patch set to introduce Designated Movable Blocks [1].
> They were included there for context, but they have value on
> their own and are being resubmitted here for consideration on
> their own merits.
> 
> The alloc_contig_range() function attempts to isolate the free
> pages within the range and migrate the data from non-free pages
> within the range to allow those pages to become isolated free
> pages. If all of the pages in the range are on isolated free
> page lists they can be allocated to the caller.
> 
> When free hugepages are encountered in the range an attempt is
> made to allocate a new compound page to become a replacement
> hugepage and to dissolve the free hugepage so that its pages
> within isolated pageblocks can be added to the isolated free
> page lists. Hugepages that are not free and encountered within
> the range must be migrated out of the range and dissolved to
> allow the underlying pages to be added to the isolated free
> page lists.
> 
> Moving the data from hugepages within the range and freeing the
> hugepages is not sufficient since the allocation of migration
> target hugepages is allowed to come from free hugepages that may
> contain isolated pageblocks and freed hugepages will not be on
> isolated free page lists so the alloc_contig_range() will fail.

Thanks for looking into this!  I am adding Oscar, Michal and David on
Cc: as they have looked at similar issues in the past.

Before jumping into the details of your changes, I just want to make one
observation.  When migrating (or dissolving) hugetlb pages that are in a
range operated on by alloc_contig_range(), we should not change the number
of hugetlb pages available as noted here.  This includes the number of
total huge pages and the number of huge pages on the node.  Therefore,
we should allocate another huge page from buddy either as the migration
target or to take the place of the dissolved page.

For free huge pages, we do this via alloc_and_dissolve_huge_page.  IIUC,
there are no issues with this code path?

As noted above, for pages to be migrated we first try to use an existing
free huge page as the target.  Quite some time ago, Michal added code to
allocate a new page from buddy as the target if no free huge pages were
available.  This change also included a special flag to dissolve the
source huge page when it is freed.  It seems like this is the exact
behavior we want here?  I wonder if it might be easier just to use this
existing code?
-- 
Mike Kravetz

> To address these shortcommings the HPG_dissolve hugepage flag is
> introduced to tag hugepages that must be dissolved when they are
> freed so that their underlying pages can be moved to the page
> allocator's free lists. This prevents hugepages that have had
> their data migrated to new hugepages from being made available
> to subsequent hugepage allocations and allows the isolated free
> page test of alloc_contig_range() to succeed.
> 
> Dissolved hugepages must be replaced with new hugepages to keep
> the hugetlbfs balanced. To support blocking allocation a new
> workqueue in introduced that is analogous to the workqueue
> introduced to support the hugetlb vmemmap optimization. This new
> workqueue allows the allocation and dissolution of the hugepage
> to be offloaded to a separate context from the freeing of the
> hugepage. The sync_hugetlb_dissolve() function is introduced to
> allow outstanding dissolution of hugepages to complete before
> the isolated free page check is made by alloc_contig_range().
> 
> In addition, a check is added to hugepage allocation to prevent
> free hugepages within an isolated pageblock range from being
> used to satisfy migration target allocations preventing circular
> migrations.
> 
> [1] https://lore.kernel.org/linux-mm/20220913195508.3511038-1-opendmb@gmail.com/
> 
> Doug Berger (3):
>   mm/hugetlb: refactor alloc_and_dissolve_huge_page
>   mm/hugetlb: allow migrated hugepage to dissolve when freed
>   mm/hugetlb: add hugepage isolation support
> 
>  include/linux/hugetlb.h |   5 ++
>  mm/hugetlb.c            | 161 +++++++++++++++++++++++++++++++---------
>  mm/migrate.c            |   1 +
>  mm/page_alloc.c         |   1 +
>  4 files changed, 131 insertions(+), 37 deletions(-)
> 
> 
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
> -- 
> 2.25.1
> 
