Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFB74DD21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGJSNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGJSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:13:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5F128
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:13:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69923a715so74640931fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689012806; x=1691604806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4L/6cXI/F66uyhWJ7oKCzwl/SwVaVVcfFFQRz36p5w=;
        b=noPDubIdDfSH4R1TDP1/B5TYjS16T9ItZ8CsobJV9xgTSLJhvQIMlZTqrhNAXbFr77
         W3C/UB9ZzKc/nvBEnrN3knUDPN97IVfecGyIWmbki/CLbPvWv27NHXzSqbLrZRXzHzQ9
         9nGp9X24lubQ56grVTW3GZ0nzNtWFAak6OGPs/ndrqzNVFOvvCmTlOk1xKDzwIsY1vUW
         u5H0/48R0BRP0rp62RovMaqr0pEvyDpEhLxUMpEFeMxGStJIDX26kTvdzHgXD+zeabIe
         zvjJqx6or8MQ1mjgNnZpjmlV0yWfEAAqwWr6PL88lZZer1d+PP4GfZQw2zZ56qUbM7U+
         lBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012806; x=1691604806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4L/6cXI/F66uyhWJ7oKCzwl/SwVaVVcfFFQRz36p5w=;
        b=DrZxd74a/DHVWjdhlPHKTFmdVHAjO4XONM1kVymSkofzWwFuLTcPzX61RiTdgc2F58
         Ot5Moy8dlAm6vhxWdnBrC8zGaoUz6C5C5JXr7Bv5+g8SvsQ2Ho7gIryOIKEf6qWoKShP
         +SFsbKtUB4VE5nsdv/RfeIPtw/B/LKX7Lu+vuL1ponci25agYAV68yl+a71PBWfB3htJ
         4kE+o6S/P2THQ/cxoJ/tJGK0axdHoRGHu6xbd+BniIWPk6iMCs5xJxRwOefJ56N6HPp+
         mKj+q7cq34ZX1yBA7Uz97Mc48Y6SuM/yrMmlilObNCzJZPOyAr181klAGpvKqgZgdhqM
         6vUw==
X-Gm-Message-State: ABy/qLYqjmkQaprkxziCt64IqbKolQJNtQDej14d6at3zm3udFUllUwd
        PjEICCTZNvLnyBod6Di8P6PX7w==
X-Google-Smtp-Source: APBJJlEQTkxpXEh7MaLgaA11TtqxwAlcT5KM2HuOPNE2NM+KxLvWGSBoUAhhvAcxRH9SdrNX75+7Hw==
X-Received: by 2002:a2e:9f07:0:b0:2b7:25b2:e37a with SMTP id u7-20020a2e9f07000000b002b725b2e37amr919668ljk.44.1689012805966;
        Mon, 10 Jul 2023 11:13:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j10-20020a2eb70a000000b002b6ad323248sm84978ljo.10.2023.07.10.11.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 11:13:25 -0700 (PDT)
Message-ID: <3fa812d6-9222-065a-8b40-95c2f2c808a6@linaro.org>
Date:   Mon, 10 Jul 2023 21:13:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 4/5] drm/msm/dp: move relevant dp initialization code
 from bind() to probe()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-5-git-send-email-quic_khsieh@quicinc.com>
 <121f82ad-9d5d-6d7f-b4ae-9a371ab49ef7@linaro.org>
 <9df52052-93fd-75a4-b54c-02ed9554e15f@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <9df52052-93fd-75a4-b54c-02ed9554e15f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 19:57, Kuogee Hsieh wrote:
> 
> On 7/7/2023 5:11 PM, Dmitry Baryshkov wrote:
>> On 08/07/2023 02:52, Kuogee Hsieh wrote:
>>> In preparation of moving edp of_dp_aux_populate_bus() to
>>> dp_display_probe(), move dp_display_request_irq(),
>>> dp->parser->parse() and dp_power_client_init() to dp_display_probe()
>>> too.
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_display.c | 48 
>>> +++++++++++++++++--------------------
>>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 -
>>>   2 files changed, 22 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c 
>>> b/drivers/gpu/drm/msm/dp/dp_display.c
>>> index 44580c2..185f1eb 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>> @@ -290,12 +290,6 @@ static int dp_display_bind(struct device *dev, 
>>> struct device *master,
>>>           goto end;
>>>       }
>>>   -    rc = dp_power_client_init(dp->power);
>>> -    if (rc) {
>>> -        DRM_ERROR("Power client create failed\n");
>>> -        goto end;
>>> -    }
>>> -
>>>       rc = dp_register_audio_driver(dev, dp->audio);
>>>       if (rc) {
>>>           DRM_ERROR("Audio registration Dp failed\n");
>>> @@ -752,6 +746,12 @@ static int dp_init_sub_modules(struct 
>>> dp_display_private *dp)
>>>           goto error;
>>>       }
>>>   +    rc = dp->parser->parse(dp->parser);
>>> +    if (rc) {
>>> +        DRM_ERROR("device tree parsing failed\n");
>>> +        goto error;
>>> +    }
>>> +
>>>       dp->catalog = dp_catalog_get(dev, &dp->parser->io);
>>>       if (IS_ERR(dp->catalog)) {
>>>           rc = PTR_ERR(dp->catalog);
>>> @@ -768,6 +768,12 @@ static int dp_init_sub_modules(struct 
>>> dp_display_private *dp)
>>>           goto error;
>>>       }
>>>   +    rc = dp_power_client_init(dp->power);
>>> +    if (rc) {
>>> +        DRM_ERROR("Power client create failed\n");
>>> +        goto error;
>>> +    }
>>> +
>>>       dp->aux = dp_aux_get(dev, dp->catalog, dp->dp_display.is_edp);
>>>       if (IS_ERR(dp->aux)) {
>>>           rc = PTR_ERR(dp->aux);
>>> @@ -1196,26 +1202,20 @@ static irqreturn_t dp_display_irq_handler(int 
>>> irq, void *dev_id)
>>>       return ret;
>>>   }
>>>   -int dp_display_request_irq(struct msm_dp *dp_display)
>>> +static int dp_display_request_irq(struct dp_display_private *dp)
>>>   {
>>>       int rc = 0;
>>> -    struct dp_display_private *dp;
>>> -
>>> -    if (!dp_display) {
>>> -        DRM_ERROR("invalid input\n");
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    dp = container_of(dp_display, struct dp_display_private, 
>>> dp_display);
>>> +    struct device *dev = &dp->pdev->dev;
>>>   -    dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
>>>       if (!dp->irq) {
>>> -        DRM_ERROR("failed to get irq\n");
>>> -        return -EINVAL;
>>> +        dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
>>> +        if (!dp->irq) {
>>> +            DRM_ERROR("failed to get irq\n");
>>> +            return -EINVAL;
>>> +        }
>>>       }
>>
>> Use platform_get_irq() from probe() function.
>>
>>>   -    rc = devm_request_irq(dp_display->drm_dev->dev, dp->irq,
>>> -            dp_display_irq_handler,
>>> +    rc = devm_request_irq(dev, dp->irq, dp_display_irq_handler,
>>>               IRQF_TRIGGER_HIGH, "dp_display_isr", dp);
>>
>>
>>>       if (rc < 0) {
>>>           DRM_ERROR("failed to request IRQ%u: %d\n",
>>> @@ -1290,6 +1290,8 @@ static int dp_display_probe(struct 
>>> platform_device *pdev)
>>>         platform_set_drvdata(pdev, &dp->dp_display);
>>>   +    dp_display_request_irq(dp);
>>> +
>>
>> Error checking?
>> Are we completely ready to handle interrupts at this point?
> not until dp_display_host_init() is called which will be called from 
> pm_runtime_resume() later.

But once you request_irq(), you should be ready for the IRQs to be 
delivered right away.

>>
>>>       rc = component_add(&pdev->dev, &dp_display_comp_ops);
>>>       if (rc) {
>>>           DRM_ERROR("component add failed, rc=%d\n", rc);
>>> @@ -1574,12 +1576,6 @@ int msm_dp_modeset_init(struct msm_dp 
>>> *dp_display, struct drm_device *dev,
>>>         dp_priv = container_of(dp_display, struct dp_display_private, 
>>> dp_display);
>>>   -    ret = dp_display_request_irq(dp_display);
>>> -    if (ret) {
>>> -        DRM_ERROR("request_irq failed, ret=%d\n", ret);
>>> -        return ret;
>>> -    }
>>> -
>>>       ret = dp_display_get_next_bridge(dp_display);
>>>       if (ret)
>>>           return ret;
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h 
>>> b/drivers/gpu/drm/msm/dp/dp_display.h
>>> index 1e9415a..b3c08de 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>>> @@ -35,7 +35,6 @@ struct msm_dp {
>>>   int dp_display_set_plugged_cb(struct msm_dp *dp_display,
>>>           hdmi_codec_plugged_cb fn, struct device *codec_dev);
>>>   int dp_display_get_modes(struct msm_dp *dp_display);
>>> -int dp_display_request_irq(struct msm_dp *dp_display);
>>>   bool dp_display_check_video_test(struct msm_dp *dp_display);
>>>   int dp_display_get_test_bpp(struct msm_dp *dp_display);
>>>   void dp_display_signal_audio_start(struct msm_dp *dp_display);
>>

-- 
With best wishes
Dmitry

