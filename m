Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998E708368
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjEROAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjEROAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:00:32 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 07:00:28 PDT
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635AF10DF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:00:28 -0700 (PDT)
Received: from [10.0.0.182] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 757FB1606D6;
        Thu, 18 May 2023 15:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1684418006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOj9DkEAsffGRvIc8YyAR4RG7FpCib/7HWlSzpx9EZ0=;
        b=YFjVINfxoE+aBlp4VV2kbChSgiAOoB9PyHhWF4UAUAIP+rTmMSIcyV37JXpc1mbRMBd6iS
        Plj0O1o2aM+3+O8m2K/S9QUzccpMUxkQU44Cy95o6K1Akw+HsQnFuVLPMdMXzP7vqclMTm
        zh7U2tA0JCiTyYNQOTOo9u/H/zPuqXE=
Message-ID: <2ae4d22c-b278-e21f-bccc-f8a1757dcf3b@ixit.cz>
Date:   Thu, 18 May 2023 15:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8192-mt6359: Remove " Jack" from
 Headphone pin name
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, nfraprado@collabora.com,
        wenst@chromium.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230517151516.343037-1-angelogioacchino.delregno@collabora.com>
From:   David <david@ixit.cz>
In-Reply-To: <20230517151516.343037-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Heidelberg <david@ixit.cz>

On 17/05/2023 17:15, AngeloGioacchino Del Regno wrote:
> Function jack_kctl_name_gen() will remove the redundant " Jack" from
> the name, if present, and then it will add it back, so that all of
> the controls are named "(pin-name) Jack".
>
> Remove " Jack" from the Headphone pin name to spare some CPU cycles.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> index 5e163e23a207..4e0d5bf12b47 100644
> --- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> +++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> @@ -46,7 +46,7 @@ struct mt8192_mt6359_priv {
>   /* Headset jack detection DAPM pins */
>   static struct snd_soc_jack_pin mt8192_jack_pins[] = {
>   	{
> -		.pin = "Headphone Jack",
> +		.pin = "Headphone",
>   		.mask = SND_JACK_HEADPHONE,
>   	},
>   	{
