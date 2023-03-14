Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF576B96BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCNNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjCNNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:47:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DA1BEA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:44:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r27so20064513lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678801449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmYDXc1m4ipXRhKVGpFbbcTg2x+quYyEc2SUvpi4ZtI=;
        b=V0gxCeN0uLEo7r2ZFnoxXs9uCSWWjH4cHQFIC4LOAbBQDPbX5XdqXPmLdPihUYECH1
         t1ZbUjxOoptLd9c4WxUL3hS755syjxtd9q2LO+Xi8OQe6ZXnkAd2FLr1dP0XAQRJ46Xd
         rMT0WCY57CUB/yko+paqEn6LJmwq+wHtgwnPHPjpiUokv+n0SbukMJv9DXtCP8tpldDD
         5v+/dO/Mvln9ahaANsudX+hE6OGLN2lD9rm9i+8aQL8hLwIJRZ0+h3g7QU3IcLjO/FC5
         i5m+Mc8fnLgE4azgp75Boq/aBoO/FfQHvvEaWCv9e/CTdq8BAf6Q+jELNsTBCoaRNUnS
         STxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678801449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmYDXc1m4ipXRhKVGpFbbcTg2x+quYyEc2SUvpi4ZtI=;
        b=Xxcs2Mj7I0jYeOvrw2HeEGkoVUYNvOhitnsBU7R3o+bnVhY5oMyI6E7qaZfc+q0c2v
         L7x667yVLxb55pbogfEnIkMpaUcxo9HGGNkHwqubtWiGv7MaVYCporE1NdNbdEl39tjN
         ECqVZoNH7HyKwywXwUSHj5Ng1qPBBm6sEX5w8OvY5uWwv2bp/jPHAivG1bQUnIEIHBee
         PkBgxX8fM6YBFYCA9qW1jgmOspPHB7dBYu4kXZ4bZEa7RDFIAJS6R/yFHDcO8paJQtt0
         FKW3OvXvVP0CpYSQsrEShGMVhdF9rf9kCiI2HyO0B6tsuaHjjlqE8IgrdAZH9jrJeb7i
         ixlg==
X-Gm-Message-State: AO0yUKXGlZwkBYGVdudWppwRmA2Vu83Ftn5L0PUbsiKpuqm1o9T2RaRi
        J1mn5ZYdUBdrynFXHXvLWXP4Ww==
X-Google-Smtp-Source: AK7set+NO6qaZeOqdzmcNO441RgYsVfp5nhWf8D6N1x6R7+Jj7PVVuYDxPH74EcVS5M7ls0+qtz6uA==
X-Received: by 2002:ac2:50c3:0:b0:4a4:68b7:deab with SMTP id h3-20020ac250c3000000b004a468b7deabmr813430lfm.7.1678801449609;
        Tue, 14 Mar 2023 06:44:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id z9-20020ac24189000000b004d5813386fdsm405637lfh.139.2023.03.14.06.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 06:44:09 -0700 (PDT)
Message-ID: <441030fa-afcb-8e5f-ea5a-f467d9d11937@linaro.org>
Date:   Tue, 14 Mar 2023 14:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 07/10] drm/msm/dsi: Remove custom DSI config handling
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
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
 <20230307-topic-dsi_qcm-v4-7-54b4898189cb@linaro.org>
 <20230314130522.wimbrf7d6lqwdbgz@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314130522.wimbrf7d6lqwdbgz@SoMainline.org>
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



On 14.03.2023 14:05, Marijn Suijten wrote:
> On 2023-03-14 13:13:45, Konrad Dybcio wrote:
>> Now that the only user is handled by common code, remove the option to
>> specify custom handlers through match data.
>>
>> This is effectively a revert of commit:
>> 5ae15e76271 ("drm/msm/dsi: Allow to specify dsi config as pdata")
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
>> index 8772a3631ac1..91bdaf50bb1a 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
>> @@ -65,8 +65,5 @@ struct msm_dsi_cfg_handler {
>>  
>>  const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor);
>>  
>> -/* Non autodetect configs */
>> -extern const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler;
>> -
> 
> Probably the wrong `fixup!` commit: this should have been part of patch
> 6 where the struct is removed, not patch 7 (this patch).
Yeah, that's most likely what happened.. Does that warrant another resend?

Konrad
> 
> - Marijn
> 
>>  #endif /* __MSM_DSI_CFG_H__ */
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
