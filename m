Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296825BD761
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiISWdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiISWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:33:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A824F696
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:33:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMDxq9015095;
        Mon, 19 Sep 2022 22:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ntvMd9xbvF+hNYWgPhXUCWBRtoWn9Ruv0iWdWRc59kI=;
 b=gMpXhWE32IYsUrp/JxXbh4cuA20HSXEuUrArqziaCfPBLUN16rcNV40iNZU2C+6uCd6r
 gFfbg3Ko2wLI83OZgmJnWo0hc/AJ0npyDvMIc4uAunOKoizQn4AGQ9zR+3bIFi0QgukQ
 zCC4fMFvTgN++9Nq5cryDMwegAvZJYu6PVMSmiAe1envob5RPOXwWpoAWxNUJeJ3Ey1x
 6sYGbaxUYjRE6Ri6DM/F1umV8hIb3/xqELOoEp70YkfRZshNZlZEScKYWKHQxB3JRUPn
 VxjM+cnqkYdYTQmaXzEeg/hsq7k4xCCPQ8vktV5bVcsTChWJvRVqHlSv9Y9FRE+hCePd gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m563n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:33:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JKcNcG016538;
        Mon, 19 Sep 2022 22:33:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cmm271-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8PUNrME76HZZzgtJiY1SZz52xn7pO9cxpt2EOWl5lPyxtcl5QALcO3ZELAB4K+yWdB8WGP/mfkAibF8EgUpZi0cgvX/EHoqDHXrqIaPI/bTbIvevQ4P8bmJbCWUMEnaifbGMim5aEQH3una6Dfux0gYcoFPg3BivK3jD1cKBJBcZbh+8/1jQTz4f7O8pxCsSpJe3WdknHAvwPe+Ji+pghh+r3pZA7taihmaiFpiK68OyfwDYO7NhYfhZjFKMmVUY2CCynxNQkD9mWA8Ezn6XI+7z1ZJr/n/YUtmGjCgYiuifkTYm6jMymJgO4Cqh2NWwPJu2lJ9eQ8ZV7LyLVS5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntvMd9xbvF+hNYWgPhXUCWBRtoWn9Ruv0iWdWRc59kI=;
 b=hX5dRz6f8MJYKaKUcpzTKPy2cW3oAWYLSt3rLhrd5ql5WLp/TnUiPalj09g5UaX0zE+LKoPj4ruGzqp0QreTWuSQuWI2khFRy165HOqscQhdob1g1f1P5mrYhQ95FIx5uXNtiTI7YyQTdzUeOljQERlSMRaGQ8jF6lkkHNN61gtxdswWsBAQwo8BKKlaKEAKv29Kmj0o1eoL01qVfgDC8E/fEgyKr3C4SLQrMBBb/+wQ6Ty82EnIQsH5pHfuOn03Jjb7Ki7hKwuHYB1Tit9PoAjpnNy3Bj3s4lnohLESLVsFfiXGW6v+UKi99IQV6K9J4aNUtduBzzXk1k0QQZh3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntvMd9xbvF+hNYWgPhXUCWBRtoWn9Ruv0iWdWRc59kI=;
 b=yD/0PHQrHJ4dqQW1ei04vDbNrebO7qFmz5yulBvCWsAAqPs+gbaxpL6OXEb0ksSTfun8iqSKr40MzO6QMJzQ0MQNGxN9KZRcpRCYzTW3DS+kOgkcfIS+ct/9HkQ5+1Cu++nUwfHIbAiC8bHMC+9vv0Jq5OhffcU1pFCw6RgYMB0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5373.namprd10.prod.outlook.com (2603:10b6:5:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 22:33:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:33:20 +0000
Date:   Mon, 19 Sep 2022 15:33:17 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH v3 5/6] hugetlbfs: convert
 hugetlb_delete_from_page_cache() to use folios
Message-ID: <YyjuLd8f8/bP2CdA@monkey>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
 <20220908193706.1716548-6-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908193706.1716548-6-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8241b7ed-d33d-4540-3159-08da9a8ef42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bdm98+T2vBEyIUaS8FzOFlOZkWa/qYKKSJRbK2LMW6pOUocY2ntFqdF198PUWxzaI01J6Yi+sa1QQB1RF4+tjGbzoaTvRIVtb9f97SWPs0kxNaqB28jqLkWHohSDnvVz07Qb80DKh2eZto3x0idmBWmoPfb6BU5bTht8r5qNt/R4fmdkfKG6Busc+pKNeUt8mWYIwd+hi8MPa3gdP12P0mZD08g5Vlt9b9Zfc0hvB6YZADxwdivZ4wiJSRcD01ukPx5ihE/6XjoXDX77CJukEPydgnuO4goCJR3XmeAF9OMLtpwlbRxsbsieo/LTs/cGLtXNgsvqO6Ia28dR3Ye/pADbc0O2SeQy9/kvpKDlv0IZcac0DmlVYjFiWaalPYyyGWqr21iKDkKMhTJJkr6bHWlYvsc/Jrcwb6IVTVzbquGrH5WegP7Yy99icjEuIObT/zD5RQ2lYl22npRwgEG6asI9dge/WZVBRPHQUZYQgLjPpvBGcy82uWZezf8QqZIxUzNW43T0dw3sa63KVns6j1mrMDXGlCvH3bT83vUNiay7tVnv6YIKgxcruCUojvllTHzr2evqi4JZ2/XefJ3Mb48jLvF32fCtLHkMCwGdxl0BtZ0qkuMSUjcfHInaXTyW7xrK9wcYKQ6vgwgEMbaBYhEjVTsv3AffKUB+zpGh33pey25RGDAe2SIqQFoTYoo8O27KkydGCm/a1eWlMTHtag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(5660300002)(7416002)(44832011)(83380400001)(6512007)(26005)(33716001)(2906002)(316002)(478600001)(6636002)(6486002)(6862004)(8936002)(41300700001)(38100700002)(9686003)(186003)(86362001)(66946007)(6666004)(66556008)(8676002)(6506007)(66476007)(4326008)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNEiyT2ch7kqlz16dW2v41f5XhsyhfUGu7UEbh9gh9GLXQRH9EXBkLUHnqMo?=
 =?us-ascii?Q?t4CrXgHR8ife9h1RtY7QKON6+RaA9rCSLycFGk+Yg5KdpD5s1wrkC0Gw0lI8?=
 =?us-ascii?Q?VoyiR0TGicc5RvC3W0ZQCvEGd897zfWz6/hGQhxp3a2PQ7WZJdM7suaPedfO?=
 =?us-ascii?Q?T9XU9uBfquHWpFCcTHlvmPuy4Wf/WX4NunErHKPlrxeIVQ5EeVJEBNyiFkGH?=
 =?us-ascii?Q?5EyfszsCPKz2YZHtFRTyjwV7Av9oypvGw8ypA/3GAFlLc4towLXPaSMpqIZ7?=
 =?us-ascii?Q?p3ghCPLq1LJPcEup9qvzL2TjdtTkFmziE8bvpD5vJOF3FTz8Fb6KGAUgiv4p?=
 =?us-ascii?Q?GifsfZvtZ5ynUktdMO2TuGPs2F9LoLFL8AT5ZW4DDChfs46xELT2W1U1bTxl?=
 =?us-ascii?Q?sKAiw27mPxOT6bGTmQhCGR4HWnBDkEXGGOTMg3dZ/Ch8YOjJjavVu4ij933K?=
 =?us-ascii?Q?wURSl5QlgpVnqJapGzd+T4BGbHNnMXZ7a4M/0ByEl+HKvS4+UQ8WptJBlW/U?=
 =?us-ascii?Q?J+s9/7fSIz0gOcC2hNn5hKhDpZA2W7Sh2K6zQ/01y1c3x6W8tT9xSG0nJqDM?=
 =?us-ascii?Q?8av6mJq1hv4LoUmj9J2LxrWGqHGejC6CFqm0K+tGCqQDGpdPDRHBq1F3CvFE?=
 =?us-ascii?Q?DtmAhzHxkbhMxPPBrkez3fzCEr3sLllGazpDsA/ugsOOhysv5Wc2M3qR2GtZ?=
 =?us-ascii?Q?+PbZIf3nMWh7HZybAZWEoiB+spakjciSkO88zUqwzerGXkbTlci67Kss0Zb7?=
 =?us-ascii?Q?dwzhyIxCcfk3h//IN6ZZEw8B88NF0GjJahWaKaz45lTojdyrBHd9Pa1OBZRu?=
 =?us-ascii?Q?UEvvOrnhcpMS6buHZ4t/ge3CNPs5a74j2YDzCD7/aP6CZm0jOZwEAGVUabNI?=
 =?us-ascii?Q?gbQuOgxtNDxXGhT6O3cG16FFXLgQ9f0JgvaG1wiS9ZeXA9n6X3BElV7lCLS6?=
 =?us-ascii?Q?KAj1oDt+80HnUBjPHqhzdG1PWQ7pmPjyjq4O/tFWGa+X0V/dkIT5PwDTQ8Mi?=
 =?us-ascii?Q?9av69MJv7KvxUkppIZKQ0I4rAEyOznVPTOQWFhLGwckIJimhZVz6MD1JILwK?=
 =?us-ascii?Q?wUx35f+wGeuAIw8ap6tmqvN190Q5Vx9ts22hnqrUWwAIBRlF2qBeuXQ4GpTW?=
 =?us-ascii?Q?Sqc36oBdMg0+fSCeu1qAt0EQq5/u95jczmtmhAL60dZq9sBZEL78Q415wy0z?=
 =?us-ascii?Q?X9xvpeswyslcpnMdmY0Vc3OWErunBQlismwvEybdvdGuh4YV5PETDE7Y4FpA?=
 =?us-ascii?Q?Dru28Q/Fe7qYlhkxqNx5l2UHWfnor9r4U8kfYOPbu8/KcJqH3TdAKSlPIYYy?=
 =?us-ascii?Q?sY0Y99rsQkfxLfdKmQ6O1s4JPl8dfTl8HdjRLPYDcH20UWKtE/LtfjGgCxOE?=
 =?us-ascii?Q?lP98nopnQEmxNIqYcEbcjQYR8twtAOiPPlnFz3/kAij46mSDyHWMciQfln6N?=
 =?us-ascii?Q?HqB8fwyBKEzuMmk527gk84UEwv6NFN8l3wjGXkXoA6ibDESK8teKTXO5sPze?=
 =?us-ascii?Q?VdekoSKEECMpIvAu141afKG5lARY24vMd1bvTzeWwJG998ZnjFNMvMC2nYX8?=
 =?us-ascii?Q?EbDc4ppibLJJnskTjLzjEWUNCzbXBELRS1rzNxTk7NYMU/DTBD4rkp4yNKxk?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8241b7ed-d33d-4540-3159-08da9a8ef42a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:33:20.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3eY2pUgqcp603R8IgybyNH0Pg4Ax3x7iCwey59mT1lkHMk2FMI6awFvWuohxIGl+ISRuzyLtoq0862YPkkFPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190150
X-Proofpoint-ORIG-GUID: oyuLnVpLm9SJb1BL9CGMUZzrkl8gBfMm
X-Proofpoint-GUID: oyuLnVpLm9SJb1BL9CGMUZzrkl8gBfMm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/22 12:37, Sidhartha Kumar wrote:
> Removes the last caller of delete_from_page_cache() by converting the
> code to its folio equivalent.

Changes below look fine.

However, if this patch removes the last caller of delete_from_page_cache()
then I think it should also remove delete_from_page_cache?
-- 
Mike Kravetz

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index d9e08c445e2f..38920702765e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -364,11 +364,11 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
>  	return -EINVAL;
>  }
>  
> -static void hugetlb_delete_from_page_cache(struct page *page)
> +static void hugetlb_delete_from_page_cache(struct folio *folio)
>  {
> -	ClearPageDirty(page);
> -	ClearPageUptodate(page);
> -	delete_from_page_cache(page);
> +	folio_clear_dirty(folio);
> +	folio_clear_uptodate(folio);
> +	filemap_remove_folio(folio);
>  }
>  
>  /*
> @@ -562,8 +562,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
>  		 * map could fail.  Correspondingly, the subpool and global
>  		 * reserve usage count can need to be adjusted.
>  		 */
> -		VM_BUG_ON(HPageRestoreReserve(&folio->page));
> -		hugetlb_delete_from_page_cache(&folio->page);
> +		VM_BUG_ON_FOLIO(folio_test_hugetlb_restore_reserve(folio), folio);
> +		hugetlb_delete_from_page_cache(folio);
>  		ret = true;
>  		if (!truncate_op) {
>  			if (unlikely(hugetlb_unreserve_pages(inode, index,
> @@ -1174,7 +1174,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	pgoff_t index = page->index;
>  
> -	hugetlb_delete_from_page_cache(page);
> +	hugetlb_delete_from_page_cache(page_folio(page));
>  	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
>  		hugetlb_fix_reserve_counts(inode);
>  
> -- 
> 2.31.1
> 
