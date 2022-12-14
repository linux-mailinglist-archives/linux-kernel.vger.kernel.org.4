Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669CD64D391
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLNXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLNXij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:38:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA331EEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:38:37 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEMwoIQ024286;
        Wed, 14 Dec 2022 23:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=9Xw5xLs4vhJTuOLnrwqirHrGnV87hNYsxXExYsuLD9A=;
 b=yFq10o8BdpKwgQCc8N6K2jxN3g/GJc7RWtVmZpmlxGgJHlFHl7HlbIGmMpxG8ku42b18
 Yz2rWZU7D2FXwJ5BKjhzcn35rdd3iXKBLvovu/+BeTueAixHTaGsXrmI68Iu2IstxzEb
 fw84S1vt0qCiM0uyF74BV5Fv7pDTolU8+y/vo6cTrDz9XsoTVhDhATJ4EZZxuYe5zF3x
 jv0V2/bz0VUKRRiB7pab328ShcAulGS+IJ3DD1Fbz84r3vcLl0kd7oUlXBSDprAyDs03
 E5UqHu5FfcvyHkNmwFYQctFlw0s2GJr77gpNiC1RlxB+EiUwxCpWS9WpLqGu95hVDsCT 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu3qd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 23:38:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEN2QHF025131;
        Wed, 14 Dec 2022 23:38:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyen2sfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 23:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpkdRbhTe8EY9jc2O/DMO42K2Js7z7WIXQiyi0PLLvOKsBePehmDPfBoi93Ouasc6zdSNAnghBXpQYVkD/EbMGCuTqbMVReHi/HY5PwxiCOeMr5tHgO4CoD+d5JBfZHVgKwwJ7dKIqFF9dbLkDJ8ZAgxbMkEFKmjUKclrFv8DR/o5cJxEibG9Pbop9XY4MumF/n0Aj4D+QPUOS+2LEr0u1Iv9mO4pLAc7vXwN/0ru8yrBYQKm1Y3oT7QqxBfWD9AGnO76Je8leFkcPJfHZAkxFc4F7Xas/fAOGBJD92zkgDENtmlOQWOigCe6IJHbYtiykGqy8jYp9N3Q0imwE506A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xw5xLs4vhJTuOLnrwqirHrGnV87hNYsxXExYsuLD9A=;
 b=PaotczdPf/OQb2mpTxz1cYHdQgm/o9/f3tSLYdL37ldrCNN7AuGMzUOFoWFRoki1snMxmX2gAMmOfmesc17uSZRr1XcxS361xSIl0yMqcZheW15ge4eWnidrHRqVKqua6cymNy4ph9tbbFMYiIXRof5jxr3h/C1yXdjJzy1b7O6h0Dy6DcagRDWHQrK+La4NoDzKsiO2UaQ45qcRhoXlXjIIxCH9hWzya0YeG9AKiNn7G0aLkTTf/VrNUG4r26l33BcCGy416IXe5aiKhUV1WMfqljifJdtGn45uYkWoucPWY8GFtm/fSC1P8cmBjLVKcGT0Dz3l9QaB319BVJ42qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xw5xLs4vhJTuOLnrwqirHrGnV87hNYsxXExYsuLD9A=;
 b=j6smgLFi9a2p1/kVFFt2bi+WqGlM+XGrvEG7EJ03NaHjbTdij8wjfOSfk3YhcWKRSr1icqlaWaNOXLs05QbpB2eH8eYHq7nDR2mGjjlXfyuDuQjD8OBvcEhulFteC40yJvEaszueSHods8DHg4hM9QXQDmjiLgeQnd7+uKBoWkY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 23:38:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 23:38:01 +0000
Date:   Wed, 14 Dec 2022 15:37:57 -0800
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
Subject: Re: [RFC PATCH v2 15/47] hugetlbfs: for unmapping, treat HGM-mapped
 pages as potentially mapped
Message-ID: <Y5peVSCzSfTKz7v0@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-16-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-16-jthoughton@google.com>
X-ClientProxiedBy: MWH0EPF00056D0F.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 960b4a34-8cb7-4863-22ca-08dade2c3d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAFabyAHnc1ATOQkj09OqSKQpGXbsDVgeTWQ9R+dBQLPl6SnQSazmVIItn9HwW4i8oxJ2NpxaQtP6Wy88rYXQI29LEaZcQWn2Tk26tHcHDDAP+BT4cVkOBSAykhrBFKnA0m75HWi8kCnotuNmItqGYUSeHqVmnfDRf94q5EPYd0qgC6knid9f6rp/XZD+UFH25WwznfPRxKQoDLW+BY+7mT7OYIEZITIBFejsIwPD3C1ZXFfWH2gLaEUNSs7oMMG9/eTma7GFOJxtr9ksnbPI6v980ycj/vE8BCS3y0yPf/l5OCoalRlqMLcoMeyyUFHRdaMFvrHPzYUMSQHgpQjFiisfjmamLgvVdZuENyeOGL0P3gBPqBnmDpcZe9N/UoeYbWb1dr0/2+hak3rll+wYYSTp5wGQ0AoO0xp/Z9lODrI3taoqGFyDsJNTFj3s7kx1Fdb+fI/xsl9Q3Se3TeMnxvWmUy/pXvDoPR27Nz2T5rGQ3u7fPhkeDdXV/SyF+mR36BypyJ6qqhU8HVZP+8mVmq+NzbUvex/h9gmOXXDkgdNo8cJN/P09r/nELPuQxj6STjul3u39IhirEYDxbmLKxsE8T25Sg4Nd4/Y/V5JVKgy9xGNm4EjlZIzEuZPFcwCiKLT7K3YgFnDsahBqLSZSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(41300700001)(8936002)(6666004)(478600001)(86362001)(38100700002)(6486002)(33716001)(53546011)(5660300002)(44832011)(66946007)(186003)(6916009)(8676002)(316002)(7416002)(4326008)(66556008)(26005)(83380400001)(6512007)(66476007)(9686003)(6506007)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9vDB27acLLgo22Y5wHXfVxzlrW0Y0+0H1l7kaWsJlYi/hR9GpFldMwuoTH5?=
 =?us-ascii?Q?Z2hr8PH5q1xkpwnXAcUNAqUJqj5R5CO3By64SLnVnOWAc7yH+B/WJzQRYaEN?=
 =?us-ascii?Q?bhH5eqKrgyhyFyM/PTFTOaHnaAQSM9c1gxFzTqqXgOhxkDdCnNGNxtGVBGen?=
 =?us-ascii?Q?mnB9Fw7b2RF3j5uWx3QgNLdVudgL9LFV+M6Zi8FM4IjKDww8JRdIvZZpdC66?=
 =?us-ascii?Q?XRmsPy6+3nYoR8NubzOpfXA+Roblq9RJ1/xic9pRCK9VKufnJ+wQlmThgVTm?=
 =?us-ascii?Q?M7m7xxLo/h7ONmfMx+Vg8OZG17YqipVdSMwIE1wWWNqXSdH1VyzwHpYEA9PT?=
 =?us-ascii?Q?xars9iDLX8ni7oEmZvE6FmBIF0XqMOrAIiS2YbN2XInAv2iv1J3mxKPtzpO1?=
 =?us-ascii?Q?56J3VrcDCZDj6m9PVuHv5kpXRRm1kr3C/58xPc4ETWw8jZ856XBKRYQ+bvSi?=
 =?us-ascii?Q?wqfJzjEx6vzUO+/19rO80vrutHpX0Fb3iTQAgoQ6qH/kJkH5CVmIZO3MVNM7?=
 =?us-ascii?Q?Zvt8+5jVOghUbvmXUOAqZuErswNZlLWld2UszsYFG+Dv93hl/tzOtw4vHZLm?=
 =?us-ascii?Q?4B9kUgshp3DsWMEEKcORf++OWed2dKv4woJ5H+Lo2gf3adf5HK42q9DnzzNN?=
 =?us-ascii?Q?kOh2z3GkJ92neAZ/aO1zPyoGgDyP0n8/jOXWec4xKM70WIiu8P3QPqfzyoW4?=
 =?us-ascii?Q?Xhp7L2YciyfZPYRRjk5vKN6X00ooAvBdg1ws6Ul1Dtdv8797BQW7yACfkVm/?=
 =?us-ascii?Q?bPVx9cKwGqkjINSZIAMCDWfk9AmuIfdGo4jDfu7uiFSx99alLYE8PdpqOzBH?=
 =?us-ascii?Q?koI/Mzp4hzf/y/0EfJVU9HOY6E1LXQoZIBdy0CE7w9BZf/1e0jLhb76fgdch?=
 =?us-ascii?Q?FZPJ3emDlsh7zszylRpLYUWpk8mZQBbWS3POvXqHTZX/xDNc9Z/JAvUwUR+v?=
 =?us-ascii?Q?FJLMbG0p4UjC3cMawhiv99TmYI3ZoZ7hIt2ycG36zS6Y+XHobWxdQWlFfhCS?=
 =?us-ascii?Q?ChQnnOBfes5C9DwG8ZzKvnMtKGptRnLNvJIKi4Z70HUi0KtOGjQaDqVD3J36?=
 =?us-ascii?Q?g+gtIEW2F9TT720yXS0Zif4+H05Bdoh2GgfwYT7lrjeCIESiyfTqkjJvm8jC?=
 =?us-ascii?Q?C1wQK34R0OwKLpkVaaKZSv/G4WrRompPvyG6iBuPIAL/WaKDgKQzTAL2Vh0B?=
 =?us-ascii?Q?b8r1weq0/5sa5+nAPLEDnY1mc7J+/i8FuowmhZQCjtDDpJQUfW9jhAxhoyvn?=
 =?us-ascii?Q?ja6npUBtLUwjuWAOHQ+Xd/E+GjSe6UTKxd4FWrgRzJR4coasmcI7BpNlponS?=
 =?us-ascii?Q?K3oRKFOYg4y6fAL6Mkj6HOWvGlWj67Y5R9SvCVndIJ46SxodptgXuReIMtv6?=
 =?us-ascii?Q?sujJWhQxBTualgYxMlI0nPpTIGqzUISyXBg5WrpDEcyNk4oKBmJwrdy0G2k3?=
 =?us-ascii?Q?PtOaxltY/2v1UGq32X3JeMDehPIJ2DDseQyGpU5+Kbp4DDI4yHYMrgDLgnzg?=
 =?us-ascii?Q?kv8eaO7tU/7vMGMnhHjF4P7a6wIEeYrfD0fDeHvwbQJfHdOOGm/dP0FcryHa?=
 =?us-ascii?Q?dEvqIkw/IpMmlynUuFakV/JFIrBw7+Olu3munGPUJ6XTLjg670JTAT2qOm6R?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960b4a34-8cb7-4863-22ca-08dade2c3d20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 23:38:01.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjIKDvW8VX6PrS2yobnQwLQHC+969kJtDgf1KvI6NzPgxkWwzj5ivdSaxoz6vMCyOzzEzhrRZbLGZLt2yfzq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_11,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140194
X-Proofpoint-ORIG-GUID: g2_ZJIV_B2feyOkZ1OQYy_ugJnqR82pF
X-Proofpoint-GUID: g2_ZJIV_B2feyOkZ1OQYy_ugJnqR82pF
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
> hugetlb_vma_maps_page was mostly used as an optimization: if the VMA
> isn't mapping a page, then we don't have to attempt to unmap it again.
> We are still able to call the unmap routine if we need to.
> 
> For high-granularity mapped pages, we can't easily do a full walk to see
> if the page is actually mapped or not, so simply return that it might
> be.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  fs/hugetlbfs/inode.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7f836f8f9db1..a7ab62e39b8c 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -383,21 +383,34 @@ static void hugetlb_delete_from_page_cache(struct folio *folio)
>   * mutex for the page in the mapping.  So, we can not race with page being
>   * faulted into the vma.
>   */
> -static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
> -				unsigned long addr, struct page *page)
> +static bool hugetlb_vma_maybe_maps_page(struct vm_area_struct *vma,
> +					unsigned long addr, struct page *page)
>  {
>  	pte_t *ptep, pte;
> +	struct hugetlb_pte hpte;
> +	struct hstate *h = hstate_vma(vma);
>  
> -	ptep = huge_pte_offset(vma->vm_mm, addr,
> -			huge_page_size(hstate_vma(vma)));
> +	ptep = huge_pte_offset(vma->vm_mm, addr, huge_page_size(h));
>  
>  	if (!ptep)
>  		return false;
>  
> +	hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
> +			hpage_size_to_level(huge_page_size(h)));
> +

Only a nit, the hugetlb_pte_populate call should probably be after the
check below.

This makes sense, and as you mention hugetlb_vma_maybe_maps_page is mostly an
optimization that will still work as designed for non HGM vmas.

-- 
Mike Kravetz

>  	pte = huge_ptep_get(ptep);
>  	if (huge_pte_none(pte) || !pte_present(pte))
>  		return false;
>  
> +	if (!hugetlb_pte_present_leaf(&hpte, pte))
> +		/*
> +		 * The top-level PTE is not a leaf, so it's possible that a PTE
> +		 * under us is mapping the page. We aren't holding the VMA
> +		 * lock, so it is unsafe to continue the walk further. Instead,
> +		 * return true to indicate that we might be mapping the page.
> +		 */
> +		return true;
> +
>  	if (pte_page(pte) == page)
>  		return true;
>  
> @@ -457,7 +470,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
>  
> -		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> +		if (!hugetlb_vma_maybe_maps_page(vma, vma->vm_start + v_start,
> +					page))
>  			continue;
>  
>  		if (!hugetlb_vma_trylock_write(vma)) {
> @@ -507,7 +521,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  		 */
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
> -		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> +		if (hugetlb_vma_maybe_maps_page(vma, vma->vm_start + v_start,
> +					page))
>  			unmap_hugepage_range(vma, vma->vm_start + v_start,
>  						v_end, NULL,
>  						ZAP_FLAG_DROP_MARKER);
> -- 
> 2.38.0.135.g90850a2211-goog
> 
