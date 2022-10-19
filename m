Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613BB6050EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJST6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiJST6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:58:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76791D8189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:58:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIP6Hj011661;
        Wed, 19 Oct 2022 19:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uG8wIJJM6/NQY3pnnmA5k7cgSc4DGPUpbUr8Fu9iavA=;
 b=UZtGM77/AbeD+eF/wpa7NE/ANEAyxDFn0hdwIN1CapzFG9z8SGOLAhxmkfXHxj00nUn0
 N24oC9SJhnmORWGr7EIAYp7W5dy2/6ZSS0cXi7NgWpLXvTu6rME2ONkye2oC8NDYWisb
 2pLtDhL7VNlb4vCnALrrTgOyhFlO5I7ShVDyeHLx14CM/Ns7WjX4jlDA2puAlA2s9bH3
 3u8wn9S1wGowsQXawnysBxDYGWQw+dTCuK5AS7NpLvsRDjdoWI7ujYQYNkEY+ZavrdJt
 9/7ICu9X7Pyj3rj1rS2uXeD4OWkXwUAGzhE9Nd7WJ0jGXj/528Spo7ld1E9+iV6PU7c0 zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtkq7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:58:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo6ZQ002765;
        Wed, 19 Oct 2022 19:58:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hthw041-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF5AIIuRSAH8b738dzA0BdpaHOqjxrV2HRnNr6OJceoGpr1kur+bygye8M/9jwwMo5cqttrwAqBYXdf/4tB7IADhO5wE9nr4nXdC7NmgKJmu8sFxrhR+fnQVvf9vkIyFm5zO9Pvo71Tywnf2bXvmuAEyljvS19nKdXpWB5hPhs2xb6VbV0kLudeeu3th30MuJXi6aKBXQlhffHODdpJdEfFvGR6DVQa+wAnvvCWCWOqRxWpgiT1Up4GUh1VZzB+DuqpMOveRG/Ii7BVkcD5cOrBbOPNQxVA1zLHz2VZ7m9Gi0+UtOnJ+uboixOMD1J3M8TzNNHh0kLIn3TVvl8MW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG8wIJJM6/NQY3pnnmA5k7cgSc4DGPUpbUr8Fu9iavA=;
 b=aRw4clxyCQtWq5VbbO7qcm6oeKMw2n+OEXE+2RQNv8CbkWWsGzJaTVgxPgJscJjsGnqppUbSrw6j6Ip/X2tst0ByUcVHI/gS5ssvy/dVPlAkmBJXdk3d0VoLUrMH6wvQ/RzPGRuy7fhAX/liNTZ8fzOmV96uRNDw9jlij4D+l4Xp5vlh/LLVuEsTiUwTcSMZT2ybiDP5nlBfrco23j8J+8JH6x+YGhjYhvBtbzm+6wsKFD2+icoUyQaBM6Q01Z5sSCDcD7zmc3Z68IJSiYk7d2yJTWKxb/1NYUAknQ2WiOSAKcHbiDPJHNPBG6g6Xva8c76Z9pdiRw7HBCXw+LrqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG8wIJJM6/NQY3pnnmA5k7cgSc4DGPUpbUr8Fu9iavA=;
 b=KXCEO7qhRq98zM9W2oHvxddTyYgroP6z9Jzrt1MmVvSAupIrCWbPoRxIQwcxdTwQxICVv7H1oZ7W5lhaNjsjlkqJkt/gOar67woNKeP0AXyw4gYMz4RuAaUxyYUqysMYJ5pSd2AFpcjv1+nZscpB5ZHcd628ybqiCS8S2qih9us=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 19:58:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 19:58:01 +0000
Date:   Wed, 19 Oct 2022 12:57:58 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH] hugetlb: fix memory leak associated with vma_lock
 structure
Message-ID: <Y1BWxqEntgajs5Dx@monkey>
References: <20221018233601.282381-1-mike.kravetz@oracle.com>
 <15890189-c3ba-4249-3c2f-674f6763415b@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15890189-c3ba-4249-3c2f-674f6763415b@huawei.com>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: d43be1d8-7cde-454e-a753-08dab20c3a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDKaKfveeD0C0oQiAefLJtzfxPV6awW0mXjK+hCpxP6zCuDtuvL4BZsKQomoeY0SzyOT25kn6nKG1Asb6xNJhqzctm59CSJyTYmauSsvWXqwCgLReptEh9HNIYjIV65+QQBGijDVzjE9g+8W8MK2yUHmPP6ySr1mUXJLFjC9sDvAkiXn9xd4QmRaMgdeXJzAsmtUU/4oGZcbZwEMKOTvbOkEiLxjbJ+3XZ8CHkcKdIN5EabvAtz90Pm0vYjlQUVQ0z0Z5h6Q5LeGZKuKmSROHiVRr2cDqN6t5lJYssY4gKE5XOM/8EbNbmFBQD74vaZLa/142pYE1mlslPxHwZtBJlG9dpepjhY91LjErZNS826e5WKtCU94ya1W8gyeqSwqbNuAliUvoB74v/wgOnPzXUqgwIXEriqJ36L5Ob6kIVzFH4H85tkTYq+q1+gleQH1NKzntxgNCSG4XHMu86u3cvzmX8XuPx5vGX+ylvxsBRDAizQzrSF2AedNtqSZ9LGxJSYbhagggXAgLf3/o4xFcklPJS+kwBHY4Zj6WOolinsfeldL5opPziTSrK5gdoIDp5/9yDwZILgetbEGmZSXx3KP/tz0kPhYaejVBudEo31qfko2QJFlllCsVqKPP/dii09lVxJtXZSjan+wsYzu2XmuA2XIauU0cuKCOSAR0MmQM68rXvtrgoq/CG5KiW5uQT9BJdcaI/Fa5z5z/b+FJRPkhzOT3dv1vepS6OomiBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(478600001)(66899015)(83380400001)(86362001)(6486002)(966005)(66476007)(66556008)(53546011)(6666004)(8676002)(6506007)(316002)(41300700001)(26005)(9686003)(6512007)(8936002)(44832011)(6916009)(4326008)(7416002)(54906003)(5660300002)(2906002)(186003)(66946007)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09jaNeoXrEOhjQHzM2IcrIRd5FL7oWZ1KVqb3Ykzc8dEn4I9svdsT0eQfpwR?=
 =?us-ascii?Q?faSlQkmAmPXwNJDBT/eJ7RW/fi+RuTIEBV79ZBrB/pu4KHANb1FmNpSjLSwZ?=
 =?us-ascii?Q?DvDLxJFJ47aI8bW953CvQZJiV/cYeZY05SBIsbYLZ5d6HudZHA20avMi6wDh?=
 =?us-ascii?Q?0XffXVnIfAqMpQBvGcGm+JaYaYlmgw8qNMakKFKjYgwnv7amerHMwNGtfUDc?=
 =?us-ascii?Q?wZAGNooqruYCpaSja0CLSeLi6Q185NYT8dqtkYLvzkP4fjMLl4oSGp6Aca+R?=
 =?us-ascii?Q?W4yibziP3shULb9gP0SRBjEuKuHy4yXhsp0kiOU9KURFVxTKOAeU9rKjHMIK?=
 =?us-ascii?Q?saR/QqYC3XCr0Zyt3GyFf2lqcT0Fv61glllaMbdCsmdj+y2frIN/uhRWrZK7?=
 =?us-ascii?Q?hBwGYuWTK11MitDydI8eWwjgMq0fFGWQ7ITwTpus3QLH/jZw6Zf3F9noVuc8?=
 =?us-ascii?Q?ihm3vc3C115qv0OrkdmVDZNpwiClW9cAZ0M7da5EXHanXePGzzTEg8aVhgpI?=
 =?us-ascii?Q?2Dpi1xXrGdNejn5ylPWVsa4BjpVB5cqL4IivNjunLv4b1J9wfgwhTMxtg2OA?=
 =?us-ascii?Q?yjomqWB1+VnFgaXmKAdGupGSIpl94eVZKdIwPCQN3vWw4Rr/peB6Aq8RarxM?=
 =?us-ascii?Q?/uIDHsEIVf3CdR16iqOEdmCbvKlKNjAYvllgkZcFSTqVxVGIEC1d1EuEJCfN?=
 =?us-ascii?Q?YARcKoBwlvP8iPxr/ZPugcUppb/oXHGdGPHbAHo88SMPyRswR7LUNOBsKijN?=
 =?us-ascii?Q?KJt79Xid6JfbDOwnoNM7oOX4x5apVlFS8D08pSx/20Nub5gl9dLhDQvCwBKC?=
 =?us-ascii?Q?Sv5AgftBwG6fmcMhLXkGF+gDXvAoGEhGZSFRUWi0B2J0/s0I0ONz7xVVUYvy?=
 =?us-ascii?Q?/R+Cb5f5VEHrL+rJ1PTfIVn2Q4vwM5hnyu5WAPRxTnB2VXt5HseWqWbkTxMX?=
 =?us-ascii?Q?WDxwmGNlr9vRxQhFGOrowYYjtwobrEbSefllODPux+1mEbUXXNpWhW0t51Dn?=
 =?us-ascii?Q?TAOvexLNMkLTTWV6tEp2DBRDzq+hIjP2XOSOXGA1yqNE7eUEhwNll7zPvEz6?=
 =?us-ascii?Q?xtM/9teKvXfLG/d8S9BFS1TTEfkfIYaDe+1LYZvTJAS6jhEEHztqWr2cDw/N?=
 =?us-ascii?Q?SMnvYVTFeTX60FqmgyTajoLqf/93Uein1unDR3YsrpcubOg4PByUzkyJUQou?=
 =?us-ascii?Q?u6kr25b0dgYlw1g8soRwquAV0tzTHfr3yr8raNbOw57L/InTME8EekzON6qu?=
 =?us-ascii?Q?EnbMKs9EfNCkrTBWC4zWhsu6lLdCWrz+Ou4h1HEINGfmY9ZTcm9pOE3SAr6V?=
 =?us-ascii?Q?HkBlBcZA6XezID18Dln34q6LitNo7/CzZpO+woDlQHtcZC0Ty7D/SwrvbMUS?=
 =?us-ascii?Q?w82kljH1FM3yi5mN8o24MD4CWUjiu8MtA1Jjb2GbBgPFA0FhHvd8SOs/jMKg?=
 =?us-ascii?Q?Q5arAHYStzcoSdP13xGMSf0uppnxvfQz/FuEKmXFZir9eL41JQpHPbnkUtzE?=
 =?us-ascii?Q?c4kwqWJazMeVnlDWwFlpjO4eZR4PD9Bslmb/8khl9YaGJ3LvNco1jJwqPMjB?=
 =?us-ascii?Q?ducyXRwGRSBg89kgY4Za4w5DeFvJiTWX+GKC7cspdCFodnfZJOJ5VVwulZh5?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43be1d8-7cde-454e-a753-08dab20c3a3e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 19:58:01.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8O3rpE32DlHFKRn9wSP4VQ87CR8ApKPVaralRQi/+l333scMS8W1J2cn7GsF/bfRPdtXxeNDXpv4dulYNubWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190111
X-Proofpoint-ORIG-GUID: GbkfN2U4uy-TeWEOwgthSi60rF5rZe9S
X-Proofpoint-GUID: GbkfN2U4uy-TeWEOwgthSi60rF5rZe9S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 16:16, Miaohe Lin wrote:
> On 2022/10/19 7:36, Mike Kravetz wrote:
> > The hugetlb vma_lock structure hangs off the vm_private_data pointer
> > of sharable hugetlb vmas.  The structure is vma specific and can not
> > be shared between vmas.  At fork and various other times, vmas are
> > duplicated via vm_area_dup().  When this happens, the pointer in the
> > newly created vma must be cleared and the structure reallocated.  Two
> > hugetlb specific routines deal with this hugetlb_dup_vma_private and
> > hugetlb_vm_op_open.  Both routines are called for newly created vmas.
> > hugetlb_dup_vma_private would always clear the pointer and
> > hugetlb_vm_op_open would allocate the new vms_lock structure.  This did
> > not work in the case of this calling sequence pointed out in [1].
> >   move_vma
> >     copy_vma
> >       new_vma = vm_area_dup(vma);
> >       new_vma->vm_ops->open(new_vma); --> new_vma has its own vma lock.
> >     is_vm_hugetlb_page(vma)
> >       clear_vma_resv_huge_pages
> >         hugetlb_dup_vma_private --> vma->vm_private_data is set to NULL
> > When clearing hugetlb_dup_vma_private we actually leak the associated
> > vma_lock structure.
> > 
> > The vma_lock structure contains a pointer to the associated vma.  This
> > information can be used in hugetlb_dup_vma_private and hugetlb_vm_op_open
> > to ensure we only clear the vm_private_data of newly created (copied)
> > vmas.  In such cases, the vma->vma_lock->vma field will not point to the
> > vma.
> > 
> > Update hugetlb_dup_vma_private and hugetlb_vm_op_open to not clear
> > vm_private_data if vma->vma_lock->vma == vma.  Also, log a warning if
> > hugetlb_vm_op_open ever encounters the case where vma_lock has already
> > been correctly allocated for the vma.
> > 
> > [1] https://lore.kernel.org/linux-mm/5154292a-4c55-28cd-0935-82441e512fc3@huawei.com/
> > 
> > Fixes: 131a79b474e9 ("hugetlb: fix vma lock handling during split vma and range unmapping")
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 02f781624fce..7f74cbff6619 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1014,15 +1014,23 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
> >  	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
> >  	/*
> >  	 * Clear vm_private_data
> > +	 * - For shared mappings this is a per-vma semaphore that may be
> > +	 *   allocated in a subsequent call to hugetlb_vm_op_open.
> > +	 *   Before clearing, make sure pointer is not associated with vma
> > +	 *   as this will leak the structure.  This is the case when called
> > +	 *   via clear_vma_resv_huge_pages() and hugetlb_vm_op_open has already
> > +	 *   been called to allocate a new structure.
> >  	 * - For MAP_PRIVATE mappings, this is the reserve map which does
> >  	 *   not apply to children.  Faults generated by the children are
> >  	 *   not guaranteed to succeed, even if read-only.
> > -	 * - For shared mappings this is a per-vma semaphore that may be
> > -	 *   allocated in a subsequent call to hugetlb_vm_op_open.
> >  	 */
> > -	vma->vm_private_data = (void *)0;
> > -	if (!(vma->vm_flags & VM_MAYSHARE))
> > -		return;
> > +	if (vma->vm_flags & VM_MAYSHARE) {
> > +		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> > +
> > +		if (vma_lock && vma_lock->vma != vma)
> > +			vma->vm_private_data = NULL;
> > +	} else
> > +		vma->vm_private_data = NULL;
> >  }
> >  
> >  /*
> > @@ -4601,6 +4609,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
> >  	struct resv_map *resv = vma_resv_map(vma);
> >  
> >  	/*
> > +	 * HPAGE_RESV_OWNER indicates a private mapping.
> >  	 * This new VMA should share its siblings reservation map if present.
> >  	 * The VMA will only ever have a valid reservation map pointer where
> >  	 * it is being copied for another still existing VMA.  As that VMA
> > @@ -4616,10 +4625,18 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
> >  	/*
> >  	 * vma_lock structure for sharable mappings is vma specific.
> >  	 * Clear old pointer (if copied via vm_area_dup) and create new.
> > +	 * Before clearing, make sure vma_lock is not for this vma.
> >  	 */
> >  	if (vma->vm_flags & VM_MAYSHARE) {
> > -		vma->vm_private_data = NULL;
> > -		hugetlb_vma_lock_alloc(vma);
> > +		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> > +
> > +		if (vma_lock) {
> 
> Thanks Mike. It seems the case of "vma_lock == NULL" is missed, i.e. if vma->vm_private_data == NULL,
> hugetlb_vm_op_open won't allocate a new vma lock?

Thank you so much!  Yes, you are correct.

Your review comments have prevented numerous bugs and led to better code.

I will send v2 shortly.
-- 
Mike Kravetz
