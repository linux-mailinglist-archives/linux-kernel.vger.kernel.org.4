Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE172AB67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjFJMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:15:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CB35BC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:15:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so29727971fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686399309; x=1688991309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AamuwXwyb3NBK1JZt4SqfKXGSRl4csVWF1Q9Qma/rA=;
        b=Zm+33gZqVkQP+H2rd+2hVYpMNUl69pvQZWEOFzMMWKGgeFt+pMC3WdWgkncAOLy0Re
         5bBPxXlUdyZuqCQ9aMnDcwQjKfaz1FxrX2pgKI9lx1i26vq8UhhnOYKnRr6iw+plr318
         tB4OOHAypw2Q3ocXa85FO6lMHr+0JmrKzBUvTllxJGxPjgTOgvcdV4y+a5Ae1mPu0oEr
         pgxpRHe34h0ERh6Hz8gG/QiC6SDIxkP4B0tPFqftz/FIbkLM5iMUK/iyHijKIDYcA6e8
         Nhym0OugygH9NfzPC7h9Jp5+alYUqfff5tn7vb3WCjPQgdN8XtEV9NCKjLcqRLQs80vS
         ZgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686399309; x=1688991309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AamuwXwyb3NBK1JZt4SqfKXGSRl4csVWF1Q9Qma/rA=;
        b=iQ28xizFVbZbRmDmzjXEli7rZC2Gv9vhn39TlueySl4TU149ArlhsAdDoGTvUJDJ6c
         yArUh6ccD4AlPB/8FP0jg0GQafzRkN4FQ+QpRgN5K75ZJ5gj0qWMGFUXd1N+O4Hi3i4X
         ipSTK6iUKwWKZgoj64FJx/lokXzVrHGR2sReFIoUDqnjDDIQxFEwTQ9Qmepx+JiyJqYF
         79smp3Uc6DqIbdnLDiABIkQKki8nrO/By3wgCF3yZw0nFH1HenkroQDr/eDmGDbObJnM
         XaFHUxqw5z82IoIp/emM9Ejj0ieaGnjz1z3qkS1u5yN6zvC2aEqanQtYI/AXWG5lxKNK
         Enpg==
X-Gm-Message-State: AC+VfDzYOXSjvhdpgHFFAIQy5q690ELWoMkh72uVqrnUTVV4m94jh0l3
        gxjPyzaklgAbVzJPWI3PaRN6rQ==
X-Google-Smtp-Source: ACHHUZ6wpmqIIvEIUC+34R3+IdZ2T7tJJdv1EJsBcAWcf83NNyj1DG5z27VSYWt41nrwvviA+IxDtw==
X-Received: by 2002:a2e:9b11:0:b0:2b1:c0f6:e955 with SMTP id u17-20020a2e9b11000000b002b1c0f6e955mr597321lji.43.1686399309286;
        Sat, 10 Jun 2023 05:15:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u24-20020a2e8558000000b002b161e6c7basm794034ljj.108.2023.06.10.05.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 05:15:08 -0700 (PDT)
Message-ID: <40f937bb-0d7e-a237-1672-5905983622ce@linaro.org>
Date:   Sat, 10 Jun 2023 14:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 04/22] clk: qcom: smd-rpm: Export clock scaling
 availability
Content-Language: en-US
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIRgGXwKD6mcgTRY@gerhold.net>
Content-Type: text/plain; charset=UTF-8
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



On 10.06.2023 13:35, Stephan Gerhold wrote:
> On Fri, Jun 09, 2023 at 10:19:09PM +0200, Konrad Dybcio wrote:
>> Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
>> clock rate requests will not be commited in hardware. This poses a
>> race threat since we're accessing the bus clocks directly from within
>> the interconnect framework.
>>
>> Add a marker to indicate that we're good to go with sending new requests
>> and export it so that it can be referenced from icc.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
>>  include/linux/soc/qcom/smd-rpm.h | 2 ++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>> index 937cb1515968..482fe30ee6f0 100644
>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>> @@ -151,6 +151,7 @@
>>  #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
>>  
>>  static struct qcom_smd_rpm *rpmcc_smd_rpm;
>> +static bool smd_rpm_clk_scaling;
>>  
>>  struct clk_smd_rpm {
>>  	const int rpm_res_type;
>> @@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
>>  	return r->rate;
>>  }
>>  
>> +bool qcom_smd_rpm_scaling_available(void)
>> +{
>> +	return smd_rpm_clk_scaling;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
>> +
>>  static int clk_smd_rpm_enable_scaling(void)
>>  {
>>  	int ret;
>> @@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
>>  		return ret;
>>  	}
>>  
>> +	smd_rpm_clk_scaling = true;
>> +
> 
> If you move the platform_device_register_data(&rpdev->dev,
> "icc_smd_rpm", ...) from drivers/soc/qcom/smd-rpm.c to here you can
> avoid the race completely and drop this API. I think that would be
> cleaner. And it will likely probe much faster because probe deferral
> is slow. :)
Sounds like an idea.. especially since it's pretty much the only
dependency other than SMDRPM itself!

Konrad
> 
> Thanks,
> Stephan
