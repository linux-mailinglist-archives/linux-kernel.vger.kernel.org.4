Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DA61F603
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiKGO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiKGO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:29:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3611F9F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:24:31 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4B97660239F;
        Mon,  7 Nov 2022 14:19:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667830754;
        bh=mif3qn3xqCd8aP/nkWjlrL1oW7XjaH5g2PK3HDhAi84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgBKXah+RA7SIC0Q4KCuj43Bx8oHJJahN8t+3IkG7Ran+4yxX4eKJfiYDeWRTG05H
         XF8mOBWG7dBSxJX4EC2S7I7BaRYpuNlqJFEv2HvxArpu+ivWDq8Fyy/g84m6VjModV
         7u5weXvP/Bj4IfiN8zt8MxD8ozAeakJ8FAa6WdoUGnvhu//odgGPMupz+1VsvY+6jc
         trKaP8zfNs7rxJTvGBCmFgOHPibVES1yxSbWl85xaxrloXxM4E+jVpyH1bRhzaejsf
         uMudsdFXoUMxNFcKmbvWC7ucJbxTBI4/cxnah0qnS3SSouArDSXLF6Y3RYt9LXumY1
         OPKTB0GEqbFMQ==
Date:   Mon, 7 Nov 2022 09:19:06 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8183-da7219: Register to module
 device table
Message-ID: <20221107141906.jrs5gwmwi2eakvvg@notapiano>
References: <20221104212409.603970-1-nfraprado@collabora.com>
 <63325548-63c6-8405-6481-3b019e7dd656@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63325548-63c6-8405-6481-3b019e7dd656@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:06:51AM +0100, AngeloGioacchino Del Regno wrote:
> Il 04/11/22 22:24, Nícolas F. R. A. Prado ha scritto:
> > Register the compatibles for this module on the module device table so
> > it can be automatically loaded when a matching device is found on the
> > system.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> 
> Hello Nícolas,
> I agree but.... can you please do the same for 8192, 8195, 8186?
> 
> Getting them all in one series would make absolute sense... :-)

Yes, I was planning to do that in a following series, to avoid extra churn on
all SoCs in case some change was needed. But perhaps I was being too careful, I
can add them here for v2.

Thanks,
Nícolas
