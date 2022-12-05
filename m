Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C0642867
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiLEM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiLEM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:26:28 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97F25CA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:26:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 145E23200933;
        Mon,  5 Dec 2022 07:26:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Dec 2022 07:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670243185; x=1670329585; bh=yI
        qDSI5A7PcdM3ZE7CaXgNn6948WUVwhu1z8w40I5rg=; b=IA2A3+3Wqw8RQ6OgvL
        yOJ5SwtfZBLQQqxVdeDMbr5HdzZNjqj7dZp8e0ayopPkhgSZ/o34pFoYCAQIOZxK
        dzHx3gep5tN5i8CgzVL5jZMASo4VSbQJzjiRf5H+3gmt/erfirSlNrDxRid4A8YM
        rPs6tMNRrqsVbUMI/vLFi3bso5vvQV+q7x65fP6M1p25kVBTVB3GCsfX5JeONQyi
        XHpQPlyL27zHoykFk8nVkad2VGUq5UzeuU0DwlKPDD/pKLFWmBBFpzQQqQs/2A6D
        98RL3P6/wRcO59ICi9TxMfEhYjfIVFU2zrUq5ZtvN2ZOGLVpFOIA2/4nvh05N/XG
        juxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670243185; x=1670329585; bh=yIqDSI5A7PcdM3ZE7CaXgNn6948W
        UVwhu1z8w40I5rg=; b=NN5tv1jVYxtA5KaIMk8Wfi53JTDEVgD7/td7Yg2+K1Hl
        +cIBnk+MvuXb7S7NGkzYbrwH6VEoN5KzTTYovLA85qTRtbpDO2TwWCuAQni5Dhxw
        MHVbWEr34yin0msM+sCIBdlwKpU6eTb/s/+sS3VXqLmBcqquzMquTPE1Ax7BPJu8
        aii2jCBviaR3Rfp+tDMgZqPz/3UG3opcQjY8uxVTeiuEvAT0Az7wpJAvuaCWcun5
        HsQvMtb9lYVkRZnF/aQnqDkz0GAx1hFKJDrUUycPEFzb6tl8miujbLwlQRQjj9km
        MbTTZpUHtD8/EBtcqYs0OAteIFl5IshgBqB/iWqqOw==
X-ME-Sender: <xms:ceONYz3pDXcoTgAGboiWeSO2lPB1aoOdys8bOZNQVMWBpG8X_FD6Vw>
    <xme:ceONYyE5q2Itwmm0vXmMcG3CW7WwdEXpiVi6S6prPixTh0r3tKJw6mtERlZZoGQMD
    WZfT2N3ZLEBFxzYM6w>
X-ME-Received: <xmr:ceONYz5RBxgfR6DGfnWpReXL43vDAVNBVuCfj_tweSHSCgvlK20e6HmecuO3xqkfYx6rKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvgenucggtffrrghtthgvrhhnpeehleevveejudejke
    evueevteevfffhkeejgfehleethefhueejvdehieejgffhhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmoh
    hvrdhnrghmvg
X-ME-Proxy: <xmx:ceONY423Jrzk_vD9jrMrqHhOQ4RyGsQM-CrpAjf-wE6PeDDi21uR_A>
    <xmx:ceONY2GZpJ2NlC8Xky-_CLTgY_UhavYDNs7poSAxmZanCAxUFNDCzg>
    <xmx:ceONY58QNQXmMEC6ABY_22NtQOHKbF9oaxRvc010xmI9clTnCXgs3Q>
    <xmx:ceONY0YFRXCH7STZo_rrLynnIt0Qsem3eOB8WNc7HHUCLjOFibTKTQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 07:26:24 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0C37B10948F; Mon,  5 Dec 2022 15:26:23 +0300 (+03)
Date:   Mon, 5 Dec 2022 15:26:23 +0300
From:   kirill@shutemov.name
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/pat: fix TDX guest PAT initialization
Message-ID: <20221205122623.2px6y63rkkgvpxo5@box.shutemov.name>
References: <20221205080433.16643-1-jgross@suse.com>
 <20221205080433.16643-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205080433.16643-2-jgross@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:04:32AM +0100, Juergen Gross wrote:
> With the decoupling of PAT and MTRR initialization, PAT will be used
> even with MTRRs disabled. This seems to break booting up as TDX guest,
> as the recommended sequence to set the PAT MSR across CPUs can't work
> in TDX guests due to disabling caches via setting CR0.CD isn't allowed
> in TDX mode.
> 
> This is an inconsistency in the Intel documentation between the SDM
> and the TDX specification. For now handle TDX mode the same way as Xen
> PV guest mode by just accepting the current PAT MSR setting without
> trying to modify it.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Good enough for now. I will follow up if something comes up from the
discussion around the topic.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> ---
>  arch/x86/mm/pat/memtype.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 9aab17d660cd..4e50add760ad 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -296,8 +296,12 @@ void __init pat_bp_init(void)
>  	/*
>  	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
>  	 * supported.
> +	 * When running as TDX guest setting the PAT MSR won't work either
> +	 * due to the requirement to set CR0.CD when doing so. Rely on
> +	 * firmware to have set the PAT MSR correctly.

s/firmware/TDX module/

>  	 */
> -	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
> +	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV) ||
> +	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>  		init_cache_modes(pat_msr_val);
>  		return;
>  	}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
