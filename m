Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9455BF8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIUIQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiIUIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:16:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7D883FA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:15:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EBA786601F3F;
        Wed, 21 Sep 2022 09:15:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663748126;
        bh=NNSx9hRJaoAMLI1n9AvUiccUA/Y2Upvxg5yv9gxOeYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nS3pdU9XGCHiM4SODNkKdfIJIyYR/r64+mKBjsLYP8UALlnNYeaKSsmV5O2cDKktk
         dYu1pHLJ+DO7p41Mlclfd+n97TeTxxo/rIBTMP/m9ky/a6g9IZiRUzeuYMMRkhE09B
         iZORo3Yp+B0E6LoP5rA/6hOfL6JabzxGkVTfP4j9+f0MbUIwy8hzxaaQPmcFfwoX82
         04Esp+eZCBJW/dZKcv8i0+cDLGLb8Pcdx9P+RFIHGSO1LaNvj7rWNzRB3W/yExFtj7
         0KmtNi4HamtoWdv0lse8OhiJ4CgFtmk25/XeMztKxIuLCshSD3ahWZOKsGitlnaBvF
         ksKsrh9A2psfw==
Message-ID: <826acb10-f2e4-6edd-4479-e71772787df4@collabora.com>
Date:   Wed, 21 Sep 2022 10:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 18/18] phy: mediatek: mipi: remove register access helpers
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
 <20220920090038.15133-19-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220920090038.15133-19-chunfeng.yun@mediatek.com>
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
> Remove private register access helpers, use the common ones instead.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



