Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2366D6261
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjDDNKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjDDNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:10:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D340F7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:10:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so130424764edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680613820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCbi5B1HqIhC33XdpdRXB89NTH08leNjzltupqeTFa8=;
        b=NuTPpo7iQJYwklBLaCifkBcTMQwkPtTF4VhbOQKam//FucHsVfohj8ZwhF4n01oY1i
         /5BHjMgL1Tie1A/hlZKY1rmfgRbuu2HHdaF47RduTpVEllJ1YeTxH2fmVYHJMGfVZwWr
         0KtBE4RzQB64Nps9XPo1LW+QLUtNVJTJ8CfAwmB2JwD7+GKtZtL4g3RjUlNfQrsaFs/A
         fSbiQWeOLnOPlSqP5BTthuD9RICxEClE3G7R0wivHzy6XrDvxU7c+ZjKaI2noPTAAecu
         SC+m5MjjBiKkK5JsO5IWUr67onNs+d8bKE1dEu/lfrdwL0qVRIZjaYtKSxVRlnnusWrV
         pBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680613820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCbi5B1HqIhC33XdpdRXB89NTH08leNjzltupqeTFa8=;
        b=5qxKTJyQXhxmQ36WzzL8u7BYESv4l1xxKFudaEU5MX8bNaiwl/TE69VLTFId9CgzwE
         pb2NJoNGeyfqe9HqgfQmD3k/Pl6oK+cqK9472u4oQ9Ci9ZaalooTTyofapBJRYh8XvbR
         Uzv6Vzyz0zAt7qh0ntlgrxE4u+daoiSLBnA1YQB0BdOkt5fjkAUTJApWdBLFgB2+SNPR
         BYzs5f9+EivNDRL7jnEg7xb9OLtRjgjdVJ869Na6PVitCUndZmxuGp6jAndD+J3dHVO/
         uMZSqHxKS51bOSrmRKww29IOeuPLWCXb3gMSlqHANqQBBOJAhWjBoXBKPAJvT1oIyXEO
         kY5Q==
X-Gm-Message-State: AAQBX9caVf5txzed8xaEgjZmT+JMBNQ9A0braKiN+xQAutIIl2IT2+4I
        GEw/6u/odUNw4kfHiQv3bQr+Ug==
X-Google-Smtp-Source: AKy350bHeq/jvus80SWXZRKF8hKRZkMU1yUYoS6L4h9+HYXhFaR54exd9V9GVMLqOznQRJtFtlrYZQ==
X-Received: by 2002:a17:906:3756:b0:8ad:51e9:cd57 with SMTP id e22-20020a170906375600b008ad51e9cd57mr2300286ejc.49.1680613820475;
        Tue, 04 Apr 2023 06:10:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7467:56f4:40b7:cba8? ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id le3-20020a170907170300b0093b8c0952e4sm5932699ejc.219.2023.04.04.06.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:10:20 -0700 (PDT)
Message-ID: <7d5c4407-3198-c39a-2c30-fbaeb5c53b08@linaro.org>
Date:   Tue, 4 Apr 2023 15:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 17:43, Ibrahim Tilki wrote:
> Devicetree binding documentation for Analog Devices MAX313XX RTCs
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/rtc/adi,max313xx.yaml | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> new file mode 100644
> index 000000000..0c17a395e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX313XX series I2C RTCs
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: Analog Devices MAX313XX series I2C RTCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31328
> +      - adi,max31329
> +      - adi,max31331
> +      - adi,max31334
> +      - adi,max31341
> +      - adi,max31342
> +      - adi,max31343
> +
> +  reg:
> +    description: I2C address of the RTC
> +    items:
> +      - enum: [0x68, 0x69]
> +
> +  interrupts:
> +    description: |
> +      Alarm1 interrupt line of the RTC. Some of the RTCs have two interrupt
> +      lines and alarm1 interrupt muxing depends on the clockin/clockout
> +      configuration.
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    description: |
> +      RTC can be used as a clock source through its clock output pin when
> +      supplied.

This part is correct, but your implementation is not. I don't think you
can disable or enable interrupts, based on usage of clock. Either this
is clock (gated or not) or interrupt, not both.


Best regards,
Krzysztof

