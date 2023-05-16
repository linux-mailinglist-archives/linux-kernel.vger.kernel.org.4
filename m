Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DC704BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjEPLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjEPLI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:08:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF18728F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:08:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f427118644so94562195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235251; x=1686827251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KU5WlCzmRwmoHMk2xokamIV5/fVgApFuQXhDquHvka0=;
        b=hCch0dIiZJloMlgxsOtcFPlFrY1ySZGVo136fQx2xiMEBKXwX8CVXAPRfS0AnLtB5T
         YdCU97z4dwElRiySxUT54XPPUhzuol9dkJMk/91YmRiSu+H3rrJXSqDx/OgDVk80yVQc
         AFqaBazp5VkRJ304Ycun4fjl7zj0dp65Aw2MDISVgtTbB1T/uHoa1SP1+VaqoZLtkMeg
         v3NrQ5CmDokWd2p3m7CC0ZX7sVWZOEsi1tmPXL8gnLihdOHs6pm6RpNf++Sr7UUrwySa
         +P6VRtTd1d3GwTNPsMJpNEz74fmPMjurSkikRocDAofNYWoy4FErUmhjZxkfMXSL6/v/
         7NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235251; x=1686827251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KU5WlCzmRwmoHMk2xokamIV5/fVgApFuQXhDquHvka0=;
        b=ARRCt8U/g5uNJdH2nHrp2zFzQOmBLKphfAbrHHX5a4D5KwMcUrD3nua0yW0FMw9IDX
         MZSA2cfRqRlz8zOVWYTQAgbWUYUaARXhajZWSUEp/siH23joUstlZNqjpFBx3JCvQsg6
         dO4JRJROVRYZ566C0ANQhZ0KoIoq32ys1AJXVhRh57De0RWpuvHxX9ZTZ4po/3THm1tR
         MMRO/Y5uArBMpiIC6br/nTL+qO5VZ8VO0Y2h5iawZCGOKy4w2m1hRn2jV4SyIpMe2v5L
         l0CbOBfEw2vz2tNM04qx7eXLs0wV260EsgOI3HAkhJO1CYAjFoeyjcIBJhhXC+r8DHxh
         AGmA==
X-Gm-Message-State: AC+VfDxtFSYNPQrUKcKqoyFYYBpqQZhjCETOgptagWV3B6X6WhWE3MRb
        ZAtZjaWYH5S/8CCkgMjz5kAQ+g==
X-Google-Smtp-Source: ACHHUZ5CEHd2a0PLvKsoXYid+Ep6ZFZ0fDNQRAfFLZF/XoRw/tRX0n0hK0oPRW1Fq6YUk58Y8TgUTQ==
X-Received: by 2002:a7b:c345:0:b0:3f5:f83:4d72 with SMTP id l5-20020a7bc345000000b003f50f834d72mr3849558wmj.38.1684235250875;
        Tue, 16 May 2023 04:07:30 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b003f427cba193sm1876533wmj.41.2023.05.16.04.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:07:30 -0700 (PDT)
Message-ID: <8756a990-6020-4fe6-cc50-d59d0569760e@monstr.eu>
Date:   Tue, 16 May 2023 13:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 11/23] arm64: zynqmp: Use assigned-clock-rates for setting
 up SD clock in SOM
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <cf5a4e412e1674500a71a0b1eed7fa8393f37ae9.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <cf5a4e412e1674500a71a0b1eed7fa8393f37ae9.1683034376.git.michal.simek@amd.com>
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
> With limited low level configuration done via psu-init only IPs connected
> on SOM are initialized and configured. All IPs connected to carrier card
> are not initialized. There is a need to do proper reset, pin configuration
> and also clock setting.
> The patch targets the last part which is setting up proper clock for EMMC
> on production SOMs and SD on kv260-revB.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi       | 5 ++++-
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 1 +
>   4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 5e7e1bf5b811..681885c9bcbb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -2,7 +2,8 @@
>   /*
>    * Clock specification for Xilinx ZynqMP
>    *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@xilinx.com>
>    */
> @@ -185,10 +186,12 @@ &sata {
>   
>   &sdhci0 {
>   	clocks = <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
> +	assigned-clocks = <&zynqmp_clk SDIO0_REF>;
>   };
>   
>   &sdhci1 {
>   	clocks = <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
> +	assigned-clocks = <&zynqmp_clk SDIO1_REF>;
>   };
>   
>   &spi0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index 2f7a17ec58b4..cb4a5126c4ec 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -133,6 +133,7 @@ &sdhci1 { /* on CC with tuned parameters */
>   	no-1-8-v;
>   	disable-wp;
>   	xlnx,mio-bank = <1>;
> +	assigned-clock-rates = <187498123>;
>   };
>   
>   &gem3 { /* required by spec */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 4695e0e3714f..31bc120dee49 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -116,6 +116,7 @@ &sdhci1 { /* on CC with tuned parameters */
>   	clk-phase-sd-hs = <126>, <60>;
>   	clk-phase-uhs-sdr25 = <120>, <60>;
>   	clk-phase-uhs-ddr50 = <126>, <48>;
> +	assigned-clock-rates = <187498123>;
>   };
>   
>   &gem3 { /* required by spec */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 340a5c43a8b6..d3c6a9feb114 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -178,6 +178,7 @@ &sdhci0 { /* MIO13-23 - 16GB emmc MTFC16GAPALBH-IT - U133A */
>   	disable-wp;
>   	bus-width = <8>;
>   	xlnx,mio-bank = <0>;
> +	assigned-clock-rates = <187498123>;
>   };
>   
>   &spi1 { /* MIO6, 9-11 */

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
