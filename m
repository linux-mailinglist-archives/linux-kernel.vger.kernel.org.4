Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37101706F35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEQRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:18:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3C740E5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:18:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so1297983e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684343885; x=1686935885;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/W+xyRZOrFaXXUosMsho+Wtkn3dRl1nHYsHDumTX8E=;
        b=M7E8jA+AmNT97OdIY8EZEME/eE+/AXzah9OG3V8PaBGWJidzVYSF79fCHwsuldXoEW
         3wVSO7Pe4WzDijxQujtsuoTQFfCyLlAVfYjPn4s0+18O3QY5mga3S5tAt6SC8I4bMZrJ
         OeC0ztHE27ts2V4VdqDV6AK/zAFJ+oMde7kJbDBkuVMXBr9aAWumVVbtWOxpVoDjm7gP
         dwocPRjQB6ttH9S2QDR+xLBBKpZ+lJMb2Tm0seZVVK1YzEHdbqpDAWfcxHZ7um/TcF1c
         xXeKo9YrExNsV4ek9RCSFvP5fKVLXHZKOP38BHUoFgWjNEqFoVvdQ1dAxUUqHqQPRzA1
         38YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684343885; x=1686935885;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/W+xyRZOrFaXXUosMsho+Wtkn3dRl1nHYsHDumTX8E=;
        b=HYp+FopNI3TlU3XYo+VMItq6m4m1g88/5Xey6nZSvxI1Njl/u5PRWSxyrLZyQZE9n6
         /bl1oaPo9kr891eupLCi5FKjgfPoV3keFUWfHNHED217VUm66RPrhUyAaWIudToC0M/l
         diO+gw6JVa+L1yK0P3hkEztnK73A6Mj2BpJosd98Pg2Zte2ZQ5Qok1C/o/H++/OOEEtl
         H64OM8pUTjyIsvGzpYRReNYfi1ge6FnoMKkOZ42RVEHKgpIu1aGCGUCEe0jbBj1ju0e/
         dzqj7bIKRMCdXI3BYkIR9KVpvKv/NMPNS9885ATDaPhM5cvdbdYmo5qqPuiXHQU5Awfq
         vYxw==
X-Gm-Message-State: AC+VfDzzJgfRTuCi7VgMrcAdF20/DAD3q16NgcbwaU1Prdq8na61fm4P
        nz4PZyCP3KuR1hNB9vqYVXUK3g==
X-Google-Smtp-Source: ACHHUZ7qL3cLZD9LGj91BXwss6hJFPqDLP8pRWU4pQowx5XVm0GxnZn5iAX20K55cchMNdGFcvo7wg==
X-Received: by 2002:a05:6512:75:b0:4ec:8816:f4fc with SMTP id i21-20020a056512007500b004ec8816f4fcmr481324lfo.6.1684343885003;
        Wed, 17 May 2023 10:18:05 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id j18-20020ac24552000000b004f140788184sm1038284lfm.289.2023.05.17.10.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 10:18:04 -0700 (PDT)
Message-ID: <f6a491ce-57ad-66c8-8fa2-933bf208adac@linaro.org>
Date:   Wed, 17 May 2023 19:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-array
 with flexible-array member
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZGQn63U4IeRUiJWb@work>
 <8f9ca4a1-26ee-cd37-6c15-abdc832d77b3@linaro.org>
In-Reply-To: <8f9ca4a1-26ee-cd37-6c15-abdc832d77b3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 04:11, Konrad Dybcio wrote:
> 
> 
> On 17.05.2023 03:03, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with flexible
>> array members instead. So, replace one-element arrays with flexible-array
>> members in struct hfi_sys_set_resource_pkt, and refactor the rest of
>> the code, accordingly.
>>
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>> routines on memcpy() and help us make progress towards globally
>> enabling -fstrict-flex-arrays=3 [1].
>>
>> The only binary differences seen before/after changes are the
>> following:
>>
>>      17ba:      mov    %rbx,%rdi
>>      17bd:      call   17c2 <pkt_sys_set_resource+0x42>
>>                         17be: R_X86_64_PLT32    __tsan_write4-0x4
>> -    17c2:      movl   $0x14,(%rbx)
>> +    17c2:      movl   $0x10,(%rbx)
>>      17c8:      lea    0x4(%rbx),%rdi
>>      17cc:      call   17d1 <pkt_sys_set_resource+0x51>
>>                         17cd: R_X86_64_PLT32    __tsan_write4-0x4
>>
>> which is expected once this accounts for the following line of code
>> at  drivers/media/platform/qcom/venus/hfi_cmds.c:73
>>
>> 73         pkt->hdr.size = sizeof(*pkt);
>>
>> and as *pkt is of type struct hfi_sys_set_resource_pkt, sizeof(*pkt) is
>> reduced by 4 bytes, due to the flex-array transformation.
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/293
>> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
>>  drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> index 3f74d518ad08..7c82e212434e 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> @@ -83,7 +83,7 @@ int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
>>  		res->size = size;
>>  		res->mem = addr;
>>  		pkt->resource_type = HFI_RESOURCE_OCMEM;
>> -		pkt->hdr.size += sizeof(*res) - sizeof(u32);
>> +		pkt->hdr.size += sizeof(*res);
>>  		break;
>>  	}
>>  	case VIDC_RESOURCE_NONE:
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
>> index ba74d03eb9cd..dd9c5066442d 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
>> @@ -56,7 +56,7 @@ struct hfi_sys_set_resource_pkt {
>>  	struct hfi_pkt_hdr hdr;
>>  	u32 resource_handle;
>>  	u32 resource_type;
>> -	u32 resource_data[1];
>> +	u32 resource_data[];
> Would making this an u32* be a better resolution?
Nevermind, I overthought this by thinking in the terms of its size
and not the data within the struct...

Maybe struct_size could be used instead of subtracting sizeof(u32)
though?

Konrad
> 
> Konrad
>>  };
>>  
>>  struct hfi_sys_release_resource_pkt {
