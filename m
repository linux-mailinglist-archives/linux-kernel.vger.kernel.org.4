Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9A69384C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBLQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBLQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:05:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B6FF2A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:05:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y1so9934112wru.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL7rtPVvnhg34mmJ0KisYg5ay8k6Ju8kHpDx7M5W/6o=;
        b=vijyc0FUncIARGjiOi02KYjAsBW2VtvQv4TaC9zE+DH4aGlAp0BHlGtRhA6wzMNLB8
         xSzJ2zKu01SRvXvt4aInK3iO29BYYpopHrhs5g2Zk5RXjDfAvoGqiGrid+cRN49GYOLC
         Nr8d5DjDp5uWb0FHwzmudw7Tc+uez8oWoT3fZ7hIWSUBvrLtA+O7d0FcJWHeEvw6Nsdj
         g+FwxcjKgys4ULDmbI1tuik5d2X6PQqcmBoUa93lXOOvfLMyCTsE9FFa+qCiNymPCFfK
         Bxf8lbz9mPmGiiVdtlbo1fwM7LfvfmKZ4u6iJ5ZX1JXvM744FQGpQRaxiCeaJ0jQ0Gi5
         xQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL7rtPVvnhg34mmJ0KisYg5ay8k6Ju8kHpDx7M5W/6o=;
        b=63zj97l0h5NicEw5V4KVbTW93YfSqQIYyxUeIgO7h0s1FQ/u3IJzNRb/Dh9S8Yu9dO
         g+Ow3xzRCPXuLozh/kqWWsolPV5h5l8voXqPyeHxUfCqKbW1bk6UaM7kJ/C//tjC21aN
         clLKQa1yMNpIZHDZsNIwAq2suRtFc/A8Bj7aAdWhGwOSFEcwHo+yjsiO4mckSB7eRsFg
         LRMYxDVgYqjpGcXFrvRWz1ct/n/jsGIyTpuvEuBzHfeSOXGHHn3KeXTCCPTPOf8K+C6h
         TnGOlK7LoWV2z89bBMTNZlq6OQDGdBQWN7swkQauwDHBAvS5vWYRL4T7OaQJhy+mzfWX
         AJ1w==
X-Gm-Message-State: AO0yUKWGpBFLUYDWB9X7DSS+jzLv/9T+nsvkcuFAK4XYh1hrssQirB/K
        EWsXSAsLbWGlqgdY5MoFLY8RtQ==
X-Google-Smtp-Source: AK7set/29YGWE82Wz3+Rj87GivyV9nV5CY5lLQotReBa+qRCH0xK3fBXSkZ4NVgq3OIBVzmxMYXW1A==
X-Received: by 2002:a05:6000:1184:b0:2c5:5868:c7e with SMTP id g4-20020a056000118400b002c558680c7emr1132183wrx.53.1676217926126;
        Sun, 12 Feb 2023 08:05:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c54d970fd8sm4383884wrq.36.2023.02.12.08.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 08:05:25 -0800 (PST)
Message-ID: <72ae1545-11ad-1c48-c6ac-a5d6e5de54b5@linaro.org>
Date:   Sun, 12 Feb 2023 17:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mailbox: sti: convert sti-mailbox to DT
 schema
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230211205102.9218-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211205102.9218-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 21:51, Alain Volmat wrote:
> Convert the sti-mailbox.txt dt-bindings into dt-schema YAML.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../bindings/mailbox/st,sti-mailbox.yaml      | 54 +++++++++++++++++++
>  .../bindings/mailbox/sti-mailbox.txt          | 51 ------------------
>  2 files changed, 54 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
> new file mode 100644
> index 000000000000..527c88147397
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/st,sti-mailbox.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: STMicroelectronics Mailbox Driver
> +
> +description:
> +  Each ST Mailbox IP currently consists of 4 instances of 32 channels.
> +  Messages are passed between Application and Remote processors using
> +  shared memory.
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stih407-mailbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  mbox-name:
> +    description: name of the mailbox
> +    maxItems: 1

Is the field defined anywhere? Looks like not, thus you need proper type
(and maxItems might not be correct then).

> +
> +  interrupts:
> +    description: the irq line for the RX mailbox
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#mbox-cells"
> +  - mbox-name
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mailbox0: mailbox@8f00000  {
> +        compatible = "st,stih407-mailbox";
> +        reg = <0x08f00000 0x1000>;
> +        interrupts = <GIC_SPI 1 IRQ_TYPE_NONE>;

This should be rather proper type of interrupt, not none.

> +        #mbox-cells = <2>;
> +        mbox-name = "a9";
> +    };
> +
> +...


Best regards,
Krzysztof

