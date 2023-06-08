Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F107285C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFHQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjFHQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:49:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9042830F6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:49:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30c2bd52f82so896272f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242956; x=1688834956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNPS/7M38Nz5+BxtavsFAB/Ran6aZSE4F1torzsLy44=;
        b=S+ZYjzMReZv+Fa4/OK0AfYtiJ58HD4NXFwHpZKe+y9QUC3S6B3mNIkv6dJz7KYQthI
         pJ8MDyFe9Ci6KH5SoljgPyqRcLL5gl2h7L/VGyrnJBsWzNqI+OtEqd5ujibPkeJCJb7F
         BNsooxHfoaPkVRiFh6ZKUlDDHUxpVkg73LacJAVjRScco9rwRjBD3M/xyvaFgiOhdJ2/
         xa0Xsny5n6i/5cxka/V1b4UvixcRKz6pu/wDJ3yZ6nvWeZqUPRYbviyG55IoMmfpYAFc
         lUVu62dXNmQgVSGY0YmQYPrDZ/kuz8nBfJqc5CUH6bgQNZKTD49e6woImHADs6bs2Xf2
         eOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242956; x=1688834956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNPS/7M38Nz5+BxtavsFAB/Ran6aZSE4F1torzsLy44=;
        b=VzAFacdp/bUoxWHQ26aMfCwDF+T9U4yhzfiBHEfP9PXst2p8Iis/c4aL2JLqA/2P6F
         oXc0HXpeL1SqYArfO1F8gdreDylz0OpKRX7oyGH5GChhJNgn9RYWYL24yU2x4LpA6u3l
         E/thbU/BnQMadGxEWgoAdYswv1X+Fl8g/RXpK4RnS7p7w62A+PP4M90XEkdzcr3hVJf7
         C8oFds3kNIT5sTim4fUDIZVP0I6wPE7YlUUt8KGQtS0kVb9gTFD5TEYJVIpTnXWGd9q/
         WYOgp+i7wrzxytghVHWkfENaNJBnbThhBzspR4WPrqvkeJEJ2hyrrkfkuuA0Px8hehOy
         IlSA==
X-Gm-Message-State: AC+VfDyTyr9mB7faTKmqgmYx4HJUZ/0XXhRYrHuE1QHHaReQCbhRSlIL
        GdSuJzHx6khX3nL5IKBzhCk=
X-Google-Smtp-Source: ACHHUZ77CeU9LlusWbTYX/0bQN+RqGpPsH5qayXpKqdIVOBhbDFoXVf1dKOoEkCu5uTSC/6Yr7C0oA==
X-Received: by 2002:adf:fd46:0:b0:30e:5c55:3e42 with SMTP id h6-20020adffd46000000b0030e5c553e42mr4107354wrs.56.1686242956394;
        Thu, 08 Jun 2023 09:49:16 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5089000000b0030ae973c2e7sm2059546wrt.83.2023.06.08.09.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:49:15 -0700 (PDT)
Message-ID: <2ea8d3cf-40d3-3409-5f53-e2eb117ffd9c@gmail.com>
Date:   Thu, 8 Jun 2023 18:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/5] ASoC: mediatek: mt8188-mt6359: Cleanup return 0
 disguised as return ret
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
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
> Change all instances of `return ret` to `return 0` at the end of
> functions where ret is always zero and also change functions
> mt8188_{hdmi,dptx}_codec_init to be consistent with how other
> functions are returning errors
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index b2735496d140..260cace408b9 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -491,11 +491,13 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
>   	}
>   
>   	ret = snd_soc_component_set_jack(component, &priv->hdmi_jack, NULL);
> -	if (ret)
> +	if (ret) {
>   		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
>   			 __func__, component->name, ret);
> +		return ret;
> +	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
> @@ -513,11 +515,13 @@ static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
>   	}
>   
>   	ret = snd_soc_component_set_jack(component, &priv->dp_jack, NULL);
> -	if (ret)
> +	if (ret) {
>   		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
>   			 __func__, component->name, ret);
> +		return ret;
> +	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int mt8188_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
> @@ -539,7 +543,7 @@ static int mt8188_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
>   		return ret;
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int mt8188_max98390_hw_params(struct snd_pcm_substream *substream,
> @@ -612,7 +616,7 @@ static int mt8188_max98390_codec_init(struct snd_soc_pcm_runtime *rtd)
>   		return ret;
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int mt8188_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
> @@ -660,7 +664,7 @@ static int mt8188_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
>   		return ret;
>   	}
>   
> -	return ret;
> +	return 0;
>   };
>   
>   static void mt8188_nau8825_codec_exit(struct snd_soc_pcm_runtime *rtd)
> @@ -697,7 +701,7 @@ static int mt8188_nau8825_hw_params(struct snd_pcm_substream *substream,
>   		return ret;
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static const struct snd_soc_ops mt8188_nau8825_ops = {
