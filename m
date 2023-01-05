Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4365E389
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjAEDeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjAEDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:34:09 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4B485B6;
        Wed,  4 Jan 2023 19:34:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CCB9B32009B8;
        Wed,  4 Jan 2023 22:34:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Jan 2023 22:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672889644; x=
        1672976044; bh=J5dtluVJN/sDCz5O/tnIQDUHTV9zIL4n+5iOhogQdAc=; b=f
        q2f0L04VWkCVzGLPpVpe6pu2vwvu11ugBpr1YE5NsGVWfNamFZTtA6mb8RB7obcI
        dKiKjqO/7zNxppLTWA1WRgGri6Lmz7dHUdF1Jroo1bDq7kogE4xfTvKubRGwmdwM
        AhDHzlSTCS4aW5KGxdc7zgfNHR50lbaxDz+Ay1j/5JgkOZKC+5JqIz6GjZbqL6Nb
        PCRFaa4IQorYDTcKT0IYchcNKTpN9IeDMfIiPWmS8/VzrgZZLeORErEcRXw0mbLS
        8mCTnvSfjw/CiDEJn90jQittQ5FwGHk9/9RQiBIkbcHY5n3otPYXs0WhN4NjYqRS
        vhW6b8N6B/nIsAnn9fPxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672889644; x=
        1672976044; bh=J5dtluVJN/sDCz5O/tnIQDUHTV9zIL4n+5iOhogQdAc=; b=Q
        O+QQMzzT6VCvmRtb8h9gVIM9Y7MBT8BBuNHuVMAZTqP3jXCUcw3wGAFCw19LOYHz
        BrFvURAIwm43NbnQ0F0D5XsN1zm8VKC6Xlf3YweUJxVoRwOo1foK3E5mtBg/304j
        D1ZzFR3dcGl2IlYefSabtAj8R59DaQO7VvcgyDZR38vmzackopGpHUAjeF/1mmfK
        QyMKzicWxlH/q8IXJ1mmR2HQ4VB2NQGV/2E49+53/LC3yCa5wqYc9xWO6N26K2AW
        cg/mXu7+/t1OWrQlHGhIEKFPWtQrH0VaHQwrnMFG5KPGx3YbYUOkAq7ZbOIOFYxy
        /jHoz5fvBEWwlBGBMf6Hg==
X-ME-Sender: <xms:K0W2Y3DTkQj5xtaTFYAaqTM7_efDj7gwl97GHYQrDBMHyyFwcnzk5w>
    <xme:K0W2Y9jCQ_2jqa5blvk76vQajAx9zWL_ohspG3b_vPxzow8IMBKWaZhsewD2YhR73
    Stx-BcCfLSpynqSQQ>
X-ME-Received: <xmr:K0W2YyleaJ2T-D3kpRaOLNBw3A7z74GbeWrGGdNeZfuLSnPHDiN4FtbH_3oxI87iJDWMpNBf33vD5jHLbbmdL425RFIlulLnZpY4YX0P1pnz3afGJXeddfgbJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeejgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheettdefgeeuudelvdffleejheejueeludduiedvkeffgeetueev
    vdelvdetfeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:K0W2Y5xZuGqFpBxlUXh3QbSx-fGevjcGeGfBkjJjfKw3ZrMtyTY5iA>
    <xmx:K0W2Y8QTFDFwSKurhzAaFS5Cx11OUoaN3yWds8uh9FSsVz-Zt3_1Zw>
    <xmx:K0W2Y8Ye5aABlp4CH9IAZv4K26nl1d8ZkjCu9fIzZ1fkUv1-hIW4jw>
    <xmx:LEW2YxJYz-mzlMrdCqjuXT6YnzW4XjX1Ps6CA4nsfFBGUKNle_H7Nw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jan 2023 22:34:02 -0500 (EST)
Message-ID: <15cd1727-eedd-d476-e52c-2234cf66a5c9@sholland.org>
Date:   Wed, 4 Jan 2023 21:34:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Christopher Schramm <debian@cschramm.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
References: <20230104140459.1147626-1-masahiroy@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] kbuild: readd -w option when vmlinux.o or Module.symver
 is missing
In-Reply-To: <20230104140459.1147626-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 08:04, Masahiro Yamada wrote:
> Commit 63ffe00d8c93 ("kbuild: Fix running modpost with musl libc")
> accidentally turned the unresolved symbol warnings into errors when
> vmlinux.o (for in-tree builds) or Module.symver (for external module
> builds) is missing.
> 
> In those cases, unresolved symbols are expected, but the -w option
> is not set because 'missing-input' is referenced before set.
> 
> Move $(missing-input back to the original place. This should be fine
> for musl libc because vmlinux.o and -w are not added at the same time.
> 
> With this change, -w may be passed twice, but it is not a big deal.
> 
> Link: https://lore.kernel.org/all/b56a03b8-2a2a-f833-a5d2-cdc50a7ca2bb@cschramm.eu/
> Fixes: 63ffe00d8c93 ("kbuild: Fix running modpost with musl libc")
> Reported-by: Christopher Schramm <debian@cschramm.eu>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.modpost | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Sorry for the breakage. This works fine for me, with or without vmlinux.o.

Tested-by: Samuel Holland <samuel@sholland.org>

