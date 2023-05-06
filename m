Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534E36F904C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjEFHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEFHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:43:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883B9E46
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:43:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so16941275e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358981; x=1685950981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fW4KRIYUMRVsD5UctMtgx/S9KUAXGGFHwiF8ujkNxLM=;
        b=aafNNnNg3WETWSnrpa2zXFujk6MCMhxzi/+xAHoyg6PlXfPHNnnc0gYXK2171mT2cz
         5DsjTcEWGKhu7nVn23M8T8V/3vrb5F6Z5ZzESgcJxBkaSkxzO31v1wflW4qXVyeU3xak
         Go1j3XCxgmdqoSWWYk9LKCWVXxFtIPTtEuiwEczJqW6tByz9BOE/LMGZSpeSbWMROq9u
         XOkGZOtOW0z42kvPgsARNjFixrDfmNZ49QVP/deCXzfuHQFJn1zIj8p6nF0/MHOrmNHS
         H/OPnpdlLOguj4ZAiNERbzwIsDYBzEI0CCmBELYwuW+7ZYBBTvwC+xdzZ6WHMjpPsbuO
         juCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358981; x=1685950981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW4KRIYUMRVsD5UctMtgx/S9KUAXGGFHwiF8ujkNxLM=;
        b=CQdhi2rpQj1DWAVEoG3EvgDgVdXDw+ulaJdVxCXjksZKEjohOPJW1h5ohT31FSXckq
         5Kz+PAMukLSqyrb2mrsrGDKBQEqg2MGMpq/ooYo/XWdBBxmsuw9hWJAEsozOYhrckYat
         gQCTtIZI319+44kZ/GyAqK+8JCunA7FNTLfWc3j0kieJdkNOZTOSM7AGm44Y4kHJBWk5
         6Q1SUxhz60s6f92gId38JWCU2Jn5Q58XQONeAYzSe+ChNX1MKu7pARWSFv0ENh8676RF
         G1gng6fyznCL6L/FvuBiUAUZjSXwV9n94yFow9t/qPTjJLl2jX+ezZYnTR3MmTNJTq/l
         zbqg==
X-Gm-Message-State: AC+VfDx3s8DYegt+kBM0PH8X21bieWIlHpwdXmp3RryWX2zPvvKMU+it
        4zyhH/8hamMAd0XzIFmbJ3DRzQ==
X-Google-Smtp-Source: ACHHUZ605kDOxqkmkZRMGKiOsisZf8+xAmQJT2IqoRzmIBY9Zxj+uSKlW43jZ7WJHJR5CY76pECKBA==
X-Received: by 2002:a05:6000:c:b0:306:32fa:6737 with SMTP id h12-20020a056000000c00b0030632fa6737mr2892704wrx.8.1683358981048;
        Sat, 06 May 2023 00:43:01 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o17-20020a5d4091000000b003078a3f3a24sm702366wrp.114.2023.05.06.00.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 00:43:00 -0700 (PDT)
Message-ID: <4823a770-f3c4-695f-5699-4c8d8179b507@linaro.org>
Date:   Sat, 6 May 2023 08:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] ALSA: pcm: add snd_pcm_add_chmap_ctls_with_prefix
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     broonie@kernel.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
References: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
 <20230505165514.4666-2-srinivas.kandagatla@linaro.org>
 <87ttwqgfxh.wl-tiwai@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <87ttwqgfxh.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/05/2023 06:57, Takashi Iwai wrote:
> On Fri, 05 May 2023 18:55:12 +0200,
> Srinivas Kandagatla wrote:
>>
>> On Qualcomm SoC which has multiple Display Port controllers, using
>> snd_pcm_add_chmap_ctls() to add chmap controls from every ASoC hdmi codec
>> instance for a give card fails while adding second instance as the control
>> with same name "Playback Channel Map" already exists from the first instance.
>>
>> Fix this by adding a new api wrapper to pass ASoC component name prefix to
>> avoid such duplicate control naming.
> 
> It implies that you have conflicting PCM objects with the same PCM
> device number from the same card.  How can it be?
Thanks for the inputs, this is only issue with my local changes, Sorry 
for the noise, Please ignore this series.

I had some local changes to debug an issue around pcm device numbering 
with backend dailinks from device tree and frontend dailinks from tplg.
Will start a new thread to discuss this issue.

thanks,
srini
> 
> 
> Takashi
