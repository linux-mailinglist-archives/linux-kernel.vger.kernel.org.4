Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6D711A08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbjEYWMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjEYWMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:12:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B0134;
        Thu, 25 May 2023 15:12:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so4952f8f.1;
        Thu, 25 May 2023 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685052766; x=1687644766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFJtBf144L+RNI6vdZ74vm5/bZAi3JB5tumWH+5TWQ8=;
        b=PiXYmMKD5UaMXF06vDpfmVdXWhVr4dEPxp1ZAS7yz3hIqr496mp6BXs6OI/zYTaYJu
         lz3JoZVGNDMaavTvD8Gth4hpob8xe9gxFjlpdBQoPlc7Te9MGVLTF/73mTB0+k3JZp4i
         CdP0ZejXXx0qCAIb48wpnHFDKIJxM38pawzwNHqKLf99YkmNs6eYOYOJxyl2toi/xBnw
         VDz5pxWTBzHFK8CSu7Ng3TapOUJt7aIhRH9gr995N8OUeGbpGD8W3lkEt6Fwl3W+J/5g
         BKSOqxZBn2hPMseYahgWrTM4K8aaf7p9hm35EA/Q2IuqzAA7W9EOW+p32Qpns6uB4YqX
         qZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685052766; x=1687644766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFJtBf144L+RNI6vdZ74vm5/bZAi3JB5tumWH+5TWQ8=;
        b=ENdFVIHbPEu0l7Bi/E1moW9239oB69q1xHGtJs54/Gx6/g7DUPoGl287pwlevs/FRW
         a9L3faSETh6L6+EQwhat2QDa5LQTi2vqehEq7nAo+y0pg9tkdwpIsZ7dog8vmtuDvhDp
         bKX9rZYidjWaMgDbsstIF2dKIb93QfLwa34RKP4JeDTw+exAd0F9V8pIBul1k9irDvcF
         goko3pQg98HbKAxuK7Cq2PFYdixBAQIim7po3kEUjGkM1nWS5WQx8DQSEmjzaVbIhiJt
         3LhOIJaxqUf5GL3TktBWPSL0NhHq3rkrqHr5OS+Mrj69Azti7U2wH9YtL7it0NIsJbYr
         qskg==
X-Gm-Message-State: AC+VfDxlV4ofI/WyDcW4F0WCO63AOI8ASrfBKLoI5Zox2N21ijhi9WnU
        SNOKVbAPsfBEej5LPFykpPO4lnDm2Q8=
X-Google-Smtp-Source: ACHHUZ4yW2unvsWGPuTSFaIHxLbQOrb9iXXOqQv3IqVqmvDLoCdQt1FD7qBZ2Ec5xDVLpgKH5NYQxw==
X-Received: by 2002:adf:f4cd:0:b0:30a:bda7:f16f with SMTP id h13-20020adff4cd000000b0030abda7f16fmr2305096wrp.0.1685052766097;
        Thu, 25 May 2023 15:12:46 -0700 (PDT)
Received: from [192.168.57.226] ([37.63.24.136])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d5950000000b003078cd719ffsm2992863wri.95.2023.05.25.15.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 15:12:45 -0700 (PDT)
Message-ID: <42b9a661-a050-4cd3-16bf-b4af88745383@gmail.com>
Date:   Fri, 26 May 2023 01:12:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] venus: replace arrary index with enum for supported
 formats
Content-Language: en-US, bg-BG
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1684736229-30567-1-git-send-email-quic_dikshita@quicinc.com>
 <0f7a33c1-f894-adfe-94d7-89296893128f@linaro.org>
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <0f7a33c1-f894-adfe-94d7-89296893128f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 23.05.23 г. 11:02 ч., Konrad Dybcio wrote:
> 
> 
> On 22.05.2023 08:17, Dikshita Agarwal wrote:
>> Use enums to list supported formats for encoder and decoder
>> instead of array index which was a error prone design.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> Thanks a lot.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
>>   drivers/media/platform/qcom/venus/core.h | 16 ++++++++
>>   drivers/media/platform/qcom/venus/vdec.c | 63 +++++++++++++++++++-------------
>>   drivers/media/platform/qcom/venus/venc.c | 31 +++++++++-------
>>   3 files changed, 72 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 12a42fb..e988ed4 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -83,6 +83,22 @@ struct venus_resources {
>>   	const char *fwname;
>>   };
>>   
>> +enum venus_fmt {
>> +	VENUS_FMT_NV12			= 0,
>> +	VENUS_FMT_QC08C			= 1,
>> +	VENUS_FMT_QC10C			= 2,
>> +	VENUS_FMT_H264			= 3,
>> +	VENUS_FMT_VP8			= 4,
>> +	VENUS_FMT_VP9			= 5,
>> +	VENUS_FMT_HEVC			= 6,
>> +	VENUS_FMT_VC1_ANNEX_G		= 7,
>> +	VENUS_FMT_VC1_ANNEX_L		= 8,
>> +	VENUS_FMT_MPEG4			= 9,
>> +	VENUS_FMT_MPEG2			= 10,
>> +	VENUS_FMT_H263			= 11,
>> +	VENUS_FMT_XVID			= 12,
> Nit: I don't think the '= n' is necessary here, as it doesn't
> map to anything in hw/fw (or does it?)

IMO, the numbers could help when debugging to avoid counting.

> 
> Konrad
-- 
regards,
Stan
