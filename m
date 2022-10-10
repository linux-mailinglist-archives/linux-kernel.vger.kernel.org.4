Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045AC5F9F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJJNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:12:18 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182815718;
        Mon, 10 Oct 2022 06:12:14 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id x188so3671489oig.5;
        Mon, 10 Oct 2022 06:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15TAcF8NS+8qj3HRwBKgB2ME6XMr5Q7+Ypj2Gz0CqG8=;
        b=SFnIGjU6UaCpk6Uj74+pvKIXBPiDSqQ4kxqkbk7O8vJ9pLX0cbGmXaiUE12FZMfz4U
         iFfQYSNcypgn1vMQPz+cEH/N4vfqimdi3Dt5oZLUBzTMk0PeP0KCSH836PE+ZJCTJO2Y
         DPjVVbaKcZ9rLdXOV0w1vBoppyALAM9R4+STeV8lYqQovFX3QR3QHADlQvXBSmeKTEnq
         4p25xhmIFUbOXC+QHtwpqnFsFYxbD8QH9zpTnhS+mezYxXrgVotsQTX934+5W4i0n1E5
         TukOH/N1ZbysCLDGTkadFuYlAN0rlDiL43r6ts6A683ZeRzFKzEuhExrUSg7sFXbfQtD
         b1ow==
X-Gm-Message-State: ACrzQf02t7XibulzKIxPBY59mpkmJqdwUnrYKUNrPosuknn6eadHGU/l
        mOeZWk+B8Ttg6U61SoW/JkHLyqZYlA==
X-Google-Smtp-Source: AMsMyM7DJkA6/IcdCMCNjVQg06TdinHfCbleCPCXBUrEl1ZkMm3jMOJkRirkoSin/GpHh11KRUFp8Q==
X-Received: by 2002:a05:6808:2387:b0:350:28c5:335 with SMTP id bp7-20020a056808238700b0035028c50335mr13639954oib.18.1665407532975;
        Mon, 10 Oct 2022 06:12:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m26-20020a4ae3da000000b00476995b5f0fsm4129135oov.9.2022.10.10.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 06:12:12 -0700 (PDT)
Received: (nullmailer pid 503584 invoked by uid 1000);
        Mon, 10 Oct 2022 13:12:13 -0000
Date:   Mon, 10 Oct 2022 08:12:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Message-ID: <20221010131213.GA498324-robh@kernel.org>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010101816.298334-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 06:18:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert usbmisc-imx to yaml format.

s/yaml/DT schema/

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
>  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> deleted file mode 100644
> index b796836d2ce7..000000000000
> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Freescale i.MX non-core registers
> -
> -Required properties:
> -- #index-cells: Cells used to describe usb controller index. Should be <1>
> -- compatible: Should be one of below:
> -	"fsl,imx6q-usbmisc" for imx6q
> -	"fsl,vf610-usbmisc" for Vybrid vf610
> -	"fsl,imx6sx-usbmisc" for imx6sx
> -	"fsl,imx7d-usbmisc" for imx7d
> -	"fsl,imx7ulp-usbmisc" for imx7ulp
> -- reg: Should contain registers location and length
> -
> -Examples:
> -usbmisc@2184800 {
> -	#index-cells = <1>;
> -	compatible = "fsl,imx6q-usbmisc";
> -	reg = <0x02184800 0x200>;
> -};
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> new file mode 100644
> index 000000000000..c0741ce9b523
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usbmisc-imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX non-core registers
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>

No, should be someone that knows this h/w, not who applies patches.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx6q-usbmisc
> +          - fsl,imx7ulp-usbmisc
> +          - fsl,vf610-usbmisc
> +      - items:
> +          - enum:
> +              - fsl,imx6ul-usbmisc
> +              - fsl,imx6sx-usbmisc
> +              - fsl,imx7d-usbmisc
> +          - const: fsl,imx6q-usbmisc
> +      - items:
> +          - enum:
> +              - fsl,imx7ulp-usbmisc
> +          - const: fsl,imx7d-usbmisc
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#index-cells':

Humm, I doubt this got reviewed...

> +    const: 1
> +    description: Cells used to describe usb controller index. Should be <1>

Drop 'Should be <1>'. The constraints already say that.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#index-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usbmisc@2184800 {
> +        #index-cells = <1>;
> +        compatible = "fsl,imx6q-usbmisc";
> +        reg = <0x02184800 0x200>;
> +    };
> +
> +...
> -- 
> 2.37.1
> 
> 
