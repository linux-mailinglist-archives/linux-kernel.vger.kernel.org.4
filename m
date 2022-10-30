Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28864612D21
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJ3WCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ3WB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:01:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C35C6173;
        Sun, 30 Oct 2022 15:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F18C1B8106E;
        Sun, 30 Oct 2022 22:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0464C43470;
        Sun, 30 Oct 2022 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667167313;
        bh=PTddCbOvBcGoJz9y6uoPrxjHNey64Rs4moExDo18JNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oBj+p4LD61npVqFTDN/1z67vIhtPjMl3nm9Bw85cdKp2SsodE1hdREk/tDZ7SXfr2
         MHMgNu9iKmezbLwTugt02OGnKJsaczKeaauODrE1ZxYOJxDCepsbkBMJJ5DISprNWt
         gz/Cf3Ub6wQoJfR5bENJp3bXySIAwc2Q8nyP7gmUu5InE5N3LFj/+9s5rxeA8FxWV7
         GIpb+Uluiu5oabZEdVuZH8zxx2mNnixkQKojweQLYpEGGAxYwclUYE2ywppcx6rWd0
         6awfqJmVaO8FozNfmDFzWE4sqd68GKDGci9UxvpBqBgb5WJmcZSPnmmhzCls3YU4yu
         Ht8ELXerH7yNg==
Received: by mail-lf1-f41.google.com with SMTP id f37so16625228lfv.8;
        Sun, 30 Oct 2022 15:01:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf2ifE0WEKPkw66GY2cAgbAJ+8mC2JEZ/PcDGRlUZc9N+AgurfQp
        PRFzc5jW7OQmFqnb4QvND5HxkFGSBBvHBFxhiQ==
X-Google-Smtp-Source: AMsMyM7bW4oZVcI6LfaIeb+D2pMd4aIh+5780YF8WjoT6K4m0oJ3/Jwzr5TWckfqyNhNSgM9wxkKYBm/MKYXrTTj2L8=
X-Received: by 2002:a19:f24b:0:b0:4ab:cd12:d282 with SMTP id
 d11-20020a19f24b000000b004abcd12d282mr4215098lfk.74.1667167311542; Sun, 30
 Oct 2022 15:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221030194311.197909-1-a39.skl@gmail.com> <20221030194311.197909-2-a39.skl@gmail.com>
In-Reply-To: <20221030194311.197909-2-a39.skl@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 30 Oct 2022 17:01:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3Yq53m6D_eELurkJjDCWZuvMtACbUnqpLymWAuFh=OQ@mail.gmail.com>
Message-ID: <CAL_JsqL3Yq53m6D_eELurkJjDCWZuvMtACbUnqpLymWAuFh=OQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: qcom: Add MSM8976 device tree
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 2:43 PM Adam Skladowski <a39.skl@gmail.com> wrote:
>
> Add a base DT for MSM8976 SoC.
>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 1357 +++++++++++++++++++++++++
>  1 file changed, 1357 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> new file mode 100644
> index 0000000000000..461593eb04635
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -0,0 +1,1357 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8976.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +       interrupt-parent = <&intc>;
> +
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       chosen { };
> +
> +       clocks {

Drop the container node.

> +               sleep_clk: sleep-clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <32768>;
> +               };
> +
> +               xo_board: xo-board {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <19200000>;
> +                       clock-output-names = "xo";
> +               };
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               CPU0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };

The cpu node is also the L1 cache(s). You've got a mixture here with
'next-level-cache' in the cpu node. Drop these nodes.

> +               };
> +
> +               CPU1: cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x1>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               CPU2: cpu@2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x2>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               CPU3: cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x3>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               CPU4: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x100>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1830>;
> +                       next-level-cache = <&L2_1>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               CPU5: cpu@101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x101>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1830>;
> +                       next-level-cache = <&L2_1>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               CPU6: cpu@102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x102>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1830>;
> +                       next-level-cache = <&L2_1>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               CPU7: cpu@103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x103>;
> +                       enable-method = "psci";
> +                       capacity-dmips-mhz = <1830>;
> +                       next-level-cache = <&L2_1>;
> +                       #cooling-cells = <2>;
> +
> +                       l1-icache {
> +                               compatible = "cache";
> +                       };
> +                       l1-dcache {
> +                               compatible = "cache";
> +                       };
> +               };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&CPU0>;
> +                               };
> +                               core1 {
> +                                       cpu = <&CPU1>;
> +                               };
> +                               core2 {
> +                                       cpu = <&CPU2>;
> +                               };
> +                               core3 {
> +                                       cpu = <&CPU3>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu = <&CPU4>;
> +                               };
> +                               core1 {
> +                                       cpu = <&CPU5>;
> +                               };
> +                               core2 {
> +                                       cpu = <&CPU6>;
> +                               };
> +                               core3 {
> +                                       cpu = <&CPU7>;
> +                               };
> +                       };
> +               };
> +
> +               L2_0: l2-cache_0 {
> +                       compatible = "cache";
> +                       cache-level = <2>;

Unified? Needs 'unified-cache' property.

> +               };
> +
> +               L2_1: l2-cache_1 {
> +                       compatible = "cache";
> +                       cache-level = <2>;
> +               };
> +       };
> +
> +       firmware {
> +               scm: scm {
> +                       compatible = "qcom,scm-msm8976", "qcom,scm";
> +                       clocks = <&gcc GCC_CRYPTO_CLK>,
> +                                <&gcc GCC_CRYPTO_AXI_CLK>,
> +                                <&gcc GCC_CRYPTO_AHB_CLK>;
> +                       clock-names = "core", "bus", "iface";
> +                       #reset-cells = <1>;
> +               };
> +       };
> +
> +       memory {

Needs a unit-address.

> +               device_type = "memory";
> +               /* We expect the bootloader to fill in the reg */

Isn't the base address known?

> +               reg = <0 0 0 0>;
> +       };
