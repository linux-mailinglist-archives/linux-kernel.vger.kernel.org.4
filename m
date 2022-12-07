Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE086645DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLGPf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLGPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:35:56 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEEA62E97;
        Wed,  7 Dec 2022 07:35:55 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id m204so21114252oib.6;
        Wed, 07 Dec 2022 07:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBpBd7+pFnpb+CGSyhsTaAtXlwJmyfr3U6zIXBU+CU8=;
        b=bwGtDG3eaTxTwfAC4Zdz21uIFe4K9ZGaY/0UTxy9ORls3qAmbvRR9zTQu+0DggfeYL
         NhOkXaf1SxTyFDAKqOIBfsMfjK+XZjqfOpA+VBiiZTc58ZmTEYEfibn4h1/HhPwfw/rJ
         K9nSYlyd8DDT9HdJ3Xf0mfolpFZ2LXLWOc70+XS5xmXmM2cRtsmq59JjY4mUnboViJOJ
         OrS3VTM50ivPdCMjT/T4qms4i+GRTxgYUT8S4D5z+hP978hqHP9RGHqYgw5T2lYUXLao
         6Ppf6JJJ/Gnjdp6LxN5T5cp3pHnHmKmoE8uJkqrBP0olKy/3IRyEsdiAfFGHQj2VCEEZ
         +eyw==
X-Gm-Message-State: ANoB5plre3BEWqFqkkAjpLymJQYigJJe7UU9/hoJ2BLzo/8bx5JC8N4Q
        ABDCusfpg3NpBEGggwqMiA==
X-Google-Smtp-Source: AA0mqf6Feu1onLJPtKNVbwwfEe7rbawqt0LgfrOo7YBldPyEM5I/BsLZS0ysSmXTDBpwIUzHe7p7Mw==
X-Received: by 2002:aca:1e0d:0:b0:35b:b54d:19a with SMTP id m13-20020aca1e0d000000b0035bb54d019amr21750341oic.242.1670427354571;
        Wed, 07 Dec 2022 07:35:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s17-20020a056870631100b00136f3e4bc29sm12245693oao.9.2022.12.07.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:35:54 -0800 (PST)
Received: (nullmailer pid 2275786 invoked by uid 1000);
        Wed, 07 Dec 2022 15:35:53 -0000
Date:   Wed, 7 Dec 2022 09:35:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/16] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic
Message-ID: <20221207153553.GA2269092-robh@kernel.org>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-10-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207055405.30940-10-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:53:58PM +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the SoC-glue logic implemented on
> Socionext Uniphier SoCs.
> 
> This SoC-glue logic is a set of miscellaneous function registers
> handling signals for specific devices outside system components,
> and also has multiple functions such as I/O pinmux, usb-phy, debug,
> clock-mux for a specific SoC, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-soc-glue.yaml          | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> new file mode 100644
> index 000000000000..6fc790963660
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier SoC-glue logic
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  SoC-glue logic implemented on Socionext UniPhier SoCs is a collection of
> +  miscellaneous function registers handling signals outside system components.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - socionext,uniphier-ld4-soc-glue
> +          - socionext,uniphier-pro4-soc-glue
> +          - socionext,uniphier-pro5-soc-glue
> +          - socionext,uniphier-pxs2-soc-glue
> +          - socionext,uniphier-sld8-soc-glue
> +          - socionext,uniphier-ld11-soc-glue
> +          - socionext,uniphier-ld20-soc-glue
> +          - socionext,uniphier-pxs3-soc-glue
> +          - socionext,uniphier-nx1-soc-glue
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pinctrl(@[0-9a-f]+)?$":
> +    $ref: /schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
> +
> +  "^usb-hub(@[0-9a-f]+)?$":
> +    $ref: /schemas/phy/socionext,uniphier-usb2-phy.yaml#
> +
> +  "^clock-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pro4-soc-glue
> +              - socionext,uniphier-ld11-soc-glue
> +    else:
> +      patternProperties:
> +        "^usb-hub(@[0-9a-f]+)?$": false

While just if and else is valid json-schema, we require 'then'. Can you 
change this to 'if: { not: {...}, then: {}'.

You should be getting a warning for this. The rest of the warnings from 
the bot look like false positives you can ignore.

Rob
