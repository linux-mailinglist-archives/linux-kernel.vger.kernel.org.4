Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96136E4322
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjDQJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjDQJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:04:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C4524C;
        Mon, 17 Apr 2023 02:04:08 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E3B4D660309E;
        Mon, 17 Apr 2023 10:04:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681722246;
        bh=mmJ0iBDdFxaw1hgC1BUonlQRRJ5YNpa5yzZ59XFkdY8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IsIwscG9vpQo5g+as2A2VwbuhAaeS91T4rhpvpyRoj2MkE2mMlHPtOGRchRFwTYag
         3ceHD3BmX3DEoTJ82clCEpWyIXff/9tithcoLlIaZy5/rNSj87pZJq5JzO5Pb5AhTj
         kDAK7HBB8WNgtWZ6OVxQX1wyJzfR37on8hxp26HGo/G829OwQtVwfBsRQcd6zcaX4S
         A+8Nw31pUGorLY9CqImD55kLocvlD8biBVvPOeU5k2exJVrNqTrcU2vZXNSt7dU+wV
         09lJONJies1zQAdacjTtkyry8qv42vEEoaAJmBgKTl6N1hb5234TLC4gz67+XalLyu
         cptzz1sD80BQg==
Message-ID: <b645c058-9f51-034b-0e81-94c8d69469c1@collabora.com>
Date:   Mon, 17 Apr 2023 11:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 7/7] MAINTAINERS: iommu/mediatek: Update the header
 file name
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
        chengci.xu@mediatek.com
References: <20230417073606.25729-1-yong.wu@mediatek.com>
 <20230417073606.25729-8-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417073606.25729-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 09:36, Yong Wu ha scritto:
> We add the prefix "mediatek," for the lastest ports header file name,
> For example, include/dt-bindings/memory/mediatek,mt8188-memory-port.h.
> Update the entry from "mt*" to "m*".
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8ebab595b2a..833d32c356ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13056,7 +13056,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/iommu/mediatek*
>   F:	drivers/iommu/mtk_iommu*
> -F:	include/dt-bindings/memory/mt*-port.h
> +F:	include/dt-bindings/memory/m*-port.h

Stuff that's not MediaTek specific which filename starts by m and ends for -port.h
is really unlikely, but we can prevent future issues.

Perhaps the best idea here would be to keep the mt*-port.h and add a new file entry
with mediatek,mt*-port.h.

Regards,
Angelo

