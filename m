Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3C68334A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjAaRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:05:09 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2837B3401B;
        Tue, 31 Jan 2023 09:05:08 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r205so13372235oib.9;
        Tue, 31 Jan 2023 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8R83rVhe54sAAq0P0ggDat4LauDn5XUlxsfrsfdnL0=;
        b=P/VJ3xyrCPlKFs/0JWtnkxRrJJHXBEEdByhb9vOPQf4r7/z8qfe8Mv0z4piE8n5gew
         P+FecGrM+90jr0nPumydZJ7gKJ6ljVttGC5nrFGYR+xIMtcEqn8wxCMNU4K85gS/HVLk
         bL+2EUkkboeJfPugWwVpizQ5+3gpSDlyrGYAOrQe/Bh6vnz1skbvABvMFAxAElAcaBNI
         x1lIG1JeT5gG8iPBm636H4h9ph+0VXl86dwF7Ts60COhHckHQfloeacu8g+fvlht1URg
         Dz3BZe69VPQGL6bZ08Sqcv7DUW310WMQLUgO6mmuXfkfZD97ls012g+ZCuTICwJA7eZo
         uIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8R83rVhe54sAAq0P0ggDat4LauDn5XUlxsfrsfdnL0=;
        b=E9P+VVumuVeYTVLav4pUtt4teFtzUOLbyHMA2ePKgfClQCUrogWVP+AZoyh69KhiLJ
         JyD2ORL9/VysiunzJHTfRE+E554lxnwesxCov92ZKO853fS5gp75PQTgrOOE1x5qUHlW
         NjlfU1aXiI5jfU06CsJBSIFr/Uap+8I4Y4Aa5I2zYbqCN2gcZ7YgabUsGVh+NnnbHzxS
         zgS5a5Vgb+N1c2muT+Vw6LfHRjDtSqBBkhudKMpsyWvCZbWQ6i/VO8I8AETEU7wLddlt
         Cdr/i5M4Qb71Kh2pRnubjC0WUQE6cRDDmPOvlWmnHTdCfFRMbHzH5RhcHnn8oCRltARe
         6Qcw==
X-Gm-Message-State: AO0yUKVYX0HlyJNe43R9xaeW6HiWUxrPATlw3yTYv/SsNiUlW5yDpnJS
        zBlwCg6zeaKE9VXmDReiYpA=
X-Google-Smtp-Source: AK7set8nx29YWbEmdIkEWuFjK8hJ8L8d31KiqdZT712m1nGDB3M5aKoSEsMjGnAG9Jk+9AEAjzcFvQ==
X-Received: by 2002:aca:3846:0:b0:378:7f5b:632e with SMTP id f67-20020aca3846000000b003787f5b632emr1667602oia.40.1675184707450;
        Tue, 31 Jan 2023 09:05:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u22-20020a056808115600b0036718f58b7esm5894565oiu.15.2023.01.31.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:05:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:05:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr
Subject: Re: [PATCH] dt-bindings: watchdog: Convert GPIO binding to
 json-schema
Message-ID: <20230131170505.GA3598994@roeck-us.net>
References: <20221125112904.48652-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125112904.48652-1-robert.marko@sartura.hr>
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

On Fri, Nov 25, 2022 at 12:29:04PM +0100, Robert Marko wrote:
> Convert the DT binding for GPIO WDT to JSON schema.
> 
> Cc: luka.perkov@sartura.hr
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/gpio-wdt.txt | 28 ----------
>  .../bindings/watchdog/gpio-wdt.yaml           | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> deleted file mode 100644
> index 198794963786..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* GPIO-controlled Watchdog
> -
> -Required Properties:
> -- compatible: Should contain "linux,wdt-gpio".
> -- gpios: From common gpio binding; gpio connection to WDT reset pin.
> -- hw_algo: The algorithm used by the driver. Should be one of the
> -  following values:
> -  - toggle: Either a high-to-low or a low-to-high transition clears
> -    the WDT counter. The watchdog timer is disabled when GPIO is
> -    left floating or connected to a three-state buffer.
> -  - level: Low or high level starts counting WDT timeout,
> -    the opposite level disables the WDT. Active level is determined
> -    by the GPIO flags.
> -- hw_margin_ms: Maximum time to reset watchdog circuit (milliseconds).
> -
> -Optional Properties:
> -- always-running: If the watchdog timer cannot be disabled, add this flag to
> -  have the driver keep toggling the signal without a client. It will only cease
> -  to toggle the signal when the device is open and the timeout elapsed.
> -
> -Example:
> -	watchdog: watchdog {
> -		/* ADM706 */
> -		compatible = "linux,wdt-gpio";
> -		gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
> -		hw_algo = "toggle";
> -		hw_margin_ms = <1600>;
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml b/Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
> new file mode 100644
> index 000000000000..155dc7965e9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/gpio-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO controlled watchdog
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +properties:
> +  compatible:
> +    const: linux,wdt-gpio
> +
> +  gpios:
> +    maxItems: 1
> +    description: GPIO connected to the WDT reset pin
> +
> +  hw_algo:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Algorithm used by the driver
> +    oneOf:
> +      - description:
> +          Either a high-to-low or a low-to-high transition clears the WDT counter.
> +          The watchdog timer is disabled when GPIO is left floating or connected
> +          to a three-state buffer.
> +        const: toggle
> +      - description:
> +          Low or high level starts counting WDT timeout, the opposite level
> +          disables the WDT.
> +          Active level is determined by the GPIO flags.
> +        const: level
> +
> +  hw_margin_ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Maximum time to reset watchdog circuit (in milliseconds)
> +    minimum: 2
> +    maximum: 65535
> +
> +  always-running:
> +    type: boolean
> +    description:
> +      If the watchdog timer cannot be disabled, add this flag to have the driver
> +      keep toggling the signal without a client.
> +      It will only cease to toggle the signal when the device is open and the
> +      timeout elapsed.
> +
> +required:
> +  - compatible
> +  - gpios
> +  - hw_algo
> +  - hw_margin_ms
> +
> +unevaluatedProperties: false
