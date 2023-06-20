Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77E6736508
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjFTHoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFTHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:43:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467B1A7;
        Tue, 20 Jun 2023 00:43:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AFB76602242;
        Tue, 20 Jun 2023 08:43:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687247012;
        bh=EC8RhzFWNfZy8dsFV1foY8bZFeIESKFCvug6BRbkaM4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TftgeGNohO/Odsdn5+P1zsXb/c8PQ0woD+hT9C6E3W9ZsWetSg9p0OyphKpMUW2rS
         X4ykNveWTI6bl20mE+4JQuaRiplDGBmFS5fmjbOKFrw+ytqmdy0B1jxX720MzaM9fr
         aVdRuKgy8fJxCISIkC4nZ1MiZxGSzOyLROJZ3myx7/CEicEKmFHVMJOFVuS91EOknS
         gNn6JchPQHztYffsRduIzUGiVNXzmncGd99n/qvbeoSk2dGRTlX8gC1P6EpiUMjVko
         ucxqyx2+brkr2P+kPhyiJYODrlAYk2FgdWXC+Dx4gwrl9gGCS4DMtz7hIiuB0rypcr
         QbCPhEUjUb4fQ==
Message-ID: <88d39014-fd06-d801-fa10-387e1aa24e15@collabora.com>
Date:   Tue, 20 Jun 2023 09:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/6] media: mediatek: vcodec: Define address for
 VDEC_HW_ACTIVE
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-5-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230620000349.2122191-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/06/23 02:03, Nícolas F. R. A. Prado ha scritto:
> The VDEC_HW_ACTIVE bit is located at offset 0, bit 4 of the VDECSYS
> iospace. Only the mask was previously defined, with the address being
> implicit. Explicitly define the address, and append a '_MASK' suffix to
> the mask, to make accesses to this bit clearer.
> 
> This commit brings no functional change.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Added this commit
> 
>   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 4 ++--
>   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c  | 4 ++--
>   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h  | 3 ++-
>   3 files changed, 6 insertions(+), 5 deletions(-)
> 

..snip..

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> index 36faa8d9d681..caa2d0a48a90 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> @@ -12,7 +12,8 @@
>   
>   #include "mtk_vcodec_drv.h"
>   
> -#define VDEC_HW_ACTIVE 0x10
> +#define VDEC_HW_ACTIVE_ADDR 0x0
> +#define VDEC_HW_ACTIVE_MASK 0x10

#define VDEC_HW_ACTIVE_MASK	BIT(4)

...because it's a bit, as you wrote in the commit description :-)

Cheers,
Angelo

>   #define VDEC_IRQ_CFG 0x11
>   #define VDEC_IRQ_CLR 0x10
>   #define VDEC_IRQ_CFG_REG 0xa4


