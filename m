Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13C76A4CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjB0VRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjB0VQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:16:57 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA0F29149;
        Mon, 27 Feb 2023 13:16:53 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1720600a5f0so8785242fac.11;
        Mon, 27 Feb 2023 13:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0zqXrzypjOqeYXfNJt8mRfFg9YBOQ25dYrBw7qJMy4=;
        b=GmELsvIj+oKduslmnfjUm3L9l7pZmGae0fRJwZsmXuuH0wdwpnJO8oI17gel5DP+7h
         a6ydk5lgaFn4tT72o1A5CO9wLXOSGw/lMCkAIDW0waFgO4OiYKWlM+Fo4IlxSfAiF7QL
         2bIxQE8z70UOCGEGA1lAFK+pfIEyW0kLBkEYC+k0yLMh0e4AZpuHcNT6RG4O8OQLXFZy
         KY3NMZDtAPVDHRQjf+Y31AgejALbBbdPsHr5HUTXBpqctHrerH2HGPEVHVq3CY7mtnkf
         97b8+w5K1/DY4bDOJ5PuXYtp/JFRygtN8mLYnueJ1GxTMWpz5HTXTiAmgLWdvlYhsxo8
         nYeQ==
X-Gm-Message-State: AO0yUKXTrorbw43D85hJVspokl6G2DDBj1nzW3N9x+yXT7J1OFURayn+
        bvaGKvyKjlDZaM5FWKsbCw==
X-Google-Smtp-Source: AK7set8LNhBekm3ZAN6Fk38EgEC6Z2DstbXq00W/iSCpHUVnXPOjtvnKHZzzGwiT/OTcFuX2fptINw==
X-Received: by 2002:a05:6870:61cc:b0:172:899d:97c0 with SMTP id b12-20020a05687061cc00b00172899d97c0mr72529oah.44.1677532613029;
        Mon, 27 Feb 2023 13:16:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a056870530500b0016e8726f0d4sm2696026oan.3.2023.02.27.13.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:16:52 -0800 (PST)
Received: (nullmailer pid 991954 invoked by uid 1000);
        Mon, 27 Feb 2023 21:16:51 -0000
Date:   Mon, 27 Feb 2023 15:16:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/7] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Message-ID: <20230227211651.GA896532-robh@kernel.org>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
 <20230226130539.277336-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226130539.277336-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 09:05:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to DT schema format. To fix the dtbs_check
> error, some properties were also added, such as nvidia,phy, reset-names
> ulpi.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 408 ++++++++++++++++++
>  2 files changed, 408 insertions(+), 159 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> new file mode 100644
> index 000000000000..b30ed11fa22f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> @@ -0,0 +1,408 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB2 ChipIdea USB controller for ci13xxx Binding

Drop ' for ci13xxx Binding'

> +
> +maintainers:
> +  - Xu Yang <xu.yang_2@nxp.com>
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - chipidea,usb2
> +          - fsl,imx7ulp-usb
> +          - lsi,zevio-usb
> +          - nvidia,tegra20-udc
> +          - nvidia,tegra30-udc
> +          - nvidia,tegra114-udc
> +          - nvidia,tegra124-udc
> +          - qcom,ci-hdrc
> +      - items:
> +          - enum:
> +              - fsl,imx23-usb
> +              - fsl,imx25-usb
> +              - fsl,imx28-usb
> +              - fsl,imx6q-usb
> +              - fsl,imx6sl-usb
> +              - fsl,imx6sx-usb
> +              - fsl,imx6ul-usb
> +              - fsl,imx7d-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - const: fsl,imx8mm-usb
> +          - const: fsl,imx7d-usb

But not compatible with imx27?

> +      - items:
> +          - const: fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +      - items:
> +          - const: xlnx,zynq-usb-2.20a
> +          - const: chipidea,usb2
> +

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Defined in usb-hcd.yaml, so drop.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dr_mode: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  phy_type: true
> +
> +  itc-setting:
> +    description:
> +      interrupt threshold control register control, the setting should be
> +      aligned with ITC bits at register USBCMD.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ahb-burst-config:
> +    description:
> +      it is vendor dependent, the required value should be aligned with
> +      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property is
> +      used to change AHB burst configuration, check the chipidea spec for
> +      meaning of each value. If this property is not existed, it will use
> +      the reset value.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x7
> +
> +  tx-burst-size-dword:
> +    description:
> +      it is vendor dependent, the tx burst size in dword (4 bytes), This
> +      register represents the maximum length of a the burst in 32-bit
> +      words while moving data from system memory to the USB bus, the value
> +      of this property will only take effect if property "ahb-burst-config"
> +      is set to 0, if this property is missing the reset default of the
> +      hardware implementation will be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x20
> +
> +  rx-burst-size-dword:
> +    description:
> +      it is vendor dependent, the rx burst size in dword (4 bytes), This
> +      register represents the maximum length of a the burst in 32-bit words
> +      while moving data from the USB bus to system memory, the value of
> +      this property will only take effect if property "ahb-burst-config"
> +      is set to 0, if this property is missing the reset default of the
> +      hardware implementation will be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x20
> +
> +  extcon:
> +    description: |
> +      Phandles to external connector devices. First phandle should point
> +      to external connector, which provide "USB" cable events, the second
> +      should point to external connector device, which provide "USB-HOST"
> +      cable events. If one of the external connector devices is not
> +      required, empty <0> phandle should be specified.
> +
> +  phy-clkgate-delay-us:
> +    description: |
> +      The delay time (us) between putting the PHY into low power mode and
> +      gating the PHY clock.
> +
> +  non-zero-ttctrl-ttha:
> +    description: |
> +      After setting this property, the value of register ttctrl.ttha
> +      will be 0x7f; if not, the value will be 0x0, this is the default
> +      value. It needs to be very carefully for setting this property, it
> +      is recommended that consult with your IC engineer before setting
> +      this value.  On the most of chipidea platforms, the "usage_tt" flag
> +      at RTL is 0, so this property only affects siTD.
> +
> +      If this property is not set, the max packet size is 1023 bytes, and
> +      if the total of packet size for pervious transactions are more than
> +      256 bytes, it can't accept any transactions within this frame. The
> +      use case is single transaction, but higher frame rate.
> +
> +      If this property is set, the max packet size is 188 bytes, it can
> +      handle more transactions than above case, it can accept transactions
> +      until it considers the left room size within frame is less than 188
> +      bytes, software needs to make sure it does not send more than 90%
> +      maximum_periodic_data_per_frame. The use case is multiple
> +      transactions, but less frame rate.
> +
> +  mux-controls:
> +    description: |
> +      The mux control for toggling host/device output of this controller.
> +      It's expected that a mux state of 0 indicates device mode and a mux
> +      state of 1 indicates host mode.
> +    maxItems: 1
> +
> +  mux-control-names:
> +    const: usb_switch
> +
> +  pinctrl-names:
> +    description: |
> +      Names for optional pin modes in "default", "host", "device".
> +      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
> +      In this case, the "idle" state needs to pull down the data and
> +      strobe pin and the "active" state needs to pull up the strobe pin.

items:
  enum: [ default, host, device, idle, active ]

> +
> +  pinctrl-0:
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: usb-phy
> +
> +  vbus-supply:
> +    description: reference to the VBUS regulator.
> +
> +  fsl,usbmisc:
> +    description:
> +      Phandler of non-core register device, with one argument that
> +      indicate usb controller index
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to usbmisc node
> +          - description: index of usb controller
> +
> +  fsl,anatop:
> +    description: phandle for the anatop node.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  disable-over-current:
> +    type: boolean
> +    description: disable over current detect
> +
> +  over-current-active-low:
> +    type: boolean
> +    description: over current signal polarity is active low
> +
> +  over-current-active-high:
> +    type: boolean
> +    description: |
> +      Over current signal polarity is active high. It's recommended to
> +      specify the over current polarity.
> +
> +  power-active-high:
> +    type: boolean
> +    description: power signal polarity is active high
> +
> +  external-vbus-divider:
> +    type: boolean
> +    description: enables off-chip resistor divider for Vbus
> +
> +  samsung,picophy-pre-emp-curr-control:
> +    description: |
> +      HS Transmitter Pre-Emphasis Current Control. This signal controls
> +      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
> +      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
> +      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
> +      bits of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x3
> +
> +  samsung,picophy-dc-vol-level-adjust:
> +    description: |
> +      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
> +      level voltage. The range is from 0x0 to 0xf, the default value is
> +      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0xf
> +
> +  usb-phy:
> +    description: phandle for the PHY device. Use "phys" instead.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    deprecated: true
> +
> +  fsl,usbphy:
> +    description: phandle of usb phy that connects to the port. Use "phys" instead.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    deprecated: true
> +
> +  nvidia,phy:
> +    description: phandle of usb phy that connects to the port. Use "phys" instead.
> +    $ref: /schemas/types.yaml#/definitions/phandle

       deprecated: true

> +
> +  port:
> +    description:
> +      Any connector to the data bus of this controller should be modelled
> +      using the OF graph bindings specified, if the "usb-role-switch"
> +      property is used.
> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ulpi:
> +    type: object
> +    properties:
> +      phy:
> +        description: The phy child node for Qcom chips.
> +        type: object
> +        $ref: /schemas/phy/qcom,usb-hs-phy.yaml
> +

> +patternProperties:
> +  "^.*@[0-9a-f]{1,2}$":
> +    description: The hard wired USB devices
> +    type: object
> +    $ref: /schemas/usb/usb-device.yaml

Defined in usb-hcd.yaml, so drop.

> +
> +dependencies:
> +  port: [ usb-role-switch ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: usb-hcd.yaml#
> +  - $ref: usb-drd.yaml#
> +  - if:
> +      properties:
> +        mux-controls:
> +          true
> +    then:
> +      properties:
> +        mux-control-names:
> +          const: usb_switch
> +  - if:
> +      properties:
> +        phy_type:
> +          const: hsic
> +      required:
> +        - phy_type
> +    then:
> +      properties:
> +        pinctrl-names:
> +          items:
> +            - const: idle
> +            - const: active
> +    else:
> +      properties:
> +        pinctrl-names:
> +          minItems: 1
> +          maxItems: 2
> +          oneOf:
> +            - items:
> +                - const: default
> +                - enum:
> +                    - host
> +                    - device
> +            - items:
> +                - const: default
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - chipidea,usb2
> +              - lsi,zevio-usb
> +              - nvidia,tegra20-udc
> +              - nvidia,tegra30-udc
> +              - nvidia,tegra114-udc
> +              - nvidia,tegra124-udc
> +              - qcom,ci-hdrc
> +              - xlnx,zynq-usb-2.20a
> +    then:
> +      properties:
> +        fsl,usbmisc: false
> +        disable-over-current: false
> +        over-current-active-low: false
> +        over-current-active-high: false
> +        power-active-high: false
> +        external-vbus-divider: false
> +        samsung,picophy-pre-emp-curr-control: false
> +        samsung,picophy-dc-vol-level-adjust: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/berlin2.h>
> +
> +    usb@f7ed0000 {
> +        compatible = "chipidea,usb2";
> +        reg = <0xf7ed0000 0x10000>;
> +        interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&chip CLKID_USB0>;
> +        phys = <&usb_phy0>;
> +        phy-names = "usb-phy";
> +        vbus-supply = <&reg_usb0_vbus>;
> +        itc-setting = <0x4>; /* 4 micro-frames */
> +         /* Incremental burst of unspecified length */
> +        ahb-burst-config = <0x0>;
> +        tx-burst-size-dword = <0x10>; /* 64 bytes */
> +        rx-burst-size-dword = <0x10>;
> +        extcon = <0>, <&usb_id>;
> +        phy-clkgate-delay-us = <400>;
> +        mux-controls = <&usb_switch>;
> +        mux-control-names = "usb_switch";
> +    };
> +
> +  # Example for HSIC:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx6qdl-clock.h>
> +
> +    usb@2184400 {
> +        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
> +        reg = <0x02184400 0x200>;
> +        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +        fsl,usbphy = <&usbphynop1>;
> +        fsl,usbmisc = <&usbmisc 2>;
> +        phy_type = "hsic";
> +        dr_mode = "host";
> +        ahb-burst-config = <0x0>;
> +        tx-burst-size-dword = <0x10>;
> +        rx-burst-size-dword = <0x10>;
> +        pinctrl-names = "idle", "active";
> +        pinctrl-0 = <&pinctrl_usbh2_idle>;
> +        pinctrl-1 = <&pinctrl_usbh2_active>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet@1 {
> +            compatible = "usb424,9730";
> +            reg = <1>;
> +        };
> +    };
> +
> +...
> -- 
> 2.37.1
> 
