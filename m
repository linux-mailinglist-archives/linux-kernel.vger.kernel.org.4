Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F26EC6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDXHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDXHFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:05:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A23C01
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:04:54 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D424660328C;
        Mon, 24 Apr 2023 08:04:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682319844;
        bh=mskX6naApSKUTuukB7KjqdlVaiylD+YEVsQ3J6mTGHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mv0Y1ohOHFIqZuph5cw9Feikq/MI/eSnnWOAY6ZUUrYQZQ6jLR4ZZGBAblYzg6yqt
         xEV1s6vYNRvk0U+8U2Ec+afT/Es+Hu7yQpbEyKHQhXIUuyiFY2B4BOTvoV7XTqQK9x
         H03mBjXpuDZuBm4QaeJfhIFps87KCEjNSVU3VXooVqpNh4gRseCAhjvl1bS//v+BuU
         vx1CCnbUyMAcwOvnfB58nHSI8qETv7fI60lICk3aRTFTsN76qLUuJJW77txNupPSzq
         MVXjvKOqTLZVqv39V6MGHg4QAfDz8KsD/7KKwkvoGdsLu2VgKguE6uNRR7suA0fkbX
         OPeOXfwgMKZcg==
Message-ID: <9b26f3e4-fcef-0e51-3443-78624e96fe8c@collabora.com>
Date:   Mon, 24 Apr 2023 09:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/mediatek: fix uninitialized symbol
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
References: <20230421021609.7730-1-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230421021609.7730-1-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/04/23 04:16, Nancy.Lin ha scritto:
> fix Smatch static checker warning
>    - uninitialized symbol comp_pdev in mtk_ddp_comp_init.
> 
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


