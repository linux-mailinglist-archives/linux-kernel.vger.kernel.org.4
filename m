Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4927461A75F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKEDpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEDpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:45:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86A3054F;
        Fri,  4 Nov 2022 20:45:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 668953200900;
        Fri,  4 Nov 2022 23:45:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 23:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667619907; x=
        1667706307; bh=8NEuN8SPTeYqFJdZJ2flEYsKN0L1d2Z1DQJbyjEXnEY=; b=A
        OA6rgjrjPP9W3Srf0PtHE2dAUyEhtdlIImR4vIQfupbWhTLUhMOANhXkc4YA+BKj
        Goxqk2tgT0yqU0g3buzpFFbvx4XJpt0dNz0Hm+lhXy8kuMi77csy4KoyFvE9ZqGO
        MH6pGLEy8MUtDp0ApmElnyc1wEnKuZtgjAYgJDiOwRVcXbSG07dsJhXgoERgF7xE
        SU/GrckTodI8I3qGxoBcOMzkqmNI3sZfHyk1IL2Jb2VuuUDiOxXqqIb626vsMwgn
        n+nMB+8NjHN9hVv+DZxw3CpWyGSpG5qDYFHAvmBGD8FV3HublluvNyuKcYEv8JCV
        ajbL5nrCo72dej9gqcKcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667619907; x=
        1667706307; bh=8NEuN8SPTeYqFJdZJ2flEYsKN0L1d2Z1DQJbyjEXnEY=; b=e
        kiwLR3and6N+kb/NtgrykahcNGI+Iy1EM6jY1rCtLLqVAX06bi5xOBNtbgscNS2l
        jqWCo7NIX4U2ThE4ZIRBtgsfVoI6JCahNh/z7TjHA8jN7cGW9TrjKxSr3nu8NPgl
        F1ZxoymrzftlK2ZLWfCEomInH3C+EyC5gv174kfGe66kEaqjHdgeLqTOYshMg7wu
        6qoPegFxGPaZC8rYT/GhK85iuwMfAEOafqMmbpjxfJM/NAH/+HTSbDoPQ91GrUJ4
        6/oxbQL+HMAi3HxA9geBU0UHGTwR6sDwdJXiSIGuleHIX8G/8XNTwhUmd8FOtrrs
        COEgKfrzFaa8f82Vho8VQ==
X-ME-Sender: <xms:QtxlY875TzvBb17geuCnJwF0-7GUxoBtqFAkicr6i9-0dFptkQBtTg>
    <xme:QtxlY96MWlGSWHyUyIiJ5TR0BpvW-9jS9sBZkRcI0p93Qn0kUIGtAPRuoUWcIVvXL
    kVN3St9ANtis78-Vg>
X-ME-Received: <xmr:QtxlY7fGJVYTNGHmR1moyXcS6PonxLz28U7-RI-dREsXXLdfdjhthHUhMv8iVm_Uhz1CHeJpsSc57WIeTuXyyPbRt00eoJo-_kT1IxDlo7V_ac4oSpdn8lC4CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddvgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QtxlYxJyNcZSaM5yaqJhSBSwuVdgb1xcpTkupGQFCqLGxXwBqwi2ZA>
    <xmx:QtxlYwKCGWpDQ9F9cDQQKGp8vU7fwSmGpj-2r8e2d-UDHQ93hcZ0qA>
    <xmx:QtxlYyzDaC5WyEmDIk-3U1BV2AtAXXUF2RaxUvjBCWI3QX9K_EnVsw>
    <xmx:Q9xlY9CYzFxbVXRq45wJrCKjc_cWPvk5lY5NrzxIQn2-XqIorJkczA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 23:45:05 -0400 (EDT)
Message-ID: <81491c02-6c07-bf17-0a00-5c396f7878d6@sholland.org>
Date:   Fri, 4 Nov 2022 22:45:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-42-f6736dec138e@cerno.tech>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 42/65] rtc: sun6i: Add a determine_rate hook
In-Reply-To: <20221018-clk-range-checks-fixes-v2-42-f6736dec138e@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 11/4/22 08:17, Maxime Ripard wrote:
> The Allwinner sun6i RTC clock implements a mux with a set_parent hook,
> but doesn't provide a determine_rate implementation.
> 
> This is a bit odd, since set_parent() is there to, as its name implies,
> change the parent of a clock. However, the most likely candidate to
> trigger that parent change is a call to clk_set_rate(), with
> determine_rate() figuring out which parent is the best suited for a
> given rate.
> 
> The other trigger would be a call to clk_set_parent(), but it's far less
> used, and it doesn't look like there's any obvious user for that clock.
> 
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call to
> clk_set_parent().

For this driver, we always want to use the more accurate parent if it is
available. The driver enforces this in the probe function already, so I
think it would be better to just remove the .set_parent implementation.

Regards,
Samuel

