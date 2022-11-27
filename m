Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B1639D15
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiK0VD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK0VDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:03:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F51BF5D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:02:50 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so14611761lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG9C8Je6fOUrC9EBgB6xvA4FHLC3Tgsmhxw2CT4bktI=;
        b=GN2Qt9uZ5uhkxgBh58GG3jZ43mc+iwVYeEMNV3OOsR3CA/ZqKa2ZeT7+oSac3hUAW/
         DBJQHIYaV/VXrvIIET1l/2qms3ULfWJu6ygEjctNV3S+nLp4eRK729aGLJA0cyPlSmDJ
         IACAHnFBpgvSad/+Vm0uvW4W8Cls7VcH22J/gOPkHE0BVQSjL1Gt7OMKtohi2l029//x
         rSB0ylRIKGo9wC4HVT7ZbNcTQavF3KC1DQKXH/OwN3p7wdxELZNRNd4b47WTPYslAH/b
         kqD9V6SKRzR4pkHa/Yxpx8jNk1Ek2zP9sg08/+M1EGk+CjpnleiHGTMJ3++z5GNaKlTb
         2ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG9C8Je6fOUrC9EBgB6xvA4FHLC3Tgsmhxw2CT4bktI=;
        b=3shzJUloyctuGijf3wX2ym5kHOsrxLTg1jMxIQSlrzt9IHOUDiS3Sm2aj1R/2OVelS
         6H09MJBzTtaMQiL5ZynHSsOe4R45qmK9f+CAvWvQlhCN387aPyA84b6QRZotDtrW3yuh
         OegCsQHDU119tdI/Zh4zcVSq3ORImcYTTY5Xjhg7+kyQQ9B62gAbEZYobOvw+uG7baF4
         13wf0eOv0BsVraHzeVGQs8V6ByMdEXcCfJqIJtbrEP5oxD8/pfgkJ6dL3Hoqg7TBGcNM
         MvGCE3u90HsIR2IJ4S3/jpPc51YbwsC4Lno5528rU9ZESSSUAa0MO4GnuBqMVI0/fVfl
         8QAw==
X-Gm-Message-State: ANoB5plFF74EOdX+B1dX3sDs6gSCmhTjIkkv6Jd3iD4Xsq/7X+EiK9y4
        JcpaYw9nv0A0A3DKsHIvyuXY1Q==
X-Google-Smtp-Source: AA0mqf6+KhkW7HMo9DsQNAJ3vjBKT6NzKVCWbqHwEcMy871JpyCK4dnJ9wP25L4Ys5FqpqLH0nxz1A==
X-Received: by 2002:ac2:4acc:0:b0:4b4:10ca:5240 with SMTP id m12-20020ac24acc000000b004b410ca5240mr17464297lfp.482.1669582967708;
        Sun, 27 Nov 2022 13:02:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z17-20020a056512371100b004b4bae1a05asm1405515lfr.293.2022.11.27.13.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:02:47 -0800 (PST)
Message-ID: <a2a8cd80-a614-e96f-90ab-a98c60527344@linaro.org>
Date:   Sun, 27 Nov 2022 22:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 6/7] dt/bindings: drm/bridge: it6505: Add mode-switch
 support
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-7-treapking@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124102056.393220-7-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 11:20, Pin-yen Lin wrote:
> ITE IT6505 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>   describe the connections.
> 
>  .../bindings/display/bridge/ite,it6505.yaml   | 94 ++++++++++++++++++-
>  1 file changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a..b4b9881c7759 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,9 +52,53 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>  
> -  port:
> -    $ref: /schemas/graph.yaml#/properties/port
> -    description: A port node pointing to DPI host port node
> +  data-lanes:
> +    maxItems: 1
> +    description: restrict the dp output data-lanes with value of 1-4

Hm, where is the definition of this type? For example it comes with
video-interfaces, which you did not reference here.

> +
> +  max-pixel-clock-khz:

There is no such unit accepted:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    maxItems: 1

maxItems of what type? What is this?

> +    description: restrict max pixel clock
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports

This is incompatible change... how do you handle now ABI break?

> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base

Why changing the ref?

> +        unevaluatedProperties: false
> +        description: A port node pointing to DPI host port node
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port-base
> +        description:
> +          Video port for panel or connector.
> +
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            type: object
> +            unevaluatedProperties: false
> +
> +            properties:
> +              reg:
> +                maxItems: 1
> +
> +              remote-endpoint: true
> +
> +              data-lanes:
> +                minItems: 1
> +                uniqueItems: true
> +                items:
> +                  - enum: [ 0, 1, 2, 3]

Same problem as your previouspatch.

> +
> +              mode-switch:
> +                type: boolean
> +                description: Register this node as a Type-C mode switch or not.
> +
> +	    required:
> +        - reg
> +	      - remote-endpoint
>  
>  required:
>    - compatible
> @@ -62,7 +106,7 @@ required:
>    - pwr18-supply
>    - interrupts
>    - reset-gpios
> -  - extcon
> +  - ports
>  
>  additionalProperties: false
>  
> @@ -92,3 +136,45 @@ examples:
>              };
>          };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    &i2c3 {
> +        clock-frequency = <100000>;
> +
> +        it6505dptx: it6505dptx@5c {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "ite,it6505";
> +            interrupts = <8 IRQ_TYPE_LEVEL_LOW 8 0>;
> +            reg = <0x5c>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&it6505_pins>;
> +            ovdd-supply = <&mt6366_vsim2_reg>;
> +            pwr18-supply = <&pp1800_dpbrdg_dx>;
> +            reset-gpios = <&pio 177 0>;
> +            hpd-gpios = <&pio 10 0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    it6505_in: endpoint {
> +                        remote-endpoint = <&dpi_out>;
> +                    };
> +                };
> +                port@1 {
> +                    reg = <1>;
> +                    ite_typec0: endpoint@0 {
> +                        mode-switch;
> +                        data-lanes = <0 1>;

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

