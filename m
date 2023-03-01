Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C836A7477
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjCATsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCATrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:47:55 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDC4C16;
        Wed,  1 Mar 2023 11:47:54 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r40so10711727oiw.0;
        Wed, 01 Mar 2023 11:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=clNbV4Ko4NJT19I6+Oqtc9INMNPkACGZh64+Ou/afM8=;
        b=i8n4P4SlZpb4GVcU1rX51GO2plVbqoosZd1r3Z3+XrRqwislOgOA7zt0s7eOLvsDEM
         bvlAxLP3qI4dKqE1HFznIF84JqFpkRRyg+c+fwalXV80/PEbmifHNwKVnhX5NOjG3Yci
         exDA8N8IBiuUYKkWyOv/Mde3ieaViMxoOX3QCS2StypIsWqvYsEsL1s1o034n/0VDfTR
         C5MnPLNSjAk00z8ptkPxo8bnrjDbCSm1PNxqpv0D7ZjFx73eeYZe0nABw4ZEXGRlo0lS
         aL3lhVhDbyyQHzMSnC//q7aIBPuq1INMClzpagCsNxISEweDh7paC2n3LTGNgW6SpNEp
         fTKQ==
X-Gm-Message-State: AO0yUKUVPcax8AdHTPwMAXGtCdjpTt2/eX3kpbSp0scyFn7sKGNonVJ3
        z9sZQ50ZC3BLWv5FfQX3jA==
X-Google-Smtp-Source: AK7set+ft3p4hKKEupo3nob49fV+/K7cx5dQaiYNeim8LsnR8L3CFt08Zm+ZZ29rxbq12+CCWpeukA==
X-Received: by 2002:a05:6808:312:b0:384:32e0:e0b5 with SMTP id i18-20020a056808031200b0038432e0e0b5mr3400605oie.11.1677700071861;
        Wed, 01 Mar 2023 11:47:51 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e4:92a3:b465:3c5a:901b:f4f7])
        by smtp.gmail.com with ESMTPSA id a6-20020a056808120600b0037d59e90a07sm6243697oil.55.2023.03.01.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 11:47:51 -0800 (PST)
Received: (nullmailer pid 9118 invoked by uid 1000);
        Wed, 01 Mar 2023 19:47:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, mturquette@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        rockosov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, jbrunet@baylibre.com,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
In-Reply-To: <20230301183759.16163-6-ddrokosov@sberdevices.ru>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-6-ddrokosov@sberdevices.ru>
Message-Id: <167769997434.7177.16688490192170246531.robh@kernel.org>
Subject: Re: [PATCH v9 5/5] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Date:   Wed, 01 Mar 2023 13:47:42 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Mar 2023 21:37:59 +0300, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 Peripherals clock driver,
> and A1 Peripherals clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++++
>  include/dt-bindings/clock/a1-clkc.h           | 102 ++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dts:18:18: fatal error: dt-bindings/clock/a1-pll-clkc.h: No such file or directory
   18 |         #include <dt-bindings/clock/a1-pll-clkc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230301183759.16163-6-ddrokosov@sberdevices.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

