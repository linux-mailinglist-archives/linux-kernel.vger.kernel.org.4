Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5D72AE6D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFJTjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFJTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:39:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5C2718
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:39:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so2543171e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686425947; x=1689017947;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivj4kBb4wltUdU71XlZeL5JCA/ynomKQYV+kfoyA22E=;
        b=ADm6//BxGc2oPbeb46UUQ1uLdar7JyMqpHc/2B3Bw/t17DRISNHzvrz4EWHY9IeIHA
         6z19h2ucXW+vQCBEbev4boY7t5uExRtYfHb0x1I9H/qrOL94UDxdx9ygqO5xw1AmunAZ
         6OXWlcBb1D+1My7gO+hV4XQWwfWNPGuDe3GydBrukts8gyE144Gx1y+dnQLft4wfIUQ0
         ZATzvMhbvFq3fc7CplR/Pyi2EeUIYRUSQMr/sCogtPfV89iZPaiLtuEp0lWLARlCd/35
         uxpIh7CjoZJWIVoY07Nm/Kihn8KwLxIwYlc3cGlHUX+L7tUSsU2FY/DYQX+YQpNaoosn
         pjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686425947; x=1689017947;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivj4kBb4wltUdU71XlZeL5JCA/ynomKQYV+kfoyA22E=;
        b=eAVBNFxenCmKUucP5G89p842zntOts5SGbev0wyfsRe3oYIbzgLYIwTc3VnemZEpoW
         VnncoKzQCfA9pEzKAmWZEg8iyoCjeSQxUkCfWkVFOlmRaUzRXH7dzJISZzc6w026HDNP
         xvCDuMH87VD/MbdkRNgEDMEmgeBIrdUGyUOVd98ygwGF/551pZi78+AifaqV/Bv0MiQt
         ffADUxQ0uX+cAU45rdas0AgTMN9J2p0T4nNpzq46Su+cuDMUqid8A8Zc/4sQbvLb/tkA
         v/3hkRCAHwJtkYlpj23qL5pPV9DG5coKV3qXwG/agDprK5mdEAqYZ2qz/hM2qDjllaBM
         y2fg==
X-Gm-Message-State: AC+VfDx6qWnXzqjdZuO+T+QR4RLLBvdwrfQ44YV7ozie/CslEzqSh9f2
        p3H9wLEmWBFKSgu1waUIxFZk5A==
X-Google-Smtp-Source: ACHHUZ7iWoFCQ0PazvZ5iVmvaDyIMxpfGSlR+ZTt2vNZuv8PgDkZiEPZQFocIbeyA6R5bUIDdT/TKQ==
X-Received: by 2002:a05:6512:3289:b0:4f0:1e7d:f897 with SMTP id p9-20020a056512328900b004f01e7df897mr2179520lfe.17.1686425947249;
        Sat, 10 Jun 2023 12:39:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25594000000b004f19bfdfef9sm951603lfg.21.2023.06.10.12.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 12:39:06 -0700 (PDT)
Message-ID: <c52f0311-a8a0-79af-2a08-51a8564a8b25@linaro.org>
Date:   Sat, 10 Jun 2023 21:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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
 <40f937bb-0d7e-a237-1672-5905983622ce@linaro.org>
 <b7b1d19c-b87d-b3fd-36aa-374065a45ede@linaro.org>
 <ZITOR3Y25Bv4msdm@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 04/22] clk: qcom: smd-rpm: Export clock scaling
 availability
In-Reply-To: <ZITOR3Y25Bv4msdm@gerhold.net>
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



On 10.06.2023 21:25, Stephan Gerhold wrote:
> On Sat, Jun 10, 2023 at 08:53:05PM +0200, Konrad Dybcio wrote:
>> On 10.06.2023 14:15, Konrad Dybcio wrote:
>>> On 10.06.2023 13:35, Stephan Gerhold wrote:
>>>> On Fri, Jun 09, 2023 at 10:19:09PM +0200, Konrad Dybcio wrote:
>>>>> Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
>>>>> clock rate requests will not be commited in hardware. This poses a
>>>>> race threat since we're accessing the bus clocks directly from within
>>>>> the interconnect framework.
>>>>>
>>>>> Add a marker to indicate that we're good to go with sending new requests
>>>>> and export it so that it can be referenced from icc.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
>>>>>  include/linux/soc/qcom/smd-rpm.h | 2 ++
>>>>>  2 files changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>>>>> index 937cb1515968..482fe30ee6f0 100644
>>>>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>>>>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>>>>> @@ -151,6 +151,7 @@
>>>>>  #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
>>>>>  
>>>>>  static struct qcom_smd_rpm *rpmcc_smd_rpm;
>>>>> +static bool smd_rpm_clk_scaling;
>>>>>  
>>>>>  struct clk_smd_rpm {
>>>>>  	const int rpm_res_type;
>>>>> @@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
>>>>>  	return r->rate;
>>>>>  }
>>>>>  
>>>>> +bool qcom_smd_rpm_scaling_available(void)
>>>>> +{
>>>>> +	return smd_rpm_clk_scaling;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
>>>>> +
>>>>>  static int clk_smd_rpm_enable_scaling(void)
>>>>>  {
>>>>>  	int ret;
>>>>> @@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
>>>>>  		return ret;
>>>>>  	}
>>>>>  
>>>>> +	smd_rpm_clk_scaling = true;
>>>>> +
>>>>
>>>> If you move the platform_device_register_data(&rpdev->dev,
>>>> "icc_smd_rpm", ...) from drivers/soc/qcom/smd-rpm.c to here you can
>>>> avoid the race completely and drop this API. I think that would be
>>>> cleaner. And it will likely probe much faster because probe deferral
>>>> is slow. :)
>>> Sounds like an idea.. especially since it's pretty much the only
>>> dependency other than SMDRPM itself!
>> It sounds great, but to not break bisecting one has to:
>>
>> 1. change the registration in soc/smd-rpm to store rpm ptr in driver
>>    data, in addition to parent driver data
>>
>> 2. change icc/smd-rpm to use the device and not parent data
>>
>> 3. add a platform_device_register_data call in clk-smd-rpm that will
>>    always fail because the device is always registered
>>
>> 4. remove the registration from soc/smd-rpm
>>
> 
> Logically the icc_smd_rpm device still fits better as child of
> smd-rpm and not clk-smd-rpm. So I would probably just continue
> registering it on the parent device from clk-smd-rpm.
> Then there are no changes necessary in icc_smd_rpm.
> 
> You could use this. Both touched files are Bjorn-maintained so should be
> manageable to have it in one commit. (note: compile-tested only)
> 
> Thanks,
> Stephan
> 
> From a2610adb2551b01e76b9de8e4cbcc89853814a8f Mon Sep 17 00:00:00 2001
> From: Stephan Gerhold <stephan@gerhold.net>
> Date: Sat, 10 Jun 2023 21:19:48 +0200
> Subject: [PATCH] soc: qcom: smd-rpm: Move icc_smd_rpm registration to
>  clk-smd-rpm
> 
> icc_smd_rpm will do bus clock votes itself rather than taking the
> unnecessary detour through the clock subsystem. However, it can only
> do that after the clocks have been handed off and scaling has been
> enabled in the RPM in clk-smd-rpm.
> 
> Move the icc_smd_rpm registration from smd-rpm.c to clk-smd-rpm.c
> to avoid any possible races. icc_smd_rpm gets the driver data from
> the smd-rpm device, so still register the platform device on the
> smd-rpm parent device.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Generally it looks good.. I'll give it a spin next week. One
thing below.

>  drivers/clk/qcom/clk-smd-rpm.c | 21 +++++++++++++++++++++
>  drivers/soc/qcom/smd-rpm.c     | 23 +----------------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index e4de74b68797..91adb16889b3 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -1302,12 +1302,20 @@ static struct clk_hw *qcom_smdrpm_clk_hw_get(struct of_phandle_args *clkspec,
>  	return desc->clks[idx] ? &desc->clks[idx]->hw : ERR_PTR(-ENOENT);
>  }
>  
> +static void rpm_smd_unregister_icc(void *data)
> +{
> +	struct platform_device *icc_pdev = data;
> +
> +	platform_device_unregister(icc_pdev);
> +}
> +
>  static int rpm_smd_clk_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	size_t num_clks, i;
>  	struct clk_smd_rpm **rpm_smd_clks;
>  	const struct rpm_smd_clk_desc *desc;
> +	struct platform_device *icc_pdev;
>  
>  	rpmcc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
>  	if (!rpmcc_smd_rpm) {
> @@ -1357,6 +1365,19 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> +	icc_pdev = platform_device_register_data(pdev->dev.parent,
> +						 "icc_smd_rpm", -1, NULL, 0);
> +	if (IS_ERR(icc_pdev)) {
> +		dev_err(&pdev->dev, "Failed to register icc_smd_rpm device: %pE\n",
> +			icc_pdev);
> +		/* No need to unregister clocks because of this */
> +	} else {
> +		ret = devm_add_action_or_reset(&pdev->dev, rpm_smd_unregister_icc,
> +					       icc_pdev);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	return 0;
>  err:
>  	dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 0c1aa809cc4e..427dd5392b82 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -19,7 +19,6 @@
>  /**
>   * struct qcom_smd_rpm - state of the rpm device driver
>   * @rpm_channel:	reference to the smd channel
> - * @icc:		interconnect proxy device
>   * @dev:		rpm device
>   * @ack:		completion for acks
>   * @lock:		mutual exclusion around the send/complete pair
> @@ -27,7 +26,6 @@
>   */
>  struct qcom_smd_rpm {
>  	struct rpmsg_endpoint *rpm_channel;
> -	struct platform_device *icc;
>  	struct device *dev;
>  
>  	struct completion ack;
> @@ -197,7 +195,6 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
>  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  {
>  	struct qcom_smd_rpm *rpm;
> -	int ret;
>  
>  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
>  	if (!rpm)
> @@ -210,24 +207,7 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  	rpm->rpm_channel = rpdev->ept;
>  	dev_set_drvdata(&rpdev->dev, rpm);
>  
> -	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> -						 NULL, 0);
> -	if (IS_ERR(rpm->icc))
> -		return PTR_ERR(rpm->icc);
> -
> -	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> -	if (ret)
> -		platform_device_unregister(rpm->icc);
> -
> -	return ret;
> -}
> -
> -static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
> -{
> -	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
> -
> -	platform_device_unregister(rpm->icc);
> -	of_platform_depopulate(&rpdev->dev);
> +	return devm_of_platform_populate(&rpdev->dev);
>  }
>  
>  static const struct of_device_id qcom_smd_rpm_of_match[] = {
> @@ -256,7 +236,6 @@ MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
>  
>  static struct rpmsg_driver qcom_smd_rpm_driver = {
>  	.probe = qcom_smd_rpm_probe,
> -	.remove = qcom_smd_rpm_remove,
This reaches over the removal of the icc registration, the depopulate
call should stay.

Konrad
>  	.callback = qcom_smd_rpm_callback,
>  	.drv  = {
>  		.name  = "qcom_smd_rpm",
