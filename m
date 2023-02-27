Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50416A4C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB0Uwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0Uwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:52:32 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA424C81;
        Mon, 27 Feb 2023 12:52:31 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id t22so6280104oiw.12;
        Mon, 27 Feb 2023 12:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IO0sBucNdWhZTvHKKkXibO8za6vlePhK4sUIcE5pvE=;
        b=rLdfV+f0SrVanHMjHdJ0xD6V1jNO76tADIVfB7GAeU69p2RyF8PeDtDE2iUL64pWpP
         SMKleRerJ1OYHCSzuAV++zycy1PHV1j3/RPRg7RxoO5LbhnWsYosAdPV0e22v/kjYAC9
         aLxdFS6lWDjX5ZH02IkoAvFvgyjSvCVMC6RMYRMKJlgFpMeChilXVa2bvgXIZVvXjKYh
         n0I3PmbAbvBKcgkcVyKZDb477KrpkNBWEz1QoESVJdiew5T2mluzmdROH44A9wOrQWXG
         zCctzyGmUL0fbK2CGrsf7Jk5uIFDqYskejikgm4mPoK4D3l6X+Jm8VtKE7f8y5lVW43U
         lvnQ==
X-Gm-Message-State: AO0yUKU0DvEYjjGcUDX39LGbKW8GdfXtyMuE4XNFx/P0nmkIWwlv8Ij9
        1mqCY9VLCYByZW83RBZC5X+JxL4BLQ==
X-Google-Smtp-Source: AK7set9tiuyo+JLiUNfNjG4cswyI/NX7Fs2lfJdk7bR1wtltnPuv7VveV/ORSiio5JbdRdOdZyls9w==
X-Received: by 2002:a05:6808:60a:b0:37f:ab79:a198 with SMTP id y10-20020a056808060a00b0037fab79a198mr234978oih.27.1677531150184;
        Mon, 27 Feb 2023 12:52:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j126-20020acab984000000b00369a721732asm3546861oif.41.2023.02.27.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:52:29 -0800 (PST)
Received: (nullmailer pid 894886 invoked by uid 1000);
        Mon, 27 Feb 2023 20:52:29 -0000
Date:   Mon, 27 Feb 2023 14:52:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Message-ID: <20230227205229.GA880857-robh@kernel.org>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
 <20230226130539.277336-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226130539.277336-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 09:05:33PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert usbmisc-imx to DT schema format.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 54 +++++++++++++++++++
>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 19 -------
>  2 files changed, 54 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> new file mode 100644
> index 000000000000..517390b9d2c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/fsl,usbmisc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX wrapper module for Chipidea USB2 controller
> +
> +maintainers:
> +  - Xu Yang <xu.yang_2@nxp.com>
> +  - Peng Fan <peng.fan@nxp.com>
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
> +              - fsl,imx8mm-usbmisc
> +          - const: fsl,imx7d-usbmisc

So imx8mm is compatible with imx7d, and imx7d is compatible with imx6q, 
but imx8mm is not compatible with imx6q? That doesn't really make sense. 
Maybe all 3 compatibles makes sense, but only if s/w understanding only 
one of the fallback compatibles would function without knowledge of the 
newer h/w.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#index-cells':
> +    const: 1
> +    description: Cells used to describe usb controller index.

Please mark this as deprecated. If it is always 1 cell, then there's no 
point. 

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#index-cells'

And drop as required. That all can be a follow-up patch if you prefer or 
in this patch is fine. Primarily, I don't want this pattern copied.

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
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> deleted file mode 100644
> index 29b8f65ff849..000000000000
> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
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
> -	"fsl,imx8mm-usbmisc" for imx8mm
> -- reg: Should contain registers location and length
> -
> -Examples:
> -usbmisc@2184800 {
> -	#index-cells = <1>;
> -	compatible = "fsl,imx6q-usbmisc";
> -	reg = <0x02184800 0x200>;
> -};
> -- 
> 2.37.1
> 
