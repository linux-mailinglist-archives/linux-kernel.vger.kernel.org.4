Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AB6BE428
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCQIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjCQIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:44:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDAD15C85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:43:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so17365241edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679042593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyjsELfFw3lppmbggM22hydH2zqp9jlm3lTnEs6D8is=;
        b=HUvjbzmDbBt2pJx9PYHfYufQrQwXrdyNXF9UkWGR+N1EEfRNjewLhQ03io6sM4WuOV
         GnvIM6bMAuclAa3iPXZR5JkPODMzLPcQ4tjm+j4Uz39iyMVvN6QVv+rg6Jb0SkEzK+64
         95tWkxo2PFMEsvdvPLRJA8Y7H2PBW5FcXN8XoN768YsQoe46PbreGx4J2WE2A9CgHXfs
         FJ2qNDtOAt+9sQFra6a8V3aew870duReNp4B/SYov0YWpk92vLc3vMZjEeriWbYyMAJ9
         NucsJdcl/iFyc63O7TV7pel9hplwavP04t2dsSdhmkAhxGTu75rdVFgZuhldcLNmIG/k
         5Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679042593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyjsELfFw3lppmbggM22hydH2zqp9jlm3lTnEs6D8is=;
        b=n+d96JknEIh6/+AZQEwCK4f8ycvc+OjVMZcd/o5/3UTwXG22VrywjU2cB0mlNpoOxa
         eu2wD6rIJ+tJzn7pS16CCete+vyDjU2wytgf3dJ3uNNPTdbGeZk1DwEG23X6caDNjNI0
         q7yobt+BvbbAtjXR5ZuUlTfqbu4+5E5wm5rcylLig7z4s3a6zOssAKek18j9JEXJ2Wzp
         3DqUtBHN3JR4jC0qfaoTONstXzVuXh74uPPaoGP1ZA1zdUj5ahIaOIXbnD2tqHTozZSN
         UNBaZgWs3XjVEoJoyPRY4yujQoIXTogT6PJsESr/aeEK+c2tYtxrpM1IvPToQGyeDr2w
         vYeg==
X-Gm-Message-State: AO0yUKXCAPO1u+gElCVGxq+NXDbHqog8XSMC3Whx5dM0qWNnaklY+95w
        50ycdevUHxF9Q87eZVmnouh8wQ==
X-Google-Smtp-Source: AK7set8/JFYEHKdhIyD71Irxi9tirZUYjiWurePXG0zdgWoXg9pW/ioBLAFfYrD2WHCFd+uU8pnQuQ==
X-Received: by 2002:a17:906:f914:b0:88c:6345:d0e7 with SMTP id lc20-20020a170906f91400b0088c6345d0e7mr12442194ejb.36.1679042593540;
        Fri, 17 Mar 2023 01:43:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060d6a00b008d044ede804sm688481ejh.163.2023.03.17.01.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:43:12 -0700 (PDT)
Message-ID: <451c8112-c7f3-f435-5d90-840f01c60bd5@linaro.org>
Date:   Fri, 17 Mar 2023 09:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/5] dt-binding: Add JH7110 USB wrapper layer doc.
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-4-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315104411.73614-4-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 11:44, Minda Chen wrote:
> The dt-binding doc of Cadence USBSS-DRD controller wrapper
> layer.

Subject: drop full stop. It's not a sentence.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).


> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/usb/starfive,jh7110-usb.yaml     | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> new file mode 100644
> index 000000000000..b1a8dc6d7b4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/starfive,jh7110-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controller
> +
> +maintainers:
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-usb
> +
> +  clocks:
> +    items:
> +      - description: lpm clock
> +      - description: stb clock
> +      - description: apb clock
> +      - description: axi clock
> +      - description: utmi apb clock
> +
> +  clock-names:
> +    items:
> +      - const: lpm
> +      - const: stb
> +      - const: apb
> +      - const: axi
> +      - const: utmi_apb
> +
> +  resets:
> +    items:
> +      - description: PWRUP reset
> +      - description: APB reset
> +      - description: AXI reset
> +      - description: UTMI_APB reset
> +
> +  starfive,sys-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle to System Register Controller sys_syscon node.
> +        - description: offset of SYS_SYSCONSAIF__SYSCFG register for USB.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of SYS_SYSCONSAIF__SYSCFG register for USB.
> +
> +  starfive,stg-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle to System Register Controller stg_syscon node.
> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of STG_SYSCONSAIF__SYSCFG register for USB. Total 4 regsisters offset
> +      for USB.
> +
> +  "#address-cells":
> +    maximum: 2

enum: [ 1, 2 ]
(because 0 should not be valid for you)

> +
> +  "#size-cells":
> +    maximum: 2

ditto

> +
> +  ranges: true
> +
> +patternProperties:
> +  "^usb@[0-9a-f]+$":
> +    type: object

missing $ref and unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - resets
> +  - starfive,sys-syscon
> +  - starfive,stg-syscon
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false


Best regards,
Krzysztof

