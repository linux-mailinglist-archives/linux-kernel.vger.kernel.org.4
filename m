Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940B1630F31
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiKSOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 09:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 09:45:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB777DCAA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:45:34 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AJD7sgk021058;
        Sat, 19 Nov 2022 14:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PQEvXswIlOW6EZsPf1TxK+jnGhKVBkvKz2u+YdMR/7I=;
 b=LXFqMyoTMSS31L3v0l5I4bAeoIgDSIXWubvxIzW1kc4JBWYMxiCkq+R7G66CAuQEpD+6
 qa+hlWJ0VDkQxwIU+5pAiqJepZWh++TO/i6/CGH+2MidtiZDHHyXB4WJuUDUk7i8wsRV
 2Da2MkmS6O1F1I0nN3u/1XMMl8WsLGNQJA/ceB0kjH2X24csmGVXpOz37IQ7QuM9b01c
 /bvQS4cD8/+i1G4tZTQDLa3Hxms03JhtEoWaO1AkHsTrj1P8s4Bx2oPM6A0vS6AyCbQT
 a+la4mbSFAoWHfFfxXaJmQmJQIcdZfToegmSX8mP2jnvievkf3ZrfAvTKRUB6kj19qro hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kxtcadsht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Nov 2022 14:44:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AJEb9mb007612;
        Sat, 19 Nov 2022 14:44:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kxtcadshg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Nov 2022 14:44:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AJEbJ5X030654;
        Sat, 19 Nov 2022 14:44:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kxpdhrfub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Nov 2022 14:44:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AJEjVaf32375112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Nov 2022 14:45:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6168211C050;
        Sat, 19 Nov 2022 14:44:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C05A11C04C;
        Sat, 19 Nov 2022 14:44:46 +0000 (GMT)
Received: from tarunpc (unknown [9.43.15.161])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 19 Nov 2022 14:44:45 +0000 (GMT)
Date:   Sat, 19 Nov 2022 20:14:42 +0530
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] hugetlb: Fix __prep_compound_gigantic_page page flag
 setting
Message-ID: <20221119144442.2m7rlexa5sva3fxz@tarunpc>
References: <20221118195249.178319-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118195249.178319-1-mike.kravetz@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zovNgPhbs_RWbLQjqEiZrfhAon-2DaGV
X-Proofpoint-GUID: hxHUNeIzBgBLMBpQED7wx75BXejaw-Wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211190110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tested it on top of v6.1.0-rc5
with 1G Hugepages on PPC64le radix MMU.

Tested-by: Tarun Sahu <tsahu@linux.ibm.com>


~Tarun

On Nov 18 2022, Mike Kravetz wrote:
> Commit 2b21624fc232 ("hugetlb: freeze allocated pages before creating
> hugetlb pages") changed the order page flags were cleared and set in the
> head page.  It moved the __ClearPageReserved after __SetPageHead.
> However, there is a check to make sure __ClearPageReserved is never
> done on a head page.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, the
> following BUG will be hit when creating a hugetlb gigantic page:
> 
>     page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
>     ------------[ cut here ]------------
>     kernel BUG at include/linux/page-flags.h:500!
>     Call Trace will differ depending on whether hugetlb page is created
>     at boot time or run time.
> 
> Make sure to __ClearPageReserved BEFORE __SetPageHead.
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Fixes: 2b21624fc232 ("hugetlb: freeze allocated pages before creating hugetlb pages")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e48f8ef45b17..f1385c3b6c96 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1800,6 +1800,7 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  
>  	/* we rely on prep_new_huge_page to set the destructor */
>  	set_compound_order(page, order);
> +	__ClearPageReserved(page);
>  	__SetPageHead(page);
>  	for (i = 0; i < nr_pages; i++) {
>  		p = nth_page(page, i);
> @@ -1816,7 +1817,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  		 * on the head page when they need know if put_page() is needed
>  		 * after get_user_pages().
>  		 */
> -		__ClearPageReserved(p);
> +		if (i != 0)	/* head page cleared above */
> +			__ClearPageReserved(p);
>  		/*
>  		 * Subtle and very unlikely
>  		 *
> -- 
> 2.38.1
> 
