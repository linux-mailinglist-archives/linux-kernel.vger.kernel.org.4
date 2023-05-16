Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3675704F11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjEPNSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjEPNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:18:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C530E8;
        Tue, 16 May 2023 06:18:35 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6F8066058F2;
        Tue, 16 May 2023 14:18:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684243113;
        bh=Z53vfnjM1pDRjRatK4NL7mBjKR6/M0ZYTm/lrMQj4Hg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R1ZR5LXxd5+KzuDqg3hnNv8LbHRxcReXjHFdO70o87XKc/fbnO6u/2bME8nCFPNZ/
         p7+/OqAIy7NtZJEu86xDV/m7i7G8rLrWvvNNstrjdDEKsvu6DnYfsk/hIGQw6pFSuY
         iG9EV/8GE+xg2QLPZewnrt3R9I10uzX6srSp5lKwyLnDxy8zLGbCnf0Ywjij3Dw/KY
         3P0qzIUjjsU8pRslTmaQdhBv+7JqaIlezAEPMLIwhkqOaHNqVGg1ud2CwIWd1cKixY
         0zTur5a2NWBJou3dk883a8gjqYzRwJ06qynZi+ha0yyAOVGe7eeBWZR+0FNIbsfFSP
         3ZSRDRdMAIkkQ==
Message-ID: <3e5c9fd9-ee6b-d903-10d0-0fc663cedd40@collabora.com>
Date:   Tue, 16 May 2023 15:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/5] arm64: dts: mediatek: mt8183: Add
 mediatek,broken-save-restore-fw to kukui
To:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        wenst@chromium.org, yidilin@chromium.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Weiyi Lu <weiyi.lu@mediatek.com>, Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230515131353.v2.cover@dianders>
 <20230515131353.v2.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515131353.v2.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/23 22:13, Douglas Anderson ha scritto:
> Firmware shipped on mt8183 Chromebooks is affected by the GICR
> save/restore issue as described by the patch ("dt-bindings:
> interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
> broken FW"). Add the quirk property.
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


