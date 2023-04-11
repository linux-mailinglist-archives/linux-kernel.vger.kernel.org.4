Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146F6DD568
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDKI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjDKI13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:27:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B549E9;
        Tue, 11 Apr 2023 01:26:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36CC766031E2;
        Tue, 11 Apr 2023 09:26:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201590;
        bh=tO/aZlkFDq6nWzAF4e3MQD3vaQDUyItkLaIlpliPk3w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nFD0BPXq3WU/LbVA9600KAmbN+02q8ST1hWPE+10lYZlnQz0fSYDSu8twYHp5o9Gy
         pgx+qr1429YjOl9NlgtPLX37gWd68YHrHEluChV7mSkh7OePIBRmxTL/WratyVNlC4
         rn1cdfWsFgIz8NOhAGN0NLpTB8fg9szPbMrgYeeY7fQ1g6zrDBUscmuHDx/G2LlMOc
         kXoYk5DcuZTImaB8g3suOyV+bzrdyG+suUvfr/aOWti7tuji7tA/MH6G6Q1zp/nmIh
         9tCwQX0kAoOVjUH+7bP8f0VHd4cL7z3zXx76zNdACMLhz+erbe9X4Oh9yoxi0GIgsX
         54uKTZY1GKUkg==
Message-ID: <f7cd5721-3e91-b455-d4bb-9af2775379e3@collabora.com>
Date:   Tue, 11 Apr 2023 10:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 4/7] arm64: dts: mediatek: add power domain support for
 mt8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
 <20230207-iommu-support-v3-4-97e19ad4e85d@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v3-4-97e19ad4e85d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/23 11:34, Alexandre Mergnat ha scritto:
> The following power domain are added to the SoC dts:
> - MM (MultiMedia)
> - CONN (Connectivity)
> - MFG (MFlexGraphics)
> - Audio
> - Cam (Camera)
> - DSP (Digital Signal Processor)
> - Vdec (Video decoder)
> - Venc (Video encoder)
> - APU (AI Processor Unit)
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


