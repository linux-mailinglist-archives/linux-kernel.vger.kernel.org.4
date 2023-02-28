Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D576A5BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjB1PcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjB1PcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:32:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C85431E00
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:31:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h14so10195465wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598288;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBPmwZnQodQJWshUDZwN7kof1cJPO1m2ohtrhRk2uVc=;
        b=EBj5wce2kEbOpX5fsYkWLTTpRPYRCMiWVZauj98oR3cVbH/AeEsAYkR9spiREZJxH/
         HK3tHNhO105XaM/G/e8MizD4llhiR15LUc9ebij/Lmi8uLkd/eq+ljmohEu837pjqWee
         TihMV3JR0lBbp/kJK7oQY77aRcCRXi1/0aO4huWjp9gBmbIq+Tvs9M7BndCr36pjywvR
         yyykaT2ezvP//dQHK80uddraQp70A3vIqnRW8AFifhsMv41wY3uYWQHwPeazWbnmOol8
         A5qiNLk8pahZdILE56/fvyiPbuq0hT6ojdW2F02f6onRzRayEZIjpn/gnMpXFXaU1utF
         b/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598288;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBPmwZnQodQJWshUDZwN7kof1cJPO1m2ohtrhRk2uVc=;
        b=Q/OLZ0VUyuIenQEw1UNHxnAW3yZ1kpqReci5nYSlZK5u0r5fzHxjp8vSWY+9ZsUCyL
         PJ4WJ5P08YA448hnPMEWdHbbQw5elZgvEhmLIxbx1OSCHojs6lzB/Zpw6ZAZPyEt6J5S
         ZJax3i7rg5wjyPLVHBIxssVeyerZ0oAogCpxNYxNYym+RlKKDGnIGPA++U+OEZNpkrvR
         2IEic2DNktyi1OJYMMjSA8VNoz03LxFtoW+Vn1h7iCO1chXr3leQDRWLCOBdF2Twalqk
         xSC1j+UKRl1FGo1oOKjPr/y/DfrcDXgBxp0Z6hnCKrZF6ETEkX2kuoXZ2wyVnwL9omrP
         5JIw==
X-Gm-Message-State: AO0yUKW/CGblF931U8hGbDa+dN1aMJw9Ykwe1f+thxTH4gxkNxAtaCrx
        D/5yE2+vm91PAwPosTkRlHdeWw==
X-Google-Smtp-Source: AK7set+AB5WNK7Y/NKNxDENEpTageptHG35d90EvOac0ZVlyzbUnprkbpPFTLIpzPL7jryEH/nxLNA==
X-Received: by 2002:adf:db8f:0:b0:2c7:1e52:c5a8 with SMTP id u15-20020adfdb8f000000b002c71e52c5a8mr2270030wri.21.1677598288366;
        Tue, 28 Feb 2023 07:31:28 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003e2096da239sm16494291wmq.7.2023.02.28.07.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:31:27 -0800 (PST)
Message-ID: <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
Date:   Tue, 28 Feb 2023 15:31:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
In-Reply-To: <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 28/02/2023 15:26, Bryan O'Donoghue wrote:
> On 28/02/2023 15:24, Konrad Dybcio wrote:
>> This call does not seem to have been cast on any kernel with support
>> for VPU-1.0 or newer (and by extension, HFI6 and newer). 
> 
> We tested this on sm8250
> 
> Restrict it
>> to V4 only, as it seems to have been enabled by mistake and causes a
>> hang & reboot to EDL on at least one occasion with SM6115 / AR50L
>>
>> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to 
>> existing IS_V4() if locations")
>> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>
> 
> Right. This may indeed fix it for you on SM6115, could you test it on 
> RB5 and verify the above statement ?
> 
> ---
> bod

For example.

Doesn't your later patch take account of VPU h/w version ? IRIS_1, 
IRIS_2 etc.

When we added for V6 here, we meant for current tested V6 hardware at 
that point - at least sm8250.

Can you not differentiate sm6115 based on VPU hardware identifier ? We 
want to retain this logic for 8250 and then assuming your patch is 
correct, not do this for sm6115.

---
bod
