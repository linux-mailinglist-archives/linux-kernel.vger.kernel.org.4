Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE10C6F19B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbjD1NfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346193AbjD1NfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:35:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB702D65
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:34:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f315735514so61215635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682688897; x=1685280897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mmAAEtOPUAr1bd+bTw4cvKl1TPg5Xn9TRA7Ti52FfU=;
        b=OQcSidFEQtSbCNHlInufClZsAvwSkpY1FQYDH+WYqwGzfBtvyGtTMtDvdTFaW1XrR5
         Tx3tl5PtUfZUrWklSSN5UvxJ15d4MgE9KWeH026UynnZY3dMmAs8aoUAmBylQZFyQjKp
         LzXIWdiEmYcA3S4bpwtLsi2/9sZdPHuObDVZ5lcFB20/+JT1pShjl7YPOpC2kQmYNv9A
         A4BF/52Y4THhbEt3wx9gRDGV5ZEVSPyIaDjM3gNbDZ5Pn3dHJIyaKr6E1SItmij0MaM5
         j621PTbJ3MRnluBQHBauXPevQBuMAFXHcuqnnABSRCMFK34BGLlciTZOS/R+YUTfO8B5
         /sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688897; x=1685280897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mmAAEtOPUAr1bd+bTw4cvKl1TPg5Xn9TRA7Ti52FfU=;
        b=CMQz4VBz8kDg8qbV/g9Ie/shpT8HiLknzk9UkIWLub7+Fou2ztvvwkcj1jMozS0iyP
         3SgjrGv6XpOxPdZo94mz/tf5qZXqL/T27Vrl2BwTP0OIPUtfS0GVIX5T/YpzjtCqqigh
         vdElRd7VDrljUxC+kTghg/rXwE8NHQ2MyPUt1D7WiLpJCFbOJiN21KlpIgfyTjmrYK3O
         6DkM8bKY44ApnCGmGzfoc1qC0Bu55qwebZWP7QBM0Rblr99WSUvHu6qMRQgknLZegSsO
         RedKszHJTE2myVbw/RHpww9tp4QTP6nRUvKcNwUKzS7TZ3JnObYxzuq88YN12fMyLp1T
         +qxw==
X-Gm-Message-State: AC+VfDzrWz2m/+IWqfds6/R1QhnQdxKlfPhD0lmfC8N5pWr7PjDazvna
        BYntReaJ/ACULm7X8jGs1pxj/Q==
X-Google-Smtp-Source: ACHHUZ50NyQZaa4YfPHncp8v3Q2ICEDpU1JVTtxWjO4UOvR08Zk0+e/uit7Me/trCaa7Pmi1ZQ+dyw==
X-Received: by 2002:a05:600c:2101:b0:3f1:7848:6740 with SMTP id u1-20020a05600c210100b003f178486740mr4078764wml.8.1682688897162;
        Fri, 28 Apr 2023 06:34:57 -0700 (PDT)
Received: from [172.23.2.142] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003f07ef4e3e0sm36176284wmq.0.2023.04.28.06.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:34:56 -0700 (PDT)
Message-ID: <32911b1c-7f32-7078-27e8-7b168d295993@linaro.org>
Date:   Fri, 28 Apr 2023 15:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add Lunzn Fastrhino R66S
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230428013738.30735-1-cnsztl@gmail.com>
 <20230428013738.30735-2-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230428013738.30735-2-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 03:37, Tianling Shen wrote:
> Lunzn Fastrhino R66S is a high-performance mini router.
> 
> Specification:
> - Rockchip RK3568
> - 1/2GB LPDDR4 RAM
> - SD card slot
> - M.2 Connector
> - 2x USB 3.0 Port
> - 2x 2500 Base-T (PCIe, r8125b)
> - 12v DC Jack
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  27 +
>  .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 507 ++++++++++++++++++
>  3 files changed, 535 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 2d585bbb8f3a..15089a78555a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -85,6 +85,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> new file mode 100644
> index 000000000000..fc9e1bdab128
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +
> +#include "rk3568-fastrhino-r66s.dtsi"
> +
> +/ {
> +	model = "Lunzn FastRhino R66S";
> +	compatible = "lunzn,fastrhino-r66s", "rockchip,rk3568";
> +
> +	aliases {
> +		mmc0 = &sdmmc0;
> +	};
> +};
> +
> +&sdmmc0 {
> +	max-frequency = <150000000>;
> +	no-sdio;
> +	no-mmc;
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> new file mode 100644
> index 000000000000..a58592b2f13b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> @@ -0,0 +1,507 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	aliases {
> +		led-boot = &status_led;
> +		led-failsafe = &status_led;
> +		led-running = &status_led;
> +		led-upgrade = &status_led;

Why do you need these? Which upstream kernel driver parses these?


Best regards,
Krzysztof

