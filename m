Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CED72245A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFELPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjFELPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:15:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF68115
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:15:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso11915455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685963738; x=1688555738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1Xmo+yIXF4XYtaFhiebO0O3iBPHuUdmWJY6R6Wg63M=;
        b=36aRIHtwGAtdIBHGvPOMNSCdN1EmVXpaJ1spfHORJ6IBKq6DTqJwuMuIre+qg2Ll1o
         ZaBFWOD70CZMnw7nog5wKXSub+NfSOEgZLODn2ezyv20EfDXryAqDLtgPPpf7VbfUMCE
         NWRGoqm/3oupdqoN1H3KQPtdy5gEAaDQe12RQCi3Fw94GDlukxdJYKa2aAbCP4kT1sBq
         eR3Q+1bRxVT6iePh26QrJpQoqwSL/abx/BMYEpEnCOOa2x21YtLwEfx++Ff0jt8cCZoq
         p4krVxjy/wMvj+BcH/pE6I2P9VtOiU4K+xKrF2Xg/cIV14CIRIP4q22B+LISwq/tU9+5
         a26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963738; x=1688555738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Xmo+yIXF4XYtaFhiebO0O3iBPHuUdmWJY6R6Wg63M=;
        b=KOpwCHA1k88JqhwcYmQHtRbBgtuyyCSHFY3dusdeUA/PCIBR/H8LniSk5HjkVOQH5K
         a8NxIszKKubwbNbAVtwqW1U3wdJEZ3qKLDWb7yTXt9H+7dv6pi5/+Z/GCxSU9KM7F+ak
         tOPitu2GdTBd1p6C5mGLR6FAqCIL3LVW/2kYHOdaHphq0GfqH3TsyKsir/7CC11j5JuI
         nLRvQ+xNnO57l7JAIJCLI+ekH33z1Fg5MiDAb9TPAxtzfA5+IKldU0iejioqGx7SMm+n
         Dg12Ly1ZBM7XwXJoV6/Y02EvoI5ICICG254HZHgBFIpukfs59vfCf852hoLsGLyTWvaZ
         NsiA==
X-Gm-Message-State: AC+VfDw8wip3v4eM+RsYaqC63yDW0MGHBorlNSd0aQ9BrpTMAu1e7QT9
        efk5NZJhSuapLwUb072Oji8TUD+b7ieLgD4qQpdzig==
X-Google-Smtp-Source: ACHHUZ6ZqSdenPheYGWF90dnTCbhBYRfgLnGcB9T26Gmq49I5qPyz6uPlVTCoIK5oCxZbwo7G2tKkA==
X-Received: by 2002:a05:600c:2114:b0:3f7:367a:bd28 with SMTP id u20-20020a05600c211400b003f7367abd28mr3288295wml.4.1685963738635;
        Mon, 05 Jun 2023 04:15:38 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b003047dc162f7sm9477645wrw.67.2023.06.05.04.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:15:37 -0700 (PDT)
Message-ID: <29a7c14d-cf30-b6f5-7131-4ee6c42d1039@monstr.eu>
Date:   Mon, 5 Jun 2023 13:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/6] arm64: zynqmp: Describe TI phy as ethernet-phy-id
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1684767562.git.michal.simek@amd.com>
 <b49904649a363f40dc9c4d3fa275e42129562082.1684767562.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <b49904649a363f40dc9c4d3fa275e42129562082.1684767562.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 16:59, Michal Simek wrote:
> TI DP83867 is using strapping based on MIO pins. Tristate setup can
> influence PHY address. That's why switch description with ethernet-phy-id
> compatible string which enable calling reset. PHY itself setups phy address
> after power up or reset. Phy reset is done via gpio.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - fix typo in commit message
> 
> Checkpatch is reporting issue
> warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented
> but it should be fully aligned with
> Documentation/devicetree/bindings/net/ethernet-phy.yaml
> 
> c&p more details from v1 version:
> Phy has some pins which is using for strapping for phy address after phy
> reset or power on. Pretty much it is resistor array which based on
> datasheet is decoded to certain phy address.
> And because some phy pins are also used as data pin for RGMII they are
> connected via MIO pins on a silicon. That's why IO block output setting
> really matter here because it changes resistor array and it moves phy
> address.
> That's why there is a need to do proper IO pin setup and after it call phy
> reset to get it to address which was decided by PCB designer.
> 
> ---
>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 23 +++++++++++------
>   .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    | 25 +++++++++++--------
>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 22 ++++++++++------
>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 22 ++++++++++------
>   .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 ++++++++++------
>   .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 22 ++++++++++------
>   6 files changed, 90 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 230ef94d5dcb..f36353a51863 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU102 RevA
>    *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -200,13 +201,19 @@ &gem3 {
>   	phy-mode = "rgmii-id";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@21 {
> -		reg = <21>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> -		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@21 {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <21>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> index 63419deb5b33..3c28130909bc 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU102 RevB
>    *
> - * (C) Copyright 2016 - 2021, Xilinx, Inc.
> + * (C) Copyright 2016 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -16,16 +17,20 @@ / {
>   
>   &gem3 {
>   	phy-handle = <&phyc>;
> -	phyc: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> -		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
> +	mdio: mdio {
> +		phyc: ethernet-phy@c {
> +			#phy-cells = <0x1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
> +		/* Cleanup from RevA */
> +		/delete-node/ ethernet-phy@21;
>   	};
> -	/* Cleanup from RevA */
> -	/delete-node/ ethernet-phy@21;
>   };
>   
>   /* Fix collision with u61 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index d178a4f898c9..3fd47725c2c8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU104
>    *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -109,12 +110,19 @@ &gem3 {
>   	phy-mode = "rgmii-id";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 38b11594c074..4f6429caecff 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU104
>    *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -114,12 +115,19 @@ &gem3 {
>   	phy-mode = "rgmii-id";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 8af0879806cf..8c3fa3fe28d5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU106
>    *
> - * (C) Copyright 2016 - 2021, Xilinx, Inc.
> + * (C) Copyright 2016 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -212,12 +213,19 @@ &gem3 {
>   	phy-mode = "rgmii-id";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			reg = <0xc>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index f76687914e30..0d9b6081dff6 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU111
>    *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -172,12 +173,19 @@ &gem3 {
>   	phy-mode = "rgmii-id";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u22 6 GPIO_ACTIVE_LOW>;
> +		};
>   	};
>   };
>   

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
