Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1766E8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAQV5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjAQVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:51:51 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA237556;
        Tue, 17 Jan 2023 12:17:05 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id p185so5821945oif.2;
        Tue, 17 Jan 2023 12:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWeHEeDhyytvt0z9wAJVJnP5zvi6qEzhrzvFt2FSXKo=;
        b=nqG++bv5SMbCkyItEJsopYmCrNQYBZliMYHw9/BRsf2f8/1TTZvisz1XWI3HAG3V1a
         7shFtILFudcopzSS8ZojA9U6N/q9Yt60PvZnQMrF12YF6cLVfkBJ6g5tUw5woHJxROKY
         KyOyVJCTonnlE1ueXx5f+TSkZ3h2U7TPBuQ4jeajT8M0eN0zjojAfFRqH92Jc75oiT3A
         UXgEqPUKJb/fCXf7mR+TcxnTDNm89juDo/8M70nnp0BpzP036aGwXa0gz+FcIG0Gj08e
         SBmBJSFE9/zoSENXn8Q1TDgtxsYP6Ej6deVYv5qJG3X5OoW9EIqBWS3ilXsYAGVMQ81k
         yM3A==
X-Gm-Message-State: AFqh2kpdgwrEqkYBuVIk1mZ0JnjAKXoR/I+CJMM67IhqXaVDX4Mja9Ci
        7VxXXtLSBniOUxs+tJ8LxQ==
X-Google-Smtp-Source: AMrXdXvN97KhxW15va857G2nD7sxVdqeGZh+s1NP2CQrFacIO7mFtVEcuvxG4t9ucxbdl0jh4jbfPw==
X-Received: by 2002:a05:6808:b31:b0:360:ceb6:1f6f with SMTP id t17-20020a0568080b3100b00360ceb61f6fmr1910323oij.54.1673986624462;
        Tue, 17 Jan 2023 12:17:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bu10-20020a0568300d0a00b0066eb4e9242esm17229273otb.67.2023.01.17.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:17:03 -0800 (PST)
Received: (nullmailer pid 3636832 invoked by uid 1000);
        Tue, 17 Jan 2023 20:17:03 -0000
Date:   Tue, 17 Jan 2023 14:17:03 -0600
From:   Rob Herring <robh@kernel.org>
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
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add GPIO display
 mux binding
Message-ID: <20230117201703.GA3555326-robh@kernel.org>
References: <20230116110820.2615650-1-treapking@chromium.org>
 <20230116110820.2615650-2-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116110820.2615650-2-treapking@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 07:08:19PM +0800, Pin-yen Lin wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>
> 
> Add bindings for Generic GPIO mux driver.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
> Changes in v2:
> - Referenced existing dt-binding schemas from graph.yaml
> - Added ddc-i2c-bus into the bindings
> 
>  .../bindings/display/bridge/gpio-mux.yaml     | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> new file mode 100644
> index 000000000000..da29ba078f05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic display mux (1 input, 2 outputs)
> +
> +maintainers:
> +  - Nicolas Boichat <drinkcat@chromium.org>
> +
> +description: |
> +  This bindings describes a simple display (e.g. HDMI) mux, that has 1
> +  input, and 2 outputs. The mux status is controlled by hardware, and
> +  its status is read back using a GPIO.
> +
> +properties:
> +  compatible:
> +    const: gpio-display-mux
> +
> +  detect-gpios:
> +    maxItems: 1
> +    description: GPIO that indicates the active output

What are we detecting? That implies an input, but this is selecting the 
output path, right? Or what does 'mux status is controlled by hardware' 
mean exactly? Something else? That does not sound very generic.

In any case, we have a common mux binding so any kind of mux control 
could be used here, not just GPIO. Then you can make this just a generic 
display mux.

> +
> +  ddc-i2c-bus:
> +    description: phandle link to the I2C controller used for DDC EDID probing
> +    $ref: /schemas/types.yaml#/definitions/phandle

This belongs in the connector node(s). 

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          Video port for input.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          2 video ports for output.
> +          The reg value in the endpoints matches the GPIO status: when
> +          GPIO is asserted, endpoint with reg value <1> is selected.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - detect-gpios
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    hdmi_mux: hdmi_mux {
> +      compatible = "gpio-display-mux";
> +      detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&hdmi_mux_pins>;
> +      ddc-i2c-bus = <&hdmiddc0>;
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 { /* input */
> +          reg = <0>;
> +
> +          hdmi_mux_in: endpoint {
> +            remote-endpoint = <&hdmi0_out>;
> +          };
> +        };
> +
> +        port@1 { /* output */
> +          reg = <1>;
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          hdmi_mux_out_anx: endpoint@0 {
> +            reg = <0>;
> +            remote-endpoint = <&dp_bridge_in>;
> +          };
> +
> +          hdmi_mux_out_hdmi: endpoint@1 {
> +            reg = <1>;
> +            remote-endpoint = <&hdmi_connector_in>;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
