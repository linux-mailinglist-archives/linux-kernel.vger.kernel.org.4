Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277C719367
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjFAGkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFAGkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:40:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD5126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:40:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f6e83e12fso54970266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601608; x=1688193608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Cv6JOLKqyraaAJ1veDO2EfbDEnH0qDmoSmkFEbJxzU=;
        b=rGULAy8o6ltpYLKvIWAp6dbZn/AbKY9W5TZa/ke5vYz4397NkfiwVXAd3rniVX3jnb
         P3tBKaU08bTKi8Lb7UbGlLPzPGo6NJV+Gr+cMwH7n1Z2OnA6VayOZOFZer87sN5bj7wV
         lvm28mS+XzC5qHqaoWh2WlA0d34xqq7bVhx1U1RcAu4sAhKLuICvynoxV05PYZKglk+a
         LwtfnDkJWN3OxdOZlFjAacxmYEBPjSK/HUuwnf04wKFy7AMd8LEn50DgdNMggEuevjTe
         pxxZNaALd73mZl6EUtZUnd4uSWuJyberrCZpraXR09M2r7n1oqCxAGOv/zqy4qch1B8P
         ZSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601608; x=1688193608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cv6JOLKqyraaAJ1veDO2EfbDEnH0qDmoSmkFEbJxzU=;
        b=Qcgtq2vaaeJLomwxw/ly6jO6T+1ibDxoSTQkp2RiPm6lqCRcUQNxWLsxlLWxpruH/w
         EtQoMH0Z0RWwdfd1jvmUlAo7d9feCfvrKl9GzpORjkEDlfXf2LIFPcQA1HhOX/nPeL9u
         hA/IEnxJdqh5nJh+IBTHZfbj5Qg1svxy7OOQizkanLTN05eC9m1uExUDITvz4ovSI+Vv
         VHOcgrx42jYpV1vvLX2105jtZjPpD7n5UIZ+gIIlMIv51bRDVNi14+5XtwWHTvErmdL0
         06U6LiA7HP8/vGD3cMFxY0kK530ud8DkjPz8ya9lAcZJXqjhb3idTDcHZ0Ge+mAq1Tgv
         +7bw==
X-Gm-Message-State: AC+VfDwbn+wOTDxBN0KesJWSnp14sFtoFzLColrAaivVMED1D7t+7Moe
        UZb5OtP2zRNUC/kVyPbvfgDstA==
X-Google-Smtp-Source: ACHHUZ6irEqbHsAc+m1c3TXDwUEB0JblM1p8azIRxgoVEdZK5OgrTJxaZdnjwZJYFqEYXfpAyj4MLw==
X-Received: by 2002:a05:6402:1252:b0:514:97f4:8401 with SMTP id l18-20020a056402125200b0051497f48401mr5581425edw.21.1685601608491;
        Wed, 31 May 2023 23:40:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b0050690bc07a3sm6841935edv.18.2023.05.31.23.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:40:08 -0700 (PDT)
Message-ID: <cbe93a8b-bb48-d5f4-38cd-eb63792cff14@linaro.org>
Date:   Thu, 1 Jun 2023 08:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 04/43] dt-bindings: clock: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-5-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-5-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:33, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> clock block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - it's now a clock controller
> 
>  .../bindings/clock/cirrus,ep9301.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
> new file mode 100644
> index 000000000000..4f9e0d483698
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/cirrus,ep9301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic ep93xx SoC's clock controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +description: |
> +  Cirrus Logic EP93XX SoC clocks driver bindings. The clock

First sentence is not suitable for bindings. Describe the hardware or
skip it.

> +  controller node must be defined as a child node of the ep93xx
> +  system controller node.
> +

parent schema should define it...

Best regards,
Krzysztof

