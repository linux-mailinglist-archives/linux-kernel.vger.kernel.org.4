Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4428063BB42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiK2IJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiK2IJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:09:49 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D75E54751
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:09:48 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x6so1749059lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q81LRK3T/EuQJCNdVN6VMMo84qLhMFEYBVI6xieT8fc=;
        b=ChkSiQTgCeqtYFGMZueziZTw7QgAtEKAsmKs9hSQZtZiauHvC9Od+YZ76QEZWGZeBR
         J5Im6a3PxuAPS180+BGY0cu6mEgeqpHJS5CvlJROxNcuOgeBLWtCjCfW75EHEbnQ+gAn
         Dr6LEFFwg59tBNyMWTWD1my001eZ1sUZvQ0Yu3h0CIumsyWkL8Ws4YyGt3Y/TzNl1P7b
         6VRSVvQz1YAlgti+hZQLa3uHr3DBt9hwGlyXpMmuD5G5lLBXl2rYHPd9aQVZzxjHi3e+
         5scQa2GY7UlNPFN3gb6KJYSm3uhMkztodZarqQW760jurX4MNEsgRDEDVeibys2FAVeu
         331Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q81LRK3T/EuQJCNdVN6VMMo84qLhMFEYBVI6xieT8fc=;
        b=EQVI8kzQraSDLXLgvvZ6JZLD2FQoyF8+TpjGMTvVQmfjb5RlAImR6pUQyhDKnwYwKF
         oCbcBTaeM8rYwq/nwOuWlHW+mTGzNUDKu72MdiHMHMtcoBZxoANmrx9ZtS+mtfvpUlWb
         8VEawHayYDR9SY+5c6s1g7hfAO9E0pi8WBRkteA4x11PbAvcf3KOQqFCkKgcE+7xrmI5
         zmvEd26ZlLBevwh6hkrVLNjU3JX118UbdDXn7uvPQ2Aozqecisx7dxiaAjhr06QDiHPD
         y6OHLEtniD2FEaPZG+mHUVLtGMiv6ehqrvCWR2AfYdZWk6ROnTYlPm70n6L0dM8zJik0
         3Lgw==
X-Gm-Message-State: ANoB5pm6g1QrSq3C8bk9PdZfLSZA5hN0xhhD6qmFWhk1gtKsLip7XZSn
        dyn1E4LIFQFfmhaiuddsktMq1w==
X-Google-Smtp-Source: AA0mqf7mXV3xue4WBidHzjSc01+0VNE7mNNq4JiQjZrsZi/lPuomV7rVS24BsId/4Hv2JoqpPtEsIA==
X-Received: by 2002:a05:651c:2205:b0:26e:33f:3c3c with SMTP id y5-20020a05651c220500b0026e033f3c3cmr18005476ljq.52.1669709386697;
        Tue, 29 Nov 2022 00:09:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u12-20020a2eb80c000000b002778d482800sm1437488ljo.59.2022.11.29.00.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:09:46 -0800 (PST)
Message-ID: <a7a705b5-64b1-e735-9f1c-5318c2bdf5db@linaro.org>
Date:   Tue, 29 Nov 2022 09:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 1/4] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
 <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
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

On 21/11/2022 13:29, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..0535d37624cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties

I responded to v6, so let me paste here as well:
Common Fan Properties

> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  min-rpm:
> +    description:
> +      Min RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulses-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwms:
> +    description:
> +      PWM provider.

Maybe:
type: object

> +


Best regards,
Krzysztof

