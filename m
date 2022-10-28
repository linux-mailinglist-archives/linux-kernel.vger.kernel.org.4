Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0675611E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJ2AAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJ2AAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:00:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FD1900A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:59:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 875615C0150;
        Fri, 28 Oct 2022 19:59:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 28 Oct 2022 19:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667001596; x=1667087996; bh=zj
        BnnxCg2s3u2OEL2zBfwRo+gzyrCLrduFCDRppnXtc=; b=JLj3jszwEfK7BIrZ4X
        kQFx3g2iTCXMOTfycRszDiHTFvxkJVp7M2TSEO50F90ZfFTJb0069lRUswi3MSZJ
        btXKoE7hkG5e91TvAh32SS8V+Bd1R77mTTENYjRz6QsKuCqcmH7ZLjffyVT0ld+Z
        Hpv/s8+8kxLPgsIARLyPY4DRoy/2EW4bBVyTdjly8/PxxY4ALO/4z4iKmG5i1h1o
        1bdHK4qG6TlCGhi38ESHUZTLZIP8jr1769452JiCGyGFPpkC1aW8DZYLLu17XZb7
        Js8OericLwTG78GFcHjN9JZxGb+kNnfU1BvR7mcU0L+w/EBjCk96yAcd9Zk6n2Ac
        ceVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667001596; x=1667087996; bh=zjBnnxCg2s3u2OEL2zBfwRo+gzyr
        CLrduFCDRppnXtc=; b=DgYPxUj98YBuSpkG6BOlDbyeWbgOnSgOl74gs3z/x9Cp
        Y9MaHgGFgvOprM7Lg0SeCtsioqgw6LFAJZHlTRpYMx2LSaEWc6vaLsmfRW1popRD
        5fHc99CqSRJLEQAcKUY9jXnJvBlKL8e+mc918Vm4TcS36RNQARIf+xM7BJS+QzIf
        svaMrRfXuJ3yqAEWc3/VYzW+ExL+sG2ugOStZkjQFwyR8l3ZWM3SKOflMsy3vOzi
        ArtgMTDrA0w4IDtQh7epoHPgSkbW2DZzBF2pQZQtRcTPQKuC4WrrAzPkomqRnyet
        5dCWHb4qF4INMfzajjD4ioqH+WtVOAU54G4D9l+kVQ==
X-ME-Sender: <xms:-2xcY6J1-de1KOPSlJJqe_cDmLIaMKmWngb-JKtYRxnv0kD0V3Ou7Q>
    <xme:-2xcYyK-NEoXKGYrBVVow1Q8xHGw8ihKuwosATsNBFm0BZkeFR62yF-OjwP9cfcVs
    AoOAWQKPIUv-7jreqo>
X-ME-Received: <xmr:-2xcY6vY_7X_wbc1wObjg8ohboJarMhKMQFHbzFn2Ptk1MW3oKLO3O26rsANCmS-yr0f7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdejgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnheplefghfefteelhfevffelveffgfetffefleefuddu
    hfejudetgefgieehfeetheejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:-2xcY_ZOIKfuK9EnYpIi4_NoCdtEeF5c6kPTLDfA9AW4yEhc8b3j9g>
    <xmx:-2xcYxZnvorGz7wnk7oH39Gx8eEB96pwcRSlV7-MYgeBO7JKyPaxpg>
    <xmx:-2xcY7BE3sCWNGB0wZpHJuWM64LQ90-3cTUevcqTwVkfaMP6CfE8rA>
    <xmx:_GxcY6Ke3vlz6BvcL9UB0RJMePoh32kXUv1ZI3wlEIA_xv91fC46ww>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Oct 2022 19:59:55 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 89A9A1036F9; Sat, 29 Oct 2022 02:59:51 +0300 (+03)
Date:   Sat, 29 Oct 2022 02:59:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Message-ID: <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:27:10PM -0700, Dave Hansen wrote:
> I looked at this a bit more closely.  The code is just bonkers now.  It
> can't go in like this.
> 
> tdx_parse_tdinfo() stashes two global variables.  Then, about three
> lines later in the function, it calls get_cc_mask() which just returns
> one of those variables, modulo a little masking.
> 
> Ditto for the td_attr.  It's stashed in a global variable and then read
> one time.
> 
> There is *ZERO* reason to store 'td_attr'.  There's also zero reason to
> have 'gpa_width' as a global variable.  It's only used *ONE* *TIME* from
> the scope of *ONE* *FUNCTION*.
> 
> Even the comment is bonkers:
> 
>         /*
>          * Initializes gpa_width and td_attr. Must be called before
>          * get_cc_mask() or attribute checks.
>          */
>         tdx_parse_tdinfo();
> 
> Comments are great.  But comments that are only there because the code
> is obtuse are not.  I changed it to:
> 
>         tdx_parse_tdinfo(&cc_mask);
> 
> It doesn't even need a comment now.  Why?  Because it's obvious from the
> naming and calling convention that it initializes cc_mask and what the
> ordering dependency is.  Plus, even *if* I missed the call, or screwed
> up the order, the compiler would tell me that I'm a dolt.
> 
> The whole global variable thing actually makes the code objectively
> worse in almost every possible way.

I agree. Sorry about that.

We have more code in our tree that want to check attributes. And it is
after initialization, so the code structure derived from there.

But, yes, I should have rework it before sending upstream.

> Can you please take a look through this and make sure I didn't botch
> anything:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxbadve
> 
> The end result is about 50 lines less than what was there before.  Most
> of it is comment removal but the code is simpler too.
> 
> Acks and Tested-by's would be appreciated.

Looks good and works fine:

Acked-and-Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
