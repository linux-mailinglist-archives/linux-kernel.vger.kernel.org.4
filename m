Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA85BC4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiISI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiISI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:58:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72967D127
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:58:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so46393531wrp.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v7YvGusii2VWZOurmgvHPkAuYpvgY/iuHE+RqeSdYqI=;
        b=GJoLxPx811a04N6H2o44fP5LKcu2VG0CzmzazXzZSGTadhR9XsLH4GG6p4I7ICwzbR
         uY28MGejpO8x9ub1f9YpHFTl1vxaIm0LHikJECh5HQVbRnjFZjuFpJz6Qiz7MpUKLtE2
         xh+rPO5AN6ZLz43A41JBhwtpqUISY4MYpafWGRQxctK70+P/x6A0lJTW6qTTTrfsAhBv
         jllrkeoZJ559SJ5R5flPL3AvlQwURKjPgkxxUw6Zs7g91bDdjBBZWZJIU8dUQd0Hw7PI
         01ZRlV45+Khappbww9ibR7pTcj0OmktzAM8LwKJp40FXz5P/rKvMcLyqJVuuYI947xY7
         0pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v7YvGusii2VWZOurmgvHPkAuYpvgY/iuHE+RqeSdYqI=;
        b=qls4yCZhrQTJY6x5g0+ZlRxFpv9g9AFf/iTnto/5TlNiZebyxukiinOV3gya0f6eMe
         7TIVsJ8AVdTtCTIn45D1GnGTiSKJ0WLGiY1B1/nb25WKvMlguUeE5HdXmRGIbGDnQgD3
         Gpsg9bLz6AUTxEmRgjHtMLxUzn4lH+tcr7glmPaEZ5IGuvoYQi+/B/4LNyGK2p5ar91X
         p79u32ruxgu8ZH5eJVmnlDv+Bu3Dn70Cml2zzPcFAog3KN+ykrRJnfA+kW+yHTBmm2CZ
         WNs1u0UC9KYimkzGHVJjxXtRe7jM4eN71v6U4UeBYfocTt57hWI6Hq9h9cTHzgUsLDN5
         +eCw==
X-Gm-Message-State: ACrzQf303ShCHNc+NjGlJ2HU+pYT8woS4He0TUe7VBuvgmvcx2ZSKjPN
        neJkvBkQuDqurt1ElsDYX0f8jQ==
X-Google-Smtp-Source: AMsMyM4cww1aT+UyEi2mGQSWgBrXtd8K3pDPv0LQhtIrLRHZBUYk6cWyL8YyQ4KeV8LQa4h1u318XA==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr9996948wrw.179.1663577898020;
        Mon, 19 Sep 2022 01:58:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f618:2ad3:3fb0:7965? ([2a01:e0a:982:cbb0:f618:2ad3:3fb0:7965])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0022762b0e2a2sm13504272wrg.6.2022.09.19.01.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 01:58:17 -0700 (PDT)
Message-ID: <5aed4431-e99c-a3a1-1cc3-0f8a57e99827@linaro.org>
Date:   Mon, 19 Sep 2022 10:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more
 robust and safer
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     robert.foss@linaro.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        dri-devel@lists.freedesktop.org, andrzej.hajda@intel.com
References: <20220919030401.211331-1-chi.minghao@zte.com.cn>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20220919030401.211331-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


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

Please keep using DRIVER_NAME in both lines.

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

Thanks,
Neil
