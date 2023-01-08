Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115D5661A5A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjAHWIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjAHWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:08:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AD11054C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:08:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so10298171lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6ubnZnnnm86vU9G8oTF7iYXAATguR/oQ9JcuOI4Xb4=;
        b=E+xc4iTYp/PLYZ+e4TrolV7ng//esyyQjPKtR4jEnokZyBcEKoAi4zhZ9ruWeypdcl
         7g2TtMyAcFsoPSX+Yvf4+c12wYd48f8B5l3P2tWT5A+AXV3pHriSyQtcSy8T3YNNfAma
         sNu04ApNLGnoAenyCgLrAD/EErt4sdwH8HZatJ3ygihxgbkzt6zikf9GT6KGvin4RzdR
         9xDqgcDJheBp2i6j5rF5mqxOPfH+dUhEZpRsZpAAZtOU4NkH3m7Zj51MbXIcL32m0c9Y
         SvT63U5SHBwQ9/45cAU6bd8zdczxxoj5PwyUmru5Ft3yIZZmJNVybor8tN83+n44YgM5
         9OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6ubnZnnnm86vU9G8oTF7iYXAATguR/oQ9JcuOI4Xb4=;
        b=iwNp0jw8IjhZoFFA3KsEwAY8KD4VTE7sOcV9K2aDKX7zedcHFnACo+xeF2bF/WB0HR
         BbNGYG4YoLKbmnbHloJbekhnlRxml9iUwmHVlqEZIpTfM00MCqZO5923DVu0LbtYem9+
         +/WY3nmNQgYi8ZiFRAECKfM1qUALDGXjdJMvMq736TRx7M+2yu+p0nzM5wAfcDNdK9bB
         PGqYuN+AY1lHpRBjl2a+jFfu7as/mfxpJJ1JfSn8x9VllrvaQBTyKRSoELCOWDgcdDgY
         M/PUeKXuXm9nBiX2LOCIvGZcPt+FHGrojqI7QX8rBNq+cIWYw0G0+ijEacBbaaF9kJVq
         TXHA==
X-Gm-Message-State: AFqh2ko87VvPPB8SoYqa37p4rn93LpDUfjBW507r4ZJd/9Xv+/v0hkR9
        bc/x5zAzElZ2TQ4d+7anAJyCjQ==
X-Google-Smtp-Source: AMrXdXsBReaMbutTRcZt/O0SaBsRbQ2XZpqlgv3sWb32zgktzJf0Rsigi+BnZVpThocB45KaI7TkPQ==
X-Received: by 2002:a05:6512:308f:b0:4cb:1189:2862 with SMTP id z15-20020a056512308f00b004cb11892862mr13486061lfd.13.1673215689664;
        Sun, 08 Jan 2023 14:08:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b0049876c1bb24sm1264699lfr.225.2023.01.08.14.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 14:08:09 -0800 (PST)
Message-ID: <0b63ef49-7a59-0a72-503c-1de20a502c6a@linaro.org>
Date:   Mon, 9 Jan 2023 00:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm/dpu: Add check for cstate
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, quic_jesszhan@quicinc.com,
        ville.syrjala@linux.intel.com, yang.lee@linux.alibaba.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
 <e56c48c2-8439-c9c8-c735-95adece3c68d@linaro.org>
In-Reply-To: <e56c48c2-8439-c9c8-c735-95adece3c68d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2023 23:56, Dmitry Baryshkov wrote:
> On 06/12/2022 10:05, Jiasheng Jiang wrote:
>> As kzalloc may fail and return NULL pointer,
>> it should be better to check cstate
>> in order to avoid the NULL pointer dereference
>> in __drm_atomic_helper_crtc_reset.
>>
>> Fixes: 1cff7440a86e ("drm/msm: Convert to using 
>> __drm_atomic_helper_crtc_reset() for reset.")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> index 13ce321283ff..22c2787b7b38 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> @@ -968,7 +968,10 @@ static void dpu_crtc_reset(struct drm_crtc *crtc)
>>       if (crtc->state)
>>           dpu_crtc_destroy_state(crtc, crtc->state);
>> -    __drm_atomic_helper_crtc_reset(crtc, &cstate->base);
>> +    if (cstate)
>> +        __drm_atomic_helper_crtc_reset(crtc, &cstate->base);
>> +    else
>> +        __drm_atomic_helper_crtc_reset(crtc, NULL);
> 
> NAK.
> 
> The proper fix is to add the if() but to skip the else clause. We should 
> not reset the crtc's state if memory allocation failed.

On the other hand... Some of the drivers do exactly this ops.

With the message fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

