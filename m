Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01627634216
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKVRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKVRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:02:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080DA3B9;
        Tue, 22 Nov 2022 09:02:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id cl5so25688869wrb.9;
        Tue, 22 Nov 2022 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUcHxKNUlASZz/X8KuXB0tRt7hDcsZtxJiE2XAUFgK0=;
        b=QfIK0hXCjKJVeI0i0Z8r3P7A0TRBhzEwfNMv7GdcuQ8byRz9v9xDE1/xQXpXzScshj
         gcRiFXtjXNZv8/4+2XGXaKQt8HqXk2FNxHeKAyh92mO8RGEB+hLOLB9m7vlps76+bIZs
         +8VQgUPMrH3lPvJKzA8vevmS9h3ST7QFsdmJBR+FidD4wLQSSf8trA1H01D2AxOYnm2W
         FmWn0UuBVuq5+M7gsiPS8D4iilJqrUkJeDotVIm2JtWeJw3UwpGxtlKBn4VOLRd2TSg9
         LHOv924/g2YRJXGzw6O09VPW72nD14vEKGIey3znmEbYYiQC5/AG/ggvVYgqVastnsMC
         OmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUcHxKNUlASZz/X8KuXB0tRt7hDcsZtxJiE2XAUFgK0=;
        b=7zKwhE5b8Bmr5c9wXyIqsKiREaTIELcbxKqtlwq4Tb6/ezppmfhUddHXZQAj3Kui7C
         p+qM2wI7mCXsxQbxzvPjzbz7fPEI2f8YZlcz5P/+5oQJVJ6NUabnXhc16/jO8Q64SvDB
         7ERrFJ05DFEbuUTAWWo7RJ3A8/vjOsArWpzE9OLdROCP5ehcokb2SL+Qatx2iIAAZ1J/
         XueSp+9yMOsO/9yIKd61hiC6CnyANwO+c/0OCVyP5YQdwIH+FQQwAVBSRJzvAQ9l306b
         ruwWqyn+AVk62WMZlhriOT7ouAyE4WPHfBieah4ZzT3Ie9gyiivD3IC7JstFiH9BMmav
         KplQ==
X-Gm-Message-State: ANoB5pnYJ+o2t0IB+Pymhbl2a51xF11U6wi9pViPrF4T1pABxqIeGqf1
        8+YDnDRYEs8SRRea2U7UYGE=
X-Google-Smtp-Source: AA0mqf49HIMZSzdOoEtBJ9tRmIBfPJn16ehrqs2keL04CLnigLwdWrXYnLZc4qam3NRENhayvSEnGA==
X-Received: by 2002:adf:dd10:0:b0:22e:4f2e:e57 with SMTP id a16-20020adfdd10000000b0022e4f2e0e57mr15005618wrm.698.1669136546331;
        Tue, 22 Nov 2022 09:02:26 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b003cfa81e2eb4sm19846292wms.38.2022.11.22.09.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:02:25 -0800 (PST)
Message-ID: <6945a20d-098b-fad3-766e-f4bcb3c37da8@gmail.com>
Date:   Tue, 22 Nov 2022 18:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/7] dt-bindings: pinctrl: mediatek,mt65xx: Deprecate
 pins-are-numbered
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221122010753.3126828-1-bero@baylibre.com>
 <20221122010753.3126828-4-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221122010753.3126828-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2022 02:07, Bernhard Rosenkränzer wrote:
> Make pins-are-numbered optional and deprecate it
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
> index 33b5f79e741ab..1b44335b1e947 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
> @@ -31,7 +31,8 @@ properties:
>     pins-are-numbered:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description: |
> -      Specify the subnodes are using numbered pinmux to specify pins.
> +      Specify the subnodes are using numbered pinmux to specify pins. (UNUSED)
> +    deprecated: true
>   
>     gpio-controller: true
>   
> @@ -62,7 +63,6 @@ properties:
>   
>   required:
>     - compatible
> -  - pins-are-numbered
>     - gpio-controller
>     - "#gpio-cells"
>   
> @@ -150,7 +150,6 @@ examples:
>             compatible = "mediatek,mt8135-pinctrl";
>             reg = <0 0x1000B000 0 0x1000>;
>             mediatek,pctl-regmap = <&syscfg_pctl_a>, <&syscfg_pctl_b>;
> -          pins-are-numbered;
>             gpio-controller;
>             #gpio-cells = <2>;
>             interrupt-controller;
