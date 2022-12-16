Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D364F0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiLPSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLPSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:30:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9D10B5D;
        Fri, 16 Dec 2022 10:30:15 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CE5CF5C011B;
        Fri, 16 Dec 2022 13:30:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 13:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671215414; x=1671301814; bh=ufIy2Gx0Em
        OXpkDAuEw/RWh0UGiPvw4YnMU8O/VoizQ=; b=fzWr716TH55LX4yLPMQNBfMmQ9
        W1ba6t6lfvEud9Id1MVtcfXNLRhZGoXcPjUQTwZsXE6fqF4A9a1Lb1dTlr80lrki
        zVSTypcQ+Jh4qIkJJUi/PSUAxnniNaMH7FyDrkQtnykKNmV8P3wXcAHw2Efm044O
        /6aQae3X13EOpiGx2pCaZIRCN5cCnKjXRtV3BNaTCQ+u27+SBLwTm9EJTJRJekyE
        3O5KAxF+G7J77kM8azuJXAQegobSP+fGlraHkV/Irhg+ShSpRjMSOICRz2Z7Sc2n
        H53abjAzt12r6EByr1YJ+wSbujEVbi9/i6V49csI8OwMP8fTEdZXkXi05EWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671215414; x=1671301814; bh=ufIy2Gx0EmOXpkDAuEw/RWh0UGiP
        vw4YnMU8O/VoizQ=; b=vOZmNWeyUTHdDlMVEkkqgToYsS1/K1D9bJCNPfj1Np98
        1tu651qvHfSdIKySYtUgu2d+GgIjpbdf2INkolpqqbgPliRMSxhhoNKlcrNkGqHx
        nwl9qKtPKa6gkLwlRz91gs1tW4PnJlYcplTRzC+kFdbh0WRfmGPr5DXdAIHsMAAT
        DjP7yxqHYYME3YdhoFVf+0YDLTlTRpS3vPLZvYgywnLPDlwoQwnOqzFVk4tlHBdJ
        DC+BiDU6biGCSZOfjgwyXM9+YTNcwoaBCcx/VI6hEagQaXnwSkr+/STy9R9dGSSr
        RkEbyPAWa/CihsMItKvP5hsAVeRvhHPqSu60wTY0Rg==
X-ME-Sender: <xms:NrmcY7vO2N3_eFrjQfzqik1U0PJ4TNbwX3QQFQA5huQczgKdrfFwVQ>
    <xme:NrmcY8cjZkVO4vieTVjV_FRVSfZS0t2LGPr3iYdHNdQE0bEYuVUlbSl2wsc_Db-Zi
    uhRY-lwJYdpQrFDEDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NrmcY-xddtUEqym9HnIuMVECwRtsrI55K69UvfA6Ew1Dp1VoTunMyA>
    <xmx:NrmcY6NxO74aALsq7grwty_8K0pjNG-tF5kYG9-hieWkOPtgdktnWA>
    <xmx:NrmcY7-Y77_SjdXn0Hbt1PDes2WWJRHdaCWrZjWaEnUxLFPzzJ1AgA>
    <xmx:NrmcY-YUi5fpx-4XLbXgfambAR_bwY4K5Rl9_U5Xxz7Uho3Z99Nn-A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EE344B60086; Fri, 16 Dec 2022 13:30:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <aa26bed0-dd8e-4fac-9606-91769eee96b8@app.fastmail.com>
In-Reply-To: <20221216160841.2061759-1-glider@google.com>
References: <20221215162956.4037570-1-arnd@kernel.org>
 <20221216160841.2061759-1-glider@google.com>
Date:   Fri, 16 Dec 2022 19:29:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Potapenko" <glider@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: wp512: disable kmsan checks in wp512_process_buffer()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022, at 17:08, Alexander Potapenko wrote:
>> The memory sanitizer causes excessive register spills in this function:
>
>> crypto/wp512.c:782:13: error: stack frame size (2104) exceeds limit (2048) in 'wp512_process_buffer' [-Werror,-Wframe-larger-than]
>
>> Assume that this one is safe, and mark it as needing no checks to
>> get the stack usage back down to the normal level.
>
> KMSAN indeed bloats the stack frames heavily.
> Wouldn't it be more preferable to further increase KMSAN's 
> -Wframe-larger-than limit instead?
> It is not intended for production anyway, and detecting a runtime stack 
> overflow in the debug mode should not be a problem.

I don't actually see a lot of compiler warnings with KMSAN
hitting the limit, I think we can deal with them individually.

I'd rather not raise the limit more, as that makes it harder
to identify functions that use more stack than they should.

    Arnd
