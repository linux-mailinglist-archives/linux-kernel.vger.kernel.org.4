Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF15B82CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiINISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiINIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:17:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F352DFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:17:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF0AD660037C;
        Wed, 14 Sep 2022 09:17:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663143460;
        bh=HFEQ65O/mE3evHovBKdThpzSRkNG08TXQRM2aECKklU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H9hmToNizNS8Y2APOOTL4yzGIZXc7SvGyz/ZEea1Gh13MMaV/Q7RJkW7sb0ZQLExj
         ip5wP8rDIFMeAp1h7Tun+ZDVrrkgFD/nAI7GSKh3bjIkQbk3T8jLENTml9qog51tDC
         g9yemHzg37bQhBC/1mLsu1B1pk6BzPTXi9dfkALIQ+guZmvJs7KneFATdCFOGHyD72
         8+H4GU+HXaB6M4PdxVUawUeIjEW7okQnIRTyHN0vN4faOOtglAoEZnFoBW/GGV4KUN
         RAqxeqQT/kUe/SHR/GJy+QJBrKgrELz/5g2zupAncqJnq6wz0yXnQzy+2M9z4MAaNE
         +weBYv+DU3GFg==
Message-ID: <0723c329-475c-42a1-f6d5-f478d649aef1@collabora.com>
Date:   Wed, 14 Sep 2022 10:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm: mediatek: Fix display vblank timeout when disable
 dsi
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     rex-bc.chen@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1663136309-29491-1-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1663136309-29491-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/22 08:18, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Dsi is turned off at bridge.disable, causing crtc to wait for vblank timeout.
> It is necessary to add count protection to turn off dsi, and turn off at post_disable.
> 
> Fixes: cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from enable/disable and define new funcs")
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Hello Xinlei,
which machine is this commit targeting?

Can you please try to reproduce again the issue that you're seeing with my
mtk_dsi fix [1], but without this commit?

Thanks,
Angelo

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220721172727.14624-1-angelogioacchino.delregno@collabora.com/

