Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5076020EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiJRCJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJRCIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2677C74DF5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYGxC028714;
        Tue, 18 Oct 2022 02:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JYFNZBSAW+ilSDcWuabF/cF2iyXvcLa5dYee2fYoDB0=;
 b=t2IQmV+R1cTlxtOZDqCI6/82Ljr3qt9Nwwouim6yEYc+q0OxjcCchEG+1z9uRbp5wREz
 gCBCeXJNkDJrrgb80914gWdGussiFBrkt1UZAD7YquxOn3mHSXSrtwBfDAGOcuUR1tfK
 8jVlMYMFqOfMCtWbHUYuSy3o+7eOdFyUUinkOIgmhZ08ZSkuAM0q4pIuf0sw2RG9+cV+
 3HmIhsE+oZfluDpoPk43WtazqxXpVa1XRBID2UvW3g+XmiIAaycPBBEvwiCOCBXFk1Gc
 D65LYNOBQGkzKAyI+da/U2Rk0To9wClpoUjvzQQNG2wS0Nky8+LPDrjHkdm2FvAqKmoJ 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nt9fq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:05:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HN02oj015903;
        Tue, 18 Oct 2022 02:05:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqy4gqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:05:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es+oRuQWesyLbJkSYv9Os+qeTK6hg40rmP9NqivXSgYGqZZkVuuZMHb0b09toDWTZIYSet839MagyI2+6OszArsOEGXceud9sc40FcAFChqy5esjcNLqkE/7xl3jzUshREodPi5ZbPFOQvygw09DXyS7QkeFokH7RMwRxVeDqlkWffx9HGFH0h78xdJnCRc+U1U4qkvPTn7IdLZkYqoWko5ObetBTr04KliU5bIK6gE/S/gFk0eJyU1ZdHEEq3UInwgckkETinClL17Gn7BCcxDNuQxjGhArYgusX4mMz7KxTX6wyy5efcnME+e40Vs0/GO/PkiLrrQUUpldylXd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYFNZBSAW+ilSDcWuabF/cF2iyXvcLa5dYee2fYoDB0=;
 b=YFZJwDWLO5LDSFM2bCMO4FcsIt/NPGcZIvuBozIo6m0FuYjmcAGa29puXkzWsCTquhorglWHKWqTa3n7y8pNRWRhDaqZ0P97B1f+3/j9OPyViEW4rEfyyHRL+xg+juVSQ528BEVWAQZXX0rfIrKPskgsI0hidjxTS7EfvEc5ss79naDm052s2gCd3GZP7PFP9QILcgy0A1Ox+dyuU0Svegg9ZwkAXnK8OSa7idk8COWffKXUVM6zsNwn4Po/QKymSFdOZVIYQz5uhkUA8aoL9K8EjD9QSMw+Uds4r0C/w8gyZbriKMluty898PJ8MEEQNC/tmHriEMAZo/k5xJg4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYFNZBSAW+ilSDcWuabF/cF2iyXvcLa5dYee2fYoDB0=;
 b=ZbJYF+2+zh6GqciAXul++gAjewEZFR/rEec474vjh0YLSScc6FaUanxAANRfa/k2W8ziu9N4cmRZ3it7LDm6F18k9ARltIbyw+NyCgsghyNWyZ8rGawWfTj9z0VzUthT4QuPVB94EgjHIe3dIo1zscSjfj0UUGXUl5w/5FoZLZU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4143.namprd10.prod.outlook.com (2603:10b6:208:1dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Tue, 18 Oct
 2022 02:05:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:05:52 +0000
Date:   Mon, 17 Oct 2022 19:05:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Glen McCready <gkmccready@meta.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com
Subject: Re: [PATCH] mm,hugetlb: take hugetlb_lock before decrementing
 h->resv_huge_pages
Message-ID: <Y04J/FxGLAhY+z6O@monkey>
References: <20221017202505.0e6a4fcd@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017202505.0e6a4fcd@imladris.surriel.com>
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN2PR10MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b2223e-ff2e-4cb2-5ab8-08dab0ad4847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v50ogx1uK7rA5DxCOXBrfvwjoPEVXwCnQPcx3/GgkkImQPCONOXY+vbjuC9DzoTlDas2LnWsyi4UYfxxx9r/ztYo/DyNVGf8KN26N7IPeGmD0omv4gK/MOWU75ejDexvwqpLooLERkGzfp2MpSMhDpCh/v4yh0YhRxYQCO0EDN0FbLH1TSOGy+mE4D7kZ657wwa+bN44U0KhI1is/YlgNmtzUs4qi4NDn5OIFZwuO1R3hy/1Dob+fii6lTbynKdIdgLZG1vhvWmnlR8ABqT17DdTnPgOg0IELeVyECurnJFF9DIkoDyzMVBimBqxjwJyrpDWu0Cbd1JrGN+1A7VgCjTdNvxKN4bpw1lOJC5QcsKLhMAc0ogH/JdFkajar3DBx1x51ebPxfM/SM5pjaNhs+mCKMNR4MuYI3QzK3+Q3rMop0UTNjOaXFB/fuYVhT/aJtwqM+iZhHZHolg9xIExaOzF0s2zsPrFhULVrC5vwOZCZzIV8t68uTuAM7aYfn15j2HPXw67uLW5oi97428vWS07aAsk+TyaG79sGlugGgP0MPY3pM5eKGkdX/CcjMiFHxHIgidkG+4QkVQiHQnCCbh4E0kWu+TILHXDl+b0lao3QRwLIAGFyWLjdCeGvJCqUcG5yVD82ePxGwB2tuBuaywh/EjleSeStPOZijKaJegsDOQEz+658YfY45V0NuF0nEWtA2XM4B4a68ZBcTbsVb1zw7KNe8Wf1r6rO+q4I+kdyHAfvTx7dQQUvlp6k2KZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(6512007)(53546011)(9686003)(6666004)(478600001)(26005)(83380400001)(186003)(44832011)(2906002)(5660300002)(33716001)(54906003)(6916009)(6506007)(316002)(6486002)(4326008)(8936002)(8676002)(41300700001)(66946007)(66476007)(66556008)(86362001)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KR9Ix4w/k/riZ2NH/IbAQYo5/kRcsikSoIsXakX+ua4j8XcxVczFXq9u3mpL?=
 =?us-ascii?Q?EuHDMs8dBfsyrCOJZOycpKmCjNtIw4fEnx4RC9Y4AlFC8e9yJZo3D3I8wXma?=
 =?us-ascii?Q?9YaCCiFrKz3/NB3YL8TIfXM1ars8Fa6SX2xyg+wvsHefg506RJAXljDlHQEY?=
 =?us-ascii?Q?zNpGK8GPo/QcO+bymrNHQuyNaI2fQQT8HJqUekRWDkBcND2g3jvV8szKphnP?=
 =?us-ascii?Q?nEsQ3Ex6PpPN4EJZeWjT5QKMr64UTCdR2GqsDmcc1Ow66wIvu4dyZar3R0K0?=
 =?us-ascii?Q?BubQpEKQbW/B6b2cnxo31KoBV68NYcgKbvcDpsY3gzR3cgygNNIBWvuuSgkH?=
 =?us-ascii?Q?2ByE0syEBpbeyRRkDIebgGfYfupbltyxB/KlyftJJwjqfCAMbp6qLv2DLYNs?=
 =?us-ascii?Q?ZwgeNLGi3/TLPTO49evwHzaTzVAvDu+vpKlGK0veMcEDCkfDiLBjDPYZ53a9?=
 =?us-ascii?Q?MXbWUMkZUb24W0jNZa9U+Ax8aDRbbGctPD7PCpaV9Zgaqa5S2sYmNTvgiCve?=
 =?us-ascii?Q?JzgtDZ+hrP2TEPcN1n066bWk/3ulObrsoxK9jeuJxWSd7YLOBmEeHhM64Zp2?=
 =?us-ascii?Q?ifl/bAOj56BbN62TuV29DTfiwYoGPohwehXacbSqQCdKO5Wt2R7TWwrMz0aw?=
 =?us-ascii?Q?pQ69zg1GMId0O+Jw6VWZoOET/mIjGJfcP7TbsnWaFufWTCSCAIy5TwXoYFZ1?=
 =?us-ascii?Q?LErUX8yJ/slWfLIWXiXyVf0G5OHdSfvdyK1ZrRdMzATmk4YtRVSFCIgwzIZt?=
 =?us-ascii?Q?O/QQR/RoV290/FL2uuU3vXiSiaH2oQxf3/OKWKYmymULYIBy3M50q/BV1gzw?=
 =?us-ascii?Q?9HNFN+J0MM4MXTC4TC2qiU0wVPSJA6PtWQVzl2ahzx9MVjXqJ44QRwerC+LM?=
 =?us-ascii?Q?p1X/poxngy9RDJt0MVXh4tKE74jM5Z8vGzv5CWgWwSQ8JjtqMhrqiBaWLAjY?=
 =?us-ascii?Q?Va0/yY/untkd0NZHoaeUEUOT+OvcU0zFVYVkC9vTriiM/ULabOLg3oUF5dnt?=
 =?us-ascii?Q?MNICRrFf+J4zZeR4oX9x+7KT/8ls7bKC5n5umPoFhWAA0GWyXRjO6Oc4/Zp0?=
 =?us-ascii?Q?iUyYumeor3YZwqRPU9weVDQWNtDJtj5BECj0ERcc68Gsz9iGu+UeTKNvryUo?=
 =?us-ascii?Q?1UBb3y1kLHWG/s71R9+VQWHz6hDuq2JzTcIFajLWhAT60PCgViq/qI/9Fbqe?=
 =?us-ascii?Q?r7u90+JAM53oay2W6EZEV+bFvqHMFK7hfiIwypwyaQZykPDph141NAfPUUtf?=
 =?us-ascii?Q?Gm46uxWz8wL91NGMbApQ8pXGYESB4YLiKMm4+6QQDauaEboHyqplQMzz8nkT?=
 =?us-ascii?Q?P02HDENj2iMRDFbQCA8NK9uxviS/64B/E+up8QydZ9jqCXJizcbyZI/fX5zu?=
 =?us-ascii?Q?PMujOsulAUpf63QHYvCS7JjQa16FYG7/xU4znTsijWpHNyuQXhYOLHh6YE+o?=
 =?us-ascii?Q?4/dqM7ZtiOE15V0+zc4YniCGPahc+PBuSdUplqsVby2GfNWuiNwl2jqsiXnn?=
 =?us-ascii?Q?PDQeMkApJfrFZVaaWrcbZLZGJOGXh2hnGySCpYBl7VevUurLMQ6gqEYRa9+c?=
 =?us-ascii?Q?qgrLVG0fvnoMyjCPYyCFpIH3i9/xNBWtORQiaKazY17EVznRuLSXegSRbIrC?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b2223e-ff2e-4cb2-5ab8-08dab0ad4847
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:05:52.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXrjhxMp2lZT+O2V+BkpfMg0VGVgcOa4rfnLWbKzj0jja+CI66XxsM5q10Qux3zvl5A+EJYs8r5D+So0489k3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180010
X-Proofpoint-ORIG-GUID: IzODKGqVrJN7m9hI0ZiS8GgJjMuitoz1
X-Proofpoint-GUID: IzODKGqVrJN7m9hI0ZiS8GgJjMuitoz1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 20:25, Rik van Riel wrote:
> The h->*_huge_pages counters are protected by the hugetlb_lock, but
> alloc_huge_page has a corner case where it can decrement the counter
> outside of the lock.
> 
> This could lead to a corrupted value of h->resv_huge_pages, which we
> have observed on our systems.
> 
> Take the hugetlb_lock before decrementing h->resv_huge_pages to avoid
> a potential race.
> 
> Fixes: a88c76954804 ("mm: hugetlb: fix hugepage memory leak caused by wrong reserve count")
> Cc: stable@kernel.org
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Glen McCready <gkmccready@meta.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Rik!  That case did slip through the cracks.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b586cdd75930..dede0337c07c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2924,11 +2924,11 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
>  		if (!page)
>  			goto out_uncharge_cgroup;
> +		spin_lock_irq(&hugetlb_lock);
>  		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
>  			SetHPageRestoreReserve(page);
>  			h->resv_huge_pages--;
>  		}
> -		spin_lock_irq(&hugetlb_lock);
>  		list_add(&page->lru, &h->hugepage_activelist);
>  		set_page_refcounted(page);
>  		/* Fall through */
> -- 
> 2.37.2
> 
> 
