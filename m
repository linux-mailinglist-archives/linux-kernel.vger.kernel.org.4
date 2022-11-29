Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C552163C2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiK2Onk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiK2On2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:43:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C922FFF1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:43:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r8so17522269ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryrPsvTC2u9FN7t3xIHXCGZHEwmjLn+ZAIdKy6LQCcw=;
        b=CMgqAbviiBucRmPxuCjjgDSOC61lg5cbQWTybVrN2I9OogjdlJef03nx2h2dMviYq+
         fBV3CR/FpUg4CmBFLNeN0i+TuVKS+ztGwmdH+LXPLDKO2udHbmMwLEVaC3sLg3+OvaxR
         TrKsI8AQCE6TRQkfK28dy4j3k+OoqpGd7hQ6guvhCxGGboDGNnAdFQJprHu626BAvptl
         6vWP01QO8I3NUgcei28tWyuhYdrsVheE8FFp9I2JrkBZgV0dN7KZeZNKOYYJSkin+BRQ
         cALK5SJf4w4VCDiqLOGvtRz9LRcX/UrlpM3XdonmqAiL4/WDLprOkSj/w9TGcYFVcNDB
         8auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryrPsvTC2u9FN7t3xIHXCGZHEwmjLn+ZAIdKy6LQCcw=;
        b=bx4MYUwpT6xd5zStV9XcxbnVBx7mSbZkzilt0zwr4t2CbIjUUO0gEYFPdk3/mCdEDP
         EluQhuKbL/KWcO14fwa+Q+RBqwtZjxth12dKsKj5RbW9o6VM16z3PV8aAU8T5CVTwjhk
         kKTBCXS7QEMInl1ySZssN4oRW/9s2kJ5J4bBIUsg0mvHY58gN/0oKhOeW8hVqQFsAZNV
         6Y1HCU/6N0/BqlXwisZ3IBsOzPLLG+QQfKcGK4Cp/EkiykPaj4mbx0Lun5m0L4NKSFxH
         nh0tDIXFzT5Lz4OLYnf7wcsCNQwlWSgu1BM7zLrNpLkZh4a+8UuDm7joTLLGT1GnTOHv
         neXQ==
X-Gm-Message-State: ANoB5pnkDzZU4dwyFYVDUj2CLjIlxjsfKpUSiLVbzUs8VZpMSa7022zl
        EPf8IJseWuC+KyPLhOWQygn8dRn+Fm9LujX9
X-Google-Smtp-Source: AA0mqf7eaccMFeBvSS/YKnLK/unubS7qy/Jm5yAGTUc+/T3WOiqrIJTgOfUDbuk/fdY/tEjrEZMFQA==
X-Received: by 2002:a2e:87d7:0:b0:277:100c:db42 with SMTP id v23-20020a2e87d7000000b00277100cdb42mr17359053ljj.417.1669733001945;
        Tue, 29 Nov 2022 06:43:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x2-20020a0565123f8200b00498fc3d4cfdsm335345lfa.189.2022.11.29.06.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:43:21 -0800 (PST)
Message-ID: <4e90944a-1200-4619-f977-590fe2919017@linaro.org>
Date:   Tue, 29 Nov 2022 15:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/8] dt-bindings: soc: socionext: Add UniPhier SoC-glue
 logic
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-3-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129103509.9958-3-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 11:35, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the SoC-glue logic implemented on
> Socionext Uniphier SoCs.
> 
> This SoC-glue logic is a set of miscellaneous function registers
> handling signals for specific devices outside system components,
> and also has multiple functions such as I/O pinmux, usb-phy, debug,
> clock-mux for a specific SoC, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-soc-glue.yaml          | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> new file mode 100644
> index 000000000000..3f571e3e1339
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier SoC-glue logic
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  SoC-glue logic implemented on Socionext UniPhier SoCs is a collection of
> +  miscellaneous function registers handling signals outside system components.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - socionext,uniphier-ld4-soc-glue
> +          - socionext,uniphier-pro4-soc-glue
> +          - socionext,uniphier-pro5-soc-glue
> +          - socionext,uniphier-pxs2-soc-glue
> +          - socionext,uniphier-ld6b-soc-glue
> +          - socionext,uniphier-sld8-soc-glue
> +          - socionext,uniphier-ld11-soc-glue
> +          - socionext,uniphier-ld20-soc-glue
> +          - socionext,uniphier-pxs3-soc-glue
> +          - socionext,uniphier-nx1-soc-glue
> +          - socionext,uniphier-soc-glue

This one looks generic - why having it next to specific ones?

Same question for your previous patch - socionext,uniphier-sysctrl.

And similarly to previous patch, do you expect child nodes everywhere?

> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pinctrl(@[0-9a-f]+)?$":
> +    $ref: /schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
> +
> +  "^usb-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/phy/socionext,uniphier-usb2-phy.yaml#
> +
> +  "^clock-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
> +

Best regards,
Krzysztof

