Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA668341B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjAaRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjAaRmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:42:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017BF577ED;
        Tue, 31 Jan 2023 09:42:12 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s66so13469600oib.7;
        Tue, 31 Jan 2023 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nQTlu24MgbwA1itsX0SvceyYlE+PA1Yy3UWZCbDfgE=;
        b=S54Qr8+41Z6P+57CNzgSkPI6uPzQ1AoLYft7ruZy0dTsy2NmJWX3RjL09Pw76Fe513
         aVEasY/WxXWdriPh5V8p7rafFAqInW/CzkH6ZuOL2pEzA6cpXq9YRrt+yE/HY7xz2Zy2
         NebFji12wUByo6GIjqGNTgpQfZkC+MdfmhJqmXZCPVs4P3h2p+a06eDHRTKqKMFWZpPA
         C3O+Urpob1AVr83BpxyKRs4fwqmnbNSJ7rg8OE/wgRHz1YScONDYzjaxo63cWTyy9IPK
         f5ct8NAK01585tlGgDDZ1VCfxHS8ErtFHvGSk77UnwyBKqyzw6N2tSxoxtusemFVoRFf
         bjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nQTlu24MgbwA1itsX0SvceyYlE+PA1Yy3UWZCbDfgE=;
        b=GpXvgAKr/i9yRAoERqk0XXASlspYA8/zZMpk6wilafBeGFBr7K+RG2s9UkOM6G9IgQ
         c3RQWwDAWGDZPsPUNbmWcRTlYr/lC2jzYxmvXNyZt9az8FOEgWrJAzV5Ul6SJRNEklXJ
         4Uz3cH3XvjG3tlBL7PjVBwyAFTMWnoinX0/va4lfVIu9Xb+lBYrMrP1K79eHKegWXMxz
         VtTZFI8hVEwrZQKCHR899y4FAsAOgTtiO88rslBfbRt4uxr3morT6vhYJaqFeDiriKl5
         OgQkWpuQfZeTGKDkx08kjxQhC0o60RY3OIBvUNgIOAi6u4ezt+WMuC0w/Hek60x2w7kb
         u4Sg==
X-Gm-Message-State: AO0yUKX6hpnZ8Q3nS4MN8SUSkdiKdRJMJqQD55qdLaolmNSeMzhjv4Qg
        CKUIkTFjtmuvnGx/im5oaBc=
X-Google-Smtp-Source: AK7set8/IWg5wpSXT2CaR5i54+1B2bm0kh1HPX8V0UVhuDrCRFFIZdJqj0rxXmNrfCC5saC8Ns9hSw==
X-Received: by 2002:a54:4181:0:b0:378:808d:8441 with SMTP id 1-20020a544181000000b00378808d8441mr1701718oiy.45.1675186931335;
        Tue, 31 Jan 2023 09:42:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8-20020a056808140800b0035bd65b776bsm6032464oiv.2.2023.01.31.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:42:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:42:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: watchdog: fsl-imx: document suspend
 in wait mode
Message-ID: <20230131174209.GA3602823@roeck-us.net>
References: <20221104070358.426657-1-andrej.picej@norik.com>
 <20221104070358.426657-3-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104070358.426657-3-andrej.picej@norik.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 08:03:57AM +0100, Andrej Picej wrote:
> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
> set and the device is put into Suspend-to-Idle mode, the watchdog
> triggers a reset after 128 seconds.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v4:
>  - combine allOf, reorder allOf so it follows example-schema, drop the
>    quotes around 'watchdog.yaml'.
> 
> Changes in v3:
>  - disallow the property for devices which don't support WDW bit
>    functionality with .yaml DTS allOf:if:then scheme.
> 
> Changes in v2:
>  - add a commit message,
>  - add a list of devices which support this functionality
> ---
>  .../bindings/watchdog/fsl-imx-wdt.yaml        | 37 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> index fb7695515be1..181f0cc5b5bd 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> @@ -9,9 +9,6 @@ title: Freescale i.MX Watchdog Timer (WDT) Controller
>  maintainers:
>    - Anson Huang <Anson.Huang@nxp.com>
>  
> -allOf:
> -  - $ref: "watchdog.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -55,11 +52,45 @@ properties:
>        If present, the watchdog device is configured to assert its
>        external reset (WDOG_B) instead of issuing a software reset.
>  
> +  fsl,suspend-in-wait:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If present, the watchdog device is suspended in WAIT mode
> +      (Suspend-to-Idle). Only supported on certain devices.
> +
>  required:
>    - compatible
>    - interrupts
>    - reg
>  
> +allOf:
> +  - $ref: watchdog.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - fsl,imx25-wdt
> +                - fsl,imx35-wdt
> +                - fsl,imx50-wdt
> +                - fsl,imx51-wdt
> +                - fsl,imx53-wdt
> +                - fsl,imx6q-wdt
> +                - fsl,imx6sl-wdt
> +                - fsl,imx6sll-wdt
> +                - fsl,imx6sx-wdt
> +                - fsl,imx6ul-wdt
> +                - fsl,imx7d-wdt
> +                - fsl,imx8mm-wdt
> +                - fsl,imx8mn-wdt
> +                - fsl,imx8mp-wdt
> +                - fsl,imx8mq-wdt
> +                - fsl,vf610-wdt
> +    then:
> +      properties:
> +        fsl,suspend-in-wait: false
> +
>  unevaluatedProperties: false
>  
>  examples:
