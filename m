Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B669B564
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBQWTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBQWTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:19:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD8663BCE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:19:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u22so3471858lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mzWS+CRDqxsokw45sagWzZSux8+Uj76DrCJJv/Nt7Q=;
        b=F2aDpxW5qIwHp9Vt9vDlbt2fYd23qDXhwv9cUQMDuTYXZ+nJs29XEHKpLrsJxKhtZo
         qfn++xywT/xRszNGSK/82lqVpwefgVSVBAkhV7gRMYgVcuDFRpFtCBKwd/ZIUFlQwR2e
         Qoe7RcaFZuVd5KDK7Jq88gC2TrpKJnS7FdRwE7FbUOKV9648FmC6BvbZvj5+63OxciLm
         Mdcs0dixaV+axHv1DIQcYefPLmKhKtJVBEfvnlTKc3QCxZ4osI+J7OI3fItFnJQebZ27
         YaH2Yej0Mza8fv33KLnqZvHa0wJc+5J/HyNcOXbqL/qmNF9QrnYTUD3xezw7bsiYUy19
         Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mzWS+CRDqxsokw45sagWzZSux8+Uj76DrCJJv/Nt7Q=;
        b=HimKrua4vvh6Zch3PyjQzt99NpviHEKgRg41dAxowt3HyNh89KKtge3FXC88v4WPXu
         29G0ah7u1EVCmZAnMnJGWNa1whu4D89FZJUsbrugPGfc1I1rjkomLEYsK1JVdCznhXJf
         Kg9UdW9aNaTgs7F2JpMGqgdru5BU2qSKl0SXY79XwrImR3nJFbJCKbamjhRQ+TAg0uxF
         je9AfE7F5hSVq+cLgMzIpDvat1C/OGJpgjDs+BRt/xCQbJWmN/msOV4nNyOxiEIyMpqV
         Y2HKc6xA7WLjJdRCX00N/Ps1U9ql3yiPJo9ulDsD8H+KObhoRLKWoKCHOl1PVC1bDVkg
         5fmA==
X-Gm-Message-State: AO0yUKWLSXW5xI7M8QuxRMs3rrdUe+He4Y/H5LGhYp2981R1vQZdEMAC
        ZqyP60af6b9Fll7M/KVzncKBnA==
X-Google-Smtp-Source: AK7set/DtR0mZkUH8bXw4vtgMAGGv8xhjkFvT/AducsiRg/2fiqyYOEsH5/4dN3B338vQ+Kmm2OYTQ==
X-Received: by 2002:ac2:44a8:0:b0:4d2:5446:5540 with SMTP id c8-20020ac244a8000000b004d254465540mr403869lfm.49.1676672375650;
        Fri, 17 Feb 2023 14:19:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c21-20020ac25315000000b004db3e2d3efesm794282lfh.204.2023.02.17.14.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 14:19:35 -0800 (PST)
Message-ID: <ad231bd5-4308-4a69-86c5-5431eba2807d@linaro.org>
Date:   Sat, 18 Feb 2023 00:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 08/10] interconnect: qcom: msm8996: Specify no bus
 clock scaling on A0NoC
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
 <20230217-topic-icc-fixes-v5-v5-8-c9a550f9fdb9@linaro.org>
 <8c4f1cc8-c1f8-06b6-53fe-7507d74ca958@linaro.org>
 <3c205131-632a-6592-5dc0-82313b26e5f6@linaro.org>
 <CAA8EJprJYPAsFZgu-DwjOHm6FsUEJ309zDo=Muh04L4B4oWhmw@mail.gmail.com>
 <5a2f502a-6530-dc8c-a81e-3d2a33964366@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5a2f502a-6530-dc8c-a81e-3d2a33964366@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 22:28, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 21:26, Dmitry Baryshkov wrote:
>> On Fri, 17 Feb 2023 at 21:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>>
>>>
>>> On 17.02.2023 20:27, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 17.02.2023 11:46, Konrad Dybcio wrote:
>>>>> A0NoC only does bus scaling through RPM votes and does not have any
>>>>> ICC clocks. Describe this.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>> This is bad, as devm_clk_get_bulk{"", _optional} doesn't
>>>> check if num_clocks makes sense and passes "-1" down the
>>>> devres alloc chain..
>>>>
>>>> I'll rework this for the next revision by simply assigning
>>>> the common "bus", "bus_a" set everywhere instead of relying
>>>> on it being there by default..
>>> Or maybe I shouldn't, as that will require redefining the array
>>> over and over again.. Perhaps just passing <&xo_board>, <&xo_board>
>>> to a0noc's "bus", "bus_a", similar to what's been done on SDM630's
>>> GNoC would be less messy?
>>
>> What about simply skipping a call to devm_clk_get if num_bus_clocks is negative?
> I tested that locally before reporting the mistake on my side and
> while it works, I just consider it.. ugly, because:
> 
> num_clocks =
>> 0 => use the externally specified num_/clocks (logical)
> =0 => use the default 2
> <0 => consider there's zero
> 
> ..but maybe that's just me.. if you don't find it ugly, I may just
> go with that.

Would 'lesser ugliness' count? Maybe add a define 'ICC_RPM_NO_CLOCKS = 
-1'? I think that spawning default bus & bus_a everywhere would be worse.

When this driver is rewritten in Rust, we'll have a clear distinction 
between None (meaning default two clocks) and Some(0) (meaning no 
clocks). Wait, does that sound even more ugly?

-- 
With best wishes
Dmitry

