Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9473CC0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjFXRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFXRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 13:25:33 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A593610D2;
        Sat, 24 Jun 2023 10:25:32 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-780d9f1bf85so83070339f.0;
        Sat, 24 Jun 2023 10:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687627532; x=1690219532;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rbq4vJktFS9BBGT+vfHjQB0z6sUAkBFuaWTct5wa/a8=;
        b=JYO9IfXAWC2EMu3kQ2lCr6Qbe5MT9BRz6lEwAJx2SsbyfSks/MU2XJsoAEcBzCYdBK
         OD7Klv9Wd5M+NiNMwEym0tvCBNjkqaVzAAS5Yla2jBsm3cFWy4M2mCQuNa39wjYCKtmw
         5vpR6RMcUwHI4MJQe4vf3e8x124qJxV1ddIyWn+pVF1WoayQV0x6KAAN11Yu5Cdz8DYq
         nJ80N6EofyxjFCR4rLytID5zXNztpCwweirpUl6d2+MqD6Vaa/kIOjQkSJBzEcmPhn0a
         IPv3lqDdyp6TE8bW8CPkb+iGKOopuUb55wOUvwsckL6BIs5S9Rz3sftwcOf2dbgJlfdo
         uzfg==
X-Gm-Message-State: AC+VfDx0nv1SXCleBVX8aVsTSBf7gAeB8q7vL0n80CGGFkgM6RPPbAiT
        9ym1sZEOumCUJ/zMgXRoJg==
X-Google-Smtp-Source: ACHHUZ5jTICnMb0WuM2/jvI6dSsywUGWCmKkiiNUEfOJU40TNRrz3QzG/8eEqqSJ0MQhmBnQQvj5TQ==
X-Received: by 2002:a5d:9941:0:b0:780:bf50:32c9 with SMTP id v1-20020a5d9941000000b00780bf5032c9mr11347401ios.15.1687627531742;
        Sat, 24 Jun 2023 10:25:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z6-20020a5ec906000000b0077e25471a7fsm723230iol.48.2023.06.24.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 10:25:30 -0700 (PDT)
Received: (nullmailer pid 3243734 invoked by uid 1000);
        Sat, 24 Jun 2023 17:25:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     JuenKit_Yip@hotmail.com
Cc:     vincent@vtremblay.dev, linux-kernel@vger.kernel.org,
        krzysztof.kozlowki+dt@linaro.org, geert+renesas@glider.be,
        linux@roeck-us.net, michal.simek@amd.com,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com, broonie@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <DB4PR10MB626179DE1C511B10ECA74D209220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
References: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB626179DE1C511B10ECA74D209220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Message-Id: <168762752922.3243704.2220547927763336288.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: <hwmon>: add sht3x devicetree binding
Date:   Sat, 24 Jun 2023 11:25:29 -0600
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


On Sun, 25 Jun 2023 00:01:48 +0800, JuenKit_Yip@hotmail.com wrote:
> From: JuenKit Yip <JuenKit_Yip@hotmail.com>
> 
> add sht3x devicetree binding files
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>  .../devicetree/bindings/hwmon/sht3x.yaml      | 31 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  4 +++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sht3x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/sht3x.yaml:2:2: [error] syntax error: expected alphabetic or numeric character, but found ' ' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/hwmon/sht3x.example.dts'
Documentation/devicetree/bindings/hwmon/sht3x.yaml:2:2: could not find expected directive name
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/hwmon/sht3x.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/hwmon/sht3x.yaml:2:2: could not find expected directive name
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/sht3x.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/DB4PR10MB626179DE1C511B10ECA74D209220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

