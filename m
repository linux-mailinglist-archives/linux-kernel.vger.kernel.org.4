Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C966E3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjAQQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjAQQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:40:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FA43464
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so45911071ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1bbrLy++qcWOt6lSo1aW2xXQtthkN26YgghLI/c6PY=;
        b=YZWptJC2T2Lt68fnk5iaS35Tt5NiBfTpWDPvoZ6YNp63K3/OpJqlWyZT9j6KW7jL+Y
         R2u99ksNtXzgJJfcKEb8tk3Q8XTu5JPV0ZoB94hofer3jjhOTHZ0EQ7Y4zl+fVQBhgbf
         xoOe2dgoLRZqgJXMrHtynQZnr5g5DUqAbnBZ6C5nVp8CrRvqEB/uaaQ+Yy3Xiq+BPQ7p
         uzJvop6v4S2b68/OrliCjG4bx0NwzotqRxAXtx0gq5sUPvGmuj/JcowQw1cRn8O8Ohvl
         cnRY58wyvX5NuCJe9A8wnxrZ+nWebym9vLkLEHPjNihs+RJJJZtYNngEeNbuCcaNCHMt
         mjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1bbrLy++qcWOt6lSo1aW2xXQtthkN26YgghLI/c6PY=;
        b=z+mYa7wnwWoO5q0BEYFSxzY71H0N/DoYDIt7mXyZ5VVZM0Af98tjKjUcRa/QBwwpkA
         tJuGqc1MDPVuhr6nku2MvEMYMZeyR/f6ECArLLxwiy1kf/FyfvGb/9DeQd6gwxhizABb
         J1AtljBGdeB99OwWUKbUg2XtbCcMbfcMSud/WR00sOKHkkkLBfkYLYnbzQ5bOhlaiHW2
         xA8HrJaSm00ReAAE5Esdt+dcKrPGoSPYyNLOOI43XEO9+dAZ1nCJx4Knp1rDh4XmGK0M
         IYJepGyuCGsIM2C8VtMVP91fPpG3FN9a1IG5Eve7fNDbO3lJGJYdEoTV1RJB3nlPqeVi
         euYQ==
X-Gm-Message-State: AFqh2koMUz/h9erUOtaT1xXqSk2egb3uq7I4Rk9D3yEDInfj+JXBfAzQ
        7ruXpurhipwuJGO/9vZRn6qzdlrROxhuC7N4
X-Google-Smtp-Source: AMrXdXvx8GfSw4jqnYWyRNx+AEyQ5TPSGpqwX8eUMCgA3tmTmVxZPkFx+gDCWDdS4uOV+AcLTLvMPw==
X-Received: by 2002:a05:6402:2b92:b0:45a:7d2:9b35 with SMTP id fj18-20020a0564022b9200b0045a07d29b35mr3870633edb.0.1673973612880;
        Tue, 17 Jan 2023 08:40:12 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0049be07c9ff5sm5820820edb.4.2023.01.17.08.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:40:12 -0800 (PST)
Message-ID: <84849b99-93ab-bc10-39ff-ac46328ede47@linaro.org>
Date:   Tue, 17 Jan 2023 18:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] drm/msm/disp/dpu1: allow reservation even if dspps
 are not available.
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1673972488-30140-1-git-send-email-quic_kalyant@quicinc.com>
 <1673972488-30140-2-git-send-email-quic_kalyant@quicinc.com>
 <0a845c24-b1a5-a961-103f-0d8840a8f17d@linaro.org>
In-Reply-To: <0a845c24-b1a5-a961-103f-0d8840a8f17d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 18:35, Dmitry Baryshkov wrote:
> On 17/01/2023 18:21, Kalyan Thota wrote:
>> if any topology requests for dspps and catalogue doesn't have the
>> allocation, avoid failing the reservation.
>>
>> This can pave way to build logic allowing composer fallbacks
>> for all the color features that are handled in dspp.
>>
>> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>> index 73b3442..c8899ae 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>> @@ -343,7 +343,13 @@ static bool 
>> _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
>>           return true;
>>       idx = lm_cfg->dspp - DSPP_0;
>> -    if (idx < 0 || idx >= ARRAY_SIZE(rm->dspp_blks)) {
>> +
>> +    if (idx < 0) {
> 
> The change doesn't correspond to commit message.
> 
>> +        DPU_DEBUG("lm doesn't have dspp, ignoring the request %d\n", 
>> lm_cfg->dspp);
>> +        return true;
>> +    }
>> +
>> +    if (idx >= ARRAY_SIZE(rm->dspp_blks)) {
>>           DPU_ERROR("failed to get dspp on lm %d\n", lm_cfg->dspp);
>>           return false;
>>       }
> 
> If you'd like to remove duplicate for the (idx >= ARRAY_SIZE) check, I'd 
> suggest dropping the second one
> 

I've misread the patch. However I don't see, why would one request 
DSPP_NONE while specifying topology->num_dspp. I think that you are 
trying to put additional logic into a function that should just check 
for the available resources.

-- 
With best wishes
Dmitry

