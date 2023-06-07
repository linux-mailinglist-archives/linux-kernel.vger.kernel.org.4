Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AE7268E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjFGSfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjFGSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:35:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BF1BF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:35:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-97460240863so1041296366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686162914; x=1688754914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oRVbakJKhxqzwhoXotbCqDyKWlJ4PhQpqo/n0s7L7k=;
        b=SaHwxSTHyCK6ZLqMnQ2tRMbD/FXv8Q0MPpXiMqqMCSpcpygJNIx7kzZV5OPWY07Vjy
         FNfE+d7sfzmTr7HFJ2d17pqik93wj5/uGHjMSMjx3IqY4yEYAEplaeUL6lxdldBJsmGV
         3lOPMHbN3vb2qbIqkWHxuQku2kAOioy9Oxm6gmP/Jn5i+aquF5WnSS1P/pWvX5E247mM
         UmFHLaAxaF7MoNbucuTv6if4W5N8Omu72Ktp9e9nqxwQfzic+T25VD0lr153Zc1J5rI+
         FF/pLCcrHwXUIP4J4NszE6j9SV6nRjo4dPmh7PmGqz2uW2n4ZieJ8ejyaQl76gD5FgT/
         xA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162914; x=1688754914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oRVbakJKhxqzwhoXotbCqDyKWlJ4PhQpqo/n0s7L7k=;
        b=Pbc5b73GJd16xXEgYWXLT6JD1Dsl9qD3R8LW/kSzB+hHY1RaheCAlc5K+0ujzGFu2Y
         t+ZP3WJMu6yATubUNxI3XVOjjh8nAAiCfv2vBcxlvkS9OEwbTs6pChOo6KVrbAYAg/+r
         5Wvy+oT5upq4gC+NKwU8c2Rx4iScrJH14v72lwYbuo1sS/B/anV7oUwUwU22Qy+Z0JVU
         dMh9LfF0nMivVsIWoCVP5rknSiDDnOIhRpiFLVdgq0dZqVS3+4BwLNMCzhwg4wwVBSgm
         p3N6+dl3iLtBC0OYkWUf1pSDdpnM3KDRPMfrg+F5+EVm2o8Im4EOmWk2S7NCZDhYQ0rH
         GuUg==
X-Gm-Message-State: AC+VfDx+8K1Mq3gaJWd9A5/qS6EelpzrG6vFe6g6xDr27D1l9SNWbPzM
        UbmnnG9Kl4iB34lOPw2gMhMXEg==
X-Google-Smtp-Source: ACHHUZ6kwcM0h6fzmYkLv2AwJVUv2wzM4110yS6KAONK+nyu/412lkMcwBU4G+no1drK2aF7E/JuPw==
X-Received: by 2002:a17:907:9444:b0:973:d48a:bc20 with SMTP id dl4-20020a170907944400b00973d48abc20mr6138655ejc.19.1686162914007;
        Wed, 07 Jun 2023 11:35:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bq4-20020a170906d0c400b0096f7105b3a6sm7155657ejb.189.2023.06.07.11.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:35:13 -0700 (PDT)
Message-ID: <49258bcf-da13-78a9-8ea6-4fc7bd9a4b1d@linaro.org>
Date:   Wed, 7 Jun 2023 20:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/9] arm64: dts: qcom: ipq5332: Add USB related nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <1b48e737aa14f5b5539cbf04d473182121d5b1ad.1686126439.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1b48e737aa14f5b5539cbf04d473182121d5b1ad.1686126439.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 12:56, Varadarajan Narayanan wrote:
> Add USB phy and controller nodes
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 55 +++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index c2d6cc65..3183357 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -383,6 +383,61 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		usb_0_m31phy: hs_m31phy@7b000 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "qcom,ipq5332-m31-usb-hsphy";
> +			reg = <0x0007b000 0x12C>,
> +			      <0x08af8800 0x400>;

Lowercase hex only.

> +			reg-names = "m31usb_phy_base",
> +				    "qscratch_base";
> +			phy_type= "utmi";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +			reset-names = "usb2_phy_reset";
> +
> +			status = "okay";

It's by default. Drop.

> +		};
> +
> +		usb2: usb2@8a00000 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			reg = <0x08af8800 0x100>;

reg is always after compatible. Ranges is third. Then you will spot that
address is wrong.

> +
> +			clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +				<&gcc GCC_SNOC_USB_CLK>,
> +				<&gcc GCC_USB0_SLEEP_CLK>,
> +				<&gcc GCC_USB0_MOCK_UTMI_CLK>;

Fix alignment.

> +
> +			clock-names = "core",
> +				"iface",
> +				"sleep",
> +				"mock_utmi";

Fix alignment.

> +
> +			interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pwr_event";
> +


Best regards,
Krzysztof

