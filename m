Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9125F4056
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJDJvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJDJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:51:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0255D81;
        Tue,  4 Oct 2022 02:49:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CE686601595;
        Tue,  4 Oct 2022 10:49:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664876973;
        bh=0JAossrh1s1hdIruCobtP1yntPLtj2cheG0ilCpKD4g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iNMFa0r/mUkXcpDHLcGnQXzL5H/YCfCOFDr7/zwbiDZQwxLsS1PaxgsKhaMno6kqG
         MuzvN5z+biFI64Q8cQ50/LNSOzmfiql0cBClk7Rwk71MVD4Lye27Kn+KjQxZQ4QMDd
         WnsmIF6vB0O7M79Jd1NwgfZursYLILfxIfR0gU8LTYfO+oUwGz72lamFmgRudlVrdI
         X81kL9mA8SAgNn3zcsh3UL1uQ6wGu/lcHwM+oh7d83Dx5fGGGBKt6cGpSTRZpM6IRl
         qsn7f1XmzRVhlMcXmBgyjvj/ibLklrqc8B4bg4YIFEjNnw96gqq8Tt5o8q6DgkvokI
         TS2TRfsWm59Bw==
Message-ID: <699e33a2-9498-9a84-47c9-419c952e75cf@collabora.com>
Date:   Tue, 4 Oct 2022 11:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] media: platform: mtk-mdp3: remove unused
 VIDEO_MEDIATEK_VPU config
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221004023727.28946-1-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221004023727.28946-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/10/22 04:37, Moudy Ho ha scritto:
> Since remoteproc completely replaces the VPU in MDP3, unused config
> should be removed to avoid compilation warnings reported on i386 or x86_64.
> 

MTK_SCP replaces VIDEO_MEDIATEK_VPU... but your description is not wrong, anyway.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Warning messages:
>      WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
>            Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y]
>          && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] &&
>          VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
>            Selected by [y]:
>            - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] &&
>          MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] &&
>          (MTK_IOMMU [=n] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] &&
>          (ARCH_MEDIATEK || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC
>          [=y]
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   drivers/media/platform/mediatek/mdp3/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/Kconfig b/drivers/media/platform/mediatek/mdp3/Kconfig
> index 50ae07b75b5f..846e759a8f6a 100644
> --- a/drivers/media/platform/mediatek/mdp3/Kconfig
> +++ b/drivers/media/platform/mediatek/mdp3/Kconfig
> @@ -9,7 +9,6 @@ config VIDEO_MEDIATEK_MDP3
>   	select VIDEOBUF2_DMA_CONTIG
>   	select V4L2_MEM2MEM_DEV
>   	select MTK_MMSYS
> -	select VIDEO_MEDIATEK_VPU
>   	select MTK_CMDQ
>   	select MTK_SCP
>   	default n
> 

