Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83426ACC56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCFSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCFSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:19:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60C837B50;
        Mon,  6 Mar 2023 10:19:23 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326H2k6Z022466;
        Mon, 6 Mar 2023 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=IVmI4yH9tG0Ae6va4zPFZiTf9ybnBWkjBZy2t1uuqgI=;
 b=FVDfNAgpf8FNutgMtGmbr7YUIcfZ6UlNMzv62++SW/PpJWUKNBbsWlIWOOXh5XRvstMB
 oQq9GnjROL9WsFXrvWRTTbG1dP6hEt0ExxI1cCBJocLCnJMIU5HNhN6nN8y8tPWZ4YOp
 ng80xkfQUFRwW4aS+3UpsTrEByxgs5oYeTCpiVt1ao1mpIIcT4b+0rr8mLZSwXRA1qT/
 NLh0PguCBuPOYQWMXxLYpZRrIK0c/ftTYpJsqM5jw1jlRX9Q1jFIHyOvuyJ8mdXNFxyY
 eykQgYPVHIUGiVQNrBiSVfJvwVAJbabnLI2eNQTfornfdxnPanacqqn9a9bVAWzU8fIS kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4vp269gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 18:18:21 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326I74HM020418;
        Mon, 6 Mar 2023 18:18:20 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4vp269f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 18:18:20 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32649vYR011365;
        Mon, 6 Mar 2023 18:18:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3p418v2fck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 18:18:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326IIC4457016778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 18:18:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E74F2004E;
        Mon,  6 Mar 2023 18:18:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31A4620040;
        Mon,  6 Mar 2023 18:18:11 +0000 (GMT)
Received: from thinkpad (unknown [9.171.75.232])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon,  6 Mar 2023 18:18:11 +0000 (GMT)
Date:   Mon, 6 Mar 2023 19:18:09 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-x86 <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: add PTE pointer parameter to
 flush_tlb_fix_spurious_fault()
Message-ID: <20230306191809.77144eec@thinkpad>
In-Reply-To: <ZAYdpLCxicptr4MJ@arm.com>
References: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
        <ZAYdpLCxicptr4MJ@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q6RU0_1d33mcmcSdtwyO-VmlbiReyfsE
X-Proofpoint-GUID: PmcJFWFlbELOtLm7Z0Wo3Lyr_EPiLECW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_11,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=937 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 17:06:44 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Mon, Mar 06, 2023 at 05:15:48PM +0100, Gerald Schaefer wrote:
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index b6ba466e2e8a..0bd18de9fd97 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -57,7 +57,7 @@ static inline bool arch_thp_swp_supported(void)
> >   * fault on one CPU which has been handled concurrently by another CPU
> >   * does not need to perform additional invalidation.
> >   */
> > -#define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
> > +#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
> 
> For arm64:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index 2c70b4d1263d..c1f6b46ec555 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -1239,7 +1239,8 @@ static inline int pte_allow_rdp(pte_t old, pte_t new)
> >  }
> >  
> >  static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
> > -						unsigned long address)
> > +						unsigned long address,
> > +						pte_t *ptep)
> >  {
> >  	/*
> >  	 * RDP might not have propagated the PTE protection reset to all CPUs,
> > @@ -1247,11 +1248,12 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
> >  	 * NOTE: This will also be called when a racing pagetable update on
> >  	 * another thread already installed the correct PTE. Both cases cannot
> >  	 * really be distinguished.
> > -	 * Therefore, only do the local TLB flush when RDP can be used, to avoid
> > -	 * unnecessary overhead.
> > +	 * Therefore, only do the local TLB flush when RDP can be used, and the
> > +	 * PTE does not have _PAGE_PROTECT set, to avoid unnecessary overhead.
> > +	 * A local RDP can be used to do the flush.
> >  	 */
> > -	if (MACHINE_HAS_RDP)
> > -		asm volatile("ptlb" : : : "memory");
> > +	if (MACHINE_HAS_RDP && !(pte_val(*ptep) & _PAGE_PROTECT))
> > +		__ptep_rdp(address, ptep, 0, 0, 1);
> 
> I wonder whether passing the actual entry is somewhat quicker as it
> avoids another memory access (though it might already be in the cache).

The RDP instruction itself only requires the PTE pointer as input, or more
precisely a pointer to the pagetable origin. We calculate that from the PTE
pointer, by masking out some bits, w/o actual memory access to the PTE entry
value.

Of course, there is the pte_val(*ptep) & _PAGE_PROTECT check here, with
memory access, but this might get removed in the future. TBH, I simply
wasn't sure (enough) yet, if we could technically ever end up here with
_PAGE_PROTECT set at all. For "real" spurious protection faults, it should
never be set, not so sure about racing pagetable updates though.

So this might actually be an unnecessary / overly cautious check, that
gets removed in the future, and not worth passing along the PTE value
in addition to the pointer.
