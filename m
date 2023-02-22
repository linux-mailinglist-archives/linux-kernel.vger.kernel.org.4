Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9969FAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjBVSUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjBVSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:20:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE6438B5B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:20:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h14so40525wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MswBRPm/o9JdJ+YWMq8NmSLgLFu7yJdf1U1uT0bi4wk=;
        b=NfOvyOI0C5+enF221jxuifhLVKUhWyMMu7qxX2m0Q43IdHZJpVxAn97Cmt3PZOSd/m
         lwzjULy50xcYr9IIbWsae9aokPMG0trlHC7nGM5TYQKvVlKibEASolaOiWhN6ZTddRHi
         zG5z4VNwssd+z5ThR51Zh37yyhHQpVPlZG5y3HTD4UmdHyVZqOcvGTevobuy9tItkx99
         oL3hcgNl+DkVpiB43bR0gA7L9hQDHPVqepXNl5RyfUMTX5t+dMQ3Nxu67CSO7sTflOK3
         hVgAeR4J5zjdv8LPxAV0q47HkmEyKprl+oR8cEeWIy0a9BxEf8ENIoo4TsH4dAf+dALu
         9zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MswBRPm/o9JdJ+YWMq8NmSLgLFu7yJdf1U1uT0bi4wk=;
        b=mHjR/NsHRJAfLStJgTIbwoKeYHAxyOQ3J0i3fycG4rmSU/Jo8/O4x3zVnL7pOQD4Hz
         A6DIK8WWTLEOFZDaoZ8L6iATHZSmAIa2VLTH/s/Z80yMW1sN/TzHWkTNc2VEnHd4kdhj
         e7MzwRsqjG3s3kqeKpUHNQ9bwD8suMXkuyWaBqHxI/K2HZX0jRzqSJqN7hOjy5jo+1nr
         0hCts1x7OIzzdHJmRs8D2Tub174m9GxG9//E/0tVV5GqFUZh5KDBCddi5ob/VS4KB/1G
         Z3W9fBAMuq/l6yIRomtig2J6z/jTCimDlES5hGzQLMHGy029gwRudf/WvwAoqolLPF3w
         CshA==
X-Gm-Message-State: AO0yUKXX6t7RP3yU2OPfZb5oUZCmPxMxzVJzlCTuyr2ixZ+bzDLhVTd+
        bS5BUCgRmiPiYt3BWlD8m1nPww==
X-Google-Smtp-Source: AK7set/rCX3TN0bFObtV37T8Ft5AfHXy9F8TYRj2H1N3WNQU/y2Xg2H5fIrSrXdlLtcHSyC7by5vKA==
X-Received: by 2002:adf:f207:0:b0:2c5:9d84:6067 with SMTP id p7-20020adff207000000b002c59d846067mr6573246wro.63.1677090012648;
        Wed, 22 Feb 2023 10:20:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e7-20020adffc47000000b002c70f5627d5sm156910wrs.63.2023.02.22.10.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:20:12 -0800 (PST)
Message-ID: <da380923-3c36-ac14-d9ea-2a4ec34e4b0e@linaro.org>
Date:   Wed, 22 Feb 2023 19:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230222182252.2ad6d82b@booty>
 <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 18:25, Luca Ceresoli wrote:
> The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
> NXPP SGTL5000 audio codec connected to I2S-0 (sai2).
> 
> This requires to:
> 
>  * add the power supplies (always on)
>  * enable sai2 with pinmuxes
>  * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
>    IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> index 470ff8e31e32..894d9809f76d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -14,6 +14,57 @@ / {
>  	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
>  		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>  		     "fsl,imx8mp";
> +
> +	reg_vcc_3v3_audio: 3v3_audio_regulator {

No underscores in node names.

> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3_AUD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_vcc_1v8_audio: 1v8_audio_regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V8_AUD";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	sgtl5000-sound {

Just: sound



Best regards,
Krzysztof

