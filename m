Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C836704BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjEPLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjEPLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:09:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8CA76B3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:08:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3093a6311dcso124005f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235268; x=1686827268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkFmfrkTxSV/jyWan+9mtY7lWbf0kYf8OcxYaORhb8U=;
        b=kH+BXoaN4PTV9t7Ng5m/k2EApS7VBlKmE9nXtrmEJNst2zf+AsS7Ko7/0ADLtO7sxA
         Q5SyB86cE+L6BReD/rRi4NsA7ohUzhIeQsUIK7X7ve3eKSX1NwwMF73xI5Jwmvi0AMrc
         J7m6m3sBAfOI7wCmvaLFBv2n/jW/Xd+WlA9wnDaYuU+dGCoz4b2geE6GHgNdAU5+WLyT
         G4l22cvJITJQSWDKusZyeyN0JSqLPQQ81i01obxUN8JMcJezXYfTeZK1ssiewkrIuDj+
         3FyA/3vUCXz5S6yaQ9xrbrwMPytFJh7welXOgrWcHsxz1njDE2K7XLQDF3EVOntTRt2V
         wy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235268; x=1686827268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkFmfrkTxSV/jyWan+9mtY7lWbf0kYf8OcxYaORhb8U=;
        b=KInJe6SvTFn4Jmx099DrYIQG0TdOVGaJSch2ygy2xls8aT+6vMGvQgcWDclkYpdqXv
         IiBgyTcka7fVDNJ+B1bUzAppFSwjXsTDQXIPWg1cfu0t1IVV1Ht3bT6bAnTq9zl8CpQJ
         YKpeN8OEggasLCb2JmcKwGiz/1cqflYz/HevcamtDAhGpHF5XuVPUXgccjkar+4NIYck
         PmPz9kceCtp7TVdxiBMVM5UUUdD3l1VOz0p8MI56HPnHHoDmVAx4hCF5XHk1hXvBzBRH
         TW8p9dpFqG9h4BwzfRFMtdpM8Er9dFM2Iti8mZUk7zCyTI2R7rGE28/RX/N1wJLaMf+6
         9PtQ==
X-Gm-Message-State: AC+VfDwGxe2LYO1JdhKbJ/+sUjL1Jm1ovvBbfT0nqLibMS/AxW8Sv855
        91yTj6S+jThf7tob1MYgNrhBng==
X-Google-Smtp-Source: ACHHUZ6RUiesVwo1xvPqIMTJ21A82S7aIIk7Xw08zu5kCoH/DW+2FASSkXTyqJwniVCD3Op9OGGrZA==
X-Received: by 2002:adf:f1cd:0:b0:307:71c6:8a4c with SMTP id z13-20020adff1cd000000b0030771c68a4cmr27825777wro.52.1684235268215;
        Tue, 16 May 2023 04:07:48 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j11-20020adfe50b000000b0030644bdefd8sm2255393wrm.52.2023.05.16.04.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:07:47 -0700 (PDT)
Message-ID: <44e18f49-bd98-b772-0527-f4c71d86ea4f@monstr.eu>
Date:   Tue, 16 May 2023 13:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/23] arm64: zynqmp: Add mtd partition for secure OS
 storage area
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <20dd23821118999c6fec2bad52ea446d1a66fefb.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20dd23821118999c6fec2bad52ea446d1a66fefb.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> 
> Update MTD partitions of Kria device trees to allocate 128KB of QSPI
> memory for secure OS. Increased "SHA256" partition size & changed
> starting address of "User" partition to accommodate the new partition
> "Secure OS Storage"
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index d3c6a9feb114..5fbc2fbd2638 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -83,7 +83,7 @@ &uart1 { /* MIO36/MIO37 */
>   
>   &qspi { /* MIO 0-5 - U143 */
>   	status = "okay";
> -	flash@0 { /* MT25QU512A */
> +	spi_flash: flash@0 { /* MT25QU512A */
>   		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -161,13 +161,17 @@ partition@2220000 {
>   		};
>   		partition@2240000 {
>   			label = "SHA256";
> -			reg = <0x2240000 0x10000>; /* 256B but 64KB sector */
> +			reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
>   			read-only;
>   			lock;
>   		};
> -		partition@2250000 {
> +		partition@2280000 {
> +			label = "Secure OS Storage";
> +			reg = <0x2280000 0x20000>; /* 128KB */
> +		};
> +		partition@22A0000 {
>   			label = "User";
> -			reg = <0x2250000 0x1db0000>; /* 29.5 MB */
> +			reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
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
