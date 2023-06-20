Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228F7367FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFTJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFTJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:40:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C6F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:40:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9883123260fso319325266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687254024; x=1689846024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYEa9yHPw2YhwKkNs2WpNu2/p4gZsC1rNIsqGGYjvpY=;
        b=hFpP02AXM4T1GUs7RMTbg98bfrTK1Z/fhu8v+2tSEJouj3UkdOl0p7vAv41i8VUvcD
         TyG5pScpxO9i42Vbg6i0KnNPjvD5sZfWAMJ4gB/OSIL01ZXsyXZY4vKs+CnuiaBTiAkG
         RcdEpVRtrDWCezW7/3B5Vv2v959491Qvc/k5sevABp3n4zuQJFjgH2xYxpmMKbyYGr/4
         bVvHRVLl5ACjgkluBYk7CtjmuzocLSWravezzkTlRzNM4WK2v/OujOs7+Ov2n4MTNS83
         VZmoZl0kopnq+GkuMsG5603tzeQK9rX92VKCXDlsh1WafaAhu98Zx5VrAz+zBy7cYX6m
         VjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687254024; x=1689846024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYEa9yHPw2YhwKkNs2WpNu2/p4gZsC1rNIsqGGYjvpY=;
        b=Xkfd0Mv7xL6WS2ZD8lCvXT1xK1FvtncKmTBfRAPq2pgLR03+AUdTjXmU9uASrJouBq
         CDpqwQdOzxw7rlWpSb2GpbEyXbn4LDOAihH93GKV9DlhMwHjZgx7WB0soZxMbfaDnp5y
         A/ZN7gLIMXQ4xwke2cnAmCFPDw9D8AqcHIZlDuz62PhrlFTHWAKkU9Ls9uvg5sfUlaGH
         A3f8kU8MYyepGJEY9+rHuHMAQvgwTKjyi+iYi0qL5mT962Jghw97yf0B1CTVP3inbOWv
         jRoXknEiHFhdNxtA1d8df8BHfsaFn6LIw8O/u10H9uurOy2yfzuGp0k1zsM4bHihFcrb
         xiHA==
X-Gm-Message-State: AC+VfDwMZSofS7l4IUwBjD6WN5UUqr620h6FynWmK7j3ER60coYNsNv0
        JHEKF0u1TjWTH8+GDIF9BHHaTw==
X-Google-Smtp-Source: ACHHUZ64d48IejsFY3AyhcSWEo9Xzbqw3YvlaDfSqUllkQ4PHpOJqNHJZnYelAyKQq+iB0ojyIzytg==
X-Received: by 2002:a17:907:c23:b0:988:8d17:53bc with SMTP id ga35-20020a1709070c2300b009888d1753bcmr5005707ejc.54.1687254023743;
        Tue, 20 Jun 2023 02:40:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p1-20020a170906a00100b0098242730348sm1058146ejy.72.2023.06.20.02.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 02:40:23 -0700 (PDT)
Message-ID: <9b0d5439-24dd-2c32-f13a-110f758591fb@linaro.org>
Date:   Tue, 20 Jun 2023 11:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: timer: add Ralink SoCs timer documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        devicetree@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
References: <20230620093409.1411399-1-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620093409.1411399-1-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 11:34, Sergio Paracuellos wrote:
> Add YAML documentation for the timer which is present on Ralink SoCs.

If there is going to be new version:
A nit, subject: drop second/last, redundant "documentation". The
"dt-bindings" prefix is already stating that these are bindings in
documentation.

> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/timer/ralink,rt2880-timer.yaml   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
> new file mode 100644
> index 000000000000..9a315449f73e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ralink,rt2880-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Timer present in Ralink family SoCs
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ralink,rt2880-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: timer

Names matching the module name are not really helpful, so drop it,
unless any existing user needs it.

> +
> +  interrupts:
> +    maxItems: 1
> +

Best regards,
Krzysztof

