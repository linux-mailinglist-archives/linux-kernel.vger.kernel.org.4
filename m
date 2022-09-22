Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2855E6A61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiIVSGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiIVSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:06:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164510653B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:06:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGtdo0016487;
        Thu, 22 Sep 2022 18:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nU1P8eo5vMT2oGmNLmaTMAh+jrFrwjkEyV0Nf4cQFGI=;
 b=HmDafvG1pZxzjNIiA0A3Jj30q+k8Rfh+FteMYfCTkT/5SnQpKWStozS9n6qUQMKb/i71
 qk3a4ka/TKxj0hi2F9ZOXl44znqKt1wYu+1mZoK502vcxC6R3t9MbiuKshacm4bz3bxG
 WgKoF2sgJP8cN+3lATklLnsTKBV2BTBNaEweKllNZIUYbChbnhhkUL59GRYYPfnDXhse
 zgUgFdc05uLO4vOUo88cvnBmGbR+Aj5z10PSTRu7Cgqqj/3kXH0oOhClFv9NKAZdYjb8
 IcFa52CdfFKP3zp4jDzJH48Jq2QGtSALL2NHNFcBj2PNyRe8+Bg4yJNtfsGWQrwdn8Lu 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rp86y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 18:06:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGNM3N031270;
        Thu, 22 Sep 2022 18:06:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39nwqrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 18:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLI6X3kAdNAF5CdSw6acI9aKP9RdGv/l3mjR8PGrZ3wvHkBsz45s6+blCRBehZxsw7EZ25PJbX/6mBz8n5bEUWYZV9DC7O4kqrBRFyFd9JZdukwhAsuEk9hsSsenEwoz14Fp2gS+nnCqegMxuwOc90q6Pgos7YcroEzbovdoyFRIZbshrtmW9DvWgH2L5nWv3802VUH8qe/CA6pN3BtWvQ469Dalow06iu6w7CnKo4Iw4hbU+vAYci0vLbBy0fp9n8QmL6riw+NSmM4/ZQYhBvSTdQLaUmQsmsTCfm3c9kof8IfaXet0icmsH6rR0r26fJjuaMKaAkX+fHY8WcGMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU1P8eo5vMT2oGmNLmaTMAh+jrFrwjkEyV0Nf4cQFGI=;
 b=kmbfUkBpaeerTWyII5csazShopDwDB29LRRoQ4Eg6uw/KaT1cUBhTtfSXJjZU3r03bkTKBcQ4HkPu62J+TlHsTSPL9bZg/lkRgcukH9mZPEf5LZdFEyhJGvQs6APiLrtRv6wGSsDf5iUOVjU/0V224MYmXDxdxTvAxLTAB8Ey8YWVkd3YVEaC7/fzy/Nl6ue8GczjyRBtB3x2RH/TYAqWeJ+AHUQmBxSKd2Ae4R17Z7XLJrYX0nR3bYWR3bzje4ftdxyXyVzwgFmWQHoJgjPfY6oHtjjItr7wzlsEek4qSM7S6OA9ck1fSNqkdXRmCg8WqL8MNVAAj35aW/eV2CjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU1P8eo5vMT2oGmNLmaTMAh+jrFrwjkEyV0Nf4cQFGI=;
 b=yP4RBk3MhlTTV+sS7e8YDZx95zwjxGo6FBWV9mLjRXW2XRW1ZCjpHj7B19egPCWlEdDB0GLJ9erzqnQfhEQ/O/UagEEOGL6/B/EiuKa8F7DB6uZeScD1IwH8Nv9JhwyHi8uzzODDiihNh30li96Io9dIqnV8nBspK/lMfMOONaw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6671.namprd10.prod.outlook.com (2603:10b6:510:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 18:06:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 18:06:31 +0000
Date:   Thu, 22 Sep 2022 11:06:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-ID: <YyykI0d8D4pSh0C9@monkey>
References: <20220922141002.3242443-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922141002.3242443-1-liushixin2@huawei.com>
X-ClientProxiedBy: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 658c6738-8c2f-433a-6212-08da9cc52d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LActA55FAWV4Cq99s+A4X/1pW8afy2wP17cgakodGAEe5Kf978ek96j0ceT5dcsD/4+Zx3x+9WiNIjhYUBoDzvsQY4TSYJcYjp+GsmdVhgBh0UQQBvwook+Etsf9Fu9jw1qTyNSyk2ASXGZ5OSEXuX9h87XcAPxE9/JZiw9BHk0GwTUFz9V85Z4yScHYT0dVwlnyymSS3LgDV3frKya9qdGhFcBksNkjeC1Cgip1tfHjDPFVfDSExWaHyNHxOdSQw1DcgnsyZqCMdbZgVyyFUNXmgYM3YcvZ7PLSxYbSnHOScZvW7BAinqClmk5LcdVRS9LipIE4ui0UfySY3H1ijR1xt8sTeQ6+FGgc/Y+hgSPKvxLWVisyZLS7BEJHA+ABZkcfMNxkTmx2VIK6yRAoiw68EFQla5dMOfLVebpp27qVMsO0hgkUGHXhfjlLZeD98PTQLiMQK+D6GdgFRTZRYhtMUN9z3+uk1x5EzE9uB5uzbKjvvWLO7CK/IK0DSMdJPRUO6VP0iPWdvRLT9F3+bMI2GyFVCQRE/Hp9fWKrW0xwBm8NZl/QKmmaVZLdy1I7exc9AoXYCwhfOJ7midQ5I04XKDxKTgl/YlLw9bJyeaxXH0HAsEqpi4jI85SLyc1+2wlSqNNzkDwxFig8jyr89FXY/37uJHDaXGu8Uy5XTgyAgjSZ/XwXsvylXvka9Xv5S9jy7aC+WlikTO/OXnNQLuApKc8woAWNHV6/R+X+icxEAELbefPKwG/eD7KRrlujlzn2mFRoE96bOvGsjGCrXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(38100700002)(2906002)(8676002)(478600001)(966005)(6486002)(6916009)(54906003)(66946007)(66476007)(4326008)(5660300002)(44832011)(8936002)(316002)(66556008)(26005)(6512007)(9686003)(83380400001)(6506007)(6666004)(33716001)(186003)(41300700001)(53546011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xFq4Jpdulw9BZbusbnDE9LVLhlUjhX3W04NaMtqdH0SRBhauNTZoHZQuUem?=
 =?us-ascii?Q?hEBnvPDwJ2ffeWbVnXqKr17jFpsu5Wb+NF4RwHM7nYRtODzgtYffmU4O7rFW?=
 =?us-ascii?Q?ACtZZgifkuC/GHIGO/MZ2/a0RKdd8B0KRziIUDiypNpIxeAUgCoBtN8NdI6b?=
 =?us-ascii?Q?tlBzzL3MBo6dGg4G7svJQJRSaVJ8oVC+ujAVkx19WSQQGLXbbVsxD+EX3iel?=
 =?us-ascii?Q?I3vPkQWI5aUjTDK1Sg69dMPT1la8Ev5WPfehGg+JnR5b2srn2lyx4luCLLZc?=
 =?us-ascii?Q?PLsAS0FN7NMyD8D1/n+a4x+DSXpj+tUKtjFv5R860oTJyj/r+Ip98/8qlz71?=
 =?us-ascii?Q?3Z33gDxfEVml89W6irkfSbdcRpaeqGUZj8gQ0lJW4SLjI8t4emimo7KzMLnm?=
 =?us-ascii?Q?dtDJ1vwHQQmbjrY8WPuomJtMebgnjXDOdokuP0RuAhIjEZ+EOCsWcEHg2omK?=
 =?us-ascii?Q?YEFoFjciL0OzO6fTqguPwNFKoM2QyY4cU7Rr3YhUB4UuzT28xOkyJTlbPTjT?=
 =?us-ascii?Q?X1E12R7skJ7gwykS/1d7wElROs4rDDEHDZWVrsRUBLKOC1rYeLctb7wXmZe1?=
 =?us-ascii?Q?sTg2kL4sKdbGWTUdAKR1mKbmhiJyNH/uqfRMvRa3KDsBae1JhTI+0aBR2JR/?=
 =?us-ascii?Q?sPXCq7K7ukkZrE4mdvVapB6CShuIBGbIQEZaAk6RjqqzbYPpDdUxGO/SNMGx?=
 =?us-ascii?Q?zJPkTlSCMw1uZzbZr8+LLQYG8G9yQsEzIkMxmuKg3uhO0hmMvWRGekZ60PJf?=
 =?us-ascii?Q?JGuCj1uum2tG717Vb6T/x2Cis/U+Whs8CQ3jmTOn+6Es3tvXmbegtNLbwtOO?=
 =?us-ascii?Q?TXjxdqozcUANN6UjBwagaXQGkC9xc1tUjuYcD5Oc37qESathfQn9d1yYy4ZH?=
 =?us-ascii?Q?5ks2UZhoj7dNjkpvFgZ+cTxuYoHaTxSCQw7TjTGn10U5iaOjiJYQhyM5tQr8?=
 =?us-ascii?Q?ZioALoApu2DR6dJjujaareQIMg6MkfrAj/8uYWYWQ4QloKZcQ7lhMnitXQj3?=
 =?us-ascii?Q?WmAhXKyMEcIuTrzWdvwlLcBBNBdgxa5zHZ7PaBYAICeLdftH6UWpOEsOm0Lj?=
 =?us-ascii?Q?CwhE7znSbczzqnHPpF5y341KVr6AKc/CE37niDI1WdaExvlFRZ/D18mSa7zO?=
 =?us-ascii?Q?GVWIU84PBiI+CK1Ocao/92cVWeUZ+PlRIswM7I716PMdr3vjh9cYOZUS49Ke?=
 =?us-ascii?Q?FUz0o6Xh42xfM2M8ULPzIHcrYV4nUoi9sTGzVBsKFGjmRsy2xTrS5AjO/zL2?=
 =?us-ascii?Q?mc3TTU2CL8wiWrjsFZ+iLYuANHQc9pjaxv9tgO8aXWcXHvFuQXw+aKn2OhiL?=
 =?us-ascii?Q?U8pykqHCmDQ9w/n3OCZ7Cn7lw5u1B7ENWtTqqDQRqsKAK3L04ZIdDfWluBOV?=
 =?us-ascii?Q?wNwBaDjICwKYelJJqRz38DyxngQfrwmpkGV+j28uInWPVHWyrwoHNbSWuyFJ?=
 =?us-ascii?Q?X5jCg1ohws+l5TMJ6FpLBEEZ4WRgnSyHUIQGnb3FxUZZvmzsmmJeHwa5QfVT?=
 =?us-ascii?Q?dQFaeUVGS1qCW5vS2Q1FQu0bIuRkkgrWHAfn6lhfyhwluWuDvxy2Runz/Mwr?=
 =?us-ascii?Q?NhyEgcs/8vzI7QQhnWcnpGpM7iELUmgi1KtADDpFHi9IVvAml8RQvgc9GIow?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658c6738-8c2f-433a-6212-08da9cc52d37
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:06:30.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtOordK3p6Aim6lBmVc8RVf4g4aog41IXfziRwiaMxdT2fZNxuFoXUM3rP2du69SnUxFecD49NB61u5AWp7ZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220119
X-Proofpoint-GUID: 5eG9BzcBACvzE0LwRfPIzOsifkTEd2xp
X-Proofpoint-ORIG-GUID: 5eG9BzcBACvzE0LwRfPIzOsifkTEd2xp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/22 22:10, Liu Shixin wrote:
> The vma_lock and hugetlb_fault_mutex are dropped before handling
> userfault and reacquire them again after handle_userfault(), but
> reacquire the vma_lock could lead to UAF[1,2] due to the following
> race,
> 
> hugetlb_fault
>   hugetlb_no_page
>     /*unlock vma_lock */
>     hugetlb_handle_userfault
>       handle_userfault
>         /* unlock mm->mmap_lock*/
>                                            vm_mmap_pgoff
>                                              do_mmap
>                                                mmap_region
>                                                  munmap_vma_range
>                                                    /* clean old vma */
>         /* lock vma_lock again  <--- UAF */
>     /* unlock vma_lock */
> 
> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> the issue.
> 
> [1] https://lore.kernel.org/linux-mm/000000000000d5e00a05e834962e@google.com/
> [2] https://lore.kernel.org/linux-mm/20220921014457.1668-1-liuzixian4@huawei.com/
> Reported-by: syzbot+193f9cee8638750b23cf@syzkaller.appspotmail.com
> Reported-by: Liu Zixian <liuzixian4@huawei.com>
> Fixes: 1a1aad8a9b7b ("userfaultfd: hugetlbfs: add userfaultfd hugetlb hook")
> CC: stable@vger.kernel.org # 4.14+
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/hugetlb.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
<snip>
> @@ -5792,11 +5786,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	entry = huge_ptep_get(ptep);
>  	/* PTE markers should be handled the same way as none pte */
> -	if (huge_pte_none_mostly(entry)) {
> -		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
> +	if (huge_pte_none_mostly(entry))

As previously mentioned, I think we want a comment here saying that
hugetlb_no_page will release the locks previously taken in this routine.
Otherwise, readers of this routine may think code is returning without
releasing the locks.  Releasing locks in another routine as is done here
is usually discouraged practice.  However, I think it is acceptable in
this case.  Hence, the need for a comment.

> +		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
>  				      entry, flags);
> -		goto out_mutex;
> -	}
>  
>  	ret = 0;
>  
> -- 
> 2.25.1

With comment added, you can add:

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
