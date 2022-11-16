Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3189262C28E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiKPP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKPP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:29:24 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60FE13F29;
        Wed, 16 Nov 2022 07:29:23 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id m204so18859326oib.6;
        Wed, 16 Nov 2022 07:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lhDySqSDSUYsaxWCzXj2OJlpzivhZzIQphmJiTKHg0M=;
        b=0oXJfsvTUCwbVrp+1rg2DKXfHT1Ctp4GWH5Q0NW0sNvjiB45lmxubZhCLclotcdE1O
         X1cO8wxZcwUgceSdiwHzr7fkHBlUBvKZxPFQbx09GEiu+uttSaGdbT8Xb7Gj3Q0+XcUY
         e0S3y22+tB7HNhy+qpK0lAKCaU1XRggE0VbQyq1jNVNgx1U71EbBypRh7+QSEHpk3ugz
         2zUmOhV06EufaP3ZBdD36oybzrjRKKgBHb5WiDBdBJy/ia4JwXxwCOrLl/qiEyalrXOM
         p6fp/hbL+AmeXcDTPlyvK7Bm7RitqhPFxVaMBlKqcZnPPd5DIU+jS7NprwFs3FeCq/c7
         Jgzg==
X-Gm-Message-State: ANoB5pmRNartTgRWXrhFBiJcEZnI6d6F0QhlO2wapLwB6OfJ10KYMT5m
        UrpEcNggSL8dHMPTqiKnz6jj0KLH+Q==
X-Google-Smtp-Source: AA0mqf7hFogxRunHKFn+f7/1NLzXGKAXDF5UC4vKAZPSXWwAD9p3mulacMhR4rahSSQ8O8MFvcgiVA==
X-Received: by 2002:aca:3442:0:b0:359:ca6a:7fc0 with SMTP id b63-20020aca3442000000b00359ca6a7fc0mr1869973oia.215.1668612563175;
        Wed, 16 Nov 2022 07:29:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 33-20020a9d0124000000b0066c495a651dsm6635906otu.38.2022.11.16.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:29:22 -0800 (PST)
Received: (nullmailer pid 4083499 invoked by uid 1000);
        Wed, 16 Nov 2022 15:29:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
In-Reply-To: <20221116115046.2687244-1-abel.vesa@linaro.org>
References: <20221116115046.2687244-1-abel.vesa@linaro.org>
Message-Id: <166861229241.4046311.14461609241498645073.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550 compatible
Date:   Wed, 16 Nov 2022 09:29:23 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 13:50:46 +0200, Abel Vesa wrote:
> Add compatible for EPSS CPUFREQ-HW on SM8550.
> Also document the interrupts.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


cpufreq@17d43000: interrupts-extended: [[215, 0], [216, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb

cpufreq@17d43000: interrupts-extended: [[221, 0], [222, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb

cpufreq@17d43000: interrupts-extended: [[223, 0], [224, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb

cpufreq@17d43000: interrupts-extended: [[226, 0], [227, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

cpufreq@17d43000: interrupts-extended: [[227, 0], [228, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb

cpufreq@17d43000: interrupts-extended: [[228, 0], [229, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb

cpufreq@17d43000: interrupts-extended: [[229, 0], [230, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb

cpufreq@17d43000: interrupts-extended: [[230, 0], [231, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb

cpufreq@17d43000: interrupts-extended: [[231, 0], [232, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb

cpufreq@17d43000: interrupts-extended: [[234, 0], [235, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb

cpufreq@17d43000: interrupts-extended: [[235, 0], [236, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb

cpufreq@17d43000: interrupts-extended: [[256, 0], [257, 0]] is too short
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb

cpufreq@17d91000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sm8450-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8450-qrd.dtb
	arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dtb

cpufreq@18591000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb
	arch/arm64/boot/dts/qcom/sm8350-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dtb
	arch/arm64/boot/dts/qcom/sm8350-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dtb
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dtb

