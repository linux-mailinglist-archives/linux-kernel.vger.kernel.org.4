Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0548E624503
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKJPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiKJPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:03:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F641B7AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:03:52 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 55D486602959;
        Thu, 10 Nov 2022 15:03:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668092630;
        bh=QFiZtqMZmaPw9ms++EaxKdyMdIsrAeckCDCQOTuJxik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JlfT/GNYWdHxplSYyKFjYL6QN5tqEuJ+HWxKryM+tp4hJBGEFb6vKHZ/hBrhvtYS1
         9feWUusJC6z0W10zbkJyiSDmJ5LcBW4sxuYm/WAQN4C5VV7rKwdB3PO90HXiNmofh9
         1iOxbEoqcqxY3w5VdJXgjPdUCEvdg0lt3KrlazQxCgF+mFrEf5Z6ldVk7nkULWD8Gg
         yHyJTD2Q70uWMaWdL4mViQ/vfWB5Op0DW71uXrddE0qM70Y+SXk9vyGgh9Hp2nNAKQ
         H6qDzAxNMegbVET/sjEWEdia3/huvwixZ+logC7JpHP5BRYgdGMPtT9fI4q6NtGnXX
         n9XDWLIAC8+FA==
Message-ID: <eae90e1e-408b-4f9a-9211-649da28b0358@collabora.com>
Date:   Thu, 10 Nov 2022 16:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] soc: mediatek: Add deprecated compatible to mmsys
Content-Language: en-US
To:     matthias.bgg@kernel.org, matthias.bgg@gmail.com,
        nancy.lin@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221110120222.32297-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221110120222.32297-1-matthias.bgg@kernel.org>
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

Il 10/11/22 13:02, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> For backward compatibility we add the deprecated compatible.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Hello Matthias,

You forgot to advertise that this commit depends on [1]... and I'm afraid
that you have to push a v2 anyway, because...

> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index ba2e79b26993b..47106f557c574 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -303,6 +303,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>   		.compatible = "mediatek,mt8192-mmsys",
>   		.data = &mt8192_mmsys_driver_data,
>   	},
> +	{	/* deprecated compatible */
> +		.compatible = "mediatek,mt8195-mmsys",
> +		.data = &mt8195_mmsys_match_data,

...mt8195_mmsys_match_data doesn't exist anymore after [1], so this should be

		.data = &mt8195_vdosys0_driver_data,

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097

Cheers,
Angelo

