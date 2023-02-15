Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159169857A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBOUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBOUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:22:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F72BEF5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:22:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bu23so20386421wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zuvkbge6mkPjzQmD+S7+UtE4w7WXp41ZirBm14pyU3M=;
        b=qCEEn9/tno24xig3oKrHMSFuh6lNDZw6d+ZJKxQLgfAf/b9K2EWWph2iLmBxpf0/ZC
         9rXCDLBvrYVeqPeXUkzppaq7fyGf4bHi5NATAabtUr8dIdcs7AM03Q82RzK6Cmm3JDRl
         vBfP2s5TICP4gSL3B8weD5lT2OZnZ+3whe2BSUGtUZVCcJOsS3fyzKJGNgetVhHEHWKw
         YcbhjOC+Vs0XgoWbZiyvqn/NEm5M9j8pAK9anobkc/zzG+rWPeA8DXttqLp4BZVCtaxR
         WQCJ+yhkrk1OOmECoxu3jaRLX4Gv4WlaLVnYc0ljzETNjoZCuZcGlXkOiJzqv4qijHNO
         Jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zuvkbge6mkPjzQmD+S7+UtE4w7WXp41ZirBm14pyU3M=;
        b=RDXt/cj0MAMUXf/r7UMbpaFD1K+rD9OuIzdjZfnhIeTMfM9TIttx+j4MAEZLWAM1iB
         SUt328qaOwBxUtWWz6YcrnBB6Q5Rj1lPl/Zo7D0D4MZWk3O2VvzwU1oof7NNU6Qwu5mA
         R+vvlrM0u2+leYVcTFeFiWsz3JacRb3KMhwbnLV2AyowVrEBCfn5Y4qO6Hg+9k2f5T/W
         xH/h2FySltv9bgmVUUfXVCDlZk96pDT5/iFUeVicigcfzSiN/JER5k7LIaZ4A9Em1Fvz
         uZy8bTLjarJkDXFFw4DzJCsg6tufM8MfkYehDIXZmXbiD0wl3F2pJ8nYRFEWrFZZgELq
         x11Q==
X-Gm-Message-State: AO0yUKV16sGTy55nfU+fRwTEYmD7iBX4Q5fipjINlt5uTJT0msZC0r/a
        0Nut9J+AE6fyNM0RHpBgTVAz0Q==
X-Google-Smtp-Source: AK7set8kwaAvwsp2XgtutyMrq28GMkilDYbwLvbErvHm9KDz6GXESTACCyuIJDxf3J5pkyLgwsoJqQ==
X-Received: by 2002:a5d:47cb:0:b0:2c5:642f:1550 with SMTP id o11-20020a5d47cb000000b002c5642f1550mr522851wrc.15.1676492556479;
        Wed, 15 Feb 2023 12:22:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b002c55ec7f661sm6928606wrt.5.2023.02.15.12.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:22:35 -0800 (PST)
Message-ID: <5e4b15b1-30f6-ca4e-1355-3c4d36b79541@linaro.org>
Date:   Wed, 15 Feb 2023 21:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: nxp,pcf8563: move
 pcf85263/pcf85363 to a dedicated binding
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
 <20230215081815.3141776-2-javier.carrasco@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215081815.3141776-2-javier.carrasco@wolfvision.net>
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

On 15/02/2023 09:18, Javier Carrasco wrote:
> These Real Time Clocks are managed by the rtc-pcf85363 device driver,
> which now supports the quartz-load-femtofarads property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
> v2:
>   - create new bindings instead of adding conditional properties to an
>     existing one.
> 
>  .../devicetree/bindings/rtc/nxp,pcf85363.yaml | 60 +++++++++++++++++++
>  .../devicetree/bindings/rtc/nxp,pcf8563.yaml  |  2 -
>  2 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
> new file mode 100644
> index 000000000000..52aa3e2091e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,pcf85363.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Philips PCF85263/PCF85363 Real Time Clock
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pcf85263
> +      - nxp,pcf85363
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  quartz-load-femtofarads:
> +    description:
> +      The capacitive load of the quartz(x-tal).
> +    enum: [6000, 7000, 12500]
> +    default: 7000
> +
> +  start-year: true
> +  wakeup-source: true

You could drop these two and use "unevaluatedProperties: false" instead
of additionalProp - less coding and binding already will be prepared for
any new RTC common properties. But it is fine for me as is.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

