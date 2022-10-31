Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA6613B73
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiJaQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiJaQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:38:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DDFE1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:38:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VEpJbe018585;
        Mon, 31 Oct 2022 16:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=9YXshxs3aTQd+tE/tBWxXIlc4pLBxNEiKx2VOOywyXY=;
 b=RPdiP/f6nfjtB+2tMcvbDmOi81fOOeOMPz6XzJ5Ct4ar4O1+1nDhdexMy44f78aJ5kcL
 AdBjicXdnT+k/Vu7hsDCZImjQqEeyDpFKxuyqg6knB+OU1KbDB00oB+3fFVHvS6ibuHv
 75/Gq/2GEgkyywmKfH8WvQfZRA4oLHgUhttOCux7weNza5yjF3NhZksb7nA5nHMP48DL
 AHNbPQc1MswIPRAZkykevQTLX8fY2Y5SjsyVTrT+H2W2UvL6uJp2sy/5KqLMLaog+QpT
 nm0mr/yda+6PBxFUip5/tHnZE233hxrpXFHpF2SEUKYvoLJWOEZFZoDzBoo7xMhy4M6E Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussma1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 16:38:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFAHor007999;
        Mon, 31 Oct 2022 16:38:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3fh9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 16:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBeUkzi5m2WeyfIlugJ7jg0UtBJgBklzNzJAJaWpO4EXz5nsbDYx8SXhFf7HkvBDFUdPEpSqM7HWFziip12+0OGkE1DralApEMYLmKKiGZ9ylpx6ZIm+w9m8cuhCluUW1zOjWTGeiZYV5Q72do+Zlwk7pRAU4+emXYuHsUc9bqx8lFGNWu1ArV/QWp0obMBeg7TEBWeMEwioJtFjrMoJ8t26y43jVEL1lP8eRZRxZEqneOU15YN3uCrJiB2ANUA/uGRqJmRolnja+2egkTDm2BcKaG2Y//s7uuI9o2a7AeYja+S+Kl3HlRAg1BgkWlzmDb6d18GyH9QLsCuavoOXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YXshxs3aTQd+tE/tBWxXIlc4pLBxNEiKx2VOOywyXY=;
 b=Yyx72jfWESjl4PE4LLgC0S8HyVKrnEWUBcmYO7ALTDmh/YyzY9kuhI5MjWmTpyiZko0+Jc7NexIQNK51WkZRriKy2uzfn7Xoa/SSsJwNII6AIFpmpLbkicZyzuyY47s3QjAh53Qqg98HB0qoc+u6EXnTKUyRpUIn8GkQ0YPUp8LuvcFvpo/vhDv2dJjN4s9z6QXz4M2+ZbCsgq/JSG2YAv6bvsYQyOqaLWTFTL9qcSZ0C/PCBqm/WlXGAa5gvqqTelBXEoJzPwOq4wHXQGfswDTyJ06Bcw8jWpJwinWG3d8mS4WhaAvnKPMLNi0HDDPATF7e2t7O4BKu3fpGqublQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YXshxs3aTQd+tE/tBWxXIlc4pLBxNEiKx2VOOywyXY=;
 b=J3Ojx3YvywBglrKRFVNSyYJ0MfDduV/NvKutgpVTnglhAySoq1tnnypxR9+yeFhEPQTeujF/BNelMSlmyObFhx9mnUscn842MAfnnDqjyW5KIoAfAagZusfavPnwY43G10sXuE4cXvIBCfixy7pbO23v5Hw6zS/LhMmu9F7G3rQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5183.namprd10.prod.outlook.com (2603:10b6:5:3a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:38:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 16:38:23 +0000
Date:   Mon, 31 Oct 2022 09:38:17 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to
 folios
Message-ID: <Y1/5+R7H4yub8epq@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-4-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a4783c-e0bf-4193-ff3f-08dabb5e5381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1JTuB3G3iqq3TKy7Ub5uKf4G1hHRBeOda/RltOSjSb3gYUzsvn9RH1dZ35F8BkSAKFxplyUMCZsGvwBYGA0IkFX6MFiWTBY/PVccyDUoiBPgKcrtWYgRX6X9ai6ZOUBIJ7BtonOXts2xyKmCeewM2T9NHtmnqEvAxpe4zk4FdvfBKouJmLzbg8myKdcJc6+bz3gEvnX8P+rWE3p+5DCwgvqgCMWnPkuRe78du6I8ISKyM4stb7DmXM2LV12W3cCf/CBaL7gr1eMEYPf3P8bs3a8alDarpBnFb/w8ke2Q9WSCXAZ8OxYflNypu8ANrU1ibxaA7bIDORShbSDxJ8FNW4hwCDjR6l3Sbl18xJcn/aBVlLT22ql7qnj/b9nqZgN76dusR9TUFwbD73fhSYcLXv3ntmtDApdO7ViceAWYSwelKy4MW6xxw1qI71au9XdvZHP/QXbpJPkHMOgPHtel02WJ0SNab4/wJ9HNwzfLbRGOuXOymIJa1hzkNuYVVaicJ6GMQP1KufKmSsqiTmJvcgCL048tc5BzWqT+5IFllhFkc3ul8J5sea9aCH14WBQGTaZFljDq+CBa7ZXoPA+WkawAh8UMpuLvVAFHgr9K3hcVqD0KHL83LkDJJcpnWVBeGWiBkYyIhp8p4W8uM0v1j7m4Mlw5ATYM+hdf4z/dIWgbYcBdIMPVNwe6NpN2qGaPHZ+getSrXNqgVm+5n9Nsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(38100700002)(86362001)(2906002)(6486002)(6666004)(44832011)(6506007)(4326008)(316002)(478600001)(8676002)(66556008)(6862004)(5660300002)(8936002)(66476007)(6636002)(66946007)(41300700001)(33716001)(186003)(9686003)(53546011)(26005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDgnmin5w2F9M79818wWFiSY3Z1A5hMYpIWMg3VfwB3+YJR7FDva2kAvUwVL?=
 =?us-ascii?Q?FWvVAJ5+FqNbYBZCm+vuUJPSkQh219VBdvYB/Ag5IqGLf2vM4gV4Gc9lu0Rc?=
 =?us-ascii?Q?snTJeTAA/tsI8/PJArIpMQaPpy9vcQUBPRSwbAuun6lyNQaVLf8IhhxRqC4E?=
 =?us-ascii?Q?2/BerVHn+6gfM+oHxyKl6jcDbM1gqJgSOIezjQT2xPHv6V9vhsFvzy7vD/6a?=
 =?us-ascii?Q?Hxgi+tsFHkwq3XfuyRMn++sH/BJD0/B6Qn1sabUxB7i7/hoVl68XZV/7i21S?=
 =?us-ascii?Q?FBUta07yR6FdUB18uZ9JeNkutgkeVcHYV2nbuQSbrEgFV3hTkBElOTNNawSJ?=
 =?us-ascii?Q?orwX7SHUNuyj+zFjNE01wK1yDcFdNEb4SKXN+Jb1BzBDvYrir9jAWB4PBO1b?=
 =?us-ascii?Q?eaJB8KKAuOUwnnAvp8nFGLW7jr6lwFwB/qH3Ey9VUSIYZ4Ah6AkubO2Hb/js?=
 =?us-ascii?Q?8Wlzk16YAX4yrKoKHzp5+3FIPqHTJGaDB1y5qWcTqGF58XPusKE/z4zDgBLx?=
 =?us-ascii?Q?KVqSkJjilFEprt9NbrzmLFOPmbC1Kby4UkW29y+nToUvNdhYBaBechvnL0m5?=
 =?us-ascii?Q?lILxr2KCIDWuYpkgVFwrA4KDFrM3icHGoK4oMlK3jY2CnxwkK7SPZyqmfBu1?=
 =?us-ascii?Q?P5szaz6RnjlVu7MCTWA2ERFL0b/28wmLIl1qh5K/8gc58uBI1PD/ipe1Q8aZ?=
 =?us-ascii?Q?kKSdXS2RqhKdva3sNd0FdtJ0iua26nsXtDpuDl+SkJirQeCODwi2nsc79N55?=
 =?us-ascii?Q?LH/DnrLdhojS0od3ylzRz0Qu8OVMWx50zxk7Gh/sJsivqa5vXIa+HjDjxfTC?=
 =?us-ascii?Q?N5QnZ2Ogu84SSTWAuTQEuoXSvmS6pa7ChjnY3JpLmCXe+odelqQVD/Fbw19R?=
 =?us-ascii?Q?pl7z1WOED+dHMuLIX0119LGtAHloDTdzuzPW7d6Lit0wyfshtS+RsgX7X52l?=
 =?us-ascii?Q?PKB/649tEiS/Gus7qDHmV8jWtCaaN9f2+h9oxYNERHq3+WSKFHo3iCDFNSms?=
 =?us-ascii?Q?gmucRA88MASY2MOfyzyx7O9Tz5WQjriC/C2s65NaTU0mUGhU7lKY6AsO8/L7?=
 =?us-ascii?Q?qvwm9Jxo/dwtYvYlloaI2aLeJ+eJN58+ctSJxPnX+vkZO3CxjXwLdtPU1pxC?=
 =?us-ascii?Q?Pzw4siAij05Jc4rIz334hQCcmT6Wurk46X+UHm+q4W8Kjb/lhubm3tdGGAYs?=
 =?us-ascii?Q?SWgWbMoQA11d67GeIXQyeoc1I+WtxhDidauHB9QlNnBxf5Q6Mp0tCXfTXxYz?=
 =?us-ascii?Q?/WmUJ3OEUuVU7JdT0QG9HcX2X2hzNs3+nYtDuRbT3wIKDq9bUl9C7m2VehjR?=
 =?us-ascii?Q?kRuGrSGcXwopwzUcghFXXzQ9VeQAlG+z91Tg7AJacJLTMBl8LWtVwtbJXsJG?=
 =?us-ascii?Q?Aon+xzc0Bwad/qMZtxM2zODlfReweW3FcQDOXIoQ6sLcQjxDAE36KjRBbGJA?=
 =?us-ascii?Q?SJEe9ifzElUa5D1jk2QL+euzH/0y0xSE7zhwp3tMhuQFVEL5N+jhoO1RuPRB?=
 =?us-ascii?Q?kDcGRfwTX9wRQy1P9MNmepKVuoN0dt2bar6ja0eJNhLso5ZbcLP85kjSOe6X?=
 =?us-ascii?Q?O6VX+FCYUjkegfts8PHL01VjbBq99o8Nr2E78Nl3OCYpSYhH7OhJAF7jzMdd?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a4783c-e0bf-4193-ff3f-08dabb5e5381
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:38:23.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBEnS86ddmT6Tzk1+ftmaQBJlSbJ2JFrdtkI8EWiAvTYyQwHTE8CwSVkyCGfspFgy5byNZsm5eNbAPhESd3AaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310104
X-Proofpoint-ORIG-GUID: 4IKuMgr0EK6vKBwOAsqex2v_AqaNHyQX
X-Proofpoint-GUID: 4IKuMgr0EK6vKBwOAsqex2v_AqaNHyQX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:12, Sidhartha Kumar wrote:
> Allows __prep_new_huge_page() to operate on a folio by converting
> set_hugetlb_cgroup*() to take in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1758,19 +1758,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
>  	h->nr_huge_pages_node[nid]++;
>  }
>  
> -static void __prep_new_huge_page(struct hstate *h, struct page *page)
> +static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
>  {
> -	hugetlb_vmemmap_optimize(h, page);
> -	INIT_LIST_HEAD(&page->lru);
> -	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> -	hugetlb_set_page_subpool(page, NULL);
> -	set_hugetlb_cgroup(page, NULL);
> -	set_hugetlb_cgroup_rsvd(page, NULL);
> +	hugetlb_vmemmap_optimize(h, &folio->page);
> +	INIT_LIST_HEAD(&folio->lru);
> +	folio->_folio_dtor = HUGETLB_PAGE_DTOR;

Seems like we should have a routine 'set_folio_dtor' that has the same
functionality as set_compound_page_dtor.  Here, we loose the check for a
valid DTOR value (although not terribly valuable).

Not required for this patch, but something to note.

> +	hugetlb_set_folio_subpool(folio, NULL);
> +	set_hugetlb_cgroup(folio, NULL);
> +	set_hugetlb_cgroup_rsvd(folio, NULL);
>  }
>  
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
> -	__prep_new_huge_page(h, page);
> +	struct folio *folio = page_folio(page);
> +
> +	__prep_new_hugetlb_folio(h, folio);
>  	spin_lock_irq(&hugetlb_lock);
>  	__prep_account_new_huge_page(h, nid);
>  	spin_unlock_irq(&hugetlb_lock);
> @@ -2731,8 +2733,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  					struct list_head *list)
>  {
>  	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> -	int nid = page_to_nid(old_page);
> +	struct folio *old_folio = page_folio(old_page);
> +	int nid = folio_nid(old_folio);
>  	struct page *new_page;
> +	struct folio *new_folio;
>  	int ret = 0;
>  
>  	/*
> @@ -2745,16 +2749,17 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
>  	if (!new_page)
>  		return -ENOMEM;
> -	__prep_new_huge_page(h, new_page);
> +	new_folio = page_folio(new_page);
> +	__prep_new_hugetlb_folio(h, new_folio);
>  
>  retry:
>  	spin_lock_irq(&hugetlb_lock);
> -	if (!PageHuge(old_page)) {
> +	if (!folio_test_hugetlb(old_folio)) {
>  		/*
>  		 * Freed from under us. Drop new_page too.
>  		 */
>  		goto free_new;
> -	} else if (page_count(old_page)) {
> +	} else if (folio_ref_count(old_folio)) {
>  		/*
>  		 * Someone has grabbed the page, try to isolate it here.
>  		 * Fail with -EBUSY if not possible.
> @@ -2763,7 +2768,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		ret = isolate_hugetlb(old_page, list);
>  		spin_lock_irq(&hugetlb_lock);
>  		goto free_new;
> -	} else if (!HPageFreed(old_page)) {
> +	} else if (!folio_test_hugetlb(old_folio)) {

Should that be?
	} else if (!folio_test_hugetlb_freed(old_folio)) {

-- 
Mike Kravetz

>  		/*
>  		 * Page's refcount is 0 but it has not been enqueued in the
>  		 * freelist yet. Race window is small, so we can succeed here if
> @@ -2801,7 +2806,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  free_new:
>  	spin_unlock_irq(&hugetlb_lock);
>  	/* Page has a zero ref count, but needs a ref to be freed */
> -	set_page_refcounted(new_page);
> +	folio_ref_unfreeze(new_folio, 1);
>  	update_and_free_page(h, new_page, false);
>  
>  	return ret;
