Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB17620E44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiKHLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiKHLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:09:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5011007
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:09:33 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c25so20546253ljr.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUpbWABUTfzB/pi8dKsIix5VNK7uNSZkTxF1xyi8p6Q=;
        b=daN5I+/5Xw346JyVPdd1+XPv2eW52SdEi5GCLbHumqVdyvfYvxcJhaIx34QQ5Dn7os
         Fae392wuPFHszQMlyavcl29jJLneUBI8TK+Y6KRRu9xoBjwAtJD2swOVmH+ba/409k/S
         Dn50bdnfGF4BOz6p2nml/ojfgtxOofgKyorrOpR3Yc6vq7DAMbfNxjBIRoS0wfglbZAI
         CqjLQ3yfvB9BVugVfHxWYg5svx8ztRlkm1ePEz1U/O5t1g7/ypvKvMKDvVTOt55XLIzc
         aQjj36nbMXMIApSQW6W8pR5W8a1QiFotDDmfqT/6zXxhLlENE3GemEtvSjMKgf42fYNA
         MSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUpbWABUTfzB/pi8dKsIix5VNK7uNSZkTxF1xyi8p6Q=;
        b=iVQBms1VQdwJiWSyGYH2kjXyMdv7EI6JDKX94/gXmXtkT7BPhI2++U62yOdinX9lj4
         GmLjWiKD43N1wG4ycHWM0xekxkuKsZBkWNzLIGWlDKYWyPk3dvIY7irbW0rbcjv0kL0m
         kq6BjZwcqJjs/Xu7P3CoVCPjCGOAvITLJ0EIrpsOcb2srSt7pPW42wPvNC8Ve2EXb2x4
         +qV+em8knboz0d2rFauRT6VNmNrDLiiAWluG4FPQVf3WMrZDf2Y8/qYwocLgY/5OxZCf
         kbBDEBG5V6klkc0auNN1WU2LP48U2fHNdoGfyf7mbNm9YmU5Xv5D6qbkB9OOcGGM8dI3
         tO5g==
X-Gm-Message-State: ACrzQf2QHFYUgl0IBjkKnwecOmIxQQKxWrOAZ/fq90dMhDTw790xdURB
        MFjdpthZX8Xt905RFxj8ne4wHA==
X-Google-Smtp-Source: AMsMyM4r9X/im4Bovuy9Fj/WpKriNFPX2D47xTmO98ajKNR/1ytDR/C0epzDHfXxnbD43H3sSa6JuA==
X-Received: by 2002:a05:651c:542:b0:277:fb6:b88a with SMTP id q2-20020a05651c054200b002770fb6b88amr20496260ljp.208.1667905772151;
        Tue, 08 Nov 2022 03:09:32 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bp9-20020a056512158900b004b19f766b07sm1745746lfb.91.2022.11.08.03.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:09:31 -0800 (PST)
Message-ID: <48988a50-3c3d-7a85-af28-66f7842e5893@linaro.org>
Date:   Tue, 8 Nov 2022 12:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: uniphier: Add system controller
 bindings
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-2-hayashi.kunihiko@socionext.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107103410.3443-2-hayashi.kunihiko@socionext.com>
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

On 07/11/2022 11:34, Kunihiko Hayashi wrote:
> Add DT binding schema for system controller implemented in UniPhier SoCs.
> This describes that the nodes defined here are treated as "syscon".
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-sysctrl.yaml | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
> new file mode 100644
> index 000000000000..be7cf72c232e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml

arm is only for top-level stuff. System controllers go to soc.

> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/socionext/socionext,uniphier-sysctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier system controller
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  This describes the devicetree bindings for system controller
> +  implemented on Socionext UniPhier SoCs.

Drop "This describes the devicetree bindings for" and instead describe
the hardware.

> +
> +properties:
> +  compatible:
> +    oneOf:

You do not have more than one entry, so no need for oneOf.

> +      - items:
> +          - enum:
> +              # sysctrl
> +              - socionext,uniphier-ld4-sysctrl
> +              - socionext,uniphier-pro4-sysctrl
> +              - socionext,uniphier-pro5-sysctrl
> +              - socionext,uniphier-pxs2-sysctrl
> +              - socionext,uniphier-ld6b-sysctrl
> +              - socionext,uniphier-sld8-sysctrl
> +              - socionext,uniphier-ld11-sysctrl
> +              - socionext,uniphier-ld20-sysctrl
> +              - socionext,uniphier-pxs3-sysctrl
> +              - socionext,uniphier-nx1-sysctrl
> +              - socionext,uniphier-sysctrl
> +              # soc-glue
> +              - socionext,uniphier-ld4-soc-glue
> +              - socionext,uniphier-pro4-soc-glue
> +              - socionext,uniphier-pro5-soc-glue
> +              - socionext,uniphier-pxs2-soc-glue
> +              - socionext,uniphier-ld6b-soc-glue
> +              - socionext,uniphier-sld8-soc-glue
> +              - socionext,uniphier-ld11-soc-glue
> +              - socionext,uniphier-ld20-soc-glue
> +              - socionext,uniphier-pxs3-soc-glue
> +              - socionext,uniphier-nx1-soc-glue
> +              - socionext,uniphier-soc-glue
> +              # perictrl
> +              - socionext,uniphier-ld4-perictrl
> +              - socionext,uniphier-pro4-perictrl
> +              - socionext,uniphier-pro5-perictrl
> +              - socionext,uniphier-pxs2-perictrl
> +              - socionext,uniphier-ld6b-perictrl
> +              - socionext,uniphier-sld8-perictrl
> +              - socionext,uniphier-ld11-perictrl
> +              - socionext,uniphier-ld20-perictrl
> +              - socionext,uniphier-pxs3-perictrl
> +              - socionext,uniphier-nx1-perictrl
> +              - socionext,uniphier-perictrl
> +              # sdctrl
> +              - socionext,uniphier-ld4-sdctrl
> +              - socionext,uniphier-pro4-sdctrl
> +              - socionext,uniphier-pro5-sdctrl
> +              - socionext,uniphier-pxs2-sdctrl
> +              - socionext,uniphier-ld6b-sdctrl
> +              - socionext,uniphier-sld8-sdctrl
> +              - socionext,uniphier-ld11-sdctrl
> +              - socionext,uniphier-ld20-sdctrl
> +              - socionext,uniphier-pxs3-sdctrl
> +              - socionext,uniphier-nx1-sdctrl
> +              - socionext,uniphier-sdctrl
> +              # mioctrl
> +              - socionext,uniphier-ld4-mioctrl
> +              - socionext,uniphier-pro4-mioctrl
> +              - socionext,uniphier-sld8-mioctrl
> +              - socionext,uniphier-ld11-mioctrl
> +              - socionext,uniphier-mioctrl
> +              # adamv
> +              - socionext,uniphier-ld11-adamv
> +              - socionext,uniphier-ld20-adamv
> +              - socionext,uniphier-adamv
> +          - const: simple-mfd
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties:
> +  type: object

No, instead you should describe the children. This must me
additionalProperties: false

You also miss example.

Start from example-schema as your template or guidance.

Best regards,
Krzysztof

