Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F40611DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ1XGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1XGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:06:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A31DA350;
        Fri, 28 Oct 2022 16:06:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A998C5C017D;
        Fri, 28 Oct 2022 19:06:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 28 Oct 2022 19:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1666998368; x=
        1667084768; bh=6ErzU4gGH8yU302IzT7x6da7AL+aZ5llrq9RKS5ab+o=; b=m
        4KE7OmqbQjEH6Dw7ERDVmB6GefrXwfUe7oysqCxp3133igpTqTk1ZoW9smT1XyVM
        Hs0AUPK3HuPLBjX+oN8UfFPD4oP6wwUUitFUXyXVM9keADNGtoM/NLJU+AjTPxcL
        lyuBYKhtXcfPqK3wFLwH/CtKQ8hjI1xcBdYWMgTzyxbJbmfOsdl/tWQZgDkfB7/4
        OSwTsBPpe/8O4588iyhaXtUgjNrzzavsI4hzVaHMY7IpzgnF6JnGSqhS8k1O3qO8
        DI+0NqIq50m4O/pNFFkwoGTnEpCWRgnSnR2rYWNqmFOba5xRWs/3Y9FkFeES/LCT
        F7W8T6VQklOZgLaD1qH1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666998368; x=
        1667084768; bh=6ErzU4gGH8yU302IzT7x6da7AL+aZ5llrq9RKS5ab+o=; b=r
        3oYnFdEmdZp5pkHqVuUmxM4VBDFEnBscB3R/qKU3Oy5uJD8GJs6XM1SucbhJuVqM
        MUrnPHMByyJzoX9ZxNfuqXYwJ8Txz2DL0jAL5baPKqT2TwfJvf/FC6iizK/dmtc7
        XOFeTkw90EStN6MZJb79+6J7Er/3MT97cAnE8tO32mwWoeZay5yZ1al5qre2M3NC
        jU7SQzzlvn5CuG9JQc/e/WTsslUWu9hu+xmrbUhBZgXImGn5SyBhckPUnd2AKnI0
        KK6ckukK4ADwX8G5DhhN1H/gD/vDHh79OxbseuVhqiyv2zIw0SnCU6ucQjKYtJKD
        M2z/PLxlMpv6x9Diwd6Gw==
X-ME-Sender: <xms:YGBcY7xe3yfeZjsCWtvfyiCCoEKEqJcxfMYf6D1zv6jNhh2KwqBjRg>
    <xme:YGBcYzRafk6PU8IVgJpQ6u9ewraMSHpDCQc26uWcxQhFAeIhfl85AX0vZRXxtxr4q
    87xiZ65XfnEnI5Y0A>
X-ME-Received: <xmr:YGBcY1V4JyheSNZtpaHGF4OIv-lvOHQqAyxq5QPz2c1tayTybzyYYTPlgjcLxy0MDW_IIY3P0rp6tuZnqGDnyJtVGbsVbZJysvZCa9rcqOcwEpWWpqT-3kgMbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:YGBcY1gGKngsAa3EiqfAC_uuZakxRfHY9sRzsBhK1eDP98Ap56Fy3Q>
    <xmx:YGBcY9CH-1C7N_yfuTW3btaZe09km3mwHSU7v39NvYlOcA5QfjopYA>
    <xmx:YGBcY-JPxItgIvBNRhraPcJRjvPEAoTWlA5ZECp5D2765St7tECQ0w>
    <xmx:YGBcY8MPPsGMVtp6xZUgeJ2t18IQjl1XOJ7UFSKbrlJtoYqgEV_Z8w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Oct 2022 19:06:08 -0400 (EDT)
Message-ID: <6b23af14-340d-b7b5-7d20-14fae03f724c@sholland.org>
Date:   Fri, 28 Oct 2022 18:06:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] power: supply: ip5xxx: Fix integer overflow in
 current_now calculation
Content-Language: en-US
To:     Ondrej Jirman <megi@xff.cz>, Sebastian Reichel <sre@kernel.org>
Cc:     "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <20221028224052.293693-1-megi@xff.cz>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221028224052.293693-1-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 17:40, Ondrej Jirman wrote:
> When current is larger than ~2A, the multiplication in current_now
> property overflows and the kernel reports invalid negative current
> value. Change the numerator and denominator while preserving their
> ratio to allow up to +-6A before the overflow.
> 
> Fixes: 75853406fa27 ("power: supply: Add a driver for Injoinic power bank ICs")
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Reviewed-by: Samuel Holland <samuel@sholland.org>

> ---
>  drivers/power/supply/ip5xxx_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
> index 02ee4d252a3e..f39cb2f7aa11 100644
> --- a/drivers/power/supply/ip5xxx_power.c
> +++ b/drivers/power/supply/ip5xxx_power.c
> @@ -398,7 +398,7 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
>  		ret = ip5xxx_battery_read_adc(ip5xxx, IP5XXX_BATIADC_DAT0,
>  					      IP5XXX_BATIADC_DAT1, &raw);
>  
> -		val->intval = DIV_ROUND_CLOSEST(raw * 745985, 1000);
> +		val->intval = DIV_ROUND_CLOSEST(raw * 261095, 350);

DIV_ROUND_CLOSEST(raw * 149197, 200) would be marginally more accurate,
but it doesn't matter in practice.

>  		return 0;
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:

