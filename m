Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E9A72E201
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjFMLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:47:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE56E47;
        Tue, 13 Jun 2023 04:47:53 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DBHqbe019547;
        Tue, 13 Jun 2023 11:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=YW8dFle4FwBo/xSGfxj/YlaloUxuRpkH0geiv0yOSDw=;
 b=T5i9ZjoLCtD5qW5i8NKsB6igZlD7dMJC6lq2OsnNDPy7oI/IJwCWRx4SPn5FJJpROxmM
 XGoOjoVssuM9/IjC8/J3XlUqvCz3C3iOZBKCzWeoF0IhoZ+avSBdbwNZr59eAY+Y/MwT
 m2mG+QlqXNAIO2Pu40I08q6zflwJsJOVsijb4rqfpucHx1YhsAfZE7071II3obN8oK0Q
 NnZiT60lRymQXLae3bIOY+/57zmLGsf/tJ23yvopK4qH2zkFEV55XJ0NU4UIbN/4AKyx
 fHREytSGkFNXaEKXdBvC+qFh/1F0GU1+NwGoF/v4zbQshn2s5Y75imb05ioVeOAk3wU9 uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6qey0j7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 11:46:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35DBbbht032708;
        Tue, 13 Jun 2023 11:46:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6qey0j6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 11:46:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D3i4Ui022712;
        Tue, 13 Jun 2023 11:45:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt523ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 11:45:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DBjA1w19399178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 11:45:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC35620043;
        Tue, 13 Jun 2023 11:45:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6D1F20040;
        Tue, 13 Jun 2023 11:45:09 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 11:45:09 +0000 (GMT)
Date:   Tue, 13 Jun 2023 13:45:08 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 15/23] s390: allow pte_offset_map_lock() to fail
Message-ID: <20230613134508.6018e70c@p-imbrenda>
In-Reply-To: <3ff29363-336a-9733-12a1-5c31a45c8aeb@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
        <3ff29363-336a-9733-12a1-5c31a45c8aeb@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NSzf1M38pnx2z8GhXfyd2zkrTyue7I-U
X-Proofpoint-ORIG-GUID: Jl-BWVCZvUKcympIO9JuW2YKR9vYO4UE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 12:27:22 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> In rare transient cases, not yet made possible, pte_offset_map() and
> pte_offset_map_lock() may not find a page table: handle appropriately.
> 
> Add comment on mm's contract with s390 above __zap_zero_pages(),
> and fix old comment there: must be called after THP was disabled.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kernel/uv.c  |  2 ++
>  arch/s390/mm/gmap.c    |  9 ++++++++-
>  arch/s390/mm/pgtable.c | 12 +++++++++---
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index cb2ee06df286..3c62d1b218b1 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -294,6 +294,8 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
>  
>  	rc = -ENXIO;
>  	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
> +	if (!ptep)
> +		goto out;
>  	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
>  		page = pte_page(*ptep);
>  		rc = -EAGAIN;
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index dc90d1eb0d55..3a2a31a15ea8 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2537,7 +2537,12 @@ static inline void thp_split_mm(struct mm_struct *mm)
>   * Remove all empty zero pages from the mapping for lazy refaulting
>   * - This must be called after mm->context.has_pgste is set, to avoid
>   *   future creation of zero pages
> - * - This must be called after THP was enabled
> + * - This must be called after THP was disabled.
> + *
> + * mm contracts with s390, that even if mm were to remove a page table,
> + * racing with the loop below and so causing pte_offset_map_lock() to fail,
> + * it will never insert a page table containing empty zero pages once
> + * mm_forbids_zeropage(mm) i.e. mm->context.has_pgste is set.
>   */
>  static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
>  			   unsigned long end, struct mm_walk *walk)
> @@ -2549,6 +2554,8 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
>  		spinlock_t *ptl;
>  
>  		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +		if (!ptep)
> +			break;
>  		if (is_zero_pfn(pte_pfn(*ptep)))
>  			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
>  		pte_unmap_unlock(ptep, ptl);
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 6effb24de6d9..3bd2ab2a9a34 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -829,7 +829,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>  	default:
>  		return -EFAULT;
>  	}
> -
> +again:
>  	ptl = pmd_lock(mm, pmdp);
>  	if (!pmd_present(*pmdp)) {
>  		spin_unlock(ptl);
> @@ -850,6 +850,8 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>  	spin_unlock(ptl);
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	if (!ptep)
> +		goto again;
>  	new = old = pgste_get_lock(ptep);
>  	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
>  			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
> @@ -938,7 +940,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
>  	default:
>  		return -EFAULT;
>  	}
> -
> +again:
>  	ptl = pmd_lock(mm, pmdp);
>  	if (!pmd_present(*pmdp)) {
>  		spin_unlock(ptl);
> @@ -955,6 +957,8 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
>  	spin_unlock(ptl);
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	if (!ptep)
> +		goto again;
>  	new = old = pgste_get_lock(ptep);
>  	/* Reset guest reference bit only */
>  	pgste_val(new) &= ~PGSTE_GR_BIT;
> @@ -1000,7 +1004,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>  	default:
>  		return -EFAULT;
>  	}
> -
> +again:
>  	ptl = pmd_lock(mm, pmdp);
>  	if (!pmd_present(*pmdp)) {
>  		spin_unlock(ptl);
> @@ -1017,6 +1021,8 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>  	spin_unlock(ptl);
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	if (!ptep)
> +		goto again;
>  	pgste = pgste_get_lock(ptep);
>  	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
>  	paddr = pte_val(*ptep) & PAGE_MASK;

