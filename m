Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712365BE37C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiITKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiITKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:39:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292173309;
        Tue, 20 Sep 2022 03:38:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FF5F6601F3B;
        Tue, 20 Sep 2022 11:38:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663670313;
        bh=CPxTsxwwUNVTZuVWPCLD0D4xQtfZBz/Zni7nORIgDcQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eTw9OQKFdxPnrguxbqFoyF1fV4CKVwuPAMQyMRgJuj+DgcKN1WIFBGD1ZHYBk6yIE
         jZTpkwMJakGsN+IqRkGfy3++gp9bSfK3mVqkP8RIm1uIXVcwyLuQnP+85hn81XTlow
         9mRz1PqsPAlZ6SBEAqK5twFvYSTwJvXzBmY+wTqKDwBuoRCnnjUIzGAAKwVMS5sP06
         z7jE6JkaFMLkNGe2tVfuITbdu7JWfhrgFPJpiAKDFTlPyzhmhGD8T8b6JeZ/YXcRY7
         csx15Vlm7Vl2z/uhn9HRswHDyT5pXPho4M6/FLRUuDTg4yo1zsvtvqntZ7/UycAnwL
         dcf85iGHGCMGQ==
Message-ID: <5920ba96-886c-1195-656a-a98d7b1f6623@collabora.com>
Date:   Tue, 20 Sep 2022 12:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 09/17] drm/mediatek: hdmi: add connector flag
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-9-4844816c9808@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v1-9-4844816c9808@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
> Add a flag to indicate support for an external connector
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> index 86653ebaacfd..30407603d693 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> @@ -199,20 +199,22 @@ int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
>   		goto put_device;
>   	}
>   
> -	remote = of_graph_get_remote_node(np, 1, 0);
> -	if (!remote) {
> -		ret = -EINVAL;
> -		goto put_device;
> -	}
> -
> -	if (!of_device_is_compatible(remote, "hdmi-connector")) {
> -		hdmi->next_bridge = of_drm_find_bridge(remote);
> -		if (!hdmi->next_bridge) {
> -			dev_err(dev, "Waiting for external bridge\n");
> -			of_node_put(remote);
> -			ret = -EPROBE_DEFER;
> +	if (hdmi->conf->has_connector) {

If MT8195's DPI uses the internal HDMI->DP converter, I say that the external
DP has HDMI input and DP output.
Logically, you can't have a HDMI port that's connected to nothing.

Please, rethink this change.

Regards,
Angelo
