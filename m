Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291BF5F6612
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJFM26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJFM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:28:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891E9F764;
        Thu,  6 Oct 2022 05:28:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BFF5566022FF;
        Thu,  6 Oct 2022 13:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665059298;
        bh=8Sr8yw+JBOQAiJk8C/U+JAHoxicfODTLrAVUrwfiToA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FN7s/832T+Xb+BqbvBlLY1QZKyUAOA8qjB0zl55D7jqCKQQVA180V2D0uSVhdq93H
         F+uEIX4Ky13l9J8RVJlNM6AvqamuTRwXRTRauGaStR4a9ET4iZQb1z0pd6paOkjFlL
         O2onoYr3/FPKPkCXumM/TOQrUcR/bQyBnsrJ05AnatrctQmi0qgsXVI6xvLHKABYKd
         edJ2I+XtXTqe3MSiBy35MIOGfeFTrWo3pBvmwd6y/+kFGamssbZ/fpQRK+arsvI+3c
         JOEt3QnnQqu6NL7gRolxLV6rqR0dhMNffEngkEU4raaR3tHoN3MaAJVbyhvVnzZGcr
         8PMqFnVpjLrzw==
Message-ID: <579c8387-ba4b-22d1-79a6-5cff94769fb5@collabora.com>
Date:   Thu, 6 Oct 2022 14:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/8] MediaTek watchdog: Convert mtk-wdt.txt to dt-schema
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 14:07, Allen-KH Cheng ha scritto:
> Based on tag: next-20221006 linux-next/master, We use [1] and [2] as
> references to send a new series.
> 

For me, it's all good to go. Thanks for respinning that series.

Cheers!
Angelo

> This series converts mtk-wdt.txt to dt-schema and contains
>   - Fix watchdog compatibles for MT8186, MT7986 and MT8195,
>   - Fix the watchdog name of mt8516
>   - Add mt6795 and MT8173 watchdog compatible
>   - Add support for toprgu reset on the MediaTek Helio X10 MT6795 SoC.
> 
> Changes since [1]:
>   - Drop "timeout-sec: true" and use unevaluatedProperties
> 
> [1] https://lore.kernel.org/all/20221005113517.70628-1-angelogioacchino.delregno@collabora.com/
> [2] https://lore.kernel.org/all/20220422121017.23920-3-allen-kh.cheng@mediatek.com/
> 
> Allen-KH Cheng (3):
>    arm64: dts: mediatek: mt7986: Fix watchdog compatible
>    arm64: dts: mediatek: mt8516: Fix the watchdog node name
>    dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT8173
> 
> AngeloGioacchino Del Regno (5):
>    arm64: dts: mediatek: mt8186: Fix watchdog compatible
>    arm64: dts: mediatek: mt8195: Fix watchdog compatible
>    dt-bindings: watchdog: mediatek: Convert mtk-wdt to json-schema
>    dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6795
>    watchdog: mtk_wdt: Add support for MT6795 Helio X10 watchdog and
>      toprgu
> 
>   .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 80 +++++++++++++++++++
>   .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  3 +-
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +-
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi      |  2 +-
>   drivers/watchdog/mtk_wdt.c                    |  6 ++
>   7 files changed, 90 insertions(+), 49 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>   delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> 

