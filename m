Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6A6B905D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCNKnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCNKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:43:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13989CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:42:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i28so19427445lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678790552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddsEOqN0WCluTndil1PR5ITOkumrYADNMRhiGg1TLi8=;
        b=GiEuRVL3oLL6Vh+sncGzeoqofKVyv0oQaQnK1B5lKE+IQYpEUJO49q0Ycv97g9BFz6
         j7uwVrrCtpJnqtKgzkBL/w0bRPBjLXWpbze6CYBufebtkM0r9b2Y+5yqHCBpLtswdHlp
         aGh5wMAJHKCwYF/y0SQRrhVTo/4DIp9SQEJtriEoTcP7tnmd7lDJoocMm8AbU+mpRr5C
         avraMcBFlllF1GlbnCWfFwzWwfCa7lOa+84bjo6iligIncVgXzpS9DaiaXp6SH5aFxw/
         czRrXARjCNVbIFY8TP5VKCZK5UVeMH0JMDOYIMryU71nI3pt8Mu+ebvGe/ChjS8lvS08
         yQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678790552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddsEOqN0WCluTndil1PR5ITOkumrYADNMRhiGg1TLi8=;
        b=OmIQSGcjQFBGSzl37eW7f7qXu2SGOVYn5p1Yx4KpiwM4gDN0KF5IfPrO0H7PPKYm2X
         1BjqVONmfCOXpK7WuihAinXSWqKakK20N01nsJ3jlitJiV1t9KV+v+bztH5XSvSEllUk
         48QSrcaQ4S9rRdpdS29S1BTBpu0qnTOssVBg4wdtSoKA3fq0brRAYwN2qWfx3QeaivAw
         PgXY8OtsOGou9oUCOY1maIzx8Q36a6Jw5CVeuJxUvl+wApIVmT7Mi5XaGRmK1Pla8Rnz
         5TdsLIONySewSMNLXjx2VbKLb34NoDCFIVznglKXjWqOBIK3Gh2aUM587jCKVTIQyxaW
         zP8Q==
X-Gm-Message-State: AO0yUKWTXdqGLMWlh1q3Sge5ZT4rEfUuTRspWhWqoCMwgBAafa/WEpzT
        kPiINQj6hMttvRh6FyCRs+LYRw==
X-Google-Smtp-Source: AK7set/wgp8O8fMeZ11Mfbu0XNr4HVywv2i7lajlKxdFLMuiU8qd3wZT0aGnXXqUMdnxSLfygLGJYg==
X-Received: by 2002:a05:6512:3743:b0:4cc:ff7c:4846 with SMTP id a3-20020a056512374300b004ccff7c4846mr518444lfs.0.1678790551852;
        Tue, 14 Mar 2023 03:42:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w30-20020ac2599e000000b004b58500383bsm345858lfn.272.2023.03.14.03.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:42:30 -0700 (PDT)
Message-ID: <5a921230-c84f-aa10-1f5c-e9c2972fb9fd@linaro.org>
Date:   Tue, 14 Mar 2023 11:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 07/10] drm/msm/dsi: Remove custom DSI config handling
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-7-8bd7e1add38a@linaro.org>
 <20230314000744.otbglr33ndizq5pc@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314000744.otbglr33ndizq5pc@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 01:07, Marijn Suijten wrote:
> On 2023-03-07 14:01:45, Konrad Dybcio wrote:
>> Now that the only user is handled by common code, remove the option to
>> specify custom handlers through match data.
>>
>> This is effectively a revert of commit:
>> 5ae15e76271 ("drm/msm/dsi: Allow to specify dsi config as pdata")
> 
> Would it also be worth to mention something along these lines in the
> previous patch, but for ee1f09678f14 ("drm/msm/dsi: Add support for
> qcm2290 dsi controller")?
50/50, it wouldn't hurt but it doesn't sound groundbreaking to skip it..

Konrad
> 
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
>> ---
>>  drivers/gpu/drm/msm/dsi/dsi.c      | 4 ++--
>>  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ----
>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
>> index 90d43628b22b..e0b911af618d 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
>> @@ -173,10 +173,10 @@ static int dsi_dev_remove(struct platform_device *pdev)
>>  }
>>  
>>  static const struct of_device_id dt_match[] = {
>> -	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
>> +	{ .compatible = "qcom,mdss-dsi-ctrl" },
>>  
>>  	/* Deprecated, don't use */
>> -	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
>> +	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290" },
>>  	{}
>>  };
>>  
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> index 9cfb9e91bfea..961689a255c4 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> @@ -214,10 +214,6 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
>>  	int ret;
>>  	u32 major = 0, minor = 0;
>>  
>> -	cfg_hnd = device_get_match_data(dev);
>> -	if (cfg_hnd)
>> -		return cfg_hnd;
>> -
>>  	ahb_clk = msm_clk_get(msm_host->pdev, "iface");
>>  	if (IS_ERR(ahb_clk)) {
>>  		pr_err("%s: cannot get interface clock\n", __func__);
>>
>> -- 
>> 2.39.2
>>
