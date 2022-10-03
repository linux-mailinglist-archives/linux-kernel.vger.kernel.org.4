Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF75F2779
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 03:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJCBRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 21:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJCBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 21:17:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB736DE5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 18:17:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 292Ffcuq026692;
        Mon, 3 Oct 2022 01:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ARIYNFqMeUq6I1vP1ejP2dK5zb5LxhWbeI0k5K+5O/0=;
 b=KaT770kvKWOijAjEwFjwG79ayNxjACvE8b9HbgHS/3r75frsAvM6pF9+/vUPPPkAIP5Z
 Pr23gxJGjAldBXKqo+9lMPHDqSupHX+zLceZgq2ywOl/pIvf6Xv8JoYNcKq2ePGVlikQ
 TqFDhr4CQ7VdJ9JIBZHMSe7nYP5r+5Vvh7vZe4OxJHWLXYKtPacrcJYRtgRxfmjteIjJ
 ylFdtSQowFAMkBxqyPhfRtuRU8RI265gmQwXrs9USwz7BSubhZhwOxCliN1s86CjG9GK
 NSX5EMExT/M80Z4BSgVeyNPRs4WJt7iZiNQ6IIN13TDoxpkqjesFgXkX4YvmEK2RBSkk xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxbyn27eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 01:16:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 292ItRYw001618;
        Mon, 3 Oct 2022 01:16:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc08x7tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 01:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+8tCOvU1TaPIAACuFwStOa8adx+jK+lUATsCT5fZDa++IUAG6ZrcbhcU0D4nZnGM0OO9VL/zQuOFQAnzw/SWDhb0vc++I2Tfippt64jQDB/mPlaUli9d0xUemeMFzgXXI5dZljmu7xpaowTqNNPcxhOXaJ3aR8Omq0bqutZeErArZN/8RBwQRUdNa9dMBl3+VA+d3+X6t0Sn2Uujk0Y6CNSTGCfbaaVqEIXqh+a1Ue5dj5XDuZZfibGUNLqliiBzsjCL4grg5Fu5ybH3rHJO6UKB/5kYUeEW2AhbfjKIS4oegDRfLzwDe7QQ19zPPeX+ozCpylAl+DitmbpC/h15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARIYNFqMeUq6I1vP1ejP2dK5zb5LxhWbeI0k5K+5O/0=;
 b=YMpbFtpa40oufA2heBl1wWwc9Qd3YCJo97UeutWb0nHg5yeJnT/Z1vSC19Yk6xQAPL9kGT6Qay1PKrQPeMqhXoVUXUGiMXqZLjEsitR/+SPb65NkNLJlcMCgVyjW21cy0fvM+jlQfKAE4kKuQTVZ05UCYyaqTkUHJN5mV811kxnTd3GtOQCSljxG8XPM5HDT6fWEDKs8ZgQ9gKNGJhEJozXPCsWJTCl68riCsNHm9dT5n8goeybFDwJBtSRJdGL181wIVeFgLN68JF2HFzcQDHnE7JnJ4NLuXsHBZzKhqwHYIyufWI9YlWk6X60OHPFQbInXoijAkmPlG+UjG6LoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARIYNFqMeUq6I1vP1ejP2dK5zb5LxhWbeI0k5K+5O/0=;
 b=q1rGdyDtptYOHxDX8EWuN2YevaYYofb44Wmr3SThou+1Xv1ffRMVGxCpi+KFKK+FPBi5JSVX0yqStoLJppfmLdyAydEHM/RFPlrvcc7CiSPB209BiUYc1rsSsRSIpotOAjDL3Fht2yCME1mDt2DTodIiTtjMboFInrsd1pPhrjw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 01:16:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 01:16:57 +0000
Date:   Sun, 2 Oct 2022 18:16:53 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <Yzo4BU25w7i8HrrQ@monkey>
References: <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
 <YzMomT+OusJnLOPC@x1n>
 <YzYrYVeA0b9d5dos@monkey>
 <YzcTt3P3ofvbGQmi@x1n>
 <YzdhuZmfQCjLFEMO@monkey>
 <YzeqUTDay7AcnP7r@x1n>
 <YzetdU37ekZ6N2II@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzetdU37ekZ6N2II@x1n>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e25f057-1a84-49f7-be8f-08daa4dcf6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kgOreR9WIBOQMAmxe6gRwZe+WDgU3j0Kq69Z66aS5NC5GJRZnjRoi9FCx4LWmFlEwW7/rzGiR1SN8ZvRNkdzfWKFMus9YO3Ix27BHW42mczRtSxWMfksDPmJcj9I+Smh0ZMh/SuiAzjUOUlP5L7zpjeHF+ZTuvjeg1un+nE4atf89ZIws++3VF1SM0k5HRyZgZQrN/TqunZGRpsYA6r0IsG7o9aNLHUaHnpl/s5GxzHtDHOOAShLhAWNz3NtMMUmFBI1BwZyngUrPSMkSZRxtdqsUm9DhwBy+pTQ+jFB/oqU2HeZLQhOxaiIJoHv/wzf8s4PsFj+iV+ZeNg99h0UQl3y/TIntne69q07ctatYd3ArJI2dJRA3AdG5WzppSgCt0llhuAUpcm20EyyMUIeUVGs+TdT0+IGJTv/lgyIJbsiOzpbQJTKlbL+CRgzQX8j4DGCdE6e1F8ndA58MAM9HfACN9wCaKgyHNJ8AV3/0Tm3D72g+06EshIrI1WOj4I9vyWMHINQ1OHH6/CLdrQJv4L1s4vMrPFBdzyfUlhcv4tVQ49Tq2dCHeHIlZRF+t5Gu4SjE7UrvyMXzp72b77+bu/LDy9X/82QnXaQB9dNAFojjbeRSibShdRCEwIf/2+XuAxhETG908BhTmBG6Ev67CXHfd6/4SHHIv8z/nM8iRMg0zrBCvWNQmiPUbL7SR1W/B6sgzAfZD3uiWOsuiXlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(83380400001)(53546011)(6506007)(4326008)(6486002)(38100700002)(33716001)(186003)(44832011)(478600001)(41300700001)(9686003)(7416002)(6512007)(316002)(26005)(8676002)(86362001)(5660300002)(6666004)(8936002)(6916009)(54906003)(2906002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixT0ethSomJBKMQ7iDmL8+EjfWwOFGCdoj4WoDn72td1E7IEr+l9RzXCzNOq?=
 =?us-ascii?Q?wONbF7NMFEiuXYtzvcKSiljnKgnA/QdnwvjHQC0tgHZzyLgWYh/Ipl10rFIk?=
 =?us-ascii?Q?fbXK0AAeAYe6jjHtu+Ng8/2dYYHYNyu3/Q1u4wzQcpE9LylILmcdtzIKE4BS?=
 =?us-ascii?Q?O8tI37/GCUIrFe5tHYWdc4sflLunaJ+2dTgyMzQZ1O6iNDSl6+pFTnfC3m9y?=
 =?us-ascii?Q?Vq1lUo28RKBkXsxAI4U5OIEKs4f9SLRXbc2p9uJIRkC2cM8NvRsio9G3fEYw?=
 =?us-ascii?Q?UeiqQSkKav+6gp/cttGooWH98HNj86BOLA9+hua15VlQm/tzhlffceajsKrh?=
 =?us-ascii?Q?Lw/7H9cDMvXJemQmdrjhrV003Fgkykh+0bp5EIPwDfEC39dj98fLQEAq35Uk?=
 =?us-ascii?Q?cUr1B4ynOZFHhjP8GzAkrr2nCQEMAOh97G5IzcXXm7xMgtfFdddQmUsMAMft?=
 =?us-ascii?Q?28TzbUkk9Jrkr+zhjkSoZbxnMNp3itCxkID36IFZNjiyQbtCzUwbije1OsfG?=
 =?us-ascii?Q?Q4fLNm84WWiNwSRIyN8jBRYwJj/ZlHZhNpFZdXfOU2grka7x3pqwWT6hQgwc?=
 =?us-ascii?Q?XntOHcvbnpwWmg5PCpc/6nUzV62SyN5TxIa6YVKcQxqRJV+Ah5zMO4WEAg7E?=
 =?us-ascii?Q?TWAyrej5Ni3w3roGOtCLaOsDevaG7VjLJPDJs/ecuv7Zhc/wTTfZUJqaXogB?=
 =?us-ascii?Q?DFQUFJJdE8VW6ZmMF4dGLT2CRsF0XxYMMjpOOATx+E/So1eeEoJhq3PizspR?=
 =?us-ascii?Q?GRgZW/fPJvTzkpUqJCyxrCDc+zF1NDdoSenEG4J8JjHL//E6RUPEqIJfCKjh?=
 =?us-ascii?Q?6feCFqEThi1myrYbysAXd4PN+mfDbK6tg0W4cUao9Oi3thGmP9+CmyJf2YIy?=
 =?us-ascii?Q?sMBZ3uvypoe/PUjQI0e8HYYZXsCScEi74WgI5qiC8cImpWdF8dXIlyAlPB4X?=
 =?us-ascii?Q?yUDHLgG7929l0JdgDVYo7BmlF/HlAJR4ADbmFrqmnNvctpqGn8g6taJZA6ZD?=
 =?us-ascii?Q?LSsQeqeSmQN/Nqwqs7y7WM4tTJHNj8wW1egy/CpUIyDhAr6VPKPLHeWzIOlr?=
 =?us-ascii?Q?m5ZbSK9DI7ZHsdcMCWHWbyFTtpI8sPxEGaJExSlESuyQ23an7tBFNujhnxcF?=
 =?us-ascii?Q?cjHy23ZOxGxNT0BIdO2fKAD30bl4U5BZu66TP9UrgNbCWMdkcpl6pwRMEsvx?=
 =?us-ascii?Q?OqwjeTj4ShIhdzC4Z6GUz5dbYE9A4ZHwhl/YH2BV8n7PN4wjkSXhQJniKceR?=
 =?us-ascii?Q?GltVTDqcAZW1AVRAgF+T0y01qA0frJ9PDA7ForXLticnNARix1XWfN5DiRn7?=
 =?us-ascii?Q?lAxPmVxtD09y6MAn3psaApSvmMItmli9wDn+UWir+2OkKpOodvSin31zlyiK?=
 =?us-ascii?Q?AKOWd9Kc0DXNVCLSrAU56954y1W8WpXsEir/0ezQ8Us6yZLkBK3O+Xs2euH9?=
 =?us-ascii?Q?+Lq2ZAHNmHJEYKfhY9353lFTZTMu1kpZt8nSlyZm3EKgR/fxkl/7/pJx0+u8?=
 =?us-ascii?Q?DmBR/lH+1EQoVj1MLK8VBsxGdCp3vOMofOxi0S7P+twSZyTdeFF/dsVvXEYf?=
 =?us-ascii?Q?je1hWmUKrK25ShVb4ETYfgG5Lm4hXzHKI7TT60aAYdmXSkxPZ70Dzox09ufr?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e25f057-1a84-49f7-be8f-08daa4dcf6af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 01:16:56.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4CuW/RhM5x9bw8sHEskIyvEUe83B4kchGc6tYjP4/Kk+XxtBqRSfPsYDe3kPILC2jDrL+aMT2PfxySuPgQ4nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-02_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210030008
X-Proofpoint-GUID: 4DyOWfAzN7MZvHlggLlKyHhpYNySan_n
X-Proofpoint-ORIG-GUID: 4DyOWfAzN7MZvHlggLlKyHhpYNySan_n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/22 23:01, Peter Xu wrote:
> On Fri, Sep 30, 2022 at 10:47:45PM -0400, Peter Xu wrote:
> From fe9e50551f3fdb7107315784affca4f9b1c4720f Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 30 Sep 2022 22:22:44 -0400
> Subject: [PATCH] mm/hugetlb: Fix race condition of uffd missing handling
> Content-type: text/plain
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dd29cba46e9e..5015d8aa5da4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5557,9 +5557,39 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	if (!page) {
>  		/* Check for page in userfault range */
>  		if (userfaultfd_missing(vma)) {
> -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> -						       flags, haddr, address,
> -						       VM_UFFD_MISSING);
> +			bool same;
> +
> +			/*
> +			 * Since hugetlb_no_page() was examining pte
> +			 * without pgtable lock, we need to re-test under
> +			 * lock because the pte may not be stable and could
> +			 * have changed from under us.  Try to detect
> +			 * either changed or during-changing ptes and bail
> +			 * out properly.
> +			 *
> +			 * One example of changing pte is in-progress CoW
> +			 * of private mapping, which will clear+flush pte
> +			 * then reinstall the new one.
> +			 *
> +			 * Note that userfaultfd is actually fine with
> +			 * false positives (e.g. caused by pte changed),
> +			 * but not wrong logical events (e.g. caused by
> +			 * reading a pte during changing).  The latter can
> +			 * confuse the userspace, so the strictness is very
> +			 * much preferred.  E.g., MISSING event should
> +			 * never happen on the page after UFFDIO_COPY has
> +			 * correctly installed the page and returned.
> +			 */

Thanks Peter!

The wording and pte_same check here is better than what I proposed.  I think
that last paragraph above should go into the commit message as it describes
user visible effects (missing event after UFFDIO_COPY has correctly installed
the page and returned).

This seems to have existed since hugetlb userfault support was added.  It just
became exposed recently due to locking changes going into 6.1.  However, I
think it may have existed in the window after hugetlb userfault support was
added and before current i_mmap_sema locking for pmd sharing was added.  Just
a long way of saying I am not sure cc stable if of much value.

-- 
Mike Kravetz

> +			ptl = huge_pte_lock(h, mm, ptep);
> +			same = pte_same(huge_ptep_get(ptep), old_pte);
> +			spin_unlock(ptl);
> +			if (same)
> +				ret = hugetlb_handle_userfault(vma, mapping, idx,
> +							       flags, haddr, address,
> +							       VM_UFFD_MISSING);
> +			else
> +				/* PTE changed or unstable, retry */
> +				ret = 0;
>  			goto out;
>  		}
>  
> -- 
> 2.37.3
> 
