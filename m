Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C65663D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjAJJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbjAJJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:36:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A5048816
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:36:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC0986602D6F;
        Tue, 10 Jan 2023 09:36:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673343399;
        bh=uSowM5jqFDNQiGdft8YboLtHI+wKc4mcCdsfgeYisSY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LVkIcqgcg4cglsYzP+u74GgzDzaOe8wq3tX8+hd3U8QPP+D/XCbKeHSAqyyMnCLRH
         kTjXiq4ucJcsbm+ax/Ym+2q6LWzmZNxdCVudO4709SoRzj64KInpgPQD+JCOprzEuL
         BlVTSb27mqnRCc5my75L49XZq3sX03RrY8QuBU4ZBVQTACqW/Bw+w1R1M6UwR0rlM8
         7Su62ObHNChFHgVx42DFQ0chsdkaNPSIOs0Bgs3lxjQuzPk/i+Vt8bIILiU6E8FP0/
         AcHRtiqnU5G6sNHHGYJ6UKH6p7JC2pmEX/hwdFgMmqnSbDR32sDSLmLxZ9DYupDp8B
         uHfgBbYVP9M5w==
Message-ID: <7cc4fe44-55b9-a80f-27a5-197070759760@collabora.com>
Date:   Tue, 10 Jan 2023 10:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/mediatek: stop using 0 as NULL pointer
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230110031223.4820-1-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230110031223.4820-1-miles.chen@mediatek.com>
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

Il 10/01/23 04:12, Miles Chen ha scritto:
> Use NULL for NULL pointer to fix the following sparse warning:
> drivers/gpu/drm/mediatek/mtk_drm_gem.c:265:27: sparse: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Please add the appropriate tag...

Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")

after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


