Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62105BFBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIUJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIUJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:58:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC603ECE2;
        Wed, 21 Sep 2022 02:58:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4BC6A3200997;
        Wed, 21 Sep 2022 05:58:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Sep 2022 05:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engestrom.ch; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663754296; x=
        1663840696; bh=eCra/b1EXsGAdvlyVpCtjB/oMgMMioXcrA1hoFjnEOk=; b=M
        0aUWi+vFc6y7/RGkB95PXAlrOeEWJ6PWHOIhNttqp3rbysLc2ao+d4H3a2oRrSRg
        qlr4hKw+m3Ugc4Ubj5mWTCZ5EFjsZZCKqYToWWQelDw4HHoY1HnJviL/URql10ip
        IP30t72kdTvJvExTTvnB4MMIvmU/NFHQufyHHo0DHFDihVwxGm6v5YL7JD1gZYMO
        mwej7mJpgZyZGSwQmSGRAfIgtsZ86C8ZTTA7regwHqakrZZxpZzEkEMXFODbPrsw
        GyeOM54UXMCH4BeH5u1C88UGFigWkwOcPxHa8kpXEteCLhwH8LznYxAIxHQSQ7T0
        ostC4oiFwX1AXHmgefwYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663754296; x=
        1663840696; bh=eCra/b1EXsGAdvlyVpCtjB/oMgMMioXcrA1hoFjnEOk=; b=x
        vEiM+dV9ObU/xEUmL9uWg+e/JWBeKglTCzFxWdjqOXhNXmzDG1bDGNc3FzDjsncf
        NXWo9QD2EYyAQfi3NgIvcEaHhFIAhiLaeil9H24NL/Batgmg+Co2uFWQdiW28qak
        EHxV4+kY/NwYFQL3THOB6KGjge9FskcnZZpoeGdGgDDW9EF/1iZ9zl0V0+vsaTOp
        Gr+GMYUzxh7zoB9bZVwKA5/VwVHo++IH5lOMzQhPEyFO+c4ace3dWTCBUUzkVB9E
        dOozWmytOHpNzpDCJFJg5JPMbh1Ziei4BWm8e4EYs4CSb3C6XP4/WtznmFYAZlet
        bxg3KZ2afk2T0QbsqQBtg==
X-ME-Sender: <xms:N-AqY7nY1U0eL0eseG3QZ6rH2LOIIO47eDbtWXuy_rNxguCzcuL-Vg>
    <xme:N-AqY-2YRcWY8yWw6ESkAg53j2KJ51sMZWDxgDz7csbllXXClA6nNan9wgc89RHx_
    biAMAdBlJ8XshfZDxU>
X-ME-Received: <xmr:N-AqYxpj4_3BFRWjPiftQ3aaYc5fSovQ_hcdnk6jBosSAyL93DJL1vZoS34dzdNh9o7MbMtHmcpkNA0C1omi6GmBeUZwvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefuddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    ekredttddtjeenucfhrhhomhepgfhrihgtucfgnhhgvghsthhrohhmuceovghrihgtsegv
    nhhgvghsthhrohhmrdgthheqnecuggftrfgrthhtvghrnhepfeegleegudefkeeuvdefhf
    eigefhkeelteeuvdfhvedtueetfefgfeffjedvleffnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepvghrihgtsegvnhhgvghsthhrohhmrdgthh
X-ME-Proxy: <xmx:N-AqYzn6tZGSPgwSVpaSVw_dwleW40gvPw3wfbUhu8j7KNclW_Xzow>
    <xmx:N-AqY52EGuDAWop-WJvl_qVmxqf9fFcIhSUlXT2fBMZ0B_VbjdmRtA>
    <xmx:N-AqYyshEiZTGUfKMd0RL6MGe3NhBX0hRksONyqI0YmI8CjveIUs-Q>
    <xmx:OOAqY14i_hrhuZ5uxNJoWkyBla1LvEYNhV9XRoNEuxMC_mfXUhtBQQ>
Feedback-ID: ieaa94438:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 05:58:12 -0400 (EDT)
Date:   Wed, 21 Sep 2022 11:58:09 +0200
From:   Eric Engestrom <eric@engestrom.ch>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, zhangqing@rock-chips.com,
        finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
        zhengxing@rock-chips.com, jeffy.chen@rock-chips.com,
        andy.yan@rock-chips.com, mylene.josserand@collabora.com,
        nfraprado@collabora.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: clock: rockchip: change
 SPDX-License-Identifier
Message-ID: <20220921095809.cr4kpqqcu7b5u76j@engestrom.ch>
References: <20c6a502-2ff5-bdb1-fb4f-0741f3a2c19c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20c6a502-2ff5-bdb1-fb4f-0741f3a2c19c@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2022-09-20 00:25:07 +0200, Johan Jonker wrote:
> Change SPDX-License-Identifier to (GPL-2.0+ OR MIT)
> for Rockchip clock bindings.
> 
> Cc: Heiko Stübner <heiko@sntech.de>
> Cc: Elaine Zhang <zhangqing@rock-chips.com>
> Cc: Xing Zheng <zhengxing@rock-chips.com>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Finley Xiao <finley.xiao@rock-chips.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Eric Engestrom <eric@engestrom.ch>
> Cc: Mylène Josserand <mylene.josserand@collabora.com>
> Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Request for copyright holder approval.
> Rockchip recently replied on other clock-patches to dual-license the
> binding.

Acked-by: Eric Engestrom <eric@engestrom.ch>
