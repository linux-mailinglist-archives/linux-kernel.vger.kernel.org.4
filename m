Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59026D1AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjCaInY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCaImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:42:55 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90571BF42;
        Fri, 31 Mar 2023 01:42:26 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Pnv0D674xz49Q6m;
        Fri, 31 Mar 2023 11:41:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1680252094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofzs1/zRJhx7iXfR1mz6Mp398ZtxCc5wKnjcib04Kpo=;
        b=mjSwuzzgkGYF1aBG+PS8dajSgq9AKxZuC4aqKYO1DR8Cr7MUowtU69KwKauUMetn+ccgbR
        5raVyjNcjEnzhcrAH21ReWk7TuiKE7UQARgBpYsxa2yeoCF6Jsz5oI64Nw3QCpErp/G6AU
        x6boAy+Dr5TcXVTqRVsoXCXu+2y45GlUuyNXbDLjvpQ2ojyEoNST8RgV3BHKTAPX40mdT+
        Yo7OId+nd12zY8b/Modkeoxy8gZ5UzMSKbXWb5BSXMxFy4uXaF3+vWGmGBVTI2L+fRdmQ+
        V997wJm8YdXBn+wGvcS34gh8lSO7R8kuh5c48nq0NeFO/sZd8VeBcDdHkebhFQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1680252094; a=rsa-sha256;
        cv=none;
        b=LbQMuPda+h/MK+hwI6qy3vKMvEbSI9MlYhd189ZBlL45LvnMcsq3MRtE0Ee49+HSuimH6/
        A7JC86v8tjaKncaISZhbqAfemQjnbpQfHhNYqKUd+W8rhRbQMG12cH7kPbI2AxovZJmRSI
        Eub6gTFRmoNQl95iwVTKvUl1QeBjW7nS3P2+a34SYkMT4EA0jD9GPtjCqPON+tHo/jhGnx
        htsb7iG+wJ0tMUPgaXhwHA8w3WJibqHYGJtD6/yLGX30aYwL9zGOHHE4+ksUpt+byDrh9+
        9BPyvEnHXbnqArN7ZOSKS//cAM+D/sIOT/Tv/feO4EWj9LY1+Z03YmI/HCG7cQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1680252094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofzs1/zRJhx7iXfR1mz6Mp398ZtxCc5wKnjcib04Kpo=;
        b=las15LzuG4Ixc1zej0ohgzrCfhwANMfPTgofZJEwqUJS+eonu58UIrIjUJbqWC8ONBSdqU
        i7mlTu/TSJHkAbLkqeFu2TYGxKsW2PUBU098cTQlaoMyiRfPbU3XZEXd3tYdFpFR5fiQ5o
        amg0sWkT2UfS2eZv3jLDUjaWFodJaNZlIph3T/kmKj9Qr7Xs6Q90sYaSWTOmhFOdzk2Gja
        DMERJ10jqBlXxbj9TH2Ydo0fTgjlw1ZkInsZTjhfukV+F/qVMLNiV1NQOkilKFmtOUU7fh
        Yd0n9EBCNzzEsa60lfAWoJ3lPLLVXaUibit0olS4juhG6/daRhrPoVAlOuQLtg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id DF993634CA1;
        Fri, 31 Mar 2023 11:39:16 +0300 (EEST)
Date:   Fri, 31 Mar 2023 11:39:16 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] media: dt-bindings: ov2685: convert to dtschema
Message-ID: <ZCacNEbg8cJo0VAm@valkosipuli.retiisi.eu>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
 <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Thanks for the patch.

On Thu, Mar 23, 2023 at 06:57:50PM +0100, Luca Weiss wrote:
> Convert the text-based dt-bindings to yaml.
> 
> Changes from original txt:
> * Take wording for various properties from other yaml bindings, this
>   removes e.g. volt amount from schema since it isn't really relevant
>   and the datasheet is a better source.
> * Don't make reset-gpios a required property since it can be tied to
>   DOVDD instead.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
>  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 102 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov2685.txt b/Documentation/devicetree/bindings/media/i2c/ov2685.txt
> deleted file mode 100644
> index 625c4a8c0d53d..0000000000000
> --- a/Documentation/devicetree/bindings/media/i2c/ov2685.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -* Omnivision OV2685 MIPI CSI-2 sensor
> -
> -Required Properties:
> -- compatible: shall be "ovti,ov2685"
> -- clocks: reference to the xvclk input clock
> -- clock-names: shall be "xvclk"
> -- avdd-supply: Analog voltage supply, 2.8 volts
> -- dovdd-supply: Digital I/O voltage supply, 1.8 volts
> -- dvdd-supply: Digital core voltage supply, 1.8 volts
> -- reset-gpios: Low active reset gpio
> -
> -The device node shall contain one 'port' child node with an
> -'endpoint' subnode for its digital output video port,
> -in accordance with the video interface bindings defined in
> -Documentation/devicetree/bindings/media/video-interfaces.txt.
> -The endpoint optional property 'data-lanes' shall be "<1>".
> -
> -Example:
> -&i2c7 {
> -	ov2685: camera-sensor@3c {
> -		compatible = "ovti,ov2685";
> -		reg = <0x3c>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&clk_24m_cam>;
> -
> -		clocks = <&cru SCLK_TESTCLKOUT1>;
> -		clock-names = "xvclk";
> -
> -		avdd-supply = <&pp2800_cam>;
> -		dovdd-supply = <&pp1800>;
> -		dvdd-supply = <&pp1800>;
> -		reset-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
> -
> -		port {
> -			ucam_out: endpoint {
> -				remote-endpoint = <&mipi_in_ucam>;
> -				data-lanes = <1>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> new file mode 100644
> index 0000000000000..2ac0ca8a0413b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov2685.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV2685 Image Sensor
> +
> +maintainers:
> +  - Shunqian Zheng <zhengsq@rock-chips.com>
> +
> +properties:
> +  compatible:
> +    const: ovti,ov2685
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XVCLK clock
> +
> +  clock-names:
> +    items:
> +      - const: xvclk
> +
> +  dvdd-supply:
> +    description: Digital Domain Power Supply
> +
> +  avdd-supply:
> +    description: Analog Domain Power Supply
> +
> +  dovdd-supply:
> +    description: I/O Domain Power Supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reset Pin GPIO Control (active low)
> +
> +  port:
> +    description: MIPI CSI-2 transmitter port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            maxItems: 1

This should be 2 --- the sensor supports two lanes (even if the driver
doesn't).

I can address this when applying if that's ok.

> +
> +        required:
> +          - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dvdd-supply
> +  - avdd-supply
> +  - dovdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ov2685: camera-sensor@3c {
> +            compatible = "ovti,ov2685";
> +            reg = <0x3c>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&clk_24m_cam>;
> +
> +            clocks = <&cru SCLK_TESTCLKOUT1>;
> +            clock-names = "xvclk";
> +
> +            avdd-supply = <&pp2800_cam>;
> +            dovdd-supply = <&pp1800>;
> +            dvdd-supply = <&pp1800>;
> +            reset-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
> +
> +            port {
> +                ucam_out: endpoint {
> +                    remote-endpoint = <&mipi_in_ucam>;
> +                    data-lanes = <1>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ea325040f355..5904f47756fe1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15410,6 +15410,7 @@ M:	Shunqian Zheng <zhengsq@rock-chips.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>  F:	drivers/media/i2c/ov2685.c
>  
>  OMNIVISION OV2740 SENSOR DRIVER
> 

-- 
Kind regards,

Sakari Ailus
