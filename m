Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B095F06A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiI3Ihw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiI3Iht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:37:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78A1EF611;
        Fri, 30 Sep 2022 01:37:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AFE866022C7;
        Fri, 30 Sep 2022 09:37:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664527065;
        bh=hXP7tMGt4lvZFrdQ9N3TpH0XDUHGm1MVYQ0cksxXiok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bHq7DgC+/YoPhbpQ2DlRNolNFuBUJCN8LSqY3rX6aMcIdi9S2NLRVABWK6unpXPce
         DsMs3ebPHieeU8uJzB6P9npvebFoOLixXRJKWCiNkNtXzoq1nOTsWM7b3zjXfmPVrL
         YctNGImbPkfZ/LXBoKqvqOYbFukNjD2ONVaIK31jqXAgtqgz0apN2sC2fpM6kYpldp
         p+P1v+8/EOxV6cllV9Qgyg50DYYCDZLne8dsOFYpOJPv5ihn7rYL/beC0On+VRaZo/
         0x6ZGbaqNNCk25qyOeYo0qZZTeMHwfavidRRquz8i6C1TK8cK3pe7wVMg2gpOq2TrU
         Mg6oFiKz3P0Iw==
Message-ID: <08017725-7e32-1967-65ee-246b9e692a95@collabora.com>
Date:   Fri, 30 Sep 2022 10:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/2] arm64: dts: mt8192: Add vcodec lat and core nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
 <20220929131309.18337-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929131309.18337-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/09/22 15:13, Allen-KH Cheng ha scritto:
> Add vcodec lat and core nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60 ++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6b20376191a7..fd3c3aaeadba 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1449,6 +1449,66 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
>   		};
>   
> +		vcodec_dec: video-codec@16000000 {
> +			compatible = "mediatek,mt8192-vcodec-dec";
> +			reg = <0 0x16000000 0 0x1000>;
> +			mediatek,scp = <&scp>;
> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0 0 0 0x16000000 0 0x26000>;
> +
> +			vcodec_lat: video-codec-lat@10000 {

There's only one more thing: why do we need the `vcodec_lat:` and `vcodec_core:`
phandles here?

Platforms that do not support the vcodec can simply set `status = disabled;` on
`vcodec_dec`... as it doesn't make real sense to disable only LAT or only CORE.

Please drop these two, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


