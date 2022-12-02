Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759236404FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiLBKoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiLBKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:43:51 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E28CFE7E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:43:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r8so4951088ljn.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Gh8vJHIwEcZh0BB+hdOKO4iOl8pjW8TLkF7IbShPHk=;
        b=y0m4WKANY+8cYSi44wZYupyb4+rS2O6rePrY3CL/B/YnmcZYckRyjjM9nsz3VZ9uHP
         IAcNvBIlpnDMdH68c+vKhuF3X+leoXp+rrFJnl/kEfg9TSXYElLpt1PaQtzHW+Fr2n2S
         wvYMAOaqbhQN9CWLtUPNR/AZrbWUBqzUTUhOux7+OKjDARu63VhndgAeRoqZl/0vdXQW
         XYGkyHgNWEn4WjQDA7+GE/6GRN/yCzy+rJl/tKzqaFyAxuQpyWuiwVLS8g+pmv8LCAh+
         gFlocbEaX3vAdLzfKOHP3NeqEt3QtlVqciEEKD/jc2Pjy5NkgZ3Ck5RR/rfdKPqKTsv1
         hVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gh8vJHIwEcZh0BB+hdOKO4iOl8pjW8TLkF7IbShPHk=;
        b=YnH9f/ttdqMW/0XTGtkicWgwvcOfJHy4P0fyl2ZNgiJJgiXKTBqR6bfWhpgVCPDKD9
         KqqqI3nFCjzMzEp2M0dUgel54QWzZDdZ2XIcsiNwxn0oi+JkQNselTgvyETrQHpyJJrL
         4jP2P4iW35nOOdof2yNdp9+e0/t0K2fpvNMLtDZbD/YY8Vm072lKsxmgulzbjLtAtJY6
         Ft8ZDRxCErWaHJ5HbUly9Pceo2J4ToZIVwinrWR9MOAD0eWmFZgVRCjxm3ylbydWIYts
         S3fitC9frNkAPPN6U15l2pFvTxo2ENg37DW2bE6pwB/Zm2zie2YfKePAVcRonsikX4lu
         VLSw==
X-Gm-Message-State: ANoB5pmDcyzVeqb5Cif4Uf1V/o00iFydkDoaiqGRov/Vf8waZpLvAuPt
        aUr60DQa+D4dOxwYKWPZyCSd5w==
X-Google-Smtp-Source: AA0mqf51Xx3+naumP4tnr+tAYf/9/xsFBGF8FoUavqS+Qrvcm63i1zMQscLL+RPsitJw/PJXEf1jew==
X-Received: by 2002:a2e:a885:0:b0:26e:768c:11ed with SMTP id m5-20020a2ea885000000b0026e768c11edmr20487809ljq.436.1669977828099;
        Fri, 02 Dec 2022 02:43:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u22-20020ac258d6000000b0049e9122bd1bsm971023lfo.164.2022.12.02.02.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:43:46 -0800 (PST)
Message-ID: <18d5ed96-1411-1bf7-6791-6202488b4f6a@linaro.org>
Date:   Fri, 2 Dec 2022 11:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 11/11] arm64: dts: meson: a1: introduce PLL and
 Peripherals clk controllers
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-12-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201225703.6507-12-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 23:57, Dmitry Rokosov wrote:
> This patch adds clkc_periphs and clkc_pll dts nodes to A1 SoC main dtsi.
> The first one clk controller is responsible for all SoC peripherals
> clocks excluding audio clocks. The second one clk controller is used by
> A1 SoC PLLs. Actually, there are two different APB heads, so we have two
> different drivers.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 27 ++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index b4000cf65a9a..38e6517c603c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -6,6 +6,8 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/gpio/meson-a1-gpio.h>
> +#include <dt-bindings/clock/a1-pll-clkc.h>
> +#include <dt-bindings/clock/a1-clkc.h>
>  
>  / {
>  	compatible = "amlogic,a1";
> @@ -81,7 +83,6 @@ apb: bus@fe000000 {
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
>  
> -
>  			reset: reset-controller@0 {
>  				compatible = "amlogic,meson-a1-reset";
>  				reg = <0x0 0x0 0x0 0x8c>;
> @@ -124,6 +125,30 @@ uart_AO_B: serial@2000 {
>  				clock-names = "xtal", "pclk", "baud";
>  				status = "disabled";
>  			};
> +
> +			clkc_periphs: periphs-clock-controller@800 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "amlogic,a1-periphs-clkc";
> +				reg = <0 0x800 0 0x104>;
> +				#clock-cells = <1>;
> +				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +					 <&clkc_pll CLKID_FCLK_DIV3>,
> +					 <&clkc_pll CLKID_FCLK_DIV5>,
> +					 <&clkc_pll CLKID_FCLK_DIV7>,
> +					 <&clkc_pll CLKID_HIFI_PLL>,
> +					 <&xtal>;
> +				clock-names = "fclk_div2", "fclk_div3",
> +					      "fclk_div5", "fclk_div7",
> +					      "hifi_pll", "xtal";
> +			};
> +
> +			clkc_pll: pll-clock-controller@7c80 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "amlogic,a1-pll-clkc";


Best regards,
Krzysztof

