Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206B66646FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjAJRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjAJRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:05:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79C4FCD9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:05:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id cf42so19505562lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViSKVOVdYXza1X58HUisghrY6PNtu3jUgQJxDurpmbU=;
        b=MsX48sRoyYXUqcmOlftJJM8++0/Mj4qf6uQu5f9hQ8r3FQGKLatvW1xBcP0tDyY3jP
         79fcWRyi+v8JI5qOTNtuu5R+eKUHS5VJSyKa06eN694zKdDcGNxoGZ7yOTWHY4FnjQ14
         JUIuwTapO+8FuiZVPkdE0T0yCEtBt3WAmkIKsdeDqJgVH8O7ri3eTxkA4QMysiZCcDcM
         yI4ijywlYzLyJXYHnUdMrVZAlSc26zgszQpOs1iA1f7VbDKOADFW1j04jGppGafLv0Ps
         o8vY4SOjIn22EK0RtpohxR8F47OA6alVPg7e+GqQ/69AKEeC7RTEc5bRthhXf169+xvA
         8xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViSKVOVdYXza1X58HUisghrY6PNtu3jUgQJxDurpmbU=;
        b=eVWdCyZZJPEABV+xtTctCLCXeMiynA+Azf7qyhlCQ9iOTvVUEzdOHup6LmF4jJaWIS
         UEwgFXv+o1znSjdegQ9nO5vs0vCeN7UheXrAJUw7TnecRUS/HRlcxu2bx8wUYEFjVGcz
         TxF8vq2a2aWEMzOEybKmwLH87bz6XpSDNCxxdrCS8PcBLsz7lYSbo99qNjWS1+YN8Twx
         TYijAVt+r2dKtJ6BxJrY2mIJt2JC8xWX19gClUe5frKgbBQxCjZXUXLN4upzOw/vCfTx
         a3yUE1N/9cwewvXKh0mLmDS9+ZiErGya1mb9aVJe3xcRQZYgvpEIjUQdwrsDCX12NXWR
         /sjA==
X-Gm-Message-State: AFqh2kpyMerZ7zB+VT/bwf3Z1ZYzvtzdPKe6MFLuA4vqfmcGSd8rSeY1
        tCXW0kJoTyzcOkva6cdHlGugaw==
X-Google-Smtp-Source: AMrXdXs52CyJbbjNnpCT3mB8KFDRxubwKTeuPu+s4xCVtpc/QoaxCbT68eLjBaRnniX0fw+UdKUeuA==
X-Received: by 2002:ac2:46f8:0:b0:4b5:9ec5:dbed with SMTP id q24-20020ac246f8000000b004b59ec5dbedmr21895758lfo.40.1673370332442;
        Tue, 10 Jan 2023 09:05:32 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b004cb291bcd2csm2257930lfs.246.2023.01.10.09.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 09:05:31 -0800 (PST)
Message-ID: <593e555b-d9fb-83ab-dabe-33d6690210f8@linaro.org>
Date:   Tue, 10 Jan 2023 18:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 01/10] interconnect: qcom: rpm: Don't set QoS params
 before non-zero bw is requested
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-2-konrad.dybcio@linaro.org>
 <1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.01.2023 15:00, Bryan O'Donoghue wrote:
> On 10/01/2023 13:21, Konrad Dybcio wrote:
>> Until now, the icc-rpm driver unconditionally set QoS params, even on
>> empty requests. This is superfluous and the downstream counterpart does
>> not do it. Follow it by doing the same.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index df3196f72536..361dcbf3386f 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -191,6 +191,12 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
>>       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>>       struct qcom_icc_node *qn = node->data;
>>   +    /* Defer setting QoS until the first non-zero bandwidth request. */
>> +    if (!(node->avg_bw || node->peak_bw)) {
>> +        dev_dbg(node->provider->dev, "NOT Setting QoS for %s\n", qn->name);
>> +        return 0;
>> +    }
>> +
>>       dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
>>         switch (qp->type) {
> 
> I still think you should include the original logic on the else, for the minimum case of silicon that predates the 5.4 kernel release.
> 
> /* Clear bandwidth registers */
> set_qos_bw_regs(base, mas_index, 0, 0, 0, 0, 0);
> 
> Either that or get the relevant silicon engineers at qcom to say the host side port write is redundant.
After some conversations in private, it was concluded that this patch
should most likely not be applied, as there's not enough reasoning
beyond "downstream does this, let's copy it".

The other 9 should be still reviewed.

Konrad
> 
> ---
> bod
