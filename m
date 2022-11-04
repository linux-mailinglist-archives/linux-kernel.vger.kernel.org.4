Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3486619C02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiKDPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiKDPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:46:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0640E303C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:46:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FGvAk030815;
        Fri, 4 Nov 2022 15:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nTm7Yq8w+UrLS55HwOpPtaNmqs/E16UW2Z0/KzvSYd4=;
 b=xIsMEvreJww3FjnZxBNL8WR2PlcNwZlIbAqGnTWolmc3m/SVbRnk03JYuQDgivSFO8cn
 Lfvr+tiNtzskWm1vN2pNlRH4Pen2Ku26lexmO84pR6i3SFG1H4yunRT18IeiChtvsYEx
 4DpRoepXCOdfpLYHVAxDzUbC/Jotw+0rSSMq+uIMvcwloRbNG3rQxm1Gc8gKjT2dJFTb
 H8fr1OoHQpIqryInxrbV9vqdCsqcIZlq8M0iE0AHxDRaLqeJSsnL02gDnWMx/FXt7AVV
 6rQ1xui/0vz0pjmjg5nnvqJ/DtP4iytL/AmW5UDbfeNiAvhHT+oZYGur6JfQFYjVsRBB 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtrhbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:44:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Eeo5q033120;
        Fri, 4 Nov 2022 15:44:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmq8662g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVQjktcpxcZQFlnzE8fnoatQAyNkGdflXPk15HmrLJl4N3G37dJPWV1IIf2/dz/RqiNCyKJwiNE09fVIRW+PKkM/AEKnVek7tGSteSfWcZ9RqDmnBcPVVlWoaKcdlKew4yQZ2eWjaxsWBF024x2TMGsVhwP/GMC0PScHPRbok25Zra7ukALWlIUewOPIl0cfZbifarJBvfvdwjgJMmn+kSicQIEGHh9HMVEOh1gI5vswYTU28/HtkVdOOXRKNipLwCRIw/ANYsHWOGg1xFaps+wjyvov9bYYTTRhCU3rqeF1v5kMQoJ1CUddtzmcDVIBze/PpXOjPzksAwU2WEduEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTm7Yq8w+UrLS55HwOpPtaNmqs/E16UW2Z0/KzvSYd4=;
 b=euLEuEDa7fODE4gwANjeBJrLPkGbzGY7PlXmuBqoY49AuJXBT8v1for/V4wz9KVKgOuKOgCYuw/cN4r8NshvlhSOwKKxS9RjhAwZLqoghqcCVHaRZH6tVtVLJ2VTYup0OyEq40/J5VWl9NBpaNAtxNVpCnbqBzyS5cjhhK71ILSO2phYTN0JMr8pJcW/AbitItdWYKz8BpEjWgdFUlqyTGPKXLzn7eesg9ud6b8VJ9Kp0MNPAdaj/bG+7Wqoo2UuMhTOvdnv47B7tJABTbSJ108fWcdcn2kpiM8AoHdYRaIbUj69tOsniw5U0LAHTBUKYPD1FOrpMpxtSVTbD7t57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTm7Yq8w+UrLS55HwOpPtaNmqs/E16UW2Z0/KzvSYd4=;
 b=I9Y64SVtHDyeZeFMVulOYgp+KQkvER1ajbGcqWzfKxhnmHmVdGO0ixS9S8l1g9kSiflakqFTcYidyrinGEMoHes1IrKOaVBNqZIMJ9eh03RDBWGo4Y1rUkBxvSpXDIE09HmNRvuwdRmZNI6CgQSEdIbirTgCDAAV+kpeF8FNsb4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 15:44:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Fri, 4 Nov 2022
 15:44:13 +0000
Date:   Fri, 4 Nov 2022 08:44:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-ID: <Y2UzSOqJr9glD39i@monkey>
References: <20221030212929.335473-1-peterx@redhat.com>
 <Y2RbGpQooJRq/gCg@monkey>
 <Y2UplvB0dgQYIZWm@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2UplvB0dgQYIZWm@x1n>
X-ClientProxiedBy: MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b424d9-1121-4639-cbc8-08dabe7b6c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCpbkpPO5LN8hjmxb9oGnWwp2nqrLNcOok0kdpaDJXITdTLxF86GqA/AXT4qLNDbr0mZbZwJHKky89X7MHC5gv22UjhOHavBWTwEQfKdvWtw3Usjue0jZt0ympPKfxgT19OEqYETQjbQNVOtmUdy/aMe276KBHDdQFeLFUlgmr2DMRWBH/POJlbMTdjzypMPJVuuz/2C+Bm0Q/P8IEEBNdsuOGiXKdleCORhPumGqHrAwreR7WiyF90KQiEjfCoaMr0gPnZUkmNs3ed7Ml+/uBLC8SLAhxM4Ra7LpQHFIm7gqXNHlpicAZhENHUGSW+AiwaiqRX7bB98wskPCMqOl1klZpFVKYSJCcHYU/5MAthX16Kip29sA/8Hp74Qhorl/xcznStPSt1qeOGc+kTGJnP/Z3JjrJ9DRGEYFLgQ05B/oGokWEXmwPi7uMnesD9Yom92DGFXEm09klYQmHiJe7u8mRd6sRx7k4oKnVKWRylVLFm1ObPzC5GAsHxt9iRgfT5VLzBlmAzlheMj7KPLk2ceO1x/2SxLk4RywvowZa1FIY5CxFVhMrF5CDU4ob0UIRZt+Pw5nIMFBj5WsOyIEOA5Bp9wQDzDu/8g1OB3ssqfjKZhi0D7ymE/VDXlHfsFWHNxkgEDToM41CxSBL/jSDbDuW1n9Giy9E1uYBN4IEVZkrAfct77XKyKB99zV1IRigYxa+CwTKiedK78lkhb+37oaGkoxPrZyRuEaeBUvLjxQq99SlngwrBMNLLW/88+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(6512007)(478600001)(9686003)(54906003)(6666004)(6506007)(316002)(6486002)(66556008)(86362001)(2906002)(83380400001)(33716001)(53546011)(186003)(38100700002)(26005)(6916009)(66946007)(66476007)(4326008)(7416002)(5660300002)(8676002)(8936002)(41300700001)(44832011)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1oIRw3IMF9U3zgC6PeAUvDgOIwUQEnW9n8adVRANwTnxLQ7d+ASdlCH3rNWd?=
 =?us-ascii?Q?QFeJQ82Gdfd+gq/4rW3BS3c7SbheJtY+kCFo2qiGGLZIlhPEpiC5SXq+LXJn?=
 =?us-ascii?Q?g9x3iiqjYY7gASjVQW6iMdzasObgthOehQFK5jPGsb/gA//aoQHOhteIsq8b?=
 =?us-ascii?Q?qc21Fck8BxNTO+wah6ayA3vo+yesafsxiEQ5iKfnQAxpnublr2/mt++Wbgw6?=
 =?us-ascii?Q?yI0PdXOEkg8lcijaUaeq8vM3B1jxaEIVw/9pLGwiSFW/moViFtP0fxDkvJVz?=
 =?us-ascii?Q?kSBjeMx0Ev2TWQPgzAnLL0g/DEWmpGPIHnAn2OrNVme26krsNtHvhSKpd0nn?=
 =?us-ascii?Q?i/UsMkklOzP1Mq/7c2anna5/84d6BApgCwCbA6CxWECn8PNozz0RIbbsR96T?=
 =?us-ascii?Q?lbKRbdB0Jlps6HrWgg1v2DPlSBVN9oo2b4WjsuVQtrpsP6PXxYA9JcNIVHm7?=
 =?us-ascii?Q?6CSHaDgFtatYUUikHQBCCqdRduPxduXvXr1AsgF3pFcbqt8NsRlUDOBt+MzF?=
 =?us-ascii?Q?fWQeggJb12Qmi6qes4Q5ZjlcFXqXrX8ic6CBMl+BtzX9yjaRLq9VgU/jyRA9?=
 =?us-ascii?Q?5upCb+gWKMHhfH+drfikCEydIXcGXS/n/pdXXCOnMgo66gKtbvQWwkb2FdUk?=
 =?us-ascii?Q?lW3tLPNZNbSxJb2YJPGGczOTDJIh4rkGbVsjQ2ovjlaj9b8e3HG60bm3sbWT?=
 =?us-ascii?Q?golzqyhT87xppNj2T2/d0c+DAmATPxKEFXkgAj5HgL3MuOOz11/S6Wh1bHT+?=
 =?us-ascii?Q?pXgTDf6w6BFb6wB/69jFkr5VrdjH5/RkZ2izZu6pPbkbiwPblHsQs1mo9AR3?=
 =?us-ascii?Q?QzFPNK1LwuXz+C2lI9zxwtESNdVIk1KgA1SixphBi77tQEIakLaIsZp045i1?=
 =?us-ascii?Q?P98Le/1HCGVE8LRmShqZUjtL8/EFl9rlTJ9PfILENhClOVeE5sztZaSbP5Bd?=
 =?us-ascii?Q?L1zfXbJJNoMv0hKKMPaYG4PlYP0ZTY1psGATpFuOQ3I0VHBu/B+T2rtFblEY?=
 =?us-ascii?Q?+ArHGH4E2y92qfk45qzH1wC0zxdb+nJv4dPiYB8QGtGDtkLtPNyJIyAT321a?=
 =?us-ascii?Q?myVtpEQA7Q9vN684IL7CM3Wa79c7kQUzWP+JPN+3MDw780LYC5YYSE3fQY1g?=
 =?us-ascii?Q?jaroDG5BUFhg7gLlNbbe2liovj/rtTCsWn+cr4QsV/noz+gOVzzv7TpX2yZu?=
 =?us-ascii?Q?q4CPU6SlZfRYSzKUAbitr1ONig8J9zhYMlFX+3lnESe3ywkSvFyDpnmG9P9Y?=
 =?us-ascii?Q?X0Cn9gMvBB2rVWaOaSdOzOvyoAOBSOYfyTeg/mUPRsYSQDTdgxWhxE7M//eA?=
 =?us-ascii?Q?T3UNSFcA+yxrNDEoM8wsVlxw+ylX8mhO/+zoPR9Yz3mgS8w8BdgSvk45UWaY?=
 =?us-ascii?Q?2+M04pRo3nZINB8Mk2Hmcl1twgdEFlXXVzSd67MyAhHtXYFBPPjjxmSzR8Dm?=
 =?us-ascii?Q?gRJH0XSQBLuZ5R3oqGnKRv6xBYhBOaX16OUjqroviPkGU0t7kOcX6e3kdgjd?=
 =?us-ascii?Q?wlS+LOItq4xtMxmIWdxFBZIWnuHoCF22ivs6vSfsgGY4xCbT3uoDFm0IubXq?=
 =?us-ascii?Q?uWpAaFNbwTNhhlLo/ozL2NaGCtqDVBCWLY3OQx7SdWfqFOax+qlmTe+wYvdn?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b424d9-1121-4639-cbc8-08dabe7b6c3c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 15:44:13.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PykC5FbI0de6X/gz33RYj0Su3mvh2PK5fHNaGyskd8Nsn9M3P4KiXwyQqwBbx5q+39Ki6SSfDOvtHvfMCywI3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040102
X-Proofpoint-GUID: PJQgv4tHq7XPL2pZQz9ZGFvvr9qhHZeH
X-Proofpoint-ORIG-GUID: PJQgv4tHq7XPL2pZQz9ZGFvvr9qhHZeH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 11:02, Peter Xu wrote:
> Hi, Mike,
> 
> On Thu, Nov 03, 2022 at 05:21:46PM -0700, Mike Kravetz wrote:
> > On 10/30/22 17:29, Peter Xu wrote:
> > > Resolution
> > > ==========
> > > 
> > > What this patch proposed is, besides using the vma lock, we can also use
> > > RCU to protect the pgtable page from being freed from under us when
> > > huge_pte_offset() is used.  The idea is kind of similar to RCU fast-gup.
> > > Note that fast-gup is very safe regarding pmd unsharing even before vma
> > > lock, because fast-gup relies on RCU to protect walking any pgtable page,
> > > including another mm's.
> > > 
> > > To apply the same idea to huge_pte_offset(), it means with proper RCU
> > > protection the pte_t* pointer returned from huge_pte_offset() can also be
> > > always safe to access and de-reference, along with the pgtable lock that
> > > was bound to the pgtable page.
> > > 
> > > Patch Layout
> > > ============
> > > 
> > > Patch 1 is a trivial cleanup that I noticed when working on this.  Please
> > > shoot if anyone think I should just post it separately, or hopefully I can
> > > still just carry it over.
> > > 
> > > Patch 2 is the gut of the patchset, describing how we should use the helper
> > > huge_pte_offset() correctly. Only a comment patch but should be the most
> > > important one, as the follow up patches are just trying to follow the rule
> > > it setup here.
> > > 
> > > The rest patches resolve all the call sites of huge_pte_offset() to make
> > > sure either it's with the vma lock (which is perfectly good enough for
> > > safety in this case; the last patch commented on all those callers to make
> > > sure we won't miss a single case, and why they're safe).  Besides, each of
> > > the patch will add rcu protection to one caller of huge_pte_offset().
> > > 
> > > Tests
> > > =====
> > > 
> > > Only lightly tested on hugetlb kselftests including uffd, no more errors
> > > triggered than current mm-unstable (hugetlb-madvise fails before/after
> > > here, with error "Unexpected number of free huge pages line 207"; haven't
> > > really got time to look into it).
> > 
> > Do not worry about the madvise test failure, that is caused by a recent
> > change.
> > 
> > Unless I am missing something, the basic strategy in this series is to
> > wrap calls to huge_pte_offset and subsequent ptep access with
> > rcu_read_lock/unlock calls.  I must embarrassingly admit that it has
> > been a loooong time since I had to look at rcu usage and may not know
> > what I am talking about.  However, I seem to recall that one needs to
> > somehow flag the data items being protected from update/freeing.  I
> > do not see anything like that in the huge_pmd_unshare routine where
> > pmd page pointer is updated.  Or, is it where the pmd page pointer is
> > referenced in huge_pte_offset?
> 
> Right.  The RCU proposed here is trying to protect the pmd pgtable page
> that will normally be freed in rcu pattern.  Please refer to
> tlb_remove_table_free() (which can be called from tlb_finish_mmu()) where
> it's released with RCU API:
> 
> 	call_rcu(&batch->rcu, tlb_remove_table_rcu);
> 

Thanks!  That is the piece of the puzzle I was missing.

> I mentioned fast-gup just to refererence on the same usage as fast-gup has
> the same risk if without RCU or similar protections that is IPI-based, but
> I definitely can be even clearer, and I will enrich the cover letter in the
> next post.
> 
> In short, my understanding is pgtable pages (including the shared PUD page
> for hugetlb) needs to be freed with caution because there can be softwares
> that are walking the pages with no locks.  In our case, even though
> huge_pte_offset() is with the mmap lock, due to the pmd sharing it's not
> always having the same mmap lock as when the pgtable needs to be freed, so
> it's similar to having no lock here, imo.  Then huge_pte_offset() needs to
> be protected just like what we do with fast-gup.
> 
> Please also feel free to refer to the comment chunk at the start of
> asm-generic/tlb.h for more information on the mmu gather API.
> 
> > 
> > Please ignore if you are certain of this rcu usage, otherwise I will
> > spend some time reeducating myself.

Sorry for any misunderstanding.  I am very happy with the RFC and the
work you have done.  I was just missing the piece about rcu
synchronization when the page table was removed.

> I'm not certain, and I'd like to get any form of comment. :)
> 
> Sorry if this RFC version is confusing, but if it can try to at least
> explain what the problem we have and if we can agree on the problem first
> then that'll already be a step forward to me.  So far that's more important
> than how we resolve it, using RCU or vma lock or anything else.
> 
> For a non-rfc series, I think I need to be more careful on some details,
> e.g., the RCU protection for pgtable page is only used when the arch
> supports MMU_GATHER_RCU_TABLE_FREE.  I thought that's always supported at
> least for pmd sharing enabled archs, but I'm actually wrong:
> 
> arch/arm64/Kconfig:     select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> arch/riscv/Kconfig:     select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> arch/x86/Kconfig:       select ARCH_WANT_HUGE_PMD_SHARE
> 
> arch/arm/Kconfig:       select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
> arch/arm64/Kconfig:     select MMU_GATHER_RCU_TABLE_FREE
> arch/powerpc/Kconfig:   select MMU_GATHER_RCU_TABLE_FREE
> arch/s390/Kconfig:      select MMU_GATHER_RCU_TABLE_FREE
> arch/sparc/Kconfig:     select MMU_GATHER_RCU_TABLE_FREE if SMP
> arch/sparc/include/asm/tlb_64.h:#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> arch/x86/Kconfig:       select MMU_GATHER_RCU_TABLE_FREE        if PARAVIRT
> 
> I think it means at least on RISCV RCU_TABLE_FREE is not enabled and we'll
> need to rely on the IPIs (e.g. I think we need to replace rcu_read_lock()
> with local_irq_disable() on RISCV only for what this patchset wanted to
> do).  In the next version, I plan to add a helper, let's name it
> huge_pte_walker_lock() for now, and it should be one of the three options:
> 
>   - if !ARCH_WANT_HUGE_PMD_SHARE:      it's no-op
>   - else if MMU_GATHER_RCU_TABLE_FREE: it should be rcu_read_lock()
>   - else:                              it should be local_irq_disable()
> 
> With that, I think we'll strictly follow what we have with fast-gup, at the
> meantime it should add zero overhead on archs that does not have pmd sharing.
> 
> Hope above helps a bit on extending the missing pieces of the cover
> letter.  Or again if anything missing I'd be more than glad to know..
-- 
Mike Kravetz
