Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91F074DD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGJSP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGJSPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:15:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EED12E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:15:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so61561131fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689012917; x=1691604917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLZ34OPni3Wb11pi8Qg03ECcQSNGfoxA5NTOQgO19hQ=;
        b=Dpe5ss5mB58PPKBTTW895kxDoVtmMqx988GMUWU1zuvtQ8fUMRdwge/GQdQxTrnXgp
         +t5NEIAdDH0oaGelCTjrAp4LG/mzoy3YHrEs+s3Om7KmT1CBPb0iRDBgPo0pvCehYWze
         XDIIy6HbuzsUHn80yc7zBLJaswJ/O4oNJFViWoIJybQJ/GaRTfzZ/Br7x4T0WVh1qfLr
         nd/QWxtSg/Js9NJhqEoeK87LxG4GC4Eo5iD24jbQA/UPSPxD6FySgOarILv1Frfxx15l
         0PS4ONBQEKVWAMWAR8DrnTn7aE5orVOc4QL1n3R/pP3vURLaSJsgilXy96ds4PRACD4B
         PY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012917; x=1691604917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLZ34OPni3Wb11pi8Qg03ECcQSNGfoxA5NTOQgO19hQ=;
        b=N0S62xdywL3TkWPK7bUf0ZE4Misr82ONV7mxWqQHlObaBKWnybrhehuAwsAvuFLRpP
         62H6Xc9fGjV/SqGTeyJvpBLkT/cVmA8m1XnG7xrHTVBwuNrfycgZWzAOY+AhVYz6pocS
         R6Jjts0z/0VrLhmFw5OOfcHgp+sey1xsvQht2XqF3o60BhbqzDHxfJz8CERqB1pZWpM8
         BJxfprHJGvOyqiAxaFs+FzKDxX9Dw2SG8a9zvTRL8vVGoGB9IXvYAwDaK7Yh6MbtkR4R
         v1k9qwdo1p961X/tBmjaA4bCGnrf1X6H4WHF3zSAtrA6gP+xhLtDbXr7IbaYwwQsO52+
         G5Ew==
X-Gm-Message-State: ABy/qLaPIlxWZwULo1v15fAdJTL3DnASVF74nlTtxS2+wx14SAGezEiQ
        8Bntadbf7J3DyJ79tloaG+P88g==
X-Google-Smtp-Source: APBJJlE5fKuaEMgO2n/ZJOqQpr8b/TTCOx37vIHH5DimqJlxKxMgkSWql8+/7zXs+qnHQWkRAUSCqw==
X-Received: by 2002:a2e:9455:0:b0:2b7:29b:d5a5 with SMTP id o21-20020a2e9455000000b002b7029bd5a5mr10499077ljh.34.1689012917454;
        Mon, 10 Jul 2023 11:15:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id z12-20020a2e964c000000b002b719138b7esm81047ljh.114.2023.07.10.11.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 11:15:17 -0700 (PDT)
Message-ID: <bd16c829-183c-9898-8890-e94c6039f4d9@linaro.org>
Date:   Mon, 10 Jul 2023 21:15:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/5] drm/msm/dp: delete EV_HPD_INIT_SETUP
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
 <1688773943-3887-4-git-send-email-quic_khsieh@quicinc.com>
 <b70e6e98-e5a8-71d7-891a-889c268a7e06@linaro.org>
 <c1a6f23d-17d9-6f4b-407a-142913e88a35@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c1a6f23d-17d9-6f4b-407a-142913e88a35@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 19:52, Kuogee Hsieh wrote:
> 
> On 7/7/2023 5:34 PM, Dmitry Baryshkov wrote:
>> On 08/07/2023 02:52, Kuogee Hsieh wrote:
>>> EV_HPD_INIT_SETUP flag is used to trigger the initialization of external
>>> DP host controller. Since external DP host controller initialization had
>>> been incorporated into pm_runtime_resume(), this flag become obsolete.
>>> Lets get rid of it.
>>
>> And another question. Between patches #2 and #3 we have both 
>> INIT_SETUP event and the PM doing dp_display_host_init(). Will it work 
>> correctly?
> 
> yes,  i had added  if (!dp->core_initialized)  into dp_display_host_init().
> 
> should I merge this patch into patch #2?

You can remove a call to dp_display_host_init() in patch #2 and then 
drop EV_HOST_INIT / msm_dp_irq_postinstall() here.

> 
>>
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_display.c | 12 ------------
>>>   1 file changed, 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c 
>>> b/drivers/gpu/drm/msm/dp/dp_display.c
>>> index 2c5706a..44580c2 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>> @@ -55,7 +55,6 @@ enum {
>>>   enum {
>>>       EV_NO_EVENT,
>>>       /* hpd events */
>>> -    EV_HPD_INIT_SETUP,
>>>       EV_HPD_PLUG_INT,
>>>       EV_IRQ_HPD_INT,
>>>       EV_HPD_UNPLUG_INT,
>>> @@ -1119,9 +1118,6 @@ static int hpd_event_thread(void *data)
>>>           spin_unlock_irqrestore(&dp_priv->event_lock, flag);
>>>             switch (todo->event_id) {
>>> -        case EV_HPD_INIT_SETUP:
>>> -            dp_display_host_init(dp_priv);
>>> -            break;
>>>           case EV_HPD_PLUG_INT:
>>>               dp_hpd_plug_handle(dp_priv, todo->data);
>>>               break;
>>> @@ -1483,15 +1479,7 @@ void __exit msm_dp_unregister(void)
>>>     void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>>>   {
>>> -    struct dp_display_private *dp;
>>> -
>>> -    if (!dp_display)
>>> -        return;
>>> -
>>> -    dp = container_of(dp_display, struct dp_display_private, 
>>> dp_display);
>>>   -    if (!dp_display->is_edp)
>>> -        dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
>>>   }
>>>     bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
>>

-- 
With best wishes
Dmitry

