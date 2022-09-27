Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0C5EC04E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiI0LCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiI0LBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:01:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2025E642;
        Tue, 27 Sep 2022 04:01:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 043BA6601F41;
        Tue, 27 Sep 2022 12:01:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664276472;
        bh=RDWtY7wqaihCFtmoFWJVug40U4Jv115kYvwmjRDansY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gH87XogzsxK7TVCFj4qUFTrougqAFQMRPxlw9tr08UzMtOqb5qAkQs3VNiTHLPzTl
         CXck085FzbMkt1n8p97aeHMkhILghLYnxGuqy4My1+mEg4R4TjfktwnPJadZQd96JN
         S9VxJDQ3RaW7sovH/daruwR7wvcucICZRKBZJSluqda+sXCuW3NBY/RE5VLlkHXtmi
         NehuyuOiri8hiw9Qbr206d1IiSRW6mlvFoTGY8HCMYfTblLb2IzVVwdwJNFTWLmoHe
         XQrWPLwBZw3Gq5ZqNZRcymZ4uexQ1fx4yz8pbDSKTzfi082JGa983swS6+A9aQ2iD3
         HfH2wshC9bung==
Message-ID: <cbed65b6-bd7c-b750-ac8e-504fe143a804@collabora.com>
Date:   Tue, 27 Sep 2022 13:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 03/11] arm64: dts: mt8195: Add SCP core 1 node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-4-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220927025606.26673-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/22 04:55, Tinghan Shen ha scritto:
> Add the 2nd core(core 1) of MT8195 dual-core SCP to devicetree file.
> Reserve some SRAM spaces for the core 1 image.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..48d457bd39b8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -760,12 +760,24 @@
>   
>   		scp: scp@10500000 {
>   			compatible = "mediatek,mt8195-scp";
> -			reg = <0 0x10500000 0 0x100000>,
> +			reg = <0 0x10500000 0 0xa0000>,
>   			      <0 0x10720000 0 0xe0000>,
>   			      <0 0x10700000 0 0x8000>;
>   			reg-names = "sram", "cfg", "l1tcm";
>   			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
>   			status = "disabled";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x105a0000 0 0x105a0000 0x20000>;
> +
> +			scp_c1: scp-c1@105a0000 {
> +				compatible = "mediatek,mt8195-scp-core";
> +				reg = <0x105a0000 0x20000>;
> +				reg-names = "sram";
> +				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
> +				status = "disabled";
> +			};

I think that the best way of describing a dual-core SCP in devicetree would
be either something like:

scp: scp@10500000 {
	compatible = "mediatek,mt8195-scp";
	reg = <0 0x10500000 0 0xa0000>, <0 0x105a0000 0 0x20000>,
	      <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
	reg-names = "sram", "sram-c1", "cfg", "l1tcm";
	interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>,
		     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
	status = "disabled";
};

...but that may pose an issue when trying to assign different (or more instances
of the same) subnode(s) to each core... for which, I'd be more for something like:

scp: scp@10500000 {
	compatible = "mediatek,mt8195-scp";
	reg = <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
	reg-names = "cfg", "l1tcm";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0 0x10500000 0x100000>;
	status = "disabled";

	scp_c0: scp-core@0 {
		compatible = "mediatek,mt8195-scp-core";
		reg = <0x0 0xa0000>;
		reg-names = "sram";
		interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
	};

	scp_c1: scp-core@a0000 {
		compatible = "mediatek,mt8195-scp-core";
		reg = <0xa0000 0x20000>;
		reg-names = "sram";
		interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
	};
};

Regards,
Angelo


