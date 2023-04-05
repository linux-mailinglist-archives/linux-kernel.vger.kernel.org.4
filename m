Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267C36D7529
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjDEHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbjDEHTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:19:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE58421A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:19:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e9so21075067ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZshzFn8jWB8lrxkc4qZocf/HOvuVXKzPMiCe+g5jLeo=;
        b=Ua3QOD+krfpvembHTU4smJG5WBZs2zvxIGyNt1F5E0OxUMD8K3sztCzQarvgWYGeFw
         jfvFnRGbNj+b5l4es+RlJRJsRYsnGVd18V8XNB0alKyYIOGYPyKUV+Y+u4LaJ6b0EKpS
         sBVKkiDZUFNqUSYTImaWyS34c2Mz+UkFIQh27+88yRQWILTObQr8Hi67pEqjxNi9WjQt
         loA78gVH5/NxTU9ewtvI0EzhAt/WAyzLEGA51ReFuvLc8D2PRSpJeDGraH/CqbxTcwRn
         LFZZCWaHHYzDHjNJSe4tKKZ2rkzl9ppLzLjBRxrI3KPIefhvgw+z4bfkxAMkYCDyGYl5
         lULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZshzFn8jWB8lrxkc4qZocf/HOvuVXKzPMiCe+g5jLeo=;
        b=nuLtwvLPUoGNrJuZ1mnd3PZxhodkJkM/11vVeCyhuEAhYH1n8FYWWq4Rd9XZ1MQ0Y4
         C2CTW5+I+w1Imhm5i3AlezbompXHIcEWminzpCxjT9YwaiEDtW19VTHyqqRiVMqrv2M+
         fR18nUt/cW8Q/hjFnmOMbUoDIY8kemQIqwTEs25DToYWkDh9htx8npEEFL32qyM8TrEG
         YGicBxKaNQjRk7kEy386Fs1h79R0dnwWwKp0kNywbWwZso2r7ZXfATCgflYjWthWrIab
         bMruq7lrerfArw0oh+ghKQYOOeAt/XJfr7/8sKFEwnq1JDvAH1Mw6vXg7gT3BnniQHVN
         IYfQ==
X-Gm-Message-State: AAQBX9cjNrDnRX2xoYnCLFFpNFTwUzEFHYuqYj9vX/p/jg0+lQsKmz6I
        q/S8z5oXfzJBTgCEhPApe1wMOg==
X-Google-Smtp-Source: AKy350YyvleS3cF2DdUqDRB8E+oRTkx1Y+HP8l8nylibcy6LctmOXNdF3KYsQp8NMGePYlGtGuX2rg==
X-Received: by 2002:a2e:9788:0:b0:29f:e144:6c6c with SMTP id y8-20020a2e9788000000b0029fe1446c6cmr1396594lji.30.1680679182298;
        Wed, 05 Apr 2023 00:19:42 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e9a88000000b0029e84187ce2sm2707553lji.139.2023.04.05.00.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 00:19:41 -0700 (PDT)
Message-ID: <514ed648-2d5e-c18d-e5ff-828f6b9a8345@linaro.org>
Date:   Wed, 5 Apr 2023 09:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] venus: fix EOS handling in decoder stop command
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-4-git-send-email-quic_dikshita@quicinc.com>
 <93b78f82-d2db-fc1d-4bad-732f7a1b33de@linaro.org>
 <62cc41a2-ff48-40b9-eb89-69e352e6f6e9@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <62cc41a2-ff48-40b9-eb89-69e352e6f6e9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 08:41, Dikshita Agarwal wrote:
> 
> On 4/4/2023 11:54 PM, Konrad Dybcio wrote:
>>
>> On 4.04.2023 08:17, Dikshita Agarwal wrote:
>>> Use firmware version based check to assign correct
>>> device address for EOS buffer to fix the EOS handling
>>> with different firmware version.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>>> ---
>> Does it only concern fw 1.0.xx?
>>
>> Konrad
> 
> that's right.
> 
> changes were made in later firmware (newer than 1.0.87) to
> 
> make the behavior generic across all supported SOCs.
> 
> Thanks,
OK

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Dikshita
> 
>>>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>>> index f0394b9..c59b34f 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>>>             fdata.buffer_type = HFI_BUFFER_INPUT;
>>>           fdata.flags |= HFI_BUFFERFLAG_EOS;
>>> -        if (IS_V6(inst->core))
>>> +        if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>>>               fdata.device_addr = 0;
>>>           else
>>>               fdata.device_addr = 0xdeadb000;
