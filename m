Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86EF6A573D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjB1Kzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjB1Kyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:54:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EAA2DE7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:53:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so5580216wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677581633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOZCIzKrLTMqexjdZ2+a46sW/ksovWEJrh6b6pkknJY=;
        b=XE9qUInIc3TEdvs5mKnKriplipNk0eDs4KVpTrDspr5XSiHyObMNbnTZcOhF2PS2mt
         a0f0xYgoCX6cNVFyjz6VWDNPtt9w65jeO4Qx0u0cu17XqMTR5BiN8kH7EoJhAJe4y0nT
         95aONn1l3B84tS51hQAfjm2AT+Co2XLIWbAivQ0AIyWgtziLPWjdk5L/D5u+v8VwA8AB
         Y19M5K+E08CGQI8SMLUFHOXPtbWYjyamS0rjzYQvzQX8LF/ayVx9HxiY2K/eulO3o6/8
         ucPYhOdXpywGVQE0j2LGFfHhMvtefkgg+pi2HNf3d0cDfxgRLbdMFByLhYKVvSfLv3jr
         b+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677581633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOZCIzKrLTMqexjdZ2+a46sW/ksovWEJrh6b6pkknJY=;
        b=1ZGwjM/FmHLHKJhGFCcirsZ18X2Df8ynMbPm8w0EVjYlHb6bQlNgeKTZbbMu7tCZbb
         M7cZHoMcaDmqNdggbFSRgFn4zOnEIj7NA+q2NgUQRpEtmBXJ24sLRmwpxWEx93s0KC8I
         F1nUu+/qhDWLNRqSKuDTeGGYz2EN1Ph9r3YTfumH1S5KfIUZo869el3GrKP5luwm8PqP
         OEtv3aJTzsS6eI7A67SSLoWspjxogBY53Lkorh7Bvtqqwg6Gsed+dQeY9Da0J1fTCQiD
         6f23872XhgeUHMw8whfO96/IURpUL2Rjb36qjSJ70o4dWJTNngRrk4fhCldxwR6zg+Hj
         wXsQ==
X-Gm-Message-State: AO0yUKX0oyrB2p7m/FgJmh3YGTnGylINdAYOzXrX8clzWWzaUpXLYYv9
        WegB4mmFoqinSWMbRL8FS0oaHw==
X-Google-Smtp-Source: AK7set9K/cJjOM6W7cKYRxtYxRSV69UDHU0t2RPlCILopPormRrRmhWgL1FNrkSC4+RMxrZ2z8podw==
X-Received: by 2002:a05:600c:35d4:b0:3eb:3945:d3fd with SMTP id r20-20020a05600c35d400b003eb3945d3fdmr1671382wmq.14.1677581633700;
        Tue, 28 Feb 2023 02:53:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ja6-20020a05600c556600b003dfefe115b9sm12251903wmb.0.2023.02.28.02.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:53:53 -0800 (PST)
Message-ID: <90b332b7-ba62-d9b5-2d94-5d2e70fad4af@linaro.org>
Date:   Tue, 28 Feb 2023 11:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-6-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227183151.27912-6-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 19:31, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support for SD6 controller support.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..0dba17c4f17f82c8ae68e46225ed72418e8361ff 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>  
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> @@ -18,7 +18,9 @@ properties:
>        - enum:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +      - enum:
> +          - cdns,sd4hc
> +          - cdns,sd6hc

I see here rather random set of changes in each version of this patch.
This does not really make sense. You are saying that existing (!!!)
mpfs-sd4hc is compatible with sd6hc. I think you wanted oneOf here, but
not sure. Can you explain what is your intention? Your commit msg is
just one line saying the same as subject, so not really helpful.


Best regards,
Krzysztof

