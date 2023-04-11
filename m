Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870706DD87A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDKK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDKK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:59:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B0BE79
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:59:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r27so9896515lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681210753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kazWNG45egAg9Td+uttQJ57w+ox1iZun1R7CnDhH38=;
        b=G6wcweLZdCpR9+r41llXcaTE118fQHBEmDGEp24aIBwYc2+uDqChb8jt5KOAm3ZGaQ
         +rcDmC4yHaR0P1P6x6J+pJ9hHCSjgdCN374BD0sZzrEZuv34D60C/vqrCBfwiSeVuYCb
         sjQx/qw1ZAU0i61FKfDPfK3yF8aojlVQsgNCnYaMNId/Z2HUdfdKTVmQdgr4qPjN7Vch
         IOBJRjjSx2Lz4ViCczfoa/8RfrRgZEjKV2gwwSnRscZvy8ITPAEX6wKSg02Heg3w+H1X
         rCNWNHBPOtG33VvX7hK10y0ukqFvtO39epXfs7WtmsL6CqbCiNUsRGJFznsbWg5282zi
         vHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681210753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kazWNG45egAg9Td+uttQJ57w+ox1iZun1R7CnDhH38=;
        b=q4mKcPH2MhOipCbv8tuHkp2K0SD8kCNgrwVC7akf1eKxgS4edGUyKoBrqwy/q3nJYD
         Kx/h50Wp6WZpPTCtcAUj4TwrFldxNkWUmGFvER+F9yYtdj8RdAWwSgDClUH3J/W+5AhA
         M82oyHwVgMnUuyLhbtZ+NpgmW27YObKU+3hpEdt+7cBQnDJiuTxXbaDIi3+Tlk88h0Wc
         snvimryuFNTtl8sJd+4RXhcMiycsKtwXJ0spzy4vtBPMdyZaVj4mzMVXGz9E5a5u94pj
         GVCz8d2M1uZh43wigIJmoTCJrEl/f/3//o83NF6ll6OO0UkKkDjgaallufracUvaxWwC
         WqMw==
X-Gm-Message-State: AAQBX9fsi+PzYjMYhCFnpEnnIn6TDIKTEI18SIIRrosFjoSpfaN1Xfdt
        PUm+/WEDtyVg0cwDCvVejtdZWQ==
X-Google-Smtp-Source: AKy350a+03egxi9cadxmrzO5rzSeZnkjey8RrjMlnOsjsT3Pbv8A9VUFw4aI9hrtq1QWJfPbeQ4baw==
X-Received: by 2002:a19:ad46:0:b0:4ea:fa26:2378 with SMTP id s6-20020a19ad46000000b004eafa262378mr2339674lfd.23.1681210753385;
        Tue, 11 Apr 2023 03:59:13 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b0029ee7bc0114sm2643288ljk.64.2023.04.11.03.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 03:59:13 -0700 (PDT)
Message-ID: <0b5d967d-b6f5-ed1e-1878-160d6e645f02@linaro.org>
Date:   Tue, 11 Apr 2023 12:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] venus: add firmware version based check
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
 <6c3002ad-ff78-8818-0e68-a151d33b0fca@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6c3002ad-ff78-8818-0e68-a151d33b0fca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.04.2023 07:18, Stanimir Varbanov wrote:
> Hi Dikshita,
> 
> Thanks for the patch.
> 
> On 7.04.23 г. 9:25 ч., Dikshita Agarwal wrote:
>> Add firmware version based checks to enable/disable
>> features for different SOCs.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>>   2 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2..9d1e4b2 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -202,6 +202,11 @@ struct venus_core {
>>       unsigned int core0_usage_count;
>>       unsigned int core1_usage_count;
>>       struct dentry *root;
>> +    struct venus_img_version {
>> +        u32 major;
>> +        u32 minor;
>> +        u32 rev;
>> +    } venus_ver;
>>   };
>>     struct vdec_controls {
>> @@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>>       return NULL;
>>   }
>>   +static inline int
>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +    return ((core)->venus_ver.major == vmajor &&
>> +        (core)->venus_ver.minor == vminor &&
>> +        (core)->venus_ver.rev >= vrev);
>> +}
>> +
>> +static inline int
>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +    return ((core)->venus_ver.major == vmajor &&
>> +        (core)->venus_ver.minor == vminor &&
>> +        (core)->venus_ver.rev <= vrev);
>> +}
> 
> IMO those two should return bool
> 
>>   #endif
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> index df96db3..07ac0fc 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>>   }
>>     static void
>> -sys_get_prop_image_version(struct device *dev,
>> +sys_get_prop_image_version(struct venus_core *core,
>>                  struct hfi_msg_sys_property_info_pkt *pkt)
>>   {
>> +    struct device *dev = core->dev;
>>       u8 *smem_tbl_ptr;
>>       u8 *img_ver;
>>       int req_bytes;
>> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>>           return;
>>         img_ver = pkt->data;
>> +    if (IS_V4(core))
>> +        sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
>> +               &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>> +    else if (IS_V6(core))
>> +        sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
>> +               &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>>   
> 
> what about if IS_V1?
Whooops, I missed that in my review as well...

Looks like the 8916 and 8996 FWs fall under the VIDEO.VE case
as well, that's the QC_VERSION_STRING they have..

Perhaps this could be an 

if (IS_V6)
	..
else
	..

Konrad
> 
>>       dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
> 
> this will crash for v1.
> 
>>   @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>>         switch (pkt->property) {
>>       case HFI_PROPERTY_SYS_IMAGE_VERSION:
>> -        sys_get_prop_image_version(dev, pkt);
>> +        sys_get_prop_image_version(core, pkt);
>>           break;
>>       default:
>>           dev_dbg(dev, VDBGL "unknown property data\n");
> 
