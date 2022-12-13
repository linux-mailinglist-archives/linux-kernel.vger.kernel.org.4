Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDC64B286
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiLMJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLMJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:38:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D315836;
        Tue, 13 Dec 2022 01:38:57 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B1E96602C2F;
        Tue, 13 Dec 2022 09:38:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670924336;
        bh=3uzuGrt4ZRlBHhLo37SMRYN1aSa87pzUD4T5GH1gEeg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A4nvPBhVtQa3qTAmMlFdtQDm4YgpFyUwJTLjvAVgtowg90/zpPevyLE6/ys2uMYbj
         LjMjyHtuTrh6I3a01HaFF/ofTEt0XsVb3iVPPeKEyDv+Vv1zdueihQd1lhdyQZobZ9
         lvydKYdnnpll6YUHti4YDvjHTJJflnCBKKgQT1XQf8WWoEJmL8mVrB92oE6c+unlNL
         68sXp/w1L/Ex07mLvNr3V4DVkFUppT3NyEZwonQR+AWABiOLvF3aGB36E3i+SveqjU
         Gw21zQqtMpyI15/pL51Y85SminbIfCc+ZHXx4d4tveJAFx6UA+JwUS1QXNF5Kgh4zm
         pgkGImauB/JOQ==
Message-ID: <fc668f1e-3d04-29db-a761-73b9d7830381@collabora.com>
Date:   Tue, 13 Dec 2022 10:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 6/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
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
        bin.zhang@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
 <20221209064317.2828-7-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221209064317.2828-7-xiangsheng.hou@mediatek.com>
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
> Add mediatek,rx-latch-latency-ns property which adjust data read
> latch latency in the unit of nanoseconds.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

