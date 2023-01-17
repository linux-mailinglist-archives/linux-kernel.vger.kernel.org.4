Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF666E5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAQSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjAQSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:20:31 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE05C0F5;
        Tue, 17 Jan 2023 09:56:59 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so8573722otf.8;
        Tue, 17 Jan 2023 09:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Gekgr8R32c2O/eU3xbaPl1FoUqCeO8TUOCrXdg/ss=;
        b=yDOvY8lPigD4v/AjMuIAKI4i9q6CZ1JV5uWiM+W9t4nfS8WM1nR6IF2WSZTYBWD1fm
         E51vMItFAFE3G2AtjMHQEnO/EsLx4od/GzIJxFzeulcD879QtgzYg3rEvlwAxiyi5LgU
         MyTLz1BkFI6v5ww5qfcPkBTT5HBSIA0Bg/Gxzkvv/9TpGfP6CD9mB6fh6Vv8X65vvsYg
         M2AVeGOMND+1Ip9uDERHBEK9SKxXh+g0a6koVmvz8h4BlKWnUwQMGRqEqQgC1v/5NJ4E
         Kmcb/X8I9KAn3xlcVHAXl3dyLmkwCyZnpbGBX/wgHImB5vtR4qAEs+0qeROWI+/f083p
         zf0w==
X-Gm-Message-State: AFqh2koayQ0DTPw1cVEFXjTW65jYe/XCXrXtI18tvwtfDyCdGiAtaMhG
        qgOBcp5HXUGI7lRCQ91elw==
X-Google-Smtp-Source: AMrXdXuorlkUKc8aeolXvCd1bFLHz0KynukT6/3yjkUch+obkJ1YmHBZjafb3WHY2tsFzDNShft/HA==
X-Received: by 2002:a05:6830:1652:b0:686:4382:13aa with SMTP id h18-20020a056830165200b00686438213aamr1965161otr.32.1673978218257;
        Tue, 17 Jan 2023 09:56:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d5e88000000b00684c9c77754sm1389376otl.69.2023.01.17.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:56:57 -0800 (PST)
Received: (nullmailer pid 3314301 invoked by uid 1000);
        Tue, 17 Jan 2023 17:56:57 -0000
Date:   Tue, 17 Jan 2023 11:56:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230117175657.GA3275060-robh@kernel.org>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
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

On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Introduce a binding for GPIO-based mux hardware used for connecting,
> disconnecting and switching orientation of the SBU lines in USB Type-C
> applications.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Expanded the example to indicate how this fits with the TCPM
> - Updated maintainer email address.
> 
>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> new file mode 100644
> index 000000000000..bf4b1d016e1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: GPIO-based SBU mux
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description:
> +  In USB Type-C applications the SBU lines needs to be connected, disconnected
> +  and swapped depending on the altmode and orientation. This binding describes
> +  a family of hardware solutions which switches between these modes using GPIO
> +  signals.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - onnn,fsusb43l10x
> +          - pericom,pi3usb102
> +      - const: gpio-sbu-mux
> +
> +  enable-gpios:
> +    description: Switch enable GPIO
> +
> +  select-gpios:
> +    description: Orientation select
> +
> +  vcc-supply:
> +    description: power supply
> +
> +  mode-switch:
> +    description: Flag the port as possible handle of altmode switching
> +    type: boolean
> +
> +  orientation-switch:
> +    description: Flag the port as possible handler of orientation switching
> +    type: boolean
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node to link the SBU mux to a TypeC controller for the purpose of
> +      handling altmode muxing and orientation switching.
> +
> +required:
> +  - compatible
> +  - enable-gpios
> +  - select-gpios
> +  - mode-switch
> +  - orientation-switch
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
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
> +                    tcpm_sbu_out: endpoint {
> +                        remote-endpoint = <&sbu_mux_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +    sbu-mux {
> +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> +
> +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> +
> +        mode-switch;
> +        orientation-switch;
> +
> +        port {
> +            sbu_mux_in: endpoint {
> +                remote-endpoint = <&tcpm_sbu_out>;
> +            };

Don't you need a connection to whatever drives SBU? Maybe your case is 
fixed because the phy does the DP/USB muxing? But the binding needs to 
support the worst case which I guess would be all the muxing/switching 
is done by separate board level components.

Rob
