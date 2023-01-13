Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC9669C74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjAMPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAMPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:33:21 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3736C7278D;
        Fri, 13 Jan 2023 07:26:55 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15eec491b40so1663919fac.12;
        Fri, 13 Jan 2023 07:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EVGeTme+bKzd3d4knCGcoP4a5CWNlrIX9hy3r7ftn/g=;
        b=CKJRPAZt/mbr402uVD6mN0iXocIEmvNbHpWC0APTDOHB7uDWOx7iXnxz1K//O+blPa
         OcG7K/tIyu4KcR92T5PehebYeXvtgWAhMo3Qr6TUHrVyEQeiIcDnruCtIdjhe05yeBlT
         NgRYNaMmezHy/uP4kRubzDIr2w8bq2nu6Zq4yPad999U8+M2ir0FmmUVy1/g8a+siHO2
         NXUmSss4SSomaJddSKdEwhJ2jTK/AbfCh5zWf2a8CChfmyvLrySxQriiYyWaj9TBKyyf
         0Jj/s8RZgEWdqn1AZ8xl5rS4koI0LzXUwQ7FUYBrHbe5SGodfcYcDfS6SHz/IhgPx3HX
         oFTQ==
X-Gm-Message-State: AFqh2krPuVBGu9iCogdlnQgilwn8Hu4ao85JtveYOZuvl4sSbKd3+Bex
        QHSaC4k1e84duSfWxpA2HA==
X-Google-Smtp-Source: AMrXdXsemvtKvDZG+AFU0Xve3Mn8xu129jjDjTlWOJCKaOUvqnRedXOSlnH9nBPF7clmH+pOTV2cYQ==
X-Received: by 2002:a05:6871:93:b0:143:e045:7082 with SMTP id u19-20020a056871009300b00143e0457082mr29912421oaa.58.1673623614498;
        Fri, 13 Jan 2023 07:26:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v12-20020a056870b50c00b0014fc049fc0asm10771366oap.57.2023.01.13.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:26:54 -0800 (PST)
Received: (nullmailer pid 2224499 invoked by uid 1000);
        Fri, 13 Jan 2023 15:26:52 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230113110738.1505973-2-keguang.zhang@gmail.com>
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-2-keguang.zhang@gmail.com>
Message-Id: <167362342081.2212182.3990856069388425566.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock driver
Date:   Fri, 13 Jan 2023 09:26:52 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 19:07:37 +0800, Keguang Zhang wrote:
> Add devicetree binding document for the Loongson-1 clock driver.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../bindings/clock/loongson,ls1x-clk.yaml     | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/loongson,ls1x-clk.example.dts:36.39-41.15: Warning (unique_unit_address_if_enabled): /example-0/clocks/cpu_clk@1fe78034: duplicate unit-address (also used in node /example-0/clocks/ahb_clk@1fe78034)

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230113110738.1505973-2-keguang.zhang@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

