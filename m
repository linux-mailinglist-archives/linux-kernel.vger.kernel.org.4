Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223E6ADB13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCGJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCGJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:53:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800104DBCC;
        Tue,  7 Mar 2023 01:53:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 367666602FE5;
        Tue,  7 Mar 2023 09:53:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678182818;
        bh=vOeT3Ma4VCBuwsG6yxTjz0hhW4n6wBQ0pRmiNCigU4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VcID3wSgiRgGRYsYRldHpyMmkM9q9Iwj7PmDLnNVemLF8K/Q0FQ7c0oOHsxU4K/Hn
         RE99gklE/DYhCxYx8uHMbbk7HhYWiV6Rqdul73r+xhWoiBucpULpGYxBiLONCuryJq
         Czj7vMF0sG1gY43EUld5eFbC/CWuj0Yk50H/Hs+ebTiL0AHr6cnQigCJRzqidyC+gL
         9gpTjtnMciNE2iMejiwJLMhvdlgy+gNxCgW29vcua+X9dAbj4pOcDAGDug2rRzvm07
         jp72R1UTHATxpR7OQE/gntZ8TYjZipCQCuJzHsH90L8aiCfmvwegMKhsbqnZm4zOu0
         U7EKfFtV9gOZA==
Message-ID: <33587fba-566e-38f9-1f27-868133a854f0@collabora.com>
Date:   Tue, 7 Mar 2023 10:53:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 2/7] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
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
        chengci.xu@mediatek.com, youlin.pei@mediatek.com
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-3-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230307080555.14399-3-yong.wu@mediatek.com>
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

Il 07/03/23 09:05, Yong Wu ha scritto:
> When we enable PGTABLE_PA_35_EN, the PA for pgtable may be 35bits.
> Thus add dma_mask for it.
> 
> Fixes: 301c3ca12576 ("iommu/mediatek: Allow page table PA up to 35bit")
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I would send this patch separately from the MT8188 series, as that's purely a
(quite important) fix that is not specific to the introduction of MT8188, even
though that SoC needs that fix.

Regardless of that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


