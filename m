Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9730B749A48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjGFLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjGFLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:10:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB4102
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:09:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so728979e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688641789; x=1691233789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRiuKcFF4D+Ma/+WP7HwqWtEf6Dd+kBdcV9nMz+Xal8=;
        b=wCQyNj8kDh/OsyddAN39TNa2jnM2R2His5q/FBgPX+0PzMpAkseWY4CyUHa2Jj5QJ+
         m2BQ3dZamSYppisNMU1d0hbm7bc1ddRHVRiH1XGod9MWd4AmceZfDWO7BxpVYPvV0SIP
         iFDUok5hM3iHd/fSo5yflzUdEkyJNKi+BAk+K9/p6qrQPtSh5rAcjQYpZ8rhE/r7traN
         Jse3mJXIdUVWx1j0IXkDwN0sEjOIyikCHwjYZDHxh9B7749PS66Nfq6f/W0pPSXENgqX
         A1LOSY9WZyRv8wlCMGJ09lMkNry9HWhS5JMV0ceppDabZTWiJ2lh+hRYEqDxREgrwh5y
         W7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688641789; x=1691233789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRiuKcFF4D+Ma/+WP7HwqWtEf6Dd+kBdcV9nMz+Xal8=;
        b=QAEcDyVwXQtpOFN7fOTQyc/gmT+TtTVOMraN2/Shs5bArLLjbXguncalXOuQ3ZZJ1v
         6TcuDWzlHHMxaFSxRfxI7/mPpBf5+1miREXIeUnf2SmCkv3GVS5f8b337FLZZx02xXEj
         3VUnJDD4PRugi5CL9aKs4i6OUcxD04nWfDI3ASacUfUbqmrAc49AJiaOFbBk8ODENenL
         I/fxTldVrkAGqMk96+IrppugEYej1T3ReHHhpADM/4WS6mwWZ+cLnyYpoYGUoax/wl2K
         gYxVNH3w9xX2NKMcKm1uvGogBTPIkU7vF5G3Em92uANr5vEXO4SrfAU7t8vzPche04wG
         Lvlw==
X-Gm-Message-State: ABy/qLarsx9iQcKo7JdnfMmUiCDmExTtSlJRIcloH4YPC6iuQNrtMgfQ
        /MTElBkeSwiuFxxQJnmZjHV1iQ==
X-Google-Smtp-Source: APBJJlFr0goL3O6OGKwREZsKNTnsILJbcu1yBKhHSIpf/ySaPhU/h5xY6c9b0kLkZyP65pD6yUsZTg==
X-Received: by 2002:ac2:4438:0:b0:4f8:7568:e94b with SMTP id w24-20020ac24438000000b004f87568e94bmr1128208lfl.56.1688641788898;
        Thu, 06 Jul 2023 04:09:48 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o18-20020a05600c379200b003fbe561f6a3sm4763165wmr.37.2023.07.06.04.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:09:48 -0700 (PDT)
Message-ID: <31bcbd57-1087-e8a4-6061-0fb89a82aec5@linaro.org>
Date:   Thu, 6 Jul 2023 12:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/8] ASoC: codecs: wcd-mbhc-v2: fix resource leaks on
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
 <20230705123018.30903-7-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230705123018.30903-7-johan+linaro@kernel.org>
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
> The MBHC resources must be released on component probe failure and
> removal so can not be tied to the lifetime of the component device.
> 
> This is specifically needed to allow probe deferrals of the sound card
> which otherwise fails when reprobing the codec component:
> 
>      snd-sc8280xp sound: ASoC: failed to instantiate card -517
>      genirq: Flags mismatch irq 299. 00002001 (mbhc sw intr) vs. 00002001 (mbhc sw intr)
>      wcd938x_codec audio-codec: Failed to request mbhc interrupts -16
>      wcd938x_codec audio-codec: mbhc initialization failed
>      wcd938x_codec audio-codec: ASoC: error at snd_soc_component_probe on audio-codec: -16
>      snd-sc8280xp sound: ASoC: failed to instantiate card -16
> 
> Fixes: 0e5c9e7ff899 ("ASoC: codecs: wcd: add multi button Headset detection support")
> Cc: stable@vger.kernel.org      # 5.14
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
>   sound/soc/codecs/wcd-mbhc-v2.c | 57 ++++++++++++++++++++++++----------
>   1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index 1911750f7445..5da1934527f3 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -1454,7 +1454,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> -	mbhc = devm_kzalloc(dev, sizeof(*mbhc), GFP_KERNEL);
> +	mbhc = kzalloc(sizeof(*mbhc), GFP_KERNEL);
>   	if (!mbhc)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -1474,61 +1474,76 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
>   
>   	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_sw_intr, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
>   					wcd_mbhc_mech_plug_detect_irq,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"mbhc sw intr", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_mbhc;
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_press_intr, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_press_intr, NULL,
>   					wcd_mbhc_btn_press_handler,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"Button Press detect", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_sw_intr;
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_release_intr, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_release_intr, NULL,
>   					wcd_mbhc_btn_release_handler,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"Button Release detect", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_btn_press_intr;
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
>   					wcd_mbhc_adc_hs_ins_irq,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"Elect Insert", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_btn_release_intr;
>   
>   	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_ins_intr);
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
>   					wcd_mbhc_adc_hs_rem_irq,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"Elect Remove", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_hs_ins_intr;
>   
>   	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_rem_intr);
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_left_ocp, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->hph_left_ocp, NULL,
>   					wcd_mbhc_hphl_ocp_irq,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"HPH_L OCP detect", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_hs_rem_intr;
>   
> -	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_right_ocp, NULL,
> +	ret = request_threaded_irq(mbhc->intr_ids->hph_right_ocp, NULL,
>   					wcd_mbhc_hphr_ocp_irq,
>   					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
>   					"HPH_R OCP detect", mbhc);
>   	if (ret)
> -		goto err;
> +		goto err_free_hph_left_ocp;
>   
>   	return mbhc;
> -err:
> +
> +err_free_hph_left_ocp:
> +	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
> +err_free_hs_rem_intr:
> +	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
> +err_free_hs_ins_intr:
> +	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
> +err_free_btn_release_intr:
> +	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
> +err_free_btn_press_intr:
> +	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
> +err_free_sw_intr:
> +	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
> +err_free_mbhc:
> +	kfree(mbhc);
> +
>   	dev_err(dev, "Failed to request mbhc interrupts %d\n", ret);
>   
>   	return ERR_PTR(ret);
> @@ -1537,9 +1552,19 @@ EXPORT_SYMBOL(wcd_mbhc_init);
>   
>   void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
>   {
> +	free_irq(mbhc->intr_ids->hph_right_ocp, mbhc);
> +	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
> +	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
> +	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
> +	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
> +	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
> +	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
> +
>   	mutex_lock(&mbhc->lock);
>   	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
>   	mutex_unlock(&mbhc->lock);
> +
> +	kfree(mbhc);
>   }
>   EXPORT_SYMBOL(wcd_mbhc_deinit);
>   
