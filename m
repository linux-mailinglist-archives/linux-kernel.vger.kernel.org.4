Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5B650A85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiLSLBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiLSLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:01:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95517213
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 03:01:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id y25so13054135lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9TiKFq5dq+t/y/OEuShbJ7inw5lT2gdllgnKZs9p38=;
        b=tV+hDIKitEbNl6RBh1+KFoZbFWmVqn6USwBvi4LJxZ/AhZR47+Fo9j35aIrTpcfj6l
         /NwZP/o2r+FEQIn+WLTbuhLp5OdaPQ1whvHGTug57Q3Pvp1Y0WB+E3bzBPyTOdplbz3h
         CzlgQQrBR09J8fvHU1G94ccNK14TGwfZUzD878MDbs3crYdN44c5IcJrRAc++Kl0wKJz
         wuTdhbO9KL3QrNB+LmuL3R5aW+KU2aO9LNeXViYEX8mpK3/2QaafseaVdkFgLwkzEl+g
         xsHqyDMm84eMsh8SsmCQLsrpN3wVDNIGk759Z3IapoSOfDhMjUEgNhf5cknIQ74y5Imq
         k+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9TiKFq5dq+t/y/OEuShbJ7inw5lT2gdllgnKZs9p38=;
        b=JdKcE1XBWZZoQHgZde3CbTVpNwmee4/y4WmpoBofzQr2BT7aaazddHkZVxqrjxF87J
         eKlNMpJdPFTrKPEeDiyK3iClnZXLrrC5FabHKmtvPH3NUVUm8YXZIKt32pu2IvjHz4mz
         VYFmvS/Bic6uqyeSQ4i6inGzY8hJquFpdH4pg2Q/92oiRe70yS/XEVHXTT8uk+oLtPyu
         j5zHhXdoVASlXNrorUn9e3uWEvlKHDMrhV4lS+vaP8N93/LIiCSArlohyfxahOjdQcl/
         DYpv3alONJlNZO831MFZsC+2HEE1XFH1Tba3P6VQeqvc3McQjMfurdmppjYFRNts1eFR
         sesw==
X-Gm-Message-State: ANoB5pmValQKce6atbPghQEI6cmvEu+C5D2FAekbw99vlmOn6/SioS/0
        A1gWzml89q8cyFILNxfyGRJOCg==
X-Google-Smtp-Source: AA0mqf4H1M8wwTE+G1mBusCirNh1t+02owUspJmFP8vDHOct+sqr1eLVg1rG1TUYsFeKwxmO8FJFaQ==
X-Received: by 2002:a05:6512:b89:b0:4b5:98bc:194c with SMTP id b9-20020a0565120b8900b004b598bc194cmr16119569lfv.63.1671447661907;
        Mon, 19 Dec 2022 03:01:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d20-20020a056512369400b0049ae3ed42e8sm1062948lfs.180.2022.12.19.03.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 03:01:01 -0800 (PST)
Message-ID: <ad1a74be-c32c-522d-8183-1079e3ce7b80@linaro.org>
Date:   Mon, 19 Dec 2022 12:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <dea33013-ae1b-a8b2-5287-68a52f5ce028@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dea33013-ae1b-a8b2-5287-68a52f5ce028@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2022 16:23, Johan Jonker wrote:
> Convert rockchip-lvds.txt to YAML.
> 
> Changed:
>   Add power-domains property.
>   Requirements between PX30 and RK3288
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   Fix title
> ---
>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>  .../display/rockchip/rockchip-lvds.yaml       | 157 ++++++++++++++++++
>  2 files changed, 157 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> deleted file mode 100644
> index aaf8c44cf..000000000
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -Rockchip RK3288 LVDS interface
> -================================
> -
> -Required properties:
> -- compatible: matching the soc type, one of
> -	- "rockchip,rk3288-lvds";
> -	- "rockchip,px30-lvds";
> -
> -- reg: physical base address of the controller and length
> -	of memory mapped region.
> -- clocks: must include clock specifiers corresponding to entries in the
> -	clock-names property.
> -- clock-names: must contain "pclk_lvds"
> -
> -- avdd1v0-supply: regulator phandle for 1.0V analog power
> -- avdd1v8-supply: regulator phandle for 1.8V analog power
> -- avdd3v3-supply: regulator phandle for 3.3V analog power
> -
> -- rockchip,grf: phandle to the general register files syscon
> -- rockchip,output: "rgb", "lvds" or "duallvds", This describes the output interface
> -
> -- phys: LVDS/DSI DPHY (px30 only)
> -- phy-names: name of the PHY, must be "dphy" (px30 only)
> -
> -Optional properties:
> -- pinctrl-names: must contain a "lcdc" entry.
> -- pinctrl-0: pin control group to be used for this controller.
> -
> -Required nodes:
> -
> -The lvds has two video ports as described by
> -	Documentation/devicetree/bindings/media/video-interfaces.txt
> -Their connections are modeled using the OF graph bindings specified in
> -	Documentation/devicetree/bindings/graph.txt.
> -
> -- video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
> -- video port 1 for either a panel or subsequent encoder
> -
> -Example:
> -
> -lvds_panel: lvds-panel {
> -	compatible = "auo,b101ean01";
> -	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
> -	data-mapping = "jeida-24";
> -
> -	ports {
> -		panel_in_lvds: endpoint {
> -			remote-endpoint = <&lvds_out_panel>;
> -		};
> -	};
> -};
> -
> -For Rockchip RK3288:
> -
> -	lvds: lvds@ff96c000 {
> -		compatible = "rockchip,rk3288-lvds";
> -		rockchip,grf = <&grf>;
> -		reg = <0xff96c000 0x4000>;
> -		clocks = <&cru PCLK_LVDS_PHY>;
> -		clock-names = "pclk_lvds";
> -		pinctrl-names = "lcdc";
> -		pinctrl-0 = <&lcdc_ctl>;
> -		avdd1v0-supply = <&vdd10_lcd>;
> -		avdd1v8-supply = <&vcc18_lcd>;
> -		avdd3v3-supply = <&vcca_33>;
> -		rockchip,output = "rgb";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			lvds_in: port@0 {
> -				reg = <0>;
> -
> -				lvds_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_lvds>;
> -				};
> -				lvds_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_lvds>;
> -				};
> -			};
> -
> -			lvds_out: port@1 {
> -				reg = <1>;
> -
> -				lvds_out_panel: endpoint {
> -					remote-endpoint = <&panel_in_lvds>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.yaml
> new file mode 100644
> index 000000000..f05901633
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.yaml

Filename matching compatible style, so: "rockchip,lvds.yaml"

> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip-lvds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip low-voltage differential signal (LVDS) transmitter
> +
> +maintainers:
> +  - Sandy Huang <hjc@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,px30-lvds
> +      - rockchip,rk3288-lvds
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: pclk_lvds
> +
> +  avdd1v0-supply:
> +    description: Regulator phandle for 1.0V analog power.

Drop "Regulator phandle for ". Same in other regulators.

> +
> +  avdd1v8-supply:
> +    description: Regulator phandle for 1.8V analog power.
> +
> +  avdd3v3-supply:
> +    description: Regulator phandle for 3.3V analog power.
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the general register files syscon.
> +
> +  rockchip,output:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [rgb, lvds, duallvds]
> +    description: This describes the output interface.
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: dphy
> +
> +  pinctrl-names:
> +    const: lcdc
> +
> +  pinctrl-0: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port 0 for the VOP input, the remote endpoint maybe vopb or vopl.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port 1 for either a panel or subsequent encoder.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,px30-lvds
> +
> +    then:
> +      required:
> +        - phys
> +        - phy-names

else:
  properties:
    phys: false
    phy-names: false

(assuming it is correct)

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3288-lvds
> +
> +    then:
> +      required:
> +        - reg
> +        - clocks
> +        - clock-names
> +        - avdd1v0-supply
> +        - avdd1v8-supply
> +        - avdd3v3-supply
> +
> +required:
> +  - compatible
> +  - rockchip,grf
> +  - rockchip,output
> +  - ports

Please keep order like in example-schema.yaml:

properties:
required:
allOf:
additionalProperties:
examples:

> +
> +examples:
> +  - |

Best regards,
Krzysztof

