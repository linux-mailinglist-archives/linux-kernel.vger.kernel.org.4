Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4B6E17CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDMXBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDMXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:01:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2110CE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:01:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bi41so3072545lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681426870; x=1684018870;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDbMy6pQwCkgyZ7gS+ySEIiMO6GFUQWvHdlS77zoO0U=;
        b=PGVxbY+vutnOMMThgqmDGmagf5KKahGnTYQepG4Lg2ckeRBUPZdXfu9+bIQO4jqk5k
         kU0XSWtg8v5su/HKcgCvcFfXvfw25GzmH20COWgLA1VuNIbhceD9hCoAlMHA4FDwHoAN
         O5PJlgUOMCpsEX7EQ1y67rV2ZNw+UM+GtAZmvRsQvm2irtYAxkwt4S3dMRoAXIWkCJNG
         bH9o1gQRZF1x98SLPSCgewOClOEIHQMOtUrfqFAJ2gKtpiPp/vvjVUQtcNszF/NamNIC
         bWHCLhMbnJM75Y9V1ULg9HJEbIbP8rej+rtXWOdBXmigne149/DNJvg3lqgYd3T6tJNf
         v0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681426870; x=1684018870;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDbMy6pQwCkgyZ7gS+ySEIiMO6GFUQWvHdlS77zoO0U=;
        b=PbiLmy8/4XCd0zYPftYzeFe1Ugv1x+2Xg5ZL2lGAB4HYuoDRJ3mKLKf7nDzNeb4sKs
         Bp3WPdG+WUfHQynQ0TMF+YygXh1fgIEwJXiOP7bMWLT/J8+c+ZIybLsHSPr5Q89zpjKa
         k/pkerdwl0eAf1ammrgCwCyYx/fRVJbkkaBr72SjV6qcdk9hjb7Ms1XIKY88vRyIuM3N
         4Ru890qOESHDeMjg4W/IyrMMiByrYLSX43yyZJgHWf0g/epFuBvE9omFa2jb5rG4iZIK
         UH3Uc2YpXzzkCuAgRkUzLoxasKk1ticlh1QvqVpj0ynkoc5M8agja+DUsT85pXMXzHx3
         tBmA==
X-Gm-Message-State: AAQBX9fihWKqUWKVxshIAlY1xB61FuLpzfjAalAD5p4LyOYEm5lYc+Bj
        yXUAgi2uecMLGnYC6aIVEz3FuA==
X-Google-Smtp-Source: AKy350bRmxl3PJ1vK1lQRdfuK4vz5JaRv95hJQtwgY3WFx7Gvu9ouzQNAbH7Z+bBvz+N7nLfrsSJ2w==
X-Received: by 2002:a05:6512:96d:b0:4e8:49ff:8df8 with SMTP id v13-20020a056512096d00b004e849ff8df8mr1418567lft.61.1681426870138;
        Thu, 13 Apr 2023 16:01:10 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id r8-20020ac24d08000000b004b4b600c093sm505607lfi.92.2023.04.13.16.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 16:01:09 -0700 (PDT)
Message-ID: <89fc0a9c-0eee-44c4-52a4-bfa0009b9cce@linaro.org>
Date:   Fri, 14 Apr 2023 01:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] venus: add firmware version based check
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
 <6c3002ad-ff78-8818-0e68-a151d33b0fca@gmail.com>
 <0b5d967d-b6f5-ed1e-1878-160d6e645f02@linaro.org>
In-Reply-To: <0b5d967d-b6f5-ed1e-1878-160d6e645f02@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 12:59, Konrad Dybcio wrote:
> 
> 
> On 9.04.2023 07:18, Stanimir Varbanov wrote:
>> Hi Dikshita,
>>
>> Thanks for the patch.
>>
>> On 7.04.23 г. 9:25 ч., Dikshita Agarwal wrote:
>>> Add firmware version based checks to enable/disable
>>> features for different SOCs.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>>> ---
>>>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>>>   2 files changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>>> index 32551c2..9d1e4b2 100644
>>> --- a/drivers/media/platform/qcom/venus/core.h
>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>> @@ -202,6 +202,11 @@ struct venus_core {
>>>       unsigned int core0_usage_count;
>>>       unsigned int core1_usage_count;
>>>       struct dentry *root;
>>> +    struct venus_img_version {
>>> +        u32 major;
>>> +        u32 minor;
>>> +        u32 rev;
>>> +    } venus_ver;
>>>   };
>>>     struct vdec_controls {
>>> @@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>>>       return NULL;
>>>   }
>>>   +static inline int
>>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>>> +{
>>> +    return ((core)->venus_ver.major == vmajor &&
>>> +        (core)->venus_ver.minor == vminor &&
>>> +        (core)->venus_ver.rev >= vrev);
>>> +}
>>> +
>>> +static inline int
>>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>>> +{
>>> +    return ((core)->venus_ver.major == vmajor &&
>>> +        (core)->venus_ver.minor == vminor &&
>>> +        (core)->venus_ver.rev <= vrev);
>>> +}
>>
>> IMO those two should return bool
>>
>>>   #endif
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> index df96db3..07ac0fc 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>>>   }
>>>     static void
>>> -sys_get_prop_image_version(struct device *dev,
>>> +sys_get_prop_image_version(struct venus_core *core,
>>>                  struct hfi_msg_sys_property_info_pkt *pkt)
>>>   {
>>> +    struct device *dev = core->dev;
>>>       u8 *smem_tbl_ptr;
>>>       u8 *img_ver;
>>>       int req_bytes;
>>> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>>>           return;
>>>         img_ver = pkt->data;
>>> +    if (IS_V4(core))
>>> +        sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
>>> +               &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>>> +    else if (IS_V6(core))
>>> +        sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
>>> +               &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>>>   
>>
>> what about if IS_V1?
> Whooops, I missed that in my review as well...
> 
> Looks like the 8916 and 8996 FWs fall under the VIDEO.VE case
> as well, that's the QC_VERSION_STRING they have..
On top of that, my 8350 fw reports:

F/W version: 14:video-firmware.1.0-3fb5add1d3ac96f8f74facd537845a6ceb5a99e4

Konrad
> 
> Perhaps this could be an 
> 
> if (IS_V6)
> 	..
> else
> 	..
> 
> Konrad
>>
>>>       dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>>
>> this will crash for v1.
>>
>>>   @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>>>         switch (pkt->property) {
>>>       case HFI_PROPERTY_SYS_IMAGE_VERSION:
>>> -        sys_get_prop_image_version(dev, pkt);
>>> +        sys_get_prop_image_version(core, pkt);
>>>           break;
>>>       default:
>>>           dev_dbg(dev, VDBGL "unknown property data\n");
>>
