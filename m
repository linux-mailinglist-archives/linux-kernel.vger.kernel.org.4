Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E476C30A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCULqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:46:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA74AD04
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:46:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i9so13341273wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679399161;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Aoa86AtLIbV7nO5suJgaHyPoZu1RFBX6SeZwEU5izi0=;
        b=g0tDnK7U3yE1cXgUCouZXhSeaPQjHU0hO0Wb7E6Rrp9eYGppf7tv6hE/VIdtGhnLJC
         iURk84zw+7T5jTFbfO2/eM8m2Ffql0M50F3blCnmfrPlhyhTb8p6rRREXjOfExH57QaJ
         spPBaJDlPM0/IDowS5CT/3HZSVO8aBrlcishTtyVWw2dOIy/qVrDxoS3BKirb0t285nf
         r4pyjxkN+DT/m4A1tBXThODVVPeNkhgQgnJDswE5n6jM8d/y7IZyjES0LgmMOAIqB7jV
         5ycLODo/DHSEd/fnUrMywCLko9ijPvyELlJprcZaH7ilLhXCkWo2KvItPOSlkWBIdtMq
         V66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399161;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aoa86AtLIbV7nO5suJgaHyPoZu1RFBX6SeZwEU5izi0=;
        b=lmftFeHWBQUBP6l1VrNP5fZoEIZgjhGUpzfMuufn8ytpFRAW/5XpzlyK1TNnE3RidF
         8YRwQmpD2RQJEVoZIeIiRcmtU4NTVM67UTYCk+vb7rTK6hHXej075s1Gcpvwm2jEG0TB
         x6BRKfFokcDh1GJyg/tqpv+VCDfrJhErf7x81xf/QbNKcZgWQsvKuhDk96+lrFLulsRL
         GqH+bZZSeSQhvEP6opyJVqP3rlrp9OoFSNoVU8YNbB70Djj94QQ2uXjJ9l6mm7dSj1GL
         ujqEZBVx93NNqUo0ZwbTmkAiR3U6OE1JCDXYYwpLQlqggH43ak28ev3Eit9xpBEEtgEN
         hOfA==
X-Gm-Message-State: AO0yUKUNTGcjEuzYwIhNmXQvU/yMQ65MGbAFw3K2/bmfrNrMGsMCDZIO
        dh0bxuvFETvTtWymDYncNDdf0w==
X-Google-Smtp-Source: AK7set9UnwHxt4TUznSruwgSkTeqo/4spI6v/mq5YvGSm1KsUXOMir+4ZvQ98uVGlqIMqKA2STyEBg==
X-Received: by 2002:adf:dccb:0:b0:2d0:d739:e37e with SMTP id x11-20020adfdccb000000b002d0d739e37emr1999488wrm.40.1679399161083;
        Tue, 21 Mar 2023 04:46:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8ed:7915:30cc:f830? ([2a01:e0a:982:cbb0:c8ed:7915:30cc:f830])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b002c552c6c8c2sm11115902wri.87.2023.03.21.04.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:46:00 -0700 (PDT)
Message-ID: <e768dd6c-5945-c1ed-89c5-b250bc90241f@linaro.org>
Date:   Tue, 21 Mar 2023 12:46:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 RFC] rtc: meson-vrtc: Use ktime_get_real_ts64() to get
 the current time
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-rtc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230320212142.2355062-1-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230320212142.2355062-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 22:21, Martin Blumenstingl wrote:
> The VRTC alarm register can be programmed with an amount of seconds
> after which the SoC will be woken up by the VRTC timer again. We are
> already converting the alarm time from meson_vrtc_set_alarm() to
> "seconds since 1970". This means we also need to use "seconds since
> 1970" for the current time.
> 
> This fixes a problem where setting the alarm to one minute in the future
> results in the firmware (which handles wakeup) to output (on the serial
> console) that the system will be woken up in billions of seconds.
> ktime_get_raw_ts64() returns the time since boot, not since 1970. Switch
> to ktime_get_real_ts64() to fix the calculation of the alarm time and to
> make the SoC wake up at the specified date/time. Also the firmware
> (which manages suspend) now prints either 59 or 60 seconds until wakeup
> (depending on how long it takes for the system to enter suspend).
> 
> Fixes: 6ef35398e827 ("rtc: Add Amlogic Virtual Wake RTC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/rtc/rtc-meson-vrtc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
> index 1463c8621561..648fa362ec44 100644
> --- a/drivers/rtc/rtc-meson-vrtc.c
> +++ b/drivers/rtc/rtc-meson-vrtc.c
> @@ -23,7 +23,7 @@ static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
>   	struct timespec64 time;
>   
>   	dev_dbg(dev, "%s\n", __func__);
> -	ktime_get_raw_ts64(&time);
> +	ktime_get_real_ts64(&time);
>   	rtc_time64_to_tm(time.tv_sec, tm);
>   
>   	return 0;
> @@ -96,7 +96,7 @@ static int __maybe_unused meson_vrtc_suspend(struct device *dev)
>   		long alarm_secs;
>   		struct timespec64 time;
>   
> -		ktime_get_raw_ts64(&time);
> +		ktime_get_real_ts64(&time);
>   		local_time = time.tv_sec;
>   
>   		dev_dbg(dev, "alarm_time = %lus, local_time=%lus\n",

Thx for the fix!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
