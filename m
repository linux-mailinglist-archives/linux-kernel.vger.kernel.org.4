Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1941D5EC4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiI0Nsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiI0Nsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:48:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E8E120584;
        Tue, 27 Sep 2022 06:48:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 76C1A660035A;
        Tue, 27 Sep 2022 14:48:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664286515;
        bh=bCw9THk8cKcz/XlHJZlqthDRQQFL7XlezPvIuw/e8yA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E7z06G8kgpmlBIMbq6NoLAmGmvZkzZM/sWYG100fKVweQ+Ag6lMIg4aozURcrMhVw
         xyejQa8tA1C7TO295QPFgJiePSBx7SMN04CD3v3XwPzfZTmU+lOdQxU+wkE9LDHSeN
         q/L/H7gv2jQ1oV1Ob8TKl2iT96ezQ0QEv4RytBio1aoCBuoBM48CIroHqLf4G04ELW
         xwkx75Gu+UwIxx9DmPUJBBdI4kT2HY+gLag0bDpUXZwcVv7/BqFXdz9Pf0VvFCS47R
         M2xcmWyJfLIsaECItO/yUnY03KN8M3OQ8gYbO2Cs3G8g6RsqpYHrzCC6eZjNRYxuLN
         tb8EriF1+W68A==
Message-ID: <b590390d-fd74-924c-9411-e3c9ab015c40@collabora.com>
Date:   Tue, 27 Sep 2022 15:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/5] arm64: dts: mt8186: Add xhci nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
 <20220923131148.6678-6-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220923131148.6678-6-allen-kh.cheng@mediatek.com>
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

Il 23/09/22 15:11, Allen-KH Cheng ha scritto:
> Add xhci nodes for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 41 ++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c6809fdc7d15..b08af431e525 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -845,6 +845,26 @@
>   			status = "disabled";
>   		};
>   
> +		xhci0: usb@11200000 {

Is there really no MTU3?

Regards,
Angelo
