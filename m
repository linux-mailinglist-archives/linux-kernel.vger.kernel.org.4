Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4E7179B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjEaINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjEaIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:12:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9610E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:12:57 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4207A6605840;
        Wed, 31 May 2023 09:12:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685520776;
        bh=3jHnkXoSBbZgKG/dl29z1pDf2aC+nSfccT04ENZNaf4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MuQDt+h+ax9A6pcSl/ydOzBb+HXKYiPc/OXQ1KeN2dXObfUeQUlm9nm3ALwdfE3AA
         Yt5CdxHwF3NbhFRIo7bHVV6zpc3tGwdzm7GestajpZ2LhYhuda1Jwp+sI+lFzij1GV
         v81O0/FeHE+YiNcWIb5/3Qf/82ls2dCvJ8EaDKSzqDxNKWoG5EbTXcVyEPWYXhmT5a
         7CIop/PknOrP+9eT1WVVphEYKKdk+ozgXBByitLdteWWVIV43EHI91OzHn5upZpHrZ
         VOGXS+Sq/oQ3Zr5oCXmBxbw7L3kVtwM6xCRM3S9CKbfWjk3epXo/gOp4Ba+qy6M18Q
         6vnvI/z1b5P2w==
Message-ID: <8cd77fb6-ed45-8f7a-93f4-e795c898168d@collabora.com>
Date:   Wed, 31 May 2023 10:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] soc: mediatek: SVS: Fix MT8192 GPU node name
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230531063532.2240038-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230531063532.2240038-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/05/23 08:35, Chen-Yu Tsai ha scritto:
> Device tree node names should be generic. The planned device node name
> for the GPU, according to the bindings and posted DT changes, is "gpu",
> not "mali".
> 
> Fix the GPU node name in the SVS driver to follow.
> 
> Fixes: 0bbb09b2af9d ("soc: mediatek: SVS: add mt8192 SVS GPU driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Hahaha, I was about to send the same patch! :D

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 81585733c8a9..3a2f97cd5272 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2061,9 +2061,9 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
>   		svsb = &svsp->banks[idx];
>   
>   		if (svsb->type == SVSB_HIGH)
> -			svsb->opp_dev = svs_add_device_link(svsp, "mali");
> +			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
>   		else if (svsb->type == SVSB_LOW)
> -			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
> +			svsb->opp_dev = svs_get_subsys_device(svsp, "gpu");
>   
>   		if (IS_ERR(svsb->opp_dev))
>   			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),

