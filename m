Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490EF5B769B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiIMQk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIMQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:40:05 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946266134;
        Tue, 13 Sep 2022 08:34:46 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1278624b7c4so33136234fac.5;
        Tue, 13 Sep 2022 08:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NHkxcPH5FKv85ET3//U58TPQlebHVHmJ2tvNIdZ+Pnk=;
        b=Darz0lUGLMTmn+d7WnnrWf3Tx4tOBEUj0MCzL/yJ2LGOof2uindOvs9w8Zcplvs4dj
         czy4+vHtjGawtxNrvqtHdPtAQ7eH7DlJWmZDz5S56WX3d63E/a0A2nlJy/SkCHykoIa2
         vFnYj8UsxjnVRGz0ls/J+iiZuCwnz1h8GMkV0Ql3mLZm/I5mvwmJhYuwOu9zJmRjGXE1
         P7cIV4LdQMGdE+sGg82oqgmr/k0JQAIJEv4RmwSa2jzBXkH5qL/BUC5tqF067zxq22T5
         GtJN11FUB9CHV299NV9Djb5Zkh5jJZWLuF/FXFYrpIwOlo7nqfHrnNCaBvQvhOn7QWyG
         uhqA==
X-Gm-Message-State: ACgBeo0rtAp3Pt05C/RqxiaI9MY4NcDO2G/Rm24gF/Y3UPSSnKFRjNdu
        FWvGqwn4xEtD5CNEdKCGnA==
X-Google-Smtp-Source: AA6agR7/9mHH3ZQG6E/UF5ELa28GzOs6gjtCqRrgLO2UV3sUe47CiR9I5zbcMrvbHWigfDm8U1Xr1g==
X-Received: by 2002:a05:6870:4586:b0:10d:2ec7:be6 with SMTP id y6-20020a056870458600b0010d2ec70be6mr2203912oao.7.1663083166741;
        Tue, 13 Sep 2022 08:32:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r35-20020a05687017a300b0011e37fb5493sm7354117oae.30.2022.09.13.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:32:46 -0700 (PDT)
Received: (nullmailer pid 3776213 invoked by uid 1000);
        Tue, 13 Sep 2022 15:32:45 -0000
Date:   Tue, 13 Sep 2022 10:32:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, zhangqing@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3128-cru.txt
 to YAML
Message-ID: <20220913153245.GA3769654-robh@kernel.org>
References: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 11:20:10PM +0200, Johan Jonker wrote:
> Convert rockchip,rk3128-cru.txt to YAML.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3128-cru.txt    | 58 ---------------
>  .../bindings/clock/rockchip,rk3128-cru.yaml   | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
> deleted file mode 100644
> index 6f8744fd3..000000000
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* Rockchip RK3126/RK3128 Clock and Reset Unit
> -
> -The RK3126/RK3128 clock controller generates and supplies clock to various
> -controllers within the SoC and also implements a reset controller for SoC
> -peripherals.
> -
> -Required Properties:
> -
> -- compatible: should be "rockchip,rk3126-cru" or "rockchip,rk3128-cru"
> -  "rockchip,rk3126-cru" - controller compatible with RK3126 SoC.
> -  "rockchip,rk3128-cru" - controller compatible with RK3128 SoC.
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- #clock-cells: should be 1.
> -- #reset-cells: should be 1.
> -
> -Optional Properties:
> -
> -- rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing pll rates are not changeable, due to the missing pll lock status.
> -
> -Each clock is assigned an identifier and client nodes can use this identifier
> -to specify the clock which they consume. All available clocks are defined as
> -preprocessor macros in the dt-bindings/clock/rk3128-cru.h headers and can be
> -used in device tree sources. Similar macros exist for the reset sources in
> -these files.
> -
> -External clocks:
> -
> -There are several clocks that are generated outside the SoC. It is expected
> -that they are defined using standard clock bindings with following
> -clock-output-names:
> - - "xin24m" - crystal input - required,
> - - "ext_i2s" - external I2S clock - optional,
> - - "gmac_clkin" - external GMAC clock - optional
> -
> -Example: Clock controller node:
> -
> -	cru: cru@20000000 {
> -		compatible = "rockchip,rk3128-cru";
> -		reg = <0x20000000 0x1000>;
> -		rockchip,grf = <&grf>;
> -
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -Example: UART controller node that consumes the clock generated by the clock
> -  controller:
> -
> -	uart2: serial@20068000 {
> -		compatible = "rockchip,serial";
> -		reg = <0x20068000 0x100>;
> -		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency = <24000000>;
> -		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -		clock-names = "sclk_uart", "pclk_uart";
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> new file mode 100644
> index 000000000..03e5d7f0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3128-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3126/RK3128 Clock and Reset Unit (CRU)
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  The RK3126/RK3128 clock controller generates and supplies clock to various
> +  controllers within the SoC and also implements a reset controller for SoC
> +  peripherals.
> +  Each clock is assigned an identifier and client nodes can use this identifier
> +  to specify the clock which they consume. All available clocks are defined as
> +  preprocessor macros in the dt-bindings/clock/rk3128-cru.h headers and can be
> +  used in device tree sources. Similar macros exist for the reset sources in
> +  these files.

> +  There are several clocks that are generated outside the SoC. It is expected
> +  that they are defined using standard clock bindings with following
> +  clock-output-names:

Which node does clock-output-names live in?

From the description, it sounds more like this should be 
clocks/clock-names.

> +    - "xin24m"     - crystal input       - required
> +    - "ext_i2s"    - external I2S clock  - optional
> +    - "gmac_clkin" - external GMAC clock - optional
