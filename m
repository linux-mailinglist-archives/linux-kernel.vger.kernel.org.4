Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7485B30DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiIIHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiIIHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:51:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4F11B013;
        Fri,  9 Sep 2022 00:46:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B60B96601F9B;
        Fri,  9 Sep 2022 08:46:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662709597;
        bh=7kCb8Q9ZMu3AI6cJXYCkilwxUD9TCXEnwK4oypdPsiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AGxDqSEytkwhvo2Uxi9UjmnHhTy7fqYOxvXwpJ/jHff+uZZVkKw9JkubKnJhUoH4/
         HK7GHtYg5QKRAByTog8CTOtZRcbcZDIdrbAHFgflwj8QXYkn04Ak8FpFEIeTX88vgx
         LFoKX6cn2eZobROzQHB3kRm7JUP/4XybUe/ZogGnFLskQEbhAU8kjEVVsZlQrcBXAv
         1ZYuljWARkZ/so0fBv8YLNXwq9iV4+EDSfgcGB366fnkiXus3+vashk7mJyywwmVwA
         gKmMqDKFFo4pidz6eF1C4TlAhDVxJTsJw1ZMHQH+N2x6kwlcciXl2pACssk/XV/0Gw
         8t2jpsMPmRT4w==
Message-ID: <ab2027b9-17e8-4fe8-3847-84c54d6f9d58@collabora.com>
Date:   Fri, 9 Sep 2022 09:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: asurada: Add display regulators
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220908171153.670762-1-nfraprado@collabora.com>
 <20220908171153.670762-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908171153.670762-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/22 19:11, Nícolas F. R. A. Prado ha scritto:
> Add the regulators present on the Asurada platform that are used to
> power the internal and external displays.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     | 114 ++++++++++++++++++
>   1 file changed, 114 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index 4b314435f8fd..1d99e470ea1a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi

..snip..

> @@ -56,6 +116,18 @@ pp3300_ldo_z: regulator-3v3-z {
>   		vin-supply = <&ppvar_sys>;
>   	};
>   

Can you please add a comment here advertising that this regulator
will not only provide power to the MIPI bridge, but *also* to the
display panel itself?

This is to make sure that everyone understands what's going on, and
also that we ourselves don't forget about that.

Probably something like:
/* pp3300_mipibrdg also enables pp3300_panel */

I would then propose to add a "regulator-fixed" that has no GPIO
but with vin-supply as this one.

pp3300_panel: regulator-3v3-panel {
	compatible = "regulator-fixed";
	regulator-name = "pp3300_panel";
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;

	vin-supply = <&pp3300_mipibrdg>;
};

I would also test assigning this regulator to the panel node, as this
will make sure to cover future corner cases (think about PM suspend/resume).

P.S.: If you add the pp3300_panel regulator-fixed with that vin-supply,
       maybe the proposed comment would become a bit overkill. Your choice!

Cheers,
Angelo

> +	pp3300_mipibrdg: regulator-3v3-mipibrdg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_mipibrdg";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pp3300_mipibrdg_en_pins>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
> +	};
> +
>   	/* separately switched 3.3V power rail */
>   	pp3300_u: regulator-3v3-u {
>   		compatible = "regulator-fixed";

