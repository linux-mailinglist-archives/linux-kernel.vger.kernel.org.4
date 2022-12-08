Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09A646A43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLHIQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:16:48 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD79248E7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:16:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so888136lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PF1nhzaa3bOWLnElJnxjSlerqY4ubgHIoylvmN0rU3Y=;
        b=II6e9Bf4eylbafWSRmdDpTseqtGBMvPUBc4y4RVjH3ExqDvoZ8qn9JW6AkGIH5NHB+
         mVDEZdssSaKciolHTzNGUUJVVQJAUaJPxS/ftiN/fvllC4D/cH7RVXxPwHspKOZdSawl
         erutud72cCMbwmC9zOe24feYT2iFt4Aau7c27i0vKN69Jix4UvuIjIrp5fdHdJ8gJIyN
         2biwVdum4ufLkWgHd37GQZ87Nple0oBC3/vdPlf9XZnQBL/Zz4Et1ZGyoI3CHL+CmxY3
         xy+NWYWbOSYtXgKVNK+EI0uB2d3JAU6quq7YBKbQXGEgje1I4kUu/gxebMmqIcwBoiHm
         enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PF1nhzaa3bOWLnElJnxjSlerqY4ubgHIoylvmN0rU3Y=;
        b=hSs0PSrfg0ro8dvmxg0vBs7AlQODnNr34ARVjKJ1oInPqZcRpAAIuWXnm99j+jFac7
         R6EZLmoMJF5axIZlHYYrBGn/t2Lryq4lvGFXMYtXbimZupTlnqYghTgLlFD7BOytcsFa
         r0yRg5o43/A8/48MZZniPwJIqnZAomZQMm1aNMMuodPSG3qHQTyzrYLP1k2yRT1zX0yE
         d+kyqjSa7/AMssQv6Z0LFwbwACEiwvHPUpUX8/YSpnF5uMITRGQWhWi84KvmBSXlouw2
         UODR8WzX64IN71EzDLcDnkEL5sFq353w/WbqByUc26LNFJ2QxnHu+h9EbpuykCF7Q3uU
         PSyw==
X-Gm-Message-State: ANoB5plHEMgJD3ZG3qqhgwrmcevhh+7StTMjU7dZPadAyNmj38YQbbhY
        Y1RbdPaE02lWjk2amk5heFRdeEY2tyyjWxANs4c=
X-Google-Smtp-Source: AA0mqf6W3fEmxI0w/HyRzJGr/j0fAAN2mK0bJVsJ5O5eA5FfTnbKMaJm7XrZDqNhpM830ZMhfwMyQw==
X-Received: by 2002:a05:6512:12c9:b0:4af:aa4c:fc8c with SMTP id p9-20020a05651212c900b004afaa4cfc8cmr30006852lfg.653.1670487405542;
        Thu, 08 Dec 2022 00:16:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v18-20020ac258f2000000b004b567e1f8e5sm1879659lfo.125.2022.12.08.00.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:16:45 -0800 (PST)
Message-ID: <26c92774-e709-ef13-598b-d271368249bc@linaro.org>
Date:   Thu, 8 Dec 2022 09:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 09/16] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-10-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207055405.30940-10-hayashi.kunihiko@socionext.com>
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

On 07/12/2022 06:53, Kunihiko Hayashi wrote:
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
>  .../socionext,uniphier-soc-glue.yaml          | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> new file mode 100644
> index 000000000000..6fc790963660
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> @@ -0,0 +1,113 @@
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
> +          - socionext,uniphier-sld8-soc-glue
> +          - socionext,uniphier-ld11-soc-glue
> +          - socionext,uniphier-ld20-soc-glue
> +          - socionext,uniphier-pxs3-soc-glue
> +          - socionext,uniphier-nx1-soc-glue
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pinctrl(@[0-9a-f]+)?$":

Your children cannot have unit address in this binding (not mentioning
that children schema has in example statement that unit address is
invalid: "must be a child of syscon node").

> +    $ref: /schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
> +
> +  "^usb-hub(@[0-9a-f]+)?$":
> +    $ref: /schemas/phy/socionext,uniphier-usb2-phy.yaml#
> +
> +  "^clock-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
> +
Best regards,
Krzysztof

