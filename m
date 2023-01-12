Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEF666AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjALF0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjALF0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:26:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0C63CB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:26:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i63so1266895ioa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QY1E4/I6RghVeieKHKvp0MOZpx6IxtkejP5Fijsma7E=;
        b=jbR5QkZ9oTOTD86R7m2LvwAPxczUOeacx5dN+653AdySSX+Bpcf9XBGnH5lRRbfmJR
         sodSwRDpEyXjrQYEpdkNwDmY15Zav2XcpqVRXZ75WdQZUPSp+HD1LkCWASmj4amyOICs
         w6vxJaQ3oShEPZfh2OZMYmsk6/4BLAxTKyfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QY1E4/I6RghVeieKHKvp0MOZpx6IxtkejP5Fijsma7E=;
        b=EAIt+KPyfWgCgUN+5WYYdNvs2z6TOasRyoThmuJRk3domP7WUIvm+/IVsJsiSES3JL
         6jNwz3DfYslWXVJtjLQKBjRSemoy2nUNwO2TfQTHY6Fbm4oHnIspjkD/+4lbrUhcEGEl
         Fra8VzWVZmArGXE62WKoTNy5hWL7wY0BrEtRsVmVXSwmtQu+Ts6tteDGYzqn7PHsguWi
         5M4LH2Lw9GLnNeWtzcqspuP7/MnE3HTyyEuEoAXT7FnQ/NRxUWoyLn5o7AbcuZpvPvlk
         xlTxbGrCyD0o+NqY+Mw/b8T/1Dt7OKt31difN20Aj1YozkmA5Nt76THRsKzznLjNEHSS
         VRbg==
X-Gm-Message-State: AFqh2kq6jgBPfw1UXY+v2a7s8EGzMuZWDOgCoj7C8gUMQhqeWOd2GIYs
        07zQVIEhutHCI6y8OQmDpgToItyPkldHBRqhkGsF2g==
X-Google-Smtp-Source: AMrXdXugCp7x+cUdqaG8tZQfFSqRksTZdbCE7QDMdiXrvqvOB3sTUbzLnrw6wV699TgRxXpVeA0/zh1LOZOk5XKNk3c=
X-Received: by 2002:a05:6638:58:b0:38a:9192:2ba6 with SMTP id
 a24-20020a056638005800b0038a91922ba6mr7600948jap.76.1673501173912; Wed, 11
 Jan 2023 21:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-5-treapking@chromium.org> <fce16123-e157-bcd6-553d-6c1926fe1d46@linaro.org>
In-Reply-To: <fce16123-e157-bcd6-553d-6c1926fe1d46@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 12 Jan 2023 13:26:03 +0800
Message-ID: <CAEXTbpfrwRxT7hov1G_URGdVY+n-RWRZrGA8C2zjcnX=6QaOvg@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Guenter Roeck <groeck@chromium.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for the review.

On Thu, Jan 12, 2023 at 12:43 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/01/2023 06:20, Pin-yen Lin wrote:
> > Analogix 7625 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Also include the link to the product brief in the bindings.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > ---
> >
> > Changes in v10:
> > - Collected Reviewed-by and Tested-by tags
> >
> > Changes in v9:
> > - Collected Reviewed-by tag
> >
> > Changes in v8:
> > - Updated anx7625 bindings for data-lane property
> > - Fixed the subject prefix
> >
> > Changes in v7:
> > - Fixed issues reported by dt_binding_check
> > - Updated the schema and the example dts for data-lanes.
> > - Changed to generic naming for the example dts node.
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >    describe the connections.
> >
> >   .../display/bridge/analogix,anx7625.yaml      | 99 ++++++++++++++++++-
> >   1 file changed, 96 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > index 4590186c4a0b..b49a350c40e3 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > @@ -12,7 +12,8 @@ maintainers:
> >
> >   description: |
> >     The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> > -  designed for portable devices.
> > +  designed for portable devices. Product brief is available at
> > +  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
> >
> >   properties:
> >     compatible:
> > @@ -112,10 +113,48 @@ properties:
> >                 data-lanes: true
> >
> >         port@1:
> > -        $ref: /schemas/graph.yaml#/properties/port
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> >           description:
> >             Video port for panel or connector.
> >
> > +        patternProperties:
> > +          "^endpoint@[01]$":
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              reg:
> > +                maxItems: 1
>
> Please remove duplicates to the graph.yaml. You have several of them here.

I'll fix this in v11.
>
> > +
> > +              remote-endpoint: true
> > +
> > +              data-lanes:
> > +                oneOf:
> > +                  - items:
> > +                      - enum: [0, 1, 2, 3]
> > +
> > +                  - items:
> > +                      - const: 0
> > +                      - const: 1
> > +
> > +                  - items:
> > +                      - const: 2
> > +                      - const: 3
> > +
> > +                  - items:
> > +                      - const: 0
> > +                      - const: 1
> > +                      - const: 2
> > +                      - const: 3
> > +
> > +              mode-switch:
> > +                type: boolean
> > +                description: Register this node as a Type-C mode switch or not.
> > +
> > +            required:
> > +              - reg
> > +              - remote-endpoint
> > +
> >       required:
> >         - port@0
> >         - port@1
> > @@ -164,8 +203,12 @@ examples:
> >                   };
> >
> >                   mipi2dp_bridge_out: port@1 {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> >                       reg = <1>;
> > -                    anx7625_out: endpoint {
> > +                    anx7625_out: endpoint@0 {
>
> But why? It's perfectly fine from the graph perspective to omit the
> index if there is jus a single endpoint.

This is because "reg" property is added as a required property. Do you
suggest making "reg" property optional and only add it when there are
multiple ports?
>
> > +                        reg = <0>;
> >                           remote-endpoint = <&panel_in>;
> >                       };
> >                   };
> > @@ -186,3 +229,53 @@ examples:
> >               };
> >           };
> >       };
> > +  - |
> > +    i2c3 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        encoder@58 {
> > +            compatible = "analogix,anx7625";
> > +            reg = <0x58>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&anx7625_dp_pins>;
> > +            enable-gpios = <&pio 176 GPIO_ACTIVE_HIGH>;
> > +            reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
> > +            vdd10-supply = <&pp1100_dpbrdg>;
> > +            vdd18-supply = <&pp1800_dpbrdg_dx>;
> > +            vdd33-supply = <&pp3300_dpbrdg_dx>;
> > +            analogix,audio-enable;
> > +
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                port@0 {
> > +                    reg = <0>;
> > +                    anx7625_dp_in: endpoint {
> > +                        bus-type = <7>;
> > +                        remote-endpoint = <&dpi_out>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> > +                    reg = <1>;
> > +                    anx_typec0: endpoint@0 {
> > +                        reg = <0>;
> > +                        mode-switch;
> > +                        data-lanes = <0 1>;
> > +                        remote-endpoint = <&typec_port0>;
> > +                    };
> > +                    anx_typec1: endpoint@1 {
> > +                        reg = <1>;
> > +                        mode-switch;
> > +                        data-lanes = <2 3>;
> > +                        remote-endpoint = <&typec_port1>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
>
> --
> With best wishes
> Dmitry
>

Best regards,
Pin-yen
