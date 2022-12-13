Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9264BD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiLMTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiLMTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:22:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4F3220
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:22:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so6631131lfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DONLyeUBEvtFdZRbXVpwOfCfRvSLKPBvM/+r4HRnRgM=;
        b=v8HDutxzGC6RaReRlTrmxmKgJIXCXC/oVRaM+uT54YvOYonHAt11Imn8wYHFcsPdIA
         VTvzL63p24fwRyy5Oq+BLykG4DNtF8ZTk3vunsvadKucc+oi4M2mCO5LB/q/HB3EJLuq
         9w6/RCXNPuv89MVQt/29SfEADwScw+/rKxtuxIG07rcxilpaTNLDAwAtCwkBM6TUDlO6
         z7u8Vp25g//j80hAAKHktNQOsPCqdTR29gnEyDAhK9upNq14dkd6xBWpuSrE/7pZ0VM8
         j9LU6R/JvQJADgUuQ+pMBAXrdj1k5vDpD6Rox8bqkqtOSdC5YG4peOiyZF/GjIkjUuPR
         dQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DONLyeUBEvtFdZRbXVpwOfCfRvSLKPBvM/+r4HRnRgM=;
        b=svlvdUxVDcEUPQWek3nMFc/BAhXtZTRA93/Z9iqERL3dp87E/XCZj8Sd9gkpRUDiOm
         OZC8PPQfAMRD6E6UPAzlQGjMaZ8ZmM9nWy6QLDzjtncHK7LjgzvxH16wklOUlbdMIJip
         /AAr0xRk6+awbAaIVnG/Ja+i46m+v+cvFHjkYShdfF+VT06WwBC+tOVps1cnzC+4Qn+S
         OTY/+/H8/cXR4bj33W54mIhk+E0Swn0Qm08MrIkBGU/vd0IElAXxLtpznmLWBgLxSwYH
         oBHQy5Csp7Fmf7GNlYW7n5FvKVsr0k/MnIit9Yp43M2LakR46ovOhl8Lp9l+VNQSafIu
         2V1w==
X-Gm-Message-State: ANoB5pkzfza95jJqTl+Sss29PiLlHSiQQqppEgOFr+yKZpo9rrq8KsXv
        2Vu72ZORifhUK2zmIxr910qWkQ==
X-Google-Smtp-Source: AA0mqf5uSyuiT5WBiKktCwmsC2x5fCZrowPoOImGCXw/yGr/q+6Uhi76/7oI59/c4EmGR3i7siSRDQ==
X-Received: by 2002:a05:6512:23a9:b0:4b6:e775:ebb7 with SMTP id c41-20020a05651223a900b004b6e775ebb7mr4041100lfv.12.1670959352767;
        Tue, 13 Dec 2022 11:22:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j20-20020ac24554000000b004b1892aa5c8sm482465lfm.56.2022.12.13.11.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 11:22:32 -0800 (PST)
Message-ID: <b673eae4-03ab-0a87-32c3-49e35e8759a8@linaro.org>
Date:   Tue, 13 Dec 2022 20:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [Freedreno] [PATCH v11 2/5] dt-bindings: msm/dp: add data-lanes
 and link-frequencies property
Content-Language: en-US
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     devicetree@vger.kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        airlied@gmail.com, andersson@kernel.org,
        konrad.dybcio@somainline.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        robh+dt@kernel.org, vkoul@kernel.org, agross@kernel.org,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sean@poorly.run, linux-kernel@vger.kernel.org
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
 <5a3865ed-8847-db04-3d60-f35438250bef@linaro.org>
 <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com>
 <be1411e8-1d07-7643-977c-a306016fd660@linaro.org>
 <b6d90c1f-5365-7197-be63-96c3d8cf0746@quicinc.com>
 <e53844b7-601b-f355-302b-cc871962a446@linaro.org>
 <8b306c8f-3089-4aaf-7fc1-038a8330c89a@quicinc.com>
 <CAA8EJpr5RYyQa7xu1_xJ0F-dn-H9aOf0KE-CDgDCwnZu3HPgXg@mail.gmail.com>
 <a9e2f269-b9df-814f-adcd-f5577f590fa7@quicinc.com>
 <bca77270-f3ac-f23f-ef96-43f9f7d574c4@linaro.org>
 <0c131d43-1e91-8b92-5517-ca8fffef238c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0c131d43-1e91-8b92-5517-ca8fffef238c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 18:31, Abhinav Kumar wrote:
> 
> 
> On 12/13/2022 5:13 AM, Krzysztof Kozlowski wrote:
>> On 13/12/2022 00:41, Abhinav Kumar wrote:
>>>>>
>>>>> besides, i think i have to sent the whole series patches include this
>>>>> one to address your new comments on other patch.
>>>>>
>>>>> is this correct?
>>>>
>>>> No. Please fix your system first, validate your patches and send them
>>>> afterwards. You can not expect others to do your job.
>>>>
>>>
>>> Just finished working with kuogee on this. This issue had been reported
>>> by few others earlier (example
>>> https://lore.kernel.org/lkml/bc9be279-a130-d5e7-4397-bbb389d14403@intel.com/T/).
>>
>> This report says:
>> "Sorry for the inconvenience, please ignore this false positive."
>>
> 
> That was one of them, and I dont think its false, maybe because after 
> fixing the PATH issues, the user deemed them as false.
> 
> Here is another one 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210812174209.1970-3-bbudiredla@marvell.com/ 
> with the same report but no resolution.

Thanks. Could be also Python mismatch. `make dt_binding_check` could use
dtschema from Python2 but the reporter used Python3 for checking the
version: `pip3 show dtschema`

> 
> So i thought for the benefit of others I would atleast summarize how we 
> resolved them.

Sure, that's helpful.


Best regards,
Krzysztof

