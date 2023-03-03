Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DE6A9273
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCCIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCCIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:30:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8619F1B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:30:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o15so7059786edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677832202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyMEf9DcHz7Rey1/n9uL5ThzUAVI9l0JbNqQFMHxvRc=;
        b=ndiZ3xAyUQhK0y/jMn9s9SmP4K2ugri8iWU6ePoBkWIz/Nr6QLQE4nLVBp6MC976Oc
         WNtRVeQ6J1awkj1ScoitJkhM8K14Z1/PUTRj5zSZ4j15k7rm/eJ6ZiSCCl/bbUknEmSD
         9B2DosfSEvYB/KYSW9jOFrKKzEg3axpqHCrV18DX2WhLun9fg+JdmF/avPwtsKke23F4
         zHktnQSWQkJh8aP8BiSY5xZ3O8OpKuGDa7x3AIBlMGO2IYNEvTcBGQhc4fzG1c3LTIAe
         /d05wpmQOGVYjZZPA45HFBMymdaKNF+jNGD/dxnsAArwC7oVFAD3ejelrTBcOACqg+hN
         99TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyMEf9DcHz7Rey1/n9uL5ThzUAVI9l0JbNqQFMHxvRc=;
        b=tgVeVAR4yM6CXUHufGxudcggJjEWRQgVUzDmEvGTuRYzfrgGthvh+/ssJyYXoEspiQ
         V7CSESxT8UounByOfh3Rd4OaUhKTkyXfpOj06ccCachxQZx7GW7W6FZqK60sfw0D+Mpe
         qrnokxZZ37uTUwzJI8oADlHaBAsLEAHZEOw0NKRLc4jMNvfZ4R2yWj6l2pUojspMj+aP
         2afEEu98in9T8T9FCwR4X0b+12QVvyi807WajYgbM1ohoxd08jWleD37DDdxILIujZZu
         1x9vsT7D5MH01DAhDm4qsQ6lZgHbv2cpli1DqvHAsHzsvjRpMTPVyFYWkp+tXVHcUcEv
         zGHw==
X-Gm-Message-State: AO0yUKXyG5XLy/bU2Ucivj6BSTbKmdg5NQIuiHMSJuyW1XmLene0lUve
        sjjLttiikfnl1UWbYtQTK42VLg==
X-Google-Smtp-Source: AK7set/VLaLjdiP1fyM/FB0SX/nUogRG2TFTaQAtY/Ry8s11/NL7JEOUGMnEWKl8Vq3fHE6fT+KUvQ==
X-Received: by 2002:a17:907:9b03:b0:8aa:be5c:b7c5 with SMTP id kn3-20020a1709079b0300b008aabe5cb7c5mr798990ejc.41.1677832202361;
        Fri, 03 Mar 2023 00:30:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709064dd400b008ec43ae626csm684564ejw.167.2023.03.03.00.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:30:02 -0800 (PST)
Message-ID: <d5c93a9f-4a66-f884-a4d1-68cf47bcd7d4@linaro.org>
Date:   Fri, 3 Mar 2023 09:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 5/5] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
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
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-6-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301183759.16163-6-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 19:37, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 Peripherals clock driver,
> and A1 Peripherals clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++++
>  include/dt-bindings/clock/a1-clkc.h           | 102 ++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> new file mode 100644
> index 000000000000..3dc86e912dea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson A/C serials Peripheral Clock Control Unit
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-clkc
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: input fixed pll div2
> +      - description: input fixed pll div3
> +      - description: input fixed pll div5
> +      - description: input fixed pll div7
> +      - description: input hifi pll
> +      - description: input oscillator (usually at 24MHz)
> +
> +  clock-names:
> +    items:
> +      - const: fclk_div2
> +      - const: fclk_div3
> +      - const: fclk_div5
> +      - const: fclk_div7
> +      - const: hifi_pll
> +      - const: xtal
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/a1-pll-clkc.h>

Eh, this explains bisectability problem.

Please do not sent patchets which are not bisectable. You can hard-code
the IDs in the example, they don't really matter.

> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@800 {
> +            compatible = "amlogic,a1-clkc";
> +            reg = <0 0x800 0 0x104>;
> +            #clock-cells = <1>;
> +            clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +                     <&clkc_pll CLKID_FCLK_DIV3>,
> +                     <&clkc_pll CLKID_FCLK_DIV5>,
> +                     <&clkc_pll CLKID_FCLK_DIV7>,
> +                     <&clkc_pll CLKID_HIFI_PLL>,
> +                     <&xtal>;
> +            clock-names = "fclk_div2", "fclk_div3",
> +                          "fclk_div5", "fclk_div7",
> +                          "hifi_pll", "xtal";
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/a1-clkc.h b/include/dt-bindings/clock/a1-clkc.h

Same comment for filename as for previous patch.



Best regards,
Krzysztof

