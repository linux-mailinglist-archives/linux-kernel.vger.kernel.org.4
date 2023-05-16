Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20219704C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjEPLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjEPLM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:12:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F919015
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso69439435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235412; x=1686827412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QDbJK0mn7DubrzqluvREfFk7e2EK90hP2aDsHEEgRU=;
        b=amodcCNODgCh+4Bzi24ukKAKMXmpv13v3wwGBwoDPCxbXXReeqske9wxoyET8VE0B2
         gWB1NBn9kPp4hRwKc7SHzRpqLvTRutkIEcX6KVmcI3OoTtc4G+o9YMtjXUbnDjh5mM/2
         CdUDBfM1BHes+2YIrmdjY9EPi5banbTbeTz9iwhU01TamjGi8SLnJVjz373J4GfASyad
         mWkSpMtnNFYVjRqefnq3HRhWKZqQXKf+9nwYy/Nm5jB8wu+Q8XddemHKhzXKZnDD7aWV
         A7ezmKFtZibCS9HI69X2NINAtqJBUz1vHYkkNFf25KSUoI55c+rraq1FvyNLeClPWz66
         KNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235412; x=1686827412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QDbJK0mn7DubrzqluvREfFk7e2EK90hP2aDsHEEgRU=;
        b=hOpP+t4wwCdDISm/Y6LLj/gsv6ikjEUo4fIJ40yRPZhLroWEDw0M9pUC0qopvIfiHE
         gVEGUXo/Y+XBBMrUgHbltYIG38CQEfi3CwP858s/U0fiK/fyMwkS2d1zv5+Pn6zlWHx5
         QbiRO/zZAaMDGVIYBHHl3ZWOcGr3oh0clH/U0Pylv0URVFq6cdQ20HntWpKbzVUB4dd5
         WFrJo8+S7ZF+KGF0RUFHu65Rbb8vUhy0a/4FAc8N9xohTcknIAKR417S/7nvgU8CVeZD
         Lz3l/sD1nJjDu/gwJIncnwiveoWvpMgHFYmhFf/8hdqJKTEu4sDbw2nZZjIpeAN21+Cf
         LI9w==
X-Gm-Message-State: AC+VfDyUFuQnSL1vEmb3z/+bx9Dxrf4NTONwV/pnzePCWMCoPvs8HpYh
        gBD0bXxnC7vF67bTrTKGBm+JRw==
X-Google-Smtp-Source: ACHHUZ4EM9gTfx0MR1mjuYwNFE8DxzS+CitELUsIQwHC6lAyqhirl5hwO1M9+lkTBFocoG78cioU6g==
X-Received: by 2002:a05:600c:2182:b0:3f4:2255:8608 with SMTP id e2-20020a05600c218200b003f422558608mr21806562wme.31.1684235412597;
        Tue, 16 May 2023 04:10:12 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc314000000b003f182cc55c4sm2000673wmj.12.2023.05.16.04.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:10:12 -0700 (PDT)
Message-ID: <0c3b4861-43d9-f1b6-68d8-f55943fdf1d4@monstr.eu>
Date:   Tue, 16 May 2023 13:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 21/23] arm64: zynqmp: Enable AMS on SOM and other zcu10x
 boards
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <e1e1621ac1cee7f36ef20606bb3795e130de9609.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <e1e1621ac1cee7f36ef20606bb3795e130de9609.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> AMS is used for monitoring system. Used for measuring voltages and
> especially temperatures. Origin interface is IIO but via iio-hwmon it can
> be moved to hwmon framework too (done for SOM and zcu100).
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 26 +++++++++++++++++++
>   .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 17 ++++++++++++
>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 12 +++++++++
>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 12 +++++++++
>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 12 +++++++++
>   5 files changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index e284979fd7b1..78ff6a9b3144 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -76,6 +76,20 @@ ds36-led {
>   			default-state = "on";
>   		};
>   	};
> +
> +	ams {
> +		compatible = "iio-hwmon";
> +		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
> +			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
> +			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
> +			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
> +			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
> +			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
> +			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
> +			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
> +			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
> +			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
> +	};
>   };
>   
>   &modepin_gpio {
> @@ -327,6 +341,18 @@ &gpio {
>   			  "", "", "", ""; /* 170 - 173 */
>   };
>   
> +&xilinx_ams {
> +	status = "okay";
> +};
> +
> +&ams_ps {
> +	status = "okay";
> +};
> +
> +&ams_pl {
> +	status = "okay";
> +};
> +
>   &zynqmp_dpsub {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index c99abb99efcb..c8be41d77cb9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -59,6 +59,15 @@ switch-4 {
>   		};
>   	};
>   
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
> +			      <&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
> +			      <&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
> +			      <&xilinx_ams 9>, <&xilinx_ams 10>,
> +			      <&xilinx_ams 11>, <&xilinx_ams 12>;
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		led-ds2 {
> @@ -581,6 +590,14 @@ &watchdog0 {
>   	status = "okay";
>   };
>   
> +&xilinx_ams {
> +	status = "okay";
> +};
> +
> +&ams_ps {
> +	status = "okay";
> +};
> +
>   &zynqmp_dpdma {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 5b6403865541..b2e1f3581f6b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -1027,6 +1027,18 @@ &watchdog0 {
>   	status = "okay";
>   };
>   
> +&xilinx_ams {
> +	status = "okay";
> +};
> +
> +&ams_ps {
> +	status = "okay";
> +};
> +
> +&ams_pl {
> +	status = "okay";
> +};
> +
>   &zynqmp_dpdma {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index a74a2061431a..1f30c37c2e03 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -511,6 +511,18 @@ &watchdog0 {
>   	status = "okay";
>   };
>   
> +&xilinx_ams {
> +	status = "okay";
> +};
> +
> +&ams_ps {
> +	status = "okay";
> +};
> +
> +&ams_pl {
> +	status = "okay";
> +};
> +
>   &zynqmp_dpdma {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 73972d83ed4d..474744278b97 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -523,6 +523,18 @@ &watchdog0 {
>   	status = "okay";
>   };
>   
> +&xilinx_ams {
> +	status = "okay";
> +};
> +
> +&ams_ps {
> +	status = "okay";
> +};
> +
> +&ams_pl {
> +	status = "okay";
> +};
> +
>   &zynqmp_dpdma {
>   	status = "okay";
>   };

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
