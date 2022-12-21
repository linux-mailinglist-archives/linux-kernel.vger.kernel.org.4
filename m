Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743CC6538C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiLUWhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiLUWgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:36:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4920379;
        Wed, 21 Dec 2022 14:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A12261985;
        Wed, 21 Dec 2022 22:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB1EC433D2;
        Wed, 21 Dec 2022 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671662171;
        bh=M/tRY0dtlLHanEM4j2N/f3MgAV3UJcjYrwR7A8LA+gs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mVUrEkg8zRQ7TSOkQUBdp7TE8RNclfXYOvxwJiCqdcEnXqCcogUVKz4dJyuKzdbdm
         fYgrFNzIXPUSFq1dJKKsa8EnqAkOyF+WLEhFp07WZOG7+crDHchayR9j2X4FSBPrtO
         ujaxValndvnwlMPyb6FJgfxbOOrQOQcj0rqQo7FoC7ICwM0uBuXemzqx+qTqbeEVTa
         yazso3peS/sYGtlt0qxwSfakN1zXY6TkTT+w1KYI2MNqymgCeN6+taqP8hdbg5pPr/
         Bu4G/3STagQV9C/a5DeT69RLHGxVJa+L3QSwwecy7tepR949nm+iiwLVkeq3nMnVC9
         GCtNdBlRwljRw==
Received: by mail-vs1-f53.google.com with SMTP id a66so142574vsa.6;
        Wed, 21 Dec 2022 14:36:11 -0800 (PST)
X-Gm-Message-State: AFqh2kqFPX4phZDSyDq3skAQT9ndSvQeHt4Wxn7gFAFWHBPZbw3xRINw
        5szHWAB7uuFPFqLP7WafM7J1lCfdWY+XBjZLag==
X-Google-Smtp-Source: AMrXdXuD7TYLmW0mSW/mYJAckH7H6ZU+Lruhm+3KZIf50DE0jUjltL5AsbTqRq+isZxtINz6jEQbpY5Y06hr4ebaBW0=
X-Received: by 2002:a67:6185:0:b0:3bf:3dbe:50aa with SMTP id
 v127-20020a676185000000b003bf3dbe50aamr478388vsb.26.1671662170541; Wed, 21
 Dec 2022 14:36:10 -0800 (PST)
MIME-Version: 1.0
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com> <fc68bedc-ff93-13bc-aa06-7920f5e53de6@gmail.com>
In-Reply-To: <fc68bedc-ff93-13bc-aa06-7920f5e53de6@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Dec 2022 16:35:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzrMtVBY3vSsykakKp8b_AzhQehOGj3T+RH_NqaTitXg@mail.gmail.com>
Message-ID: <CAL_JsqLzrMtVBY3vSsykakKp8b_AzhQehOGj3T+RH_NqaTitXg@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] dt-bindings: usb: convert fcs,fusb302.txt to yaml
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:23 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Convert fcs,fusb302.txt to yaml.
>
> Changed:
>   Add vbus-supply property
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/usb/fcs,fusb302.txt   | 34 ----------
>  .../devicetree/bindings/usb/fcs,fusb302.yaml  | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
>
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> deleted file mode 100644
> index 60e465429..000000000
> --- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Fairchild FUSB302 Type-C Port controllers
> -
> -Required properties :
> -- compatible             : "fcs,fusb302"
> -- reg                    : I2C slave address
> -- interrupts             : Interrupt specifier
> -
> -Required sub-node:
> -- connector : The "usb-c-connector" attached to the FUSB302 IC. The bindings
> -  of the connector node are specified in:
> -
> -       Documentation/devicetree/bindings/connector/usb-connector.yaml
> -
> -
> -Example:
> -
> -fusb302: typec-portc@54 {
> -       compatible = "fcs,fusb302";
> -       reg = <0x54>;
> -       interrupt-parent = <&nmi_intc>;
> -       interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -
> -       usb_con: connector {
> -               compatible = "usb-c-connector";
> -               label = "USB-C";
> -               power-role = "dual";
> -               try-power-role = "sink";
> -               source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> -               sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> -                            PDO_VAR(3000, 12000, 3000)
> -                            PDO_PPS_APDO(3000, 11000, 3000)>;
> -               op-sink-microwatt = <10000000>;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml b/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
> new file mode 100644
> index 000000000..9b172fda9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Fairchild FUSB302 Type-C Port controller
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>

Why me? I don't care, but that's kind of the default.

> +
> +properties:
> +  compatible:
> +    const: fcs,fusb302
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vbus-supply:
> +    description: VBUS power supply
> +
> +  connector:
> +    type: object
> +    $ref: /schemas/connector/usb-connector.yaml#

       unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vbus-supply
> +  - connector
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/usb/pd.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      fusb302: typec-portc@54 {

Drop unused labels.

> +        compatible = "fcs,fusb302";
> +        reg = <0x54>;
> +        interrupt-parent = <&nmi_intc>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +        vbus-supply = <&vbus_typec>;
> +
> +        usb_con: connector {
> +          compatible = "usb-c-connector";
> +          label = "USB-C";
> +          power-role = "dual";
> +          try-power-role = "sink";
> +          source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +          sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                       PDO_VAR(3000, 12000, 3000)
> +                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +          op-sink-microwatt = <10000000>;
> +        };
> +      };
> +    };
> --
> 2.20.1
>
