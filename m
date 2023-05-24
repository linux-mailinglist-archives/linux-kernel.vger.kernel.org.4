Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7476070F028
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjEXIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbjEXIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:06:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BD18C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:06:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so535626e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684915565; x=1687507565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2di5F/Fsbly9FAD3Arcq2hIOC6OgudTqnppopyN/4nE=;
        b=RSELJiQWTCvR5j8lZExyFCzoraNky4ZAabOHgGlH7yl/0Quby/lt2SDe6fTx3XbWAj
         0XWa/vf1m8zEvRtZMM6rAZl2rRfVrXpvpynlU3epuM9Rs74RN5+L4X2pQT2jQD2CEo+G
         4HLLTRWH4qDXGZoB9uRcOt7OVaTpTG2ilLXAY7SoNpVdiK6ilWc0uPg0mrD+NXT9P66S
         T9A6JhgwUdZRbQi/fz9keYqnWpHWf//oOKVSeeKc+wHMRjUnD8taHhKov93BzWxjiW02
         jYS0rmR920K+h2BVdf0nrgoicMfE+eSbL5IQDE+9g/bCyJzrwH0e4p5eQpm5b1jRQw1w
         cKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684915565; x=1687507565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2di5F/Fsbly9FAD3Arcq2hIOC6OgudTqnppopyN/4nE=;
        b=Kc22ODS5lQbF9DHR1TayI9ZUR+iG/DjN1f1IcTizQFUmb3AEe1sanncL6AyfT7ET0v
         0ATn9bjtJvGp4jbKW5MTlfoK3rUwyL1FMVEn8JASZSsWqpKngRrKHk1lEZRAgBEXO4fB
         IzLbMIAFsEPA3aDHQkWlPei9Vc368jiZLjBvckcM0BzmpuZ0t8TCzF/u3sAHZ21LxrpW
         ZLPF1UPJTsmU9MCy+vLIhIqO9goQ0lY5PIsYGT0/Ix2haFfGVF/eHy94d1q+b2j8oRwH
         V5mPDnCQsKuGvJ2zoj9+QPweBSRxNgNtWVDZg7L6y3eG9jVf5NTPQrBmuuxSNup9tb65
         kXnA==
X-Gm-Message-State: AC+VfDxYDkYVHVgfqeRkcN4mlZmCXhT5qla2H3xiAp4Vy37Q1lIJEMYO
        tkBgUSuRXFUZDwxIYenTsPnHVEX8DDgQgNGQIWw=
X-Google-Smtp-Source: ACHHUZ6kVNyrtxkIjgkKymdHMZFb01K61ZNMGKdJOPA3oiVKK8AHjyd/9kt+dgwnEGIzjiA1+U7fLQ==
X-Received: by 2002:ac2:4c9a:0:b0:4f1:4602:fb63 with SMTP id d26-20020ac24c9a000000b004f14602fb63mr5205614lfl.41.1684915565311;
        Wed, 24 May 2023 01:06:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 19-20020ac24853000000b004f3b4d17114sm1647259lfy.144.2023.05.24.01.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:06:04 -0700 (PDT)
Message-ID: <4f2556e2-52ab-eb1d-b388-52546044f460@linaro.org>
Date:   Wed, 24 May 2023 11:06:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/msm/dp: add module parameter for PSR
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        swboyd@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230427232848.5200-1-quic_abhinavk@quicinc.com>
 <053819bd-b3c4-a72c-9316-85d974082ad6@linaro.org>
 <ZGzalLjTvUfzEADU@hovoldconsulting.com>
 <f530691b-989d-b059-6b06-e66abb740bdb@quicinc.com>
 <ZG216qoxK9hQ-kQs@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZG216qoxK9hQ-kQs@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 09:59, Johan Hovold wrote:
> On Tue, May 23, 2023 at 12:23:04PM -0700, Abhinav Kumar wrote:
>> On 5/23/2023 8:24 AM, Johan Hovold wrote:
>>> On Fri, May 12, 2023 at 09:13:04PM +0300, Dmitry Baryshkov wrote:
>>>> On 28/04/2023 02:28, Abhinav Kumar wrote:
>>>>> On sc7280 where eDP is the primary display, PSR is causing
>>>>> IGT breakage even for basic test cases like kms_atomic and
>>>>> kms_atomic_transition. Most often the issue starts with below
>>>>> stack so providing that as reference
>>>>>
>>>>> Call trace:
> 
>>>>> ---[ end trace 0000000000000000 ]---
>>>>> [drm-dp] dp_ctrl_push_idle: PUSH_IDLE pattern timedout
>>>>>
>>>>> Other basic use-cases still seem to work fine hence add a
>>>>> a module parameter to allow toggling psr enable/disable till
>>>>> PSR related issues are hashed out with IGT.
>>>>
>>>> For the reference: Bjorn reported that he has issues with VT on a
>>>> PSR-enabled laptops. This patch fixes the issue for him
>>>
>>> Module parameters are almost never warranted, and it is definitely not
>>> the right way to handle a broken implementation.
>>>
>>> I've just sent a revert that unconditionally disables PSR support until
>>> the implementation has been fixed:
>>>
>>> 	https://lore.kernel.org/lkml/20230523151646.28366-1-johan+linaro@kernel.org/
>>
>> I dont completely agree with this. Even the virtual terminal case was
>> reported to be fixed by one user but not the other. So it was probably
>> something missed out either in validation or reproduction steps of the
>> user who reported it to be fixed OR the user who reported it not fixed.
>> That needs to be investigated now.
> 
> Yes, there may still be some time left to fix it, but it's pretty damn
> annoying to find that an issue reported two months ago still is not
> fixed at 6.4-rc3. (I even waited to make the switch to 6.4 so that I
> would not have to spend time on this.)
> 
> I didn't see any mail from Bjorn saying that the series that claimed to
> fix the VT issue actually did fix the VT issue. There's only the comment
> above from Dmitry suggesting that disabling this feature is the only way
> to get a working terminal back.

Originally this issue was reported by Doug, and at [1] he reported that 
an issue is fixed for him. So, for me it looks like we have hardware 
where VT works and hardware where it doesn't.

Doug, can you please confirm whether you can reproduce the PSR+VT issue 
on 6.4-rc (without extra patches) or if the issue is fixed for you?

[1] 
https://lore.kernel.org/dri-devel/CAD=FV=VSHmQPtsQfWjviEZeErms-VEOTmfozejASUC9zsMjAbA@mail.gmail.com/

> 
> Regressions happen and sometimes there are corner cases that are harder
> to find, but this is a breakage of a fundamental feature that was
> reported before the code was even merged into mainline.
> 
>> We should have ideally gone with the modparam with the feature patches
>> itself knowing that it gets enabled for all sinks if PSR is supported.
> 
> Modparams are things of the past should not be used to enable broken
> features so that some vendor can tick of their internal lists of
> features that have been "mainlined".

We have had a history of using modparam with i915 and IIRC amdgpu / 
radeon drivers to allow users to easily check whether new feature works 
for their hardware. My current understanding is that PSR+VT works for on 
some laptops and doesn't on some other laptops, which makes it a valid case.

> 
> You can carry that single patch out-of-tree to enable this if you need
> it for some particular use case where you don't care about VTs.
> 
> But hopefully you can just get this sorted quickly. If not, the revert I
> posted is the way to go rather than adding random module parameters.
> 
> Johan

-- 
With best wishes
Dmitry

