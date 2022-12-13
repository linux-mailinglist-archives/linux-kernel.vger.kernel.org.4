Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E564B28E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiLMJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLMJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:43:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B00F01D;
        Tue, 13 Dec 2022 01:43:01 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FFB86602C2F;
        Tue, 13 Dec 2022 09:42:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670924580;
        bh=VMAoG4F0h5+2Tw6EEa082N1EiJ7bqvGUQOspWsbMvtQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nO4q0ZGLrpF68McW2i5tJS/hRxHNV+JxWpcNEhyfiA323dsriZkn42C8iP3aO69Ox
         r2f+QiWQSlr8v6Xh1FPeIr5/9z5q8viZj+JTmXGzgwIUJGbYMr8dB//IOKgXuCRfQY
         QJwdo6J0VUvr8YlqNfo4vTy7rJhz5NRGW/XMoKAz6dUKn20sFtpk97udrFlaTeEBri
         /g2nCMeyqRdjq6AZp/tlM9TFqQ+iPi3ImBIgyKJAvWMg3IOhAbO1UMwApvnnZCPbok
         E0c6JiYYGUX50g3Yp7Vr9DAZdi3zCgfVEdkkJIgZeGB8H6Pj2pRcbnlBu7KOujeTX1
         VPEQXTHev9JLg==
Message-ID: <3729df62-8d39-db47-0b57-2bef37cc5830@collabora.com>
Date:   Tue, 13 Dec 2022 10:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 8/9] arm/arm64: dts: mediatek: Fix existing NAND
 controller node name
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
 <20221209064317.2828-9-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221209064317.2828-9-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/22 07:43, Xiangsheng Hou ha scritto:
> Change the existing node name in order to match NAND controller DT
> bindings.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>   arch/arm/boot/dts/mt2701.dtsi             | 2 +-
>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 +-
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Splitting this in two commits, one for ARM and one for ARM64 would probably
be better, but since I don't have strong opinions on that...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


