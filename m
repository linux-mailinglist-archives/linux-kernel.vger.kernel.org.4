Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296F4746B90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGDIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGDIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:09:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6D61AA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:09:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so43661955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688458183; x=1691050183;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvBmFcK9SXnfqzwuT+DfReBotxw6B6mSOnCOgONNgv0=;
        b=Pq175pcSnAl7IBWg926B60sUexUNsN91Xa/FXmI2ntAs3lAcXGzMzqf4IEP6z2ykp9
         Adjl5UHjXAQG8b4Im0Dof7v6hUdWRtbvmWC3hTxCMF5N2VNgfVITNVQn8/Jf8xUKWf+E
         7BG6w3II1oRPPgcIYSMC8un0AEKX2h+RaDCShclbX+PeUfqmBWMA01dcSttEvegLWGn0
         fq2+rYWCegcCvj/dHvaA66hFXc2tQl9YHzQvNN3D8QPQeIBL5ALKdRVi1m+co9bZcItC
         LtNLXBnjMXpBtBpqBJGhiDoSRiG0h6cBbZZceGDgK8M0NeBtkhbwaCfmgLOvfPmbSYQu
         50+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688458183; x=1691050183;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fvBmFcK9SXnfqzwuT+DfReBotxw6B6mSOnCOgONNgv0=;
        b=fXNna6AslS4WOu7c8A02nFmLgZVVNTmZwitQpcAiU9UIriNu0rOjzyl9YDqHSrziFp
         kKyGyyeS1d/zsk//t4kH+E93k47RHA3ViWDw9o9zuxnjvY9l8/Ilzr0PWoVH19TWrBMv
         XoLAuhDnKUMswy7E3Afm1xGUeMNjUrrSNYw+PDkT1yj6R0vikGxzkFmFldpvLdYdKidM
         kLEa+6IeJ5d7jvdmYb+RYfmS7RHqff/v2vBH0YcaQHhxRSGLXwJ8nla7SE6FEdRqgSvI
         vb4u9WFOU2oBGBOUc8dvHR0lLd1XwZH2rDf2LgA+5mdyGldhuA/WKQTcfby+m42Jr2Lk
         EYGg==
X-Gm-Message-State: AC+VfDyQ0f5/ZSAVhz+l1wPjMIHn4y+QGy5TWha2nBBoh66bDDjwjeFJ
        eGMDidNSMmNTlIJ2SHYaogqUug==
X-Google-Smtp-Source: ACHHUZ7Djrvqul6xZf1D/plK1Qgd3CmUESVoJdtGZKmCNznyqFyd+//02tHVc7+lyTW8WZM1HIkk4g==
X-Received: by 2002:a1c:7914:0:b0:3fa:984d:7e94 with SMTP id l20-20020a1c7914000000b003fa984d7e94mr16886762wme.18.1688458183057;
        Tue, 04 Jul 2023 01:09:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:106:cd85:84ae:7b? ([2a01:e0a:982:cbb0:106:cd85:84ae:7b])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b003fbb25da65bsm17017498wme.30.2023.07.04.01.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:09:42 -0700 (PDT)
Message-ID: <112727a2-29c5-1402-deb7-f35119b4338e@linaro.org>
Date:   Tue, 4 Jul 2023 10:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230704031636.3215838-1-xianwei.zhao@amlogic.com>
 <20230704031636.3215838-3-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
Subject: Re: [PATCH 2/2] arm64: dts: add board AN400
In-Reply-To: <20230704031636.3215838-3-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

On 04/07/2023 05:16, Xianwei Zhao wrote:
> Add devicetree support for Amlogic AN400  board based T7 SoC.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>   .../dts/amlogic/amlogic-t7-a311d2-an400.dts   | 39 +++++++++++++++++++
>   2 files changed, 40 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 91fa425116ea..8b6f57a94863 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
> new file mode 100644
> index 000000000000..d755e1ee108a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-t7.dtsi"
> +
> +/ {
> +	model = "Amlogic A311D2 AN400 Development Board";
> +	compatible = "amlogic,an400", "amlogic,a311d2", "amlogic,t7";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart_a;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		linux,usable-memory = <0x00000000 0x00000000 0x00000000 0xE0000000
> +					0x00000001 0x00000000 0x00000000 0x20000000>;

Please use "reg =" instead of linux,usable-memory, which is not a documented property

Please use `make CHECK_DTBS=yes amlogic/amlogic-t7-a311d2-an400.dtb` before posting DT patches,
and make sure there's no errors except already in-review bindings like here the UART compatible.

The result here is:
arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /: memory@0: 'anyOf' conditional failed, one must be fixed:
         'reg' is a required property
         'ranges' is a required property
         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/root-node.yaml
arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /: memory@0: 'linux,usable-memory' does not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/memory.yaml
arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /: memory@0: 'reg' is a required property
         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/memory.yaml

Please fix this one.

arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: serial@78000: compatible: 'oneOf' conditional failed, one must be fixed:
         ['amlogic,t7-uart', 'amlogic,meson-s4-uart'] is too short
         ['amlogic,t7-uart', 'amlogic,meson-s4-uart'] is too long
         'amlogic,t7-uart' is not one of ['amlogic,meson6-uart', 'amlogic,meson8-uart', 'amlogic,meson8b-uart', 'amlogic,meson-gx-uart', 'amlogic,meson-s4-uart']
         'amlogic,meson-g12a-uart' was expected
         'amlogic,meson-ao-uart' was expected
         'amlogic,meson-gx-uart' was expected
         From schema: Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: serial@78000: Unevaluated properties are not allowed ('compatible' was unexpected)
         From schema: Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /soc/bus@fe000000/serial@78000: failed to match any schema with compatible: ['amlogic,t7-uart', 'amlogic,meson-s4-uart']

This one is OK, the UART bindings is reviewed and should be picked up for v6.6

Neil

> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&uart_a {
> +	clocks = <&xtal>, <&xtal>, <&xtal>;
> +	clock-names = "xtal", "pclk", "baud";
> +	status = "okay";
> +};

