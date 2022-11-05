Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951DF61A6E7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiKECcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKECcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:32:11 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B042E68A;
        Fri,  4 Nov 2022 19:32:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 257833200437;
        Fri,  4 Nov 2022 22:32:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 04 Nov 2022 22:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667615528; x=
        1667701928; bh=ijJvdLYIYldUXAOtaIMJyb2s/LtRvLB9vF5LnGhLHK4=; b=H
        EPxGf1aw8Uhh0fRHoPnJuo5euH1pTk3kOEOON0LtzMWiwJWTpU0tTgc27N0hXdiT
        qDOt/wcUuHnPz2TN3HS90jOE2HyXd9Mj0dEOB2cS1BdaFy5ut+/ep/hbiJRY841u
        6iJLPjQtgzhiZeeByqkFJlxNhYJugDwcIHYEoisoyJQ8ULOWby4d00xk7sOZaxAF
        fttyJk9veMzzfQlSJKQ0gJRVIuJSK1dSeePyvXuHwbR45ne2vQtDHFoiDwdNGY+m
        4IDjdNvfsSORdqCn8nbf+tedJXv/n1W02oTJjOu2HaIjTWHFkzyB73kj8aJgnQxR
        UMq0DOWV40lbXJMG6N/ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667615528; x=
        1667701928; bh=ijJvdLYIYldUXAOtaIMJyb2s/LtRvLB9vF5LnGhLHK4=; b=R
        CPHyofYQzG5wTHOMb+KWL4GoGBCku0X2ghycH49t5XMyTQAxkVvwbM9+N03RG3K/
        ezTkaTSqUWEz9h+QjWDTDat2AwNBVVK7DPPQu1RCpReSPx5ThRthyZyxu8mplKQk
        GYddjePun4rDtnSC0mOykO9JBjCNGXkR9H+IZnFB06gDHdA1Lhvqh8Fvb0prE5KV
        FYnWl2OInxpfgGDkjMnwGH7e9tnK+gfSkjh0mpFUUSR3yLcRTQi4iMTcf9xAZ3NJ
        2Jy2bYj6kMphMmaqxqTxdVeUuECYRtCufSGjDfw9FCOV2tIQZ0xJUjvfkFf8nY1w
        QhTzfPaiIF2j995N5eLdA==
X-ME-Sender: <xms:KMtlY8fbgDBClDHMlf7WLd10iTJGZVW2QvDaYlDlQgJUPBaX8QiyuQ>
    <xme:KMtlY-N5vOF187Z-No8LpJ3lv05xgBTSK5b7MR_YpieGDNiDL0H63kxsSpvOVq8Fx
    IXMbFw2_qQdHUFjrQ>
X-ME-Received: <xmr:KMtlY9gvZqHyezeLczDO_5FnSI8z0YF8s7QKiptkRe-wJiPwtgu_gw7w5TDdUes3nnCSBNEGaZ2i41-Uoj0ZvC7Ul1c_-Q6OzH_QueQA7g3oIvCYtyImSwEU3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:KMtlYx_bgTebu0wyPMQBbXGl8OxN1ejCsfGp1xVDeihsSSAtn7OJ2A>
    <xmx:KMtlY4vq_2sR5t5Mg2gqZ_3j3WbYbayuox0LK1JLo93vH0wD8jRS6w>
    <xmx:KMtlY4Fbuiv4xh2b_71c3Ae16PkVkvV11RtwGq-AdEvwQzU49pvydQ>
    <xmx:KMtlY99CFBeML--Dj5kXYPz6vg_XjfSid4lvNj2oFMtIk9r02l07vA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 22:32:07 -0400 (EDT)
Message-ID: <90fcb1bc-6388-d4ba-a9cd-c5d35fb27e74@sholland.org>
Date:   Fri, 4 Nov 2022 21:32:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20221007234553.12328-1-bage@debian.org>
 <20221007234553.12328-2-bage@debian.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/1] arm64: allwinner: a64: enable Bluetooth on Pinebook
In-Reply-To: <20221007234553.12328-2-bage@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastian,

Please make sure you include the sunxi platform maintainers (as reported
by get_maintainers.pl) when sending your patch, so it gets in our inboxes.

Subject prefix should be "arm64: dts: allwinner: a64:" (with "dts:").

On 10/7/22 18:45, Bastian Germann wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Pinebook has an RTL8723CS WiFi + BT chip. BT is connected to UART1
> and uses PL5 as device wake GPIO and PL6 as host wake GPIO.
> The I2C controlling signals are connected to R_I2C bus.

Please remove this sentence; it doesn't make sense. The RTL8723CS does
not have any I2C connection.

> Enable it in the device tree.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 620cb3ef5f6c..19ba87c411ed 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -406,6 +406,19 @@ &uart0 {
>  	status = "okay";
>  };
>  
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8723cs-bt";
> +		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */

You also need:

		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */

(this is BT-RST-N in the schematic).

The rest looks good to me.

Regards,
Samuel

> +		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +	};
> +};
> +
>  &usb_otg {
>  	dr_mode = "host";
>  };

