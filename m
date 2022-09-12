Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75175B58BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiILKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:51:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3183054C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:51:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r12so8490058ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JyxZJBDxwa1juNFoQDcnNx8kzZcf1BUcQHxFamfBS9U=;
        b=ol/VATnLs6JCVymJeLMyS2ANExMLVBlpsGNJCzRIcNIEumS6IS4Y8ZFSmBuInRU1YP
         5pwlePB8AIjfMmLI7BDksVLpV7C92efrimaWI2/owvq5NFJHK6DTiIfwoIhiwElyVNpN
         13FnRgm3CbJSI9TEiOkwwz7EnK8b/hF88zTBBWECRy1Jf1I8RUFe3K80YJVvsDBb2xQ1
         WqRs+9yV4++IkJP0CjVXEXa8fFFJc00VV2btLPtEdnC9aAhjSiLSzw/8s9HXycU+i0Wh
         2IuL0zGZkf69gLqn9u6ZtW38fTBofCLyf/9CakO7RjOCzEFut6tC09dJPYwyaW3XKtwm
         hAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JyxZJBDxwa1juNFoQDcnNx8kzZcf1BUcQHxFamfBS9U=;
        b=bp9j7rpZ+UYlhiqN1yYs7qEo4pqa6YrWi4oJXBfQvfyQp0qRMXuvB/TAnMyH3ycxbK
         YsGrVgWotWzfcyesucSVIWFbHm6tdaIU9S4OQBeNdDoAicizLgyrH0tlaTEGP8DsP6Hg
         85IT3Kkv+TOKnS0a3UP5jv0Lc8TL9sL8ChDu1C7i77gG/V8rlXQt2E6/2XjjuvICPf0W
         1XhEEdu2E+c/ZY1NStY0ilftVEdC/qVrbgsDws6/JGcjzlJSTl0+FzHwGzft5xzLrcs7
         KRrKLuhhk7iWDkq7+Cek3NZm+L/sOrh+UB2NcaN0znpK35KU9liXWap9Yb8lun2QX2Ja
         +sqg==
X-Gm-Message-State: ACgBeo06RmINuR4TyyFWy+EXIjyVENPJ2a4x+Wi7QgPHyboGE0jS1zh6
        FmcRk//d8VaJaogiAm0n3fIxqzErsZ2HNA==
X-Google-Smtp-Source: AA6agR79aoCpEogSUJhr9xxLEteFdk51Jg5L0gCGuub7enPMTGd6uvgE8eglysHg+QSpeMwTWtu5sw==
X-Received: by 2002:a2e:a552:0:b0:25e:6fa1:a6c4 with SMTP id e18-20020a2ea552000000b0025e6fa1a6c4mr7292256ljn.90.1662979881408;
        Mon, 12 Sep 2022 03:51:21 -0700 (PDT)
Received: from [10.129.96.84] ([109.232.243.34])
        by smtp.gmail.com with ESMTPSA id d28-20020a0565123d1c00b0048a8586293asm1005267lfv.48.2022.09.12.03.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 03:51:20 -0700 (PDT)
Message-ID: <14d7bbb5-51c4-8fc0-2303-f5164c6da903@linaro.org>
Date:   Mon, 12 Sep 2022 12:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3128-cru.txt to
 YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     zhangqing@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2022 23:20, Johan Jonker wrote:
> Convert rockchip,rk3128-cru.txt to YAML.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> new file mode 100644
> index 000000000..03e5d7f0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0

Can't it be Dual licensed?

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
> +    - "xin24m"     - crystal input       - required
> +    - "ext_i2s"    - external I2S clock  - optional
> +    - "gmac_clkin" - external GMAC clock - optional
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3126-cru
> +      - rockchip,rk3128-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xin24m

More clocks were mentioned in old binding.

> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the "general register files" (GRF),
> +      if missing pll rates are not changeable, due to the missing pll
> +      lock status.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cru: clock-controller@20000000 {
> +      compatible = "rockchip,rk3128-cru";
> +      reg = <0x20000000 0x1000>;
> +      rockchip,grf = <&grf>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };


Best regards,
Krzysztof
