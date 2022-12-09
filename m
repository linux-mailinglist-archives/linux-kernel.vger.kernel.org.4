Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D264875A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLIRJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLIRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:09:05 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8763C6C1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:08:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DB2475C011D;
        Fri,  9 Dec 2022 12:08:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670605719; x=1670692119; bh=ie
        Kba2wRqpTtar0M8Punm8EsvypR1DWul//ocfevcKY=; b=B7In/EVG85GZYWHzeE
        qEc30OzgneO/S2JaOCrCl1drNK7+IbJMpXUY8YSz5RzR50ZBDQIKF9pv8dbhGBmK
        60HwH+xSzKhyvg5iTvZjdB/8UWVpI+2dcaQS/HUrpL33Ymh6uRVN1fTxSo4iFB4z
        D4tzpzwUW+x39JVs8XzPLbTGE/yh8ywOLh4XsN5zCFJsfE7KsKIcaMUHGs6e7s7H
        uyJVsTFDYSsYZjrbYXVJreoICWEsv9NmZIGgsatv5IVLYBTIbbWtF2uITjFyZdqe
        3OORA/JFishaiEq99hd3wDoVFrQK5Sl+fW1GfxLlIHOT20nAcntwAEpbetR3wJUj
        fOcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670605719; x=1670692119; bh=ieKba2wRqpTtar0M8Punm8EsvypR
        1DWul//ocfevcKY=; b=nhl3g4T20adgQx0zJ7e4ECXvKFX1PFT1ruH2ckjXUCHG
        QzNzF/zUN483Yr45NiioUYa/KRQWS4ReQTaJI3INL9en1HU+unjoRSvFLveTl2Ou
        7Zz6X9YLm5kzNRIV2mNDuSAvcokzq82hUqd6eqNosp9eNfocy40RaVhy7UUViD2k
        KzgI3Ztqju7n/j8CU5MhTF3nMKN7F6iv3kMh+NwQ/mGMOShZcj9yE3LqurJLyiMd
        dk7y4Av1m9ExWh81j6AY8SJXSfJ0sC2NLcFr76FiqNXS0YIzItdLsO9sZQUenOoP
        f4d4BxAllNcfSUv++iQE7dGffAHD0F2Iv4tjHd9Sww==
X-ME-Sender: <xms:l2uTYyGzEGWXMi_MBOeWu12A-RE3evqus97vVWBtnSQYKmnLsF5g8A>
    <xme:l2uTYzUHbhGYropqWZ0qFeL-Kxge0gqQymo8K39l5tQzTyRoGObjyFeHzJkobsDiY
    lMJ--VEIptG10Kt2UY>
X-ME-Received: <xmr:l2uTY8IHj9hn3niLMHLV2aFYlyd2VA_9Z55G4Iu6E6V9ryZMeJ_vISHALGHMBS3w-CpOCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:l2uTY8EFml1vDh8uBIB3M1OnAreI9d6_nqSPmcrloyqFxB9kgDuPxQ>
    <xmx:l2uTY4Wd7yMpIqCVH94wtRLgKL3V2uB7qR1mla7R1C5TlIVf0agQaA>
    <xmx:l2uTY_MrDqLC30KI5XblOKAnYL7MhdsOCbqFCNlmdkKIJhbdj8kPlQ>
    <xmx:l2uTY8pk95Wesr25V-KoMHco2Py84qFQ29epPTt7r6GZWQiHM6wJHQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Dec 2022 12:08:39 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 61493109CE2; Fri,  9 Dec 2022 20:08:37 +0300 (+03)
Date:   Fri, 9 Dec 2022 20:08:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
Message-ID: <20221209170837.xb5z4zoirx6iwhnc@box.shutemov.name>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
 <acef3c81-635e-6753-577e-3905117823b9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acef3c81-635e-6753-577e-3905117823b9@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 07:45:34AM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 12/9/22 5:25 AM, Kirill A. Shutemov wrote:
> > SEPT_VE_DISABLE check is required to keep the TD protected from VMM
> > attacks, but it makes harder to debug guest kernel bugs. If guest
> > touches unaccepted memory the TD will get terminated without any
> > traces on what has happened.
> > 
> > Relax the SEPT_VE_DISABLE check to warning on debug TD and panic() in
> > the #VE handler on EPT-violation on private memory. It will produce
> > useful backtrace.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 8ad04d101270..0e47846ff8ff 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -38,6 +38,7 @@
> >  #define VE_GET_PORT_NUM(e)	((e) >> 16)
> >  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
> >  
> > +#define ATTR_DEBUG		BIT(0)
> >  #define ATTR_SEPT_VE_DISABLE	BIT(28)
> >  
> >  /* TDX Module call error codes */
> > @@ -207,8 +208,15 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
> >  	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
> >  	 */
> >  	td_attr = out.rdx;
> > -	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
> > -		tdx_panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.");
> > +	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> > +		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> > +
> > +		/* Relax SEPT_VE_DISABLE check for debug TD. */
> > +		if (td_attr & ATTR_DEBUG)
> > +			pr_warn("%s\n", msg);
> > +		else
> > +			tdx_panic(msg);
> > +	}
> >  }
> >  
> >  /*
> > @@ -682,6 +690,8 @@ static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> >  	case EXIT_REASON_CPUID:
> >  		return handle_cpuid(regs, ve);
> >  	case EXIT_REASON_EPT_VIOLATION:
> > +		if (ve->gpa != cc_mkdec(ve->gpa))
> > +			panic("Unexpected EPT-violation on private memory.");
> 
> Why add this change part of TD debug check? Should this be a separate patch?

This code is never reachable if ATTR_SEPT_VE_DISABLE is set. And the panic
provides backtrace useful for debug.


> 
> >  		return handle_mmio(regs, ve);
> >  	case EXIT_REASON_IO_INSTRUCTION:
> >  		return handle_io(regs, ve);
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
