Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6A7285C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjFHQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjFHQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:48:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860F1730
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:48:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso6874345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242922; x=1688834922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAGoNRFxCpaYHU/hquZQMckGJK1MycTqKrmK0fBxG7E=;
        b=ZqrukFB0x02Ksu9A21nKCNgSxXKaIv9A4zm/KLh/PMSC6np4/9in+rhXslNpvhpnDa
         mXx4kn1KXbG6FSaClpEds24iF1+bcl1u/x0bcbcDFpqe4uAzAeXbOERgwu23isjyfm4g
         2MNqP8USNkwMwr9ONSjKJo8/09+P4Cu9VSF3W6+vmzxbiXlJazMZzQr82kSCL9lKTay9
         SI9lj60WTnw5RKJVVaBfCV+mKL3HAts1LDNlZocCq/K7fN0jrHKt1XOnMexp55JvMXCE
         5gl0OaZcQw8VBuFoWbT1Q5EDl6cbLP51m+RlWMP1yNMTYATsz/kYq7F/IqsCMsYvUCGI
         BMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242922; x=1688834922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAGoNRFxCpaYHU/hquZQMckGJK1MycTqKrmK0fBxG7E=;
        b=PlKivSp6GAU7bNzPbplOa4ZNxE+5fmrJaa1Bc6t9dZTnTp6G83poSMG4FJW9ZhXjQM
         9vBWnKtb4pjfjDGegcegyYlqPTSdcR0IEl5l/YEOeQpWOp7FoqvmuD3iFOoiXrzUqdI8
         MKf9DYpg3OgNYeB2BJGxeNnKLQ8U4ffx3aBcllezyEnUf0d1pdQCh45s+RuzEP/0jGCS
         kZF1V8OxTLiiGnCFO0UvybV0hCf6qsatBDQSSTSM1mkKeqAVWIN4s5UZkfFWmqO326bU
         64OcS2bLC/p6o+LB66vN9xAdgZkMxG8+IH75ZNoDgWGiuF0r0uyJ1LcPEaMqKe6Onu1U
         29gA==
X-Gm-Message-State: AC+VfDzSVYLjcjOur3MPpiwhuLqG8dgwOPcEgNqzlg7wJGWNrEd1In6s
        +YuVXhPsv3Gi4qfiOsi98q4=
X-Google-Smtp-Source: ACHHUZ4Coiru7soNPzfL2Fy+8KRA7k2eYiCZIxlKiMz3t/+/D2WokBnXoIyuNOcVlVJvpJI5pbwL3g==
X-Received: by 2002:a05:600c:2216:b0:3f7:e7a2:25f6 with SMTP id z22-20020a05600c221600b003f7e7a225f6mr1679174wml.17.1686242922204;
        Thu, 08 Jun 2023 09:48:42 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b002ff2c39d072sm2043313wrx.104.2023.06.08.09.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:48:41 -0700 (PDT)
Message-ID: <e548940b-cda3-05e6-2c31-80c286d5025c@gmail.com>
Date:   Thu, 8 Jun 2023 18:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/5] ASoC: mediatek: mt8188-mt6359: clean up a return in
 codec_init
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230608084727.74403-3-angelogioacchino.delregno@collabora.com>
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
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> This code triggers a Smatch static checker warning and does sort of
> look like an error path.
> 
> sound/soc/mediatek/mt8188/mt8188-mt6359.c:597 mt8188_max98390_codec_init() warn: missing error code? 'ret'
> 
> However, returning 0 is intentional.  Make that explicit.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index 643a7a12a96b..b2735496d140 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -594,7 +594,7 @@ static int mt8188_max98390_codec_init(struct snd_soc_pcm_runtime *rtd)
>   	}
>   
>   	if (rtd->dai_link->num_codecs <= 2)
> -		return ret;
> +		return 0;
>   
>   	/* add widgets/controls/dapm for rear speakers */
>   	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_rear_spk_widgets,
