Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FAD6F757D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjEDT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjEDTzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:55:39 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECCF1CFC7;
        Thu,  4 May 2023 12:48:59 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-38e7ce73ca0so403839b6e.2;
        Thu, 04 May 2023 12:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683229679; x=1685821679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pv7fLf4V+sKDgE/kCbqAdgUtPBkXqEj+NL6KuNPXfSs=;
        b=M6Ujr1/4+wINSoiItXlfwL3o8PZgYB75zQFRRxvHgoOAjMDhZQa3jhL3VPQlBaezXS
         kSbywsd+2NitzsLZ4f8bg7xS23mo5GWR1Ut2mXrSIy5haIXWHPKlqoY8LamuaFcAOv+z
         WiRftuMybNG0ZgjGRpQkbqGsqGc66NCSTuTJjVOdO7OtrfRNAekC6jJ7Rqt4LP5LEvID
         wgWfpby9rL55Xw1HsTy/13hbc/0lVf7ZVwbNH+zWi8ko2l9xS9xXGmtmUgjZYzkikMSd
         OzAJID3dM1UEe7sDh1mHdlEgIeeCEYz/BsYcmZsmJDLy1dM8P6GPhLCjnoK5U6q70ENw
         cLug==
X-Gm-Message-State: AC+VfDzvRSS0CaPFCP1NUvUm1bcjTpTqr+8e/Y322RBgxTYzQ53LWN//
        7hPcoeH7/RhzThJoSgSj7g==
X-Google-Smtp-Source: ACHHUZ72vbcpe22oJI/K+vN20yfCQvQRKWVO9WlHefU9HaxUqx5JpbVbj3WoW+kfAfWbQu0/ymw7+A==
X-Received: by 2002:a05:6808:3406:b0:38b:7184:f330 with SMTP id by6-20020a056808340600b0038b7184f330mr2137118oib.38.1683229679474;
        Thu, 04 May 2023 12:47:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d13-20020a05680808ed00b003895430852dsm1944358oic.54.2023.05.04.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 12:47:58 -0700 (PDT)
Received: (nullmailer pid 155968 invoked by uid 1000);
        Thu, 04 May 2023 19:47:57 -0000
Date:   Thu, 4 May 2023 14:47:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: gpio-sbu-mux: add support for
 ss-data lanes mux
Message-ID: <20230504194757.GA145231-robh@kernel.org>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:46:50PM +0200, Marco Felsch wrote:
> This adds the support for GPIO based USB-C SS data lane muxing.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml      | 82 +++++++++++++++++++---
>  1 file changed, 71 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> index bf4b1d016e1f..796f3283ac02 100644
> --- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> @@ -4,24 +4,26 @@
>  $id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  
> -title: GPIO-based SBU mux
> +title: GPIO-based SS/SBU mux
>  
>  maintainers:
>    - Bjorn Andersson <andersson@kernel.org>
>  
>  description:
> -  In USB Type-C applications the SBU lines needs to be connected, disconnected
> -  and swapped depending on the altmode and orientation. This binding describes
> -  a family of hardware solutions which switches between these modes using GPIO
> -  signals.
> +  In USB Type-C applications the SS/SBU lines needs to be connected,
> +  disconnected and swapped depending on the altmode and orientation. This
> +  binding describes a family of hardware solutions which switches between these
> +  modes using GPIO signals.

Consider whether the mux-control binding would work for this purpose. 
Then what controls the muxing can be anything.

>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - onnn,fsusb43l10x
> -          - pericom,pi3usb102
> -      - const: gpio-sbu-mux
> +    oneOf:
> +      - items:
> +          - enum:
> +              - onnn,fsusb43l10x
> +              - pericom,pi3usb102
> +          - const: gpio-sbu-mux
> +      - const: gpio-ss-mux
>  
>    enable-gpios:
>      description: Switch enable GPIO
> @@ -50,10 +52,18 @@ required:
>    - compatible
>    - enable-gpios
>    - select-gpios
> -  - mode-switch
>    - orientation-switch
>    - port
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: gpio-sbu-mux
> +then:
> +  required:
> +    - mode-switch
> +
>  additionalProperties: false
>  
>  examples:
> @@ -107,4 +117,54 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    tcpm {
> +        connector {
> +            compatible = "usb-c-connector";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    tcpm_hs_out: endpoint {
> +                        remote-endpoint = <&usb_hs_phy_in>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    tcpm_ss_out: endpoint {
> +                        remote-endpoint = <&usb_ss_phy_in>;
> +                    };
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    tcpm_ss_mux_out: endpoint {
> +                        remote-endpoint = <&ss_mux_in>;
> +                    };
> +                };

port@2 already has a defined use for SBU signals. You can't use it. 
port@1 corresponds to the SS signals.

> +            };
> +        };
> +    };
> +
> +    usb-ss-mux {
> +        compatible = "gpio-ss-mux";
> +
> +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> +
> +        orientation-switch;
> +
> +        port {

This is a mux device. It needs an output port and N input ports.

Please present a complete picture of your USB-C related h/w. It's hard 
to review with just 'I have a GPIO controlling the SS muxing'.

Rob
