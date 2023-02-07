Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC768D3A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBGKI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjBGKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:08:18 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0AC14EAF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:56 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r6so5467303ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUtfbS0GC3JJK/B5YtNwMVsFna40Ybwka57jHZjmmOU=;
        b=hT7TG39dijBvF0NlSxhfd0VPQvVGxZCZkeozw6VL2COqlxBvf/BM2Nt30mV7W4WzuB
         mjBqUdwrVdHGFuopwTRuTbwO+C0jeAadUVyE+jEpSIGsTv3FkzvV6O/9l4jxnuzHX7cU
         icRfMxUabw9wpgWXtEq/HBlhpq7ox3Eo07l6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUtfbS0GC3JJK/B5YtNwMVsFna40Ybwka57jHZjmmOU=;
        b=a5atflG6rcZBAQkXFD76K0fYUR4WVamDftLg7qeX3vl+LupQsc5Kttx4kcK0tMO7bG
         fFuDlvGp+A22r2KXMwZd6r71GjGLJQx7f1AO9xqlWHgXy7WaLgVeWZYIYD0fGJB26vdS
         uxLPht4yp+IWsYs3+RNJuRc5ql1mu3IOrJaV98VV7eEMlYASVMxLF5pwZq6Md58BckyM
         eFSAHgZto5CzW5AO3sybhQcsFcSPOLFAi9kEXBtBXo6Pmy+6q5we/DqZO0qpdkZkr0vv
         /lvLw8fQJFxFWqsMRYbZDGS/KW6s71d1hzE/h7/S2BuTA79ZoZoKL8EI8ZxSwAQGuPR4
         Yuxw==
X-Gm-Message-State: AO0yUKV9D1OvQveBw+kNDwJW3SBCOAQQN/vioSJOzPMGKM+ARyZrOoq3
        6LQ4j52/1WmYgpA51nPUxeTX8eSN/giJtYDeAQh90g==
X-Google-Smtp-Source: AK7set92k3NRrPN2he11BGdlbGn60K3DywK0CbxSsYhZFMP0yqz9TN0nMnTZIMoiK0OGrH+RzO7evGw5Dv6xxrzg//4=
X-Received: by 2002:a02:ca50:0:b0:3b2:a6c0:2879 with SMTP id
 i16-20020a02ca50000000b003b2a6c02879mr1987635jal.7.1675764475679; Tue, 07 Feb
 2023 02:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20230116110820.2615650-1-treapking@chromium.org>
 <20230116110820.2615650-2-treapking@chromium.org> <20230117201703.GA3555326-robh@kernel.org>
In-Reply-To: <20230117201703.GA3555326-robh@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 7 Feb 2023 18:07:44 +0800
Message-ID: <CAEXTbpdOg_un9rWD+QeS1rJLW8wHzDOnkJ-i6R0WNvAU4THEGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add GPIO display mux binding
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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

Hi Rob,

Thanks for the review.


On Wed, Jan 18, 2023 at 4:17 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 16, 2023 at 07:08:19PM +0800, Pin-yen Lin wrote:
> > From: Nicolas Boichat <drinkcat@chromium.org>
> >
> > Add bindings for Generic GPIO mux driver.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Referenced existing dt-binding schemas from graph.yaml
> > - Added ddc-i2c-bus into the bindings
> >
> >  .../bindings/display/bridge/gpio-mux.yaml     | 95 +++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > new file mode 100644
> > index 000000000000..da29ba078f05
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > @@ -0,0 +1,95 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic display mux (1 input, 2 outputs)
> > +
> > +maintainers:
> > +  - Nicolas Boichat <drinkcat@chromium.org>
> > +
> > +description: |
> > +  This bindings describes a simple display (e.g. HDMI) mux, that has 1
> > +  input, and 2 outputs. The mux status is controlled by hardware, and
> > +  its status is read back using a GPIO.
> > +
> > +properties:
> > +  compatible:
> > +    const: gpio-display-mux
> > +
> > +  detect-gpios:
> > +    maxItems: 1
> > +    description: GPIO that indicates the active output
>
> What are we detecting? That implies an input, but this is selecting the
> output path, right? Or what does 'mux status is controlled by hardware'
> mean exactly? Something else? That does not sound very generic.

The GPIO (or any kind of MUX) is an input that indicates where the
output should go. The actual "output selection" procedure is done in
the driver. That is, the driver monitors this GPIO and selects the
output path accordingly. In our use case, the GPIO is reported by the
embedded controller on the device.

[1] listed other similar bridges that can leverage this driver, so we
called this driver "generic".

[1]: https://lore.kernel.org/all/CAJMQK-jGw8kJFNjoHjeZUL+3NCiOS2hgGERnAnMwNsL_cm_J=Q@mail.gmail.com/

>
> In any case, we have a common mux binding so any kind of mux control
> could be used here, not just GPIO. Then you can make this just a generic
> display mux.

Thanks for sharing this, I'll update the binding in the next version.
>
> > +
> > +  ddc-i2c-bus:
> > +    description: phandle link to the I2C controller used for DDC EDID probing
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> This belongs in the connector node(s).

The HDMI bridge before the MUX doesn't (and doesn't have to) know that
its next bridge is a MUX. We put it here so that the HDMI bridge can
parse the phandle and get the bus node.

Regards,
Pin-yen

>
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: |
> > +          Video port for input.
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: |
> > +          2 video ports for output.
> > +          The reg value in the endpoints matches the GPIO status: when
> > +          GPIO is asserted, endpoint with reg value <1> is selected.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - detect-gpios
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    hdmi_mux: hdmi_mux {
> > +      compatible = "gpio-display-mux";
> > +      detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> > +      pinctrl-names = "default";
> > +      pinctrl-0 = <&hdmi_mux_pins>;
> > +      ddc-i2c-bus = <&hdmiddc0>;
> > +
> > +      ports {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        port@0 { /* input */
> > +          reg = <0>;
> > +
> > +          hdmi_mux_in: endpoint {
> > +            remote-endpoint = <&hdmi0_out>;
> > +          };
> > +        };
> > +
> > +        port@1 { /* output */
> > +          reg = <1>;
> > +
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          hdmi_mux_out_anx: endpoint@0 {
> > +            reg = <0>;
> > +            remote-endpoint = <&dp_bridge_in>;
> > +          };
> > +
> > +          hdmi_mux_out_hdmi: endpoint@1 {
> > +            reg = <1>;
> > +            remote-endpoint = <&hdmi_connector_in>;
> > +          };
> > +        };
> > +      };
> > +    };
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
