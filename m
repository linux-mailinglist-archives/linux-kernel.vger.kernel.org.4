Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47F6E8264
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjDSUJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjDSUJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:09:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06B524B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:09:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so279543a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681934984; x=1684526984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xw+KJbFyACMkRJGroXOI3BeGOTCCUWrYEe/1oBLkoRQ=;
        b=zxLiR99eSsw7BjcTYQ5S8E/CLIhKw3VB5JtlrC3z5U9ubcd67bhgmEL6qhgyiYHXnN
         1FKFTMdCsvP8cWawQqMJH8WcsJXs7jKvHzVzsgZjss3z7mRJuhEnp2MklmWlA5gMjRXG
         mAUhXVOcM/JlvX7vsTfyiWiz3Rmwe3D+OhArJEsHNLImFAO2I3OTIlHXI/TCRRyyhFR7
         fgT92UqMmmJC/mx078VhIgAqtju+3rvlsQx52kdYVGRerlNjhFJv2cUxNcROuWBOjM+a
         eR1UeOFNXCkXI1ObwK1mMXi0GZI7DEGzgsoWiT7tdYkbkrHnV27T/TMX25BRd/GWv2DD
         1tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934984; x=1684526984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw+KJbFyACMkRJGroXOI3BeGOTCCUWrYEe/1oBLkoRQ=;
        b=iEGSidzrKK/3gOEmOi7NsRfp3j4fhlKbrhh3SCjqx6e+alUtj8dGSjuEGr20KjwwDj
         2/ubPuYbSyPBIssUgCCoXG72dFg615//HUrJGgofBPOouI+8cqHEWmopujT4MNtCLqOO
         ickEr9OF0uDZzSJMch9dEy45MFJ5HUX3v5phh80JdJ+so6D/epcvg66euDFCeUmcJZil
         LZXz14vOuc2MzHVGlHv4ZeNRWDzjdlquVnKZZ2jJ75/9vXPa7z8jloWXdwf+3eChlZX4
         gFcBexcQzq4XJF34c+HbsqRYgSVEYdKYsyER3Vv/ZcvZff4IcBigsnoHtfAOPaAknS3B
         MsDg==
X-Gm-Message-State: AAQBX9fdcagTX9NGcFn97rIKvk/WseprETINKGei6UJna4XlmaKcArOK
        RXjHZ6kbD6cLNoYehkExy+O3Ug==
X-Google-Smtp-Source: AKy350a3Apxx+KuNFbakTzHCxKVnVUVMPDVeV2R93lEsA74lMQBPm+5IF/g1O8tqNFYYN6/peDtnqw==
X-Received: by 2002:a05:6402:650:b0:504:b313:5898 with SMTP id u16-20020a056402065000b00504b3135898mr7270539edx.27.1681934983797;
        Wed, 19 Apr 2023 13:09:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7dd0a000000b0050685927971sm6858485edv.30.2023.04.19.13.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:09:43 -0700 (PDT)
Message-ID: <f9b62f48-5c8b-2674-313d-4552c61c4302@linaro.org>
Date:   Wed, 19 Apr 2023 22:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Content-Language: en-US
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <cover.1681887790.git.zhoubinbin@loongson.cn>
 <3b9c4f05eaf14bc3b16aebec3ff84c8a2d52c4a5.1681887790.git.zhoubinbin@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3b9c4f05eaf14bc3b16aebec3ff84c8a2d52c4a5.1681887790.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 09:17, Binbin Zhou wrote:
> Add Loongson Extended I/O Interrupt controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../loongson,eiointc.yaml                     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> new file mode 100644
> index 000000000000..4ab4efb061e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson Extended I/O Interrupt Controller
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +description: |
> +  This interrupt controller is found on the Loongson-3 family chips and
> +  Loongson-2K series chips and is used to distribute interrupts directly to
> +  individual cores without forwarding them through the HT's interrupt line.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k0500-eiointc
> +      - loongson,ls2k2000-eiointc
> +
> +  reg:
> +    items:
> +      - description: Interrupt enable registers
> +      - description: Interrupt status registers
> +      - description: Interrupt clear registers
> +      - description: Interrupt routing configuration registers
> +
> +  reg-names:
> +    items:
> +      - const: enable
> +      - const: status
> +      - const: clear
> +      - const: route
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    eiointc: interrupt-controller@1fe11600 {
> +      compatible = "loongson,ls2k0500-eiointc";
> +      reg = <0x1fe11600 0x10>,
> +            <0x1fe11700 0x10>,
> +            <0x1fe11800 0x10>,
> +            <0x1fe114c0 0x4>;

Binding is OK, but are you sure you want to split the address space like
this? It looks like two address spaces (enable+clear+status should be
one). Are you sure this is correct?

Best regards,
Krzysztof

