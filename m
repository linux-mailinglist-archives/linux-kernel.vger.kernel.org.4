Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25B5EC6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiI0Opn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiI0Oo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:44:57 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F521EC53;
        Tue, 27 Sep 2022 07:39:42 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id w22-20020a056830061600b006546deda3f9so6458966oti.4;
        Tue, 27 Sep 2022 07:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nHNtpCAaWTA+Dw1rB8DWK4iTvHhEsl/fXvnF+sWqJGE=;
        b=6tIH01wFRvdRI+3+HRGoF2zBflHVpTpBHVwBokJG1KsfXC+6Yw3sg+O2KcDCRUFHDn
         6RaJJAsbZSHhEsmyZ2wfUiVDwd0Fpj8D1cqM+PO+fMZ+SdUgd2RuKcM6TphPSrUJkfrZ
         SmfT/ZkqpzCJpdI+oFVLDStd4+Jh8hXPlW06A5s4tDmQWq3SaHXLCbfOq38R3Kc64eV0
         xd7ejaI1RMii7puGulK7UHrOGh8NZxDYLdKyaKN7SBfxZo9H6FvoiWUB7VE8Iff8RQ7y
         qsR6CafEFb/Dt5p39sRqFvm6hYn5eOuiI14D/V4ftEmjb1lKdYmDpN12Igbn2HOSpJ7j
         Mb5g==
X-Gm-Message-State: ACrzQf34PQsGRCVP1oke3abcdDNXTBlCqmeEioAZiZWWExDmtpGP86rM
        OXdYfB563sUXDl0pjF/y4Q==
X-Google-Smtp-Source: AMsMyM51dptMOCqAKMgLE0XdvFMaNAh3lePFweSpDIrTmzRRCm1I595197gtHOUPgx7aLj/EjOpKgw==
X-Received: by 2002:a05:6830:835:b0:65a:2135:c1b2 with SMTP id t21-20020a056830083500b0065a2135c1b2mr12638048ots.197.1664289561028;
        Tue, 27 Sep 2022 07:39:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z25-20020a9d7a59000000b0065af1b094dasm754159otm.28.2022.09.27.07.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:39:20 -0700 (PDT)
Received: (nullmailer pid 943215 invoked by uid 1000);
        Tue, 27 Sep 2022 14:39:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20220926140932.820050-1-dinguyen@kernel.org>
References: <20220926140932.820050-1-dinguyen@kernel.org>
Subject: Re: [PATCHv3 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Tue, 27 Sep 2022 09:39:18 -0500
Message-Id: <1664289558.354045.943214.nullmailer@robh.at.kernel.org>
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

On Mon, 26 Sep 2022 09:09:30 -0500, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>     "altr,socfpga-dw-mshc"
> v2: document "altr,sysmgr-syscon" in the MMC section
> ---
>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
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

dwmmc0@ff808000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dtb

dwmmc0@ff808000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'broken-cd', 'bus-width', 'cap-sd-highspeed', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb

dwmmc0@ff808000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'fifo-depth', 'resets' were unexpected)
	arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb
	arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb

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

