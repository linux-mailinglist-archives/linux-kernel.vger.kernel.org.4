Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC2604FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJSS4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJSSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:55:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91272963
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:55:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIOuj5007508;
        Wed, 19 Oct 2022 18:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=S7z1MLafBaR6Lce+OFEkEsYYxW/Cye6yfI3t5UDuHHo=;
 b=WDghLoUGe3d2Zd3Bbj4cEe3BeYb/CiZmStlfBYeoBdLyssY68w+KRhsFdJ4IlPk1d0qW
 eEzNOyaO1mRm7NoSB1LAdP/XUiiPPPYF/QNlmnDvN4oKkAtHCp/mfVlyQdmxhxiMUkbk
 cm/BZKBiPprio6DeCS2TMOxfUhyTDC6dCq7p9iq9pw6X2y8/wKXRFzD4jl7AN6a6u8Hq
 1w/vs09/qSlSawJyYwD/5HW5HPoF570oNEn6a2EN+QRH2kP8RXK7VR1nA6U99yYskWrj
 6bK5F0B9xUXXYM64hdpFkThzGE529ceyqkECi74VLM7aOZbkQ93UgiMdrNPXqR26Mq3K FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww6gun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 18:55:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo63N014080;
        Wed, 19 Oct 2022 18:55:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu944qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 18:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgxPPh6TB8zL5lW5jVV40UikErr/O3LFbvqvGXIrPUC+olS2fnZTQw5TWkBRFtO9ZJJGYd8NSoya7GiadPTuEgEps8jFoBlT+i92w7fbd3HqaN9bGB0WASusRT6PWFWvOwUEH4mKUPDxNQcJUVe5Gnk3YYaRo1ub8bdHmr4ttbzMYV84mvSe3ZFONiUoZOtfu0DyDxZ81azhcbXUdjxxXJcBaiZKBQwFpubM4NdkcJpi3+guFfhvDIpTE7xHLQKs5fygGmIU4e5N2q8t1I8IgqfMNwHsG7vtWqP58ikR3xC8qLA3K9rYIRhGicIMebguJ5pK9N+N6tc42Zz+FSAnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7z1MLafBaR6Lce+OFEkEsYYxW/Cye6yfI3t5UDuHHo=;
 b=C0zucsX4MzmNIZMiE+Esds1KjQc7yO7+33dd/JPOZKaDCT+vOdVrIOmNMGYZPngWLAaTG0xl/pmbIFldWia2L/OO3+o5eABwykkAQBfvWG1QRTnmHKTArpYpuMicOj5ZQB70AaomrG0zYsoYyKfLfaNGwNT1KI87zbrf90lEHSd4vR6+88W0TAKTe7+mKngpvZEYAPM2Ex9ct8Pvt1mQE1DvVDIlHXnyUxFIVJHpz+jKIovrDx4F5yI+T9SZF10mB1rmodSZxNUf3qCQ4GTt9UaM7uCj+x1DNdy+P4oGy/DVMbD2KTUQvDVoqIV+ctvS8p3Wmc3OMBuUDIli9x7iTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7z1MLafBaR6Lce+OFEkEsYYxW/Cye6yfI3t5UDuHHo=;
 b=XIW2S+Gwh1k0JEprKQskWVIjeCpKfowTgp4TZ2tANw/2d+Wq3BfinML6Vc0YITo7cIitId3aMR0IWvgiRz8XO1uh/QziCmoszcZoqO84QGSYF1hu44aBr0o2bdW+XcGHo3cdqJ+sFpoGlD4IoYte8vL7EacOUWQJmKJK4oBWThQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4403.namprd10.prod.outlook.com (2603:10b6:303:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 18:55:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 18:55:40 +0000
Date:   Wed, 19 Oct 2022 11:55:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
Message-ID: <Y1BIHxIbVIc18zBj@monkey>
References: <20221018200125.848471-1-jthoughton@google.com>
 <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 751a24bc-5eb4-4a61-f34c-08dab20384af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JqfNQgY5PU5rbTunKw/bEWTM02eRvlrDnH8ZVGzoyHILVbt70zWxbCg9bRXNgdTCzTZVZNYcCJEjI0FTREoPcbMQp1aMoEn758xxYo4fBxX6eQwKSany6tsKLvYnyqEEoboaS8DgtViRj3xekq+azXW62E2ajwYBBwqEZHuj6oB/tV2DDKpObuHaVhMBhvDtl4y0lCdUw++VipwLw39CudKkN815OKEh8iY851yL+R9J7xpGuSJ3Iqe7oSXUFLZdd4y8nBCitc+MncgfesaCKyQtFVJaXmecKUFRhRehjfW3iwFM7e/E1l4AkIEyK0IR/rHUiC+lp0vV0KUO2FzqUAPmtZE91Yha1T1/JyyBPhwdRJroaQ3ZSLFcFQTQKIVbP0FxsdE+gakG2/+Y81xllbKdJt6q1XjIpXGAW60bIPYYdHWi2Om4Qt7c6Z5CzTHpURX3uDlYw9UTVpQ6FAgWm85R1Vur+USqpgEgoa0G6EuyftXmM7agNqCGkR8RHV/tV6xoixfYPfwcvByqSDI8oi/tzULfPREetgX2u79PjfPgaXVCPswaYvQjg9DInoDJnODSFd9q3FOSUI6aklhPcxR5EGtkbUjfgD1dsNSPdkAp1ejKThPWnRUbj2pwAz3BuVksFwWPcjbYJaW1S4CS9v2TKVISb7jtj6uNdkwYqZefuUTXVMKLQbg1wszTOIKhJgOnmMsYOX/Qj4wts8WXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(44832011)(6916009)(54906003)(66556008)(8676002)(4326008)(66946007)(66476007)(86362001)(83380400001)(41300700001)(6512007)(6506007)(9686003)(26005)(53546011)(5660300002)(316002)(8936002)(6666004)(38100700002)(6486002)(33716001)(2906002)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVxzIUml36Trs7fJrtSa7g6uLBKMUfGGqhCx+q81IJLMpW9dkq3aSf3OoCRr?=
 =?us-ascii?Q?0yC9tFk0HCllUB2iaw4Nw7unUW5gjIM3qKMWy20BJ6o6Q95FM1QImKa0RsSI?=
 =?us-ascii?Q?IGpLF44iAuOHoe2j1j8ac0+jh+grv6a0b+Yd8+A912MEuRXLOnAuEQPFqfUr?=
 =?us-ascii?Q?VlpAr6UbPwdqb20ZjUZvvQ7delj6x2N3PxRk7ixSEi9WzKpAE0SgaUd9NuQ7?=
 =?us-ascii?Q?1Wpkb1bQYUuj41P9Z/9nrqH4XswkLbHpGaGSvXnm1dnx24SayZSJAbtwsMcm?=
 =?us-ascii?Q?YSacZjGbKyzbd41AhZYhsorQHPROXwvuhUiVVGYiumFq9ddW+ypEbHJl3TyQ?=
 =?us-ascii?Q?gSfC14p5LmRFlQtNnbR0dfVLMqqUB4glRKxDrXEheiwA2c/lG9kJp9niru6g?=
 =?us-ascii?Q?GDPCi3FYuCtj7PWQJG7bvI8vG8dlPQiWMwIpvyVVe6KDdacRNKH0STwkvvuu?=
 =?us-ascii?Q?1mCOKMAjgdgZ4DsFJhSkWBFR9zPE5wDxGQjCh8C1hiE86MbCOfJxG4QqHLzd?=
 =?us-ascii?Q?A+A2aJQPSgoes6MnCKsaqyLEkcq0JVOCkTZI/M+RPDTb6K0wehEKna+b6K2R?=
 =?us-ascii?Q?ocpv56sqrb0CJ2VOzb2iGR3ZsQ3KcuVKrKlwf+2sxtHSDE5KqF0kiqzGmUmP?=
 =?us-ascii?Q?YBuRLodhyF9eL5R1SWuHVRFDpUqJAEoVsdA+p/W/z2bFjh2hpnb6aHzWotLM?=
 =?us-ascii?Q?j+0CWNYC7CFfsU7Tw7FMYU2XqF0JMQ6YVZcNVvULF6npg4UkrqjMp60jAvet?=
 =?us-ascii?Q?b8NkZIDo/qrZNsKIBSyDQ/YzsfgSKeKzmUfP1e2qvw/hZOSbIV1jPi/I3c31?=
 =?us-ascii?Q?h9+pRJTAxdxJcTsvtHSP9/wOb9vFkeQAvDJS9F556XPNN1qBGKD6WnnM/Vc9?=
 =?us-ascii?Q?AQsZRdFG7TDH6u+Kl+lzMhx5fP/pF5rHRzDEz5Obj+eIXrjewFGfPcHlVgQ1?=
 =?us-ascii?Q?tF//1FS04bFsVFC7DegO7YFk8MSAPBlDRres7lFi9I3WpinUviI1nKz7G2iK?=
 =?us-ascii?Q?eHLJ5AJkFWG/E5PY5hUqS+jm6edezsk4wKTbbchL/HA2pC9gFhmpdMs8K3h2?=
 =?us-ascii?Q?fUS5LgvM23g26ORNQGr63C2TZuhnPQkDSX2+UvLLMvXkvZ359ZVT90IsSxGQ?=
 =?us-ascii?Q?mxmlK19gjaajw0yGr5FH6BZsEryTdZrn2w2x84azs8EIxhnZFV30ZVntuhYc?=
 =?us-ascii?Q?4UZhPOkzF2KnYJ989zaLBNFnms5KvirjbzqX4MfjwxmC45EuW2LWmiZ7Nc3R?=
 =?us-ascii?Q?cKsXHqtSFV918plFAU1IVZ6a4qs7lX3rGDXI8j3nmoJHPBWxUKKqQhwecmVp?=
 =?us-ascii?Q?W31iYdHYcfoQtnwCeWVPx0AheOvpvFc5STaiaCIOtUgfu6JcO/9T0X5gosdo?=
 =?us-ascii?Q?Xbu0LynvxB2SWhO4BtBjO6qCPFHJYj8xbwgfx9FE55FsZtLNKThb7CBR/AGE?=
 =?us-ascii?Q?ghZbWccSVxB4gA8UfDup5ZiyStEL1GKhA/GVI1MFOlkekn5wDOtoVm5rhNWL?=
 =?us-ascii?Q?H5XauynCF5OTBNl/ei+GOGHT9CedrUzmQnuJy4E9HJgG/BguGDz50efmnp8x?=
 =?us-ascii?Q?qHkYkccsfdTc3XU7I0OwxY6ojFjDRhZm0hJy4UwzN5zGqTOUc8H2gL7wWbAb?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751a24bc-5eb4-4a61-f34c-08dab20384af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 18:55:40.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COwMd5tMj4FP7OIcR9yhtOj4xHpM3wj2nQbRhJk3N+hN5xs9zPF97eR/U7M1PSlpZbofXXyEflnxtpav5HiIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=927 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190107
X-Proofpoint-GUID: ehuT1P17etg4w_LaoE_0FyS5gpY64qsM
X-Proofpoint-ORIG-GUID: ehuT1P17etg4w_LaoE_0FyS5gpY64qsM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 11:31, Yang Shi wrote:
> On Tue, Oct 18, 2022 at 1:01 PM James Houghton <jthoughton@google.com> wrote:
> >
> > This change is very similar to the change that was made for shmem [1],
> > and it solves the same problem but for HugeTLBFS instead.
> >
> > Currently, when poison is found in a HugeTLB page, the page is removed
> > from the page cache. That means that attempting to map or read that
> > hugepage in the future will result in a new hugepage being allocated
> > instead of notifying the user that the page was poisoned. As [1] states,
> > this is effectively memory corruption.
> >
> > The fix is to leave the page in the page cache. If the user attempts to
> > use a poisoned HugeTLB page with a syscall, the syscall will fail with
> > EIO, the same error code that shmem uses. For attempts to map the page,
> > the thread will get a BUS_MCEERR_AR SIGBUS.
> >
> > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> 
> Thanks for the patch. Yes, we should do the same thing for hugetlbfs.
> When I was working on shmem I did look into hugetlbfs too. But the
> problem is we actually make the whole hugetlb page unavailable even
> though just one 4K sub page is hwpoisoned. It may be fine to 2M
> hugetlb page, but a lot of memory may be a huge waste for 1G hugetlb
> page, particular for the page fault path.

One thing that complicated this a bit is the vmemmap optimizations for
hugetlb.  However, I believe Naoya may have addressed this recently.

> So I discussed this with Mike offline last year, and I was told Google
> was working on PTE mapped hugetlb page. That should be able to solve
> the problem. And we'd like to have the high-granularity hugetlb
> mapping support as the predecessor.

Yes, I went back in my notes and noticed it had been one year.  No offense
intended to James and his great work on HGM.  However, in hindsight we should
have fixed this in some way without waiting for a HGM based.

> There were some other details, but I can't remember all of them, I
> have to refresh my memory by rereading the email discussions...

I think the complicating factor was vmemmap optimization.  As mentioned
above, this may have already been addressed by Naoya in patches to
indicate which sub-page(s) had the actual error.

As Yang Shi notes, this patch makes the entire hugetlb page inaccessible.
With some work, we could allow reads to everything but the sub-page with
error.  However, this should be much easier with HGM.  And, we could
potentially even do page faults everywhere but the sub-page with error.

I still think it may be better to wait for HGM instead of trying to do
read access to all but sub-page with error now.  But, entirely open to
other opinions.

I plan to do a review of this patch a little later.
-- 
Mike Kravetz
