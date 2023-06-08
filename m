Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9F7285BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjFHQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjFHQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:48:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA513D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:48:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so843100f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242898; x=1688834898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQLEV575N+KrNUGlsZrmx4zC48HUkepNutbY0RXCnbk=;
        b=ISUlowyJjuLK125JQcOXVHEa2QeAgCdOj4C8MAGqYt7vr0t5LECt5PYKZ8XvtYHa/f
         /jcGG0yITgrSx3ZzeH/RA+yJlQYKG+JF3qEckajkfu/8g5A8UodMP37O2GuDhJfYiC32
         s+WRvq+3t8uPqJo5C25EYlZGDeY43Xp3xUwb5RdWahvk5iuoBMVEmeSbIHvo5rk4yEa7
         f/XxcdTbh/6e6Kr6J3r6NBMuuNxx6H1UKOR1oP3FCyTWcGcrEH4c6FWWwrrRNFF5HyFA
         99PMUVtltuQLEHUzouvdxGezr9nk8JiKbYrQpNE69pfOW7dKa6x17mUFEfuIBTloWhss
         vy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242898; x=1688834898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQLEV575N+KrNUGlsZrmx4zC48HUkepNutbY0RXCnbk=;
        b=bhhCF/HSXdTU/BxkiOyYIBub8xM3gvEaYOsfKfD8Z4nP65g93TGgRMTw/VTrbm6uJQ
         PeL4hkgEEG4Y8KzSSN/y1rzTCyc5bGxA9f//PHXSkeuK2SFLqhkCz2sw0kqYAwUC7Krd
         TtyLXbl+hPhlaO8iVja/hJrhZXKhRUl4Wf9QxIqG7xeIB8RhnUEQqUB3vew4qM9Pz3tW
         aegS/LGSlR5FFesHeBDWHXa9VBMimWCO5+ZTqRrIVxaC53mkeCwy2iAlgkIXB6NaPtvG
         bc6YtuB2Utx8cqaPJloj2OYBAC1l/foeRTGALbw3YRgmIEk93W3SDl2LIFkNoHYVcaI+
         7AmA==
X-Gm-Message-State: AC+VfDzk5hJkXRW92hIHoPHVOamZBa+KDnhYdAOkjwTVtdlMPADBY0Aw
        7IjoxwCcKEb09JQYDivO94g=
X-Google-Smtp-Source: ACHHUZ4dJo9Yhk6pVGkaDe0tPdKFCQhHLtZW7L57ZwBBoQ377VxaNTldMtwjWar/LJ3Y+f0Y+1PTPw==
X-Received: by 2002:adf:ea8c:0:b0:2f9:a798:602f with SMTP id s12-20020adfea8c000000b002f9a798602fmr10422192wrm.48.1686242898149;
        Thu, 08 Jun 2023 09:48:18 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q11-20020a056000136b00b002f9e04459desm2023010wrz.109.2023.06.08.09.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:48:16 -0700 (PDT)
Message-ID: <b7a19bb7-94e9-4837-c1dd-0ca891995efb@gmail.com>
Date:   Thu, 8 Jun 2023 18:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/5] ASoC: mediatek: mt8188-mt6359: Compress of_device_id
 entries
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230608084727.74403-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2023 10:47, AngeloGioacchino Del Regno wrote:
> Those entries fit in one line: compress them to reduce line count.
> While at it, also add the sentinel comment to the last entry.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index bc4b74970a46..643a7a12a96b 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -1117,15 +1117,9 @@ static struct mt8188_card_data mt8188_nau8825_card = {
>   };
>   
>   static const struct of_device_id mt8188_mt6359_dt_match[] = {
> -	{
> -		.compatible = "mediatek,mt8188-mt6359-evb",
> -		.data = &mt8188_evb_card,
> -	},
> -	{
> -		.compatible = "mediatek,mt8188-nau8825",
> -		.data = &mt8188_nau8825_card,
> -	},
> -	{},
> +	{ .compatible = "mediatek,mt8188-mt6359-evb", .data = &mt8188_evb_card, },
> +	{ .compatible = "mediatek,mt8188-nau8825", .data = &mt8188_nau8825_card, },
> +	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
>   
