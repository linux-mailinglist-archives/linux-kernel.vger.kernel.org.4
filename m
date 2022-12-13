Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706F64B283
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiLMJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLMJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:38:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C55CE21;
        Tue, 13 Dec 2022 01:38:04 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCC856602C2F;
        Tue, 13 Dec 2022 09:38:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670924282;
        bh=+3tNy+PbZTfVFEAnTh4aKWZ5b5VVak/D88xkeyMCNAM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cqpMqvHyvyupH6c1+skxTj01j8625v01zTgTBytGuvVwgLcyzGx821DfQNC5Ny3WB
         H+9DwHLlmUt8RPXWuFcd8ja7fESsBfCMFjVED4jD8NKMKT/UXo8QavC1v9Iqz1WWaT
         c8auD19P8QLxerdBQCNHXv7TSLZk7ku9RKRe59dsYd4tqrDi9RMzDxwjW/9Y2bwnKe
         6FH+eBqr+BZl7oSa83d+5ww06r+GhLo/2ufBSV3ZI1ZiG+rWLe/zXZKPBOl4EH2CXK
         DTGgtRMUGQY+Zg6J6KM4qRqgZHqWr34ciV2YD8tyGZiMXjh3Ia2PXnNODdW1W3cXUx
         3rLeauk6F2Z3g==
Message-ID: <ce3350c4-9c43-9fa6-9aaf-a119b700778b@collabora.com>
Date:   Tue, 13 Dec 2022 10:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 4/9] dt-bindings: spi: mtk-snfi: Add compatible for
 MT7986
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
 <20221209064317.2828-5-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221209064317.2828-5-xiangsheng.hou@mediatek.com>
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
> Add dt-bindings documentation of SPI NAND controller
> for MediaTek MT7986 SoC platform. And add optional
> nfi_hclk property which is needed for MT7986.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


