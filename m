Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3846A6A94A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCCJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCCJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:59:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0703BDA0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:58:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f13so8041057edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CU36Qx0+p6MLOQ5K57tM7u0vitEOFBXc97asRJKCLJc=;
        b=gYJLj1OTe0kwd7xyGeyqlwjfQiinuhH9B6dNW1bQsHTjABcw27hlCQSCPgFDnPr1Im
         N5qe5qwrFnkNOVHXmstQ4R8guWRxzvhtNMNIml3KAen0XdBihZnVvBDWiNG7tb+rcuxC
         6t8d99Pzle9zbqDjy7/V8vxw1MWss/tLh3Y9jDKtdT+ZR0qG5C6un1GajTuaR7uj8wZV
         JSWulZ5N3lz+u3ZxMpSlvXeLtiuBgsakPq5rMs6Y1Z/Y24Z4SbXJxRpK2Dx71y3JDDTA
         O1EiZiJo7JUukgDYgD0u0aLKYqKsxc8iHPR8GV6ndb3rDEAIDoYMhlrcLUHSHj0E0A/4
         PleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU36Qx0+p6MLOQ5K57tM7u0vitEOFBXc97asRJKCLJc=;
        b=ZrRswblVMg6GG34HHVE17XMB5zfZp0Ze6KTAgFt/jW+kXf8yDh+8CBtMf0lyZAksAj
         WQ/hG/Xrc3JdMx2csFaDNT+rIQssq8JEe+F8a3BiTDxss8NFwJm+RW/a6PnKEBG/RJ6e
         eWqHzIPv5L2eGcm8mkP4RuTodvMaAhWra8aBVitp+mpxXT0wpUjPyrLgqocafxB7PQ4G
         7Q0Ij+BdyFut6MH8OURlg7KC8URo5PG33d/15RuQc6+LBfUer9ub6HymIIBAFsZbIXl1
         N+x4DfKO7JfPeV4cxcmee2eI0NBosXyEVh8XA9M9+V0pNO0xYHPjkgIzRMoDJmo++V5+
         Lb0A==
X-Gm-Message-State: AO0yUKXlit5Mjp+ITrX09prq72ALujwy6XSJp91yqpYmdBX2XrTRXaRz
        KGCVGlXOlg/nskjrSWeDaDY4cg==
X-Google-Smtp-Source: AK7set9Cb5INMEvYD4lAG27kFDAPOhxa7QVZp+bdKpJzdM+ARypsC1YxKja7qU/Mqmy/AEyKucFkBA==
X-Received: by 2002:a17:906:3687:b0:881:4d98:fe2e with SMTP id a7-20020a170906368700b008814d98fe2emr903460ejc.29.1677837535150;
        Fri, 03 Mar 2023 01:58:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id se9-20020a170906ce4900b008dd3956c2e3sm769047ejb.183.2023.03.03.01.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:58:54 -0800 (PST)
Message-ID: <49da270d-6802-79e9-843f-d46efc9ef728@linaro.org>
Date:   Fri, 3 Mar 2023 10:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/9] dt-bindings: crypto: add fsl-sec4-snvs DT schema
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-5-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301015702.3388458-5-peng.fan@oss.nxp.com>
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

On 01/03/2023 02:56, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert fsl-sec4.txt SNVS RTC and PowerKey to DT schema

This is a mess. Subject says add, commit msg says convert and body does
what?

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/crypto/fsl-sec4-snvs.yaml        | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> new file mode 100644
> index 000000000000..633e70f9b303
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml

Filename matching compatibles.

> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/fsl-sec4-snvs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SEC4 SNVS Binding

Drop Binding.


> +
> +description:
> +  CONTENTS
> +    -Secure Non-Volatile Storage (SNVS) Node
> +    -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node

OK, this is some copy-paste from some poor other code. Please fix all
your bindings like I mentioned in previous emails.

> +
> +  Node defines address range and the associated interrupt for the SNVS
> +  function.  This function monitors security state information & reports
> +  security violations. This also included rtc, system power off and ON/OFF
> +  key.
> +
> +  For more information on SEC4, ref fsl-sec4-crypto.yaml
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,sec-v4.0-mon
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description:
> +      A standard property. Specifies the physical address range of the SNVS

So the rest are non-standard properties?


> +      register space.  A triplet that includes the child address, parent
> +      address, & length.
> +
> +  interrupts:
> +    description:
> +      Specifies the interrupts generated by this device.  The value of the
> +      interrupts property consists of one interrupt specifier. The format
> +      of the specifier is defined by the binding document describing the
> +      node's interrupt parent.

Please point me to any useful information in this description. Anything
useful. All interrupts are generated from the devices, aren't they?

> +    minItems: 1
> +    maxItems: 2

No, you need to describe the items instead.

> +

(...)

> +    sec_mon: sec_mon@314000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

No underscores in node names.

> +        compatible = "fsl,sec-v4.0-mon", "syscon";
> +        reg = <0x314000 0x1000>;
> +
> +        snvs-rtc-lp {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "fsl,sec-v4.0-mon-rtc-lp";
> +            regmap = <&sec_mon>;
> +            offset = <0x34>;
> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clks IMX7D_SNVS_CLK>;
> +            clock-names = "snvs-rtc";
> +        };
> +
> +        snvs-powerkey {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



Best regards,
Krzysztof

