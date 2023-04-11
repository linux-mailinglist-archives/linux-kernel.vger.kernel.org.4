Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D906DDC13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDKNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:30:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850F135
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:30:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504a37baf98so1430167a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681219838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gO2BTkJ++4qTrFAxR5g0p2pWZdBPYvq38Dgem4/uZdA=;
        b=gcMAXMGhw2SS8c+rNdp3D5J4cwxSIVFrv6OyO1uj6eQICcXc133bZLFg+xvp/JgnT0
         uU4VIv2Spb7+wPox1KSk7oz853N+fej7SRwJQClfyCvRGe/+1e1BuV0BqcE7attVv7Nw
         blE5XUhJzFsR9w3vqdvF4T0l5trF/WK6yHbz1zYUq6D6B5ynsZjkz4+tRcitVr0BhWik
         cfPFtwzM/uw2F+sLNOA5AyRm1JuBVmCQ/aGK/yRaXOQiPIrlLjcg24YRNF6IHxFp46+C
         xIW7B9BDOqIGsq5WUPYjo/XJ8lU5/koYXiK9zMR2cG6GQlCyRQnEzO25P/eKyCgZMexJ
         8Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO2BTkJ++4qTrFAxR5g0p2pWZdBPYvq38Dgem4/uZdA=;
        b=JbsgswSoi3K380AkObJouTGMR0z47wJcZIR0vFrjj8ZHbyh9wCoM5k5CeQpRecKfQU
         zH+On92V4HkrD9Ke9xOuyXW8JEwaz1PYHSgbovDkviPUWb1+RoKOCdQfYpqELxW4bCtr
         +bWeBVjMBzB3giOouEaCY69TlWJOn40D9Kb9p9/hjoVj6KK0warMIIV5xZfUC7Ki7XeU
         BCzGImMsdiXb5yD36+ghB7dt1tTZcv+iJjRkovQiw3gXB5i3znlPbTtsYtRAGTcdkMRW
         gzMVDgoqLWirRlZslvugRr7ZQZE5eXFlMHVRFXFrA+0Uk54uAnGwqSFrEzA+ZAcd+XC4
         Igpw==
X-Gm-Message-State: AAQBX9eLA8h11tz28EC+oAJ1z2l7zGKn05Yyt7PNTaYWap47k+j6fHA1
        Ms2MyX6LYYfABLO264na+KygIQ==
X-Google-Smtp-Source: AKy350bapoxh14R/6n3+7EJ8biqLy3ACVSR7SGlD2+rApnKehuhP1+1eyysnkJF3GYv6k1aT0xlHpQ==
X-Received: by 2002:aa7:ce15:0:b0:4fe:9374:30d0 with SMTP id d21-20020aa7ce15000000b004fe937430d0mr8787658edv.39.1681219837758;
        Tue, 11 Apr 2023 06:30:37 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o5-20020a509b05000000b005049b063736sm2602057edi.27.2023.04.11.06.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:30:37 -0700 (PDT)
Message-ID: <7af7475e-e8d3-6cf0-d879-4f9599bd1cfd@linaro.org>
Date:   Tue, 11 Apr 2023 14:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: soc-compress: set pcm nonatomic flag from dai_link
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
References: <20230411110831.813-1-srinivas.kandagatla@linaro.org>
 <14976031-7d63-4069-8647-3cee41064215@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <14976031-7d63-4069-8647-3cee41064215@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2023 14:25, Pierre-Louis Bossart wrote:
> 
> 
> On 4/11/23 06:08, Srinivas Kandagatla wrote:
>> In compress offload case we never set nonatomic flag on a new pcm. This triggers
>> below configuration error with DPCM on Qualcomm setup where dai_links are marked
>> as nonatomic.
>>
>> "FE is atomic but BE is nonatomic, invalid configuration"
>>
>> Fix this by Updating the pcm nonatomic flag correcly from the respective dai_link.
>>
>> CC: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/soc-compress.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
>> index 554c329ec87f..a8d70274cab8 100644
>> --- a/sound/soc/soc-compress.c
>> +++ b/sound/soc/soc-compress.c
>> @@ -615,6 +615,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>>   			return ret;
>>   		}
>>   
>> +		be_pcm->nonatomic = rtd->dai_link->nonatomic;
>>   		rtd->pcm = be_pcm;
>>   		rtd->fe_compr = 1;
>>   		if (rtd->dai_link->dpcm_playback)
> 
> isn't this fixed already? Daniel Baluta sent a patch for this, already
> applied by Mark:
> 

Thanks for pointing this, Yes, It is fixed in sound-next.. my branch was 
a week+ old so did not spot it :-)

--srini
> https://lore.kernel.org/alsa-devel/20230324124019.30826-1-daniel.baluta@oss.nxp.com/
