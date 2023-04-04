Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD86D60E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjDDMiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjDDMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:37:59 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6584DE65;
        Tue,  4 Apr 2023 05:37:30 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17aceccdcf6so34302320fac.9;
        Tue, 04 Apr 2023 05:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611796;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0jw5cqutZbx/QW7WKjOQs2owiMOWHGW+suiwBs6SJ38=;
        b=gp0iFRlZFIZk4vkje2zkclsavRf7hw6jlUvRF1UAHKjNfbDKCN3fXdJ/WYBDYk5TDf
         +pxb2zZcR6/N0+Y4wk5RigcT2EilQL6hUbmilBy7KbJ4Tp/lY6aqsZWMkhEuSXe4zJf+
         5YnTHMXW1t1iP7LXXMs+7LNfVskMEuV03gUqpsJEUScjVsYCvxnk3I1j5O4qHdW1bTRM
         oO39Q6E/LCNkf3b9/nn7oDO5NzduRecwUUx6+yYHSe2GEjFaiNUeY+w76IChgko5aLUe
         K72wn0B0RDmWaYrD30/mHmzRuTkK32hXXY/OmQfO+51p57qtaOoq7DW/DOvsKl6k5qgP
         sKIw==
X-Gm-Message-State: AAQBX9cU+jlbW4tmu0Kc/CMpC3wS+MPvhtYNuHRveq4QXbH7HokjBHMy
        flKvclt20Xh0dw2Kg1T9HA==
X-Google-Smtp-Source: AKy350bhRqX4FAch/8GEKSjtpqleOc3Q0BdTRsPuYpRjYCW4EMYiAFL7XmR8fMG3R30XCkec0VxWAA==
X-Received: by 2002:a05:6870:d1c8:b0:17a:a7af:6cee with SMTP id b8-20020a056870d1c800b0017aa7af6ceemr1512478oac.51.1680611796368;
        Tue, 04 Apr 2023 05:36:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y206-20020aca32d7000000b0038b0dd1c040sm3353259oiy.3.2023.04.04.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:36:35 -0700 (PDT)
Received: (nullmailer pid 3710629 invoked by uid 1000);
        Tue, 04 Apr 2023 12:36:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230404054642.5691-1-otabeknazrullaev1998@gmail.com>
References: <20230404054642.5691-1-otabeknazrullaev1998@gmail.com>
Message-Id: <168061169045.3708460.6798007287517476603.robh@kernel.org>
Subject: Re: [PATCH] watchdog: dt-bindings: atmel-at91rm9200-wdt convert to
 json-schema
Date:   Tue, 04 Apr 2023 07:36:32 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 14:46:40 +0900, Otabek Nazrullaev wrote:
> Convert atmel AT91RM9200 system timer watchdog from text bindings
> to YAML format
> 
> Signed-off-by: Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
> ---
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
>  .../watchdog/atmel-at91rm9200-wdt.yaml        | 28 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 9 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.example.dts:18.27-20.11: Warning (unit_address_vs_reg): /example-0/watchdog@fffffd00: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.example.dtb: /example-0/watchdog@fffffd00: failed to match any schema with compatible: ['atmel,at91rm9200-wdt']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.example.dtb: watchdog@fffffd40: Unevaluated properties are not allowed ('atmel,dbg-halt', 'atmel,idle-halt', 'atmel,max-heartbeat-sec', 'atmel,min-heartbeat-sec', 'atmel,reset-type', 'atmel,watchdog-type', 'clocks', 'interrupts', 'reg' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230404054642.5691-1-otabeknazrullaev1998@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

