Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB11704BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjEPLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjEPLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:11:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB805591
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:10:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42711865eso64072985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235369; x=1686827369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7ZR8UG+ieKj3JI8V/RnQW1dE0jfj0Fs0lyJslk94NI=;
        b=j6OpFNI9o/QbyIczkVTX53Diwu88pxqxJWtDQEbl46cknBPbPkfGLTinPc5ovSvXYl
         iKfG8TGWXPAyypdQDGk16eyjwy51sOkGOA/8vzNO0IW/500mW1xHIHi/+Tb4KvtK/DVS
         f0VPJiUcI1mSNam5ZpNzX2Q43HAX1yDkpPlJMrjsVAsP/rj/Ft+cuI2kxqonMekC6pp2
         0e60pcnPK/FNkTJXWTUITOg3PMGafbuiF6eodsYxqjhau40571O4lLxTrKKVKluNJqXc
         w+1pfQKmaRYGFvFVU4Wf3yMgXeYGMH3kiSF2cZmxH4hA5S9qePHPh7FDhQ6zAAhBv0FF
         Zwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235369; x=1686827369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7ZR8UG+ieKj3JI8V/RnQW1dE0jfj0Fs0lyJslk94NI=;
        b=I/7EHyV6B5rUMj46ShNvTR/ESedcIULDn5VcM7PxaI5vCOkmOwIxRvJRrmtdHqm0VT
         UbKzhldrHAChvcwi6S/v699/zNEUdSStbgHc0vHA3m3u443CpXIKQskLhEaI26/sDfCQ
         0YBNBoQVkkfeBqLOy9JxqX7mI/vOR6DJEJCO0nKe/s1lqdXBQp+T1DzX70xCzZjJnbcV
         9wiBmWlT/ICJWNn+FRzRc0YErGZNyfimcVqEp10/C9xhCHG6P+BZzu5vilkJ01OVGEue
         anoDQEMHw6KHuB/4cQcowaToGFj8bW0Wpf/TE243K1MdRKEiAjZ/zRw9ySNJXtSKReUC
         8SDQ==
X-Gm-Message-State: AC+VfDx99JxTx98q/yn8OqeTEn0LvrBzpcTSHjoDeL1ic8XAIabp3/WQ
        e08YJxzdPNhNdRn45Pi+trlclQ==
X-Google-Smtp-Source: ACHHUZ4fC1HFypX/AruDUwpxcFLFCsG7Za5bjaArpiSk0P6YjSRfNNc8JWTulnzTpDy6MXGxQRiDVQ==
X-Received: by 2002:a05:600c:3655:b0:3f4:2cc7:aac5 with SMTP id y21-20020a05600c365500b003f42cc7aac5mr16156446wmq.9.1684235369047;
        Tue, 16 May 2023 04:09:29 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003f195d2f1a9sm1966436wmr.15.2023.05.16.04.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:09:28 -0700 (PDT)
Message-ID: <4a51d30f-7d20-b008-3d2f-1187fecbc4a5@monstr.eu>
Date:   Tue, 16 May 2023 13:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 18/23] arm64: zynqmp: Setup clock for DP and DPDMA
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <807e22371394222f728ff7d6b190a96a12145439.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <807e22371394222f728ff7d6b190a96a12145439.1683034376.git.michal.simek@amd.com>
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
> Clocks are coming from shared HW design where these frequencies should be
> aligned with PLL setup.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi       | 4 ++++
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 2 ++
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 2 ++
>   3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 681885c9bcbb..581221fdadf1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -248,10 +248,14 @@ &xilinx_ams {
>   
>   &zynqmp_dpdma {
>   	clocks = <&zynqmp_clk DPDMA_REF>;
> +	assigned-clocks = <&zynqmp_clk DPDMA_REF>; /* apll */
>   };
>   
>   &zynqmp_dpsub {
>   	clocks = <&zynqmp_clk TOPSW_LSBUS>,
>   		 <&zynqmp_clk DP_AUDIO_REF>,
>   		 <&zynqmp_clk DP_VIDEO_REF>;
> +	assigned-clocks = <&zynqmp_clk DP_STC_REF>,
> +			  <&zynqmp_clk DP_AUDIO_REF>,
> +			  <&zynqmp_clk DP_VIDEO_REF>;  /* rpll, rpll, vpll */
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index 817d756142ab..4f18b3efcced 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -99,10 +99,12 @@ &zynqmp_dpsub {
>   	status = "disabled";
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
> +	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
>   };
>   
>   &zynqmp_dpdma {
>   	status = "okay";
> +	assigned-clock-rates = <600000000>;
>   };
>   
>   &usb0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index e07cec231ee0..77bc806b15a1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -80,10 +80,12 @@ &zynqmp_dpsub {
>   	status = "disabled";
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
> +	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
>   };
>   
>   &zynqmp_dpdma {
>   	status = "okay";
> +	assigned-clock-rates = <600000000>;
>   };
>   
>   &usb0 {

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
