Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2E7152BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjE3A5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3A5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:57:40 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED819D;
        Mon, 29 May 2023 17:57:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 064A35C010A;
        Mon, 29 May 2023 20:57:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 May 2023 20:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685408259; x=
        1685494659; bh=jWG2cb261aJIx2WDI0uGrh8JxOzjxCXM6ks6s69gakA=; b=v
        g1yecJTFZ9UHBWKYQcrs5WovDrUX8fUG8pHtHYDZtbypYqVBFX78M0kGPr9BNNWO
        6xM7lfUGo6s7CqCO8qLu4JhvNM6YUXrCcX55mZduO6IzA0KKvRjvQLtvXz1Hcssh
        PmccWY354ZSlce0wK/pLxOjkN8Q2K7HpBdVAiChlCVpWTAqL83q3DzfN9ksysrX2
        Om1vTCoizJusi+bmH5CSpm3FBtACQXIF1YiMRubpprVAduUkVOzfYzFkJwf5hgQF
        l5ihljgkr1groMSKW6d2NT6C23sW672L5++IlPM1dnfEl1VH4iVlLS+cV9IsqE1c
        xOM5XAK8FJU6oIp9O6Euw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685408259; x=1685494659; bh=jWG2cb261aJIx
        2WDI0uGrh8JxOzjxCXM6ks6s69gakA=; b=mFWHJleA5DFx4XkGhADOfmWDYMS/S
        I5eryTd8lQ2Ve1ld4ekGoYC5gC23Iq4V49e5IIJvOAaVIMuXPH37zBq6knV2p/bH
        7JCde9czBQTtzPj2KjyVWYQwpJnEivlcS2KgKOnMA3RqcGJ2beyncPgp7464XJ37
        4caDJg0Q3RPn3RWyN+KuVOcoBKcY+12d9G1iP9p/ou09E+kC2S6r7OuBjB59qcZV
        RsVxuECCCAzckcGFS4hymuY80e2i6UH43R41rbZUvcD6yLFoeWQwkjxmsO5urQdG
        kK+bk8Fx8ciItVhPGEQQ+TW/WxFHMmSp/fJiIneQmQkA1bXLgUpNx0yPQ==
X-ME-Sender: <xms:Akp1ZBiqxp1eniQDQZXT-neHKHS0mHosErjFiMjQJXf2pOiSV5K3cw>
    <xme:Akp1ZGAYfpBfkf7AFPXdS76pE_S_zlYWKlcumf1Rw4FU0imA6EG1QZPibpd_6Uh6n
    1-gl-7HDzXaoAcgJVU>
X-ME-Received: <xmr:Akp1ZBH5dn_bzVBerB9Wb8BuvZxJ1YRh0PLgh6ZjCx10bjAC0gOqvF68T_PwkHgfA34saA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekiedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Akp1ZGS-_McBDqNUY-pOY0MDK_mLP_eSOM0Bfx475K_S_KNk1FEHcQ>
    <xmx:Akp1ZOysHrLqxVeZxV1x0hWVVm5NfkG3H_PE-AhvRhaj6aMtEdijJA>
    <xmx:Akp1ZM5E4vid5nORMMTxGqi5ifjobLUwFipCDxFc4a76NW0MUmHgBQ>
    <xmx:A0p1ZA4n66E0zTSyBEuel8_kq5ncBsWubNcL2fFKyAaLTe4iefEkog>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 20:57:37 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 138CB102633; Tue, 30 May 2023 03:57:36 +0300 (+03)
Date:   Tue, 30 May 2023 03:57:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        thomas.lendacky@amd.com
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, decui@microsoft.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Message-ID: <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:10:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
> > Touching privately mapped GPA that is not properly converted to private
> > with MapGPA and accepted leads to unrecoverable exit to VMM.
> > 
> > load_unaligned_zeropad() can touch memory that is not owned by the
> > caller, but just happened to next after the owned memory.
> 
> /s/to/to be ?

Yep, my bad.

> > This load_unaligned_zeropad() behaviour makes it important when kernel
> > asks VMM to convert a GPA from shared to private or back. Kernel must
> > never have a page mapped into direct mapping (and aliases) as private
> > when the GPA is already converted to shared or when GPA is not yet
> > converted to private.
> 
> I am wondering whether this issue exist in the AMD code? 
> 
> IMO, you can add some info on the window in set_memory_encrypted()
> where this race exists.

I don't think AMD affected by load_unaligned_zeropad() the same way as
Intel does. But I'm not sure.

Tom, do you have any comments?

> 
> > 
> > guest.enc_status_change_prepare() called before adjusting direct mapping
> > and therefore it is responsible for converting the memory to private.
> > 
> > guest.enc_status_change_finish() called after adjusting direct mapping
> > and it converts the memory to shared.
> > 
> > It is okay to have a shared mapping of memory that is not converted
> > properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
> > stepping on it.
> 
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/x86/coco/tdx/tdx.c | 56 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index e146b599260f..59cc13e41aa6 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -840,6 +840,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> >  	return true;
> >  }
> >  
> > +static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> > +					  bool enc)
> > +{
> > +	/*
> > +	 * Only handle shared->private conversion here.
> > +	 * See the comment in tdx_early_init().
> > +	 */
> > +	if (enc)
> > +		return tdx_enc_status_changed(vaddr, numpages, enc);
> > +	return true;
> > +}
> > +
> > +static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> > +					 bool enc)
> > +{
> > +	/*
> > +	 * Only handle private->shared conversion here.
> > +	 * See the comment in tdx_early_init().
> > +	 */
> > +	if (!enc)
> > +		return tdx_enc_status_changed(vaddr, numpages, enc);
> > +	return true;
> > +}
> > +
> >  void __init tdx_early_init(void)
> >  {
> >  	u64 cc_mask;
> > @@ -867,9 +891,35 @@ void __init tdx_early_init(void)
> >  	 */
> >  	physical_mask &= cc_mask - 1;
> >  
> > -	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
> > -	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
> 
> I think you don't need to change the order here.

I wanted to emphasise that the comment is for _prepare/_finish callbacks
and I hoped re-order would help with this.

> > -	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
> > +	/*
> > +	 * Touching privately mapped GPA that is not properly converted to
> > +	 * private with MapGPA and accepted leads to unrecoverable exit
> > +	 * to VMM.
> > +	 *
> > +	 * load_unaligned_zeropad() can touch memory that is not owned by
> > +	 * the caller, but just happened to next after the owned memory.
> > +	 * This load_unaligned_zeropad() behaviour makes it important when
> > +	 * kernel asks VMM to convert a GPA from shared to private or back.
> > +	 * Kernel must never have a page mapped into direct mapping (and
> > +	 * aliases) as private when the GPA is already converted to shared or
> > +	 * when GPA is not yet converted to private.
> > +	 *
> > +	 * guest.enc_status_change_prepare() called before adjusting direct
> > +	 * mapping and therefore it is responsible for converting the memory
> > +	 * to private.
> > +	 *
> > +	 * guest.enc_status_change_finish() called after adjusting direct
> > +	 * mapping and it converts the memory to shared.
> > +	 *
> > +	 * It is okay to have a shared mapping of memory that is not converted
> > +	 * properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
> > +	 * stepping on it.
> > +	 */
> > +	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
> > +	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
> > +
> > +	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
> > +	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
> >  
> >  	pr_info("Guest detected\n");
> >  }
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
