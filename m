Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036516119AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJ1Rxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJ1Rxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:53:32 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E151D8F3A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:53:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z30so3902097qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sSUMxC+XoR1FPr8npnNSTCNLao0xyHEAmVsF1JSBMw=;
        b=L9PXBLBok6GO/WjEyWHwQpjkaqr5A4I+OdiQZ9eXtj4tjjSw+v++H2W2TZpzKrKmnR
         m848j5p8APXRGHG8A/QGKtjCpobD6gHUUUOeABDqTtlo/dGxC2/tjXCAWyXfAGEsyKf6
         ZRl5rhOIkTScMsw2xhk89iWGNeTPIDp+AzBwHruICZnP5dcXiL65OHjhQA4eyqdiTmHD
         KtJ9I4hz7pCTfko4I5PH9ha4Q+yDYJSc2CagTchuHz2/pSyaQZ7OTPvOcUXK0UQA5uyK
         BSJV/q6b045d9HZOqbts5HpSheJflGhipXQaVeD0l/l8x+z5K6/lhMhnUOzYfvOO8TBF
         Xn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sSUMxC+XoR1FPr8npnNSTCNLao0xyHEAmVsF1JSBMw=;
        b=7+UnTyFT+TqjSu9Ju4lie8QDX8el9EZqpl+EVwOfOSY0oVrEK/qm55e3aoTXWteNE1
         H4CdNYS6/VbJ4X+tB4Cl03C/yBunIdUMSaaauZhON/7Yz9gLNtdbaxOENvjAR8df2BBn
         2YXcw4srmU8nHXdRuP4pmBERND1w9fXywjgJWBLj1LmpHZ7kU7cfflPGLDKdoSltktFI
         CVkcs04HY5/Pweit50FiFCh1iKDr+cfk3zWyc+06fSTooIk01A6zsFnlq0aqMa2viJjm
         8sjeESERA/lUvGx9WVoWwgF4hWrGHu2er41NP0Ri9dO42p57gcHsgfEheVzoNqL4OLVY
         iFqA==
X-Gm-Message-State: ACrzQf3DK0qO/W2zhR2GUpiJVV0S5ALmcrkx9WG3RTDsmmdorRT7/a3i
        rYWxE8nUfzXRjA5uSxBcfvZiaw==
X-Google-Smtp-Source: AMsMyM4WPfiepokFOhnKcfOJr85HYlGFsNw/KONl4h2U9SmIK533puCOo9utatMjhaQcmut8ayM6Ig==
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr319450qkp.609.1666979609475;
        Fri, 28 Oct 2022 10:53:29 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a425100b006cec8001bf4sm3438042qko.26.2022.10.28.10.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:53:28 -0700 (PDT)
Message-ID: <5b194c93-48df-055a-f532-abd98657dc41@linaro.org>
Date:   Fri, 28 Oct 2022 13:53:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/4] dt-bindings: pwm: Add Apple PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
 <20221028165215.43662-2-fnkl.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028165215.43662-2-fnkl.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 12:52, Sasha Finkelstein wrote:
> Apple SoCs such as the M1 contain a PWM controller used
> among other things to control the keyboard backlight.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-apple.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-apple.yaml b/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> new file mode 100644
> index 000000000000..39dc32e00a3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-apple.yaml

Filename matching compatible, so apple,s5l-fpwm.yaml

> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-apple.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple FPWM controller
> +
> +maintainers:
> +  - asahi@lists.linux.dev
> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
> +
> +description: |+

Drop |+

> +  PWM controller used for keyboard backlight on ARM Macs
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-fpwm
> +          - apple,t6000-fpwm
> +          - apple,t8112-fpwm
> +      - const: apple,s5l-fpwm

Is it then derived from Samsung platform? If yes, it is candidate for
merging.

> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: fpwm@235044000 {

Generic node name, so just "pwm". Drop also label - it's not used in the
example.


Best regards,
Krzysztof

