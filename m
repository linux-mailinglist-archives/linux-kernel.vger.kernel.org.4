Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5A704BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjEPLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjEPLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:10:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072D7696
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:09:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f423521b10so70779485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235352; x=1686827352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FNJszxzR3PXgaTxXmMTfcWtAHlHrlwtzwkzpwXZ8Uk=;
        b=BaPg9oSWENth98+wPU9l3gHPGKPggMPbQmG79b7DKpukrTlN1XGzFTFtsC7FWNXp9I
         D3CvgkTilHbgRA7zCaOrLQo/SIM1UF/JVK2PiyC3VSUJAD5F8v8PbvyGyoe75O2SoXtT
         UGuOOWIEAlhWExeRxn+rgt5BUPWwK8hDMYbLDq6eTmeLm0Ha8g+R5MUzqtd0IMr87fxq
         UYD/qnLCCjpX+hyc0g4NfJGW2mWJIF5bser4mkaHq7Hcp/5imfmXHcSUOEEPcnam3lIP
         ICKJIMFwL+RJIK+fgFCJFGnPTHL/QVFHlk8oJFM7Y7766Cm/xhaRIqBlbBcRHMyORTGu
         GW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235352; x=1686827352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FNJszxzR3PXgaTxXmMTfcWtAHlHrlwtzwkzpwXZ8Uk=;
        b=NHFCxhhYyzPZpQseOs9CbSy18RGQRGuxPgJ13OzFMVpldvPV/T9ITrTstW9kfTgRKh
         xRk4uFk2AXMldWBhDnGn5PBY7D7XKed5xCc3XLC4mRkFfO0QLYCUcPhqqE/reL+jeLW5
         QN3TL8c+6Aqk3NCh3N1akSYGTVxIFM58WjTtMtr12czxAoyyK6IC+K9qQJmEiwwgLy9i
         BnfJ4pI8RPo6gdtc4bFaT9msh1t7cJFhTwu6UyRzFtvNNE/QSkVB64gU2QJHJVAvxCUO
         NWjBwYg+D3WWhXzzgGYH0I37nZgCcj1CvO0SxYRwT6Da/RqLTuSHU4CPUKVEjz8hcj6U
         RpaQ==
X-Gm-Message-State: AC+VfDwPoGWsBImCBKC6pgOwkgQUioE5djGFA30YZcj2lRyty8vVQhU9
        XCTA32l5kFdubNhkFdC069EHVA==
X-Google-Smtp-Source: ACHHUZ4sdLHwqQN66Odl6tIfIJySedBTOX8PmE56db6XHBPLToK6D1c9Tsbpk23NjNgZnc12r4zRSw==
X-Received: by 2002:a05:600c:220a:b0:3f4:ffaf:a862 with SMTP id z10-20020a05600c220a00b003f4ffafa862mr7216285wml.12.1684235351699;
        Tue, 16 May 2023 04:09:11 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c00c200b003f423f5b659sm1970348wmm.10.2023.05.16.04.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:09:11 -0700 (PDT)
Message-ID: <ed357f07-c4b4-4bff-55ba-2c63374b21bc@monstr.eu>
Date:   Tue, 16 May 2023 13:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 17/23] arm64: zynqmp: Switch to ethernet-phy-id in kv260
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <4b139e942c2a808eecbb30226b6ea5303348390a.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <4b139e942c2a808eecbb30226b6ea5303348390a.1683034376.git.michal.simek@amd.com>
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
> Use ethernet-phy-id compatible string to properly describe phy reset on
> kv260 boards. Previous description wasn't correct because reset was done
> for mdio bus to operate and it was in this case used for different purpose
> which was eth phy reset. With ethernet-phy-id phy reset happens only for
> the phy via phy framework.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 6 ++++--
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 6 ++++--
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index cb4a5126c4ec..817d756142ab 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -146,16 +146,18 @@ &gem3 { /* required by spec */
>   	mdio: mdio {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> -		reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
> -		reset-delay-us = <2>;
>   
>   		phy0: ethernet-phy@1 {
>   			#phy-cells = <1>;
>   			reg = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
>   			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
>   			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
>   			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>   			ti,dp83867-rxctrl-strap-quirk;
> +			reset-assert-us = <100>;
> +			reset-deassert-us = <280>;
> +			reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
>   		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 31bc120dee49..e07cec231ee0 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -129,16 +129,18 @@ &gem3 { /* required by spec */
>   	mdio: mdio {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> -		reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
> -		reset-delay-us = <2>;
>   
>   		phy0: ethernet-phy@1 {
>   			#phy-cells = <1>;
>   			reg = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
>   			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
>   			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
>   			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>   			ti,dp83867-rxctrl-strap-quirk;
> +			reset-assert-us = <100>;
> +			reset-deassert-us = <280>;
> +			reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
>   		};
>   	};
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
