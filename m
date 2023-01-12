Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAF2666A84
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjALEo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbjALEoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:44:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD11182E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:44:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bt23so26673060lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47snh28HUgMeLpHnJEUn7mW35yDFmysVC3/EfGDSaFw=;
        b=FHj3RRQlxzRQ1jEHAj2YFjjXRA471fiEFh+jaDRSQpCh1xmUA06YNqqdzHjBhc3jeo
         Mit7tYsx0JA03iLuhmwzzDPZEWRGi0szBQKVZ0ZVTsHhsu1K+gOyQERsdWn4146K6r3j
         1mHIpeenGeotbEheoEvsM3yDbgWAiJI8pkHYDll5bUxlJvduib4vW3DYNKtasGFq4NGC
         MIxRh07BoK6T9Q/kwpGeRgh/fSLR69JxBbOksHhaSSiqk5HUOH26HqmY3LzhocWYdDGJ
         qrF52xPvPrvta2wYtAZ4PMXZCkbHoxvSsCiI02I9daYma3kVR06NVgZ3M5IUoJsddvid
         nd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47snh28HUgMeLpHnJEUn7mW35yDFmysVC3/EfGDSaFw=;
        b=LVvMZ2nE52xfeGXGV9e3n+vueYJ1CiWRxhdhYDuZQT87G9NWKXA+Zswq13YCPOuhG0
         SI7ezeVyWX5byaBguDehHrWOL4B6fgx33YIyfK7GjCzNykD2uBewxIR52/n7mkwUatAP
         kMyQhZOm3lPYFR+CkgUoLvUkUyiu5RhCq+Sp3XO5MpVmX8E4CQsEnEx7j7/O/hCltERz
         YEtTfMkpUboaMjX7/sMgzCeh97RAdY8lPtP6XUzuIdEwgIwVCGrTj4X7TPpxOScTeLC/
         eqfM7fcv+bwq/NIRT0mfdZLQ0MmUuVTWbMt+wxFbkGm+6rhE7KWy8+k20xchjY5ARi5M
         MgJQ==
X-Gm-Message-State: AFqh2koDpfcSICWguhkaL6vDtQQJLb7cT/QxxWl0bC0yKZkiCheZih8k
        gluvLL8IMEQ6KIty1UVcWWkU9g==
X-Google-Smtp-Source: AMrXdXuJYXA78PDxN6LQrEjY5+RRXTU8k7U/8eiSXPtUiMUSIRDxU8f/h/SbFey4SBXSNGQmTG8wrA==
X-Received: by 2002:ac2:5308:0:b0:4cc:a041:2ba2 with SMTP id c8-20020ac25308000000b004cca0412ba2mr234557lfh.24.1673498638802;
        Wed, 11 Jan 2023 20:43:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512314b00b004b592043413sm3077777lfi.12.2023.01.11.20.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 20:43:58 -0800 (PST)
Message-ID: <fce16123-e157-bcd6-553d-6c1926fe1d46@linaro.org>
Date:   Thu, 12 Jan 2023 06:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 4/9] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
Content-Language: en-GB
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Xin Ji <xji@analogixsemi.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-5-treapking@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230112042104.4107253-5-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 06:20, Pin-yen Lin wrote:
> Analogix 7625 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Also include the link to the product brief in the bindings.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> 
> Changes in v10:
> - Collected Reviewed-by and Tested-by tags
> 
> Changes in v9:
> - Collected Reviewed-by tag
> 
> Changes in v8:
> - Updated anx7625 bindings for data-lane property
> - Fixed the subject prefix
> 
> Changes in v7:
> - Fixed issues reported by dt_binding_check
> - Updated the schema and the example dts for data-lanes.
> - Changed to generic naming for the example dts node.
> 
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>    describe the connections.
> 
>   .../display/bridge/analogix,anx7625.yaml      | 99 ++++++++++++++++++-
>   1 file changed, 96 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 4590186c4a0b..b49a350c40e3 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -12,7 +12,8 @@ maintainers:
>   
>   description: |
>     The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> -  designed for portable devices.
> +  designed for portable devices. Product brief is available at
> +  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
>   
>   properties:
>     compatible:
> @@ -112,10 +113,48 @@ properties:
>                 data-lanes: true
>   
>         port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
>           description:
>             Video port for panel or connector.
>   
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              reg:
> +                maxItems: 1

Please remove duplicates to the graph.yaml. You have several of them here.

> +
> +              remote-endpoint: true
> +
> +              data-lanes:
> +                oneOf:
> +                  - items:
> +                      - enum: [0, 1, 2, 3]
> +
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +
> +                  - items:
> +                      - const: 2
> +                      - const: 3
> +
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3
> +
> +              mode-switch:
> +                type: boolean
> +                description: Register this node as a Type-C mode switch or not.
> +
> +            required:
> +              - reg
> +              - remote-endpoint
> +
>       required:
>         - port@0
>         - port@1
> @@ -164,8 +203,12 @@ examples:
>                   };
>   
>                   mipi2dp_bridge_out: port@1 {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
>                       reg = <1>;
> -                    anx7625_out: endpoint {
> +                    anx7625_out: endpoint@0 {

But why? It's perfectly fine from the graph perspective to omit the 
index if there is jus a single endpoint.

> +                        reg = <0>;
>                           remote-endpoint = <&panel_in>;
>                       };
>                   };
> @@ -186,3 +229,53 @@ examples:
>               };
>           };
>       };
> +  - |
> +    i2c3 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        encoder@58 {
> +            compatible = "analogix,anx7625";
> +            reg = <0x58>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&anx7625_dp_pins>;
> +            enable-gpios = <&pio 176 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
> +            vdd10-supply = <&pp1100_dpbrdg>;
> +            vdd18-supply = <&pp1800_dpbrdg_dx>;
> +            vdd33-supply = <&pp3300_dpbrdg_dx>;
> +            analogix,audio-enable;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    anx7625_dp_in: endpoint {
> +                        bus-type = <7>;
> +                        remote-endpoint = <&dpi_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    reg = <1>;
> +                    anx_typec0: endpoint@0 {
> +                        reg = <0>;
> +                        mode-switch;
> +                        data-lanes = <0 1>;
> +                        remote-endpoint = <&typec_port0>;
> +                    };
> +                    anx_typec1: endpoint@1 {
> +                        reg = <1>;
> +                        mode-switch;
> +                        data-lanes = <2 3>;
> +                        remote-endpoint = <&typec_port1>;
> +                    };
> +                };
> +            };
> +        };
> +    };

-- 
With best wishes
Dmitry

