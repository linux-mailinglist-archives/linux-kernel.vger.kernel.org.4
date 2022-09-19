Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE05BC351
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiISHDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiISHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:03:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE31D308
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:03:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q17so18865633lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9xFTk4OMhZkRlhAaanDFcs7HM/NhpRYI6iz828j2ZeA=;
        b=wJ7qP0XlQU6l+wwCv1ayWHDuWf6ip3NMJLAJNXT5z7UomUh+jpD6eFLmTPkxo6V5QJ
         yuNT3vObCNly/555xWdO1u9e9H4wobqR5iNkDDUKCshgxhdlZJOWGwBytHHwQPBdkqfD
         ik1jdaFy0j70Gms28/12tPl/jTDeexSVoCuM6CrR3uIhDPsuVTQVevE3pTrWHNVsEwcS
         vsbHyKqnD02gMF1Tmnp9E+17THTx6ohIRmORnSxE1iM77YuY8eRT5yU39BYNiDr4+7WY
         id+OggelsrRjY6tbJgu59PQBV/ZQ46dtB0cCcu6Es+2vPCSGzmDABBNa5xkrvbFwDGNE
         FsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9xFTk4OMhZkRlhAaanDFcs7HM/NhpRYI6iz828j2ZeA=;
        b=X0F+UBACV96ES2WyVuFTOK7oKS2ImOQEabsqlnbVfTdSvXU3fxtNEizUi6gjBMXfKN
         iaT3EhABKC7O6xklvWywGlE8nRrlHU4SYZUDMsDZyRKsHCXYijd8ZMXIq8gSeoRFRv+M
         PXJih/vhGhDL4G2wiLuwAVPFVFZkzC3ISoBnElhMRl9dSLye16wa8TR43TD0XRcwt8pA
         8pysmOlQ0M5IoibZFJ3n1UeVB7RAu9eMo+8OxpmliJhh9Byn+SOq9mk/BNBuRSGUTtZI
         fKNT8CV2x4AU9Lk214IldngqBP32P3f06fecbKc1oijUgDOVZXIhjL9URIGaMJN/jKfP
         b5DA==
X-Gm-Message-State: ACrzQf1oXgMF7kAkdzCNtekSx9KLGupUZl5bqLZMk8TV8JIuS5B+cgpH
        1Zmf1T1NgeXTKEWp/GHZ28fNlA==
X-Google-Smtp-Source: AMsMyM7LeebYro7ACkENxHGy30ekGSA6BGvSNxYWMK2+W2evg4h1dugZbL9Q6/4Tq74QNm2Jh8U2TA==
X-Received: by 2002:a2e:9cf:0:b0:26c:3973:ec1f with SMTP id 198-20020a2e09cf000000b0026c3973ec1fmr4624171ljj.322.1663570998645;
        Mon, 19 Sep 2022 00:03:18 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r13-20020a2e994d000000b0026c3b68c8b0sm1443633ljj.74.2022.09.19.00.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 00:03:18 -0700 (PDT)
Message-ID: <25c6693c-a57f-8ea2-71e8-fda9646fd7f1@linaro.org>
Date:   Mon, 19 Sep 2022 09:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/3] dt-bindings: thermal: Convert ls2k to json-schema
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>
References: <20220919034915.26912-1-zhuyinbo@loongson.cn>
 <20220919034915.26912-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919034915.26912-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 05:49, Yinbo Zhu wrote:
> Convert the ls2k thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

FYI, All your patches were marked as spam, unfortunately.

> ---
>  .../bindings/thermal/ls2k-thermal.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml
> new file mode 100644
> index 000000000000..44bc5d4626d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml

Filename based on compatible.

> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ls2k-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensors on loongson 2k SoCs
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,2k-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  id:
> +    const: 0

Why? What is this? No description, no type (is there such standard
property?), no vendor prefix... and always equal to 0?

> +
> +  interrupt-parent:
> +    maxItems: 1

That's not needed, I think.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - id
> +  - interrupt-parent
> +  - interrupts
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tsensor: tsensor@1fe01500 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Use names used by other examples.

> +        compatible = "loongson,2k-tsensor";
> +        reg = <0 0x1fe01500 0 0x30>;
> +        id = <0>;
> +        interrupt-parent = <&icu>;
> +        interrupts = <7>;
> +        #thermal-sensor-cells = <1>;
> +    };


Best regards,
Krzysztof
