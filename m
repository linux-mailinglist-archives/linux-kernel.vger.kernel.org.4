Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357CC6A5C22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjB1Pi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjB1Piy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:38:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877D7D95
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:38:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso6126100wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hn8pQh2Uorn3V8tSzwuAz0OAeay/eogSoQRtuGgUOOc=;
        b=i9QNqpPqqv6iImxnuWf46SRgvQU6BtN4HcQ88EwRTtDuzCQSx3WHEwwtmd6MjmBWIE
         yQgHqJ8FUyeMpD9oG0RxkJL2gI8+7cbljupGi206TCZ4Ms9Nt6j/Eb+VI7dwg8kgYCfu
         y1S/dAVgZvxeZx9dO6oQSSWloqgxtk46oxgJ3Gsu2RzJonIset/WCtdSUW2CV91J7iCG
         i8PRngfxqhTsWCpdiqmjxs7zbczNt3iLiDckk3THySLgLmSXwl9XyHWyDFH5xoO3leEc
         qv8j3XKjFnC7HYNJSRzbQsoF+ftLB8rp6I3PbnVhLF8aZ1WUEaBXfkWdGk3sM+gcA5gT
         fqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn8pQh2Uorn3V8tSzwuAz0OAeay/eogSoQRtuGgUOOc=;
        b=Qu98ZyWVUMJ5mvxKT8/Ohl2v9koYNebu2xeRM1XYbaDCp6ZgirsLtbQ5yevVj4WcKg
         Lx8MFLxMyiZfNl+2idKLT2JmAHHsT7uDS2QPkX9ER28xZYCYMGvTz7xxcDO6KxJYw8yV
         AEhzCAoOsPGs2/sJ2jtqzvHdImUXEBiCTPsl7sbNpy/EChFEdqmD+SQzPRkIzkShTiRS
         GcC2OlCH6l4mzMvWxZaT2JVuCAuCzawvTRY4iTJ0v0ybwYyR0tYw4YBjIrBTEPY1QjBY
         M91sOOCVU/zk2/u+W+ZFKN/hH7x+fpBieVQR1f5hAaiaHMEIj4bhnZhfxHNN1O+fz9Ck
         4XUw==
X-Gm-Message-State: AO0yUKVE/cUfh4Mb6xvvQNdad+0OWZ9hy3EZGoat8uCYqfuEwF/0Eav1
        wdARXs42dRKhr9db3m+0/ZvuUQ==
X-Google-Smtp-Source: AK7set8eSj9wAxx+UD8JjPklpSg7Vo6o/DZsEZKH3e0U2dU0vIlX2UgxlgUNamJ9Bgz/8V/KpX4U0w==
X-Received: by 2002:a05:600c:74a:b0:3df:1673:90b6 with SMTP id j10-20020a05600c074a00b003df167390b6mr2547027wmn.39.1677598721052;
        Tue, 28 Feb 2023 07:38:41 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b003e91b9a92c9sm13596319wmq.24.2023.02.28.07.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:38:40 -0800 (PST)
Message-ID: <b7f0c568-72b7-3342-decc-784cd5f68b1a@linaro.org>
Date:   Tue, 28 Feb 2023 15:38:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:37, Konrad Dybcio wrote:
> 
> 
> On 28.02.2023 16:31, Bryan O'Donoghue wrote:
>> On 28/02/2023 15:26, Bryan O'Donoghue wrote:
>>> On 28/02/2023 15:24, Konrad Dybcio wrote:
>>>> This call does not seem to have been cast on any kernel with support
>>>> for VPU-1.0 or newer (and by extension, HFI6 and newer).
>>>
>>> We tested this on sm8250
>>>
>>> Restrict it
>>>> to V4 only, as it seems to have been enabled by mistake and causes a
>>>> hang & reboot to EDL on at least one occasion with SM6115 / AR50L
>>>>
>>>> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
>>>> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>
>>>
>>> Right. This may indeed fix it for you on SM6115, could you test it on RB5 and verify the above statement ?
>>>
>>> ---
>>> bod
>>
>> For example.
>>
>> Doesn't your later patch take account of VPU h/w version ? IRIS_1, IRIS_2 etc.
>>
>> When we added for V6 here, we meant for current tested V6 hardware at that point - at least sm8250.
>>
>> Can you not differentiate sm6115 based on VPU hardware identifier ? We want to retain this logic for 8250 and then assuming your patch is correct, not do this for sm6115.
> As far as my only source of information (msm-4.19 techpack) goes, this is
> unnecessary/incorrect on 8250 as well. I doubt downstream would ship Venus
> with no/broken low-power modes..

Can you test it and make sure ?

---
bod

