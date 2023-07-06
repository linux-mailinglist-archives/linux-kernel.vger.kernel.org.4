Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3E749A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGFLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjGFLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:09:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB2DC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:09:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso6064615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688641750; x=1691233750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4pJMNxdRYP6BWhbdIUrCN4Z4INLjW+mU8oEQ+C2oq0=;
        b=Qyt1S6dW0DJHS9Qwr6lQFv0KX6BIiN/hDvnwUc5Nob/8jVfskxy5bjk9zDFKVViUdL
         r0ZyxrGM75LdfQGVyoecfc/byaadeOsgN49+KyF5gckB4e1vDphVLF6eGpMBEj5OkvSw
         LGvnbohKEg+50mocgJaa0y7kOlSJYg5H3qcbh/3UyzcCxJA2ZyD8xHqk0tUNOx2lZouV
         M1sRZdBBy8prC14qbwYmVfetcRESsy0VKweU7LQjwq0D/vXBNzJNx7snLQczkCty/ITB
         S6XWZDZ+zErZHNLrhwt0WCjT7tScFvGVb3Iz7Y656IblYfY0bR7SlE/eTFX8xD6aCdSa
         hTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688641750; x=1691233750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4pJMNxdRYP6BWhbdIUrCN4Z4INLjW+mU8oEQ+C2oq0=;
        b=iV8uoVkBqFkPRhQaaY8Vq7xo0lT3MW5N/p2Z29kXf1fALcy6lUmfZRHwsB5Er4644R
         6qWGVczsUcZkVREsqHlc0W4zOiXCzMaKCWJhIpSQd34iuO5eVd62g9KmU9ZjEqEbrnoU
         euhy7m3qSF6qdFFVQ18OoKwMuT4aMJwIrN4aDpREpc4sXJXregvjLYcHSdNtXI74hf48
         ceh73Ge/3hMG8+EPFx6aNBsb2jG1BTVZl+VTj7daGvumHyVlq2NJ+FNNMZu8PbZ8D9wp
         XIvVVDv1hdKpvlq6psdu/7SPNdWXE1II3zQ+i8d17FgAdb7vr14EnQEeQsN6ioB4yWES
         cgig==
X-Gm-Message-State: ABy/qLbC+MUsxah4U+UCZPJ18hOFrrb8RMcZxWxA6ncJ1conwC1u1v3B
        1pDHhiShOI25FSHrzi5LbbdEXw==
X-Google-Smtp-Source: APBJJlEwlWIIftTa7gVX+PL/PhpqiVsjsG9ggmBOPIkfwoJfsfs9brTOMymuBcGCGggJ5cVGxBm3AA==
X-Received: by 2002:a7b:cd08:0:b0:3fb:d81a:8b4 with SMTP id f8-20020a7bcd08000000b003fbd81a08b4mr2651wmj.16.1688641750542;
        Thu, 06 Jul 2023 04:09:10 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z18-20020a5d6552000000b0030fd03e3d25sm1591490wrv.75.2023.07.06.04.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:09:10 -0700 (PDT)
Message-ID: <3819b919-b096-31c9-525b-03a8b52df3b7@linaro.org>
Date:   Thu, 6 Jul 2023 12:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/8] ASoC: codecs: wcd938x: fix missing clsh ctrl error
 handling
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
 <20230705123018.30903-4-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230705123018.30903-4-johan+linaro@kernel.org>
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
> Allocation of the clash control structure may fail so add the missing
> error handling to avoid dereferencing an error pointer.
> 
> Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
> Cc: stable@vger.kernel.org	# 5.14
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


>   sound/soc/codecs/wcd938x.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index faa15a5ed2c8..2e342398d027 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -3106,6 +3106,10 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
>   						 WCD938X_ID_MASK);
>   
>   	wcd938x->clsh_info = wcd_clsh_ctrl_alloc(component, WCD938X);
> +	if (IS_ERR(wcd938x->clsh_info)) {
> +		pm_runtime_put(dev);
> +		return PTR_ERR(wcd938x->clsh_info);
> +	}
>   
>   	wcd938x_io_init(wcd938x);
>   	/* Set all interrupts as edge triggered */
