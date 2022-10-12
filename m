Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D215FC649
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJLNUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJLNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:19:49 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C3EE22;
        Wed, 12 Oct 2022 06:19:43 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so12119072ooi.5;
        Wed, 12 Oct 2022 06:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK3/2ktgZFYxmk6D2dAbFjGlvGPsnMW8mq4UIJV60gw=;
        b=X3/pJ1KMDZpjoEORfIEzwpZibCaaufimt1q5kxt9kWrA+aut65ZIq+uzUtNtHtwoBt
         t3G/E4u3UpL9QVlgS2b43sXpE2Nu5UCn2VQY75TKQp28Z6WKKWYvzQ0qdoyvPZoLbww2
         aaukCGRloxGdoI9AagW0deDiAmPWG7lwmeviroGg1vC37G4HcDizZK+6lI6mv8WMYWl8
         7vC9e9xZUHJo309h/2qC5qbg7EgZPcedm7M9wtvi6CEH8EXRyi47F6ZSqK8vhqifD/iV
         u/6aPA2Z/ioHXWBZib5If8TQOKTOcXh0fnzOOFM48Irzj573cOrPiL8abZtIavgoZ40m
         KJnQ==
X-Gm-Message-State: ACrzQf1gYYAmx6e81dBNBsADiZ4ncwj+lhrKuv8oiQeVsazhgCgmT5RM
        P08mzCwTTPjooqx42S3Clw==
X-Google-Smtp-Source: AMsMyM4IrNGXQTD0hDlqbYMLetA/d6BTgR/0gu4wgW2iciejDR0oJA3WkrTBrQIuJMT1xDM2vVBC3A==
X-Received: by 2002:a9d:4808:0:b0:661:b220:cb5b with SMTP id c8-20020a9d4808000000b00661b220cb5bmr3070570otf.370.1665580782513;
        Wed, 12 Oct 2022 06:19:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c28-20020a056830349c00b00660fe564e12sm6436095otu.58.2022.10.12.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:19:42 -0700 (PDT)
Received: (nullmailer pid 1941576 invoked by uid 1000);
        Wed, 12 Oct 2022 13:19:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     aakarsh jain <aakarsh.jain@samsung.com>
Cc:     linux-fsd@tesla.com, linux-media@vger.kernel.org,
        pankaj.dubey@samsung.com, linux-arm-kernel@lists.infradead.org,
        dillon.minfei@gmail.com, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, smitha.t@samsung.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        jernej.skrabec@gmail.com, robh+dt@kernel.org,
        aswani.reddy@samsung.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, mark.rutland@arm.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, andi@etezian.org, andrzej.hajda@intel.com,
        ezequiel@vanguardiasur.com.ar, david.plowman@raspberrypi.com
In-Reply-To: <20221011122516.32135-2-aakarsh.jain@samsung.com>
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com> <20221011122516.32135-2-aakarsh.jain@samsung.com>
Message-Id: <166558064414.1937173.2124012536890566845.robh@kernel.org>
Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema for MFC
Date:   Wed, 12 Oct 2022 08:19:39 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 17:55:02 +0530, aakarsh jain wrote:
> From: Smitha T Murthy <smitha.t@samsung.com>
> 
> Convert DT schema for s5p-mfc in yaml format
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt     |  75 --------
>  .../bindings/media/samsung,s5p-mfc.yaml       | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


codec@13400000: clock-names: ['mfc', 'sclk_mfc'] is too long
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
	arch/arm/boot/dts/exynos3250-monk.dtb
	arch/arm/boot/dts/exynos3250-rinato.dtb

codec@13400000: clocks: [[7, 178], [7, 228]] is too long
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
	arch/arm/boot/dts/exynos3250-monk.dtb
	arch/arm/boot/dts/exynos3250-rinato.dtb

codec@13400000: iommus: [[36]] is too short
	arch/arm/boot/dts/exynos3250-monk.dtb
	arch/arm/boot/dts/exynos3250-monk.dtb

codec@13400000: iommus: [[40]] is too short
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb

codec@13400000: iommus: [[47]] is too short
	arch/arm/boot/dts/exynos3250-rinato.dtb
	arch/arm/boot/dts/exynos3250-rinato.dtb

codec@13400000: memory-region: [[31], [32]] is too long
	arch/arm/boot/dts/exynos4210-smdkv310.dtb

codec@13400000: memory-region: [[37], [38]] is too long
	arch/arm/boot/dts/exynos4210-origen.dtb

codec@13400000: memory-region: [[41], [42]] is too long
	arch/arm/boot/dts/exynos4412-smdk4412.dtb

codec@13400000: memory-region: [[43], [44]] is too long
	arch/arm/boot/dts/exynos4412-origen.dtb

codec@13400000: memory-region: [[47], [48]] is too long
	arch/arm/boot/dts/exynos4412-itop-elite.dtb
	arch/arm/boot/dts/exynos4412-odroidx2.dtb
	arch/arm/boot/dts/exynos4412-odroidx.dtb

codec@13400000: memory-region: [[48], [49]] is too long
	arch/arm/boot/dts/exynos4412-odroidu3.dtb

codec@f1700000: clock-names:0: 'mfc' was expected
	arch/arm/boot/dts/s5pv210-aquila.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb
	arch/arm/boot/dts/s5pv210-goni.dtb
	arch/arm/boot/dts/s5pv210-smdkc110.dtb
	arch/arm/boot/dts/s5pv210-smdkv210.dtb
	arch/arm/boot/dts/s5pv210-torbreck.dtb

codec@f1700000: clock-names:1: 'sclk_mfc' was expected
	arch/arm/boot/dts/s5pv210-aquila.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb
	arch/arm/boot/dts/s5pv210-goni.dtb
	arch/arm/boot/dts/s5pv210-smdkc110.dtb
	arch/arm/boot/dts/s5pv210-smdkv210.dtb
	arch/arm/boot/dts/s5pv210-torbreck.dtb

codec@f1700000: memory-region: [[51], [52]] is too long
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb

codec@f1700000: memory-region: [[55], [56]] is too long
	arch/arm/boot/dts/s5pv210-galaxys.dtb

