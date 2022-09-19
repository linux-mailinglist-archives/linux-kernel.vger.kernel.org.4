Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B555BD88C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiISX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiISX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:59:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0AB520A9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:59:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMiMtZ005287;
        Mon, 19 Sep 2022 23:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Vv4Znsm62gdtCmz+Lb7UKfiZ3RmFKkJlPpUyERH9qVo=;
 b=RBlV+pE6rnQajbVo6Rkgmb/G6N2PB0EiSyQypSRtPzHjd3H4Q7T0r1tRbhbL4nhI+XvH
 f2DiCdJ33sRYRRd/juCNMrzpkemxOAH9iPHvoufhZ1eB2cJQwiyhK9GLEk/cxCCtstrH
 KVhp1jDpVGFG9uT+x/aq15gMYdjuJRtf2zCgPoc8RvjTG7/fKsVkoCnW8MPKnXuPtrIy
 JbB0hlKub9E2IEInwjgUFk84rYWVbZHKxR/9WyxnEhu+JwvZkOUpFBQk7xzUHzYM7Jdv
 fGB3/r+87CPKKQ/nt9tRiQS6ii6H5KEZbqvTYY5hx2Rf/ZVdR/ZZMwSkptgXL5DGOlQL 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stdcve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 23:58:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JKrfKh035919;
        Mon, 19 Sep 2022 23:58:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39jp5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 23:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmeP4UrTI/hvx1RIjZBDdcQ9s+6Z5C12C8kzBytmhof2MX+C6m6KcHeTDP9m9jm8cQWaMziTstC2Z8yVNFuC99vrc5IP/k4cGYIrFrub3Z86PkSfFpxsli3J8jIMEMYVHebIQa1UU4Pwu6l5mbWxFscsZzd+ilRI4lDOaRJYj2KIhlM2d/B5vq13uA+V0D4HLScoFdpnwtb/uS04rPki91grgCNo0IjOs9NZl6wRczjVvSAMSQT4lIzDbctV7f7IP57c3YVaYPjdgCl3S+1QyoSktvFMASuO8BMv/EKD39gNgE+ictcsGU3YqMcfJ451ebFLmEfoRhHT8x3cf9S2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv4Znsm62gdtCmz+Lb7UKfiZ3RmFKkJlPpUyERH9qVo=;
 b=GJzDZjKq8v+SbXXtqqeu2kzAOf+TZ3KfVoyzW+nUxxm6Klu1lIBdOC8pAvmWbwAPNU9VUHQ+Q/kigjjgB4k4fyvVzwN4R0Ctef7nm86GgDTDe6YvCb24Ltn9TTNdWOYHtfyJUlaW7oyN/JVT3BwYR7f9AlYZgAoUYbU/7zKdJZXLiB6ZZ5aM8tQhTwZ4hFJr0hvu0OONjHq6l7AkeRI8Fdia8uX01XWd5IZKwhrukwQxkdv9BqYO/YdLHDjVDDUmLn06u5XsD34l+GjQXgbp4vl8eb2Frdu4vPmsIBFbYP/Ia8PHbANehZy06afFTQKKkihHAgtJE3J+yN7TzwOR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv4Znsm62gdtCmz+Lb7UKfiZ3RmFKkJlPpUyERH9qVo=;
 b=mgVtj81vjsLGc5Xw48FUEA3DEUaDDygZVYYXEk70ZDw2ate0NzYCqMEgvPM87ka03NYuIHSiL9Y5RFHO99VQCcM1u70eOVkjKcaWRcnYNHrpuimyDTpt4cacsLu1go7qXDhsjYbYMJ1KSl/xD6CFqjzUNL08cNp9d3aUV0Iab+E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6552.namprd10.prod.outlook.com (2603:10b6:510:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 23:58:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 23:58:56 +0000
Date:   Mon, 19 Sep 2022 16:58:53 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/hugetlb: add available_huge_pages() func
Message-ID: <YykCPfGkMwNksqCs@monkey>
References: <20220917011528.11331-1-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917011528.11331-1-xhao@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b2af09-f5c5-4f5c-c9ad-08da9a9ae997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQoKEG3gPljMIn5Pj87wxf2u0r3rpM15/FzafujVbgvG1ZrWkq/g/62Y+lnaFtKjs230WWsxSjzwaQp+5KPbB7fXoVH+i5oc0nmq7Vv7PbdOv0/V7pYNhsvt7LMT3XTS/eLfSj4XqJXzbGu0azkcbZFDgYJ0rHUb04S4PRq4nqeK/yEwNXQsxmhI+I9hVpnnP77s6FOEY6cSFcXP94Lu9oTN0TNkeC8x7WAWLoKnKGQQ0wMkV2L54s8jBcCAnG9vkEyw7S0gOJJEuTzQkotVByum+1zi7CKkWEtgwEgoPBXip9srv3dO6trAcV6kpnLeHIJw0iKoiGHjD+5z0CminWF/5oUSINhigEwTXLWXK7Jm2nm9k9S2VdtZ8Oe77DJ/iirBBsqlff0DNn7cGv4ZLamYBtVY+7MrCNnHzDAUiD3ailept+He5vFhU1M88Tl/60d8roN6VurYeHLqs1onk1aOuWA1h0TTvS7lCNQDT6yvkf6HEJ2ebhkE9tNvbvr2TZzcSDgDr/yG9TyWPKtWcMHCw/qc1q4bOec2uVBVy7CsGYLjIRxFfdgssA/CdaYl0RmPKSb0OR9YETddTIAaO5wNyfyTIGKdW1LE35MFcUxYh8y8kBRjkCuL1lxBGS0fE3CupeV4d3ht4n0Qq/IaYg+4V/ODUZbCaN6Vs+er/g54zqArN5xBMy+NU3gn9tATUTO3Akfktg9AttBVQR7exVwfC8kvmF1qCiHgr2IhzV4zvq4MavndsyRgbokHDEts+Wqrr0L6q1WqLeGKcpiKGoma4lf20mzkFpiSVlAR/yzjUmW9y/NOBecztc1rP8IE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(66476007)(4326008)(8676002)(66556008)(66946007)(26005)(53546011)(6506007)(86362001)(8936002)(6512007)(5660300002)(41300700001)(9686003)(6666004)(83380400001)(2906002)(44832011)(186003)(38100700002)(33716001)(478600001)(966005)(6486002)(316002)(6916009)(131093003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DvGh1bevVW5sDTzkJwO1TZ+rgoVU5yJwqOb96V8+ShKfaD6GUEtjAvZdywYb?=
 =?us-ascii?Q?nXoPzmSPmubd9SgiYtgr+gSGBcxH7lJOC6QRuWlxTiXNg1/CWhGlfD9dg1Ae?=
 =?us-ascii?Q?CwaNgEVahlgrsrYy00M/ZobamEaYlP9zBuVbxgZx4OAkjdqttsmJrm5bdd4h?=
 =?us-ascii?Q?+To+F7hLGW8f3TGJYj90ujuZynGwY6jGYadFySGDpUgga6WdLM3tIqi53FKJ?=
 =?us-ascii?Q?h0J1rbf9DNZP5jtJ40+6jqkGJYeWjZxbVzGGfXGvVw5wS8Yc+g/tSVw4Oq0y?=
 =?us-ascii?Q?vGrIsu0sLpLExa8P5g1Nwu92ZHSYla00PyrABQoqbtFtCOG1LbKmh4l3HTbx?=
 =?us-ascii?Q?BTEl23S2UvY/uZ/h4ZsYZbHnx0Eiu8cny2TYIOzxuYNEiR68DjUqYHhRTaUV?=
 =?us-ascii?Q?gtA0yVO+iO3Fsuqwl5MtwvsLDIV8C/1zZRsz7HN2VHBNFFmqVesZJuiJnm4q?=
 =?us-ascii?Q?a+edDeUBxQt84VLAHx5Tt7YQ+2BfnlXHjCfeayiPEhPGd6uTZkdIeflAGdhe?=
 =?us-ascii?Q?Fe+9Msl2k5xTr8r/V4cC9QI56l42GLoG8/I4ErGxkLu4CNqZKrEZbDiyO3dU?=
 =?us-ascii?Q?Zbid7jzRS7eKu15QJe2wpI5saKE4Ah9an9Kc5HcC4emJR57K9lsFf6clzCk9?=
 =?us-ascii?Q?aPIqH4uev5ZNzxvN/210pviUw77KeNBolmZTwK43nvs+L7CQtw6kLyhsGTUu?=
 =?us-ascii?Q?apGNXUApFyntSToTJMtz2FHdUWQgaon1eBDDs64q8sbd/XLiL76OY93ozYcQ?=
 =?us-ascii?Q?xoNDTsciCxn+dMTzmZZmn8XP2iq9F6NccTcCISzZJnJOROscehcvU//TlITV?=
 =?us-ascii?Q?Y6VgFPfHDCpRB5LzDMcPrLJuLLYo6AglNEp5/AyuOitb5zl+GadxBjDlTg3H?=
 =?us-ascii?Q?rnnA0pAsjE2VBlju3D6UYgoyoCXx1O3FMq/DmuQcMoHCLW59u+0NSGrScwtN?=
 =?us-ascii?Q?sYTSwjjBtieYnEOQ8CvjJk6iyIRDF81UNsAkEYPRmhhEIdWD65DWRBAsOlDS?=
 =?us-ascii?Q?UQ6j715jRHsygXJvP7+CePDqOZbvfahbdm3qFIubxrnfpjMbpdOc66WuhApw?=
 =?us-ascii?Q?3WRbpvuTu+06z2tVisDhlFE8CYQc0OfCvrEEqUqYwprlw4+m+Q/34xnD47So?=
 =?us-ascii?Q?hQKCG/awozdzdkvp3o5zzTiImzOu8GIYYFH1D+FSuMsteD/oL2lpSJvcpd4j?=
 =?us-ascii?Q?7AARYUdbgTrmZz8kqD7F+YNwVA71V/sESXoj/wr2a2i2yhufLkRXNclTUOCQ?=
 =?us-ascii?Q?Jq2zbef1TffvPLvAyigllhciOMiO4ueVyEr/1jVIBahwReNHHu96HubtOYyA?=
 =?us-ascii?Q?l4CbAyWAKSL8EUObdcduaxUbu9oMptO9gt+h8kVSmsecdB7XOGFRvdQ/4xIe?=
 =?us-ascii?Q?ZaxE1mFCVohF3cWtmbbFQIG4L0rV+9kjhKsdqmihcRLDgCt13mCBc0Fk5/z/?=
 =?us-ascii?Q?PInmBzGRZNJUCq+UW35oX7nJIdMOM8h+wLoryDqqJgZDLurX4VD/nXK03Aqk?=
 =?us-ascii?Q?KiAfluGFTJLy4+t06dBm9fbVhW8OQKOmwZFAouSVshAjCgs5s+AbwEXCdz1N?=
 =?us-ascii?Q?UmOg+UU/9LyPvnPYSLYFS9uQB/0Ias5MI8csFvYFiDpa1TYA3vJiXoh6oXc6?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b2af09-f5c5-4f5c-c9ad-08da9a9ae997
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 23:58:56.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQmikBEsIGVxpbD3w16cJGCjxImKBvtH8CVkopycmsosalP67ppravtYQTQHyJGtrlBCjz2L345/ytuUpIeAug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190159
X-Proofpoint-GUID: p3Ijsbt6JSQfRSiBOlyye5_O2xlkxhrr
X-Proofpoint-ORIG-GUID: p3Ijsbt6JSQfRSiBOlyye5_O2xlkxhrr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/22 09:15, Xin Hao wrote:
> In hugetlb.c file, there are several places to compare the values of
> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
> there add a new available_huge_pages() func to do these.

Thanks, I think the code looks a little better with this change.

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Changes from v2
> https://lore.kernel.org/linux-mm/20220916064127.1904-1-xhao@linux.alibaba.com/
> - Convert is_resv_equal_free() to available_huge_pages()

I believe the above 'Changes from v2' information should be below the marker
'---' as it will not be included in the changelog.

> ---
>  mm/hugetlb.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

The changes look fine,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ea0b1b0d1ab..21d7f2361696 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1191,6 +1191,11 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  	return NULL;
>  }
> 
> +static unsigned long available_huge_pages(struct hstate *h)
> +{
> +	return h->free_huge_pages - h->resv_huge_pages;
> +}
> +
>  static struct page *dequeue_huge_page_vma(struct hstate *h,
>  				struct vm_area_struct *vma,
>  				unsigned long address, int avoid_reserve,
> @@ -1207,12 +1212,11 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  	 * have no page reserves. This check ensures that reservations are
>  	 * not "stolen". The child may still get SIGKILLed
>  	 */
> -	if (!vma_has_reserves(vma, chg) &&
> -			h->free_huge_pages - h->resv_huge_pages == 0)
> +	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
>  		goto err;
> 
>  	/* If reserves cannot be used, ensure enough pages are in the pool */
> -	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
> +	if (avoid_reserve && !available_huge_pages(h))
>  		goto err;
> 
>  	gfp_mask = htlb_alloc_mask(h);
> @@ -2105,7 +2109,7 @@ int dissolve_free_huge_page(struct page *page)
>  	if (!page_count(page)) {
>  		struct page *head = compound_head(page);
>  		struct hstate *h = page_hstate(head);
> -		if (h->free_huge_pages - h->resv_huge_pages == 0)
> +		if (!available_huge_pages(h))
>  			goto out;
> 
>  		/*
> @@ -2315,7 +2319,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>  		nodemask_t *nmask, gfp_t gfp_mask)
>  {
>  	spin_lock_irq(&hugetlb_lock);
> -	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> +	if (available_huge_pages(h)) {
>  		struct page *page;
> 
>  		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
> --
> 2.31.0
