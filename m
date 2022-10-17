Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050A3601588
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJQRjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:38:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07017331F;
        Mon, 17 Oct 2022 10:38:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HGH3G7005065;
        Mon, 17 Oct 2022 17:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=rOcKZmWl/BYS9pdfCKorzAgRXPEmbNo80bHwNysIBGI=;
 b=V9f6skMijBVtrO6uRiO/KLCr49BFyQekqgZxWvFBZ/cFI/SaD1BxTGne3v1NhiJfhO+y
 UKMpupHpf2baSLYEn4ie4tp8zhh/oKUeY1inRYOfozXAM/sNj3fP2p7m0HnUOgPsgqm1
 PD3DO6RnGKQg9F0C7Vl0cIyefjOt18lmorhUeg0yLA3QbM3uJ9uWqtVGSAjM3LlepD5B
 H8G1MfPMgYr+eORoxYqkxb7sXzVMeaJMhH43YHuSqm7sYQ923mZN9VxgNLQGaM/lEZEf
 kfATR/YkkR19Lz5aDQf1GOSnMh9yjkuwy3fJF7o/bUIZU8pRLHgF6HB9ik++Fv2vdfu1 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtcn36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 17:38:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HHa530015967;
        Mon, 17 Oct 2022 17:38:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr97h70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 17:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl8pW/lLklP+oIqhAhsn1oBIm6AfQ/l32MXY+pfJ4hiOmYBq2tb/fTJxfDeagPqpHT0FZAVemhNLnXXmZuTGYc5KUPjANiRDah0NEzpagUUzY0u9Dk4UVj5GRiSf9JPviOXEJL/hJp0xCZiOyXeJZrFIgpdmGeJ4SeUJJNpZTBjP/zEABoe5KO+QXYbSq534rldX4s6Ena24DpPfcYsOJ+x7/RXK//M8CdLA+kj1AGYO3tshIhau0s8d/qu34qzYxs/ur6FEq2qydpDYUWYHewJXl3ccMuT0fuzRZBcrzkQSWNEtKyXEaKiU2R+wxbzaYOwFxDNyzHqznetun3YnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOcKZmWl/BYS9pdfCKorzAgRXPEmbNo80bHwNysIBGI=;
 b=PnDjYcJ7PDAR3ccr+kegjsudbP7PbhgBvF3d+k4kn6qXMmMU3IpttuzhInUtw5HDEGg/DA0jfEz5NkkmXkEcmitrq0hS4KP5xkuKF5SXcWWtd8hDyvHE2tM9xl+niyhrUeoxvtWyj1TNxhn3OVZxs3ZsoK3ZTdRBWQ9GUW5iSIfpPPBB2lCoW+qPTWUykjmrqzT2APmmgFTH7SCW5qpxcAwD2tdClIDlrjWjWu9+u/0AdMF42Bq/YDyARxbMKLBLyeb+ECb/07GfzmeBfJlfQ40Y/t3uyeSsJx/pK8qzWdaxYwYvmJeKG2qEXy1dS7L6vGfmQRTA8UxSTNKK/UCjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOcKZmWl/BYS9pdfCKorzAgRXPEmbNo80bHwNysIBGI=;
 b=V5jB+4TrjI/2oVG+jUz0JDQXAEnL1VeC9PtlVICQzqgdwk9H/MK14QzjZUkWWnC4SwVgtGSKSxDjynl/zmni6d3dIE5nXbomGRcWp2OYEyYa3o4jjcRyjKN51bn0hzOKspc7LV9KbCRWe0cqtXAn/lsBvg4rY0IX6AMwqEgPoA0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 17:38:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 17:38:45 +0000
Date:   Mon, 17 Oct 2022 10:38:41 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Observed memory leak in hugetlb_reserve_pages
Message-ID: <Y02TIcPTBcQPmk5J@monkey>
References: <CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:303:8d::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dd9658-94e1-47ee-8ba5-08dab066700f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uS3mtyeeujk7nPDlUnE9MlBvIGGHBiEDm9NijS96IQacopzyWYp2CVjzVmFkNzCwY1tdBFOwWzmo7h2djs5evAwIIdWiG7wXr3dHf9NcUnL7XtsyaEOlPnvwTNcbDrED4IIkYQGrUYmh6z1+6FaDhkKsDcHRYBhIBSVlGR0pcguNDHC05I8BFyskNCl43TOkNgTDNLWZEYMMCClImJgHdDp2jmu1o7gm6gHiHh1xWGHesvB/EO90HV7xMEsnfroXpt5aMsGC6i+m2ACTVU7g/clwZluGtqe+yuVWl7tg/GukSJa+zGqyUsj5JOOuAtJoDkgdD9xOb4PVsshS/gm0AlvmX2sxIA6udqZwPk4WArnJoeoZTtH6L0q1HlTh+sU+ps5MTBkFd/wTmRM+x3GjY9wUllamDak7+pg+MnoX++2+1mlEmqDjXNxErr4rZUsjzN/+FuHPucreOb07X59znBPmdPytSyhPQs8ilhHuiu5a689T9cVRXTK79LJHMwnwnYpPR5A7d0+ZZKGi43/R6NM2CFHjCEY0Xmxvygxzu8n3GfL3bn2wbscPozC5XrHjUVxQYc8e+g5aRtUNi6QIswkDlGHpN7o5LOH+kFKHPjGqY8EQ35pYDt3SBoR+sl6w3Obl8oqgQosFKteMLohYYskUxXZybFVBgiVwVMjkxkfkI+dbai6bxb/eJNLBoodn/c3Uq/wz8EHRKn6CPdVNtN9+mPbyuwNi0FZyOOuyua8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(6916009)(186003)(83380400001)(86362001)(38100700002)(5660300002)(2906002)(44832011)(41300700001)(4326008)(33716001)(8936002)(8676002)(6666004)(478600001)(6512007)(966005)(6506007)(26005)(316002)(53546011)(66946007)(66476007)(66556008)(9686003)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLZscdFmN+yJOPGeMVhaFRxJpdVHVBWd09nFP+FFITO/t0BYkVqysytDFp+Z?=
 =?us-ascii?Q?QnZSsk7v2ffzjRls24RC/EnoZ7SOlj+exY/Qris/eosoJhE1d15WPptaDHzX?=
 =?us-ascii?Q?ahnM6cYOcydD3aPuyJ/eQinUJKelKJnWJLgwiuG50AgkeqQtRZp1Xg2JQrl4?=
 =?us-ascii?Q?44lp5ufrzdTfN5kSKp0WX0cULLBhBXw+i/l3ddY2R7KAoLMMZUnuEPatGxST?=
 =?us-ascii?Q?mlVcRMjOCe+kiX5nYrSOnUIoYSoFHZAHZu7O3nw3CJKyDU8OYubXRN1l8ZQX?=
 =?us-ascii?Q?3kDnVXO3beUo2dWCQqk2p5p2gu1J3yJktNA2qbIgsP9oq0zK9Ki709DX6PjL?=
 =?us-ascii?Q?kzxA616Lm9xGv1GXoXQ2O6rT2hiAfC+Mnhomyb7gTfch3CtS0NVxBuW+TFUb?=
 =?us-ascii?Q?BVcx95R5Q/OptYB8j/S9kKPjPuMpPMZr1aynKsau8cvphdMENY+jU0CtNXCv?=
 =?us-ascii?Q?o6HUsek8XNaZSH8ZZ3i6hbds4SOGLsY/CoEVdZEYnpdiXJcq6LQNy+73JE8w?=
 =?us-ascii?Q?ga75G+oePyIgMPJRq0Y95Z7rhbelNVIfVQBhHmll79lLQTGCySgkUY8nHr3+?=
 =?us-ascii?Q?b6iiP8hHQ9fflK3c8DzsszqDLI6HkQHd0sSmrYvmFzfDfmwF3ULhPLT4YXOV?=
 =?us-ascii?Q?/7XIbMFJAQFmv4nTvbEYGWf+1fG4HK45wKS/N8oEYV9F8obdw4gxE21dkH4k?=
 =?us-ascii?Q?eCMcU6Z+Qs9vCHddpTWY1G6eTdsUbx+jNDmMBN9DowP+fJKOQYt6ksZWf44Q?=
 =?us-ascii?Q?r1ka7T7plk0ajCGWZZ5pwUUH/OmZbMSh4hvOP7nevMKLeSIMLJxeXjVEdDbq?=
 =?us-ascii?Q?KdjxeuhcwpuPTyDOXqSwWUVjYYcXMrZHwSutR/sVQikyWfu84LdWNnVYlP89?=
 =?us-ascii?Q?mP20dWyHXH9+RbEZ629BN1sXo8/evFhUdqaZB3UUk18PB/NvccccqPdbGjH2?=
 =?us-ascii?Q?7pEPDZOtduCxkBidpE+SZW+uNBHEtAzq4jsRwTqVo3Uus/m3lUTtBttrkDGC?=
 =?us-ascii?Q?t728CPVK2Rz23nNYdt+g3fW5bvtbsUgx3JMePDLi+oWBnnP/7/iuLs2aSLCo?=
 =?us-ascii?Q?R3dp/IkcmY3X3tUnKBll+CCscLGZSaUyoCpY8Z4U/TmZ+0RFah4jixlwkdYi?=
 =?us-ascii?Q?DBR7FVm0TyUvlGDXMERWrWWFCfRnbWXjKTkZ520fYxJhT54M3XASk03azCRl?=
 =?us-ascii?Q?/OfO83RzJjadnMSQheIQyVLsIl2rzbGV2m6YD7Roiy2QD0Bo/r75umhOxPnr?=
 =?us-ascii?Q?p5Dy/vLH/i1n+mqdbr1+GPvwbFT2PE0pEhmC5p19eBICpeLv3EbPh5gjM1VP?=
 =?us-ascii?Q?qwK1bgDKXeEPEzkySgncp0jNM+qzXYNp8xFoA/Cp+/zE8kOy4OQskD81Rlif?=
 =?us-ascii?Q?OAqx4Bw5rTfCcrknt6r4UBjWehm04n/4jEMM8hK0obm+VCK0FuqgUbjHE8Q5?=
 =?us-ascii?Q?GMHULC4NobyHhQxzm6erpvSDyBt1fTxS2t6+g8puQjYU1ggjG4JxQxAOWs0K?=
 =?us-ascii?Q?fyaYyIM4geCkcOZlRyut99J0W51ojpycxNlequWAKvyCHguTeYHbDEsfuSiz?=
 =?us-ascii?Q?sdSc71GK1oPtcJH8yu2Ra8bxPlLYdwgqpDnHXk9lMW4qhouf4i8yYtNXTFCV?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd9658-94e1-47ee-8ba5-08dab066700f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 17:38:45.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNnX5CA16n5TJpLmCs0QF895MxQ4AJUjzx7yqclReOVFeVLR1PxBmDwweuDZKEJAwiNysw1JAOt6VOGeESS3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=626
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170101
X-Proofpoint-ORIG-GUID: RbJ0-hPU-1e0rO4VKYJE9DZ5ZEwycpXD
X-Proofpoint-GUID: RbJ0-hPU-1e0rO4VKYJE9DZ5ZEwycpXD
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 13:11, Lukas Bulwahn wrote:
> Dear Mike,
> 
> The reproducer for the 'memory leak in hugetlb_reserve_pages' bug (see
> https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3469603f4a0da86b581cc979bd6c6663b46ceb1b)
> is reproducible, it is triggering the memory leak on the current
> mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
> build config is a x86_64 defconfig with some syzkaller-recommended
> debug options.

Thank you Lukas!

The leak is embarrassingly obvious.  Here is a bit of code at the beginning of
hugetlb_reserve_pages:

	/*
	 * vma specific semaphore used for pmd sharing synchronization
	 */
	hugetlb_vma_lock_alloc(vma);

	/*
	 * Only apply hugepage reservation if asked. At fault time, an
	 * attempt will be made for VM_NORESERVE to allocate a page
	 * without using reserves
	 */
	if (vm_flags & VM_NORESERVE)
		return true;

There needs to be a hugetlb_vma_lock_free(vma) call before that return.

I will do some testing and send a patch.  However, I will use commit
8d9bfb2608145 in the Fixes: tag.  This is because that commit added the
call to hugetlb_vma_lock_alloc in hugetlb_reserve_pages without the
hugetlb_vma_lock_free in the VM_NORESERVE return.

> My git bisection showed that the first bad commit is
> [bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69] hugetlb: allocate vma lock
> for all sharable vmas.

The reason your bisect pointed to bbff39cc6cbc is because the mmap/vma size in
the test case is not sufficient for pmd sharing.  Therefore, the test did not
experience a leak until the patch which allocates the vma lock for ALL vmas
was added.
-- 
Mike Kravetz
