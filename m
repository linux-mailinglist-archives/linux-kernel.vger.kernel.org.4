Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A36439ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFA0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFA0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:26:15 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4C1EAFD;
        Mon,  5 Dec 2022 16:26:14 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 164663200949;
        Mon,  5 Dec 2022 19:26:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Dec 2022 19:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670286367; x=
        1670372767; bh=3CGH9HhcetAdOgZSRwrfM5MD0lJuEd9B/GIe9kj/hzo=; b=n
        697w9xePqnt2Zr3AVOYOpv1h7X1AQmkS04kXCqeNZHLbJXdt9PnmsJPqluA6y6ie
        DXdn9kuXkvIyy1DTDYK1+bG6fUqVs/Lr9bb4KkFlliQiBOOZmfoSC9Z5nVO6dJPR
        vUs+s2ilSQr++aq6Ke+AgwmTaXhj3EkmoPG+6SFh0QqB2CeV/zlJBq/FAlyapcqx
        5wxc4b8fF4NSiWqehCSuFGdN/h6eNKqwc50j4EsfKRhapoAPZMCq3kinMNW+E9Fj
        MMiJFCGzGJnCgQskmbFvaEQfvWK55jC5hKIwwPz+UwO6oLb8UZ8eU/HmKZJKwgpH
        D0bK4WEnxrHtYYqsvOfDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670286367; x=
        1670372767; bh=3CGH9HhcetAdOgZSRwrfM5MD0lJuEd9B/GIe9kj/hzo=; b=O
        em+0VDYY/AXEgAj7nY65hj0uJYXOL785k8+91di15IoD1U2+jVdHzau7G1xGoi8z
        qBqFfxFereUCg0wfonbB/+SIgz4+cl3qvCK3y7H6mYS5R/Weki1S8XtxhvPwceYl
        ZPNL11seHwZpKVxqu+gRCw1Sf04CaYx0yYwpxelk6PtUZm3QJsMTE8Hrhr0fVZsN
        IWcVomtJ1qhhUYjor787JHQQHOTdmsvSyTuZQqDTI8oQ+Enzyjt83PAXBDOWy8iv
        BwWXnxc7ewwgVi3oJKrR8Rm0fwCdvo3dUKmE8s/BGPxCjzdzMFAPb1yh01lrL1Uy
        X49CGSCATWlSeIbVtaNEw==
X-ME-Sender: <xms:HYyOYwsO7GWFkR7v6vKER5mxp7Ziy4rt6W0xVjT7AoQUCSPzJOVsqQ>
    <xme:HYyOY9f4OT4eUTy3q3uz3x0Lw8ZLWJH86oiBAsHVefsGSGkaUavM9Gh0MY9Y8Vx2Z
    iznm9OZXVmwzlUuvw>
X-ME-Received: <xmr:HYyOY7x11GOALng9029pCIVpTVajcn-IK5ua9-TXXHnZ45Cr7f_jYtIwCF_kmTaUah6dbW1iZcI3sY1bGM1joYBLTtVc7ZWeGCgiQBm6_wCQ5viH_5XFIa1X5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:HYyOYzN1cDkTRtlUiCITJiIuL6oNrli1quZxUCK-r53n-GMpSr2I1g>
    <xmx:HYyOYw99df9U5mgzoIWdzSMyiUloHMH1unQh-DoY_7VhDA_2r6-zTA>
    <xmx:HYyOY7VVHCBDiKt_1-5_42hClQ65j-GuZJ4azHghgi525HtyZBgqjw>
    <xmx:H4yOYyye-CmZk9os8yvj-jdcmxMzJKm3FZwbx5VaSf-i7gUK0IXNrg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 19:26:03 -0500 (EST)
Message-ID: <a0c767d5-eb55-3479-c4bc-1029809027f5@sholland.org>
Date:   Mon, 5 Dec 2022 18:26:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 6/9] arm64: dts: allwinner: fix touchscreen reset GPIO
 polarity
Content-Language: en-US
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v3-6-0975809eb183@theobroma-systems.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221103-upstream-goodix-reset-v3-6-0975809eb183@theobroma-systems.com>
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

Hi Quentin,

On 12/5/22 07:40, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The reset line is active low for the Goodix touchscreen controller so
> let's fix the polarity in the Device Tree node.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts       | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi          | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts             | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 8233582f62881..5fd581037d987 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -122,7 +122,7 @@ touchscreen@5d {
>  		interrupt-parent = <&pio>;
>  		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
>  		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
> -		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
> +		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>;	/* CTP-RST: PH8 */

You are changing the DT binding here, in a way that breaks backward
compatibility with existing devicetrees. NACK.

Regards,
Samuel

>  		touchscreen-inverted-x;
>  		touchscreen-inverted-y;
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> index 577f9e1d08a14..990f042f5a5b1 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> @@ -45,7 +45,7 @@ touchscreen@5d {
>  		interrupt-parent = <&pio>;
>  		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
>  		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
> -		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
> +		reset-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>;	/* CTP-RST: PH11 */
>  		touchscreen-inverted-x;
>  		touchscreen-inverted-y;
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 87847116ab6d9..97359cc7f13e2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -167,7 +167,7 @@ touchscreen@5d {
>  		interrupt-parent = <&pio>;
>  		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
>  		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> -		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
> +		reset-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
>  		AVDD28-supply = <&reg_ldo_io0>;
>  		VDDIO-supply = <&reg_ldo_io0>;
>  		touchscreen-size-x = <720>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> index 0a5607f73049e..c0eccc753e3f5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> @@ -189,7 +189,7 @@ touchscreen@5d {
>  		interrupt-parent = <&pio>;
>  		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
>  		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> -		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> +		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
>  		AVDD28-supply = <&reg_ldo_io1>;
>  	};
>  };
> 

