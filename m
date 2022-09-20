Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B705BDFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiITIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiITITy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A1642EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:17:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s14so1021708wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=i/SVyHf5uhkNd+oOQ1j8B0CS4C1F0nyqp8RGFx50BGM=;
        b=t8GO30+RYsyD6KakHvs5H0TSzI2o3v/yM+4P17hqqio0MKQKDyvfWWn5NJbyDjQvLt
         ThxwQj06nNEbPKi7OMzVBXsCNz2azELPZaClB9H3xMEBcqTGF6YAd1bzU2SrVPUiWjUK
         VbQJkGuDP+oW5/xhIITGZ7Yb81M2fWMZKQxNr4WJlilsG8/qj4GvpVw5tb3j/wOYsASS
         y4ofQFgBtQBi+kAHqw8EbasuKCvrEqEK3gCtUPbh7DhwGhTALk2O2CZzh1QEeucTGmai
         sxFGKP+mN1JRU7JARIhdJc8WmOSyB5t4GXa1ivSMSsGD0rmsKMJIPI1mZBTmszJ+3oVV
         X8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=i/SVyHf5uhkNd+oOQ1j8B0CS4C1F0nyqp8RGFx50BGM=;
        b=7gIvTTU8OHKQbNXh5fQYkcQkv0xzjEitVRPuMUMQ7xRKObcDpScdusyKn/ZTRbaLsh
         0i88LZ/zXSH5Cs1OqOJrZ5j4K13tcDmOMLjyui8kM4k3VvLz6N7ymXisKxjVnYtb9SQB
         pcw+REBhRfM2QU7c5kMcxsnwdEE1tv3z4u8NnnuCItWGsI7r4jIh9vPEEssHqtbeW94K
         xcnBe5aiEfg/KA7f6jChGR0c7Pfgz0q4ilCbXBlEihbPEqnvC7ule0eCLqmOyoNc3imp
         c5T9SwtWaMNWhpy5qcb6gRjpAdW9RbQh6vwrqyyVZ6PCI2owVOHaeUq/TcHuIoBSiROP
         2IQg==
X-Gm-Message-State: ACrzQf1d79RiQLtKyl5AumKGd/W4no6xILenpzgNox1reqJmPd9X4eDZ
        wix/xaeWg49EftzJtwRMXTXYBw==
X-Google-Smtp-Source: AMsMyM7znY5JAx7G32cOuz/YUFx2JQP41fqHoTJhgsTnB8VUTTEJMYd4k9qwTDBv4u5aWBSPXAszlg==
X-Received: by 2002:a5d:5a15:0:b0:228:cd90:ccd with SMTP id bq21-20020a5d5a15000000b00228cd900ccdmr14022732wrb.658.1663661821036;
        Tue, 20 Sep 2022 01:17:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id q9-20020adff509000000b0022aeba020casm859875wro.83.2022.09.20.01.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:17:00 -0700 (PDT)
Message-ID: <bdb8efa9-9b72-9db5-4e3b-17c518cacaf2@linaro.org>
Date:   Tue, 20 Sep 2022 10:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more
 robust and safer
Content-Language: en-US
To:     cgel.zte@gmail.com, andrzej.hajda@intel.com
Cc:     robert.foss@linaro.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com
References: <20220920061655.214785-1-chi.minghao@zte.com.cn>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920061655.214785-1-chi.minghao@zte.com.cn>
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

Hi,

On 20/09/2022 08:16, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> That's now the recommended way to copy NUL terminated strings.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> v1->v2
> using DRIVER_NAME instead of "DW-HDMI".
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> index 7d2ed0ed2fe2..8cb6177f976d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> @@ -542,8 +542,8 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	strlcpy(card->driver, DRIVER_NAME, sizeof(card->driver));
> -	strlcpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
> +	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
> +	strscpy(card->shortname, DRIVER_NAME, sizeof(card->shortname));

OH, I did misread the first patch, and it was in fact ok... I'll apply v1 instead !

Thanks for fixing, but sorry for my wrong review...

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

Neil
