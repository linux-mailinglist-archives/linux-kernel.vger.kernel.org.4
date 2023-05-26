Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33F711CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbjEZBn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbjEZBnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:43:53 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF171A7;
        Thu, 25 May 2023 18:43:52 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-774942ddfe0so30431139f.2;
        Thu, 25 May 2023 18:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685065431; x=1687657431;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UcJBsXA60m04uWBwWmLfTx0vDK+YHxaLAkQOCUWBnMg=;
        b=fcu/v/xAv3bcA9O8OnGb80o2hRhTyVDASfxCBTs5Lmz8GR+B/H2DeWuEoCLD1ynwMB
         zWWpSeo4hUo3djc7mA7uy/cB+8sx4ymM+vLghMrpNrfuyiEf1RzTAS2mZFi18dh2pxEq
         QTHv3vm76k+1XvvyWQudoB29vYjgBh2RpQR20c6BFoVksZqwSYcOQLgD62/vHg54AAYu
         P8aOZxNgbs1a48CJqPOCIBmCnJ/dSNSyI2GPPhzk5MOm+3NwkuXO2hN0RdXdgwdoKSjk
         HKL6+38VGEW7V/O8LAjE/vmjDdar3EHQMLE6b+iwpnyP2Li23lEnE/eLjDd6FWnGExZ0
         wjeQ==
X-Gm-Message-State: AC+VfDxYsbjPESsBgIZRXG1/VpM0xxXDokglc5sxPHkBPglVKbccE9If
        RoezuwVrIBgTBpES8hsNKhZSrbDJlA==
X-Google-Smtp-Source: ACHHUZ5XM5uaXn9XSM6fbkgHRJZa5tJEeP+5zrxfIHZJ6gYS0KacPa8XYLSfmIAIvdYMEPcan3QC1g==
X-Received: by 2002:a6b:7602:0:b0:76c:89de:ba47 with SMTP id g2-20020a6b7602000000b0076c89deba47mr1077910iom.19.1685065431430;
        Thu, 25 May 2023 18:43:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id n1-20020a056638110100b00411be337516sm829734jal.24.2023.05.25.18.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:43:50 -0700 (PDT)
Received: (nullmailer pid 3171 invoked by uid 1000);
        Fri, 26 May 2023 01:43:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     conor+dt@kernel.org, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org,
        nicolas.ferre@microchip.com, linux-watchdog@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, sebastian.reichel@collabora.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230525125602.640855-5-claudiu.beznea@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-5-claudiu.beznea@microchip.com>
Message-Id: <168506542457.3138.7238632491421340996.robh@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: watchdog: atmel,at91rm9200-wdt:
 convert to yaml
Date:   Thu, 25 May 2023 20:43:44 -0500
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


On Thu, 25 May 2023 15:56:01 +0300, Claudiu Beznea wrote:
> Convert Atmel AT91RM9200 system timer watchdog bindings to YAML.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 +++++++++++++++++++
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
>  2 files changed, 29 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.example.dts:22.5-6 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230525125602.640855-5-claudiu.beznea@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

