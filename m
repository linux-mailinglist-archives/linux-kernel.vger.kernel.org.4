Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058D061078D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiJ1B7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiJ1B66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:58:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D0B03D4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:58:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 8so2619782qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAW17+BRYm/H3b4WvRIwEV8kXOxv/g6sG9smsLfq3p0=;
        b=vjd0f8z/krQCI2mZcirxzMwClkzC3Hldszir9m1PcZNl5VAXYBpmRo2ls+Z3CZSInj
         j4tlmLK67v0MVs4OGpDoutATgrFPQpizafC6XVVlW6Q3zLxufNHl1PGBQUzwX9TKXjTR
         HoldiZLnPe9s9oDlHkCzvqFs3hd+InNKIqhNPuExt/l/QgTjfuoUPXJloLu8yjn9/ZgP
         Sowaw+Qq+aV17bOJwf5M/Y0Eb4Dmais0JAAaTsNXfpSXdS0XcROkC9mNvC/lGijnFlHn
         o8pNyukvX8+tgODVDBeXz1KGUy5W5PQCukWv4M8CxFGbeoSOL74P+9RVugWtQXf6VIF5
         cLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAW17+BRYm/H3b4WvRIwEV8kXOxv/g6sG9smsLfq3p0=;
        b=yD7Ns3zXw4AH3ieMOfHjMxT6EC6rcvZ+UwmzY10xJxSCyzwdKzENkVdVZVEqsapsek
         QzfxSC8qBzu32ZiTGURLcxGvF0yKMKlaTKXJntQpgYkYIzy7Iwe5NyNGbieWUn2SRX1L
         WGgH74+OemtymrpFg1+6wNfbGF6X9df9KSCuSWlSh4fQW5KACpSmsdZjriuxUe7/F4Cf
         RxA3kH+1HPhgMSKt5zcBH4WZxR6IiDAuus0EYisl+XDyl1oOvyzoUv4pqMYBqTgKJipy
         T+ECKeaHlApGmZuQFV2REFig7UQV34RJCUzKdITAw6h2a8c4oKbAMbBZ9BiKr9NqOmWO
         4Bpw==
X-Gm-Message-State: ACrzQf1dDvmPb/lCkm6uGitaQ1C5+As9s5qbZ+ZOBX/yFCCgiy2NQqKw
        twGpp0PcVK9dJgCmWEpC4yKP7w==
X-Google-Smtp-Source: AMsMyM4KNauk+P3PKPfVNAfv2imHHQZUKu47Ls8+K3ykGh6ymSZlm9Yn/lb4RSQzLktpCTirbNrTUQ==
X-Received: by 2002:a05:620a:1452:b0:6ec:3f82:522b with SMTP id i18-20020a05620a145200b006ec3f82522bmr36080682qkl.402.1666922337187;
        Thu, 27 Oct 2022 18:58:57 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h18-20020ac87d52000000b003998bb7b83asm1694147qtb.90.2022.10.27.18.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 18:58:56 -0700 (PDT)
Message-ID: <d6f14e09-0c24-e19a-0951-bb3ca2219e79@linaro.org>
Date:   Thu, 27 Oct 2022 21:58:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Content-Language: en-US
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-Yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221027030155.59238-1-allen.chen@ite.com.tw>
 <20221027030155.59238-2-allen.chen@ite.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027030155.59238-2-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 23:01, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Rob asked - Commit msg should explain reason for breaking users.

> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml   | 68 +++++++++++++++++--
>  1 file changed, 62 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a7..b16a9d9127ddb 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,9 +52,49 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>  
> -  port:
> -    $ref: /schemas/graph.yaml#/properties/port
> -    description: A port node pointing to DPI host port node
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: A port node pointing to DPI host port node
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              link-frequencies:
> +                minItems: 1
> +                maxItems: 1
> +                description: Allowed max link frequencies in Hz
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for DP output
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                uniqueItems: true
> +                items:
> +                  - enum: [ 0, 1 ]
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +

This looks ok.

Best regards,
Krzysztof

