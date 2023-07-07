Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAA274B152
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGGMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:54:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A61BF4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:54:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so1887552f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688734473; x=1691326473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//HmX2rwH4kNsgH83nKEdamx6qwz4xhPHaVhwq5zDNc=;
        b=DBvyiGaQWXVlWzt3CvPY5sxFRQUw8nXRMtQDxRwIJ8zj+XJcDEUxOsujGhtXBFOAHy
         bW/s+9ngfwoVnD6g88h9hsuy9gr99f2jPN+O297guVAHuQPErDCGYTDADGtOYTyVc7Gs
         C4JkzA3Dj7TiJIGjwmoivhD7WyOXafTc+8dc6thUy81uVSbBp9ovMbjatMjGf9ClDvKU
         pFHQ7vbDXfIKALy+bOg+AUIo+H50bYpUhrvAzuF8tXXmuKpKV+unxfgmy1tAs4BCOVjz
         MiYxO14J3KUhqj2gtNtwZJaFw2Lc4auomOApRyGPLPWIEo7bSdmoddL8p8y7sYlTTrmL
         l1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688734473; x=1691326473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//HmX2rwH4kNsgH83nKEdamx6qwz4xhPHaVhwq5zDNc=;
        b=G3CMrPmN2ODS+MlhUSYjv1HUKdRLwZDGNz6FDtV9rxlcWbA8BQDjP1gTtt6kXJXlAl
         NOfauuUJRM0yEee1h1P8pOyNcDKU4yDta/2GbiDN/GinEtPRZ+sFs9T3G95lIigDAr6Q
         dm1uRq869fGKvqCspiJw0irdxnk+zMc/51L+ZBegVa+t4CYeytZW/s75lAX6D/qrV6A6
         XDgh4/Y52jJXs9Dkftcv4VrxVkRegGsxXJMxOz2DutC5voIFIjOJVp5inY2V9rkG4dIs
         bJJpClQAtGQMXqs08Vb+jHitPPLmHf36vD4g1n1VcPRAtaAEh1/yUFDHeg3R2sXb/AEk
         ZR2A==
X-Gm-Message-State: ABy/qLa/nWMNAZmO3+uCb7JS7UGlZlv7UUyrQ+v6HLtIi2FgVPaqpqpI
        48t99YVdtt80As1M6Zpp1Kq4rg==
X-Google-Smtp-Source: APBJJlHvsrINvPQT0ac2eHj3X1qsLxYz25VEg3MHYtCOHGh7p/6C1edZJp6JGL5VpbqsaehK1vgDTA==
X-Received: by 2002:a05:6000:150:b0:306:46c4:d313 with SMTP id r16-20020a056000015000b0030646c4d313mr3928132wrx.28.1688734472847;
        Fri, 07 Jul 2023 05:54:32 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k15-20020a056000004f00b003140fff4f75sm4436162wrx.17.2023.07.07.05.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 05:54:32 -0700 (PDT)
Message-ID: <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
Date:   Fri, 7 Jul 2023 13:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2023 08:35, Johan Hovold wrote:
> On Wed, Jul 05, 2023 at 01:57:23PM +0100, Srinivas Kandagatla wrote:
>> dB range for HPHL and HPHR gains are from +6dB to -30dB in steps of
>> 1.5dB with register values range from 0 to 24.
>>
>> Current code maps these dB ranges incorrectly, fix them to allow proper
>> volume setting.
>>
>> Fixes: e8ba1e05bdc0("ASoC: codecs: wcd938x: add basic controls")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/codecs/wcd938x.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>> index faa15a5ed2c8..3a3360711f8f 100644
>> --- a/sound/soc/codecs/wcd938x.c
>> +++ b/sound/soc/codecs/wcd938x.c
>> @@ -210,7 +210,7 @@ struct wcd938x_priv {
>>   };
>>   
>>   static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
>> -static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
>> +static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);
> 
> This looks wrong, and indeed that forth argument appears to be a mute
> flag. I guess that one should have been 0 (false) here?

yes, this should be true instead of a mute dB value.

> 
> Headphone output also appears to be way too loud by default with this
> patch (alone) applied. Perhaps it's just the default mixer settings need
> to be updated to match?
> 
> It looks like you're inverting the scale above. Perhaps that's intended,

yes, the highest value corresponds to lowest dB which is why its inverted.

> but some more details in the commit message as to what was wrong and
> what you intended to do would have been good.

HPHR/HPHL Volume control is broken on this codec.
current UCM uses digital volume control for x13s which needs to be moved 
to Analog volume control.
I have this change https://termbin.com/mpp9 in UCM which I plan to send 
out once I test and fix other paths as well.

--srini
> 
> Johan
