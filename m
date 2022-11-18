Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DE62FBD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiKRRmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbiKRRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:42:02 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388DF205EA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:42:01 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A36E3F135
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668793319;
        bh=qLey4Ba7Mxtw0us/UV6dihBauJ7yWiM395MsIE8wApA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vAByh9F9prD5C7jVoI5WllEShDhDZ7e4Ybt6a+XIagpttImpkVskNrCmyB2MXrUun
         a1Zs9saHmBnBRWPZuzt4BcfdshnhpAQL4xBfpJN2QCAewYm4nT8TB0FzLwznE1vHtK
         2wkMyePj1qThlKQCAE5dy7JcuHF62kBwlqrlewmL9jXpbJhGtMECq3IIEC96wGQEx8
         VaZAXGPSm2wlsXfzy5eRh5jWeF28cKpHM6rJ2w8B2wx/ABTL4moTlLbN8byqAh3xZ0
         VeuGYkIFqJ2zGupmekr3BaW7k4l+fpbXWz6fC6puZf8iiduVVAwbn66UdrN01/dofJ
         /DIkiLlWiGNWQ==
Received: by mail-yb1-f198.google.com with SMTP id f8-20020a25bd88000000b006dda2c86272so5032272ybh.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLey4Ba7Mxtw0us/UV6dihBauJ7yWiM395MsIE8wApA=;
        b=XnCvmDbsBAon4h1RwnttORw772OR0GltS+xPspZf6m0+Rtf/IIURkRUL7xnaYXJgd2
         TC+pJbwUiNspLRPQed/fg8AYtZfJ6mOz6FXCLqR/dS3/yHlg1KoV+tsTYGQjOl3IN0dT
         FWZNalkXZTjubCWOwraPHLrRy3jj810yWvkAArcCZxEPahlyur2Rt/QIywsHRGdwVwYP
         nPd5femESDn+hGAPJbUPYcpIPE3XMLXTfSx+S6YIZlf9bhsdyH7LqV/A+7H1qPZAO04Z
         DfmB1Dlf47w5NCdNb9Wijrq6+ILYcOGlG92jfhbBFebhPCxnTZGesY1F8ZwIGHKO6ROP
         2sPg==
X-Gm-Message-State: ANoB5pndqqMS64BpnWfdHHxGWHOZfmg1HjvaUdy7gcDcZCmSZ+ImPii5
        giWHWYpMX+xstzC2pQxGfFb1D3T2tmlHzgD6bGDOA3Su6FpUhawFVoX6VEzRxe5B3SszuhU67OU
        jlbxDqJxvAHyiN0v23wdBlnv/akXo6DlAXk59EcvciyvCo+DNajIoXIVvyQ==
X-Received: by 2002:a81:f805:0:b0:378:5e3a:8fad with SMTP id z5-20020a81f805000000b003785e3a8fadmr7457706ywm.78.1668793318237;
        Fri, 18 Nov 2022 09:41:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4PkW+6KwpVvLH2wd9J3iZgdBdQhcmyZXoHDHAcHA8dDEtYWlt6rNtwZ6kj+9lJNFCDSMCd2DTRoG1ielpT8Rg=
X-Received: by 2002:a81:f805:0:b0:378:5e3a:8fad with SMTP id
 z5-20020a81f805000000b003785e3a8fadmr7457682ywm.78.1668793317939; Fri, 18 Nov
 2022 09:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20221118011714.70877-1-hal.feng@starfivetech.com> <20221118011714.70877-7-hal.feng@starfivetech.com>
In-Reply-To: <20221118011714.70877-7-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 18:41:41 +0100
Message-ID: <CAJM55Z9PXVLfFTPuyELR4ov22ENfEXZfJAJdLgURA+R4mcH_eg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 02:17, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> Add initial device tree for the JH7110 RISC-V SoC by StarFive
> Technology Ltd.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 437 +++++++++++++++++++++++
>  1 file changed, 437 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> new file mode 100644
> index 000000000000..c22e8f1d2640
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/starfive-jh7110.h>
> +#include <dt-bindings/reset/starfive-jh7110.h>
> +
> +/ {
> +       compatible = "starfive,jh7110";
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               S76_0: cpu@0 {
> +                       compatible = "sifive,u74-mc", "riscv";
> +                       reg = <0>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <8192>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <40>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <16384>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <40>;
> +                       mmu-type = "riscv,sv39";
> +                       next-level-cache = <&ccache>;
> +                       riscv,isa = "rv64imac";
> +                       tlb-split;
> +                       status = "disabled";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
> +               U74_1: cpu@1 {
> +                       compatible = "sifive,u74-mc", "riscv";
> +                       reg = <1>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <40>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <40>;
> +                       mmu-type = "riscv,sv39";
> +                       next-level-cache = <&ccache>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +
> +                       cpu1_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
> +               U74_2: cpu@2 {
> +                       compatible = "sifive,u74-mc", "riscv";
> +                       reg = <2>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <40>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <40>;
> +                       mmu-type = "riscv,sv39";
> +                       next-level-cache = <&ccache>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +
> +                       cpu2_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
> +               U74_3: cpu@3 {
> +                       compatible = "sifive,u74-mc", "riscv";
> +                       reg = <3>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <40>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <40>;
> +                       mmu-type = "riscv,sv39";
> +                       next-level-cache = <&ccache>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +
> +                       cpu3_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
> +               U74_4: cpu@4 {
> +                       compatible = "sifive,u74-mc", "riscv";
> +                       reg = <4>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <40>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <40>;
> +                       mmu-type = "riscv,sv39";
> +                       next-level-cache = <&ccache>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +
> +                       cpu4_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&S76_0>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&U74_1>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&U74_2>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&U74_3>;
> +                               };
> +
> +                               core4 {
> +                                       cpu = <&U74_4>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       osc: osc {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       clk_rtc: clk_rtc {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       gmac0_rmii_refin: gmac0_rmii_refin {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       gmac0_rgmii_rxin: gmac0_rgmii_rxin {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       gmac1_rmii_refin: gmac1_rmii_refin {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       gmac1_rgmii_rxin: gmac1_rgmii_rxin {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       i2stx_bclk_ext: i2stx_bclk_ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       i2stx_lrck_ext: i2stx_lrck_ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       i2srx_bclk_ext: i2srx_bclk_ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       i2srx_lrck_ext: i2srx_lrck_ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       tdm_ext: tdm_ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       mclk_ext: mclk_ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };
> +
> +       soc {

Please sort these nodes after their address like the jh7100.dtsi.
That is sort the nodes after @<number>.

> +               compatible = "simple-bus";
> +               interrupt-parent = <&plic>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               clint: clint@2000000 {
> +                       compatible = "starfive,jh7110-clint", "sifive,clint0";
> +                       reg = <0x0 0x2000000 0x0 0x10000>;
> +                       interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +                                             <&cpu1_intc 3>, <&cpu1_intc 7>,
> +                                             <&cpu2_intc 3>, <&cpu2_intc 7>,
> +                                             <&cpu3_intc 3>, <&cpu3_intc 7>,
> +                                             <&cpu4_intc 3>, <&cpu4_intc 7>;
> +               };
> +
> +               plic: plic@c000000 {
> +                       compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
> +                       reg = <0x0 0xc000000 0x0 0x4000000>;
> +                       interrupts-extended = <&cpu0_intc 11>,
> +                                             <&cpu1_intc 11>, <&cpu1_intc 9>,
> +                                             <&cpu2_intc 11>, <&cpu2_intc 9>,
> +                                             <&cpu3_intc 11>, <&cpu3_intc 9>,
> +                                             <&cpu4_intc 11>, <&cpu4_intc 9>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +                       #address-cells = <0>;
> +                       riscv,ndev = <136>;
> +               };
> +
> +               ccache: cache-controller@2010000 {
> +                       compatible = "starfive,jh7110-ccache", "cache";
> +                       reg = <0x0 0x2010000 0x0 0x4000>;
> +                       interrupts = <1>, <3>, <4>, <2>;
> +                       cache-block-size = <64>;
> +                       cache-level = <2>;
> +                       cache-sets = <2048>;
> +                       cache-size = <2097152>;
> +                       cache-unified;
> +               };
> +
> +               syscrg: clock-controller@13020000 {
> +                       compatible = "starfive,jh7110-syscrg";
> +                       reg = <0x0 0x13020000 0x0 0x10000>;
> +                       clocks = <&osc>, <&gmac1_rmii_refin>,
> +                                <&gmac1_rgmii_rxin>,
> +                                <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> +                                <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> +                                <&tdm_ext>, <&mclk_ext>;
> +                       clock-names = "osc", "gmac1_rmii_refin",
> +                                     "gmac1_rgmii_rxin",
> +                                     "i2stx_bclk_ext", "i2stx_lrck_ext",
> +                                     "i2srx_bclk_ext", "i2srx_lrck_ext",
> +                                     "tdm_ext", "mclk_ext";
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
> +               aoncrg: clock-controller@17000000 {
> +                       compatible = "starfive,jh7110-aoncrg";
> +                       reg = <0x0 0x17000000 0x0 0x10000>;
> +                       clocks = <&osc>, <&clk_rtc>,
> +                                <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
> +                                <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
> +                                <&syscrg JH7110_SYSCLK_APB_BUS_FUNC>,
> +                                <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;
> +                       clock-names = "osc", "clk_rtc", "gmac0_rmii_refin",
> +                                     "gmac0_rgmii_rxin", "stg_axiahb",
> +                                     "apb_bus_func", "gmac0_gtxclk";
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
> +               gpio: gpio@13040000 {
> +                       compatible = "starfive,jh7110-sys-pinctrl";
> +                       reg = <0x0 0x13040000 0x0 0x10000>;
> +                       reg-names = "control";
> +                       clocks = <&syscrg JH7110_SYSCLK_IOMUX>;
> +                       resets = <&syscrg JH7110_SYSRST_IOMUX>;
> +                       interrupts = <86>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
> +
> +               gpioa: gpio@17020000 {
> +                       compatible = "starfive,jh7110-aon-pinctrl";
> +                       reg = <0x0 0x17020000 0x0 0x10000>;
> +                       reg-names = "control";
> +                       resets = <&aoncrg JH7110_AONRST_AON_IOMUX>;
> +                       interrupts = <85>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
> +
> +               uart0: serial@10000000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x0 0x10000000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
> +                                <&syscrg JH7110_SYSCLK_UART0_APB>;
> +                       clock-names = "baudclk", "apb_pclk";
> +                       resets = <&syscrg JH7110_SYSRST_UART0_APB>;
> +                       interrupts = <32>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +
> +               uart1: serial@10010000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x0 0x10010000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_UART1_CORE>,
> +                                <&syscrg JH7110_SYSCLK_UART1_APB>;
> +                       clock-names = "baudclk", "apb_pclk";
> +                       resets = <&syscrg JH7110_SYSRST_UART1_APB>;
> +                       interrupts = <33>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +
> +               uart2: serial@10020000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x0 0x10020000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_UART2_CORE>,
> +                                <&syscrg JH7110_SYSCLK_UART2_APB>;
> +                       clock-names = "baudclk", "apb_pclk";
> +                       resets = <&syscrg JH7110_SYSRST_UART2_APB>;
> +                       interrupts = <34>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +
> +               uart3: serial@12000000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x0 0x12000000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_UART3_CORE>,
> +                                <&syscrg JH7110_SYSCLK_UART3_APB>;
> +                       clock-names = "baudclk", "apb_pclk";
> +                       resets = <&syscrg JH7110_SYSRST_UART3_APB>;
> +                       interrupts = <45>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +
> +               uart4: serial@12010000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x0 0x12010000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_UART4_CORE>,
> +                                <&syscrg JH7110_SYSCLK_UART4_APB>;
> +                       clock-names = "baudclk", "apb_pclk";
> +                       resets = <&syscrg JH7110_SYSRST_UART4_APB>;
> +                       interrupts = <46>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +
> +               uart5: serial@12020000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x0 0x12020000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_UART5_CORE>,
> +                                <&syscrg JH7110_SYSCLK_UART5_APB>;
> +                       clock-names = "baudclk", "apb_pclk";
> +                       resets = <&syscrg JH7110_SYSRST_UART5_APB>;
> +                       interrupts = <47>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +       };
> +};
> --
> 2.38.1
>
