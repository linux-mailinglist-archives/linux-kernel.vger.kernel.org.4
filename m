Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429746CBFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjC1M5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjC1M5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:57:14 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC75BA279;
        Tue, 28 Mar 2023 05:57:11 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso12528054fac.12;
        Tue, 28 Mar 2023 05:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008231;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mjBgCumvHWx1Ig5otityHvo0eU5ZT+OEcV468BiANM8=;
        b=lNxMXdNQruWEcCu8T2VYl5cH5sAW8+eqrMmn4sDrJIRfBqyWvX1sowX43DY0DSDwTp
         +iW4oAAS3TQzfqAaJTtQIXUIWf00114W3M6rxZ7JWy5axwcM6ehd2Yq+ix+uTckz4RTI
         E2m/qSFlmHkFlg3OsOffwbBAguSfmuDFyXgvQoUFhKsdlk16Y66A+rG+KTicgBXMrTz1
         uWycESbk2CTQJfAIH+xhVTcke9vw3znu/oAGJ6qbXFBxB/EuRBFI8+B02VXu3FTkc+O2
         s5a99p7Un2f5RpYaNsMlZGBLvI6CDOmhrWKq901Zidjwz5NIOKpYnY3PbiFLPuohZWEF
         l34g==
X-Gm-Message-State: AAQBX9f3EI096plTotRSq6FKPQFRO1ecTppnnWJRMoeDh3RWMt0Thb79
        0phZ3RPLfY9+y90ICIp2c+GNTgXkFg==
X-Google-Smtp-Source: AK7set9KKydmy/GDFigIvPwq4MnOfKJ2hMnCpruiDqwjqD9RT0kMmz01n88OJGU/uvTqbYKP1Zh4fQ==
X-Received: by 2002:a05:6870:96a2:b0:177:9753:f823 with SMTP id o34-20020a05687096a200b001779753f823mr9935780oaq.20.1680008230737;
        Tue, 28 Mar 2023 05:57:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ar10-20020a05687192ca00b00172ac40356csm10626015oac.50.2023.03.28.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:57:10 -0700 (PDT)
Received: (nullmailer pid 3017892 invoked by uid 1000);
        Tue, 28 Mar 2023 12:57:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        robh+dt@kernel.org, s.hauer@pengutronix.de,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20230328054833.1974942-1-peng.fan@oss.nxp.com>
References: <20230328054833.1974942-1-peng.fan@oss.nxp.com>
Message-Id: <168000764372.3005001.13458583342722454689.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: input: pwm-beeper: convert to dt schema
Date:   Tue, 28 Mar 2023 07:57:07 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 13:48:33 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding doc to dt schema, and also fixed the
> example from fixed-regulator to regulator-fixed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328054833.1974942-1-peng.fan@oss.nxp.com


beeper: beeper-hz:0:0: 4000 is greater than the maximum of 255
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

beeper: pwms:0: [19, 31, 4000] is too long
	arch/arm/boot/dts/armada-370-c200-v2.dtb

beeper: pwms:0: [52, 5, 1000000, 0] is too long
	arch/arm/boot/dts/aspeed-bmc-vegman-n110.dtb

beeper: pwms:0: [53, 5, 1000000, 0] is too long
	arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dtb
	arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dtb

beeper: pwms:0: [72, 0, 250000, 0] is too long
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb

beeper: pwms:0: [91, 0, 250000, 0] is too long
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb

beeper: pwms:0: [98, 0, 250000, 0] is too long
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

beeper: pwms:0: [98, 0, 500000] is too long
	arch/arm/boot/dts/imx6q-kp-tpc.dtb

beeper: Unevaluated properties are not allowed ('beeper-hz', 'pwms' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

beeper: Unevaluated properties are not allowed ('pwms' was unexpected)
	arch/arm/boot/dts/armada-370-c200-v2.dtb
	arch/arm/boot/dts/aspeed-bmc-vegman-n110.dtb
	arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dtb
	arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dtb
	arch/arm/boot/dts/imx6q-kp-tpc.dtb

beep: pwms:0: [108, 0, 4000000, 1] is too long
	arch/arm/boot/dts/exynos4412-itop-elite.dtb

beep: Unevaluated properties are not allowed ('pwms' was unexpected)
	arch/arm/boot/dts/exynos4412-itop-elite.dtb

buzzer: pwms:0: [20, 0, 1000000, 0] is too long
	arch/arm/boot/dts/s3c6410-mini6410.dtb

buzzer: pwms:0: [41, 0, 500000] is too long
	arch/arm/boot/dts/imx53-kp-ddc.dtb

buzzer: pwms:0: [42, 0, 500000] is too long
	arch/arm/boot/dts/imx53-kp-hsc.dtb

buzzer: Unevaluated properties are not allowed ('pwms' was unexpected)
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/s3c6410-mini6410.dtb

pwm-beeper: pwms:0: [56, 0, 5000] is too long
	arch/arm/boot/dts/imx6ul-kontron-bl.dtb
	arch/arm/boot/dts/imx6ull-kontron-bl.dtb

pwm-beeper: pwms:0: [60, 0, 5000] is too long
	arch/arm/boot/dts/imx6ul-kontron-bl-43.dtb

pwm-beeper: pwms:0: [83, 0, 5000, 0] is too long
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb

pwm-beeper: pwms:0: [86, 0, 5000, 0] is too long
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb

pwm-beeper: Unevaluated properties are not allowed ('pwms' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
	arch/arm/boot/dts/imx6ul-kontron-bl-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-bl.dtb
	arch/arm/boot/dts/imx6ull-kontron-bl.dtb

sound: pwms:0: [44, 1, 1000000, 0] is too long
	arch/arm/boot/dts/da850-lego-ev3.dtb

sound: Unevaluated properties are not allowed ('pwms' was unexpected)
	arch/arm/boot/dts/da850-lego-ev3.dtb

