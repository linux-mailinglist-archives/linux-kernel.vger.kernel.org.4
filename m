Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A591653215
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLUNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:54:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726F2098D;
        Wed, 21 Dec 2022 05:54:33 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 941B16602C60;
        Wed, 21 Dec 2022 13:54:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671630872;
        bh=uRpuNCKUngRkdpvBDnBL2vpNR+gY/XoPcezBtl5F5ZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UV4hyzLgHTk+VLRFh3Nz0P0IWPiEsGWmyp3JPJSbOKIedipZbhNWJl8GoIOafcy1E
         a2rIkTU8Dcw0n05Vfjn17g9ks0COCZ1I+JyLmcOsmKDGvYgKaDLYQRHn7BkVeX9W2j
         kiZaiHFXtIjoTzYyHNcpTc7bd6JzKj2u9L9Jr+mZ1K5eXB+A+PeO+XcvoFXYFFzVmZ
         VL3n2YtBIJs5lmTTU5EBH2MNwcPq0Al2yTxXOy8ARql1P27FaXxvIRCFgt9mzSYADj
         ruuAUnkU0qbhHXP4C3bRyYz/Fq9fEYg+8OivxVCLEsJwreSDVhtCyaOLoBDJruhfBH
         zAovyEBiOGJ4w==
Message-ID: <8911df4a-e581-3792-ba8a-7c150ed8407e@collabora.com>
Date:   Wed, 21 Dec 2022 14:54:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 0/3] Add vcodec lat and core nodes for mt8192
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/12/22 06:51, Allen-KH Cheng ha scritto:
> This series is based on linux-next.
> 
> Change from v5:
>   - Add required interrupts for mediatek,mtk-vcodec-core
>   - Rewrite commit message for 'Remove "dma-ranges" property for decoder' PATCH
> 
> Change from v4:
>   - Add patch for removing dma-ranges
>   - Update child names to video-codec
>   - Update patch title and message
> 
> Change from v3:
>   - Drop `vcodec_lat:` and `vcodec_core:`
> 
> Change from v2:
>   - Add a dt-bindings patch for changing "vcodec" to "video-codec"
>   - Rename child names for vcodec lat and core nodes
> 
> Change from v1:
>   - Replace node names with video-codec
>    [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> 
> Allen-KH Cheng (3):
>    media: dt-bindings: media: mediatek: Rename child node names for
>      decoder
>    media: dt-bindings: media: mediatek: Remove "dma-ranges" property for
>      decoder
>    arm64: dts: mt8192: Add video-codec nodes
> 
>   .../media/mediatek,vcodec-subdev-decoder.yaml | 68 ++-----------------
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 59 ++++++++++++++++
>   2 files changed, 64 insertions(+), 63 deletions(-)
> 

Matthias, can you please pick this one? It's all good and tested.

Thanks,
Angelo
