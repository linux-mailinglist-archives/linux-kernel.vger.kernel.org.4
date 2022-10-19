Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E919A6053F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiJSXcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiJSXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:31:57 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A7170DD6;
        Wed, 19 Oct 2022 16:31:56 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso22584854fac.6;
        Wed, 19 Oct 2022 16:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AIp9bMJCr5Y+vVCCDJA4f0wPlmi8lCrHSWYwE065mg=;
        b=uRj/zRxpP6QRekC7MgZt7r+Z/36KqL0eB1qideNSWgeNnZCJIbLg0n9WGF9R3NSe5z
         t8rQO7phQ7YmmjZBEMSgXqWAuaVBFDG4JkacEFO1naym1Pwg1Csj5+9dWQUwlGoaKxGT
         1Ia/lF2OYNPubC2wQ9quoJsz4bSIo5DBfSRNWq/4kKUARpjO+j2kevumpCntKy6mF1Q3
         5VrK4xn5VERzkRMiVS2L2ubvooXeHvLVqIxdhprTbtcnpo/hl3bsz0Pw5x3P7lMv81+D
         FFrSWgvIfWKGEXVWLhgO94jPDUEUgeCwJmUFHqb9bZgF+zMnuEG1XOheHLnmezw8ysUT
         2Mrg==
X-Gm-Message-State: ACrzQf1PSWhRbWx4B82DxHK5LHagUB0ycXWcDdogyjan/0ICIeM80DtL
        1FoLJ9KsNUfB9JNvPPuFQw==
X-Google-Smtp-Source: AMsMyM5bf2O1XCXcTT+EBxdNCZPqKq/zfFpFZLmILpaWROke+ZLdE9yyGbpPQwHfxM5CCj/Csptsuw==
X-Received: by 2002:a05:6871:90:b0:136:b9e8:a024 with SMTP id u16-20020a056871009000b00136b9e8a024mr22611816oaa.60.1666222315586;
        Wed, 19 Oct 2022 16:31:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b133-20020aca348b000000b0035494c1202csm7235963oia.42.2022.10.19.16.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:31:54 -0700 (PDT)
Received: (nullmailer pid 19946 invoked by uid 1000);
        Wed, 19 Oct 2022 23:31:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, jh80.chung@samsung.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20221019170657.68014-2-dinguyen@kernel.org>
References: <20221019170657.68014-1-dinguyen@kernel.org> <20221019170657.68014-2-dinguyen@kernel.org>
Message-Id: <166622207591.14373.6525811988033372211.robh@kernel.org>
Subject: Re: [PATCHv5 1/6] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Wed, 19 Oct 2022 18:31:53 -0500
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

On Wed, 19 Oct 2022 12:06:52 -0500, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v5: document reg shift
> v4: add else statement
> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>     "altr,socfpga-dw-mshc"
> v2: document "altr,sysmgr-syscon" in the MMC section
> ---
>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 32 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


dwmmc0@ff704000: $nodename:0: 'dwmmc0@ff704000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/socfpga_arria5_socdk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb
	arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb
	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb
	arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb
	arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb
	arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb
	arch/arm/boot/dts/socfpga_vt.dtb

dwmmc0@ff704000: 'altr,sysmgr-syscon' is a required property
	arch/arm/boot/dts/socfpga_arria5_socdk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb
	arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb
	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb
	arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb
	arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb

dwmmc0@ff704000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'cd-gpios', 'fifo-depth', 'resets', 'vmmc-supply', 'vqmmc-supply' were unexpected)
	arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb

dwmmc0@ff704000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets', 'vmmc-supply', 'vqmmc-supply' were unexpected)
	arch/arm/boot/dts/socfpga_arria5_socdk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb
	arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb
	arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb

dwmmc0@ff704000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb
	arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb
	arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb
	arch/arm/boot/dts/socfpga_vt.dtb

dwmmc0@ff808000: $nodename:0: 'dwmmc0@ff808000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb
	arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb
	arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb
	arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dtb

dwmmc0@ff808000: 'altr,sysmgr-syscon' is a required property
	arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb
	arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dtb

dwmmc0@ff808000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dtb

dwmmc0@ff808000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-sd-highspeed', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb

dwmmc0@ff808000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb
	arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb

mmc@ff808000: 'altr,sysmgr-syscon' is a required property
	arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb
	arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dtb
	arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb
	arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dtb

mmc@ff808000: Unevaluated properties are not allowed ('altr,dw-mshc-ciu-div', 'altr,dw-mshc-sdr-timing', 'iommus' were unexpected)
	arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dtb

mmc@ff808000: Unevaluated properties are not allowed ('iommus' was unexpected)
	arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb
	arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dtb
	arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dtb
	arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb
	arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dtb
	arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dtb

mmcsd@40004000: $nodename:0: 'mmcsd@40004000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/lpc4337-ciaa.dtb
	arch/arm/boot/dts/lpc4350-hitex-eval.dtb
	arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb
	arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb

mmcsd@40004000: clock-names:0: 'biu' was expected
	arch/arm/boot/dts/lpc4337-ciaa.dtb
	arch/arm/boot/dts/lpc4350-hitex-eval.dtb
	arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb
	arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb

mmcsd@40004000: clock-names:1: 'ciu' was expected
	arch/arm/boot/dts/lpc4337-ciaa.dtb
	arch/arm/boot/dts/lpc4350-hitex-eval.dtb
	arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb
	arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb

mmcsd@40004000: Unevaluated properties are not allowed ('bus-width', 'clock-names', 'resets', 'vmmc-supply' were unexpected)
	arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb
	arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb

mmcsd@40004000: Unevaluated properties are not allowed ('clock-names', 'resets' were unexpected)
	arch/arm/boot/dts/lpc4337-ciaa.dtb
	arch/arm/boot/dts/lpc4350-hitex-eval.dtb

