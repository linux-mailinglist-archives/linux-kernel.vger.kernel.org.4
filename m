Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43398682694
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjAaIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjAaIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:35:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EAF474F0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:34:44 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B26816602EB0;
        Tue, 31 Jan 2023 08:34:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675154083;
        bh=gk51BAwxxzzaABKBP2WotRoLxqVnUC7sVm/G4eOrCFY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R9VyU3qxX7AEcl+PjF66YNawyr36hWB9F55uHVuLiAbGrkePSC81KWH58V7Hb0S13
         n2Wx5Udk36QZ3VnRQD+l6xdtFo2kYsZJ0tdYjm0jcoHKiRXPII/vIIs+WZUWV8SyvF
         rMRipUurAvVndfWvlesKQ8I7l54ZEXEd6EqdLbhYxlyN8TFB+ZANflibWBccuFDCQE
         wyFSU/yc7vPAGKiAniknm4FNgnXjSzqddtADpBpNu6ilj5gwc8l8SZJksYSy+ZREMT
         DLzp4//yT96L9QvSUmrQhrzigRkkNinrXhNp7Blx2Y4NeN71T6IFLGgo6TJynialHF
         0ked1AunctcKQ==
Message-ID: <ff2862aa-288d-7c81-8867-521f62b6042a@collabora.com>
Date:   Tue, 31 Jan 2023 09:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] drm/panel: boe-tv101wum-nl6: Fine tune the panel
 power sequence
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1675130359-24459-1-git-send-email-xinlei.lee@mediatek.com>
 <1675130359-24459-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1675130359-24459-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/01/23 02:59, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> For "boe,tv105wum-nw0" this special panel, it is stipulated in
> the panel spec that MIPI needs to keep the LP11 state before
> the lcm_reset pin is pulled high.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


