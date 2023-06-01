Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12D4719834
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjFAKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjFAKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:02:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF0129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:01:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f122ff663eso690255e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613680; x=1688205680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ioEn//NQFT+oZEC++gXomowkVto8H1YOn/EZNzbn6s=;
        b=ReOwnsrpA4kmhUrZv8TuJtTLcy3Yuql4TSfPEYMJxkQisD6BKRqh7WzsJpaqxTCNO/
         JdXJNQ2aarCzwxh7akL1CkHY7dZP+HkCss2bmsemBjaCY53OOXo6sMlEwd2L17qeguAc
         Mwtbgj13VjQIVVHGxWK6muY/RRwfXNdjxdlG4ECEQf9gto1Qu2vvsYIRJrll9CTHAQu8
         Xr4uxneoYv2VmEy3Tc6J2f3745BlkBPf2IC5XF5w8tGNbXFBTAlNybeJoAm24UkFFAS6
         NYGRAH4v3TMRN9w0ZV/wE+aaClznitFw5prgLwWy0c4Q8bN2UEJZlvAVNOh5g9TOdkzD
         MVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613680; x=1688205680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ioEn//NQFT+oZEC++gXomowkVto8H1YOn/EZNzbn6s=;
        b=UdpXaQ48zPs/j3xfb/96lcErGMX4CMtl3QDlMDSrradyq7hMufFhVpDp0d1eICqK6b
         /3mbHUnbTqJAQmkHgC+HykXdoja5E17ve+k9Is6DAWbl2TZHmBa1+nSp3gP7+9Wc/QpG
         Xc/ayyMjJnP1w2bh3DOv2hgzcVNM3YZGYfqXkfsvAsHFC3R9lfqa2sjoaBCYxymO36MY
         Q482/CQYmrNoqyegmUp9FcHL47cswiM2doisCx4CFRvVn3t3rr5JP4Q3htXMTQqnNngh
         BAxYg/IuEQfJmyW+A0ZIsj/qBYJsU4/NgFwy7BPe+hTA8bdkQn/2M8+TtTg94AaQkN5j
         ADhQ==
X-Gm-Message-State: AC+VfDysfeNOt2wVdkvOOOn61sTlV7zYnz3d4IUE0wVogOHjpA8Y8/cO
        KOR1P5aHXO7f4YWMKBiV195lDw==
X-Google-Smtp-Source: ACHHUZ45A2zkOvmoul2/6LZWTZ/lgfoERO9Kxkw51MKhHfF4Vqw08RldTLbMkVp2uuThiEwd7qfS7g==
X-Received: by 2002:ac2:4c13:0:b0:4f3:8258:5894 with SMTP id t19-20020ac24c13000000b004f382585894mr1128367lfq.27.1685613680554;
        Thu, 01 Jun 2023 03:01:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512014700b004edce1d338csm1027007lfo.89.2023.06.01.03.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:01:20 -0700 (PDT)
Message-ID: <1f43abe6-faf3-3d87-a49f-12f2a62eafd9@linaro.org>
Date:   Thu, 1 Jun 2023 12:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 01/20] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-1-1bf8e6663c4e@linaro.org>
 <2679410b-b40d-97b5-b7c2-46f32395b796@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2679410b-b40d-97b5-b7c2-46f32395b796@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 11:20, Dmitry Baryshkov wrote:
> On 30/05/2023 13:20, Konrad Dybcio wrote:
>> Add a preprocessor define to indicate the number of RPM contexts/states.
>> While at it, use tabs instead of spaces for the existing entries.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   include/linux/soc/qcom/smd-rpm.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
>> index 2990f425fdef..99499e4b080e 100644
>> --- a/include/linux/soc/qcom/smd-rpm.h
>> +++ b/include/linux/soc/qcom/smd-rpm.h
>> @@ -4,8 +4,9 @@
>>     struct qcom_smd_rpm;
>>   -#define QCOM_SMD_RPM_ACTIVE_STATE        0
>> -#define QCOM_SMD_RPM_SLEEP_STATE         1
>> +#define QCOM_SMD_RPM_ACTIVE_STATE    0
>> +#define QCOM_SMD_RPM_SLEEP_STATE    1
> 
> This is what we usually try to abstain from: ident changes + functional changes. I'd say, leave spaces as is and just add the new entry.
I think I might wanna turn this into an enum..

Also, I'd like to rename it but that's a story for another day, as
it'd require even more messy merging..

Konrad
> 
>> +#define QCOM_SMD_RPM_STATE_NUM        2
>>     /*
>>    * Constants used for addressing resources in the RPM.
>>
> 
