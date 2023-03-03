Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB16A965C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCCLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCCLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:33:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EF5F521;
        Fri,  3 Mar 2023 03:32:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46E576602FA9;
        Fri,  3 Mar 2023 11:31:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677843114;
        bh=Z3yUm93fbmBr4tmQhaa1EsNOBS414MHB6O4CE83OdqQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lgy+LTz1zV43+EdSB+89iwuIlMZfftKkayi7VVbaOiTT4WcNFTVRVV19dL+w2F0pi
         CbTrUC1iBiDivUWHT2qyTP/RJFccVJC7bmWUvoA9bjEvfzAEOHy8dSHOIy8iw7xisS
         MYzrSbGiD/nfhJSgjxW1J2/rsa49WhH3f6u+6axUcVdGI9X669hR+jFqP1HrJlEWr6
         WMiDYmNLGaT3SMmjWV3iG6CnnlkGIKCXbZEoMC/ie69JrfSyqiFywVPF9sshmRb9/F
         Sy6vJeXO8e8Fqpez8XLcvsye5bNxXETAd+aAPyBNAghgvDy8GImC7wQ2S+n43UzxuW
         ZsBFPCwXl0jZA==
Message-ID: <b121408c-bed3-7b58-affc-c7fde5d0ac40@collabora.com>
Date:   Fri, 3 Mar 2023 12:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/7] arm64: dts: mediatek: mt8186: Add ADSP node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230303031728.24251-1-allen-kh.cheng@mediatek.com>
 <20230303031728.24251-5-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230303031728.24251-5-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/03/23 04:17, Allen-KH Cheng ha scritto:
> Add ADSP node for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 0e42bdbd2cb6..337bcf3c1571 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -633,6 +633,22 @@
>   			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH 0>;
>   		};
>   
> +		adsp: adsp@10680000 {
> +			compatible = "mediatek,mt8186-dsp";
> +			reg = <0 0x10680000 0 0x2000>, <0 0x10800000 0 0x100000>,
> +			      <0 0x1068b000 0 0x100>, <0 0x1068f000 0 0x1000>;
> +			reg-names = "cfg", "sram", "sec", "bus";
> +			clocks = <&topckgen CLK_TOP_AUDIODSP>, <&topckgen CLK_TOP_ADSP_BUS>;

Was missing <&topckgen CLK_TOP_AUDIO_H> intentional here?

AFAIK, that's required for the ADSP.

Regards,
Angelo
