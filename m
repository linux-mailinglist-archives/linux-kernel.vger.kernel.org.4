Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6863D191
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiK3JSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiK3JR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:17:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302226485;
        Wed, 30 Nov 2022 01:17:54 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E1B06602B50;
        Wed, 30 Nov 2022 09:17:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669799873;
        bh=9cp5AdKDGyLjgw1/1j2L92HmOOapOEzOCWRCmTYUeao=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wb4OD8mPgXuOSjZGTjDWvvJt0WeA3s4wShYH1Ma/sciq6IxEM/T1HLAHqTOGIs+ip
         CbI8hHTuX+weeFLcL4KTl0tXbhq9/WmNxaXisJyyxuCwN94D4jnGlRp+8f/z4Wz2hy
         yC0ZrwZWOW/nE8sfk0zXfyoptzYbHoKc8u5pwsxhXtmP1qYFz4O52Y7epHaj3GFKfp
         DP5XjBhpdnR0taGYwj1RqTt3HW1T38HwOFxs3ZGLvDUKlk963KHAA8Zz0sBhY4roeh
         QOqB6ucBtxvca1olL7JBK4BEjwKZwLgQc2Jgn/EwxIdSn2wMZap5EZSHLn4D6RYcfk
         0hmY2ym/R5YHQ==
Message-ID: <6c4dc109-0245-7145-c87a-11494c694165@collabora.com>
Date:   Wed, 30 Nov 2022 10:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 4/6] soc: mediatek: add mtk-mmsys support for mt8188
 vdosys0
To:     "nathan.lu" <nathan.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, lancelot.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        amy zhang <Amy.Zhang@mediatek.com>
References: <20221129143503.16638-1-nathan.lu@mediatek.com>
 <20221129143503.16638-5-nathan.lu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221129143503.16638-5-nathan.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/22 15:35, nathan.lu ha scritto:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> 1. add mt8188 mmsys
> 2. add mt8188 vdosys0 routing table settings
> 
> Signed-off-by: amy zhang <Amy.Zhang@mediatek.com>
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

