Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA35F42D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJDMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJDMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:17:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CB14D39;
        Tue,  4 Oct 2022 05:17:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 002EA66022A9;
        Tue,  4 Oct 2022 13:17:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664885856;
        bh=cu5Yah5ck29bMkIycNvWBlc3sRFZHfkN4nV9X/MJBsk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j6xHqimEfiapB+IhxmaUxW10jKW1BgCkqMGc5g5ONzkgg4z40XoG2/D0Lt5PwQHKU
         5C7Y9wDRF6C9D3UwvjEEyvVippFSbyzFCpk7fXHg0IA+JqkRFTtACW9B/hMvKUIvUT
         rMxM2eq3TkF/uURTsaTULWftwL2IZaAa0BbpIH6qWXV/xQdTWn/Kw22CFFeJcwo2FR
         9oYxQNopplTjR7S1qQ7r6xL7EgAsM2JmxOLZ2lMa/SsNQrwRogHpzhYK6rzJRCqxpk
         0yfCRw1QAQIrpIfwGZ6d3RHiDN3tyo72oeEDg4fHvxLhk8UWZ2DJNJNfe/Baal24m0
         kCM+AvoikzCaQ==
Message-ID: <15791b10-fdeb-3776-d7f5-968cb0fa85dc@collabora.com>
Date:   Tue, 4 Oct 2022 14:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 3/6] soc: mediatek: mmsys: add support for MT8195
 VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20221004093319.5069-1-moudy.ho@mediatek.com>
 <20221004093319.5069-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221004093319.5069-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/10/22 11:33, Moudy Ho ha scritto:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Add MT8195 VPPSYS0 and VPPSYS1 driver data.
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 20 +++++++++++++++++++-
>   drivers/soc/mediatek/mtk-mmsys.h |  1 +
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index d2c7a87aab87..c4d15f99f853 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -149,11 +149,25 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
>   	.clk_driver = "clk-mt8195-vdo1",
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8195_vppsys0_driver_data = {
> +	.io_start = 0x14000000,
> +	.clk_driver = "clk-mt8195-vpp0",
> +	.is_copies = true,
> +};
> +
> +static const struct mtk_mmsys_driver_data mt8195_vppsys1_driver_data = {
> +	.io_start = 0x14f00000,
> +	.clk_driver = "clk-mt8195-vpp1",
> +	.is_copies = true,
> +};
> +
>   static const struct mtk_mmsys_match_data mt8195_mmsys_match_data = {
> -	.num_drv_data = 2,
> +	.num_drv_data = 4,

After a long discussion, it was chosen to not use the io_start way, but to change
the devicetree compatible....

Check this series, and rebase on top of it:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097

Cheers,
Angelo

>   	.drv_data = {
>   		&mt8195_vdosys0_driver_data,
>   		&mt8195_vdosys1_driver_data,
> +		&mt8195_vppsys0_driver_data,
> +		&mt8195_vppsys1_driver_data,
>   	},
>   };
>   
> @@ -360,6 +374,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   	if (IS_ERR(clks))
>   		return PTR_ERR(clks);
>   
> +	if (mmsys->data->is_copies)

I don't get what "is_copies" means, sorry. I'm sure that there's a better name
for this one.

> +		goto out_probe_done;
> +
>   	drm = platform_device_register_data(&pdev->dev, "mediatek-drm",
>   					    PLATFORM_DEVID_AUTO, NULL, 0);
>   	if (IS_ERR(drm)) {

Regards,
Angelo

