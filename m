Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48F64E1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLOTcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiLOTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:31:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01445C0F6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:30:09 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEnIZv022970;
        Thu, 15 Dec 2022 19:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=537HRAFK8mx7iDB1MAys6Xdn1/ja9rm8uLi5of7Juug=;
 b=QTNbpxwbRrn3LLRccEbbKdIb6m7pk3miG1Z3ooJWV0E0wRkwcNqjCPKhopqUm3TMUxh2
 NII6fuTfcljM/6SoRVOhR3OzLwP96MyMX+R/M+PaJHLdWw3N5irwHntE+j7UmbUwiBwj
 zGd5Wl25iELznH/F5Yy9V+Goh92zEDJ7Lz+wMsRCnSv1UTz6kmSH+jQ2HBhef8WKp8QI
 lTehSUJlXngojUbHuPY739dc/UbZ+ervStomlvBOhqSSRSIdSdB2zK/FueKU8ALZd195
 cva9Fa82wlgQUCD1zEpV3l7uhIM4GZtdY7fwCQraOsuYk3ePm0crHi2moGQmP3XQr3mP 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewdwyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 19:29:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFIiHKI010175;
        Thu, 15 Dec 2022 19:29:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyepg87t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 19:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT9oHVNThyhN1pPI0rUNCAI+v05gm3gqyMUofzXRXN25RgdIGskRx3Qzzju53rROTK5h5lPOllgRtTEZWo0FQnKoOEAcQA4vEnUJSiIOHyVfOzFSPxNmEK4ni5qn7jp9mnGlesoNna34afcYRAOegTFV2c/TUyEmkd8egmFcaHnIgUjLFERhb6YSKUspyPHDv/Y3I1rIUooP6/kHxvuX0vAkEFRVUMSa5MLeZyfmSWTK4LBfS0/87Ts7GeJT4MSWnPe9mmqZ+X0yNRbcBxGYhtFXgwg6Md5Ri4XxveH7n0VgpRvHfjrCGPmrWsNaPNWwQpesP3epy1RuIxZ2sSa5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=537HRAFK8mx7iDB1MAys6Xdn1/ja9rm8uLi5of7Juug=;
 b=gb3PtGZI1tJll1nvV/bUJM4B2Po7Y0Xdz1gFtSCBCMGeMj5p2sI4OcEPbRD+Di2MfYmyTG2yPospSWmF8cFOa0VNHmhIVMOhMr9yGeZ7Qq6rdzXUAA2ksJbJL3hfuyUXfcdSwtktPOGkQrWpjxCUyb1wBN358CCHitphOYx6LenqFkmX3bXHh3dNEICWDozDKRpE8X8Gse2L7TdXS0IOa0JNIHimokE1tNPnTu6KPRdv0fYbHNSUapbnTR2YEuTEmhGaQCJedF2Im8f/N67Pb8BStkdldQYuTwWN9Yid6tWQoLaBya0NLFV53dnBDlh5dXehX9IH6s84Y/NoZ7gUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=537HRAFK8mx7iDB1MAys6Xdn1/ja9rm8uLi5of7Juug=;
 b=IAYoq0jqDVhaodLiX0jy3IBc0WcQPOvk3TybLYiucMQwh1VqXsUQ/jRA2KaA7SK0Y9Bym/c+yUMyz2o7+qn1elKOUQ4FYo8NqSpad4RdO6mXgvk1RtKTq9RBPR3f3WK6oDff3KV6FTmqpRr0uCwlCo6pcqoEaskGJo55QwQjIJg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6274.namprd10.prod.outlook.com (2603:10b6:510:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 19:29:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 19:29:33 +0000
Date:   Thu, 15 Dec 2022 11:29:29 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 18/47] hugetlb: enlighten follow_hugetlb_page to
 support HGM
Message-ID: <Y5t1mY1y2Smq/cul@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-19-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-19-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e681b3-1544-4e1c-5192-08daded2b116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmfKwZo/4Sqo+3ZyjMvW5b7dE1EflnFpIUjzTrQ1+EE+iUumo9Q2CzlvPlGZI+7NdxvRyldzELyLULr/hXO9eb1iJAuZh1NlcNAy6HTWbuxHwXL/Ok2G7ua863tDMITMZck18jDebkj8QFdyTprxljKH7jrSaALrAP9GFjT+Pbq9xVX4q96M/1LcXahqV+QUhFvM7sSjaiNZ2paPkhrAPDOkJJ12sWUNQQyiqKDh3JseiwOGTPFGO5Cr04QrbskGTQxIequI5fo3axRUOny1LnEHWLf4B9zgiUaJxYxh8wWXwazWmmeGqLbngeSVD6oI3PF2msbRD5F1Ekhjl1299BgbXpW93EaURNFvZWSN0Bgnz+iv2HvFVBQI8vbnY4boa5ky/oO7+JEyK9jbW50h92wpk4H2Zw2lbovpadsN7THi/yTbH4T4D5RvVnCsN3eafU6IrFl5fJiINx+AzI2tIyYeoDZPxQN9ApzDjisPJYL6Iv4Nz+n4rCZzf+hDSmoBgPQJzezWqekShDb2DDVw6aEwtEHxYMcurE84IB3Tt4ua26pQWiw7aq3GZuwasyEDBvT5tmK2I7kgJed3TjBUyWr0BtlQDAC77QI5AYpwtqOBwnnpLNLAf8W5wIkHRhq+ElQivmRQP3DyuF9eY57bvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(38100700002)(41300700001)(6666004)(86362001)(53546011)(6486002)(478600001)(33716001)(5660300002)(6512007)(54906003)(4326008)(66946007)(6916009)(66556008)(83380400001)(66476007)(2906002)(7416002)(8936002)(9686003)(44832011)(26005)(186003)(8676002)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/er97eA68TXEf+xqWAUp/g1xW7q3hZasclS1bhxjCE+Or41LoxMyTQgSeMEW?=
 =?us-ascii?Q?cRLot9OKlqCCjyUNeWQsR4LwrYiOt11Sx+7e/v0LHeUO+o5xmYVTWCGBSI5d?=
 =?us-ascii?Q?abK73MLWuPU6+wQOKGry4RLQYMZru8y99QGPZppBbfeeYbtxG2ggmHZS3bgA?=
 =?us-ascii?Q?OQpcaqwwjnGiqMlce0OhgjU/vxKQHtD8GKrK0pJPz0qTspLZl9dsDzKV1MTW?=
 =?us-ascii?Q?vNqSo49BU3smz5ruzD8lSVJP6tBQZupLmS538rwv/lhq+XXyVA9uYT6ubHS7?=
 =?us-ascii?Q?QxyOFJOKc3EuqxhZZeGGiQ5FpOFNCIdpQjmWG8nVxXXkwXqRn9q/2r5Hik3g?=
 =?us-ascii?Q?dr0JR/YJM15AiTkDdS1SXwXWddBKQMds4zait7j64mfaacOIe8IFJSeHMXSo?=
 =?us-ascii?Q?OAgDE2nhQoFRK+/UwX3oIn/L/CI6Ej4XAtr3jtf5S6OJlExAFI/0VghtSE5b?=
 =?us-ascii?Q?Nb8ev3AvNyO69vLozTvLH5DdXEbubifwK8lU8l5Lme0gfZ+iv63MBwfzRs9k?=
 =?us-ascii?Q?NeE+1hz8mokcIwlOidIiVWYWl4zh7OZgfQfIMlx1PwPKvfVdNmR/e0FFJc/n?=
 =?us-ascii?Q?oqpA2aLS1nMBxoy+FOpZ1Ev+7lPhdb0hIUQ2oTbijW+sVPmLj+whnSBipGph?=
 =?us-ascii?Q?Ol/QvoqOB8V2Rz8HwlMyz5L7jjJh2A/YD9nyZdUjhAe+Xl9KhnshoGdNhAYQ?=
 =?us-ascii?Q?GnP7/0hEwzn5/MR1XIXPiUkJBkOFqhhb5PEiw38hLIlUQ4/prGqUBjbgEXGb?=
 =?us-ascii?Q?pO7x8CNn8FyhSMN9sQxzYXakaCMYMaPloqddhD4r1WQgaf1MyUiaYQAigp/B?=
 =?us-ascii?Q?KSeldgdxN+5NYwckGS0R0ynZ7c4I76JfDN7D3YAGDyd/hIiKJYNmVeKcTLDb?=
 =?us-ascii?Q?ph50EEBlzAY0thfH5lsDFICyjO1ijs2GB6FSqqRpL2L/r3SH935lP54Dr2M2?=
 =?us-ascii?Q?ZiHH1zGh41VV5bToRtqIKi7xv3xCYpOXSpQ0cDqKYM3b0+uRExVvT0RO5sQm?=
 =?us-ascii?Q?fkAlnaCIkMkIUhOvbqQDb5Cp5YwwMMJgXmiLqsrRrnA8a1RYiEKjt7wIq6Ef?=
 =?us-ascii?Q?OwkQn+5E9jL6Ba5adQR88r/pIZjGPh1p+VicBq+o7Ssgu+gayLQk+ml+QI7Z?=
 =?us-ascii?Q?L8EdnSPyWynjH9nZ+FS2j8p33QoLOGP1ylTDDXHUdne1PDqcRnvFmDirw4Ak?=
 =?us-ascii?Q?EO0Pu6QBpp438zrOLISOzOyap6WAyb9E9h4D9UZzMrnQbU0ub99H7E6aBe73?=
 =?us-ascii?Q?ggOwV6qIzZoDypQypC5KIZkbtJB9SNtBXF/5tMenZRN8+465YY74KUEwuRFg?=
 =?us-ascii?Q?skEbfG4R+NWXIYRrhYNlfZOqdp61bnLoRyi2efJ6ezdaejufmTpNDW3g/NHq?=
 =?us-ascii?Q?Dwf0mBX8zZXl3d3r5q9jmX4/IQMD+dCqFUoa6Qp1mJAPe2AGEXEIJl8BRrRW?=
 =?us-ascii?Q?NjKSbkihfYQeihv3/+Oboj94zi5j4VvM44Mf/fWpKKl0jLCe7BHIrWKkyvTq?=
 =?us-ascii?Q?ybvRVp2SHsopSHLyoLbA09EdbYvVMRUm9wHGO1Oln6PcHDbUHrLW9Z/UkCJy?=
 =?us-ascii?Q?4A33sTFamN8i0OSBxGMR1xQ0A/5Yi2zABmGSqQXRdISxiCHBRb15rOeclRDp?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e681b3-1544-4e1c-5192-08daded2b116
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 19:29:33.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnRxYcEgQz1GjtoJmY1/Z2jzdsDnNSujlUzC91sv/g5uzmnkKHyU6AU5B0py4UKr6QcHR/oXZNYGfcq9qSO9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150164
X-Proofpoint-GUID: ofTZdSn6IyaxjEFFxX2ufIYVnibUtbco
X-Proofpoint-ORIG-GUID: ofTZdSn6IyaxjEFFxX2ufIYVnibUtbco
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> This enables high-granularity mapping support in GUP.
> 
> One important change here is that, before, we never needed to grab the
> VMA lock, but now, to prevent someone from collapsing the page tables
> out from under us, we grab it for reading when doing high-granularity PT
> walks.

Once again, I think Peter's series will already take the vma lock here.

> In case it is confusing, pfn_offset is the offset (in PAGE_SIZE units)
> that vaddr points to within the subpage that hpte points to.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 76 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2d096cef53cd..d76ab32fb6d3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6382,11 +6382,9 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>  	}
>  }
>  
> -static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
> +static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t pteval,
>  					       bool *unshare)
>  {
> -	pte_t pteval = huge_ptep_get(pte);
> -
>  	*unshare = false;
>  	if (is_swap_pte(pteval))
>  		return true;
> @@ -6478,12 +6476,20 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  	struct hstate *h = hstate_vma(vma);
>  	int err = -EFAULT, refs;
>  
> +	/*
> +	 * Grab the VMA lock for reading now so no one can collapse the page
> +	 * table from under us.
> +	 */
> +	hugetlb_vma_lock_read(vma);
> +
>  	while (vaddr < vma->vm_end && remainder) {
> -		pte_t *pte;
> +		pte_t *ptep, pte;

Thanks, that really would be better as ptep in the existing code.

>  		spinlock_t *ptl = NULL;
>  		bool unshare = false;
>  		int absent;
> -		struct page *page;
> +		unsigned long pages_per_hpte;
> +		struct page *page, *subpage;
> +		struct hugetlb_pte hpte;
>  
>  		/*
>  		 * If we have a pending SIGKILL, don't keep faulting pages and
> @@ -6499,13 +6505,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * each hugepage.  We have to make sure we get the
>  		 * first, for the page indexing below to work.
>  		 *
> -		 * Note that page table lock is not held when pte is null.
> +		 * Note that page table lock is not held when ptep is null.
>  		 */
> -		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
> -				      huge_page_size(h));
> -		if (pte)
> -			ptl = huge_pte_lock(h, mm, pte);
> -		absent = !pte || huge_pte_none(huge_ptep_get(pte));
> +		ptep = huge_pte_offset(mm, vaddr & huge_page_mask(h),
> +				       huge_page_size(h));
> +		if (ptep) {
> +			hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
> +					hpage_size_to_level(huge_page_size(h)));
> +			hugetlb_hgm_walk(mm, vma, &hpte, vaddr,
> +					PAGE_SIZE,
> +					/*stop_at_none=*/true);
> +			ptl = hugetlb_pte_lock(mm, &hpte);
> +			ptep = hpte.ptep;
> +			pte = huge_ptep_get(ptep);
> +		}
> +
> +		absent = !ptep || huge_pte_none(pte);

In Peter's series, huge_pte_offset calls are replaced with hugetlb_walk that
takes a vma pointer.  It might make sense now to consolidate the hugetlb
page table walkers.  I know that was discussed at some time.  Just thinking
we could possibly fold much of the above into hugetlb_walk.

>  
>  		/*
>  		 * When coredumping, it suits get_dump_page if we just return
> @@ -6516,12 +6531,19 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 */
>  		if (absent && (flags & FOLL_DUMP) &&
>  		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
> -			if (pte)
> +			if (ptep)
>  				spin_unlock(ptl);
>  			remainder = 0;
>  			break;
>  		}
>  
> +		if (!absent && pte_present(pte) &&
> +				!hugetlb_pte_present_leaf(&hpte, pte)) {
> +			/* We raced with someone splitting the PTE, so retry. */

I do not think I have got to the splitting code yet, but I am assuming we do
not hold vma lock for write when splitting.  We would of course hold page table
lock.

> +			spin_unlock(ptl);
> +			continue;
> +		}
> +
>  		/*
>  		 * We need call hugetlb_fault for both hugepages under migration
>  		 * (in which case hugetlb_fault waits for the migration,) and
> @@ -6537,7 +6559,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			vm_fault_t ret;
>  			unsigned int fault_flags = 0;
>  
> -			if (pte)
> +			/* Drop the lock before entering hugetlb_fault. */
> +			hugetlb_vma_unlock_read(vma);
> +
> +			if (ptep)
>  				spin_unlock(ptl);
>  			if (flags & FOLL_WRITE)
>  				fault_flags |= FAULT_FLAG_WRITE;
> @@ -6560,7 +6585,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			if (ret & VM_FAULT_ERROR) {
>  				err = vm_fault_to_errno(ret, flags);
>  				remainder = 0;
> -				break;
> +				goto out;
>  			}
>  			if (ret & VM_FAULT_RETRY) {
>  				if (locked &&
> @@ -6578,11 +6603,14 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  				 */
>  				return i;
>  			}
> +			hugetlb_vma_lock_read(vma);
>  			continue;
>  		}
>  
> -		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
> -		page = pte_page(huge_ptep_get(pte));
> +		pfn_offset = (vaddr & ~hugetlb_pte_mask(&hpte)) >> PAGE_SHIFT;
> +		subpage = pte_page(pte);
> +		pages_per_hpte = hugetlb_pte_size(&hpte) / PAGE_SIZE;
> +		page = compound_head(subpage);
>  
>  		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>  			       !PageAnonExclusive(page), page);
> @@ -6592,21 +6620,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * and skip the same_page loop below.
>  		 */
>  		if (!pages && !vmas && !pfn_offset &&
> -		    (vaddr + huge_page_size(h) < vma->vm_end) &&
> -		    (remainder >= pages_per_huge_page(h))) {
> -			vaddr += huge_page_size(h);
> -			remainder -= pages_per_huge_page(h);
> -			i += pages_per_huge_page(h);
> +		    (vaddr + pages_per_hpte < vma->vm_end) &&
> +		    (remainder >= pages_per_hpte)) {
> +			vaddr += pages_per_hpte;
> +			remainder -= pages_per_hpte;
> +			i += pages_per_hpte;
>  			spin_unlock(ptl);
>  			continue;
>  		}
>  
>  		/* vaddr may not be aligned to PAGE_SIZE */
> -		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
> +		refs = min3(pages_per_hpte - pfn_offset, remainder,
>  		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
>  
>  		if (pages || vmas)
> -			record_subpages_vmas(nth_page(page, pfn_offset),
> +			record_subpages_vmas(nth_page(subpage, pfn_offset),
>  					     vma, refs,
>  					     likely(pages) ? pages + i : NULL,
>  					     vmas ? vmas + i : NULL);

Not your fault, but all the above was difficult to follow before HGM. :(
Did not notice any issues.
-- 
Mike Kravetz

> @@ -6637,6 +6665,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  		spin_unlock(ptl);
>  	}
> +	hugetlb_vma_unlock_read(vma);
> +out:
>  	*nr_pages = remainder;
>  	/*
>  	 * setting position is actually required only if remainder is
> -- 
> 2.38.0.135.g90850a2211-goog
> 
