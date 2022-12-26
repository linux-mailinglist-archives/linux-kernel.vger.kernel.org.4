Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD06E65626D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiLZMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLZMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:08:56 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785622ACC;
        Mon, 26 Dec 2022 04:08:55 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4D273CA744;
        Mon, 26 Dec 2022 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672056533; bh=EdE0K1C4NRk7q6tfNodedMaUhUanKrhdHp5SURYtjGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pNsQu10x/8rB6Lu/iJerSu2Vav+ua0dacjVWKK8+AhMxgh2aggDJXozlEHQ21h4Hz
         v6YU0CYkCciETXyKmWnvCZct2FplYzHh+goB/kLFEW0SxH8zKLOXyVxbiRPCciq2U4
         xZIDMULRA+sSfc1yyaIqFkyFpFEzRV1ZYvxLiilc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>
Subject: Re: [PATCH 1/3] ARM: dts: qcom: pm8226: sort includes alphabetically and
 nodes by address
Date:   Mon, 26 Dec 2022 13:08:52 +0100
Message-ID: <2659686.mvXUDI8C0e@g550jk>
In-Reply-To: <20221223193403.781355-2-rayyan@ansari.sh>
References: <20221223193403.781355-1-rayyan@ansari.sh>
 <20221223193403.781355-2-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 23. Dezember 2022 20:34:01 CET Rayyan Ansari wrote:
> Sort the includes and nodes for consistency.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi index 9b7d9d04ded6..d99532ea70b2
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> 
>  &spmi_bus {
>  	pm8226_0: pm8226@0 {
> @@ -41,13 +41,6 @@ smbb: charger@1000 {
>  			chg_otg: otg-vbus { };
>  		};
> 
> -		rtc@6000 {
> -			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>, <0x6100>;
> -			reg-names = "rtc", "alarm";
> -			interrupts = <0x0 0x61 0x1 
IRQ_TYPE_EDGE_RISING>;
> -		};
> -
>  		pm8226_vadc: adc@3100 {
>  			compatible = "qcom,spmi-vadc";
>  			reg = <0x3100>;
> @@ -81,6 +74,13 @@ adc-chan@f {
>  			};
>  		};
> 
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 
IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		pm8226_mpps: mpps@a000 {
>  			compatible = "qcom,pm8226-mpp", "qcom,spmi-
mpp";
>  			reg = <0xa000>;




