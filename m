Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940456E3AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDPRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDPRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:38:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92AB30CF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:38:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so2896356a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681666719; x=1684258719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2vKe4V7oTjo32GQLqOKK9KO2UHfJzvL/v/DQOh4vME=;
        b=abHRUrt5wUQO7o3okURaM/Bwxq5e70RyKNZ3o1yVlo0qp4wUO959TGhV+UTMEmvs1P
         39hfxQ0v0h34iow78PmVmB4uyy211WwlXKoXN5wW0U0B8GdVmpNPQ4pbuSEiiIYNHgR0
         ycG6Vpl6X2UosaD1Obyt9cxSipQLFX8gJg/qD5A7xgYlgChKbiulgPk7a76eYDsJdf5m
         0rJen6DZO4LtdbWS3mnXesWe8bySM4acFPCtaTgE3++2uBuIXgASYpD8AXrzl13ELWYk
         qE81Dmx8d6NkGEtlqdVMz9JDufDmB1dGF8m/sFaEa9FIj0J8WvrwcOnHSf+tgaekA7P4
         63hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666719; x=1684258719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2vKe4V7oTjo32GQLqOKK9KO2UHfJzvL/v/DQOh4vME=;
        b=CvR2MmykPo+oejtnePhAzYlWnLP2ug5fmZNnB8YkO++1K0uENxClplIYdT3c4FBStv
         Mhx/OsEFyMPu6jER+fMEzP2xWew4zKAREoeSueXFxXlbm66S5AvQWv3xxEtIqVrWqmns
         0Oa/IcGZNlJTE/G4LiNLgASNOKjfvV/CzY7VZ2hCX44a4q9AfTQGvjdm4NZOsTzXoOOc
         TqefHUDJrqgupUVjQHaXbF2acZOahp3eYZJcuLrqiR62ziLnuHYaX3WWnI+qasysQCsj
         Em+7RNU0U7xxVn+O+2SL54oEfmG1sc0Xoldp+C13kYNn+e5Po/J4+jQHQp28sv9V4VtY
         yWFA==
X-Gm-Message-State: AAQBX9evNJzlaNkVA+RyN2hUFohK4KUrD6LTjU+QsO2PwfOQi7hsA3fk
        fw7yqjNfx2CMaFYKMOx6kaAvdA==
X-Google-Smtp-Source: AKy350aTQXNKVQFEuceo2SpdnYVpR14+yujDsTeJUZHdSUOVrzsfrVXo5hTVvkca/HY/La78DmELLw==
X-Received: by 2002:aa7:d74f:0:b0:505:34c:eb38 with SMTP id a15-20020aa7d74f000000b00505034ceb38mr11698645eds.11.1681666719387;
        Sun, 16 Apr 2023 10:38:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7ca55000000b004fa380a14e7sm4740615edt.77.2023.04.16.10.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 10:38:39 -0700 (PDT)
Message-ID: <c6571a6d-bf55-14b3-102d-814af6763be7@linaro.org>
Date:   Sun, 16 Apr 2023 19:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: Add simple-clock-controller
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230416173302.1185683-1-mmyangfl@gmail.com>
 <20230416173302.1185683-2-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416173302.1185683-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 19:32, David Yang wrote:
> Add DT bindings documentation for simple-clock-controller, mutex
> controller for clocks.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../clock/simple-clock-controller.yaml        | 50 +++++++++++++++++++

Where is the changelog?

>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
> new file mode 100644
> index 000000000000..17835aeddb1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/simple-clock-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple clock controller
> +
> +maintainers:
> +  - David Yang <mmyangfl@gmail.com>
> +
> +description: |
> +  Driver (lock provider) for real clocks.

Drop driver references. Typo: clock, not lock.

What is a real clock? What is an unreal clock?

> +
> +  Usually one register controls more than one clocks. This controller avoids
> +  write conflicts by imposing a write lock, so that two operations on the same
> +  register will not happen at the same time.

Interesting. How the clock controller imposes write locks? Aren't you
now mixing drivers and hardware?


> +
> +properties:
> +  compatible:
> +    items:
> +      - oneOf:
> +          - const: simple-clock-controller
> +          - const: simple-clock-reset-controller

Why two?

> +      - const: syscon
> +      - const: simple-mfd

Why do you need syscon and simple-mfd?

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    const: 2
> +
> +patternProperties:
> +  "clock@.*":

Use consistent quotes.

Anyway, I don't understand what is happening here and why such changes.
Nothing is explained...


Best regards,
Krzysztof

