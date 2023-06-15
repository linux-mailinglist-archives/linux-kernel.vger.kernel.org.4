Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6639730F15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbjFOGIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjFOGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:08:22 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA404A7;
        Wed, 14 Jun 2023 23:08:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F684Wv012964;
        Thu, 15 Jun 2023 01:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686809284;
        bh=3NAjiVPIi9Qh+/1jZT4iJ5D7YNH/KCh98ShDdQJk2YU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fZuKARzRDnB4cb4JFjO8ZpDwEu8LCDyEUcMTJ+U67Xo2zVCXyBVXDiKnqiWxhZqUS
         OcIR4RGNaEcIG12GTtLNYKgnEmwdD9O9d0ILDELqmEVphffoBbu1fU3QKO6KcmKadj
         MypvgVJkP928i74ERPLN4dyLLrWMpPxuHGHt/JfA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F684w7117061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 01:08:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 01:08:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 01:08:04 -0500
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F680rA015262;
        Thu, 15 Jun 2023 01:08:01 -0500
Message-ID: <62ca6112-0aca-788e-fc9b-8a2c3ce9ba1f@ti.com>
Date:   Thu, 15 Jun 2023 11:38:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] arm64: dts: ti: add verdin am62
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-4-francesco@dolcini.it>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230601131332.26877-4-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/23 18:43, Francesco Dolcini wrote:

[...]

> +/* Verdin I2C_1 */
> +&main_i2c1 {
> +	status = "okay";
> +
> +	/* Audio Codec */
> +	nau8822_1a: audio-codec@1a {
> +		compatible = "nuvoton,nau8822";
> +		reg = <0x1a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2s1_mclk>; /* Configure AUDIO_EXT_REFCLK1 pin as output */
> +		#sound-dai-cells = <0>;
> +
> +		/* POSTDIV4_16FF_MAIN_2_HSDIVOUT8_CLK -> AUDIO_EXT_REFCLK1 */
> +		assigned-clocks = <&k3_clks 157 10>;
> +		assigned-clock-parents = <&k3_clks 157 18>;
> +		assigned-clock-rates = <25000000>; /* for 48KHz ± 1.7% */
> +	};
> +

Oops, this node fails dtbs_check

make ARCH=arm64 CROSS_COMPILE=$V8_CROSS CHECK_DTBS=y ti/k3-am625-verdin-nonwifi-dev.dtb

/work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /home/a0132425/workspace/k3-next/Documentation/devicetree/bindings/sound/nuvoton,nau8822.yaml
/work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	From schema: /work/.local/lib/python3.10/site-packages/dtschema/schemas/clock/clock.yaml

[...]

-- 
Regards
Vignesh
