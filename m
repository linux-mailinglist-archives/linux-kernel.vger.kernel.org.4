Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33C36E944E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjDTMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDTMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:30:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C95FF7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:30:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b16so6049754ejz.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681993819; x=1684585819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH3tKKTTbR7ydKTmk89P7HY1g6F2kMXmEFuZQTvaqAE=;
        b=lfm2Ps5voBZpRWSgtp1JnnrKXApYgIzvhki/Gi1i1/YZAzamhfj9P6lDcLEuTym4ew
         ZyXvL66Dn9GaQu+V6LQISR3t+iE8PSXWllVaL+5hrGA66tT883KxlXIIJMqg9pcBAuJJ
         Zzz5ndepDFnw1M4TR3nJUiqsHqOtBSkpeb+8hR60ILutQR8XqU5xF3FHt38hMkEwwEsi
         OKEiDXau/yf2EyrROmqUYyEd/gcVf6ngyeGbd0Gkl/xhbKAMI5D0L8WJ9YXWswoyMcxC
         h3MAXulvmDrg+ZI8ulk9DdNGwgHxRDOeAVVEAW1UrtHXhNvF96NBaJUR1DEU8Jlv9hZx
         zghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993819; x=1684585819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AH3tKKTTbR7ydKTmk89P7HY1g6F2kMXmEFuZQTvaqAE=;
        b=KtVjzlMn3MbNgvVc4A51QiR9U1zLUipGBkvJLw6W2OX/TRKReH9tcMEdLjZy73JH9k
         vB9Uqycx2g3WHGR5jhvGCHpzfXF7KnhR0b3NzXVhR7xAM4Ey0MDZup/vLzak7vXFrTf8
         50RNJjI+Vs+Hf7xK5CWaek6dQhE4fov9a79Wc3iZcXLmwWu0N6A/6KsW8b+ZXsHIbgIS
         L/a8rXdbUbroCN1azO/UIpvudQWuY9xv98zhQyE+DdO7b6+9iUxxYF1HHE8WE50w9Yb1
         v2THwqMp3C8ePooFBJA6LQswlppcwTmINy6QDlCmFM5bqkHHNDR8C6wdgPPTwtL2cqw5
         kKPw==
X-Gm-Message-State: AAQBX9dvJtctIOBVC7gCBLJ5smlcPnDZ1m5PC+fNNqjv8L1lyiROmzP4
        n8pfj9HBOHr2fAIlrUClcw/J9w==
X-Google-Smtp-Source: AKy350Y2xDKZe/gbJvtstCxeETEqBiQ9MDJOoV3vTS92ppsMpVgAHyLVPr3IWjXlLvuSyvoV/tvBWQ==
X-Received: by 2002:a17:906:f8d2:b0:94f:705e:d9e4 with SMTP id lh18-20020a170906f8d200b0094f705ed9e4mr1349881ejb.31.1681993818974;
        Thu, 20 Apr 2023 05:30:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id ce17-20020a170906b25100b009532427b35asm691504ejb.7.2023.04.20.05.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:30:18 -0700 (PDT)
Message-ID: <fe6202ee-2552-8b5c-c2d5-f2f7042b901d@linaro.org>
Date:   Thu, 20 Apr 2023 14:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
 <6b355201-a957-4fca-a513-d5fa0742fb40@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6b355201-a957-4fca-a513-d5fa0742fb40@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 13:58, Mark Brown wrote:
> On Thu, Apr 20, 2023 at 12:16:12PM +0200, Krzysztof Kozlowski wrote:
> 
>> -	gpio_direction_output(wcd938x->reset_gpio, 0);
>> -	/* 20us sleep required after pulling the reset gpio to LOW */
>> +	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
>> +	/* 20us sleep required after asserting the reset gpio */
> 
> This is inverting the sense of the GPIO in the API from active low to
> active high which will mean we're introducing a new reliance on having
> the signal described as active low in DT.  That's an ABI concern.

It's bringing it to the correct level. Old code was not respecting the
DTS thus if such DTS came with inverted design, the driver would not work.

We were already fixing the upstream DTS users and I thought all of them
are fixed since long time (half a year) or even correct from the
beginning. Now I found one more case with incorrect level, which I will fix.

> 
> I remain deeply unconvinced that remapping active low outputs like this
> in the GPIO API is helping.

The code is mapping them to correct state. The previous state was
incorrect and did not allow to handle active high (which can happen).
This is the effort to make code correct - driver and DTS.

Best regards,
Krzysztof

