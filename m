Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242B69B3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBQU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBQU27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:28:59 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882A3B0DA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:28:57 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bx13so2257440ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTQ6oglkYOM2AN9ZOIfiGyLQVZrV76p4xsc7YkXI35c=;
        b=yWiS7NmIF3KI587TkrTgQf+NkYs7qRs4kMyEcyRPQh5Fi9Ihk1BaM+WzbqYvm2kldT
         U4BUyRVGD5UP1aSMpiLVy6i3fIxKy+3pnC6si5OAp4ab1t9v9adqza/ZtIOpRTq51bBJ
         urtTGQSe7FMJUO06WemkMrbZRe9oy+UHJxJRfzGkccPZNXd13vr7fBrpKXGl94bvRz3W
         +ozZkfp0UomTt8bh+VTarofMLEQcdmyIdhL17lOSftIm6piSLVORZ68FEVIwB1ZQhMEM
         0x4evUoQvFDk25vXdUa2/CZHhT5WRA/Tzrk7vsTIpbCeNb3HF8hn7QOuk9zBYaGPptLP
         qH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTQ6oglkYOM2AN9ZOIfiGyLQVZrV76p4xsc7YkXI35c=;
        b=0qrJZDH2wY7xmpBVXshUCogkTimrqK4rd57vTUEoPQIKKYzeWTcBZALuO7do96afOP
         JkfiyPK2aeBe5h6v4EpDVFYhzQhW+lXoj9jkG5iS9s17gRvF+4CRNbt9n+2eaFmkhXh5
         M9DGo1H7A+bF2erN2Kx0dRW8/VgVpMCCeL5tKaF3apNURMQFRUpFvARQ8f0l9b+5vzEl
         wlbGtv9OUkg60cwOwD9WYiuHuYe8ppSa0VpgEjIPwCbnu/Ajpk7YWQuYO+265QBQMfyL
         26eavXaD8hBaGsZO0WeihbxKAiFu0bZqbSquoRS//kmJ96Ar51zViNC3g9TVrp2xOXxE
         m+5w==
X-Gm-Message-State: AO0yUKWbdSgER4Zpzg7k7Yrho89dNjcjsIzrgVhmex0kkVm1aObVW7Ex
        cCJpTtHBpZGb8k21J5QMCw4JPQ==
X-Google-Smtp-Source: AK7set/TDjj7Wmbuf8xCJ0jTpkVZ9OeoRDej7SHgFhojYH8cSfMDg2oUyUqjxToR8JNrKZK3aY+2oA==
X-Received: by 2002:a2e:a261:0:b0:279:bc00:fe5f with SMTP id k1-20020a2ea261000000b00279bc00fe5fmr779789ljm.8.1676665735842;
        Fri, 17 Feb 2023 12:28:55 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id k16-20020a2e9210000000b00293524fb6b1sm703068ljg.74.2023.02.17.12.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 12:28:55 -0800 (PST)
Message-ID: <5a2f502a-6530-dc8c-a81e-3d2a33964366@linaro.org>
Date:   Fri, 17 Feb 2023 21:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 08/10] interconnect: qcom: msm8996: Specify no bus
 clock scaling on A0NoC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprJYPAsFZgu-DwjOHm6FsUEJ309zDo=Muh04L4B4oWhmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.02.2023 21:26, Dmitry Baryshkov wrote:
> On Fri, 17 Feb 2023 at 21:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 17.02.2023 20:27, Konrad Dybcio wrote:
>>>
>>>
>>> On 17.02.2023 11:46, Konrad Dybcio wrote:
>>>> A0NoC only does bus scaling through RPM votes and does not have any
>>>> ICC clocks. Describe this.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>> This is bad, as devm_clk_get_bulk{"", _optional} doesn't
>>> check if num_clocks makes sense and passes "-1" down the
>>> devres alloc chain..
>>>
>>> I'll rework this for the next revision by simply assigning
>>> the common "bus", "bus_a" set everywhere instead of relying
>>> on it being there by default..
>> Or maybe I shouldn't, as that will require redefining the array
>> over and over again.. Perhaps just passing <&xo_board>, <&xo_board>
>> to a0noc's "bus", "bus_a", similar to what's been done on SDM630's
>> GNoC would be less messy?
> 
> What about simply skipping a call to devm_clk_get if num_bus_clocks is negative?
I tested that locally before reporting the mistake on my side and
while it works, I just consider it.. ugly, because:

num_clocks =
>0 => use the externally specified num_/clocks (logical)
=0 => use the default 2
<0 => consider there's zero

..but maybe that's just me.. if you don't find it ugly, I may just
go with that.

Konrad
> 
>>
>> Konrad
>>>
>>> Konrad
>>>>  drivers/interconnect/qcom/msm8996.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>>>> index 1a5e0ad36cc4..45eb8675fb11 100644
>>>> --- a/drivers/interconnect/qcom/msm8996.c
>>>> +++ b/drivers/interconnect/qcom/msm8996.c
>>>> @@ -1817,6 +1817,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>>>>      .type = QCOM_ICC_NOC,
>>>>      .nodes = a0noc_nodes,
>>>>      .num_nodes = ARRAY_SIZE(a0noc_nodes),
>>>> +    .num_bus_clocks = -1, /* No bus clock scaling */
>>>>      .intf_clocks = a0noc_intf_clocks,
>>>>      .num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
>>>>      .has_bus_pd = true,
>>>>
> 
> 
> 
