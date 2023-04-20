Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050DB6E9B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjDTSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjDTSBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:01:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D5435A7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:01:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4eca19c3430so741122e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682013665; x=1684605665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z71ifX+3bePpNj6BLLcg5VtBqXd9L7O317uWqrrJ0jY=;
        b=pE+i+7GJa5mGP7pN8Pn/lkXCkEzxDPET5cjPLpsKLHlB5SOlbsMB/KdJ2IzfMqoct1
         3KFZxKRhEhli0IYmucY4Q8zCh/1a/6DGntfRe0LET2s7QWjth1Bg+NpqtMDBXiBXOnUe
         cauvCYkY2ogSQL2IHhC9whcnIKmRbPeONT+b8S5FJQeKeQjd5iOsJh3fiGp9foZR+bF3
         /bGTiMol8JDDNJXT72B3BAWUB+2dy+aq7u7rwLeE8IaZc9W/hZgrUfVPL2/j9saUDW4I
         UDEdX1GkW7RTjlNqhKgklK0LleQ6PaOFO5FN8bL2flD4helzqVcRGVySbsIFdWn8PJ7a
         8HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682013665; x=1684605665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z71ifX+3bePpNj6BLLcg5VtBqXd9L7O317uWqrrJ0jY=;
        b=GnnjO9Y2QRMu5eJafr5INg3KLJiW2lIRkBm1Gt1XlOYpdT6W1jou0FJFf05YJpjfbi
         6ck029a5yF+77umb8dl1aUU79KzumcTDwxirpTkapRsl5VZOQhgT0p7GO7x8mQrKvLMt
         nP1f525n8dPAFTNh9Jd8YjbTLC719GZL8j27693EYKKleBjjnuUzMI1LleE/5Qb7gvPY
         8nK4nnzj1TH3g+IdBrt98xgUYX29asovO52BbwWZTLhLVvOYuLfn8r6DfngpufaZit2H
         2SdRzGl1iD7pPOyjMzXVuoAqFG07R3S8ZW/t0tbHfn+FPPC199EFIn6haIuk2swwl8Dv
         sNFw==
X-Gm-Message-State: AAQBX9cJByRGiey7gegCh84/jTbh8cXXiZvufWnzre1a7j4t84j840PT
        c1MYyvuXElE/t2Vs98BuWP6YMw==
X-Google-Smtp-Source: AKy350YhBge2kn5asPvQjIsoowiT2dTTKXXJSITeKrLIxWF5Sj2L/FGZ7oX9ry4+1WWCmJi5XWCL3w==
X-Received: by 2002:a05:6512:145:b0:4ed:c6d5:bdc with SMTP id m5-20020a056512014500b004edc6d50bdcmr738154lfo.24.1682013665093;
        Thu, 20 Apr 2023 11:01:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25a02000000b004b4cbc942a3sm290839lfn.127.2023.04.20.11.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:01:04 -0700 (PDT)
Message-ID: <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
Date:   Thu, 20 Apr 2023 21:01:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
 <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
 <3f3b3637-ed85-09a1-22b7-3ccd4bc929bb@quicinc.com>
 <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 04:36, Konrad Dybcio wrote:
> 
> 
> On 20.04.2023 03:28, Abhinav Kumar wrote:
>>
>>
>> On 4/19/2023 6:26 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 20.04.2023 03:25, Dmitry Baryshkov wrote:
>>>> On 20/04/2023 04:14, Konrad Dybcio wrote:
>>>>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
>>>>> dspp sub-block in addition to PCCv4. The other block differ a bit
>>>>> more, but none of them are supported upstream.
>>>>>
>>>>> This series adds configures the GCv1.8 on all the relevant SoCs.
>>>>
>>>> Does this mean that we will see gamma_lut support soon?
>>> No promises, my plate is not even full, it's beyond overflowing! :P
>>>
>>> Konrad
>>
>> So I think I wrote about this before during the catalog rework/fixes that the gc registers are not written to / programmed.
>>
>> If thats not done, is there any benefit to this series?
> Completeness and preparation for the code itself, if nothing else?

The usual problem is that if something is not put to use, it quickly 
rots or becomes misused for newer platforms. We have seen this with the 
some of DPU features.

In case of GC (and the freshly defined DPU_DSPP_IGC, but not used) we 
have three options:
- drop the unused GC from msm8998_sblk.
- keep things as is, single unused GC entry
- fill all the sblk with the correct information in hope that it stays 
correct

Each of these options has its own drawbacks. I have slight bias towards 
the last option, to have the information in place (as long as it is 
accurate).

-- 
With best wishes
Dmitry

