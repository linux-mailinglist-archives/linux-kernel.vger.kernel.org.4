Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108A73E3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFZPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFZPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:41:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B48719BA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:41:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3113da5260dso2960679f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687794069; x=1690386069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcAjUvoJv+soy8lFEBlsPkblkqyu/m9eFd2zpfxjosE=;
        b=tO6OqZdd37AW1NbN6NQLmeeSOF8mOhRK+Jf7ixWOaf8Jw4+hoKjbAgRJy0Fa7HZYKX
         JpY7E0CWUx/CEfmiH8xyXRVC0fPTTLJFnsSP/Fl6Ce52BXSxkvjnTmN6LWj09hv7Bi6f
         iuK0Rs5rHgQQqDvW1TJkZHgZYw58TTjKK781rmUcJHNZiwHXNt+vBEwOftzVo/CAy8vR
         rzJQCcnY3/nsFduTrM0snqMVzxXblztYLr/Pjf2XIfJNhfqUuc+eG3v75PgJ8XlvuX4q
         pR3kXLEfmHWELyrJI7RUI3t9wF6AfT5ezgRnT6+KUmwFuWGxrgqw+N6PwhRePvoITZ1x
         TGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794069; x=1690386069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcAjUvoJv+soy8lFEBlsPkblkqyu/m9eFd2zpfxjosE=;
        b=kNfAiTfkKRf/V666+BPhHjmS2MZ9nzVObv9nzklODw5/yT0/CCxW1cvwnyU+HrZ8Xx
         fbbQMB1b8IFbKPF5d6jAaDn9LgEzDRfxCVSk+V0xeQCHIa7LqAo0xeyWllWSOMdMDyc3
         LScLo2z4pn5lbD0iIyEMQTNGyy/KJJCrnoIh+zpI+pkPYvR1M/NenJyhCV0BhjtbmNDx
         D6y9V40s09FYnvvTpHg/7O6c1GI7JDDh/78ZDw2P190DOq3TJwUfr4C6HHebB0XbP1Vq
         WA/0VBoh4gMbsAOgDsFAxGVzDa/3Z/ZaNPR5MDqR7U7tdTYEu4IsAg8BtXLjA93HKkOY
         KO+w==
X-Gm-Message-State: AC+VfDwi4PPwBpG5NMVv+YgN6KVLYZBXFIos3p/H7Ajbxzs3Tqw3IL5A
        YKW0rM4WGZgpk9wusFZEF1xCOQ==
X-Google-Smtp-Source: ACHHUZ6SD/+R9QJaeeqkTvuy16RIFBOytcsvos4lluOdTQEOmJM+FBidZX5DmN6xzACs6kG6widqtw==
X-Received: by 2002:adf:f4cc:0:b0:313:ef96:84c8 with SMTP id h12-20020adff4cc000000b00313ef9684c8mr3050240wrp.67.1687794069018;
        Mon, 26 Jun 2023 08:41:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a25-20020a5d4579000000b003048477729asm7711578wrc.81.2023.06.26.08.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:41:08 -0700 (PDT)
Message-ID: <9b49e979-4a24-f628-88c4-fd53f53d46e4@linaro.org>
Date:   Mon, 26 Jun 2023 17:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] arm64: dts: add support for T7 based Amlogic AN400
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626095223.721011-3-xianwei.zhao@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626095223.721011-3-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 11:52, Xianwei Zhao wrote:
> Amlogic T7 is an advanced application processor designed for smart display.
> 
> Add basic support for the T7 based Amlogic AN400 board, which describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.

Few nits.

...

> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		cpu0:cpu@0 {

You miss spaces after labels.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1:cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2:cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3:cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu4:cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5:cpu@101{
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6:cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x102>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7:cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x103>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@fff01000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfff01000 0 0x1000>,
> +			    <0x0 0xfff02000 0 0x0100>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +		     };

Fix indentation.

> +
> +		apb4: bus@fe000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xfe000000 0x0 0x480000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +			uart_a: serial@78000 {
> +				compatible = "amlogic,meson-s4-uart",
> +					     "amlogic,meson-ao-uart";
> +				reg = <0x0 0x78000 0x0 0x18>;
> +				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";

Please, don't put status in the middle of properties...



Best regards,
Krzysztof

