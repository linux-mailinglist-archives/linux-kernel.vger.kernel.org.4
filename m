Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9676729EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjARVFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjARVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:05:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F57E552B7;
        Wed, 18 Jan 2023 13:05:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v30so394531edb.9;
        Wed, 18 Jan 2023 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ef3zfxl9nq9fpHR8YJhBTRzp8G9GTQEeQ0zaoI0in1k=;
        b=g3hLpv7Z1JQbQcTCOWhvnbYvZXPv3oOlzX7j617cUcForw92WAN5hB9Nn7odi0Mjui
         9sECkGhrFNRzbA9SV2BuSjrDkb73s/xREDe+37gOFhdrcTuWw/2jwK5XI13sTiXTBh4K
         r1PYWglewDuOQL8jVrgoI0RzjLkjw6RuHh3xjXDJJVZQqK90Qx9eEl+JJ8+kqBBtKYpe
         e8PiUUQKqsH30n+GjuvE+oXbrSJpVk8wC/qm2e3EMLq5kZfGQY1ASbQQsyEp/stn7LVn
         Q0xafTzaCqKLvz7cY4K4WqysSskCD1hvWIGvHPVVsYAh45fZwcdoM9jbauWPqubc+cj2
         FkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef3zfxl9nq9fpHR8YJhBTRzp8G9GTQEeQ0zaoI0in1k=;
        b=GVFPQCY/58gFmiXF3lV2UkNI/KsTFWFmEVt56K80ZYps7MuX/9fe7noVS6rNbXVE/f
         3RdLgN3y8uHz546TIYdMioURNkr4UfHDt1Dh9FpbNb5gdJZ+quc6xsiBdvYyAi9oCEFw
         kyeH1WcKhCwwUAGjKjCa/GPq4LKcGX4TMkf68GuUoWvrJWiHuCzpZSdTrJ5G+1WuQn5h
         akFgkgnlxgm1+KEspADeEbF/QKYOvgPOK+iWqfHnpvfBKZz2hy+hYJc5k9ua2153CJCp
         HIY9V4H/GwzB4Zy4OI4p4YqawG05pB/SxEUpvJMf+0H2gn9QFUnlAIIGq/67tgtE4xay
         h3mQ==
X-Gm-Message-State: AFqh2koUUDC6Rkpyv4nKYhr7pZTAOttaSoOAq5kJHbjxZdupnM/p3xHN
        ambQ5QuucJ/TT0KwJzvZKM7M3vjxaiE=
X-Google-Smtp-Source: AMrXdXtcuOYIvH/iQIRSSRU+VfK6+1P8eGPecffrw9Lau3PtNqWB0uY32t/70biDCQaAYY6c5NeT+g==
X-Received: by 2002:a05:6402:60b:b0:470:25cf:99d1 with SMTP id n11-20020a056402060b00b0047025cf99d1mr8853875edv.31.1674075941977;
        Wed, 18 Jan 2023 13:05:41 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7da18000000b004704658abebsm14811229eds.54.2023.01.18.13.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:05:41 -0800 (PST)
Message-ID: <4eca2695-cb73-eaad-4c8a-82dec923825e@gmail.com>
Date:   Wed, 18 Jan 2023 22:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to
 its own schema
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118193056.673514-1-robh@kernel.org>
 <20230118193056.673514-2-robh@kernel.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230118193056.673514-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some alignment at the examples and the unknown extcon property.

usb@fe800000: 'extcon' does not match any of the regexes

Johan

On 1/18/23 20:30, Rob Herring wrote:
> The rockchip,dwc3.yaml schema defines a single DWC3 node, but the RK3399
> uses the discouraged parent wrapper node and child 'generic' DWC3 node.
> The intent was to modify the RK3399 DTs to use a single node, but the DT
> changes were rejected for ABI reasons. However, the schema was accepted
> as-is.
> 
> To fix this, we need to move the RK3399 binding to its own schema file.
> The RK3328 and RK3568 bindings are correct and use a single node.
> 
> Cc: Johan Jonker <jbx6244@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/usb/rockchip,dwc3.yaml           |  10 +-
>  .../bindings/usb/rockchip,rk3399-dwc3.yaml    | 115 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> index b3798d94d2fd..edb130c780e4 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -29,7 +29,6 @@ select:
>        contains:
>          enum:
>            - rockchip,rk3328-dwc3
> -          - rockchip,rk3399-dwc3
>            - rockchip,rk3568-dwc3
>    required:
>      - compatible
> @@ -39,7 +38,6 @@ properties:
>      items:
>        - enum:
>            - rockchip,rk3328-dwc3
> -          - rockchip,rk3399-dwc3
>            - rockchip,rk3568-dwc3
>        - const: snps,dwc3
>  
> @@ -90,7 +88,7 @@ required:
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/clock/rk3328-cru.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      bus {
> @@ -98,11 +96,11 @@ examples:
>        #size-cells = <2>;
>  
>        usbdrd3_0: usb@fe800000 {
> -        compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
> +        compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
>          reg = <0x0 0xfe800000 0x0 0x100000>;
>          interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> -        clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> -                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
> +        clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,

> +                <&cru ACLK_USB3OTG>;

align

>          clock-names = "ref_clk", "suspend_clk",
>                        "bus_clk", "grf_clk";
>          dr_mode = "otg";
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> new file mode 100644
> index 000000000000..e39a8a3a7ab3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3399 SuperSpeed DWC3 USB SoC controller
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3399-dwc3
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  ranges: true
> +
> +  clocks:
> +    items:
> +      - description:
> +          Controller reference clock, must to be 24 MHz
> +      - description:
> +          Controller suspend clock, must to be 24 MHz or 32 KHz
> +      - description:
> +          Master/Core clock, must to be >= 62.5 MHz for SS
> +          operation and >= 30MHz for HS operation
> +      - description:
> +          USB3 aclk peri
> +      - description:
> +          USB3 aclk
> +      - description:
> +          Controller grf clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +      - const: suspend_clk
> +      - const: bus_clk
> +      - const: aclk_usb3_rksoc_axi_perf
> +      - const: aclk_usb3
> +      - const: grf_clk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: usb3-otg
> +
> +patternProperties:
> +  '^usb@':
> +    $ref: snps,dwc3.yaml#
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/power/rk3399-power.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        usb {
> +            compatible = "rockchip,rk3399-dwc3";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +            clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,

> +              <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> +              <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;

align

> +            clock-names = "ref_clk", "suspend_clk",

> +                    "bus_clk", "aclk_usb3_rksoc_axi_perf",
> +                    "aclk_usb3", "grf_clk";

align

> +            resets = <&cru SRST_A_USB3_OTG0>;
> +            reset-names = "usb3-otg";
> +
> +            usb@fe800000 {
> +                compatible = "snps,dwc3";
> +                reg = <0x0 0xfe800000 0x0 0x100000>;
> +                interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> +                clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,

> +                  <&cru SCLK_USB3OTG0_SUSPEND>;

align

> +                clock-names = "ref", "bus_early", "suspend";
> +                dr_mode = "otg";
> +                phys = <&u2phy0_otg>, <&tcphy0_usb3>;
> +                phy-names = "usb2-phy", "usb3-phy";
> +                phy_type = "utmi_wide";
> +                snps,dis_enblslpm_quirk;
> +                snps,dis-u2-freeclk-exists-quirk;
> +                snps,dis_u2_susphy_quirk;
> +                snps,dis-del-phy-power-chg-quirk;
> +                snps,dis-tx-ipgap-linecheck-quirk;
> +                power-domains = <&power RK3399_PD_USB3>;
> +            };
> +        };
> +    };
> +...
