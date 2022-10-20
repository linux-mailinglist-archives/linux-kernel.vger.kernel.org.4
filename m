Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB75F60544F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJTACb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJTACU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:02:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EB16D882
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:02:19 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JM4jZq032011;
        Thu, 20 Oct 2022 00:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=g2rDt0HxEKaXibvyik57UYA4b+8OS9QLQHJVC4Q9zYs=;
 b=Rvn9kF9D+DV6liMPBpt2Z/IMEroE0A696f2TuZESGvPLFgfpFLmQWXaI+NAOKEX7lA2D
 WLVyaShehxMsMdI0uTP+fbz3iQygcuFbYrg5xXVIsvzYID9PYojKIT7QhXPPp3afAJtx
 DhxOoRfKxZF6l+tukjz/Ds4ZS/SQ5CzLib7q+lZjeVEDumEGbj2sk3CQ7wIER2Qr7y+p
 hJPM2e2DuMG1Ka/74Mg4Jw1alQXA1fCPngpE33YtGdlbPZjucx2lpk8L3P3mKd7k7Mfh
 WxXG6ZILGIt4DGhBdFDL/rl9k0eJYBegZDWqPIowOi/FvKKwDFxsSL38lrSo6YS3iLD0 mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww750d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 00:02:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JKjBg2002735;
        Thu, 20 Oct 2022 00:02:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htj1tyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 00:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuIFuO3ueI203JtcdDQUwPJNi5i3FnfOaKOlwFbvWXOpEjSqNZ68How9DgoPZ09ksgNOv/tfeOHp84hkh56dQK9i8tFCU0CNbg1BBIYSnf+WxtcvZOjml7f5tjKnyww/Kzwe9oQxdgA4QYlcmVshIAcWpydEjLth9tVnfbDtbQ2hhgPpbpSQmqoLTWhpb1r7dUHS4t4pO+vf/p2Pout899rYAt4O6g/1vXsFGXBPlEESSfv+XbQ+xpqB/h4+tKUfOcpyMKqGVvubxBLzGDBcIcJpof1qo2OGZYEITsfemFNfUeUF3qX1VY2VCc2oUw72TRXy7f1Q/C0rpabs5GlClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2rDt0HxEKaXibvyik57UYA4b+8OS9QLQHJVC4Q9zYs=;
 b=HK+1pBBZOmAo/nXD2nfkgn4YzsuviKONnTYeGCNGJfPS3TeInyfkeG2HuneW60WFOeHm8cXyCmXr84vCU51DnPCfrk6ppkV2HqBMxW02s49UdcoP6NcVWOSfMo/LZVnxQSfASafL6HEkC57LgxicRhprhOKdYrOkQLxJglpt6ztn00nBBVL0HEi/IJXCgxHAvDhJXZHhhnMV4q9Xd2Oy3KN0pdIOk03YlJb3RSpmZVqxOkTv9/SgAHZGYl7pwHvKUcsaewSbTujBmkM34XKbuqT+XcA8dH1seEVRvFU0cDJ1kr9e0LY1meYtgwHlvvfSJ0oNL+WOOQoMRadEEhaKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2rDt0HxEKaXibvyik57UYA4b+8OS9QLQHJVC4Q9zYs=;
 b=MWAlyB3Jky5+8GY5nEbBVvUOVp8i5H8rFehpIdnSViXhtNRHuYD99t/zyG0o3H6KryzpHmR4DuYsEBjB725gBmusoDIiAJoUAXm/at8GFWW3k9Dnu+fkVHAvO/2cKyj00E5+oAztarMKLY5koub01ukTM6bNu3TURCAeyPvdPTk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 00:02:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 00:02:05 +0000
Date:   Wed, 19 Oct 2022 17:02:02 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
Message-ID: <Y1CP+jEO+cIEOejb@monkey>
References: <20221018200125.848471-1-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018200125.848471-1-jthoughton@google.com>
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 988f3a86-50b7-4b2d-99db-08dab22e52f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk57bGv7FlH2Al3pNehVNB0NCCoc8mk8JUidMQiXnJWduJ8PcvLhVF+/rAYPcA2RG9Ja3JSQWyg+b9lzYaQnQgH1NjnCwSL9K/6N9TbQ696SRvxNgsaqkqksq+7iqBlSKTMKxiT6EwVxqMY0Kikj2Z8zgA53jouj5jDueFGMLjl/ympSnQ9FDjm3O6/mEYW8lHFuWq4JGIZkn9k4v3mEeBHauTf2BScv7chfG7Vfc/Y2oedpRnLveE7mPTXpoEZQBXM4Dq7QBXVZYQRFPzA/4wHirutm+5vcDQyG9BOgO6sqf32D7lI002G2NK+/00idBQpKDyYLSIxyxwlHh5miGjH2NgKmwsKaF/vWvnAqoaVnh8Io3YL4Q93VUsEA55GrkiGtH59gb8IcmAS+j9EUE0ePrzj3gVj1C/w2WOcvcyUz5wH3oC8txa/zBW5/oHpIjiF/qR/QSS766xgazmeoUTfHlqdx1hyAz5Cb9Y2TBesLlMqX2r6XK8n8eJYsh2jwx+ZDq7xpUA8TKkmIIh7nmNdlFOR2FMuSLgDXoXErupdGvUtpS3YFci4NurttNIXMabkFCuyeFA2je7g4yIKynqvTwcG/tX+ycaFBSDNcZVcnwjFVXhLS/2lZiJhVcQUqDNGWi99fUOLJ219wKHHKoNQZZ3576LiBKqq4GZQT0SZlwhxkoATu23yG+NYflXNcz5DQLpJHR4M1OMazvGgCrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(2906002)(5660300002)(6916009)(54906003)(8676002)(4326008)(316002)(33716001)(66946007)(478600001)(6666004)(6506007)(8936002)(41300700001)(6486002)(9686003)(6512007)(26005)(66556008)(44832011)(53546011)(38100700002)(186003)(66476007)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lf0eeSsigCtcUgaeUcJbRlcjg9Tcv+HIODlMhTudAtVkLnWLWEiH3fQlylff?=
 =?us-ascii?Q?tLK7jIBd5yo9mnFlN5z5xNXU9XY5Luza+4srmGYOCha9IPocVk60auIaumlw?=
 =?us-ascii?Q?I039eb3UM8F1nsPjP1qtOMURswMFnsbZ8yfVv4XPnzQAttbwA/Cox9HNxTgf?=
 =?us-ascii?Q?IMzudmLZOYSi6cXRvKUl5tq5oZ+foFPzP4axPyWzaiP+hOmMup6hIT2dw5pJ?=
 =?us-ascii?Q?/bWDL7NIebPlVnoJBDU66fRDU89TxXTJguorlyvJrC0v0hK0aMQmP++LyZh0?=
 =?us-ascii?Q?ccI4XrdSWxYNzNo6eELEssmslMeN13ogUqFnsu5+rBI51PbGfU6ObHtaDkrW?=
 =?us-ascii?Q?X2DTj4vzK8YzPvsN2fb5EPJAAOltd3DVH+H0t9rabXHY1afnkq+DsnBqecNa?=
 =?us-ascii?Q?gIW/ubU+rhhOV/oHI9Pa2iHLVVHq6AWAj2LzVe7vNMPrUEoiBMak9yHUWypn?=
 =?us-ascii?Q?Z5r8B8/IhKtzG230FUExbpT47naNr1Gaaikf1cgM7iFVbid2SwKCO346CT0w?=
 =?us-ascii?Q?oDBf3e6kwCKltGkuAnz3XkHRxMPPWUjz30s61ZFWcLlH1I3SVT3nX1iYER4G?=
 =?us-ascii?Q?iuciPdcXqUgWKWa4o7Emnl5JmCrrTtqSPL4kKVMUDRHSp3ye4YK/Z9nNKsdS?=
 =?us-ascii?Q?pHE9uZi9H60BTjYZtWIy3LVrNA6HTQWulSh5ONPcLM9vS45FjFLEnyzrULP7?=
 =?us-ascii?Q?KBrRjCPS6bBjnocky+rL8LQs9zU8QU34yNnLHpVXZwuQuMTLYoARkIZwkPeY?=
 =?us-ascii?Q?W6ZrwCfD6kOau8nAyJPSYovV0MdE8k36EznrhFLuSh6lDqSJjDab8exWm3qs?=
 =?us-ascii?Q?pvfb8sdAUEBHBPgUod9bRTT7pA1LU1MbW4RgKROijXjN2wsrM0Th4mp7dlsv?=
 =?us-ascii?Q?U/mXzEi43taUuvAuq+EmL/DQr3pPtRNpNCtH5OzYoXrKlxxP6lzq7U2VDvtZ?=
 =?us-ascii?Q?MqEe8EIbhwoni+NY4+i7fOVSsyBmHiw/ut2U0luGjQ3w2FPsrsNDipWZSdK+?=
 =?us-ascii?Q?KrJSG9gPKwED66zX0Onf3beljyh7wS5kDdJ4alu164CWWy3QxYO52FIWWEsp?=
 =?us-ascii?Q?X3SW+ZSsIjq7OCDMr9uLlabjkzzDPUoSiGa2eGLG+XfIN30C1NvbECi/ZgkU?=
 =?us-ascii?Q?3fWkPQIVXuiF9bd0/bDH3ut7Z/YJ5zM6jC1e7606IXvp+Uyd65OsBkd+YQaQ?=
 =?us-ascii?Q?xGkvgqyM6B9FiXIPFLwONzpG5WvhbaQk8tKAlFrgYrDl4hlCtKOKGztSs/Kv?=
 =?us-ascii?Q?pMt0unV2rdTY1aybkbQ8HEoBKhzTO51yT3O/Q2kHtRn5Ig3xEeY/ksUf6IT5?=
 =?us-ascii?Q?vc0AEb9EzBIYCFV1S5HOG3S/LalbZwvvEEJbdgC6Tto1+ssZdUgCSR09XN07?=
 =?us-ascii?Q?81LSOeD7pFLO0LyIvj3+Oe6Gb7G1bLQTgHI4RIPhqobbDxPz+Gg2cWhDWh0e?=
 =?us-ascii?Q?fTE+pjpBahLXGZ9hTkCjyNNDZjFT8Nux0EM1OqKIRKEsxAUXypPrtRAHjffC?=
 =?us-ascii?Q?rmedaIQsYSro/gwX/zky9hs5GoeaZlUW8bXNivzQz5TwHif2cSJSxv3jjQx/?=
 =?us-ascii?Q?MxUkyHfj/x9oM3YxHWrvzMYIMQC3zhPO/pX8Vb0bWW00s1zYZFkmpA8NZtnj?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988f3a86-50b7-4b2d-99db-08dab22e52f2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 00:02:05.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQjCTmKdVWmAQ3YWpKZ7SpXAtZKUDyNq7/RIL01iZn3KWwjDlEnoAphYGDuUJ9vV6jp6NyLx6MBRpRoB8Lg4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_13,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190134
X-Proofpoint-GUID: KIR28bsMWrclQ26tPdoribFGnllctSgG
X-Proofpoint-ORIG-GUID: KIR28bsMWrclQ26tPdoribFGnllctSgG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 20:01, James Houghton wrote:
> This change is very similar to the change that was made for shmem [1],
> and it solves the same problem but for HugeTLBFS instead.
> 
> Currently, when poison is found in a HugeTLB page, the page is removed
> from the page cache. That means that attempting to map or read that
> hugepage in the future will result in a new hugepage being allocated
> instead of notifying the user that the page was poisoned. As [1] states,
> this is effectively memory corruption.
> 
> The fix is to leave the page in the page cache. If the user attempts to
> use a poisoned HugeTLB page with a syscall, the syscall will fail with
> EIO, the same error code that shmem uses. For attempts to map the page,
> the thread will get a BUS_MCEERR_AR SIGBUS.
> 
> [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  fs/hugetlbfs/inode.c | 13 ++++++-------
>  mm/hugetlb.c         |  4 ++++
>  mm/memory-failure.c  |  5 ++++-
>  3 files changed, 14 insertions(+), 8 deletions(-)

Thanks James!

Code looks correct.  One observation below, but I do not suggest changing.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index fef5165b73a5..7f836f8f9db1 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -328,6 +328,12 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		} else {
>  			unlock_page(page);
>  
> +			if (PageHWPoison(page)) {
> +				put_page(page);
> +				retval = -EIO;
> +				break;
> +			}
> +
>  			/*
>  			 * We have the page, copy it to user space buffer.
>  			 */
> @@ -1111,13 +1117,6 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>  static int hugetlbfs_error_remove_page(struct address_space *mapping,
>  				struct page *page)
>  {
> -	struct inode *inode = mapping->host;
> -	pgoff_t index = page->index;
> -
> -	hugetlb_delete_from_page_cache(page_folio(page));
> -	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
> -		hugetlb_fix_reserve_counts(inode);
> -
>  	return 0;
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 97896165fd3f..5120a9ccbf5b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6101,6 +6101,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  	ptl = huge_pte_lock(h, dst_mm, dst_pte);
>  
> +	ret = -EIO;
> +	if (PageHWPoison(page))
> +		goto out_release_unlock;
> +
>  	/*
>  	 * We allow to overwrite a pte marker: consider when both MISSING|WP
>  	 * registered, we firstly wr-protect a none pte which has no page cache
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 145bb561ddb3..bead6bccc7f2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1080,6 +1080,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  	int res;
>  	struct page *hpage = compound_head(p);
>  	struct address_space *mapping;
> +	bool extra_pins = false;
>  
>  	if (!PageHuge(hpage))
>  		return MF_DELAYED;
> @@ -1087,6 +1088,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  	mapping = page_mapping(hpage);
>  	if (mapping) {
>  		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
> +		/* The page is kept in page cache. */

That looks a bit silly as we are know truncate_error_page() is a noop and call
it anyway.  I suppose we could just set 'res = MF_RECOVERED'.  However, it
really should be left as is in case more non-hugetlb functionality is added to
truncate_error_page() in the future.
-- 
Mike Kravetz

> +		extra_pins = true;
>  		unlock_page(hpage);
>  	} else {
>  		unlock_page(hpage);
> @@ -1104,7 +1107,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		}
>  	}
>  
> -	if (has_extra_refcount(ps, p, false))
> +	if (has_extra_refcount(ps, p, extra_pins))
>  		res = MF_FAILED;
>  
>  	return res;
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
