Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E896A1B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBXLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBXLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:11:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF143468
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:11:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bt28so6863046wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW1MMOsZ1jdi5XBUIwdHvUOrWypSSf4PAFyyG2azRmY=;
        b=oObB51ZbGeFK/JucA7XIeI2+mqGwFQqnDd+S+tN+8B6X1cPq2UXSe37sNTfnQATNOc
         T960+WBcc6XralJWiUwoiGKC3Qhr9gUuPo1iArkursW04JZVsxdS+uOmp4/Wq+Tn9m8a
         M20wWwWEcSdl/Gd09YsWvjHmx4bn8bEVTEcQmYEdo+d9f9xqLU2mVOIMDaBuz+IpQzej
         xVVM85m4XdaA9EhxoBYv2GUWopDnYBCQjIQ7Fg8eD2MmkHrmxPRAporoc9u5/M7u8gcl
         yh3xN2heWXPpJL80dTj01zG9v9RKWeq+acQD+2IwkmpfRs46G1ZQfhuDJG2ih0MHQNGi
         eCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW1MMOsZ1jdi5XBUIwdHvUOrWypSSf4PAFyyG2azRmY=;
        b=byfVCBJOK+fs8QIN8Ec88KoORssGkKsbgEQ1lqfmX6kRm95BtzhP52sK6rMDBeboRS
         HcjwxIDMan3YgPtFKKMY0TkqdjfilsZZDyDh+342EggBAWC2n1uqAzcB07dTx3bATaGg
         OSmbQjsIYJsEZ0a0fENF9Ffd4mgaEEpWQrJbN1w1k4KT400wltFK8TL6Fo0UdTdL6hlh
         ERdDiTZbu+jO+V4j7NDUweXTEIIke5eKNWoJH/6s1XhI0rEUteNib5qxGuLwJVlpxn3U
         wB5MzitoT8d4lqjjgv7T4BuOYcMe+cAWphdCI8RvI4fQ5bdz+fsO3mHin/HJeU4afHMy
         0h/A==
X-Gm-Message-State: AO0yUKXdOCRBldPbNeSV6S5GeswvebGU0eDLL9u73rOaZPkMK8cpuSF3
        JtSqlfUMc7o1eQO/F5Fa21yP2Q==
X-Google-Smtp-Source: AK7set9w7qpxDBdOWAHOzOR27ysmRZbKntF29OBpFSpvlT6RmuI9Wa/1F9AnYGAqRfWPMt5F3tNxMw==
X-Received: by 2002:a05:6000:8c:b0:2c5:9cb8:d315 with SMTP id m12-20020a056000008c00b002c59cb8d315mr12435970wrx.62.1677237076381;
        Fri, 24 Feb 2023 03:11:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d4b89000000b002c794495f6fsm598003wrt.117.2023.02.24.03.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:11:16 -0800 (PST)
Message-ID: <e20f5d80-e53a-559d-9a21-fcf77c1cf968@linaro.org>
Date:   Fri, 24 Feb 2023 12:11:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 6/8] arm64: dts: ti: k3-j721s2: Add support for OSPI
 Flashes
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, afd@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        vaishnav.a@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230224102438.6541-1-r-gunasekaran@ti.com>
 <20230224102438.6541-7-r-gunasekaran@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230224102438.6541-7-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 11:24, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> J721S2 has an OSPI NOR flash on its SOM connected the OSPI0 instance and a
> QSPI NOR flash on the common processor board connected to the OSPI1
> instance. Add support for the same
> 
> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> Changes from v10:
> * Removed Link tag from commit message
> 
> Changes from v9:
> * Enabled fss and ospi nodes
> 
> Changes from v8:
> * No change
> 
> Changes from v7:
> * No change
> 
> Changes from v6:
> * No change
> 
> Changes from v5:
> * Removed Cc tags from commit message
> 
> Changes from v4:
> * No change
> 
> Changes from v3:
> * No change
> 
> Changes from v2:
> * No change
> 
> Changes from v1:
> * No change
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 39 +++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 43 +++++++++++++++++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index fa38940fe6cd..76b420379645 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -206,6 +206,20 @@
>  			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
>  		>;
>  	};
> +
> +	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
> +			J721S2_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
> +			J721S2_WKUP_IOPAD(0x060, PIN_OUTPUT, 0) /* (C21) MCU_OSPI1_CSn1 */
> +			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
> +			J721S2_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
> +			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
> +			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
> +			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
> +			J721S2_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
> +		>;
> +	};
>  };
>  
>  &main_gpio2 {
> @@ -347,6 +361,31 @@
>  	maximum-speed = "high-speed";
>  };
>  
> +&fss {
> +	status = "okay";

Where is the pinmux usage you said is required for the bus?

> +};
> +
> +&ospi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
> +
> +	flash@0{
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <40000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Are you sure these are correct? Aren't they marked as deprecated?



Best regards,
Krzysztof

