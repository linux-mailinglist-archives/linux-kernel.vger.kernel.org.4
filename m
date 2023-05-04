Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9C6F68CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjEDKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEDKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:03:11 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D524C2D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:03:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac7847839eso3221751fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683194586; x=1685786586;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUjsjGTbqIUYScp9njKat3CizREnO8jx2KX+bdN1BJY=;
        b=CPobskDKj4JOvCKQUhjMFk2j+rNgdljiKRXgs3ZimA3rWp6MFfWF4W5OKEmxFXaUbs
         NZzNy5rpxac1ArkeQbAmqlB6CwCPj15pbQnUja1zgKE8vk9kACCAXaNvVU7+lYUYFJCC
         ECpQoVYzaV/05wKu3Rbmzr1p/vyWC3ZRu9AXgzHqtIlJEdNGGdeHh87tesWu4SzDL4Z4
         YmKuOzmUDQe5Yio2jNXxNaOSvEDE8NIB/wke23lrsLaTpCJ2QHyd9WUD2TUXY45B9gaV
         o5YZQEx3ERgl870yiDXFjmu/IYwiKAPgCIiJG+ycMtnRyS7EqaeA1eNO16QxmJltGJBn
         clgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683194586; x=1685786586;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUjsjGTbqIUYScp9njKat3CizREnO8jx2KX+bdN1BJY=;
        b=C1a7cxe+0pfAY44qYpBWe1Tk8F63NVNF3AxmnaEom+MppHBUN2z29P7MGE6rGi3rCf
         ybBwvT6+g0mKBKon+sCim4gdAJrPqlBAvcvpWu8MMA9L6yTvML1hegibgJvpsl+EUapy
         QQYW8+VhBrbyJqGfCW1sLzKQPZxNLmp6TmdQDAQgEgsxkL7VyaxBMaa4iQeJVB5/Mwrz
         fv3uoVy4pYc+AFG1A2DnsSJg9EdCfWlDr5SPdTFk5gGh4gXprgOhG3mlO92nP0BvCuTO
         Y7pFfDU1r0nHBWyutnlUW23kCqcBQpgQ/WiwaDWP7Vu3dAe641HgxExGJ+8Gb5iLl8Bj
         WWlQ==
X-Gm-Message-State: AC+VfDxbeg5sbd97q9KkVwO0qoyNEJi9GeDFB7tJ8AVDFCHjoqeJkG5B
        iAsX3U6xqGq4vkX/+BwehJLMXg==
X-Google-Smtp-Source: ACHHUZ4OM3+BDd3VMsH9rAG/LXoVUh12dUYOeg15PSF7P2vyTthIJZf1ZbobVtmp54OmFpOnxdkHfw==
X-Received: by 2002:a2e:b003:0:b0:2ac:798d:1529 with SMTP id y3-20020a2eb003000000b002ac798d1529mr728777ljk.29.1683194586479;
        Thu, 04 May 2023 03:03:06 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id i14-20020a2e864e000000b002a9f9c358d4sm6352511ljj.111.2023.05.04.03.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:03:06 -0700 (PDT)
Message-ID: <bb2e9963-54da-8314-5eea-d6619108b2c3@linaro.org>
Date:   Thu, 4 May 2023 12:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
 <1683193152-5808-2-git-send-email-quic_dikshita@quicinc.com>
 <966416d1-3ddd-26ba-63ec-2323062dfda5@linaro.org>
 <2a8e6199-179d-ac66-5ce6-d014d5534819@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 1/3] venus: add firmware version based check
In-Reply-To: <2a8e6199-179d-ac66-5ce6-d014d5534819@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 11:49, Dikshita Agarwal wrote:
> 
> On 5/4/2023 3:12 PM, Konrad Dybcio wrote:
>>
>> On 4.05.2023 11:39, Dikshita Agarwal wrote:
>>> Add firmware version based checks to enable/disable
>>> features for different SOCs.
>>>
>>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>>> ---
>>>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 27 +++++++++++++++++++++++++--
>>>   2 files changed, 45 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>>> index 32551c2..2f2176f 100644
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
>>>   +static inline bool
>>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>>> +{
>>> +    return ((core)->venus_ver.major == vmajor &&
>>> +        (core)->venus_ver.minor == vminor &&
>>> +        (core)->venus_ver.rev >= vrev);
>>> +}
>>> +
>>> +static inline bool
>>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>>> +{
>>> +    return ((core)->venus_ver.major == vmajor &&
>>> +        (core)->venus_ver.minor == vminor &&
>>> +        (core)->venus_ver.rev <= vrev);
>>> +}
>>>   #endif
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> index df96db3..4854863 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> @@ -248,13 +248,16 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
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
>>>       size_t smem_blk_sz;
>>> +    int ret;
>>> +    u8 *ver_str;
>>>         req_bytes = pkt->hdr.size - sizeof(*pkt);
>>>   @@ -263,6 +266,26 @@ sys_get_prop_image_version(struct device *dev,
>>>           return;
>>>         img_ver = pkt->data;
>>> +    if (IS_V6(core) && core->res->num_vpp_pipes == 1) {
>>> +        ret = sscanf(img_ver, "14:video-firmware.%u.%u-%u",
>>> +                 &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>> This is still not perfect, 8350 has 4 vpp pipes and its firmware is
>> also denominated with "video-firmware".. perhaps we can just try
>> each variant until we reach ret == 3?
> 
> sc7280 onward firmware have image string as "video-firmware".
> 
> Support for 8350 is not yet added in venus driver, any required change for the same can be done
> 
> when support will be added for the same.
I understand, but that doesn't mean this can't be improved:

ret = sscanf(.. video-firmware .. )
if (ret == 2) {
	/* video-firmware string doesn't provide rev info */
	ver.rev = (something);
	goto done;
}

ret = sscanf(.. VIDEO.VE .. )
if (ret == 3)
	goto done;

ret = sscanf(.. VIDEO.VPU .. )
if (ret != 3) {
	/* We ran out of options! */
	return -EINVAL;
}

done:
	// continue the code flow


> 
>>> +        if (ret != 2) {
>> 3?
> 
> this image version string doesn't return valid revision hence checking against 2 (major and minor versions)
So why are you filling the revision field with an invalid value?

let's take a version string from a firmware I have on hand:

14:video-firmware.1.0-3fb5add1d3ac96f8f74facd537845a6ceb5a99e4

this will evaluate to:

maj = 1
min = 0
rev = 3

since it's incorrect, drop the last argument and initialize it with
something like UINT_MAX or 0xdeadbeef

On a note, you left ver_str unused in this patch, so it doesn't work
for VIDEO.VPU anyway

Konrad
> 
> Thanks,
> 
> Dikshita
> 
>>
>> Konrad
>>> +            dev_dbg(dev, VDBGL "error reading F/W version\n");
>>> +            return;
>>> +        }
>>> +    } else {
>>> +        if (IS_V6(core))
>>> +            ver_str = "14:VIDEO.VPU.%u.%u-%u";
>>> +        else
>>> +            ver_str = "14:VIDEO.VE.%u.%u-%u";
>>> +
>>> +        ret = sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u",
>>> +                 &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>>> +        if (ret != 3) {
>>> +            dev_dbg(dev, VDBGL "error reading F/W version\n");
>>> +            return;
>>> +        }
>>> +    }
>>>         dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>>>   @@ -286,7 +309,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>>>         switch (pkt->property) {
>>>       case HFI_PROPERTY_SYS_IMAGE_VERSION:
>>> -        sys_get_prop_image_version(dev, pkt);
>>> +        sys_get_prop_image_version(core, pkt);
>>>           break;
>>>       default:
>>>           dev_dbg(dev, VDBGL "unknown property data\n");
