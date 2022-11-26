Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93411639871
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKZWZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:25:36 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3DE0C3;
        Sat, 26 Nov 2022 14:25:34 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id i85so5247319ioa.5;
        Sat, 26 Nov 2022 14:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZlyB3iEQfZN2ouKWA070xdoCwtuTYqQ3/sG9m3p7/80=;
        b=VAk7lsvtZ+DsBg+hvaW7dC+ZrMlGaPgCVqWKIYfm1mIJmE8viGV0SXeLkGIkupBb05
         /TI0JCw6FV/LQn97dn/xrCUQPoQI0lq1a73YcnaqdTnnIGnLRci2P8HP+1t9GnN6y5CV
         30IdQerHrLKrFJPQvYVHmzXr6eVDoAKIdQGWqzdQsK/Qk9CPlpoobMpo+AV3S95RU/Uc
         zl4Q3dub0EpxkMU1RuGojsbrJhKVoIrThFPO8zq/H5eZFPk+X7wxUIHanTMcUZ5PQjXP
         s5QPnABDDjkHB/XI0PXl1KCTKm7I6fgunm0iBYLkytlDaHYd+a40tZHlGlh1sT6KRcqQ
         qtBg==
X-Gm-Message-State: ANoB5pmyX99vc/+jno1i8hKjU1Gvi3ynP5unEaUgZierUwKwugdjkNYS
        e5n9EWeZfE9a0XMMH4+18U1KOhYMlQ==
X-Google-Smtp-Source: AA0mqf6yWHEStBRsGoTfckgJSkpmKT6XWvb9nkZy76Ew7cHLnrwvgiNck/FaNKmTl5/fQQkixWY/ew==
X-Received: by 2002:a5d:8941:0:b0:6a1:2c0c:6084 with SMTP id b1-20020a5d8941000000b006a12c0c6084mr10279947iot.128.1669501533882;
        Sat, 26 Nov 2022 14:25:33 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z15-20020a05663822af00b00389d2ff28a5sm712108jas.47.2022.11.26.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 14:25:33 -0800 (PST)
Received: (nullmailer pid 35346 invoked by uid 1000);
        Sat, 26 Nov 2022 22:25:36 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20221124191400.287918-2-j.neuschaefer@gmx.net>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-2-j.neuschaefer@gmx.net>
Message-Id: <166950112932.8087.6546134123286782729.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Date:   Sat, 26 Nov 2022 16:25:36 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 20:13:58 +0100, Jonathan Neuschäfer wrote:
> The Flash Interface Unit (FIU) is the SPI flash controller in the
> Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> accessed by software-defined SPI transfers.
> 
> The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - A few cleanups suggested by Krzysztof Kozlowski
> - Simplify binding by making second reg item mandatory
> 
> v1:
> - https://lore.kernel.org/lkml/20221105185911.1547847-4-j.neuschaefer@gmx.net/
> ---
>  .../bindings/spi/nuvoton,wpcm450-fiu.yaml     | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dts:18:18: fatal error: dt-bindings/clock/nuvoton,wpcm450-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124191400.287918-2-j.neuschaefer@gmx.net

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

