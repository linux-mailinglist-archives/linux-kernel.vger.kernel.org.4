Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3E3668763
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjALW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbjALW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:57:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D70517DC;
        Thu, 12 Jan 2023 14:57:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D12F2B8202B;
        Thu, 12 Jan 2023 22:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71884C433A4;
        Thu, 12 Jan 2023 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673564221;
        bh=XJbAYFtKJrsiJkc3mYwPVbfBQAWFjyHsbxpFxsr7kv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ecH8E+bpJVchEE2eS/RESQzv4VtE+LZDzau2V9udBRpZBpyqYaQhBR/NhJHiDn/ld
         VJizL7e0gDVZoxmsirE6EM9GcS36cX0eVzokhEwE5F49OyPgYJ+vFdHnSnAAjUC8Mm
         xeoR7+TfM7WFMihxTjDQsfrgqumlMhVBC2fen+u6oXvsguYhW5cU6e9aTxG740TaAM
         ISSUA4KsbAjRLCMOyMpGTfyy0Dz9hmdgW9nKVWJbAJH1MZgAQRkSQMqdkt4ATJPgZd
         jo4Ibc6RPBRo7yYwPJ0Jbv5muBiGm7QsDTU50WgZdQWto7AkquztEXXWkMTMLFRuo+
         Ts2/YwlqbH+zQ==
Received: by mail-vk1-f178.google.com with SMTP id q141so6859135vkb.13;
        Thu, 12 Jan 2023 14:57:01 -0800 (PST)
X-Gm-Message-State: AFqh2krUbdLyqEsME/hCCnOAzWbyMZN5P5ZCsP/aK42wkl9QJJC+z0+E
        JSGp6g/fAG8bY/YG06fiSGfKkN/wr8H43x2Prg==
X-Google-Smtp-Source: AMrXdXt8wHrRY2gdsYARqhiRw0HAx5328dSIv8af4ZbpRgdiVb5LWwG0uV+KGfpJFJ9+GQ11YNTxNRn1tFh83Da+frk=
X-Received: by 2002:a05:6122:221e:b0:3da:f920:c0ef with SMTP id
 bb30-20020a056122221e00b003daf920c0efmr981096vkb.26.1673564220164; Thu, 12
 Jan 2023 14:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org> <20230112042104.4107253-5-treapking@chromium.org>
In-Reply-To: <20230112042104.4107253-5-treapking@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Jan 2023 16:56:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJDGKskYoZvzCVWickpGpA5GtY6p9eY1tKia7cyd+umaA@mail.gmail.com>
Message-ID: <CAL_JsqJDGKskYoZvzCVWickpGpA5GtY6p9eY1tKia7cyd+umaA@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:21 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
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
>   describe the connections.
>
>  .../display/bridge/analogix,anx7625.yaml      | 99 ++++++++++++++++++-
>  1 file changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 4590186c4a0b..b49a350c40e3 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -12,7 +12,8 @@ maintainers:
>
>  description: |
>    The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> -  designed for portable devices.
> +  designed for portable devices. Product brief is available at
> +  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
>
>  properties:
>    compatible:
> @@ -112,10 +113,48 @@ properties:
>                data-lanes: true
>
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
>          description:
>            Video port for panel or connector.
>
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base

You are using a property from video-interfaces.yaml, so you need to
reference that.

Needs some description of what each endpoint is. IOW, how each
endpoint corresponds to the h/w.

> +            unevaluatedProperties: false
> +
> +            properties:
> +              reg:
> +                maxItems: 1
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
>      required:
>        - port@0
>        - port@1
> @@ -164,8 +203,12 @@ examples:
>                  };
>
>                  mipi2dp_bridge_out: port@1 {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
>                      reg = <1>;
> -                    anx7625_out: endpoint {
> +                    anx7625_out: endpoint@0 {
> +                        reg = <0>;
>                          remote-endpoint = <&panel_in>;
>                      };
>                  };
> @@ -186,3 +229,53 @@ examples:
>              };
>          };
>      };
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
> --
> 2.39.0.314.g84b9a713c41-goog
>
