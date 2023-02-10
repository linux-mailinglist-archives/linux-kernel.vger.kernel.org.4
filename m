Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59441691949
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBJHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjBJHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:38:13 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04748A5C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:38:11 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id bl9so1627417iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 23:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sH6WBMIYjOrjkH/731UIBZAsfjfVbMVBCIgRS34cgKk=;
        b=Fe2eLtjJLCwCT5mjjaOcyhU9LHroO1VFce8GA6kOXZOtOO1loppZhJi0f+d5S/XcZa
         gUhbP7U+Z8crCLL204zmBCuDFdWoRpx5VblEOafV7ONWHW7VV9FHgtOJeXHfNOQw0kn+
         0vOFqgzajHL07LDo0QMuEekRU1mV/tNJNIDOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sH6WBMIYjOrjkH/731UIBZAsfjfVbMVBCIgRS34cgKk=;
        b=VPFNq0jUp4xTiQk53GCx/G7xSw6s0C3wku6hz8+9JyoyXaB3J0kQgxct9kaN/TsqEo
         ZQs+97XUTIr9QiZ7WxdlkxYh57myH+/aT+EC0H/Z5Fh56LuNPCYvgBBB+wLeB8iec8AN
         oOTLFJJup4WWyzFTPMJ5ha4gXGPsJHWKfaliUueEhDITD//3KtNAiqY2/NjP+27ncwn3
         5SOeQCMtghtQt2DHHlEE3nkbILbr0MXmtOGHoL9y8WQUbxpKgTmoNcVPksTTtD7XQ/12
         hijoTCUPZnbdpN7XCwMM598xYvTjPLaM4tZK9pMbudmo1SrgKPCnIsyPotDLAv+ggD7n
         kW1A==
X-Gm-Message-State: AO0yUKX9lVXtV/QFoZmYiBuOwBej5C+X3IQ+E90bedVB3BpyGaceJS6L
        rfNPsXuz2XlnLOD0lsCgjee4TqJx5RAtUl6XIXgJIQ==
X-Google-Smtp-Source: AK7set/gx4TdacLbs0+/wfrvnIrUVSLZGEzR1Zu0S5V34Avy7nZFwCtAuXpEjElIVZdXZPwaeLkLAtTf8V2q6DIpRAI=
X-Received: by 2002:a02:c816:0:b0:3c2:8c48:377a with SMTP id
 p22-20020a02c816000000b003c28c48377amr7201617jao.115.1676014691042; Thu, 09
 Feb 2023 23:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20230116110820.2615650-1-treapking@chromium.org>
 <20230116110820.2615650-2-treapking@chromium.org> <20230117201703.GA3555326-robh@kernel.org>
 <CAEXTbpdOg_un9rWD+QeS1rJLW8wHzDOnkJ-i6R0WNvAU4THEGQ@mail.gmail.com>
 <Y+InK8qF0Izlv6s6@pendragon.ideasonboard.com> <CAEXTbpc=2BOvcXDj-Bff7y3yZjaYr61RBphLiCkkUVzGFnVgKg@mail.gmail.com>
 <Y+JsWQZMKCuPSbeO@pendragon.ideasonboard.com>
In-Reply-To: <Y+JsWQZMKCuPSbeO@pendragon.ideasonboard.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 10 Feb 2023 15:38:00 +0800
Message-ID: <CAEXTbpf+wK8hLmN=E=Z7zaM+p0OW5sNW83pq9HFmdwWsE7uM=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add GPIO display mux binding
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Feb 7, 2023 at 11:21 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello Pin-yen,
>
> On Tue, Feb 07, 2023 at 06:30:36PM +0800, Pin-yen Lin wrote:
> > On Tue, Feb 7, 2023 at 6:25 PM Laurent Pinchart wrote:
> > > On Tue, Feb 07, 2023 at 06:07:44PM +0800, Pin-yen Lin wrote:
> > > > On Wed, Jan 18, 2023 at 4:17 AM Rob Herring wrote:
> > > > > On Mon, Jan 16, 2023 at 07:08:19PM +0800, Pin-yen Lin wrote:
> > > > > > From: Nicolas Boichat <drinkcat@chromium.org>
> > > > > >
> > > > > > Add bindings for Generic GPIO mux driver.
> > > > > >
> > > > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Referenced existing dt-binding schemas from graph.yaml
> > > > > > - Added ddc-i2c-bus into the bindings
> > > > > >
> > > > > >  .../bindings/display/bridge/gpio-mux.yaml     | 95 +++++++++++++++++++
> > > > > >  1 file changed, 95 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..da29ba078f05
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > > > > @@ -0,0 +1,95 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Generic display mux (1 input, 2 outputs)
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Nicolas Boichat <drinkcat@chromium.org>
> > > > > > +
> > > > > > +description: |
> > > > > > +  This bindings describes a simple display (e.g. HDMI) mux, that has 1
> > > > > > +  input, and 2 outputs. The mux status is controlled by hardware, and
> > > > > > +  its status is read back using a GPIO.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: gpio-display-mux
> > > > > > +
> > > > > > +  detect-gpios:
> > > > > > +    maxItems: 1
> > > > > > +    description: GPIO that indicates the active output
> > > > >
> > > > > What are we detecting? That implies an input, but this is selecting the
> > > > > output path, right? Or what does 'mux status is controlled by hardware'
> > > > > mean exactly? Something else? That does not sound very generic.
> > > >
> > > > The GPIO (or any kind of MUX) is an input that indicates where the
> > > > output should go. The actual "output selection" procedure is done in
> > > > the driver. That is, the driver monitors this GPIO and selects the
> > > > output path accordingly. In our use case, the GPIO is reported by the
> > > > embedded controller on the device.
> > > >
> > > > [1] listed other similar bridges that can leverage this driver, so we
> > > > called this driver "generic".
> > > >
> > > > [1]: https://lore.kernel.org/all/CAJMQK-jGw8kJFNjoHjeZUL+3NCiOS2hgGERnAnMwNsL_cm_J=Q@mail.gmail.com/
> > > >
> > > > > In any case, we have a common mux binding so any kind of mux control
> > > > > could be used here, not just GPIO. Then you can make this just a generic
> > > > > display mux.
> > > >
> > > > Thanks for sharing this, I'll update the binding in the next version.
> > > >
> > > > > > +
> > > > > > +  ddc-i2c-bus:
> > > > > > +    description: phandle link to the I2C controller used for DDC EDID probing
> > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > >
> > > > > This belongs in the connector node(s).
> > > >
> > > > The HDMI bridge before the MUX doesn't (and doesn't have to) know that
> > > > its next bridge is a MUX. We put it here so that the HDMI bridge can
> > > > parse the phandle and get the bus node.
> > >
> > > How does that work, does the HDMI encoder driver parse the ddc-i2c-bus
> > > property of the next DT node in the OF graph ?
> >
> > Yes. In our use case, mtk_hdmi.c[2] checks the remote node of its
> > output port to get the bus phandle. sun4i_hdmi_enc.c[3] seems to use a
> > similar approach as well.
>
> Peeking into nodes of other devices is a bad practice. I don't know how
> the code you mention below got merged, but I'm pretty sure I would have
> flagged it if I had reviewed the patches :-)
>
> The ddc-i2c-bus property should instead be specified in the node where
> it logically belongs (in this case, the connector node), and handled by
> the connector driver. You can then use drm_bridge operations to tie
> things together, like done in the drm_bridge_connector helper. I'd
> recommend using the drm_bridge_connector helper if you can, either
> as-is, or by extending it.

So, even if the connector does not have its own i2c controller, we
should put ddc-i2c-bus property in the connector DT node and tell the
DRM core that this bridge (driver) has the ability to read EDID?

If so, I'll fix up the mtk_hdmi.c driver and update the anx7688 driver
in the next version.

Regards,
Pin-yen
>
> > [2]: https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/mediatek/mtk_hdmi.c#L1500
> > [3]: https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c#L240
> >
> > > > > > +
> > > > > > +  ports:
> > > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > > +
> > > > > > +    properties:
> > > > > > +      port@0:
> > > > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > > > +        description: |
> > > > > > +          Video port for input.
> > > > > > +
> > > > > > +      port@1:
> > > > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > > > +        description: |
> > > > > > +          2 video ports for output.
> > > > > > +          The reg value in the endpoints matches the GPIO status: when
> > > > > > +          GPIO is asserted, endpoint with reg value <1> is selected.
> > > > > > +
> > > > > > +    required:
> > > > > > +      - port@0
> > > > > > +      - port@1
> > > > > > +
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - detect-gpios
> > > > > > +  - ports
> > > > > > +
> > > > > > +unevaluatedProperties: false
> > > > > > +
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > +    hdmi_mux: hdmi_mux {
> > > > > > +      compatible = "gpio-display-mux";
> > > > > > +      detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> > > > > > +      pinctrl-names = "default";
> > > > > > +      pinctrl-0 = <&hdmi_mux_pins>;
> > > > > > +      ddc-i2c-bus = <&hdmiddc0>;
> > > > > > +
> > > > > > +      ports {
> > > > > > +        #address-cells = <1>;
> > > > > > +        #size-cells = <0>;
> > > > > > +
> > > > > > +        port@0 { /* input */
> > > > > > +          reg = <0>;
> > > > > > +
> > > > > > +          hdmi_mux_in: endpoint {
> > > > > > +            remote-endpoint = <&hdmi0_out>;
> > > > > > +          };
> > > > > > +        };
> > > > > > +
> > > > > > +        port@1 { /* output */
> > > > > > +          reg = <1>;
> > > > > > +
> > > > > > +          #address-cells = <1>;
> > > > > > +          #size-cells = <0>;
> > > > > > +
> > > > > > +          hdmi_mux_out_anx: endpoint@0 {
> > > > > > +            reg = <0>;
> > > > > > +            remote-endpoint = <&dp_bridge_in>;
> > > > > > +          };
> > > > > > +
> > > > > > +          hdmi_mux_out_hdmi: endpoint@1 {
> > > > > > +            reg = <1>;
> > > > > > +            remote-endpoint = <&hdmi_connector_in>;
> > > > > > +          };
> > > > > > +        };
> > > > > > +      };
> > > > > > +    };
>
> --
> Regards,
>
> Laurent Pinchart
