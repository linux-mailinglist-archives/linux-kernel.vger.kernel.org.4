Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED31F6C4432
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCVHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCVHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:36:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8045CC3A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:36:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so68972825edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679470572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uV97OTONSxnGEyV7uO8OnMJG0g0QG+ETuEfWA/XgJlc=;
        b=PGSo4SIkDysijZW+Nb0UtNdfJBM6YH+rR5SG3c21IjzKSh4MGWnrr9YkU/SDC5POk3
         jQltAPsr2pcOlhSACMu5bVLiitpiqT8JSv2ciEWwUttYxEg5I5m4EmLMmAnctcIlRSPX
         72qFxluE6ZdM1FBgos9TBMDKEvc4MgyEcS5B4Wlres9EC7nO+4XOM7VtZRSBwlu+fang
         JqwTwKeRY9hTWzc0vcc67VQUYCih31Q/BNXzsm7Ekene6GpgSIBlJ1mT8tO7+gIZ8MkH
         PR2aH1kOB5SJuMk2NYb2S0GG7IL1XAi5/tCLpECL2iq2YVyFyHoAJxKvtu2kn1zRJEMk
         yIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV97OTONSxnGEyV7uO8OnMJG0g0QG+ETuEfWA/XgJlc=;
        b=5ibA1Yw1k9O5JabdpVANW1iXJ6dZiEZpKlX51uBT0KrrDwRpMifPkxHvIwfiuLMBaX
         bzeGoSzNCbIQwy77/g09S4bv31yYTzDgU0Lz9GMSGQzfIPksCIQqhLqjrnVfj+FmvDo+
         r3rPJGq6qk6riOEMUWtgb1kCFFcyTxHwQKYSIioK1jDjDrgU4XBhiVyf3tNdmP6qymHP
         1J/2fG902FZMdOyZplfPp3WplisMnazJKkMhp9jYAO/qqA9EbThFIiXxUEfadZ9cYGhJ
         zs/1oRCIRFSEY6Gr6o3ptHGgSkKaBcn+T4fBZbyvx+YGdT4yHA1pIXyQnRTNWK7Mn4Tj
         rGig==
X-Gm-Message-State: AO0yUKU/YMhcwYwqKX2rmXaSmPhYFZl+D6Garyk68P+uPEB+LdR1fa5a
        cdjRMaf+Q3daMtmhzqHlnqUMZw==
X-Google-Smtp-Source: AK7set9zlFgHEYh7EBKB/Bq2zpzCToe8YappDSA+j6UYFnxOE7JXrPRmTTfy3WKchUJ4BYgi5XUEQA==
X-Received: by 2002:a17:906:ece4:b0:930:9385:ce51 with SMTP id qt4-20020a170906ece400b009309385ce51mr5666192ejb.68.1679470571686;
        Wed, 22 Mar 2023 00:36:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id qh7-20020a170906eca700b0092bea699124sm6768128ejb.106.2023.03.22.00.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:36:11 -0700 (PDT)
Message-ID: <a4e0a256-4db3-543a-f133-852beb4cf726@linaro.org>
Date:   Wed, 22 Mar 2023 08:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/3] media: dt-bindings: ov2685: convert to dtschema
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
 <20230129-ov2685-improvements-v3-2-d9737d0707f6@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230129-ov2685-improvements-v3-2-d9737d0707f6@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 19:03, Luca Weiss wrote:
> Convert the text-based dt-bindings to yaml.
> 

Thank you for your patch. There is something to discuss/improve.

> +  - Shunqian Zheng <zhengsq@rock-chips.com>
> +
> +properties:
> +  compatible:
> +    const: ovti,ov2685
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XVCLK clock
> +
> +  clock-names:
> +    items:
> +      - const: xvclk
> +
> +  dvdd-supply:
> +    description: Digital Domain Power Supply
> +
> +  avdd-supply:
> +    description: Analog Domain Power Supply
> +
> +  dovdd-supply:
> +    description: I/O Domain Power Supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reset Pin GPIO Control (active low)
> +
> +  port:
> +    description: MIPI CSI-2 transmitter port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            maxItems: 1
> +
> +        required:
> +          - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dvdd-supply
> +  - avdd-supply
> +  - dovdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c7 {

i2c

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

