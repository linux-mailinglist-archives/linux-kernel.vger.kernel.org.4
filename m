Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC05BF6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIUHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIUHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:05:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92295286E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:05:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so7608148lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sx/lrSth5nujqjHlbG4gs9XUHweVDL0pqpPRXfUkt5A=;
        b=XPcKtyGyUjf2RRoiutLMnHiMqd5AUH19sxuidJt/2qc5pLMDNDASfB6fPPJIldseMd
         p4PjEwovWFLPd5z0jUrCIrkqYk46fz32k1pFt0Uz8UXhXfBJrBgtizGMGc76kDu5Te+s
         YH4FxBVLxlk3ITyMEtvkRIl9HWd3FWn6UKDRSyRSfSi6pBV1qhY0uTS5fDY5Zn6leIg9
         Y6zL9VTSjE7Xnpmmqt9EH8vf7sepL+AS6Zzn8a93XiaYbSQvh9YVYxCnaPYevv7cD2YD
         eFIzprDnZGD1yqMP9g3JasLYVVEeUTJqR+9xjKm+s+fXBKdIkjRxgs/j/QfolUNOquzC
         I75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sx/lrSth5nujqjHlbG4gs9XUHweVDL0pqpPRXfUkt5A=;
        b=1pJ8ZoZ47n+w1nV/12U0Rkd2KUpz4Mbr4U/TavF9Zr+r3XB4448/WyDRhRbuDpy5xw
         gt0ORzSqCrDHkI8dhnMPt9faIDVOY6gWnESpuhEZOPxM0EykzmHkXDyvjYrCqEdp5va6
         wWN0yYqRbThCDVrdIoqTWMTssLIdtpwEJGuSpiPh25/3cKeGvK58JEJ7eDTpcXcGBe+l
         ArZPjS2l/4QOLTNBeEMm9RXMOZ09aODIdLS75Ojkbz96U2hCOxWKjSjSGt0pjrnUHP2z
         WZ+VEkrPVt0kLvduYlW6lS5Ww4CmcbkJjPAUK81tZns811ZhPsFdvxXMoz9zVNPwhZjT
         WMrQ==
X-Gm-Message-State: ACrzQf0jwJNSPMDlWbnfLiGCZF3nc/jfKhoHRqJcN1M2HNjSWWROm7R8
        84wckpMhU4KyPdVig3lNeJZmNQ==
X-Google-Smtp-Source: AMsMyM69Jrp+m5vAD9HV9L/xj1HYJRmo29oV2zG6Ek0RJIXp7T9Z1DalUlYmUOiGpJgjupV7fVUDzQ==
X-Received: by 2002:a05:6512:261f:b0:49f:eb39:4762 with SMTP id bt31-20020a056512261f00b0049feb394762mr2140806lfb.670.1663743901905;
        Wed, 21 Sep 2022 00:05:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 5-20020a2e1445000000b0026be23f24efsm314442lju.18.2022.09.21.00.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:05:01 -0700 (PDT)
Message-ID: <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
Date:   Wed, 21 Sep 2022 09:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
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
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921015605.17078-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 03:56, Yinbo Zhu wrote:
> Convert the loongson2 thermal binding to DT schema format using
> json-schema.

Incorrect subject and incorrect commit msg. There is no conversion here.

> 
> Signed-off-by: Yinbo Zhu <c>
> ---
> Change in v2:
> 		1. Add description and type about the "id".	
> 		2. Make the filename was based on compatible.
> 
>  .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> new file mode 100644
> index 000000000000..2994ae3a56aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml


No improvements here. You ignore my comments, so I am going to NAK it.


> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensors on loongson2 SoCs
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,loongson2-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  id:
> +    $ref: '//schemas/types.yaml#/definitions/uint32'

No improvements here, so let me be specific - you need to really justify
such property or it cannot go to schema.

> +    description: |
> +      Specify the thermal sensor id.
> +    minimum: 0
> +    maximum: 3
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

Why?

> +  - interrupts
> +  - '#thermal-sensor-cells'

Use the same style of quote: ' or ".

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermal: thermal@1fe01500 {

How other similar nodes are named (in other DTS files)?



Best regards,
Krzysztof
