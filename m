Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77152678286
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjAWRE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjAWRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:04:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B276A3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:04:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mp20so32227085ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MumBSmLnR6qtNJV+vo1mnn6BMJJa8MTj2/SYpRgyK0A=;
        b=zVIfPhFLbFu7uV161eMTM3C7yivzp8mPjtQ5u+ywjWvegXp60gGKONpyK0tUEJ7jNf
         UZDMGmwpPitzBVGSctxPY3/sqXteeykKOSSrhXwTX4QB65xausSwEwEE1ADVonPOMaYq
         aKEcuWojS3jRc0a1TrLA1PGzJMLxY3JXXE8CDIw6AlpIX9iFjKdMBijt5aajW0xYyKYE
         hdp4ISJ8ocxfJk8/MuwLwmRBCyAXoJ25Kv/rJlV1hgRIXrQOByLf8rzFUcZfm9JXfv55
         F5sWVdZjMfDlQsTvUuAefT6JkRXRSma2E/PYPMwCFTYcztvkJ/Sr8eq0k4r6DNn0nhQy
         wFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MumBSmLnR6qtNJV+vo1mnn6BMJJa8MTj2/SYpRgyK0A=;
        b=l6VoZ0v/Rs/4rQdMpvnBTb34zZY/lojYlrzl0xhdu56nIRFzfDLAq+uVPFHxOuWqJB
         QNgs2+YhSc5vJ8hk7JC68cGVkU05f33fnBGtoL4Yz+V2BFbYhaz/0sclnvE1DenuTdTZ
         SjO2uO7NYPU1pbCKteDfsWkw0SxEfE2huDls8E1JcjIrY98uKMNx6I1q+pcLeqqbaJ2s
         pk0kNCO/s0MOdl4SHOzqcpTj5j7FsopQxdnUDMmWkFyzwykPGIYIZZJLmU6/r2sFnl2i
         Bl7ghPbC6sZFLWlkzrwbYGAjeT9m7IRmL9IaAWxITK7SMJ4iiae27wA67YLlZ0/V8+9b
         lkBA==
X-Gm-Message-State: AFqh2kqxdtGEvos+vHrpJiGcc/IN+LRkvuTm0JoE2XPUBARsBxIIn1cO
        uw0aoSCRxMNQ8vq5q6uGu8vfbw==
X-Google-Smtp-Source: AMrXdXvF9qSmhrrxo1yfZJcAWyvUP3LJLaDdk6U4dhdDk/1GeU4VbH1AxM/lBMVsF0YnR0jWRThYgg==
X-Received: by 2002:a17:907:7248:b0:872:b1d7:8028 with SMTP id ds8-20020a170907724800b00872b1d78028mr34814718ejc.3.1674493495123;
        Mon, 23 Jan 2023 09:04:55 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090632c600b008779eb0fd83sm5288910ejk.23.2023.01.23.09.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:04:54 -0800 (PST)
Message-ID: <5ca0d7d4-b396-8435-0957-f794ed0c2eed@linaro.org>
Date:   Mon, 23 Jan 2023 18:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230122172441.4f8d75f5@jic23-huawei>
 <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
 <20230123170118.2q5b5rmmkyoi7zpk@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123170118.2q5b5rmmkyoi7zpk@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 18:01, Marijn Suijten wrote:
> On 2023-01-23 17:35:34, Konrad Dybcio wrote:
>> On 22.01.2023 18:24, Jonathan Cameron wrote:
>>> On Wed, 18 Jan 2023 12:06:23 +0200
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>>> The node name can contain an address part which is unused
>>>> by the driver. Moreover, this string is propagated into
>>>> the userspace label, sysfs filenames *and breaking ABI*.
>>>>
>>>> Cut the address part out before assigning the channel name.
>>>>
>>>> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
>>>> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> LGTM, but given it will have ABI impact, I'd like to hear from 
>>> Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
>>> who has touched this driver fairly recently.
>> + Doug
>>
>> Unless the Chromium folks relied on the old names (they're the
>> only ones I can think of that actually could have tapped into
>> this), I say green light!
> 
> Can you clarify "old names"?  The ABI-broken ones after Nuno's patch
> with @xx suffix, or the orignal names (without @xx) before that, which
> this patch from Andy reverts back to?
Nuno's patch names, this is a fix for that but in a very unfortunate
event, they might have started using sysfs paths right when the
breakage happened.

Konrad
> 
> - Marijn
