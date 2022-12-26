Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC02656154
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiLZI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLZI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:57:13 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9A5F7D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:57:12 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q190so5433387iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y9TbX3Ceh1FvaBv664udZf8XfrOpdKKd1+DeV95MdyU=;
        b=Bi5owdA6WovVAMZcv9Xg7UtskNw4+684vpuoZJeflxtV3ZDO4PKd2iJDfmLTyqqNpq
         lOVR9fPEoBWOyeiHd85xuiPaMJnyBllR19W6q6zN8qOmAkm9E7Kl+IrfWMsltiZ4cmA1
         C+ow+S7IbcqHZPmSLrl2qKxwome1/bjEv8xaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9TbX3Ceh1FvaBv664udZf8XfrOpdKKd1+DeV95MdyU=;
        b=p+RK+dvZiRsDR2W0R1S+pP2NY3iGO8Wm9JtMVwz2UH0hzI8sZ7b0BQLuTCLht2IOJY
         Hu1UY5odGIoOrwkFZj2OrOp+oYRFSO5rhXginvqRDNpAykQ5apjm/146FrlwnbuVRr7I
         lDvFhiZ/VHtq04IKpEIBRSd+SOO5udVz15CBg9g2/EyBJ5Eqp1B6tMeVVBrtedQQNTQW
         FzGEp30tJ9ww0mHCRCNcBMehsqY9BRELKCCQRsp5cHrsMZRhWAnSSM+wXtUGy/F/lGhT
         kbXKQitXf4qtyL1VH5gM8Q6oHGewLV7BHroevw/ncPzgILWr8B5dZag2Psc8wvhONs9j
         yPtQ==
X-Gm-Message-State: AFqh2koZH3Ve4jBsfXeJRB3019nQZdmnEu3xM/RTvFHvAW61lDA3QNMn
        x93EvnWD4L5p55D3SbfRFRVwrKoL06qnTnp5u/o9ng==
X-Google-Smtp-Source: AMrXdXvZZwiu7qagoS6yQmOv/xa7NoF2r1prkxbf2PgG2eUjFk6I49fFzrxM9Ian30iQB4AcDtL7g9FaZUcFi4kfwfI=
X-Received: by 2002:a6b:490f:0:b0:6e3:29a8:47a with SMTP id
 u15-20020a6b490f000000b006e329a8047amr1409337iob.209.1672045032266; Mon, 26
 Dec 2022 00:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-7-treapking@chromium.org> <a2a8cd80-a614-e96f-90ab-a98c60527344@linaro.org>
In-Reply-To: <a2a8cd80-a614-e96f-90ab-a98c60527344@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Mon, 26 Dec 2022 16:57:01 +0800
Message-ID: <CAEXTbpeYZTeWvnGtRo3i7eGSAoQnkSmcpV=SS8MZA+an3SHUwQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Nov 28, 2022 at 5:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/11/2022 11:20, Pin-yen Lin wrote:
> > ITE IT6505 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >   describe the connections.
> >
> >  .../bindings/display/bridge/ite,it6505.yaml   | 94 ++++++++++++++++++-
> >  1 file changed, 90 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > index 833d11b2303a..b4b9881c7759 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -52,9 +52,53 @@ properties:
> >      maxItems: 1
> >      description: extcon specifier for the Power Delivery
> >
> > -  port:
> > -    $ref: /schemas/graph.yaml#/properties/port
> > -    description: A port node pointing to DPI host port node
> > +  data-lanes:
> > +    maxItems: 1
> > +    description: restrict the dp output data-lanes with value of 1-4
>
> Hm, where is the definition of this type? For example it comes with
> video-interfaces, which you did not reference here.
>
Actually I messed up here with another accepted patch:
https://lore.kernel.org/all/20221103091243.96036-2-allen.chen@ite.com.tw/

This and the next new property have been added in that patch.
> > +
> > +  max-pixel-clock-khz:
>
> There is no such unit accepted:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>
> > +    maxItems: 1
>
> maxItems of what type? What is this?
>
> > +    description: restrict max pixel clock
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
>
> This is incompatible change... how do you handle now ABI break?
>
This is also added in another patch, and currently we don't have any
upstream it6505 users now.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
>
> Why changing the ref?

The `unevaluatedProperties: false` in
`/schemas/graph.yaml#/properties/port` does not allow me to add new
properties here.
>
> > +        unevaluatedProperties: false
> > +        description: A port node pointing to DPI host port node
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port-base
> > +        description:
> > +          Video port for panel or connector.
> > +
> > +        patternProperties:
> > +          "^endpoint@[01]$":
> > +            $ref: /schemas/media/video-interfaces.yaml#
> > +            type: object
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              reg:
> > +                maxItems: 1
> > +
> > +              remote-endpoint: true
> > +
> > +              data-lanes:
> > +                minItems: 1
> > +                uniqueItems: true
> > +                items:
> > +                  - enum: [ 0, 1, 2, 3]
>
> Same problem as your previouspatch.
>
> > +
> > +              mode-switch:
> > +                type: boolean
> > +                description: Register this node as a Type-C mode switch or not.
> > +
> > +         required:
> > +        - reg
> > +           - remote-endpoint
> >
> >  required:
> >    - compatible
> > @@ -62,7 +106,7 @@ required:
> >    - pwr18-supply
> >    - interrupts
> >    - reset-gpios
> > -  - extcon
> > +  - ports
> >
> >  additionalProperties: false
> >
> > @@ -92,3 +136,45 @@ examples:
> >              };
> >          };
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    &i2c3 {
> > +        clock-frequency = <100000>;
> > +
> > +        it6505dptx: it6505dptx@5c {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
I'll fix this in v7.
> > +            compatible = "ite,it6505";
> > +            interrupts = <8 IRQ_TYPE_LEVEL_LOW 8 0>;
> > +            reg = <0x5c>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&it6505_pins>;
> > +            ovdd-supply = <&mt6366_vsim2_reg>;
> > +            pwr18-supply = <&pp1800_dpbrdg_dx>;
> > +            reset-gpios = <&pio 177 0>;
> > +            hpd-gpios = <&pio 10 0>;
> > +
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                port@0 {
> > +                    reg = <0>;
> > +                    it6505_in: endpoint {
> > +                        remote-endpoint = <&dpi_out>;
> > +                    };
> > +                };
> > +                port@1 {
> > +                    reg = <1>;
> > +                    ite_typec0: endpoint@0 {
> > +                        mode-switch;
> > +                        data-lanes = <0 1>;
>
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
Sorry for not checking the documentation and testing the patches
before submitting this.

I'll fix the errors in v7.

Best regards,
Pin-yen
>
> Best regards,
> Krzysztof
>
