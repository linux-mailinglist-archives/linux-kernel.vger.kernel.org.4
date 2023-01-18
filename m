Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86867671D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjARNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjARNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:16:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3B7D647;
        Wed, 18 Jan 2023 04:41:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F2DD6602E0D;
        Wed, 18 Jan 2023 12:41:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674045661;
        bh=F+XxzJUm4lsANVRjnsUxehsaKD3z+0zIZyj5AjqBkbs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fd9yJP0xkniKPzH6TUTh4OcVu13uWVY9wouz0NucXaWzXVz8VWlwZH3i/YS8sDOIQ
         lR3fiWQqlY80q4gyH8vRSfZ6Zc4PEoO7N6IMIqe9xZzAxtRA2NoTu+jryaVqeDvWuY
         3Av+dyT3JeTJtOG/i5zoS3up4KAdCj49+PAq+VdBwpwq4an9u41ImBN1TmKrfIwAt0
         m4poVR9+6okdK0Ar4KnqfuXAvtvoD5d+9zOtCnQvtKizcKiurT2wyUD6PhlipvttSR
         k0s4ylIDVTsG5p+zYh6N7Oz7BgOaHmNFaZorzYYfiyh9aPQigkij2DFWNMKPau3lt1
         SdTQP/X3CqZpg==
Message-ID: <38fd6436-7315-6342-f9d1-afafac0e677b@collabora.com>
Date:   Wed, 18 Jan 2023 13:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/9] arm64: dts: mediatek: mt8186: Add SPMI node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230118091829.755-4-allen-kh.cheng@mediatek.com>
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

Il 18/01/23 10:18, Allen-KH Cheng ha scritto:
> Add SPMI node for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 3d88480913eb..a8ff984f1192 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -605,6 +605,25 @@
>   			clock-names = "spi", "wrap";
>   		};
>   
> +		spmi: spmi@10015000 {
> +			compatible = "mediatek,mt8186-spmi",
> +				     "mediatek,mt8195-spmi";

fits one line.

> +			reg = <0 0x10015000 0 0x000e00>,
> +			      <0 0x1001B000 0 0x000100>;

ditto

Regards,
Angelo
