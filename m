Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0B605957
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJTIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJTIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:09:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DCB26E3;
        Thu, 20 Oct 2022 01:09:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 826A166023A0;
        Thu, 20 Oct 2022 09:09:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666253385;
        bh=UiiNQ2JiXdeVnmENk3ISE8BLEL6+wyAdDcJy+rlcvFQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dlWOH/BgcuFtG2NoTSkj2ozcSRqMC6EXyppaBDywsbEulv94OVNDucnxDhJq7/wnn
         uyBN0SdLkKMSPfdVbohaY4bLk9L9P4QH/G9lQ5Bp1OJj4ftlA17o59Bhkoqe0Egymy
         hdZdwNCQU/UJnRhEmJaozlBO0pW4hW5HK2xBSWA1ABn3N5CUq/VruEz+HSm8DwbN7D
         3U6MoWR+p7eCxoEfyrsAv/0faI4/ZP46Ei+ZXuGIXh/x5Ys5EXyn/feOeyUG+tfaUR
         AeZedg6xaxKhK+AavXn4I1LSvydgTEKs4FgxDrpFo/vPFWAQVMSlOD19FQ5EAEk0f5
         09vu4Q1rPwr/w==
Message-ID: <0fb91a39-e356-4785-3ab1-11cbc3e78877@collabora.com>
Date:   Thu, 20 Oct 2022 10:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3] arm64: dts: mt8195: Add Ethernet controller
To:     Biao Huang <biao.huang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com
References: <20221020024155.24520-1-biao.huang@mediatek.com>
 <20221020024155.24520-2-biao.huang@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221020024155.24520-2-biao.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/10/22 04:41, Biao Huang ha scritto:
> Add Ethernet controller node for mt8195.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88 ++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 88 ++++++++++++++++++++
>   2 files changed, 176 insertions(+)
> 

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..7efaf92c5ff3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1042,6 +1042,94 @@ spis1: spi@1101e000 {
>   			status = "disabled";
>   		};
>   
> +		eth: ethernet@11021000 {
> +			compatible = "mediatek,mt8195-gmac", "snps,dwmac-5.10a";

..snip..

> +			#address-cells = <0>;
> +			#size-cells = <0>;

I'm truly sorry for a partial bad suggestion, you don't need to specify address nor
size cells = <0>; in the ethernet node, or you get a warning:

arch/arm64/boot/dts/mediatek/mt8195.dtsi:1174.26-1260.5: Warning 
(avoid_unnecessary_addr_size): /soc/ethernet@11021000: unnecessary 
#address-cells/#size-cells without "ranges" or child "reg" property

So please remove these two.

After which...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


