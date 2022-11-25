Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED3638703
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKYKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKYKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:05:48 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB427DF7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:05:47 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E5F2B5C0097;
        Fri, 25 Nov 2022 05:05:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 25 Nov 2022 05:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669370746; x=1669457146; bh=nCUDBJBJHd
        ePT/oDuUKf6UFCDmSjLUzfGVmKPcZYTHc=; b=oc85BrLut4eMUnLgtSRs1dBRTq
        yTswdBUuAAzRMymMAHCp/TQIRDoBx518DMQgvdN0tkYLQJpNvtdYuXNpOQesU0I+
        oRLgfx53QU9qBPgO7jaUGNLiJeQGDpik4jgwggvcyPCGzcdvSg+OtH3Ttk6zJbtT
        PCPek/BYIY+11yocO7hR6Gqs5UHpbXoLhXqS4Fz/99rnMxXfdBXPv1CB216C4LOm
        F5EVAtvkGVYzC9NsMSCA55+arEPPG4yXyg1HXi0uYp7j+K6qOdXBKmQkRHQZhGzZ
        Q3IXjBaj2FpFr0oL3GgWK5EOwHIDITpVSqgSzCViu/6hKxGsj0zQ1A0BXVUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669370746; x=1669457146; bh=nCUDBJBJHdePT/oDuUKf6UFCDmSj
        LUzfGVmKPcZYTHc=; b=ggjyDftopnn52yQ2dDvZS842qcWdpe2HJmciqGNBdASv
        pNuccXdeNieJIhwXCRb09AHgoOg9k/z3sqKT7kT+ekaYpfqaywl7agbgTTiIlF3+
        WSHZGyjwnK/JFMXWbK98v94+qUcJnpAoU2WWhud10sTVXfe3tYLarAzoJFCeoWED
        s/Jvbh+gkf4WCnyn1qiLsXayabbm7irh8J7kTXEJmJC+PoheT71zl69x5M3BRkhy
        pgh6dzcj03fFnzCpZLLNAIwaDoSz9dJwPJkO+SigUonK+JegC22mEy110GII/zet
        D9yxsIrf8q+KwtM5Qcs8i0v7r7DzI1HZzsgvUoBDlw==
X-ME-Sender: <xms:epOAY-3Eda9GKDnL0an58UF2OVpH0x6YAVoG1C_Sdtgb3vikBvwipA>
    <xme:epOAYxHjg9wa3ByCOZWnpG1N28dOcQDleoLQhy88eiqhIEAxBPDOIrfj7cFFVoDtR
    QdTOMhYUGeiMy5y4qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:epOAY25MNWvqDiJnbPXQ9uy9Y4zHwqSgeaRqeB54Mf9XjqKdBspppA>
    <xmx:epOAY_3Kp6Z2JNnZpur8lT89l6uifeBJU4CvKOGt1Fwvyj5RD9NjMA>
    <xmx:epOAYxGAUHlSw1G2EmHIdcsjKUDlArxIcMu4YFSxe0lU3ZpzeaufaA>
    <xmx:epOAY__-3AAdEaTnWCpWNS3s6huDcSrM1uHPHzV-rz-3qU8_cyt-Sg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96163B60086; Fri, 25 Nov 2022 05:05:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <aec6ed25-6999-45a7-90d0-121ce315f45d@app.fastmail.com>
In-Reply-To: <20221125092517.3074989-4-lee@kernel.org>
References: <20221125092517.3074989-1-lee@kernel.org>
 <20221125092517.3074989-4-lee@kernel.org>
Date:   Fri, 25 Nov 2022 11:05:25 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] Kconfig.debug: Provide a little extra FRAME_WARN leeway when
 KASAN is enabled
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022, at 10:25, Lee Jones wrote:
> When enabled, KASAN enlarges function's stack-frames.  Pushing quite a
> few over the current threshold.  This can mainly be seen on 32-bit
> architectures where the present limit (when !GCC) is a lowly
> 1024-Bytes.
>
> Signed-off-by: Lee Jones <lee@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

If this affects only clang but not gcc, I wonder if we could
limit the scope and keep the 1024 byte limit on gcc builds.

> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c3c0b077ade33..82d475168db95 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -399,6 +399,7 @@ config FRAME_WARN
>  	default 2048 if GCC_PLUGIN_LATENT_ENTROPY

This is actually a related bug that we should fix: allmodconfig
with gcc turns on GCC_PLUGIN_LATENT_ENTROPY, so the limit
ends up being way too high. I think we need to either ensure
that allmodconfig turns off the latent entropy plugin,
or that the limit gets lowered again to something that is
not any higher than the KASAN limit.

     Arnd
