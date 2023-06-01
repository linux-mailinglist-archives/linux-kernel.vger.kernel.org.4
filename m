Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C00719571
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjFAIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFAIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:24:19 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C389F;
        Thu,  1 Jun 2023 01:24:18 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7770b7c2fa5so30066339f.0;
        Thu, 01 Jun 2023 01:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607857; x=1688199857;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gazYzevqDLyrG+qGr3GI/LyG1WYAHb9INyzNCzwmvyc=;
        b=Il8qOPO1WBaNfz48WK80lLtWPy2C6N8TtI3ufKVt8x+831ujmdNKszhZ2SS83b+FJB
         myZc/f3sYI8zUF9FjqkXeQEBGkJkFUmM/A9sPbRV3RoBAbDlrPbCdHSDNzMk2lVMifwO
         HK/R3pVAWcMePMt8D7/9gP2Nhi8dewP+J0N1saygpZ7ToSBhEyHceqSJdMayWRzbvKL1
         eumeHVsOb04Pvfw6z9zLQNWtlzegQbkKVC3T01OcxDG9SMN1ah/l3blHaux2p5VlFlEA
         7ugbvxzKqW/g4ieJ4ADx3smNiSReGoAoeX6UzkAypsV/WETZOQoTXsSThS64mBrwRRgW
         1tCg==
X-Gm-Message-State: AC+VfDwhmyWlQLBXGdrL8T1MkyQ1IzwSjcHuB62R00Ygk81fsRt1xl+m
        ZsipNYraCoWslghc9oB9Vg==
X-Google-Smtp-Source: ACHHUZ72HMFJrNP45MDZaHcwAYDi9bIP9etREBHxugVwme18lNW5tPq76fVbnKuCrVpt+dm7PaOGDQ==
X-Received: by 2002:a6b:d90c:0:b0:766:48cf:6ca9 with SMTP id r12-20020a6bd90c000000b0076648cf6ca9mr7105603ioc.12.1685607857269;
        Thu, 01 Jun 2023 01:24:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id e18-20020a6bf112000000b00760e7a343c1sm4359706iog.30.2023.06.01.01.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 01:24:16 -0700 (PDT)
Received: (nullmailer pid 4111361 invoked by uid 1000);
        Thu, 01 Jun 2023 08:24:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michael Peters <mpeters@embeddedTS.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kris Bahnsen <kris@embeddedTS.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20230601054549.10843-9-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-9-nikita.shubin@maquefel.me>
Message-Id: <168560785494.4110862.6938379895148443324.robh@kernel.org>
Subject: Re: [PATCH v1 27/43] dt-bindings: input: Add Cirrus EP93xx keypad
Date:   Thu, 01 Jun 2023 02:24:15 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Jun 2023 08:45:32 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC keypad.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
> 
>     - remove almost all but debounce-delay-ms and prescale
>     - s/ep9301-keypad/ep9307-keypad/ it's actually only for
>       ep9307, ep9312, ep9315
> 
>     Krzysztof Kozlowski:
>     - renamed file
>     - changed maintainers
>     - dropped quotes
>     - dropped clock-names
>     - use fallback compatible and list all possible compatibles
>     - fix ident
> 
>  .../bindings/input/cirrus,ep9307-keypad.yaml  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.example.dtb: /example-0/keypad@800f0000: failed to match any schema with compatible: ['cirrus,ep9301-keypad']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230601054549.10843-9-nikita.shubin@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

