Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B106366BED6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjAPNHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjAPNG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:06:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421123592
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:06:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a11so2517610lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhaySgQ931ggdM3I6a9ki+kXxD+QSoWR1uvU+hZmKiM=;
        b=mE/EwGkRpZCujtVivCpriZS0XO6rUEfL+lYuLMGxspO4E0COtutKaR0sS12UUovXG0
         P917lUmjP323E3U3LajB4eVqjr+6N7I8mYnJzvzwkUBdOYDWY5lvilCt0dIgo2MWgXZD
         Eu7upP8CExT76uU4GxOZhMJ8DA02prbw2oOrQMoTfzrOGBCYoq/kPe19HyevnLilAChC
         2RnnksigiGUMUNa1nSg6btyEgUuCJPCgSS3u6JS+mbvlSFzAoS2yIt2zL3EZA///oBol
         k1mUZqXdSdxLESDLvjMSrXVnq46syo3EBiSZGqE5Zl9IrNnKJ8bNHOENn703ErzQqi3x
         WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhaySgQ931ggdM3I6a9ki+kXxD+QSoWR1uvU+hZmKiM=;
        b=mgHh3dpQ7F95Wv5rQVWZUdXucAdKahqjYQKZ2zrXqk47SXAlQ9qnVHh+xjzMmfmg0u
         fkhXe4F4RcTtb8uXvxod3WqVgpTzglc6H/mXRXpB+/KjXhxkKCsOF+Bocj7HGyA/rXU7
         vvCR1E3BGiYcLoQ9Oa09p/RMbr6Ofd3jSfPLrBXKrwYE/KebdOaCQLp4kS+Rs8Z5FzmK
         HWO8/RG1mk5Ff6+mhjyLotR9VdyYkObSlE6hUyoCiQCgIAUeb9pcTdjbHm+Af3t4KRmv
         DK/8YMpDygxw2RefQkpyM92jTNK4Ry2Olb3g3LgBGMWUjWnljIGXVgwfgixwvC09/Aq0
         RF5g==
X-Gm-Message-State: AFqh2kp96uyZ2ZDNYxYA9uHIUnUW3Ndf5NTrgN/fTsvhX0MRMbs7r8OS
        TuSRYJAFsvvTJbkaxWfe70O40w==
X-Google-Smtp-Source: AMrXdXvF5dt4yar2orujGs7guEyKNFpIKXkkv1kvIR2CQqTY55DTNzGT4TUUjImhtKs6f8KXfaF2fw==
X-Received: by 2002:a05:6512:2302:b0:4a4:68b8:f4f1 with SMTP id o2-20020a056512230200b004a468b8f4f1mr31785702lfu.55.1673874414625;
        Mon, 16 Jan 2023 05:06:54 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b004cb08757441sm4999853lfo.199.2023.01.16.05.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 05:06:54 -0800 (PST)
Message-ID: <4ccefff5-a207-8832-c94f-058757ecf8e8@linaro.org>
Date:   Mon, 16 Jan 2023 14:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 02/10] interconnect: qcom: rpm: make QoS INVALID
 default, separate out driver data
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-3-konrad.dybcio@linaro.org>
 <d8a7e477-f612-19cb-8573-5cc0449df0fa@linaro.org>
 <22d4bd3b-1b36-8ad4-ca19-157597949a21@linaro.org>
In-Reply-To: <22d4bd3b-1b36-8ad4-ca19-157597949a21@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 00:47, Konrad Dybcio wrote:
> 
> 
> On 11.01.2023 00:13, Bryan O'Donoghue wrote:
>> On 10/01/2023 13:21, Konrad Dybcio wrote:
>>> +#define NOC_QOS_MODE_INVALID_VAL    -1
>>> +#define NOC_QOS_MODE_FIXED_VAL        0x0
>>> +#define NOC_QOS_MODE_BYPASS_VAL        0x2
>>
>> The basic fix you are applying here makes sense to me.
>>
>> But why bother with an additional _VAL defintion, you have your enum.
> Thinking about it, I was probably confused by MODE_INVALID checks in
> qcom_icc_set_bimc_qos and only now realized that it's not even called
> with MODE_INVALID.. Will surely fix!
Actually, no.. qcom_icc_set_noc_qos() writes the _VAL to
NOC_QOS_MODEn_ADDR(), so it does matter.

Konrad
> 
> Konrad
>>
>> +enum qos_mode {
>> +    NOC_QOS_MODE_INVALID = 0,
>> +    NOC_QOS_MODE_FIXED,
>> +    NOC_QOS_MODE_BYPASS,
>> +};
>>
>> ---
>> bod
