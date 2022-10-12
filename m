Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547195FC65C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJLNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJLNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:24:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF353A54
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:24:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r19so1913972qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XO8fv91Nboj+QSUSC+7VOc7gIOkXQQhYDgybEBdQTW4=;
        b=xofxExgXhCkyGBeFhL0UTec6L8MEyYCmNn3yv513JFjKtKyD+gctKUUkn/5DeuUv7M
         0Hs51rT+06IwX3E+txvkddpyi855DCbZCJaSiAsnIxEdHVX6aUjUkTi3WppmUr7LFtcr
         mdtT0fIOoqZ0/gJRC27KxceWYrrUXWsvufZFFBznB1hZAns9agR77HfOmloecGEt2FSV
         4cTyJzjSLQL8QwZbUgHQq+ZqbBN2f2TxZ9DelH0QB+MkLO+CiH579JhA8DVgrWAjc1UN
         LzlAaVPSEvNNABNoetuRlMv/6sFuqu88rmNhnmM1tHmeuwhzV26pS/65QHwGHHHvUPxV
         PxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XO8fv91Nboj+QSUSC+7VOc7gIOkXQQhYDgybEBdQTW4=;
        b=f4C/7ZWPpVLkTc1z/F/wthiQIMZtJhUUGzwWonMe0FNf2hpWROXSF49wAFGi2i4vyp
         p7d5jMvlKTDCS4x461i6q7w2oN1SZOlyzNZXoi1sx7KD+AtCV/qqQN2zkeHLT+GhJduN
         wh77p5uJWJjpFZgz8fhNPXt6qA0A+q3zecslCpDI02rU70Tl/RqPbQaFYg7FYyUkLfls
         sqACrubPgjovdhxtMQ+dPwB5eS5kU7ENnWWFW4MLGXML2BysKQIGQa9u0ZJIBGq4+hdt
         lJhqFSGQIB36rCKDDvnHOaDY5A8ut6jFW78qrIt2BXn2kCm9jPfkrj1KReWOhlYbYYR0
         x6eg==
X-Gm-Message-State: ACrzQf0Y6Z+vhhqzYQKY1DQAdDtmRJOADoEXy2JR8ldqPDlsnr7skpKM
        rWmkDB2tF86cavqMH5/g0MxjjA==
X-Google-Smtp-Source: AMsMyM5rnEX15Z1RLEwRMyybSW6Dhy2pbwt5tDVfTSgopiVOjLgh6QC8kXD9COu7ClBrlVe04u16ng==
X-Received: by 2002:a05:622a:513:b0:396:378a:f0e4 with SMTP id l19-20020a05622a051300b00396378af0e4mr21137319qtx.515.1665581052651;
        Wed, 12 Oct 2022 06:24:12 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a0e9500b006ed138e89f2sm7863598qkm.123.2022.10.12.06.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:24:11 -0700 (PDT)
Message-ID: <14d359c6-8cfc-c426-f264-1dbf79d1f09e@linaro.org>
Date:   Wed, 12 Oct 2022 09:24:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010101816.298334-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 06:18, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to yaml format
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 306 ++++++++++++++++++
>  2 files changed, 306 insertions(+), 158 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> deleted file mode 100644
> index ba51fb1252b9..000000000000
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -* USB2 ChipIdea USB controller for ci13xxx
> -
> -Required properties:
> -- compatible: should be one of:
> -	"fsl,imx23-usb"
> -	"fsl,imx27-usb"
> -	"fsl,imx28-usb"
> -	"fsl,imx6q-usb"
> -	"fsl,imx6sl-usb"
> -	"fsl,imx6sx-usb"
> -	"fsl,imx6ul-usb"
> -	"fsl,imx7d-usb"
> -	"fsl,imx7ulp-usb"
> -	"lsi,zevio-usb"
> -	"qcom,ci-hdrc"
> -	"chipidea,usb2"
> -	"xlnx,zynq-usb-2.20a"
> -	"nvidia,tegra20-udc"
> -	"nvidia,tegra30-udc"
> -	"nvidia,tegra114-udc"
> -	"nvidia,tegra124-udc"
> -- reg: base address and length of the registers
> -- interrupts: interrupt for the USB controller
> -
> -Recommended properies:
> -- phy_type: the type of the phy connected to the core. Should be one
> -  of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
> -  property the PORTSC register won't be touched.
> -- dr_mode: One of "host", "peripheral" or "otg". Defaults to "otg"
> -
> -Deprecated properties:
> -- usb-phy:      phandle for the PHY device. Use "phys" instead.
> -- fsl,usbphy: phandle of usb phy that connects to the port. Use "phys" instead.
> -
> -Optional properties:
> -- clocks: reference to the USB clock
> -- phys: reference to the USB PHY
> -- phy-names: should be "usb-phy"
> -- vbus-supply: reference to the VBUS regulator
> -- maximum-speed: limit the maximum connection speed to "full-speed".
> -- tpl-support: TPL (Targeted Peripheral List) feature for targeted hosts
> -- itc-setting: interrupt threshold control register control, the setting
> -  should be aligned with ITC bits at register USBCMD.
> -- ahb-burst-config: it is vendor dependent, the required value should be
> -  aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This
> -  property is used to change AHB burst configuration, check the chipidea
> -  spec for meaning of each value. If this property is not existed, it
> -  will use the reset value.
> -- tx-burst-size-dword: it is vendor dependent, the tx burst size in dword
> -  (4 bytes), This register represents the maximum length of a the burst
> -  in 32-bit words while moving data from system memory to the USB
> -  bus, the value of this property will only take effect if property
> -  "ahb-burst-config" is set to 0, if this property is missing the reset
> -  default of the hardware implementation will be used.
> -- rx-burst-size-dword: it is vendor dependent, the rx burst size in dword
> -  (4 bytes), This register represents the maximum length of a the burst
> -  in 32-bit words while moving data from the USB bus to system memory,
> -  the value of this property will only take effect if property
> -  "ahb-burst-config" is set to 0, if this property is missing the reset
> -  default of the hardware implementation will be used.
> -- extcon: phandles to external connector devices. First phandle should point to
> -  external connector, which provide "USB" cable events, the second should point
> -  to external connector device, which provide "USB-HOST" cable events. If one
> -  of the external connector devices is not required, empty <0> phandle should
> -  be specified.
> -- phy-clkgate-delay-us: the delay time (us) between putting the PHY into
> -  low power mode and gating the PHY clock.
> -- non-zero-ttctrl-ttha: after setting this property, the value of register
> -  ttctrl.ttha will be 0x7f; if not, the value will be 0x0, this is the default
> -  value. It needs to be very carefully for setting this property, it is
> -  recommended that consult with your IC engineer before setting this value.
> -  On the most of chipidea platforms, the "usage_tt" flag at RTL is 0, so this
> -  property only affects siTD.
> -  If this property is not set, the max packet size is 1023 bytes, and if
> -  the total of packet size for pervious transactions are more than 256 bytes,
> -  it can't accept any transactions within this frame. The use case is single
> -  transaction, but higher frame rate.
> -  If this property is set, the max packet size is 188 bytes, it can handle
> -  more transactions than above case, it can accept transactions until it
> -  considers the left room size within frame is less than 188 bytes, software
> -  needs to make sure it does not send more than 90%
> -  maximum_periodic_data_per_frame. The use case is multiple transactions, but
> -  less frame rate.
> -- mux-controls: The mux control for toggling host/device output of this
> -  controller. It's expected that a mux state of 0 indicates device mode and a
> -  mux state of 1 indicates host mode.
> -- mux-control-names: Shall be "usb_switch" if mux-controls is specified.
> -- pinctrl-names: Names for optional pin modes in "default", "host", "device".
> -  In case of HSIC-mode, "idle" and "active" pin modes are mandatory. In this
> -  case, the "idle" state needs to pull down the data and strobe pin
> -  and the "active" state needs to pull up the strobe pin.
> -- pinctrl-n: alternate pin modes
> -
> -i.mx specific properties
> -- fsl,usbmisc: phandler of non-core register device, with one
> -  argument that indicate usb controller index
> -- disable-over-current: disable over current detect
> -- over-current-active-low: over current signal polarity is active low.
> -- over-current-active-high: over current signal polarity is active high.
> -  It's recommended to specify the over current polarity.
> -- power-active-high: power signal polarity is active high
> -- external-vbus-divider: enables off-chip resistor divider for Vbus
> -- samsung,picophy-pre-emp-curr-control: HS Transmitter Pre-Emphasis Current
> -  Control. This signal controls the amount of current sourced to the
> -  USB_OTG*_DP and USB_OTG*_DN pins after a J-to-K or K-to-J transition.
> -  The range is from 0x0 to 0x3, the default value is 0x1.
> -  Details can refer to TXPREEMPAMPTUNE0 bits of USBNC_n_PHY_CFG1.
> -- samsung,picophy-dc-vol-level-adjust: HS DC Voltage Level Adjustment.
> -  Adjust the high-speed transmitter DC level voltage.
> -  The range is from 0x0 to 0xf, the default value is 0x3.
> -  Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> -
> -Example:
> -
> -	usb@f7ed0000 {
> -		compatible = "chipidea,usb2";
> -		reg = <0xf7ed0000 0x10000>;
> -		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&chip CLKID_USB0>;
> -		phys = <&usb_phy0>;
> -		phy-names = "usb-phy";
> -		vbus-supply = <&reg_usb0_vbus>;
> -		itc-setting = <0x4>; /* 4 micro-frames */
> -		 /* Incremental burst of unspecified length */
> -		ahb-burst-config = <0x0>;
> -		tx-burst-size-dword = <0x10>; /* 64 bytes */
> -		rx-burst-size-dword = <0x10>;
> -		extcon = <0>, <&usb_id>;
> -		phy-clkgate-delay-us = <400>;
> -		mux-controls = <&usb_switch>;
> -		mux-control-names = "usb_switch";
> -	};
> -
> -Example for HSIC:
> -
> -	usb@2184400 {
> -		compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
> -		reg = <0x02184400 0x200>;
> -		interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clks IMX6QDL_CLK_USBOH3>;
> -		fsl,usbphy = <&usbphynop1>;
> -		fsl,usbmisc = <&usbmisc 2>;
> -		phy_type = "hsic";
> -		dr_mode = "host";
> -		ahb-burst-config = <0x0>;
> -		tx-burst-size-dword = <0x10>;
> -		rx-burst-size-dword = <0x10>;
> -		pinctrl-names = "idle", "active";
> -		pinctrl-0 = <&pinctrl_usbh2_idle>;
> -		pinctrl-1 = <&pinctrl_usbh2_active>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		usbnet: ethernet@1 {
> -			compatible = "usb424,9730";
> -			reg = <1>;
> -		};
> -	};
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

You already have this in first enum.

> +      - items:
> +          - const: xlnx,zynq-usb-2.20a
> +          - const: chipidea,usb2
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +  

Your patches have several white-space issues.

Don't send patches which fail checkpatch.

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

Just define the item here.

> +
> +  pinctrl-names:
> +    description: |
> +      Names for optional pin modes in "default", "host", "device".
> +      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
> +      In this case, the "idle" state needs to pull down the data and
> +      strobe pin and the "active" state needs to pull up the strobe pin.

Describe the items. Otherwise this does not make much sense, because
core allows it.

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

What's the type? Which other schema defined it?

Same applies to several other properties - are you sure they are already
defined by some other schema?
> +...

Best regards,
Krzysztof

