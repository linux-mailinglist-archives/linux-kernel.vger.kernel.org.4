Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30AF707195
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEQTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEQTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:11:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46947E67
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:11:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f1411e8111so1385963e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684350703; x=1686942703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54iwv/pGzux9yUooHmL70lgD44/ZcJlgzOCmfdHgBto=;
        b=uXKqksZ2ucaYLlDpISTIWF6CU6gZIsSWQMMCvItyiZPfUXEnKMqv/zEdE1mKgC9o9A
         uixAWtffzvQv+EwuxqvWr1aUCuYCC+lLVO51NVwdAIw/iC0GF7UeaevYSFG6lOhg1QUN
         NI2ka+hKR8P88dK4M/uWuO093Hvn0+9IzfsXrdPu13JYVLhXWWQw7VvAHctUUKxxeGA7
         YaxZlFD2VNm3ZhTCW1T8DnEXe1ggMBwa9OWTmn+A3iad+dnNbSrKq9uLoxmWbfRt8t7N
         UhYpbq6QP+V1nlv5NQuatD9WMsTTasTm/qBzTqyvaESVvMYNNNzj21L0BPKHpGELKD9u
         op2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350703; x=1686942703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54iwv/pGzux9yUooHmL70lgD44/ZcJlgzOCmfdHgBto=;
        b=P67smAYGO1ux9fVywd1EfVNEdQ03d2rBj5kctV3zFdsotEAaEcjVjBptoWluo6TNzJ
         YgowRRKhitxgDPulQSS73UlKT9acIphPIK/dmLMBDM+O+6W3IxALi0Mbh1kpQkn24M0z
         RXuTq+nnDWZ9me4I51o44J1oqsqIDgwyuV+F5vTnL0ppvIAC/7cUaC12ARSto3X4KR9Y
         uSzvd2N9xq7WlMeJbfhXJvcg5qe1gdROKgcu6/1PfHRThbKq80OZafKwbso4UDDJfDjg
         Th9k5L1Qh5oVosEtuRydWA5DcpJeWt3e4ZSFa7QQNt49ibav8l2iDt1FbZBwoDcBZJwC
         Xbxg==
X-Gm-Message-State: AC+VfDySJW1qYLg52p8zsZPcpNhJzTTnZNH0MuePQpnAaTxtTVTxBUPY
        V8xkfuX6YXPwGUtKAohDIvh2AA==
X-Google-Smtp-Source: ACHHUZ7Ok6LehYkCwfiScUDyFS6l76YaTjpbf2vGVyHHiMNUo1oqXp2JOmH5PCmZZEe8/TewtLBSBQ==
X-Received: by 2002:ac2:4143:0:b0:4f3:895f:f3f8 with SMTP id c3-20020ac24143000000b004f3895ff3f8mr410341lfi.16.1684350703501;
        Wed, 17 May 2023 12:11:43 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id t24-20020ac243b8000000b004eff4f67f1csm3478306lfl.304.2023.05.17.12.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:11:43 -0700 (PDT)
Message-ID: <2a04cde4-ae8e-82b0-d467-0fc32d0c67b7@linaro.org>
Date:   Wed, 17 May 2023 21:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] clk: qcom: smd-rpm: conditionally enable scaling before
 doing handover
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
 <20bd79c1-6c38-f1ed-1661-6fa4c308c5c5@linaro.org>
 <2679120.mvXUDI8C0e@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2679120.mvXUDI8C0e@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 16:59, Luca Weiss wrote:
> On Dienstag, 16. Mai 2023 03:27:46 CEST Konrad Dybcio wrote:
>> On 6.05.2023 22:10, Luca Weiss wrote:
>>> On older platforms like msm8226, msm8974 and msm8916 the driver in the
>>> downstream kernel enables scaling first before doing the handover of the
>>> clocks.
>>>
>>> While this normally doesn't seem to cause noticeable problems, on
>>> apq8026-asus-sparrow this causes the device to immediately reboot,
>>> perhaps due to older rpm firmware that becomes unhappy.
>>>
>>> On newer platforms the order has swapped and enabling scaling is done
>>> after the handover, so let's introduce this behavior only conditionally
>>> for msm8226 and msm8974 for now.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>
>> Did you give this a spin on some 8974? I think hammerhead had
>> issues around rpmcc in the past..
> 
> Yes, appears to be fine on msm8974 also.
> 
> I tried to reproduce the hammerhead ocmem hang we had in the past but even 
> with v6.3 rpmcc it seems to be fine. But iirc it was happening more or less at 
> random in the past so wouldn't be surprised if my tests just didn't show 
> anything on accident.
> 
> Regards
> Luca
OK sg

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
>>
>> Konrad
>>
>>>  drivers/clk/qcom/clk-smd-rpm.c | 16 +++++++++++++---
>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c
>>> b/drivers/clk/qcom/clk-smd-rpm.c index 887b945a6fb7..6d5476afc4d1 100644
>>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>>> @@ -178,6 +178,7 @@ struct clk_smd_rpm_req {
>>>
>>>  struct rpm_smd_clk_desc {
>>>  
>>>  	struct clk_smd_rpm **clks;
>>>  	size_t num_clks;
>>>
>>> +	bool scaling_before_handover;
>>>
>>>  };
>>>  
>>>  static DEFINE_MUTEX(rpm_smd_clk_lock);
>>>
>>> @@ -693,6 +694,7 @@ static struct clk_smd_rpm *msm8974_clks[] = {
>>>
>>>  static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
>>>  
>>>  	.clks = msm8974_clks,
>>>  	.num_clks = ARRAY_SIZE(msm8974_clks),
>>>
>>> +	.scaling_before_handover = true,
>>>
>>>  };
>>>  
>>>  static struct clk_smd_rpm *msm8976_clks[] = {
>>>
>>> @@ -1318,6 +1320,12 @@ static int rpm_smd_clk_probe(struct platform_device
>>> *pdev)> 
>>>  	rpm_smd_clks = desc->clks;
>>>  	num_clks = desc->num_clks;
>>>
>>> +	if (desc->scaling_before_handover) {
>>> +		ret = clk_smd_rpm_enable_scaling(rpm);
>>> +		if (ret)
>>> +			goto err;
>>> +	}
>>> +
>>>
>>>  	for (i = 0; i < num_clks; i++) {
>>>  	
>>>  		if (!rpm_smd_clks[i])
>>>  		
>>>  			continue;
>>>
>>> @@ -1329,9 +1337,11 @@ static int rpm_smd_clk_probe(struct platform_device
>>> *pdev)> 
>>>  			goto err;
>>>  	
>>>  	}
>>>
>>> -	ret = clk_smd_rpm_enable_scaling(rpm);
>>> -	if (ret)
>>> -		goto err;
>>> +	if (!desc->scaling_before_handover) {
>>> +		ret = clk_smd_rpm_enable_scaling(rpm);
>>> +		if (ret)
>>> +			goto err;
>>> +	}
>>>
>>>  	for (i = 0; i < num_clks; i++) {
>>>  	
>>>  		if (!rpm_smd_clks[i])
>>>
>>> ---
>>> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
>>> change-id: 20230506-rpmcc-scaling-handover-a63029ed9d13
>>>
>>> Best regards,
> 
> 
> 
> 
