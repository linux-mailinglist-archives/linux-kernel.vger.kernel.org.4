Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD685BF8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiIUIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiIUIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:14:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A1870B9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:13:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 082386601F3F;
        Wed, 21 Sep 2022 09:13:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663748034;
        bh=Bjxfb672TwUm4EQlrnOmkCxSjzDBw2gi/aezKDDa3X0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XLuzjhKcVat7z477U2gtZXCfQG48jkdlU0vFU2EaqllJ4M3ys37+lldw8lOLD9Naa
         NJNTLwGFc7/65UL8qmtVfIdJFEIfxKDBelbBck1dhknCIKeDTsCAFguew1RwrnyxRp
         BSwEmrWuQdI2GKgRnlCkx7upp5ynC4kRviGrDBD6/XVAZQlJtW11njPnIolD/RFMkB
         +m0Y773tikySCI84XCpVc1K9G3Vx9GeaNxNYZRjAs9rRldiNdeEjbYTQj6IN9YVa2h
         x8W2ABkKTBnW2DnvtyqpLBKuZnoTkgbqtRnJ1Ry8zZt5SDG3YW+NHMXAEPS3UHP3r/
         h70g0J8hKc0ow==
Message-ID: <cad587d8-8435-668f-1c7d-a8f0e8d05873@collabora.com>
Date:   Wed, 21 Sep 2022 10:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 13/18] phy: mediatek: mipi: mt8173: use GENMASK to
 generate bits mask
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
References: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
 <20220920090038.15133-14-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220920090038.15133-14-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/22 11:00, Chunfeng Yun ha scritto:
> Use GENMASK() macro to generate bits mask
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


