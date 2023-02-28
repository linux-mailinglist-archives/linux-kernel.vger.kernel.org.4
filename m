Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716F6A5C16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjB1PhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjB1PhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:37:18 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77C2A9AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:37:15 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h3so10683603lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmZThYj/LApm7g8E3Vb/uN+vkTQ915AMf1R2olPZ3NU=;
        b=ElrpRhI3WQ3X5hsHrwaar/fvHU6EmGpxSEUDJK57GQ/39+NUkwXWShyocCIsQRKcIg
         pbEJVkzhuWjSlfgnaEtAi57MM3iF4cVm2SmGDERNDxIQ7Dbj9+4OOGH18kWC6t7zP5FR
         aH1L8CmT0CVfi37dAI0TCjmnp9R2RR1Z2IZLjG51iV53rr/Nslk+EoA+AJ5mS4FQKh4A
         Z0Ojih9GGDIKxFtBQ3PWfiGwTP1s4mpmlpI2PTV+jb3loe6IeCeMh4cwLNQNG85eSVlh
         qdNq5I1kt7EDOXbuMQtzfu0CAoOQRyBQcdDK6iPlZanYUfbwD8c3MWNQkd9ghOa0fhtg
         Xd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmZThYj/LApm7g8E3Vb/uN+vkTQ915AMf1R2olPZ3NU=;
        b=fq/RkrVEVx536502SZnStVURc1dlpRHhoVi1AbK7zKeKalVtnozT2wS2gYDxKJfB14
         e0i3NKZbwjOkpYiy54CoCkdE5du5SOuO6L3QgkjmXfwHD09Ut30QbPPLqj20oGgdAnNx
         9uGs9WVDTGgDsyqguJS82XTiZ0kuzrK6+QPgUsbhZxc2EmuBJqS9skCBJGUn3GhpoET2
         9C08wWXYB5ovL1DxsEfsiui9nk6mfUbRXo/VWsowB5D+9TBJ8lYaJntMKfNzVZdjYdun
         9g4m1wJa7SSFPxkbqgxXHdQGGloSHeGuLdasZvDgU87NSf0k42L/I+czdfIG882izuD+
         Q/XA==
X-Gm-Message-State: AO0yUKW1Ml1u+YK3E3PxRNWunlr8EangkEm0ot/vBOwHMSj8F+TwTEQE
        D2ImsgyBkXrTKxDKtgmBfBhk1Q==
X-Google-Smtp-Source: AK7set8OR7nGA538ny3cM3lrTAmK0UyJgkUspqLu+Y4G4AHnYMu9ODpfNIvu2SNyqODgJf5yS33kBQ==
X-Received: by 2002:a05:651c:383:b0:295:9829:47b0 with SMTP id e3-20020a05651c038300b00295982947b0mr802542ljp.49.1677598634002;
        Tue, 28 Feb 2023 07:37:14 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u5-20020a05651c130500b002959f550084sm1213885lja.100.2023.02.28.07.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:37:13 -0800 (PST)
Message-ID: <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
Date:   Tue, 28 Feb 2023 16:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
 <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
 <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 16:31, Bryan O'Donoghue wrote:
> On 28/02/2023 15:26, Bryan O'Donoghue wrote:
>> On 28/02/2023 15:24, Konrad Dybcio wrote:
>>> This call does not seem to have been cast on any kernel with support
>>> for VPU-1.0 or newer (and by extension, HFI6 and newer). 
>>
>> We tested this on sm8250
>>
>> Restrict it
>>> to V4 only, as it seems to have been enabled by mistake and causes a
>>> hang & reboot to EDL on at least one occasion with SM6115 / AR50L
>>>
>>> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
>>> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>
>>
>> Right. This may indeed fix it for you on SM6115, could you test it on RB5 and verify the above statement ?
>>
>> ---
>> bod
> 
> For example.
> 
> Doesn't your later patch take account of VPU h/w version ? IRIS_1, IRIS_2 etc.
> 
> When we added for V6 here, we meant for current tested V6 hardware at that point - at least sm8250.
> 
> Can you not differentiate sm6115 based on VPU hardware identifier ? We want to retain this logic for 8250 and then assuming your patch is correct, not do this for sm6115.
As far as my only source of information (msm-4.19 techpack) goes, this is
unnecessary/incorrect on 8250 as well. I doubt downstream would ship Venus
with no/broken low-power modes..

Konrad
> 
> ---
> bod
