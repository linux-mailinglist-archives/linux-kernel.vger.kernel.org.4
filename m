Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DC5F380E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJCVr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJCVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:47:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A463A495
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:46:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293LiMj0020052;
        Mon, 3 Oct 2022 21:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HHLTGKvhFuPh/5qXEmdrEsqyjT9Ql00TztsuOCKmxcA=;
 b=t39HQY0bb+IDoHY0gYWdZaUn03eQu2K5enjF4yYwajqMS7BTq6wDu8Tia8YvSRA0Cw9L
 bgo8DsK7oypl8fEyn/xNxwfpVWfQcYFQ2BHeB+PgoYZv63WbE6yqZ5qq9wzUtbH1NSPi
 TTo2Kl1/JvIAmvFeG5qhq24Lhb5If0awA+P04BaG5PMXcxEXSovkHrPlRyBoSQeGoO8/
 X6NWlU3Yocpk3i9pNPZYOdZBqB56LNrhO34TUPACfTc9kZEa/n7hSDHkmpXotNcdPcmL
 5URTvRLwRQ9if+RRqaU9gI5l1vbu28H5v7FP85mkRVMDfy8tnHPaINZ7oR4Ieo8E9s90 Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea4xxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 21:45:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 293LGWA1014074;
        Mon, 3 Oct 2022 21:45:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc03d3bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 21:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgVs7xJFpBQct3aYpr800dXXuSJUT8IVSeVhK5Mv6hs4VC6Xq+neyP4BpEzp7rNg9aPmj65hW4PJ0recK1ITLwydJJ4H12OjEs3+FoPtWWYlNfGtidIdKhONQzzTvmtxQ0U+stV3StqMzXeywi2Ji/mXcKxJx2xRASEmex9ERbPgZ/Hxo+SygOo1gLq9cXWzVZZaE9IzCGKIsPCpV7rMskRIff4j7N70m4WIHXRenzwTGwiOyrVt/l+4UV99kKN6POQ+eNnjRuzEaeAGqTISl5PXddXgVk2Ab3F6fhMTmCIiDmWHqyrhjkAVHvNr9CXoW8TQ3HETygIrqyjaWwcHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHLTGKvhFuPh/5qXEmdrEsqyjT9Ql00TztsuOCKmxcA=;
 b=nFope0PwFEVz3tBaGJ+1T8zOAG42qqyGtuPeTrGCn5J6lQO2N2I9YSKmTt6s80wAlKG3MoB8Jbra3EZjByYzgsUuVEh6Gkru8Cehbs6lZxiq+tv5tbAWdLi4B8NSTt/omrkBVxgHfuYGoR6lkskXaL5PscMD9ZrXxcjNT1Sd56pZGM7J67h1qCFJ1wZu0DyZ4CiRxG5N6UGjGVya9yBm6YI9AX9rfPo7rF+UAz/30Hu+Ap2ZibE6uVUj1PU71nYxCS2oJ9GXNXS5ibiyIb4WKtYIQsIvx8CWko4hjA6omukNsgLXsIqQSGxg1QW/7AeHWeH0EZ0UqXR3r2dm5mAmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHLTGKvhFuPh/5qXEmdrEsqyjT9Ql00TztsuOCKmxcA=;
 b=d7egW07X5uilTuzC+0TbInkRHc3Q9o/C5V9kVM6Eutv6Mq5vR+X3T1SwjBl7yIpxqfPhYSAqiPivba8K+hyIvyQaNn8FP7ecEvPv1eTtS+DRY1Cxm2ywKhi7ng5mm0FH4+/bs/vDNzqRJQ7ycixiMbqMW4oXAmNfYyyoyMJg0Uk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 21:45:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 21:45:51 +0000
Date:   Mon, 3 Oct 2022 14:45:47 -0700
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
Message-ID: <YztYC+2jalrsxKDm@monkey>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
 <YzsZ3VV/95AvXDUz@monkey>
 <YztT2OJake65WG3P@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YztT2OJake65WG3P@x1n>
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5830c23b-e7af-462a-2b4c-08daa588a3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBXlgM767erpW5BUA2fK0ZEh+k/n3Nbij83YlFtHIGaAWyfO3fH8AJF8pM3I8T50xjV231Y0syaKf40sI14egUzpYZ+MWR0TtRHalZ5Q3Kz01U50ymfmjbTLAbYvXdg1Q2h2JUmQXhieTm585UHGoJzHxwZVcgBFKRmR9R/C2KCsushKMLqxjOa5kYqBqMsaV743nHaDQNzpOPSO+QJzXp34N9uu3w/i2MtQSi2QiIqUyyNuoPW2qhUR5tgABQ/imNqsTU1s2vuoz6KadmwTlOmscHyCeg+5UWVmKmGEokaYYDB8fV/F9c1GwFI254HhpB1gStnQDOH7tMVij11VhuYFXBlRkvqlzflMGUWmsTsUT49g7XLLCcNh1L71WIsrkiF/fiZKkONB3j55f5kOF1A+S0jgv2qvbg9ZZDLvXl+ZVjn1JV9fCDRu6ZpLAIfvHjCFm+Yt7jqxeGh68qoq5QOrQvMLbzsAfmT2rrQigp9AQk4QWTGkV1BNGSUhs4f0C51z/g8Y/LGfvxmmxVqNFxjUzGeTFWPVckHb2HGJGToLjSTXtE7/bR9ZXWxYlVvpWIzbNmqnRclExyvzU+2fsRDXj/rL4RDUKUc9NwqQjGdKpomWY8KuRyQFVVkeyBntFTZwFw27JiiSzEEB2+5NnCerR79A7f0EwmCExpT1ato2eBGspoK+MABZcTNSimI1hDEg9DXvydaLGk0SM5n4hgvzacknhwEF9ybwrW2K2avYqXiijWAiLN6BCLfWTrw0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(186003)(6506007)(41300700001)(6512007)(6666004)(86362001)(9686003)(53546011)(5660300002)(26005)(4326008)(8676002)(38100700002)(33716001)(83380400001)(2906002)(6486002)(316002)(54906003)(6916009)(8936002)(44832011)(478600001)(66476007)(66946007)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhUjPa9s/SFL8j+UBh9r1G3F/yay8XZ5rETsvWigEXHr3YI63wYAc2fLwcC/?=
 =?us-ascii?Q?i3JLmuWmp3Q2BJI2M31dLDheMP8BjEa8funjF6B/ha7GrtOwjYDumqzStHut?=
 =?us-ascii?Q?PkMeaGerft8D/CCoQMZvuDtDthbFAovmHP7G3QDkj3ATD6Q3EYlulaMe2sdM?=
 =?us-ascii?Q?jdTr0SJRJUXwwrxH6DAMF8mQmdLnUBg1Y/pAsQ6EmsxufMv2SVUcdvfbF1LM?=
 =?us-ascii?Q?8ZDdWjhj+RciToeoUA6mpLMpTivsJR6AmmE+teeEbRTJ9+eeeapodBpe0zZY?=
 =?us-ascii?Q?F5NoRbtCNEpCavruZGn023/JXm8Wi7J4Nm/RAX6SNK3Mj12+6NNCUVcfdOz3?=
 =?us-ascii?Q?HTHH4baYBj7BYbo/JwNmzZ4ABJtj8JXHqt2+OCm0hBRo22B2ceey7cbz2YFW?=
 =?us-ascii?Q?XG3shhcp3RdUb37tIuaKI4pxGKg5zmy/y1EcUfTXfREM2ZeMAlVzewlkhtUZ?=
 =?us-ascii?Q?mFa98giUWr048iHLtUXSXZn29AJsDC7GTDZtKJLQ6Sli5RQKov/dQzUMS6TM?=
 =?us-ascii?Q?jd4/bpEKVhoVD5bP4zbXkJjFGKQP0KyLiGeyu1UOp0PfeNTFziTV+my10yjM?=
 =?us-ascii?Q?ssw5zHM00l/PNahj0Hfom2QeDwuKH1zlPYZ4I6AuPHumHD1pA84za9h2c7bH?=
 =?us-ascii?Q?TTYiO91HodlloH+F/7NmYLcwlV+HxzwHoyksnaF53dKLt5KdpYplk4A/ilRq?=
 =?us-ascii?Q?7t8lUxiBGD+tE43gjZtpbuHt+7xXb2LN9jyQzFaYNxDZm6luFveNTkY+Q8Fg?=
 =?us-ascii?Q?+HGNpY1YH4AXItLxRoI31u1swQ6ryhRbMeuBBKBxXFGSeM5XiIw3vg3z1AN7?=
 =?us-ascii?Q?7pWOIwu6TtpagxNn/ryZp5LWdg9HKCCzNCZcg4RGGPIkPJEVbdiWK51ap8a3?=
 =?us-ascii?Q?474Uhyr26S+JHYMt0NRj5th7YteaBLACg9KFrodB1lWK78vBcdGk+NQEUFQh?=
 =?us-ascii?Q?Hd5I1Of0J1D6V2wwUhVJlb4Cq7f1jCLjFRmKxMBZq6tQ8bbMPHJLundamjDf?=
 =?us-ascii?Q?Y8yh3RcuLldHR1E/Yh3oqWb/b7FC1wXfvpMkuZYnHXcRkT6MCXWHY+y/Fszx?=
 =?us-ascii?Q?GeR4sTU7ZynUZw7s6E56uX++R7Zc1CelKXieNTcq3oKQl4lhLS5RgPHL7Lln?=
 =?us-ascii?Q?z9bMHH222koYuJiDXkfamT2OCsLTavCJtPF5WYgETTfcXgd+ORz30rKzWtlB?=
 =?us-ascii?Q?9fMI+OWjr8w95a1zeHpSA94vfdi+J7c/skkEJfNnob07Uh9AYvtR8BgaQvr7?=
 =?us-ascii?Q?USDg9SGFL9Et99UQyJx8Mx42Vs8q/A2G76H389HlQdYytVTsxmRxt8Hb7QjB?=
 =?us-ascii?Q?mn5sxt0adY4FRNVNCr/Oumds9gBRJrIhnPwQBE0plZSaef9J8dm4aj/7Ki36?=
 =?us-ascii?Q?9Hoqhn1El0IZEDS4U4vLMtXAhx082ExBSheG8I4kFjXVkGxC/eSK1M4m+lfU?=
 =?us-ascii?Q?SHcWj0KY/6LpVQEEIRYHJcnFbms0kc7dgQ5fWKRG4iwAFSULCDvMTtdo7zb7?=
 =?us-ascii?Q?X6Fl3T3KIHsMutPtsPkwS0r10Jor0ncx6aDQzx4tlX4tV5cjByCDb2Ud3iUd?=
 =?us-ascii?Q?McqB3Jcd920fT3E1qu6VMAfu4vU7in+ODAqMo9U8AsuRIwGI+TOOaiDdK8j8?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5830c23b-e7af-462a-2b4c-08daa588a3c3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 21:45:51.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBv+TBuvBIau3YOY31FdzgnlaB5GfA2zwao3Q2ZAfFlh74wyaZUadrKDs2pWflyJxIV26PNFTd1rqgSpnuatNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210030130
X-Proofpoint-GUID: cKriXdSO27bCZUpnBHNmvbhav1c_djTX
X-Proofpoint-ORIG-GUID: cKriXdSO27bCZUpnBHNmvbhav1c_djTX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 17:27, Peter Xu wrote:
> On Mon, Oct 03, 2022 at 10:20:29AM -0700, Mike Kravetz wrote:
> > On 10/03/22 11:56, Peter Xu wrote:
> > > After the recent rework patchset of hugetlb locking on pmd sharing,
> > > kselftest for userfaultfd sometimes fails on hugetlb private tests with
> > > unexpected write fault checks.
> > > 
> > > It turns out there's nothing wrong within the locking series regarding this
> > > matter, but it could have changed the timing of threads so it can trigger
> > > an old bug.
> > > 
> > > The real bug is when we call hugetlb_no_page() we're not with the pgtable
> > > lock.  It means we're reading the pte values lockless.  It's perfectly fine
> > > in most cases because before we do normal page allocations we'll take the
> > > lock and check pte_same() again.  However before that, there are actually
> > > two paths on userfaultfd missing/minor handling that may directly move on
> > > with the fault process without checking the pte values.
> > > 
> > > It means for these two paths we may be generating an uffd message based on
> > > an unstable pte, while an unstable pte can legally be anything as long as
> > > the modifier holds the pgtable lock.
> > > 
> > > One example, which is also what happened in the failing kselftest and
> > > caused the test failure, is that for private mappings CoW can happen on one
> > > page.  CoW requires pte being cleared before being replaced with a new page
> > > for TLB coherency, but then there can be a race condition:
> > > 
> > >         thread 1                              thread 2
> > >         --------                              --------
> > > 
> > >       hugetlb_fault                         hugetlb_fault
> > >         private pte RO
> > >         hugetlb_wp
> > >           pgtable_lock()
> > >           huge_ptep_clear_flush
> > >                                               pte=NULL
> > >                                               hugetlb_no_page
> > >                                                 generate uffd missing event
> > >                                                 even if page existed!!
> > >           set_huge_pte_at
> > >           pgtable_unlock()
> > 
> > Thanks for working on this Peter!
> > 
> > I agree with this patch, but I suspect the above race is not possible.  Why?
> > In both cases, we take the hugetlb fault mutex when processing a huegtlb
> > page fault.  This means only one thread can execute the fault code for
> > a specific mapping/index at a time.  This is why I was so confused, and may
> > remain a bit confused about how we end up with userfault processing a write
> > fault.  It was part of the reason for my 'unclear' wording about this being
> > more about cpus not seeing updated values.  Note that we do drop the fault
> > mutex before calling handle_usefault, but by then we have already made the
> > 'missing' determination.
> > 
> > Thoughts?  Perhaps, I am still confused.
> 
> It's my fault to have the commit message wrong, sorry. :) And thanks for
> raising this question, I could have overlooked that.
> 
> It turns out it's not the CoW that's clearing the pte... it's the
> wr-protect with huge_ptep_modify_prot_start().  So the race is with
> UFFDIO_WRITEPROTECT, not CoW.

Thank you!  Now I understand.

This also explains why the new locking exposes the race.
hugetlb_change_protection needs to take the i_mmap_sema in write mode because
it could unshare pmds.  Previously, hugetlb page faults took i_mmap_sema in
read mode so this race could not happen.
-- 
Mike Kravetz
