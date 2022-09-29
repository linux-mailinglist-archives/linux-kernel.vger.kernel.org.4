Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561275EF0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiI2Ikh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiI2IkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:40:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DC2EF3E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:40:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u10so904736wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=9yCHudwWTs8iGGjOW2yzGpZ+XsTes14RKtIMcMyggXE=;
        b=YFayQv5zccBSzwC1ZnIbDUZbLsM5Aw0c4lFGDl4BO08Fpc4xl1cSeF9XXRqN5P5wBe
         rUvsdp0+jezwGpqFcH1QtaHdcASZqq7taW1fiJdA9oSjTXpvHWhdwa/CoOO9UXMZBZ7w
         577un9+SStHkbJq2UtdLIG+55k8dJPgURuKlXUvVybFvIDYQnf5aWia3bF5ivDeCRVsW
         YV0IeKrGlCWORDAyaSR278Awgf8LrUJyhCdsMhgZcEpy0rUK5tEf5qaGZAdddCm9czVw
         645Ecj0rvYLRyzmy5GTcIB6sEWkKytHF34Tikwf4yGojhiBUIuOUewdrRPhOibhw8imB
         hxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=9yCHudwWTs8iGGjOW2yzGpZ+XsTes14RKtIMcMyggXE=;
        b=vDMY87b8IeO9dcfsQy48YiVghnKnzocWIqwiejuqvoRmJrasrYIem6e3GC4fJ4jLRO
         9gWm0bk8VPXBRCrDNsRGeEycT2GylHDawhE8bs8da8+pcnSf4ab39PvRu4rwkcldIIQy
         D4MjrmQMl7VePNZBezoWDBbXwqk4mrUOcOf2s2eYzuyvKLb6o1cQQLXXNhtvcVLQ69fV
         Dy64GPFxgIsjDFSsO2Uo+WAbnNAKLEGuvE30+A/7dctbvsHXhOZ6PTXUAYnUxa4+1w7X
         peLklzjD44O0j5vGXvdGNubCgGqGSQy7eyWgy0pS5IzpBaotkLNCD6E04RHHd4dyfAwq
         dLQQ==
X-Gm-Message-State: ACrzQf3PxD+BUNvK/ffe96MTGzjJL/lgOF3tDyr77LJM2bj25q4G6VUX
        FWfe88yS4kVA7VmA62bsQ1wo3w==
X-Google-Smtp-Source: AMsMyM6dwuUJdxC7BENyYXPsQCOd+CranHMYc70MqG9BZMnC1YgoC1MsI3vRIn9cBDMtsz0FCbVOkg==
X-Received: by 2002:a05:6000:98b:b0:22c:c3b1:3f2a with SMTP id by11-20020a056000098b00b0022cc3b13f2amr1359248wrb.11.1664440815789;
        Thu, 29 Sep 2022 01:40:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm3963146wmh.23.2022.09.29.01.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:40:15 -0700 (PDT)
Message-ID: <aaf68eff-17da-3f27-c8dc-48b9659e7b50@linaro.org>
Date:   Thu, 29 Sep 2022 10:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Content-Language: en-US
To:     allen <allen.chen@ite.com.tw>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>
References: <20220929014456.30077-1-allen.chen@ite.com.tw>
 <20220929014456.30077-2-allen.chen@ite.com.tw>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Organization: Linaro Developer Services
In-Reply-To: <20220929014456.30077-2-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/09/2022 03:44, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>   .../devicetree/bindings/display/bridge/ite,it6505.yaml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a..62b9f2192202 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,6 +52,14 @@ properties:
>       maxItems: 1
>       description: extcon specifier for the Power Delivery
>   
> +  data-lanes:
> +    maxItems: 1
> +    description: restrict the dp output data-lanes with value of 1-4

Can't you use the data-lanes property in the first port endpoint ?

Look at Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml

> +
> +  max-pixel-clock-khz:
> +    maxItems: 1
> +    description: restrict max pixel clock

New vendor specific properties should have the ite, prefix.

> +
>     port:
>       $ref: /schemas/graph.yaml#/properties/port
>       description: A port node pointing to DPI host port node
> @@ -84,6 +92,8 @@ examples:
>               pwr18-supply = <&it6505_pp18_reg>;
>               reset-gpios = <&pio 179 1>;
>               extcon = <&usbc_extcon>;
> +            data-lanes = <2>;
> +            max-pixel-clock-khz = <150000>;
>   
>               port {
>                   it6505_in: endpoint {

Thanks,
Neil
