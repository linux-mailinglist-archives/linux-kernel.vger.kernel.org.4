Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B672AE30
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjFJSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjFJSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:53:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B531A30F5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 11:53:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6170b1486so3617486e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686423187; x=1689015187;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W3qXQBYLfvcOcHPwLf5dnUaJ1dWHnwvnx/YrwlI4M4=;
        b=iIXy+xM1Ri4iImRDYsrKmb7D4h8wFMuXYnw1T9OLhXI7ik6L7zBKci/6+NlEnL5I6B
         UpL5KVEAfCO8BRMHLC378WQHoMekUBNYtshZzhSpr4OsogNlpcxCSZGAvarENdg6Sn0z
         kWS2ZeyTQEoYMSRbv87efvP3PE1quMaWrbEwOGmIpWubHdMEUfNOEIPFX/UNN/9h2pS9
         7ojUyN4CNder2JVTn6gxgLSWE69AeWSXAfyAmOqdmPCyP3iViQwfNRl2zASK7WOu34TW
         1SJqZtIXCt+yrUa3MXEZtWwCg/8LRh8lqpp5ZpfDjYPkZdXvBRi1pBbIpiVLdRxojJ+l
         YDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686423187; x=1689015187;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4W3qXQBYLfvcOcHPwLf5dnUaJ1dWHnwvnx/YrwlI4M4=;
        b=aivcIlEhlNYKLwz8OKAoPcrpOz4f2FYHnsHHtjii+OvQBYiVJ0xsL6hpmwwvb+VLAA
         pm7ppw+coWpiAgq7vTHI4lV4urqovrWMxjsXTeybQBsm7NY04wK1paaUybyEoopDn7dh
         D+yF5OrEoAlmfug+dxFUY2TddSqO+09dPqlW1H1sbAKbblDJsCjL8PjlzF+RtFa0r5HP
         k6UG+0FetS0ywSxllkOsLpv6R1qFJQp9IZVEPxbQrB9BQc3DTNhrjUr7Rxwi+nC5dWTN
         GYOANwN7K4WrUcMrZjsgF0C8XLSIJ7nO70PGYKJMtrk/GN81dzzOaD8IMs6cFJXGFJYm
         Rzeg==
X-Gm-Message-State: AC+VfDwTOi39tBCvnRyrBe5mp5RT2ZyLp5WbbetUeEjiP4tS6eYp0zbs
        oDyFDTvSmkJkbZzj1VNediBU6w==
X-Google-Smtp-Source: ACHHUZ7mKB7lGRSqxZ50JKFb5GXFXrGSchRahf1U72h4atAMla4ilUk9lrxPcVX7Jxz/Yg7uzHAAWA==
X-Received: by 2002:a19:9202:0:b0:4f3:b242:aa98 with SMTP id u2-20020a199202000000b004f3b242aa98mr1746402lfd.30.1686423187420;
        Sat, 10 Jun 2023 11:53:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d17-20020ac25ed1000000b004db508326c0sm919441lfq.90.2023.06.10.11.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 11:53:07 -0700 (PDT)
Message-ID: <b7b1d19c-b87d-b3fd-36aa-374065a45ede@linaro.org>
Date:   Sat, 10 Jun 2023 20:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-4-e5934b07d813@linaro.org>
 <ZIRgGXwKD6mcgTRY@gerhold.net>
 <40f937bb-0d7e-a237-1672-5905983622ce@linaro.org>
Subject: Re: [PATCH v2 04/22] clk: qcom: smd-rpm: Export clock scaling
 availability
In-Reply-To: <40f937bb-0d7e-a237-1672-5905983622ce@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.06.2023 14:15, Konrad Dybcio wrote:
> 
> 
> On 10.06.2023 13:35, Stephan Gerhold wrote:
>> On Fri, Jun 09, 2023 at 10:19:09PM +0200, Konrad Dybcio wrote:
>>> Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
>>> clock rate requests will not be commited in hardware. This poses a
>>> race threat since we're accessing the bus clocks directly from within
>>> the interconnect framework.
>>>
>>> Add a marker to indicate that we're good to go with sending new requests
>>> and export it so that it can be referenced from icc.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
>>>  include/linux/soc/qcom/smd-rpm.h | 2 ++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>>> index 937cb1515968..482fe30ee6f0 100644
>>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>>> @@ -151,6 +151,7 @@
>>>  #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
>>>  
>>>  static struct qcom_smd_rpm *rpmcc_smd_rpm;
>>> +static bool smd_rpm_clk_scaling;
>>>  
>>>  struct clk_smd_rpm {
>>>  	const int rpm_res_type;
>>> @@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
>>>  	return r->rate;
>>>  }
>>>  
>>> +bool qcom_smd_rpm_scaling_available(void)
>>> +{
>>> +	return smd_rpm_clk_scaling;
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
>>> +
>>>  static int clk_smd_rpm_enable_scaling(void)
>>>  {
>>>  	int ret;
>>> @@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
>>>  		return ret;
>>>  	}
>>>  
>>> +	smd_rpm_clk_scaling = true;
>>> +
>>
>> If you move the platform_device_register_data(&rpdev->dev,
>> "icc_smd_rpm", ...) from drivers/soc/qcom/smd-rpm.c to here you can
>> avoid the race completely and drop this API. I think that would be
>> cleaner. And it will likely probe much faster because probe deferral
>> is slow. :)
> Sounds like an idea.. especially since it's pretty much the only
> dependency other than SMDRPM itself!
It sounds great, but to not break bisecting one has to:

1. change the registration in soc/smd-rpm to store rpm ptr in driver
   data, in addition to parent driver data

2. change icc/smd-rpm to use the device and not parent data

3. add a platform_device_register_data call in clk-smd-rpm that will
   always fail because the device is always registered

4. remove the registration from soc/smd-rpm


I know you'd love to see me break my [PATCH xx/42] record, but I'd say
that deserves its own series and *this* patch could be a good transition
middleground :P

Hopefully Stephen, Bjorn and Georgi won't send a hitman after me for
abusing atomic cross-subsystem merges..

Konrad

> 
> Konrad
>>
>> Thanks,
>> Stephan
