Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3A67D070
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjAZPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjAZPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:40:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46D66EC8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:40:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1382326wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wGuDYxH7Iul+ATYCcdnef/prennloRJ57eEGIhU2qs=;
        b=JWR1Bwfgp4dtDeSgjUY3QBmjI9YsxPO2NZza2CS0FfN0fFK+8IFYU/BOod09jtLRNt
         DDKK+oxqfdSeP1blqfoFDRp8WMUyXb7du2LtJvOhBvjNfOAWCE7gfOwJLSMPU/tiLGvj
         dDYKP2Xa93rErEbGyJpUA5hJ0N9xvb5MG3aIoMDFDdyS27BLfIw6gTm5JEmuM0MulMK2
         d077ayjmflfIS4Yqg2iFoa1txQJXvop2o0JuSTYeOcwEGFRGJLjNKebGLeo6nPaoBj5b
         hJNQZ6dM5E9E+GOg9L7O1AdyvqfJCdUKsE64uC6O/9ssdx9P5/er4CFaJVMtsS7uY3T6
         VCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wGuDYxH7Iul+ATYCcdnef/prennloRJ57eEGIhU2qs=;
        b=5RB5Fz7ysY6go9U9K/G5SDD7AfLo4x7iW/ArobL+YwX9l8TGJQQ1V2JBz8BU0FxY35
         pn9gzpgsZ3RlKIVmZjKTiEEqtnMifcFWbUZWRw554v0JNkEBb8Nz6BroZC/Ywh8xl+S+
         Xv6l3xty6TyyUDfVBb/aLAplp/3fS4/4o6SoMO8CPZNAJpyKTMGOv3PCGWQ4DARnU7v3
         3WZ+5rRdVXlQ5kfa7k7F9EVPiPObyG7HT0YyE6tcYsPwOPKmZDHtwVeKqiU2OKAHIjbN
         meKCsZnTcPo5WLhdXLImFkS8YKCWN2X+hhK0xBGEE8wZH2pt6lBXlwrylHKNh5pdDXqR
         5rSg==
X-Gm-Message-State: AFqh2kr/TngbXDUJ+/+TQz53kuSUT7codD6wj6fpTxakNwYpEyZ7ceTU
        anj809jnZ5pnkGotx33uoq+UlRyzbMSGqv11
X-Google-Smtp-Source: AMrXdXsxL7BpxR0g9bj985rZVtbY+EqMI8f/SKLBlPBf6vgC4UnHC0wEfDaJkwDXBLm3HvCnb4g5Eg==
X-Received: by 2002:a05:600c:1c9c:b0:3d3:49db:9b25 with SMTP id k28-20020a05600c1c9c00b003d349db9b25mr33371738wms.26.1674747600019;
        Thu, 26 Jan 2023 07:40:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b003cfa622a18asm5232266wmq.3.2023.01.26.07.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:39:59 -0800 (PST)
Message-ID: <906b693d-1e85-8c17-cdda-f09ea8f12e7f@linaro.org>
Date:   Thu, 26 Jan 2023 16:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: tfp410: Add tfp410 i2c
 example
Content-Language: en-US
To:     Jonathan Cormier <jcormier@criticallink.com>,
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
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
 <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
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

On 25/01/2023 22:09, Jonathan Cormier wrote:
> Add a i2c example with HDMI connector

Why? It's the same - but more on this below.

> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>

You need to test the bindings before sending and fix the errors.

> ---
>  .../bindings/display/bridge/ti,tfp410.yaml         | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> index 4c5dd8ec2951..456214f14b47 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> @@ -116,4 +116,46 @@ examples:
>          };
>      };
>  
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdmi_encoder: tfp410@38 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "ti,tfp410";
> +        reg = <0x38>;
> +
> +        ports {
> +          address-cells = <1>;
> +          size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            tfp410_in: endpoint {
> +              remote-endpoint = <&dpi1_out>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            tfp410_out: endpoint {
> +              remote-endpoint = <&hdmi_connector_in>;
> +            };

That's the same example as existing one, so it looks useless. I don't
see benefits of this example.

> +          };
> +        };
> +      };
> +    };
> +
> +    hdmi: hdmi_connector {

Drop. Incorrect name and not really related.

> +      compatible = "hdmi-connector";
> +      label = "hdmi";
> +      type = "a";
> +      ddc-i2c-bus = <&i2c1>;
> +      port {
> +        hdmi_connector_in: endpoint {
> +          remote-endpoint = <&tfp410_out>;
> +        };
> +      };
> +    };
> +
>  ...
> 

Best regards,
Krzysztof

