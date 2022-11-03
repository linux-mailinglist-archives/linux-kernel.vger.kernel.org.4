Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5776182CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiKCP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiKCP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:28:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D51A213
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:28:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FKGHo016080;
        Thu, 3 Nov 2022 15:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uNtqEUINUUTw69VS8YNOCCSc6ZCcGIp5qZpPdXraiAw=;
 b=PI2ZpOJnoiKOM7xy2uCVcCLgG/1FpwVJzRSoWYKc2U3Bg15qe+i2hTwHEMLpHWMBbtNk
 QTRuIhHubvykJalST8HssbI5L82zd6oQG0d9HwLVi88Tdd07wIM8IrOwJmRop2GDqlW/
 9MakHqGFrUIG7AtqqM3J0RDcIxb3b+P0nEdz3Q4pF4y319Ga1jcOtTLYUlwZB30Si4GL
 GjGV8UymeFbGjkKuuQnJqzZQitqbz9PsMDqy67q2JqJ4e4M2L8aEUB+WGxMONTiYxvau
 1yHLly2sbq6CGZs9pozK5lFXsc7cRysYnQJjnwJ2p8i6WyU4qB00glgC3uumtVPDI/aK zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1de9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:26:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Evd63027297;
        Thu, 3 Nov 2022 15:25:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm6rvh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHOFWJrgWbK08hKzOXGatM6ujHK5zi75JbAb44TaDGjcLXADf8CCMkmt3iNTkbanNFQpuJhEMt2m+uqWfXcyTgkXLDSfYXYgeRF7pNqx65ZOQTScjTazlbh3RWMzT65q81VB22LMaNZK/UIK5NryY38dU4iydh/zrCp6BfYcrPIqbeFQvs5g6Ge+pVH8Oz260f1kI3jTs7mIfCE1QdlaKBLUb2nQeBDRPXx5QwX6CjHPFDnmWLxzmg1cwtQJ4DNBjF96EQ4K94zXRqsMjBwTmDx+63+LaypxaEqnOtObwI1E7tlycWpJdFAc/1aOJsaGw2kYhMmV9PmOf5NwNHSLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNtqEUINUUTw69VS8YNOCCSc6ZCcGIp5qZpPdXraiAw=;
 b=j1JiCh6/KWbG6oL1Qe9veRJOP2sExxoop7qhkinqwasXMc4sa4o67PVnxER4kX0fxCBd1Pe6Kz/B2ryC2v1s9IuA9pxwE6npk3+7vQy4Es/OWYYggP9kIh8/rTRD7ITCrvL4jvQCmiJMsxwGpwzfxYGYLj6xcA2SfXUXXzZR79348/RSepA/uVtCJ5zdgRmUKdZcDm+hWsP4n6GJw7Dy4krDZdcidomM2N+kntsvDd+tnl6Llr4fbnU7nQRPhjb+mfNty9m+MBnxcBGQLs2fTk1V72+2t9dI5xlBqjItBsnUoi9lSWxolsrpTbjSrdrsO1Za1BTU6onJ/zvfpHQ6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNtqEUINUUTw69VS8YNOCCSc6ZCcGIp5qZpPdXraiAw=;
 b=mn2wOWZMwIoIrSvnFFwLGWfcB6rTIbDV00La/4wKKuT+0FLw8JQrYdOL+Gz/ctIkhSmlqm4dmCnRHHtZZPU+3xVwJ0PXMi2UnbWnYEFqzEu52YqdcZKZxuRhbvTTMfYjuew9B3UseUid5SewvxAYtPunzlsY9oNm+uU00BJT0MY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5696.namprd10.prod.outlook.com (2603:10b6:a03:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 15:25:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Thu, 3 Nov 2022
 15:25:55 +0000
Date:   Thu, 3 Nov 2022 08:25:49 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 01/10] mm/hugetlb: Let vma_offset_start() to return
 start
Message-ID: <Y2PdfXDBJjqZvp09@monkey>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-2-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030212929.335473-2-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 096d5ddc-5b9a-4655-4a69-08dabdafb371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AUaJi2uaw7XnTAobUd3raDhUiMBRvLEGqRgNCpn5AODL8rFNYgMrF8+r6C2bqO2/SBSb1TKWvv7g8k6UTck5VevnpZHG/l40bUIzexbZWcn4CpccKinxZl2ekpLn83aHvCXxYU9mz13k6ZY1y5y3OuNYO2y8IxQrP23dIsOAamSIvMexH7wcNWh88rTr/q6r4hEk8dIDw1zHtUWXZl1k3uVPEQieFgG64xvSXiLcg6rO8SxdHV1kAyL/1i2S7HBr9Kpc5j8WvRjJISyecH+0qQEr0SAktLLoLSpfDkJvpHsBC8sQ93UEniePogzXtDmh+S90x59lXfNuCoF1XIFfL3mBr7iyL0FblhOjhlQr3lKVCkXdLPglY4y9Iv9p1eh+HV5/Xl9ha5bkYFY0XSmsoSJltc+Tl7Hx/BdNeLulClfuWA6INEw4e82Hf21X960u551NjrC6iJYlFQDtNpqAizYnxYbqYcWKNKUCTnLjpb0StG8misUBkpdNmh5Aeq+QrZg1bnPL/DbTuL4DA6OGE7jsJiT5IRTlRah07uOfkdKYUCUQbDPy0GJ3q5r9/koPabbjJVHQ6RWDPRTYRgC22Pee5jLRWuhRcwdJsm90gA7CpV5b5Ra2TO6qLnwnV/OdI4x/ghZVGRkn3OBbHUwvdBAmA5G8Sb9GFIFFoKr96FWPmHoHy3t8zwc151nplTgZzCz4qesewbg9Mvgt2KDXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(6916009)(5660300002)(7416002)(186003)(44832011)(2906002)(38100700002)(83380400001)(86362001)(4326008)(54906003)(6666004)(478600001)(8676002)(66476007)(6486002)(316002)(26005)(33716001)(41300700001)(6506007)(66556008)(9686003)(8936002)(53546011)(6512007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJ/iNdfA8JiW8txy7TZJ/ulE20DKG7EBChuDzX1/buzoaHPhFJfd6iC9IgZq?=
 =?us-ascii?Q?8th8siRxDl4MplGlgeBwsKMMA0MKIF34wWhatrX5YCUVa8zEirvnks49XyaX?=
 =?us-ascii?Q?LWb3Z4aDipHxkrSRVQwQKSV+DPsiuhnyTSjjnwIeqkBiEj5y2wOaxZ5ddMS+?=
 =?us-ascii?Q?av7WGe1nXBK6G4uwfN8ujJXJ4uQSjFK8n7VbOH0eZ4NCz76D9U7hlVoXPUZQ?=
 =?us-ascii?Q?nVNbTBud7m2967Nf+1Fdnd3KocgNQr2Fv6Ej09WENfaQ6u9tZ/FvTaN2sneA?=
 =?us-ascii?Q?H/oCty+DHnt8sFajoyYYsoqx6en4Zo5vk7k4TT5xqCYMRTnp2hoByi6ADgbP?=
 =?us-ascii?Q?Zs3/zr15eMYbgP6kjxAyxa23mDaIOY88DvC+1fCq45w6N4IjwvVjBBLvxih6?=
 =?us-ascii?Q?Q2GjX/nSl9RWe+9j+cx4k4Y3f5JITKFipnkTVCA1aE+NyOqrS6ZAuYfZnmmD?=
 =?us-ascii?Q?S+3CS0vazbCWHA3m/z+NwdjX99PSx2gQcgtAIKT2CEOdJ/GQ705tDdPpPN8V?=
 =?us-ascii?Q?z1nMbXt9M0POV3id1Ga433/zVErN3QJf1A0oUhcxd0Pvrsp6NM4UckZ5d3Iu?=
 =?us-ascii?Q?Pz8gUFtsXvDVyuWrfLsE02KrdMrCj3jpMHUDb90i/gnV+6JzQzDj8WJdCXPR?=
 =?us-ascii?Q?xd9fcjxkfTmxqERdVSlsFiya6TIr5ivBvWNQoq4BpEIVvwGvcGK7JiEatXmU?=
 =?us-ascii?Q?oPoq5V4ZCCAlDb8oY3Ixblb7Vp29TAYeUFAwZroNdhbnoQble9FcBkXSdOBb?=
 =?us-ascii?Q?yc9x7hMNSlw6EdTOYvX78PWYbuhy5ttqSNqkMB7wRz0u2ujlggeajDPPBzzN?=
 =?us-ascii?Q?oTBrD4qkDyxdx9l8eulIP4MYXqqH/oEiZWUWe8lXcsszkfluYRUB2abYZK0/?=
 =?us-ascii?Q?aHdM3TJ2cCGep/Apj2f5XSa3332kL7Mbu6LHTBn+Zum5XPmi8W6/UHkh9Ll6?=
 =?us-ascii?Q?GEuAGTg+PS9HqQFC8D4mW4NystJcyD/JJXhL7Py5D6RK5vCpZDGLzUeFbAmA?=
 =?us-ascii?Q?YvvpVZdluDacEA6mS3NRtNZ1mhAnBuf4UJalvhTgdzRvBSWCVUyEYeHuC8Y/?=
 =?us-ascii?Q?7ZR30PlR+pQGmFO0TZvX7qz+tAcKvTpBgAIWIkvtFoyu2Nea+E7NcCMkkdBH?=
 =?us-ascii?Q?QOgXqucNAyZTtLi5XWCXPn+hlJVGOIhro7d8bUlgRYJKv25sA1M/rx4fXr/Z?=
 =?us-ascii?Q?mSeAoq9PZr1aqn5/bNUaJ2TPDJcJVVDJGWkHu+NW/49kavTeP3Q0uBRsUxH0?=
 =?us-ascii?Q?RR/0khXG7Pj/mS8M1k3HYwY9yBfO886GeMi9XWNgDxsW0qe45iJFi6ANhPkR?=
 =?us-ascii?Q?EBEn/iS8sbzfUWUXjZfDaEzCMnUQT+adqT5cCTND5X4Q+JVxGJ92SPdzx6rF?=
 =?us-ascii?Q?ZfWu3wQs6MC81jKcXiQw5F8p3l079aihK2iMAbdKmiTdPC2PDrjKGdFcwT6W?=
 =?us-ascii?Q?IM0oNJxwLgYXccAPL6LyGGrwvTAQ5lzorTBNvw/DzCFJK5AlyNkxaRNsPXfN?=
 =?us-ascii?Q?uoYJubrhuBo/9RAG5kXGcVONsew9Fx0GcchsVyVz/N0imtUJPDdxkE+dDIbs?=
 =?us-ascii?Q?z4v/0fTM3eOASDqnJgktZlg3IGMzG9ZLXwTr7mvbRiHNktw6wra1KP0v5Xc+?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096d5ddc-5b9a-4655-4a69-08dabdafb371
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 15:25:55.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OszYJMALEhO/fc21oys88+diQF4QzDqREuFtJBiqdAvCUgYFrCQCVqhdyRmB71IDEyRsz8c97/AC2FVF1elzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030102
X-Proofpoint-GUID: gPIhmwI5Se9GzHxJ3mKMdBU2eeySzXMn
X-Proofpoint-ORIG-GUID: gPIhmwI5Se9GzHxJ3mKMdBU2eeySzXMn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 17:29, Peter Xu wrote:
> Even though vma_offset_start() is named like that, it's not returning "the
> start address of the range" but rather the offset we should use to offset
> the vma->vm_start address.
> 
> Make it return the real value of the start vaddr, and it also helps for all
> the callers because whenever the retval is used, it'll be ultimately added
> into the vma->vm_start anyway, so it's better.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/hugetlbfs/inode.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Thanks, nice cleanup/simplification.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3ee84604e36d..ac3a69fe29c3 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -412,10 +412,12 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
>   */
>  static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
>  {
> +	unsigned long offset = 0;
> +
>  	if (vma->vm_pgoff < start)
> -		return (start - vma->vm_pgoff) << PAGE_SHIFT;
> -	else
> -		return 0;
> +		offset = (start - vma->vm_pgoff) << PAGE_SHIFT;
> +
> +	return vma->vm_start + offset;
>  }
>  
>  static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
> @@ -457,7 +459,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
>  
> -		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> +		if (!hugetlb_vma_maps_page(vma, v_start, page))
>  			continue;
>  
>  		if (!hugetlb_vma_trylock_write(vma)) {
> @@ -473,8 +475,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  			break;
>  		}
>  
> -		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> -				NULL, ZAP_FLAG_DROP_MARKER);
> +		unmap_hugepage_range(vma, v_start, v_end, NULL,
> +				     ZAP_FLAG_DROP_MARKER);
>  		hugetlb_vma_unlock_write(vma);
>  	}
>  
> @@ -507,10 +509,9 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  		 */
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
> -		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> -			unmap_hugepage_range(vma, vma->vm_start + v_start,
> -						v_end, NULL,
> -						ZAP_FLAG_DROP_MARKER);
> +		if (hugetlb_vma_maps_page(vma, v_start, page))
> +			unmap_hugepage_range(vma, v_start, v_end, NULL,
> +					     ZAP_FLAG_DROP_MARKER);
>  
>  		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
>  		hugetlb_vma_unlock_write(vma);
> @@ -540,8 +541,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
>  
> -		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> -				     NULL, zap_flags);
> +		unmap_hugepage_range(vma, v_start, v_end, NULL, zap_flags);
>  
>  		/*
>  		 * Note that vma lock only exists for shared/non-private
> -- 
> 2.37.3
> 
