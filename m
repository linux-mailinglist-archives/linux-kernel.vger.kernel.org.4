Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C568D5F345A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJCRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJCRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:20:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A8222A9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:20:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293GOD0V015434;
        Mon, 3 Oct 2022 17:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=5zSG3FkS6bQNtq9SFcWyE0ao4wSbLFScEKdh8OoirEg=;
 b=0zWcFZb0t4KrGE33OkYHtRwZmXObLzRLrcg/4nnFrHC+lOmY6WkvMfW5q/GdiEqIeF30
 1MMrJwbZgnCe73PfMy958gXMeNLReKhMbn0WqQIHzQXHnRY26l4JV3puZIBr6UpBKUqD
 HZvYY8uvm37so9sVWw2N8jBNnUZQpH9LFq/iVVs1gEfCk5xq7Tskx2H1pTaxIA7gA5ke
 E88WLZH7FdOs0M1+iiVyQ7bqYsuMOMosqHMKf0cUE/ykWi8c1FfibrkqvX7vHUeSZyKC
 T7EtwHa7jVgwPAHtCL+k5ixWUWBcPNXdltgDzrAdzkO8Mu1CJUsHdeGjy9CEo3+zkO1B aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2m7ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 17:20:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 293F5ALD014881;
        Mon, 3 Oct 2022 17:20:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc03xxnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 17:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz4x/60cqXm4Ol0XFg5Ljs5i64CB88VdkD2DY2KooI/alufgOfWsL10zf60VeZYlwH/3l9G2OP6eTcH8OPzs7JSLGFaz6NGor8N1t+89Mb8vNHUXRrHat++8XAWX7jjVekHzMWpFLB3SJBDXH0sKoyAK//eQfQX6IJ2NBkeFOuYcxaT3O/YXsuuudXPFxorC55xgyXKRkFPlUp1aTwZb9dIJMOCcAENs4KTSVV9xIeqIriQAjtMHDorVsXTY6ASfMqjbBLk3qLh9E0Ika4UJG2uF4SQrzJwnESGTWa+5y2YeCuulSTdPR9SysmSLuAYGB06VIRqrYcWULjbQQ/LMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zSG3FkS6bQNtq9SFcWyE0ao4wSbLFScEKdh8OoirEg=;
 b=hOVexC2OjxXPZZ26VjWNzIRqKPTXnPPj4mC1WgaMHMNm+Eh5bkKOJW7oJT0nFAnQjQf3d8F3OGIZXJiQGCbPLh3SaK6MEGw7lOQlPH09/Kqe4w2C/Fsm38gaxr57L7L0RSNp/32TVeQltjT6U+Cz21IouacptoPePM1BCM6YT0YYdntpi7VTwXx1UVx1Z4bDKH5w/eiW21ZQnLrvGDj6sXwVqK+vv4rUxQee27tGj+TgLik43WjGrBpJDDzl4RjPzzhLYhljSIrMcOT1VsZv/ft3oRpZui9p1z1iOT9wIVuVVbcmtBV4zpAqdJtpmEB8vpW4+DhCPq8teJUDC3tdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zSG3FkS6bQNtq9SFcWyE0ao4wSbLFScEKdh8OoirEg=;
 b=GbpF+i2FaELH1d1q93wywTn6GDqFB+6CWIjw9dpRUgBqqEhVZQn9rOFryCDBsvu7iW77AT9YgplaufDW1h0+WpiGu8cWqiPMwUdvha8mHb5CMO5EjgURt7slShGkuE0ZhAbZ2EOu9YF3ZfHHxpVJ4luyHQkiKOyDb59tU6Wa3jQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6110.namprd10.prod.outlook.com (2603:10b6:8:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 17:20:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 17:20:32 +0000
Date:   Mon, 3 Oct 2022 10:20:29 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/3] mm/hugetlb: Fix race condition of uffd missing/minor
 handling
Message-ID: <YzsZ3VV/95AvXDUz@monkey>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003155630.469263-2-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0357.namprd04.prod.outlook.com
 (2603:10b6:303:8a::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dacb33-4cff-4b46-5b96-08daa56393b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qdkAwrRH9rSsxrva6r87max9MSCCMS09S20eFWV87tMQo7U/Tsr1zVvrKChsZmYkwiZZECkSRA1XSHVYW0Z+IBz2rzUOcdJcScfLSk2on/xtDw+SYKAjKQQmP3JKJJzS/f+OTHICoZ1dMERXjp2EFVhg1mDPFo0ajsXrIfcpLGXfaZs07Oko15ZvMToXc5xuvKV1b4VE//GOoWUk14HF/WjYa7OnNXI8ctWYegoEDvZxms18avUvSzJLj5HJQTjpy7U/p0hJfiqumlCAR9MJbUd0no/yZ2YAjqovwI6v4+G9sw2rODXkidGk+XVJ+zAyaGk6i30uKGkQEPbpFDYS+UIierVjuqSy1oDMeWn5KEVLyL9lLrfAc1v3HFIabooFQrUuFkpDKGaE2UryXGH3O1Mad1kPBbQgfyea9mBCzxv/6AbCvXpzaImeC54x4UNkHBYkavQW/uxpeUPketypNt++NHdCFxWhf2HzIets4EdwMVhGICyxB7mLEGG7hc69wFsEG3PWXt79tibNLm19MwP2393qjp76iMe7XavJHmn9hcmFiejTphoz3FCH0K68L5waDJtlB8cctr2uh9hmNavyTjtB9BLElPaXwtLNH7K4FuNKsOPeZvAa/vYGJqzUjqxsUTa2myjUL0t+QkeEuNljigrqW9TWGqXQ/W8gD267KuYRGo8ybXtPvobTMBCPG9tLGvcd07q+TmvyKyRtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(44832011)(6506007)(86362001)(4326008)(26005)(6666004)(66556008)(66476007)(41300700001)(33716001)(6916009)(5660300002)(38100700002)(8676002)(83380400001)(2906002)(54906003)(9686003)(316002)(478600001)(6486002)(8936002)(6512007)(186003)(53546011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNruw8AmkVxIBFZ1vEMpeBMGXW3IWmy5GIP4XObkaLpplO3f1MrZzKtk8t2Q?=
 =?us-ascii?Q?x1Q3ulDSkMLPj4feMAQG1LrJ5D+O9KmdX1sFBXWYWV92p+AAuVFq2fLq3Tgu?=
 =?us-ascii?Q?xZkdtrNgXhTDQG13qZOxhbG1t2QjFO1lgpwlma5Zjb/XQa+8ZYsn4ldzHimP?=
 =?us-ascii?Q?mNQPR8e4K7s/NWsUgAGBnpNvR5n32fZwzSKmAFuiW53e45KfBNt2czpJwR1P?=
 =?us-ascii?Q?yLdq3IVjiQ0PXaO5MHEDNY9wtIsMEsduXTphnAx8AxWLXZemBLOO17oDLz3g?=
 =?us-ascii?Q?1RFlbOXPQunSRzX3jtbQ+lB98deii1vCguXbp2auACup+jq8kIXtmUcwrzNz?=
 =?us-ascii?Q?nKwmfWG6UmdgS0okd3DHdKCMvR2YmppcjQ5CM5XTWN1Emfya812y/BrQ4suy?=
 =?us-ascii?Q?Q/sxDS6a2tSkw+MRSSxHW+lFCVbThk9GA2Bu8DqNo0aFEfqb7+XBnnhlaCDy?=
 =?us-ascii?Q?CxahB+YmfwHS9iIIn8dWjsgsQfiBIWg78uwYSj9ILj9CGtWZOIGh1JsrhApx?=
 =?us-ascii?Q?fRwaeHpkZbNC2KpADQl3/mOndvTBCxMVEgU4wjOtO9ifJfojuKZL21Pa9fau?=
 =?us-ascii?Q?M6x3seXZp40/zI5baSYyKMsxitwvftncZDxsXdXWgEMRH7dPWyHCNwhKvWoQ?=
 =?us-ascii?Q?d3Z4GYah42SVEUAmFncECSQJtBH2ZP+Asr+w2/tTysjE+T6TILoqw2h79R6U?=
 =?us-ascii?Q?93f2eMh6YzQ8iQJilQ0vdj48mHzhlDgcnFjL517dw1TJWb4/4Xq7LNOXX0AA?=
 =?us-ascii?Q?RM0ITkUvPKd2haseRScsyV+hXPlTzDvYzB2JI0Jyr8gR0Bk9TKfVJe57AOSa?=
 =?us-ascii?Q?ftX9ApBClK9/7EpKxsbOFm8zNcR+iqTh4uq9uxaTRSKMQvZivZ2wg37Kzixm?=
 =?us-ascii?Q?WHDzxlFo8aDqXhGbcdt9TCAdx0zzzOAarukT8JI8cvO2Is/zvO/u381MMYJG?=
 =?us-ascii?Q?tYRynsVeyq3T9V8EAOu/fNIewjEV6NRSrTb5lSmgpqW13sibhbptrVTEt9jB?=
 =?us-ascii?Q?cEONQ4/xVx9GsY7lIyURLc6RJSRM0UYiwMQnGlFHsh47basqVg1gxB1PH7Zm?=
 =?us-ascii?Q?m6AarHhcFS6WQ2hv1842PZ9AyTwD4J5V98sauBxVB+gijJXsW0T2C+hw5vnQ?=
 =?us-ascii?Q?+XhzmEQLvoXur+epg5RY2EK/6HeKh0zU3rYv/w5F2KvunBsDYx1fb8JXwZeO?=
 =?us-ascii?Q?gmR/zjmc3Dj62ZeZ7R3jaAj+oBUYn6cdu0idje72mUAvk9hzCH5XLdJkcIiB?=
 =?us-ascii?Q?Ksfu5+AxbOsy0Q7rsTV12m2U+SXkJXyE8yQTYOV5euysyI7KYPQ6XvFqpTMe?=
 =?us-ascii?Q?yNvYXP88RpNuWFUiXs5lrwT80IZVVgWfhrKt58wgjZOapVbRbZlsCzxIQWbv?=
 =?us-ascii?Q?GokRsgGfHGEcfGcjv5MAr6zqiQx+T1FlESA69XLVPxOLqWZQdqB4tiydRlMc?=
 =?us-ascii?Q?aes01s86TFN3k37uhJfimmzOIz565ID59QobKO/u4IAfXJxwXa7w/GU3wCmV?=
 =?us-ascii?Q?4kaZzqCKtKrKwP2PidVLDhJCS7NZZgnQSyAz8g7xKuGWpaJc9ZWrD1oVtAz7?=
 =?us-ascii?Q?bEkFB6YkhhabIJbGq/vVVoYlEx9K6mW0/Bam/2g41oVUANWCIHwW/nIXCoiN?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dacb33-4cff-4b46-5b96-08daa56393b9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 17:20:32.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L77zT78bYfEXWBRRg60d3lzvs7hQk4TP6RuSk7QUDFL8KEyW8Xf5MRoNrVaYkN165VUiGWlhXWsbF/ALR8htiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030104
X-Proofpoint-GUID: CRBBuBN-Q_2acMtWyq2Oj0z91NPTh4Pi
X-Proofpoint-ORIG-GUID: CRBBuBN-Q_2acMtWyq2Oj0z91NPTh4Pi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 11:56, Peter Xu wrote:
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
> caused the test failure, is that for private mappings CoW can happen on one
> page.  CoW requires pte being cleared before being replaced with a new page
> for TLB coherency, but then there can be a race condition:
> 
>         thread 1                              thread 2
>         --------                              --------
> 
>       hugetlb_fault                         hugetlb_fault
>         private pte RO
>         hugetlb_wp
>           pgtable_lock()
>           huge_ptep_clear_flush
>                                               pte=NULL
>                                               hugetlb_no_page
>                                                 generate uffd missing event
>                                                 even if page existed!!
>           set_huge_pte_at
>           pgtable_unlock()

Thanks for working on this Peter!

I agree with this patch, but I suspect the above race is not possible.  Why?
In both cases, we take the hugetlb fault mutex when processing a huegtlb
page fault.  This means only one thread can execute the fault code for
a specific mapping/index at a time.  This is why I was so confused, and may
remain a bit confused about how we end up with userfault processing a write
fault.  It was part of the reason for my 'unclear' wording about this being
more about cpus not seeing updated values.  Note that we do drop the fault
mutex before calling handle_usefault, but by then we have already made the
'missing' determination.

Thoughts?  Perhaps, I am still confused.
-- 
Mike Kravetz

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
