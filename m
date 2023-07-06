Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBE749A45
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGFLJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjGFLJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:09:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798BB1FE5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:09:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so725846e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688641776; x=1691233776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIfq4MRzR+KoZPI1E9eD68L1Fz5A5ss/vOUye0MENZk=;
        b=Eu+qCiJb9/ZQziHich993INIybqg5yUVTuFRG8v+m1ZYi1/RozbOLY1UNN8f/ZQkZg
         6Hyb002LVetWGbB5bopkDcBSfKL4EJxQGT8Tsq7itQMAYt6vsHxczuar1nzxn/3Q/cJN
         UecBxQ9KawO3nDK/Gm97C7Y1Z7Ya42Awa8seKVpA8jsOybCHvpzYIM/0TaGqCQ7acRnB
         6KbL9xHzZDtbflOJ9gsrpJx6/AzIshQiJUXyItjUFaLOH5wI2u10tF3ylKTgb3Pv7xSK
         vxbKBadnqWFKTSRpwYAd6MPEYA4Lk0yCHRA854KXvkE6MBzzGqSBcxKMah+MsSskK1Mc
         qqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688641776; x=1691233776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIfq4MRzR+KoZPI1E9eD68L1Fz5A5ss/vOUye0MENZk=;
        b=bo8fAHTRbXIUsgVkF0KVmOhnCMgo5ht06/mDLbPid0Rnk9d/8C4xNSwmZZomtZSP4t
         Eyz/U8b6tBzVob8dl+zTi6lwdkxmx/IroKCir0eWGl8CHcBhUOakhkz5oSN79sh332eC
         QzUo/mJmGGbQpCZqmIjnv4IS4WbAuDZKPDIoP880SoCPhkM9lmRYA3ZFWAEDnlIBnJKn
         cz13t00UmVGRiqCXavRf8RdgIjsdUQ8WEsX16PzgXLV/XPOlaDCp8r2Dn0iocsz2L/SO
         uP55K5XX5TmnEmEzxn6P6zr+mOPtP0G78QLyr7ms6U1x82k1D+bp3S0QwuphEInm8fFJ
         llig==
X-Gm-Message-State: ABy/qLa2A+xbw9QiV9yUoTj7J4PJVRo9ei/yMmOfNq5nE9eWT/3tGugJ
        +bxLHXTP6VlyxpYMGWzapO+qtw==
X-Google-Smtp-Source: APBJJlF5NH85gPa/S229vpji4QxH175vQhrtxSWkFPBoWHTwM4BvsECkcwnnHswVVAWLFpm7U+teIw==
X-Received: by 2002:a05:6512:3da8:b0:4fb:8b2a:a4af with SMTP id k40-20020a0565123da800b004fb8b2aa4afmr1592839lfv.2.1688641776427;
        Thu, 06 Jul 2023 04:09:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id p14-20020a056000018e00b003113ed02080sm1574066wrx.95.2023.07.06.04.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:09:35 -0700 (PDT)
Message-ID: <af3ea27a-5940-5279-5590-fe7a42bdfdfa@linaro.org>
Date:   Thu, 6 Jul 2023 12:09:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/8] ASoC: codecs: wcd934x: fix resource leaks on
 component remove
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-6-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230705123018.30903-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2023 13:30, Johan Hovold wrote:
> Make sure to release allocated MBHC resources also on component remove.
> 
> This is specifically needed to allow probe deferrals of the sound card
> which otherwise fails when reprobing the codec component.
> 
> Fixes: 9fb9b1690f0b ("ASoC: codecs: wcd934x: add mbhc support")
> Cc: stable@vger.kernel.org      # 5.14
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/wcd934x.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index a17cd75b969b..1b6e376f3833 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -3044,6 +3044,17 @@ static int wcd934x_mbhc_init(struct snd_soc_component *component)
>   
>   	return 0;
>   }
> +
> +static void wcd934x_mbhc_deinit(struct snd_soc_component *component)
> +{
> +	struct wcd934x_codec *wcd = snd_soc_component_get_drvdata(component);
> +
> +	if (!wcd->mbhc)
> +		return;
> +
> +	wcd_mbhc_deinit(wcd->mbhc);
> +}
> +
>   static int wcd934x_comp_probe(struct snd_soc_component *component)
>   {
>   	struct wcd934x_codec *wcd = dev_get_drvdata(component->dev);
> @@ -3077,6 +3088,7 @@ static void wcd934x_comp_remove(struct snd_soc_component *comp)
>   {
>   	struct wcd934x_codec *wcd = dev_get_drvdata(comp->dev);
>   
> +	wcd934x_mbhc_deinit(comp);
>   	wcd_clsh_ctrl_free(wcd->clsh_ctrl);
>   }
>   
