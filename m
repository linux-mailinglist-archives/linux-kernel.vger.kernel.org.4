Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8946DAED1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjDGOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjDGOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:22:03 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4CFE;
        Fri,  7 Apr 2023 07:21:58 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id k14-20020a9d700e000000b0069faa923e7eso22164480otj.10;
        Fri, 07 Apr 2023 07:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680877317; x=1683469317;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YsRxXaApn9xqdxBsn1qMUWKQy9YkoaOpoPL73WZA9M4=;
        b=avniN7QEhTVP5bjEuluc7cZ/n0UfgwQ4fssIWaWuXgM23MmkXinnZYapxrmay4942F
         Nu89UwXheFHE85Y0nwMiItL5yg9EeToIWlyQ0FXKdKCzGlo/YoR+TnwzcJ7BLlymATl7
         cAJ876vhcaZ4B04p9wXJz0gs9mwkApFyUEr8aQxcTWL+9ztTYmSfFZwaXfhhdAF4/eeZ
         vDBcc2w3Mr6zl4pv0866owfUhVYJdw58RAYOdBKp39Cr7UDXKIKO7UlyEn7Par4kuuHb
         6UKd4r+ek99GVY/GXQieD8ZcQpFTnNsWkgJR9RmxdUVkc65KIMpawqwopPe4KQmAFDTd
         uoBg==
X-Gm-Message-State: AAQBX9ck6kouAhYO2wme0CBoSfK189BfP/iLvFGtcHX7uF96rt7PJTD2
        o3knmFtFh0WF2+4iOlmE9w==
X-Google-Smtp-Source: AKy350aNwBFWMxb/vuIZvZXDuIvV6p1Qf5utJufM3NqZZNE2XXf2am6NlHRLQFasd7g6u1RNlTlqlw==
X-Received: by 2002:a9d:6b94:0:b0:68f:2134:9a3a with SMTP id b20-20020a9d6b94000000b0068f21349a3amr1048221otq.30.1680877317581;
        Fri, 07 Apr 2023 07:21:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a9d730c000000b006a3ae1c5a30sm1749510otk.9.2023.04.07.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 07:21:57 -0700 (PDT)
Received: (nullmailer pid 2506789 invoked by uid 1000);
        Fri, 07 Apr 2023 14:21:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Yang Ling <gnaygnil@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407110025.516405-2-keguang.zhang@gmail.com>
References: <20230407110025.516405-1-keguang.zhang@gmail.com>
 <20230407110025.516405-2-keguang.zhang@gmail.com>
Message-Id: <168087712122.2500896.540819430483949508.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add Loongson-1 watchdog
Date:   Fri, 07 Apr 2023 09:21:55 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 19:00:24 +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 watchdog.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../bindings/watchdog/loongson,ls1x-wdt.yaml  | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.example.dts:18:18: fatal error: dt-bindings/clock/loongson,ls1x-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/loongson,ls1x-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230407110025.516405-2-keguang.zhang@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

