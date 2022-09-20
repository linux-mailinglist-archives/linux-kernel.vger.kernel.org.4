Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6F5BDFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiITIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiITIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EB6FF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:17:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id cc5so2968297wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=l9gtbM2uto1x5bgL0a0otnawkJGJbySIPkwXwU+/1Sg=;
        b=g0l7m7UeOdhQ1PnCBXbxUamAfihljV9V2FnQje6nfTZog1OMNhC8oL2nO8DhxAHrdz
         R5tjgOGSyumGkF1pwo5z9ZhIt6dtb8075rVEd0oApEB71LEbSqSUTlsR+EYRxDVa3Lu8
         O+M8MmsB1I9X2KmauJ8B5tR6kOAf5niG8lHh5Je0byFx2N6cYQQqgVnAETPrQm822657
         YCcAnFbL9A6L59hlZ4tsyqYSyzTIcsC5bqU+4Hl6WMx9QJcCoacg34iA3YmNAviHMt2M
         G3tn/H27cfKd2XR8nEMg2hGrsCRaySYxd8kgkvHDc8Y2YLYU+EuDxVMvRszMbjSiW2gX
         nLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=l9gtbM2uto1x5bgL0a0otnawkJGJbySIPkwXwU+/1Sg=;
        b=ufPhbQb6/8Plg+S9yr0Ofi7vy1Qd2T79nsd5pawFtAcqr7larZ/WLsseCWuIid1sIu
         TeouYz1iGAk0Dvk7bMXby2kJaGYfpwHpDo8jJswAQ0TK7vqQF8DkadZTBa2ZkwQ9CP82
         aWdKpeKor2wQjlHUWutkug4UODLCtnR4mYdQ3IwnzZNrNZunPZpoxwGJCIwks9iTJHMv
         HVSUVQ1+SmBtOIFWDhi7uUyKd0xs+z/NSWz8IkcAinPN+BdsSx+utcoyouWlIaUjgcR8
         VCrKF+BrrIMVzyUp5wz36zg1pwAo0e5qi5sEkFjW4/pKDLSOpncLGv9pUwYMSkIZPUbI
         pB1g==
X-Gm-Message-State: ACrzQf3/IqXRGvUuf5Ak6RLtPiO7VrWFXf5l8LHBTb8fL2MLboqkoFtf
        ovQ8DZgKSl5xDcZffw3KW2VThQ==
X-Google-Smtp-Source: AMsMyM7tatwTKzU25uwqfUSidVRXEueFyIejARipSVNwx7OXnQPpPmj88gcBjqsYA2tRb+GzRzL8Iw==
X-Received: by 2002:adf:9b97:0:b0:22a:e61a:4b0c with SMTP id d23-20020adf9b97000000b0022ae61a4b0cmr10134280wrc.290.1663661859773;
        Tue, 20 Sep 2022 01:17:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b00228d183f9c2sm973130wrb.89.2022.09.20.01.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:17:39 -0700 (PDT)
Message-ID: <4aa7744a-f002-9029-d50d-bae43c051559@linaro.org>
Date:   Tue, 20 Sep 2022 10:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more
 robust and safer
Content-Language: en-US
To:     cgel.zte@gmail.com, andrzej.hajda@intel.com
Cc:     robert.foss@linaro.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        dri-devel@lists.freedesktop.org
References: <20220919030401.211331-1-chi.minghao@zte.com.cn>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220919030401.211331-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 05:04, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> That's now the recommended way to copy NUL terminated strings.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> index 7d2ed0ed2fe2..4efb62bcdb63 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> @@ -542,8 +542,8 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	strlcpy(card->driver, DRIVER_NAME, sizeof(card->driver));
> -	strlcpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
> +	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
> +	strscpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
>   	snprintf(card->longname, sizeof(card->longname),
>   		 "%s rev 0x%02x, irq %d", card->shortname, revision,
>   		 data->irq);
> @@ -561,7 +561,7 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
>   
>   	dw->pcm = pcm;
>   	pcm->private_data = dw;
> -	strlcpy(pcm->name, DRIVER_NAME, sizeof(pcm->name));
> +	strscpy(pcm->name, DRIVER_NAME, sizeof(pcm->name));
>   	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_dw_hdmi_ops);
>   
>   	/*

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
