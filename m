Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2EB6ADB33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCGJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCGJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:56:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C0E135;
        Tue,  7 Mar 2023 01:56:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1524D66018CA;
        Tue,  7 Mar 2023 09:56:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678182999;
        bh=b2sW59AfaGFgFUY1ZzjTm6KZ66xi/bkthdwC/r+4TgA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LJxMvDvw6Q83K+ttDjzaDidUrhIXIZx+I98if6nPAtt4g6mQCFgOVenRXYHxce70M
         67XrHxS+XgTAN5WD1IsqbuC8VE0QJWcNQDfBAYbcMQ+6De/Rtijk5uN6v2X8Wfp8eq
         PncHZ6GVV3tgwpc5Ng+Hdvhrg+B4r/kwJuSnkD/fKgEeREj2g/SavYamspcy2n+RUU
         AisM8yrgNrCJLUvVRnTTISHlXA68st2K3KUrkNNsOu5BGY0QKljeMKDNN+EabQ5yK5
         nZOn3tKpQtOx4ZbnM5C6FH5av8/Kkc7Mjhkf4ARmofNjomCzaxxwBkFAy9oekokfwI
         8q2PjlQJqqxJg==
Message-ID: <7e5aac3a-8edc-fd90-666b-0649182ad8a5@collabora.com>
Date:   Tue, 7 Mar 2023 10:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 7/7] iommu/mediatek: mt8188: Add iova_region_larb_msk
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
 <20230307080555.14399-8-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230307080555.14399-8-yong.wu@mediatek.com>
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
> Add iova_region_larb_msk for mt8188. We separate the 16GB iova regions
> by each device's larbid/portid.
> Refer to include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> 
> Note: larb19(21) as commented in that h above, it means larb19 while its SW
> index is 21.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Please clarify the commit description:

"larb19(21) as commented in that h above" => "As commented in the code, larb19(21)
means .."

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

