Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC061E00F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 03:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKFC5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 22:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 22:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B2FCCC;
        Sat,  5 Nov 2022 19:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 196EC60BDE;
        Sun,  6 Nov 2022 02:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B793C433D6;
        Sun,  6 Nov 2022 02:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667703419;
        bh=OxCmvoAiWJ7eX5jbg8wqKgFMCNgFHPCFJ3WmR4oO6wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUkadnWNL31eAF7V1a20xeGAsI056SUVEz4XUD5ibGYMgQqLO0tADYxSzwgvYknNn
         9VHuKT18ZW8dYBqOUR/OAG7Z5U6RMGP2N5V5wRFW3O3B4KwS9W3RUT4fuV1n+4lISr
         fIQ6OMf4hsetrSTVm23ezMLjbziO6V/cO/vyG9JTH7U8/Ik7h2U6ankBZE5DXSEBOx
         7Kg3iQoS2pdOJy2C5bVsgA1vOUYDjFz6EHlT5tW432XFJU9C+mBjeEsIQEkS1BWYhM
         Ui1hp2ri2NgAgferRuC417AvCIJbmH10712oMJw2wbCVUy3yoN7/CL93+6g8Y+7DKd
         eB2CMECZwQYBw==
Date:   Sat, 5 Nov 2022 21:56:56 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "Lin, Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: msm8916-samsung-j5-common: Add
 initial common device tree
Message-ID: <20221106025656.5s6bwcuk2blv5tvm@builder.lan>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
 <20220928121717.102402-1-linmengbo0689@protonmail.com>
 <20220928123816.104641-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928123816.104641-1-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:39:46PM +0000, Lin, Meng-Bo wrote:
> The smartphones below are using the MSM8916 SoC,
> which are released in 2015-2016:
> 
> Samsung Galaxy J5 2015 (SM-J500*)
> Samsung Galaxy J5 2016 (SM-J510*)
> Samsung Galaxy J3 2016
> - SM-J3109/SM-J320Y/SM-J320YZ
> - SM-J320N0/SM-J320ZN
> - SM-J320P/SM-J320R4/SM-J320V/SM-S320VL
> 
> Add a common device tree for with initial support for:
> 

I'm afraid I don't think this, or the $subject, reflects what you're
actually doing in this change.

This should say something about moving the J5 device definition to a
common file, so that it could be reused in other related devices.

> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART (on USB connector via the SM5703 MUIC)
> - WCNSS (WiFi/BT)
> - Regulators
> 
> The three devices (some varints of J3, all other variants of J5 released
> in 2015 and J5X released in 2016) are very similar, with some differences
> in display and GPIO pins. The common parts are shared in
> msm8916-samsung-j5-common.dtsi to reduce duplication.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  ...6-samsung-j5.dts => msm8916-samsung-j5-common.dtsi} | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>  rename arch/arm64/boot/dts/qcom/{msm8916-samsung-j5.dts => msm8916-samsung-j5-common.dtsi} (94%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> similarity index 94%
> rename from arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> rename to arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> index eabeed18cfaa..4f71609bf6f8 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi

With this movewe have the Makefile referencing a file that doesn't
exist. Please introduce msm8916-samsung-j5.dts in the same commit.

> @@ -1,15 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> 
> -/dts-v1/;
> -
>  #include "msm8916-pm8916.dtsi"
> +
>  #include <dt-bindings/gpio/gpio.h>
>  
> 
>  / {
> -	model = "Samsung Galaxy J5 (2015)";
> -	compatible = "samsung,j5", "qcom,msm8916";
> -	chassis-type = "handset";
> -
>  	aliases {
>  		serial0 = &blsp1_uart2;
>  	};
> @@ -92,7 +87,6 @@ &usb {
>  
> 
>  &usb_hs_phy {
>  	extcon = <&pm8916_usbin>;
> -	qcom,init-seq = /bits/ 8 <0x1 0x19 0x2 0x0b>;
>  };
>  
> 
>  &smd_rpm_regulators {
> @@ -199,7 +193,7 @@ l18 {
>  };
>  
> 
>  &msmgpio {
> -	gpio_keys_default: gpio-keys-default {
> +	gpio_keys_default: gpio-keys-default-state {

This is a good, but unrelated change.

Thanks,
Bjorn

>  		pins = "gpio107", "gpio109";
>  		function = "gpio";
>  
> 
> -- 
> 
> 2.30.2
> 

