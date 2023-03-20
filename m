Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9F6C0D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCTJYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCTJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:23:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066C193FD;
        Mon, 20 Mar 2023 02:23:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAECC66015F1;
        Mon, 20 Mar 2023 09:23:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679304216;
        bh=kLvg39Gaq3ED8iaOlpcmqwM+ANaZdEUpeHZ6xeDIhuU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BM3SozDIU+HOpZ4vQEVxgOpyG3uXs4uOSCEw/s3e5vIlqAogkS0jXUEQcTW8oFysn
         rfD7/qrIwRvJ9qge9FuEvzVcCG3/ebS3Iaw4S377uU0leeDvlecpJUoM2sqX6zwKGo
         p+Q+T6eRn4M96IQunabLTIGGaR59+pMlE0yz8syY9jqbf/R1dtT2HpOpg3VrbsRRCD
         9MLqJ8mcMNcBTZjnxrYg/TY55hEmLSmrP9YhA8hSTT8rhBR1tJvclYQs4GTiuuDmVQ
         FHsc3qTrgdNOP9ZPkgm4A9Zq1he+gpnEeOql80mmuPijVi497gA732e5YEFE2PteTU
         NpV293LM8BMxw==
Message-ID: <7a651e39-aab6-1723-c28f-756756ae74e3@collabora.com>
Date:   Mon, 20 Mar 2023 10:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [v3, PATCH] drm/mediatek: add dma buffer control for drm plane
 disable
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20230320030449.5397-1-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230320030449.5397-1-yongqiang.niu@mediatek.com>
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

Il 20/03/23 04:04, Yongqiang Niu ha scritto:
> Fixes: 41016fe1028e4 (drm: Rename plane->state variables in atomic update and disable)
> dma buffer release before overlay disable, that will cause
> m4u translation fault warning.
> 
> add dma buffer control flow in mediatek driver:
> get dma buffer when drm plane disable
> put dma buffer when overlay really disable
> 

The Fixes tag currently has wrong format, and it goes here, not at the beginning;
Please fix.

P.S. The right format is:
Fixes: commitid ("commit title")

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>


Regards,
Angelo

