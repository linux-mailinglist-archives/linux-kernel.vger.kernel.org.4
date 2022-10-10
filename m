Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7715F9E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiJJMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiJJMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:12:38 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE85E67E;
        Mon, 10 Oct 2022 05:12:33 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so7836939oop.3;
        Mon, 10 Oct 2022 05:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqnTrL5Hj6yMqMTo0warAGK9EdOo2WjxQ8RQXQ1IhUU=;
        b=KORCjmkBZjH/OJrZKHXsfS1Tc4JaV+5D3ry6tNYiawxWkXkPOx38PAWoLJwb7XF2YN
         DlmcXh4OnOyzLxTex3ilivgQbA1XEH6od/31F/XovnAJypEhwN6jAmsLBX3wJXghc2tH
         jYxpCeHcxHBBPX2PT5WvZBRkUxDsU9KDv0F9YZsrsd27UUSBBddvcgOdf4Vqr680ONpy
         1H2AvXy4fzDCewvPJSICOMjYg6HKaD6hUaEOs+DsyktTNluiQfVndbTovQ9NqPV4ZqAq
         HhvRKPJ76tiWjZ6xECM1VlTF25EzDICMBmF7qDZMB439DDIyy++UF3oVU41BSa5oVlEB
         s5IQ==
X-Gm-Message-State: ACrzQf1B32Wt/JQ+m3WM8FIU3lSLNGlYy5XjiLbDD7xT6fWyNXTSzlJg
        JZlJwVgqOqbAZQCLmarNEA==
X-Google-Smtp-Source: AMsMyM773+78otousObz6fxwB21h85/1yjMBBCV+KW4lcuX/tgXkocLWvb5O29IiXQBthryhW+ClDQ==
X-Received: by 2002:a4a:9586:0:b0:448:5e55:a122 with SMTP id o6-20020a4a9586000000b004485e55a122mr6837401ooi.61.1665403952606;
        Mon, 10 Oct 2022 05:12:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r30-20020a056808211e00b00353ee26984esm4264322oiw.27.2022.10.10.05.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:12:32 -0700 (PDT)
Received: (nullmailer pid 424678 invoked by uid 1000);
        Mon, 10 Oct 2022 12:12:33 -0000
Date:   Mon, 10 Oct 2022 07:12:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Message-ID: <20221010121233.GA419967-robh@kernel.org>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010101816.298334-2-peng.fan@oss.nxp.com>
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

On Mon, Oct 10, 2022 at 06:18:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to yaml format

s/yaml/DT schema/

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 306 ++++++++++++++++++
>  2 files changed, 306 insertions(+), 158 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml

> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> new file mode 100644
> index 000000000000..1c10691c45f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> @@ -0,0 +1,306 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB2 ChipIdea USB controller for ci13xxx Binding
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - chipidea,usb2
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
> +          - const: fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +      - items:
> +          - const: lsi,zevio-usb
> +      - items:
> +          - const: xlnx,zynq-usb-2.20a
> +          - const: chipidea,usb2
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +  
> +  clocks:
> +    maxItems: 2
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
> +
> +  mux-control-names:
> +    description: Shall be "usb_switch" if mux-controls is specified.
> +
> +  pinctrl-names:
> +    description: |
> +      Names for optional pin modes in "default", "host", "device".
> +      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
> +      In this case, the "idle" state needs to pull down the data and
> +      strobe pin and the "active" state needs to pull up the strobe pin.
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
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: usb-drd.yaml#
> +  - $ref: usb-hcd.yaml#
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
> +
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
> +          enum:
> +            - fsl,imx23-usb
> +            - fsl,imx25-usb
> +            - fsl,imx27-usb
> +            - fsl,imx28-usb
> +            - fsl,imx6q-usb
> +            - fsl,imx6sl-usb
> +            - fsl,imx6sx-usb
> +            - fsl,imx6ul-usb
> +            - fsl,imx7d-usb
> +            - fsl,imx7ulp-usb
> +    then:
> +      properties:
> +        fsl,usbmisc: 
> +          description:
> +            Phandler of non-core register device, with one argument that
> +            indicate usb controller index

type ref?

Don't define properties within if/then/else. Define at top level and 
then restrict presence in the if/then schema.

> +
> +        disable-over-current:
> +          description: disable over current detect
> +
> +        over-current-active-low:
> +          description: over current signal polarity is active low
> +
> +        over-current-active-high:
> +          description: |
> +            Over current signal polarity is active high. It's recommended to
> +            specify the over current polarity.
> +
> +        power-active-high:
> +          description: power signal polarity is active high
> +
> +        external-vbus-divider:
> +          description: enables off-chip resistor divider for Vbus
> +
> +        samsung,picophy-pre-emp-curr-control:
> +          description: |
> +            HS Transmitter Pre-Emphasis Current Control. This signal controls
> +            the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
> +            pins after a J-to-K or K-to-J transition. The range is from 0x0 to
> +            0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
> +            bits of USBNC_n_PHY_CFG1.
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          minimum: 0x0
> +          maximum: 0x3
> +
> +        samsung,picophy-dc-vol-level-adjust:
> +          description: |
> +            HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
> +            level voltage. The range is from 0x0 to 0xf, the default value is
> +            0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          minimum: 0x0
> +          maximum: 0xf
> +
> +additionalProperties: true

Cannot be true.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/berlin2.h>
> +
> +    usb@f7ed0000 {
> +        compatible = "chipidea,usb2";

Doesn't match documentation. You should know by now to test your 
bindings.

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
> +        usbnet: ethernet@1 {
> +            compatible = "usb424,9730";
> +            reg = <1>;
> +        };
> +    };
> +
> +...
> -- 
> 2.37.1
> 
> 
