Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48366C2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjAPOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjAPOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:51:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7017CF6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:36:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so40936832edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCZPqWPiwmy+Qg3w9Zw0kU442c7Jihjgka7OZcZFvZ4=;
        b=vK/m3ZhBu0rXmwlaHWgHg/SJV3wZwAcbhd6qMxLW6BfEHoQz0LWh1fbCr8C+lK5HmS
         bhRZ1X9ylmKvKawQ3N6yph8My2pmJvfm0eafkOElbuheYZVdMhjGMwR8YExcCfbR/kL8
         7eeGDkBW4uSNo0sICPIofDBbdeMdir6P4y2J0LpZl3rAU4eXG4k6SY8gQa6LsLjo1Hyd
         UJgJqfqxKJJnyqeIXL8PxL4bMoBZkHOqmADuqiClaUMVQQH1XIk5czTyl31+GkSEqVyO
         b/3x0jhIpJSBAntgZfJ52P3wbP7zLAnGw9xJE+2x3+hDg8AAW3SluiWijSVism0Kxc2q
         uc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCZPqWPiwmy+Qg3w9Zw0kU442c7Jihjgka7OZcZFvZ4=;
        b=KKTqKk7/S13FwD8G5Sc7J/6oQjNRWUIm4Q26X2EOh0nxG0bmq8alfMoBwubDJ0HERq
         +Z4Aya+pQrsFWWQOE4do2s4gdB0eeVpm6U4QLPlfknesWQbyJ4A6TvYKxGaSEnoI3NkG
         guazBnR0OFBhshpSlfCosB4ZMj2RNIXBaLy58qiN6fhBU0CQcSZfO5kKg1zIWs2I6qYi
         WpIwALtBtU4y7tr0x8KslqOZyqUOTE5FG0U9I/8CFoVApwAmDl/XTA0/klxHBUYF+Rdi
         GGksVnMAVyzDsPah1x1tXFycncZHNBkgSb+HNMgvvswqBlq+NxT544pWW2q4q7kc0jrh
         pdFQ==
X-Gm-Message-State: AFqh2kpphE1kQMZ6WZ44+tx5AEttamhwmoEuWc65azeHLy3RqUm6cwuG
        a7PzQyOqgFoqmuSp2M7veTZDzg==
X-Google-Smtp-Source: AMrXdXtV7SF+3RSBX9E7TN51Zz8RFwX6gb7hQ8yrCuB589NuTrrLEfdLDjrguaEyTdVgTYDRIpbTRw==
X-Received: by 2002:a05:6402:2a02:b0:470:44eb:9e58 with SMTP id ey2-20020a0564022a0200b0047044eb9e58mr82109589edb.30.1673879762167;
        Mon, 16 Jan 2023 06:36:02 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d3-20020aa7d5c3000000b004835bd8dfe5sm11665624eds.35.2023.01.16.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 06:36:01 -0800 (PST)
Date:   Mon, 16 Jan 2023 16:35:59 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, angelo@amarulasolutions.com,
        michael@amarulasolutions.com, tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com, Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/11] arm64: dts: imx8mn: add clocks description
Message-ID: <Y8VgzyNxGpqSvJ2b@linaro.org>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
 <20230101175740.1010258-12-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101175740.1010258-12-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-01 18:57:40, Dario Binacchi wrote:
> The patch creates a unique node for each clock in the imx8mn clock
> control module (CCM).
> 
> To ensure backwards compatibility it was not possible to separate the
> changes to the device tree from those applied to the clocks setup code.
> In doing so, all clocks are initialized from the device tree and the
> legacy setup code with hardwired parameters is removed.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v1)
> 
>  .../boot/dts/freescale/imx8mn-clocks.dtsi     | 1885 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   54 +-
>  drivers/clk/imx/clk-imx8mn.c                  |  714 ++-----
>  3 files changed, 2086 insertions(+), 567 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
> new file mode 100644
> index 000000000000..21e02ea996d0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
> @@ -0,0 +1,1885 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Device Tree Source for imx8mn clock data
> + *
> + * Copyright (c) 2022 Amarula Solutions
> + *
> + * Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +/ {
> +	osc_32k: clock-osc-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "osc_32k";
> +	};
> +

[...]

> +
> +	clk_audio_pll2_bypass: clock-audio-pll2-bypass@14 {
> +		compatible = "fsl,imx8mn-mux-clock";
> +		#clock-cells = <0>;
> +		clocks = <&clk_audio_pll2>, <&clk_audio_pll2_ref_sel>;
> +		fsl,anatop = <&anatop 0x14>;
> +		fsl,bit-shift = <16>;
> +		fsl,set-rate-parent;

NACK. I'm sorry, but this creates a huge effort on maintaining the
bindings. Plus the vendor specific properties will keep increasing.

I don't think Rob and Krzysztof will be OK with this either.


> +		clock-output-names = "audio_pll2_bypass";
> +	};
> +
> +	clk_audio_pll2_out: clock-audio-pll2-out@14 {
> +		compatible = "fsl,imx8mn-gate-clock";
> +		#clock-cells = <0>;
> +		clocks = <&clk_audio_pll2_bypass>;
> +		fsl,anatop = <&anatop 0x14>;
> +		fsl,bit-shift = <13>;
> +		clock-output-names = "audio_pll2_out";
> +	};
> +

[...]

> -- 
> 2.32.0
> 
