Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15949663CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbjAJJe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjAJJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:34:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B813F4C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:34:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AA566602D6F;
        Tue, 10 Jan 2023 09:34:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673343264;
        bh=2X++/CX/YTAfIcjlM+DL6gfRl75tPuYYPGsfmxgOiGE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OefKhWDdnqvlYAqc/ThdX441MkImgzCrRjY1+pFgFjiOCZjJ/XehLQdzQ/ZF//jzD
         iXBkxh8mqvB/O3bJr0gpVcEnZ4CCrw/1pa59q1NrWTYhtk2PZBnise3AQrLYCpLz65
         4GPR/9wf+MXUjIP9QZ1/QdB5VooBClY/wMD7z+enttc9fo0+oM+L14mblHmMzaTtf+
         1Xl/TrHJxxgefbGblH3l0yjTpDvlfl92VKQba3ajbhshYj9+62IeHLXFNJ3LcGA47z
         w4MpK7ARbvRw6/td8yfjypsT0TDzZRIuvC17+0/WIHkzX4GmdA26QRf64u4Odr4S2A
         p0VNLfnOwsWKA==
Message-ID: <9102d7a1-e40d-1201-f1e8-eeb12923502a@collabora.com>
Date:   Tue, 10 Jan 2023 10:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/mediatek: include missing headers
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
References: <20230110091647.13265-1-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230110091647.13265-1-miles.chen@mediatek.com>
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

Il 10/01/23 10:16, Miles Chen ha scritto:
> Fix the follow sparse warnings by adding missing headers:
> 
> drivers/gpu/drm/mediatek/mtk_cec.c:251:24: sparse: warning: symbol 'mtk_cec_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:221:24: sparse: warning: symbol 'mtk_disp_ccorr_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_disp_rdma.c:390:24: sparse: warning: symbol 'mtk_disp_rdma_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_disp_gamma.c:209:24: sparse: warning: symbol 'mtk_disp_gamma_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_disp_ovl.c:565:24: sparse: warning: symbol 'mtk_disp_ovl_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_disp_color.c:164:24: sparse: warning: symbol 'mtk_disp_color_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_disp_aal.c:161:24: sparse: warning: symbol 'mtk_disp_aal_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_dpi.c:1109:24: sparse: warning: symbol 'mtk_dpi_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c:340:24: sparse: warning: symbol 'mtk_hdmi_ddc_driver' was not declared. Should it be static?
> drivers/gpu/drm/mediatek/mtk_dsi.c:1223:24: sparse: warning: symbol 'mtk_dsi_driver' was not declared. Should it be static?
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


