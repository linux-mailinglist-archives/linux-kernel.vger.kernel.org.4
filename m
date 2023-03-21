Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56CA6C3DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCUWbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCUWbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:31:19 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7FE21966;
        Tue, 21 Mar 2023 15:31:17 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id v17so2564000oic.5;
        Tue, 21 Mar 2023 15:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsrlirkyxxpf69cKGbaHdCbHdq2dWdqkX3HuFTW619Q=;
        b=AMXk6iIqMPgYEsVo1bhS8c+UCQ0PY2e8cngyuD1+zBH442l0P6ImEVNE2XZpEC//+Q
         XUhx3iYcg+bcTxZrGkRnW6a4SwxkkP6wf4RSVhlyFK40h1ec1GdOsu4n7EePrB/xFEnY
         FRfqeKBdVVQYDMwLTIgFn59F92wrmaczsMggRTAN67JIzpk2jYO1iAQ1ayrj1DGpXAq/
         GrE5MJb6/8sJymYDI2ll9fO2K1zi7PUIlwXu+HYbFgr+CGTlcFM7KlmULlz/NVcWJzja
         mJjHgMV5pClmMrSEgEhsw0tJdmeWWWF9MCfGRO7tm0gcHSVFH2ETiq/ZaHJdS8vzmCRz
         F6bg==
X-Gm-Message-State: AO0yUKUwa8DIHktBGzh9kF9mmyikGO5Au+kqJYQ+HNtnrtUDsrLFma9U
        Xlrlmu9hpdermPeL7CU63w==
X-Google-Smtp-Source: AK7set+mYB7Q/JHml2KJgMhM5FikDWiHf+dsJWBbPgwh1svqWXeEAeN4vf9oA0kW75C9kpFTw540qQ==
X-Received: by 2002:a05:6808:6298:b0:386:b9bd:d02b with SMTP id du24-20020a056808629800b00386b9bdd02bmr292292oib.52.1679437876552;
        Tue, 21 Mar 2023 15:31:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q130-20020acaf288000000b00383ef567cfdsm5225863oih.21.2023.03.21.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:31:15 -0700 (PDT)
Received: (nullmailer pid 1777814 invoked by uid 1000);
        Tue, 21 Mar 2023 22:31:14 -0000
Date:   Tue, 21 Mar 2023 17:31:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 02/10] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Message-ID: <20230321223114.GA1765051-robh@kernel.org>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
 <20230321085213.1624216-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321085213.1624216-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:52:05PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to DT schema format. To fix the dtbs_check
> error, some properties were also added, such as nvidia,phy, reset-names
> ulpi; missing compatibles are added.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 449 ++++++++++++++++++
>  2 files changed, 449 insertions(+), 159 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml


> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> new file mode 100644
> index 000000000000..758bebb1deaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> @@ -0,0 +1,449 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB2 ChipIdea USB controller
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
> +          - lsi,zevio-usb
> +          - nvidia,tegra20-ehci
> +          - nvidia,tegra20-udc
> +          - nvidia,tegra30-ehci
> +          - nvidia,tegra30-udc
> +          - nvidia,tegra114-udc
> +          - nvidia,tegra124-udc
> +          - qcom,ci-hdrc
> +      - items:
> +          - enum:
> +              - nvidia,tegra114-ehci
> +              - nvidia,tegra124-ehci
> +              - nvidia,tegra210-ehci
> +          - const: nvidia,tegra30-ehci
> +      - items:
> +          - enum:
> +              - fsl,imx23-usb
> +              - fsl,imx25-usb
> +              - fsl,imx28-usb
> +              - fsl,imx50-usb
> +              - fsl,imx51-usb
> +              - fsl,imx53-usb
> +              - fsl,imx6q-usb
> +              - fsl,imx6sl-usb
> +              - fsl,imx6sx-usb
> +              - fsl,imx6ul-usb
> +              - fsl,imx7d-usb
> +              - fsl,vf610-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - const: fsl,imx8dxl-usb
> +          - const: fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usb
> +              - fsl,imx8mn-usb
> +          - const: fsl,imx7d-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx6sll-usb
> +              - fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - const: xlnx,zynq-usb-2.20a
> +          - const: chipidea,usb2
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

Missing a type.

> +
> +  phy-clkgate-delay-us:
> +    description: |
> +      The delay time (us) between putting the PHY into low power mode and
> +      gating the PHY clock.

Drop '|'

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

Missing a type.

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
> +  operating-points-v2:
> +    description: A phandle to the OPP table containing the performance states.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  pinctrl-names:
> +    description: |
> +      Names for optional pin modes in "default", "host", "device".
> +      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
> +      In this case, the "idle" state needs to pull down the data and
> +      strobe pin and the "active" state needs to pull up the strobe pin.
> +    oneOf:
> +      - items:
> +          - const: idle
> +          - const: active
> +      - items:
> +          - const: default
> +          - enum:
> +              - host
> +              - device
> +      - items:
> +          - const: default
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
> +  phy-select:
> +    description:
> +      Phandler of TCSR node with two argument that indicate register
> +      offset, and phy index
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to TCSR node
> +          - description: register offset
> +          - description: phy index
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
> +    deprecated: true
> +
> +  nvidia,needs-double-reset:
> +    description: Indicates double reset or not.
> +    type: boolean
> +    deprecated: true
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

This if/then has no effect. The 'if' is true when mux-controls is not 
present. 'required: [ mux-controls ]' is what you should use to test 
property presence. The 'then' clause is just constraints you already 
have. If you just want to say mux-control-names is required with 
mux-controls, then use 'dependencies'.

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
