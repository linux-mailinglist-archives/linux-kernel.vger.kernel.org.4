Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB961E258
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKFN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKFN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:27:07 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0877DEEB;
        Sun,  6 Nov 2022 05:27:06 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id h132so1849812oif.2;
        Sun, 06 Nov 2022 05:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=70rG3D8Yrp5l4kQEMqm9SiHO8UxHi0ydxic0NbAwdXY=;
        b=MseI7AkTwJlp74aN4gRQn/6MlVv3OQ/LHSEakp6/SDEFO98fBEPdwNGQAvlHoP8wUN
         Kx3lyIjlJQXu6ox8lQ5v43A2rMRJn46fSh0pIIP1Wjz4qROVTaujhAfb9kCKnhbNIp4S
         Y1eTfUF4LhZtenbt7heMGQ88ciqwj89EoKBALWOcLY1xiEdyMdz0Hx5RjEC4RFrj3vb8
         /MasD8vMDxz/JaXdXftiFylHF+dFQxmLx/F6xyZ+vAa7xLgemGhcSoSFjJ7VUDNGfB98
         xOq4ZSTHu1ykowTsNDd9inNjAcGARFrvEY/n/y12p/sA3ZgmDgZr76yjlBWM1EBJifjH
         T6vg==
X-Gm-Message-State: ACrzQf2jzuAZtAEDp9lV4Cl+bgAoSn4v4K9uH4IQmsuKSBTrMcVWEKxN
        N1T+m/snwVwDC/XW95In+N02rby4cA==
X-Google-Smtp-Source: AMsMyM7Sls3WiTU2TvqdLp/oEK24gdz+axBLfyyb2HTGWnoficc1u8L89/xNoNFThGX+S2ZP2YkBgg==
X-Received: by 2002:a05:6808:1823:b0:35a:6f80:6398 with SMTP id bh35-20020a056808182300b0035a6f806398mr4003830oib.68.1667741225773;
        Sun, 06 Nov 2022 05:27:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ek17-20020a056870f61100b0013c50b812a2sm1878335oab.36.2022.11.06.05.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 05:27:05 -0800 (PST)
Received: (nullmailer pid 2692032 invoked by uid 1000);
        Sun, 06 Nov 2022 13:27:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org
In-Reply-To: <20221105185911.1547847-4-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-4-j.neuschaefer@gmx.net>
Message-Id: <166774077447.2683568.10429527253386553094.robh@kernel.org>
Subject: Re: [PATCH 3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface
 Unit (FIU)
Date:   Sun, 06 Nov 2022 07:27:07 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Nov 2022 19:59:06 +0100, Jonathan Neuschäfer wrote:
> The Flash Interface Unit (FIU) is the SPI flash controller in the
> Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> accessed by software-defined SPI transfers.
> 
> The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/spi/nuvoton,wpcm450-fiu.yaml     | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
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

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

