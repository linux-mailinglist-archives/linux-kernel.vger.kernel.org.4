Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014963CF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiK3Gdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiK3Gdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:33:37 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2352EF41
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:33:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 14DC032007D7;
        Wed, 30 Nov 2022 01:33:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Nov 2022 01:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669790015; x=
        1669876415; bh=VW9z6eh5MzCdps/w72rAtJ1o+Cq+BDu6YqFNPuN/Giw=; b=Q
        17t3D8DfFNssoKUiUtkMrJCYV4Qu5Lns4Ns/3WMMC/3Utb/z7DIhjx6kTaVByRUk
        cSfAwtocDMBF8U37kjf9T6Ia/HAKxVLYda2oskkr726sxnoyYXw83CycFxwqlII/
        9vNUdmISxvpnRjMcwRFU8YcygfWGxX1fAKvT+8alTjNw7ahKoL2AgB20rniGYcc3
        tn8G5pmOkik7+Lv4O4LRfsfDQnoDy+exaTUPm419wbxWr2mZibV1JJwL2hoBY6ak
        bZs6DM9fT1u0waFX9lSReULz3EyJB2aMGa8iBfnzGESCorzOyUFBzW2G/F0T+afB
        9C0MU57g27OLawVLmeoAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669790015; x=
        1669876415; bh=VW9z6eh5MzCdps/w72rAtJ1o+Cq+BDu6YqFNPuN/Giw=; b=Y
        dMkbn5sHGu0P+WhBWOx05swSv7qRd4+gkiZnlQ/7jciBFEaxBXZfVn+PI3om70W6
        iFIL4n7/ZoM9L0dd6DIx04DPTG+M1e3uVF5A/7BqGiY741OZ7vGtVIyfyinO+15V
        iMV4S0o1V4iT6nkstPUzA5oNRpHxcE83UO0wMoB1ChZCtlJqzYa0f4S/HPp8wnYe
        zHpe/zyqqe27Qg5IZs26OLRUVcQ/QdNu5GACnp1kbqhnaD0kW4TSL/MaBGFO0IM9
        BEThPHFh2xnXY2UNQq7JCbQpNpUlQSEbsi2PLdhZSMeOIeeE4Dismzqq5hbXabyc
        bTsB+YPBFlDY94pS7buGQ==
X-ME-Sender: <xms:P_mGY8nu5kNED_x-vSseXxdbLOE9zCGkznOYzoglcJVlA1AqE_Dadg>
    <xme:P_mGY71dHhvyjUV80jrw7PjMHGUsMNLRLFtvHg3hOnn45eR21E7e0M5_-6YTVSDCu
    FAWF6TWHzBGlUlrig>
X-ME-Received: <xmr:P_mGY6oPwhsQugykJheaDLT2FLTXEOYrZp0BbA-GAop8HtdiRjS5O_VxdBq69PxWAOK_vyApAKfo0nR_P9lQgqX9T-p54onyRccPpacz2zHwfYopIWN3YjIa1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtje
    ertddtfeejnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhes
    shhhohhllhgrnhgurdhorhhgqeenucggtffrrghtthgvrhhnpeduhffffefhffduudetvd
    ffkeetveeiueegfeelleffiedtuddtffduhefgtdefgfenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:P_mGY4nTTk0ILD1f1KrMZyEtvrW_i2nFvK2F0TJJtFcAiv9XWAY9nA>
    <xmx:P_mGY63rLMkxnfY_lvz6BoN37wx40Orql4rjoO1OhW3DcBxsjN7VvQ>
    <xmx:P_mGY_tiQM47b1abrtwhv1PN3FnHtiqikMHTuUEI_MIDqFeCRcvqCw>
    <xmx:P_mGY_wMtqx9GB33QqalSLdN-gAyxQmVywqQ7QpqJtwU3-A9s1S_lw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 01:33:34 -0500 (EST)
Message-ID: <ac1efa75-97d8-de8d-1e80-adc61a53269a@sholland.org>
Date:   Wed, 30 Nov 2022 00:33:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mfd: axp20x: adapt to newly refactored unmask_base in
 regmap-irq
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-sunxi@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
References: <20221127072307.2092327-1-uwu@icenowy.me>
Content-Language: en-US
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221127072307.2092327-1-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On 11/27/22 01:23, Icenowy Zheng wrote:
> The mask_base and unmask_base fields in a regmap-irq description is
> recently refactored to be orthogonal and mask_inverted property is
> deprecated. The new semantics of unmask_base just fits AXP PMICs.
> 
> Specify enabling registers as unmask_base and drop mask_inverted
> property to adapt to the new interface.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

An equivalent patch was already merged:

https://lore.kernel.org/lkml/20221112151835.39059-4-aidanmacdonald.0x0@gmail.com/

> ---
>  drivers/mfd/axp20x.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 88a212a8168c..6e6b5dbab098 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -506,8 +506,7 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
>  	.name			= "axp152_irq_chip",
>  	.status_base		= AXP152_IRQ1_STATE,
>  	.ack_base		= AXP152_IRQ1_STATE,
> -	.mask_base		= AXP152_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP152_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp152_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp152_regmap_irqs),
> @@ -518,8 +517,7 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
>  	.name			= "axp20x_irq_chip",
>  	.status_base		= AXP20X_IRQ1_STATE,
>  	.ack_base		= AXP20X_IRQ1_STATE,
> -	.mask_base		= AXP20X_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP20X_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp20x_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp20x_regmap_irqs),
> @@ -531,8 +529,7 @@ static const struct regmap_irq_chip axp22x_regmap_irq_chip = {
>  	.name			= "axp22x_irq_chip",
>  	.status_base		= AXP20X_IRQ1_STATE,
>  	.ack_base		= AXP20X_IRQ1_STATE,
> -	.mask_base		= AXP20X_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP20X_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp22x_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp22x_regmap_irqs),
> @@ -543,8 +540,7 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
>  	.name			= "axp288_irq_chip",
>  	.status_base		= AXP20X_IRQ1_STATE,
>  	.ack_base		= AXP20X_IRQ1_STATE,
> -	.mask_base		= AXP20X_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP20X_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp288_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp288_regmap_irqs),
> @@ -556,8 +552,7 @@ static const struct regmap_irq_chip axp803_regmap_irq_chip = {
>  	.name			= "axp803",
>  	.status_base		= AXP20X_IRQ1_STATE,
>  	.ack_base		= AXP20X_IRQ1_STATE,
> -	.mask_base		= AXP20X_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP20X_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp803_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp803_regmap_irqs),
> @@ -568,8 +563,7 @@ static const struct regmap_irq_chip axp806_regmap_irq_chip = {
>  	.name			= "axp806",
>  	.status_base		= AXP20X_IRQ1_STATE,
>  	.ack_base		= AXP20X_IRQ1_STATE,
> -	.mask_base		= AXP20X_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP20X_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp806_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp806_regmap_irqs),
> @@ -580,8 +574,7 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
>  	.name			= "axp809",
>  	.status_base		= AXP20X_IRQ1_STATE,
>  	.ack_base		= AXP20X_IRQ1_STATE,
> -	.mask_base		= AXP20X_IRQ1_EN,
> -	.mask_invert		= true,
> +	.unmask_base		= AXP20X_IRQ1_EN,
>  	.init_ack_masked	= true,
>  	.irqs			= axp809_regmap_irqs,
>  	.num_irqs		= ARRAY_SIZE(axp809_regmap_irqs),

