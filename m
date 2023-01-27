Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CE67E10D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjA0KG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjA0KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:06:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39182D50
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:06:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so3059542wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZGBWYBP+jLn9qax6QemUknci7LrD7dJVK21sk9z6Zg=;
        b=LAL0s+LA7HHaPIDhE3KYySG/4T3Z24RXZLU2sYBns9Tl6UFrj4rHlJ6IZPV+EmoqhF
         SiX3gtvDDRKTlhmTjiUHRuZZ2jlOsNimugdf5gsSK6wU44ZnlVvrvfzyKpN9ywNqe2sM
         ChzVu0JZf0OMG6yhXOwkaK//DCW0WVKsp9ziPbWzYBpF4L8CJlNpnNX36G6Na8plUiqj
         HOI/IqknRDBWHa4jjRQxThR9wzHyKww32bwK+Av7RQwtqxqVqlD9knOc+ZlxPrLNJ2RH
         iA4jx8SQ/d3ZEBXDrZWZPDZH668klHHrykwf45xgjtd2a+E2hS9v5MK8+mMv5BDMDJxJ
         iOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZGBWYBP+jLn9qax6QemUknci7LrD7dJVK21sk9z6Zg=;
        b=cdcgp3QjhgK8F/AnKnzJOfrwbExPVZJZwWLIsqHebOaVrGosCje92kO9egjD8aiElT
         qb5FllM6IUkK07MZcTB0hwbOBLHWPWNnlUYEMNBZtqCysvEnm9baBqHHArRnDjnoejJu
         /2uN1XO5wXMB94FsWSX4Z9JJJBLudxBLTpyThYKUHXwsB23cNvPqlu04ucbUiXP/uz18
         M0IrgRFOJVLniqPsPyHd38f4RzXElt58IgSKghTo1NAm5XXAtlEEDPHYdnpMJIXPc/y4
         DQ9HtlQyaJZlQLu0V5Ec+FY+coww3tz5pyVzWMOTFKX/b3RLT/7zIpXsSjmzB+Y/whzI
         Ew2w==
X-Gm-Message-State: AFqh2kqjSgkp56l+pwRxP9aOiKJP4ycr4ovQQWEdkhHnh2TVEmk2r3O9
        /ln1JA88SIUiNH66CfOAGR4Atw==
X-Google-Smtp-Source: AMrXdXsE5NJCOFMShnnXwCTKJoJkEV4/fgpryTXXiLacJHvzUxSC7KVGt8Dsm33+mH4kLSD3wlKQbg==
X-Received: by 2002:a05:600c:2284:b0:3d3:5c21:dd9d with SMTP id 4-20020a05600c228400b003d35c21dd9dmr39012065wmf.19.1674814010311;
        Fri, 27 Jan 2023 02:06:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h23-20020a05600c499700b003dab40f9eafsm3739043wmp.35.2023.01.27.02.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:06:49 -0800 (PST)
Message-ID: <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
Date:   Fri, 27 Jan 2023 11:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/4] arm64: dts: meson: add support for BananaPi M2-Pro
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
 <20230127100236.3385154-5-christianshewitt@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127100236.3385154-5-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 11:02, Christian Hewitt wrote:
> BPI-M2-PRO is based upon the BPI-M5 design except for a different
> physical board layout and the following changes:
> 
> - USB 3.0 ports reduced from 4x to 2x
> - 3.5mm Combined CVBS/Audio Jack removed
> - RTL8821BU WiFi/BT module (internal USB connected)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts | 98 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 97b42e2100e0..644451794aca 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
> new file mode 100644
> index 000000000000..4890d5d9a4f7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 BayLibre SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1-bananapi.dtsi"
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible = "bananapi,bpi-m2-pro", "amlogic,sm1";
> +	model = "Banana Pi BPI-M2-PRO";
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "BPI-M2-PRO";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";

It's by default. Did any DTSI disable the sound node?



Best regards,
Krzysztof

