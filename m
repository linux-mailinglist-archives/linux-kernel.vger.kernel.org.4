Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B492E6CDA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjC2NIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjC2NID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:08:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E84049DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:07:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D05BD660316A;
        Wed, 29 Mar 2023 14:07:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680095268;
        bh=yGfVILKe7laFu/2YHoRttqj8pGUwtwyR33Lg1kmR68E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WVKmbqI9f/tOjmJbTXVwE2UHiYR7vuFTBriH3zaFHfmMCj3jcP46Df1s8kR8nW078
         iVCesM5eN2gRh0baQ3glN8f3NMriMe7wuKiMbBeguEfnOkrI6mBOxOFfqI0xnUSvQ/
         r6KYUg3SfGZ6+U3BZnycavTk5iaG/tGltcf7Ef9XVRo64FLmDQDnD7ZWifnHhiKqnj
         Cs2TgTkRdk8qO3FZ7j/wbxp18FQRHxqaRm5TYhuBi64n5T2xRM1W7ofAOqxwcl7qFt
         dAkfaikA9m5N94lSkhsUvL0wi40cwAEgK6QZZmxB9f1sQSoexW+ccU+MkAKnz3Kfog
         AmoGp5x4E7BiQ==
Message-ID: <84dff623-c5e7-7f9f-19e1-54fb8c20d110@collabora.com>
Date:   Wed, 29 Mar 2023 15:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/mediatek: Add ovl_adaptor get format function
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com, shawn.sung@mediatek.com
References: <20230329015916.21684-1-nancy.lin@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230329015916.21684-1-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/23 03:59, Nancy.Lin ha scritto:
> Add ovl_adaptor get_format and get_num_formats component function.
> The two functions are need for getting the supported format in
> mtk_plane_init().
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Small note:

This commit depends on
f287c66a6064 ("drm/mediatek: Refactor pixel format logic")

...that was already applied in the maintainer's tree.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[On MT8195 Cherry Tomato]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo
