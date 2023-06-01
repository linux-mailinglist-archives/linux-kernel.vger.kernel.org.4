Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC052719544
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjFAISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjFAISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:18:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599A107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:18:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149bdb59daso865431a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685607507; x=1688199507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIA79XBwvYumb/G8gUWPX+7zKEo7ElCUwf5JGjf9O3k=;
        b=zsKPj3I6Qhnvcy8aehpi2yXfXSU26bcoom+KTNnFvB/Iwkk81xZJ+aKsIEBs5bmXvf
         0OO4gPbCrMOqljgg5vygSJJa//lYsViC5ql5FF3n1Lo6MOU3pyIqqDmAY8Cjeb5fe2Z5
         /RnFClxAYbEeCarLTy3yAe8Xl9D/32+Ys/4rDmeZuvmHQuRDwe3NE+DTrzQkqmYIljPR
         Z5y7QjZcBm7SeoocTblARvt746oxvQuTjuDDcVAsAENh6DP+x8rMbBSZ8TlNqrxkpjhB
         FSQ+Sf6jeY+yVZiEkMQuq8WpkC7gYnTodq1zhYmq/FLiDX28KGTnLtCgiYdH4pYQrTxY
         9TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607507; x=1688199507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIA79XBwvYumb/G8gUWPX+7zKEo7ElCUwf5JGjf9O3k=;
        b=jsphAAAgIhruQZr+r3Q62Pc1dyMZ4R7EKsmdMqg+qmLda/okva+ehoH98sUZyfFBzr
         txr4uCtUwCW+J8zrmjeFYwT4C12XsHYnHmcuz4f1ysajnJB01SsdcSNrj1QjrRjaoBSD
         94Dpl0zItIWLIHb50kqE+EijzcSNXjXazl7mzwtPcURoiLdwV2HdPvfXSxhiaso6bpCR
         D6tZTM6q/6yiaiU1g8jF6GlLY11Q98AWZtoEhzRMZgKQj4MJHKTS6N+NKieQppIezfpJ
         mnQaEpJf6ibw4EksFt3U1H3VPnp3MOg4BKnLi22ruE/lV61rh0LXr4ROgEinD/Tac1f5
         Ejgw==
X-Gm-Message-State: AC+VfDyot5KNHJVjgpUUe0e3AN3pdtDSjMm6UmYUADIIMS9tkR/7+6NW
        wSLdoseeSAndxL9dvVBBmq1cN7W4zWUNKBuHk6I=
X-Google-Smtp-Source: ACHHUZ7+qR1XZbCdhw3gHi5Up/bxJ6eI81Q8ByfLGunNMvzPMiH3SU8lsg35Mbo1RH0mvBXraMgkhw==
X-Received: by 2002:a05:6402:1a4c:b0:514:8f89:fafe with SMTP id bf12-20020a0564021a4c00b005148f89fafemr5353142edb.33.1685607507452;
        Thu, 01 Jun 2023 01:18:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a19-20020a50ff13000000b005148f0e8568sm6502020edu.39.2023.06.01.01.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:18:27 -0700 (PDT)
Message-ID: <a2b286a5-32c1-213d-49df-129f2d94d771@linaro.org>
Date:   Thu, 1 Jun 2023 10:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 29/43] dt-bindings: rtc: Add ST M48T86
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-11-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601054549.10843-11-nikita.shubin@maquefel.me>
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

On 01/06/2023 07:45, Nikita Shubin wrote:
> Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - s/dallas/st/
>     - description for regs
>     - s/additionalProperties/unevaluatedProperties/
>     - add ref rtc.yaml
>     - changed compatible to st,m48t86
>     - dropped label in example
>     - replaced Alessandro Alessandro to Alexandre Belloni
> 
>  .../bindings/rtc/st,m48t86-rtc.yaml           | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
> new file mode 100644
> index 000000000000..eb8e6451d7c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml

Filename based on compatible, so drop "rtc".

> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/st,m48t86-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST M48T86 / Dallas DS12887 RTC wirh SRAM

typo: with

> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,m48t86
> +
> +  reg:
> +    items:
> +      - description: index register
> +      - description: data register
> +
> +allOf:
> +  - $ref: rtc.yaml
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg

required goes after properties:

Keep the same order in all your patches.

> +
> +examples:
> +  - |
> +    rtc@10800000 {
> +      compatible = "st,m48t86";
> +      reg = <0x10800000 0x1>, <0x11700000 0x1>;

One byte long? Not a word?

> +    };
> +
> +...

Best regards,
Krzysztof

