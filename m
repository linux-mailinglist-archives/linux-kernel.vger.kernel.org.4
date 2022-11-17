Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1504762D6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiKQJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiKQJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:23:45 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4D76177
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:23:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so1804204lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moN6KHYbdG/Z4IisuTSl+R5V5aPET/l8Rjzbwgo1qiA=;
        b=SPJV0CHvwWkdFKqyvd3WpOzIWZWSjVO7qYRQt12x55t36GQyJ7862UtICr58yvksuY
         0ZE7/PX9Hvt6F9aUp3Q27qOD90gmvbcCZ6ZLkBY1eOhTITdHM9jT2aIepQSvrlZjQaK+
         BRUANqK79cZrxmYPphcYf+EoWqdryNg8vO2jsKChMS6BJkvF26BzO6IKAW+uHsO/m96f
         ffBtLoJxT2VGTmr+hA38/y/9ShlOGrJT7m2RCq3ees9e+iVxLjNhBVZnPQfyIOGfM60y
         uD6hwYK1QDoMWG5wi32dvSwh02aL5ebbHM2um9D5MRzD5NwYTOPIFaQzyBCkdM1JdE+k
         3TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moN6KHYbdG/Z4IisuTSl+R5V5aPET/l8Rjzbwgo1qiA=;
        b=mc3Vk1NVCxwgEDccSkyVxF9JdCkS63d/O5YPT+ls9f33mNkFwjfndve6g+lbi6rni5
         5Yg2X0r2IAPTnOo8mjQ3vrJ7JwaErzVXQpnEnBoq3rqxRoBMTdqOj9h6Y63r5Pm2H7D/
         lLp6VADVBpcvJsdtQPq9zeRsk9DqJJ/zChLlz9JLOi1Lhl7zDJb10QjxoM/i5ceD9j5W
         8sI6ZLKIaBTaaImCbl3OICULWje0KrUnMUYm9/YKvB+MFzzMAkvAH9UeGYW+ZySdduB3
         xNUJMHGiKwv6EG5e30tKdyqnQXY5S2NqXswrui6RA+gEtho2QrWb3DcxKKUkeHfHqQH3
         TbqQ==
X-Gm-Message-State: ANoB5pkO68rlFi5IgQkee0ILw+KAk27IW+qtJuGEAvJxMng2TnFYGhji
        Wo3ogA7OokMZvejkE/ouFNwtNA==
X-Google-Smtp-Source: AA0mqf6FtIUZgijIAa3c32/SuuDTu5zyBG3bUfwJ4xptof8kulXHdhgEiKlnk6AwSZ8JJTZcv7hvFQ==
X-Received: by 2002:a05:6512:49a:b0:4aa:da5d:dfd8 with SMTP id v26-20020a056512049a00b004aada5ddfd8mr647737lfq.677.1668676986196;
        Thu, 17 Nov 2022 01:23:06 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bd4-20020a05651c168400b0027628240ff7sm92899ljb.135.2022.11.17.01.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:23:05 -0800 (PST)
Message-ID: <5d1b9912-8de1-6f71-8a79-66d02d50842e@linaro.org>
Date:   Thu, 17 Nov 2022 10:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/9] clk: qcom: gdsc: Add configurable poll timeout
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-3-abel.vesa@linaro.org>
 <9c5b6037-c962-81d3-41c1-a9ec459c9adc@linaro.org>
 <Y3XrQrnT0dxTvc5S@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y3XrQrnT0dxTvc5S@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2022 09:05, Abel Vesa wrote:
> On 22-11-16 12:19:09, Konrad Dybcio wrote:
>>
>>
>> On 16/11/2022 11:47, Abel Vesa wrote:
>>> Depending on the platform, the poll timeout delay might be different,
>>> so allow the platform specific drivers to specify their own values.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>    drivers/clk/qcom/gdsc.c | 5 ++++-
>>>    drivers/clk/qcom/gdsc.h | 1 +
>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>> index 0f21a8a767ac..3753f3ef7241 100644
>>> --- a/drivers/clk/qcom/gdsc.c
>>> +++ b/drivers/clk/qcom/gdsc.c
>>> @@ -107,7 +107,7 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
>>>    	do {
>>>    		if (gdsc_check_status(sc, status))
>>>    			return 0;
>>> -	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
>>> +	} while (ktime_us_delta(ktime_get(), start) < sc->poll_timeout);
>> What about the second usage of TIMEOUT_US (in gdsc_toggle_logic)? Is it fine
>> for that to be the default value?
> 
> The usleep you mention is not really for polling the state.
> So I think it should stay as is. Who knows, maybe in the future we will
> need to have the configurable as well, but as a toggle delay rather than
> a status poll timeout.
> 
> I added this configurable poll timeout just because I saw that
> downstream, each driver has different values. And it kind of makes sense,
> because the state machine inside the GDSC might be different between
> platforms, and so, it might take different time to reach a certain on/off
> state.
> 
> Thanks,
> Abel
Okay, thanks for explaining

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
>>
>>
>> Konrad
>>>    	if (gdsc_check_status(sc, status))
>>>    		return 0;
>>> @@ -454,6 +454,9 @@ static int gdsc_init(struct gdsc *sc)
>>>    	if (ret)
>>>    		goto err_disable_supply;
>>> +	if (!sc->poll_timeout)
>>> +		sc->poll_timeout = 500;
>>> +
>>>    	return 0;
>>>    err_disable_supply:
>>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>>> index 803512688336..9a1e1fb3d12f 100644
>>> --- a/drivers/clk/qcom/gdsc.h
>>> +++ b/drivers/clk/qcom/gdsc.h
>>> @@ -36,6 +36,7 @@ struct gdsc {
>>>    	struct generic_pm_domain	*parent;
>>>    	struct regmap			*regmap;
>>>    	unsigned int			gdscr;
>>> +	unsigned int			poll_timeout;
>>>    	unsigned int			collapse_ctrl;
>>>    	unsigned int			collapse_mask;
>>>    	unsigned int			gds_hw_ctrl;
