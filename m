Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1E673637
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjASK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:59:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF14A1C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:59:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id az20so4689232ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7slYj27tWChzBwemc8Nazo6wNsxFYT7zCj0IwHR+spI=;
        b=qoYiPDt4yz409fA5BCm5IBNuCuYqNPhaFPuCSF4zPREAowsIS9Q02/kaXKozSqEueP
         6ne6P5XlksR5l6NSWoqq3hz0KAGQb209ddPqtADsEdJOiv2r8yh+22Dr6YDJOQus/SuH
         eAl2SsQJMHhcEg8Dl9oonqMueVwsaN56Ozbs7Ap4b8DqlgoPAkFxd91kiDcLUm8cib2e
         Kytwdu7LyzRzb3vxwviVLZa1spe5aG1qMIl0HZbW5cchhZS217cvNMuteSvpY4d1FbRR
         Kr5xitYw+ycrUvwnr+Rgwx6NXasvdUbF6zuHfpGCQvdJREGLrz2OQC+VtZQbjIPmf66Z
         xrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7slYj27tWChzBwemc8Nazo6wNsxFYT7zCj0IwHR+spI=;
        b=BAmNVUkQAZ7kdj6U9O28Z8+fmKiGjTfu70xZpakVThZjVL7tYcwpG3prZ75LRMW6Sw
         c6Pk/YcISYQDYFVis83cVVyAmWlsN/6FlWZcfpb8fMv4NWrvZuVgER9c7+fJHa+hdZqW
         7JLqvqqjEIhVzOf26ZHh5GdijLZcuA3rEDROIc/SVPw2DacpTVM/+UH8MDuaqeMVz67o
         lT8pVpQUhcGRoIDmus02o9OwEohWPckIM4TbIzoyZgcuprUzmHCicBOJdxpaGuns5oEu
         q/7Hc3DcEOddpl2Hywb+G8PntDdnwCuqY79TzmQvn43Q9Av+suPc3Y3HGZBF5a+O9d+v
         k/4A==
X-Gm-Message-State: AFqh2kpHA67tMotdoKavVNcrKhI8RprI3WqWAKCFxN9rqow/qyEip2WD
        EIv3geHNxJLrazm04/04R8V4LA==
X-Google-Smtp-Source: AMrXdXvj6utOxXXzgGizreoOrIBdet1ICTfdi3Gn2Y9wxokJdyLfM/EAPD1ANDuUmpUTI0UzmVDr8w==
X-Received: by 2002:a17:906:8608:b0:86b:9216:2ddb with SMTP id o8-20020a170906860800b0086b92162ddbmr10565291ejx.52.1674125957527;
        Thu, 19 Jan 2023 02:59:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o21-20020aa7c7d5000000b0046ac017b007sm15326228eds.18.2023.01.19.02.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:59:17 -0800 (PST)
Message-ID: <a501ead8-7376-6d7d-251a-c468b9759f30@linaro.org>
Date:   Thu, 19 Jan 2023 12:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add sysfs attributes for fields
 in v2-v6
Content-Language: en-GB
To:     Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, Trilok Soni <quic_tsoni@quicinc.com>,
        Shiraz Hashim <quic_shashim@quicinc.com>,
        quic_kaushalk@quicinc.com
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-3-quic_namajain@quicinc.com>
 <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
 <b623e046-8dbc-3a07-7e16-d22b762c4122@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <b623e046-8dbc-3a07-7e16-d22b762c4122@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 11:39, Naman Jain wrote:
> Thanks Dmitry for reviewing the patches. Sorry, for replying late on 
> your email, I wanted to collect all the information, before I do it.
> 
> On 1/12/2023 4:49 AM, Dmitry Baryshkov wrote:
>> On 11/01/2023 10:21, Naman Jain wrote:
>>> Add support in sysfs custom attributes for fields in socinfo version
>>> v2-v6. This is to support SoC based operations in userland scripts
>>> and test scripts. Also, add name mappings for hw-platform type to
>>> make the sysfs information more descriptive.
>>
>> Please include a patch documenting your additions to 
>> Documentation/ABI/testing/sysfs-devices-soc. Please describe usecases 
>> for new attributes and their applicability to non-Qualcomm boards.
>>
> 
> The fields added here, are applicable to Qualcomm boards only. I can 
> include in the same file sysfs-devices-soc, mentioning the same that it 
> is Qcom specific, or I can create a new file for this, 
> sysfs-devices-soc-qcom, however you suggest. Mentioning the use cases, 
> later in the mail.

So, you are extending the generic SoC interface with the vendor-specific 
interfaces. There must be a file describing them in a generic enough way 
that other vendors can apply for their boards too.

Note, that /sys/devices/soc applies to SoC level, not the board level. 
Generally I think that you should export your data through a more 
generic data path, e.g. /sys/firmware.

> 
> 
>> Note, that testing scripts can access debugfs entries without any issues.
> 
> 
> Yes, that is right. Thanks.
> 
> 
>>
>>>
>>> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/socinfo.c | 181 +++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 181 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>>> index 251c0fd94962..ff92064c2246 100644
>>> --- a/drivers/soc/qcom/socinfo.c
>>> +++ b/drivers/soc/qcom/socinfo.c
>>> @@ -41,6 +41,52 @@
>>>    */
>>>   #define SMEM_HW_SW_BUILD_ID            137
>>>   +enum {
>>> +    HW_PLATFORM_UNKNOWN = 0,
>>> +    HW_PLATFORM_SURF = 1,
>>> +    HW_PLATFORM_FFA = 2,
>>> +    HW_PLATFORM_FLUID = 3,
>>> +    HW_PLATFORM_SVLTE_FFA = 4,
>>> +    HW_PLATFORM_SVLTE_SURF = 5,
>>> +    HW_PLATFORM_MTP_MDM = 7,
>>> +    HW_PLATFORM_MTP = 8,
>>> +    HW_PLATFORM_LIQUID = 9,
>>> +    HW_PLATFORM_DRAGON = 10,
>>> +    HW_PLATFORM_QRD = 11,
>>> +    HW_PLATFORM_HRD = 13,
>>> +    HW_PLATFORM_DTV = 14,
>>> +    HW_PLATFORM_RCM = 21,
>>> +    HW_PLATFORM_STP = 23,
>>> +    HW_PLATFORM_SBC = 24,
>>> +    HW_PLATFORM_HDK = 31,
>>> +    HW_PLATFORM_ATP = 33,
>>> +    HW_PLATFORM_IDP = 34,
>>> +    HW_PLATFORM_INVALID
>>> +};
>>> +
>>> +static const char * const hw_platform[] = {
>>> +    [HW_PLATFORM_UNKNOWN] = "Unknown",
>>> +    [HW_PLATFORM_SURF] = "Surf",
>>> +    [HW_PLATFORM_FFA] = "FFA",
>>> +    [HW_PLATFORM_FLUID] = "Fluid",
>>> +    [HW_PLATFORM_SVLTE_FFA] = "SVLTE_FFA",
>>> +    [HW_PLATFORM_SVLTE_SURF] = "SLVTE_SURF",
>>> +    [HW_PLATFORM_MTP_MDM] = "MDM_MTP_NO_DISPLAY",
>>> +    [HW_PLATFORM_MTP] = "MTP",
>>> +    [HW_PLATFORM_RCM] = "RCM",
>>> +    [HW_PLATFORM_LIQUID] = "Liquid",
>>> +    [HW_PLATFORM_DRAGON] = "Dragon",
>>> +    [HW_PLATFORM_QRD] = "QRD",
>>> +    [HW_PLATFORM_HRD] = "HRD",
>>> +    [HW_PLATFORM_DTV] = "DTV",
>>> +    [HW_PLATFORM_STP] = "STP",
>>> +    [HW_PLATFORM_SBC] = "SBC",
>>> +    [HW_PLATFORM_HDK] = "HDK",
>>> +    [HW_PLATFORM_ATP] = "ATP",
>>> +    [HW_PLATFORM_IDP] = "IDP",
>>> +    [HW_PLATFORM_INVALID] = "Invalid",
>>> +};
>>
>> This is not a property of the SoC. It is a property of the device. As 
>> such it should not be part of /sys/bus/soc devices.
> 
> 
> I understand your point. The Socinfo structure as such on Qualcomm SoC 
> gives not just SoC related information but also many other info like 
> serial number, platform subtype etc. Now in order to support the 
> usecases below, we are proposing sysfs interface extension, as we can't 
> use debugfs interface in production/end user devices due to debugfs 
> access restrictions.

"The vendor does it in this way" doesn't give you a right to repurpose 
the ABI.

> 
> Use cases:
> 
> 1. In post-boot shell scripts, for various chip specific operations, 
> that are relevant to that particular chip/board only:
> 
>      a. Setting kernel parameters using sysfs interfaces etc.

If the parameter is common to all devices of some kind, it should be set 
by the driver using the data in the DTS. See, how this is managed for 
PHY tunings. You can not expect for the userspace to function in any 
particular way. The whole userspace might be a single /bin/bash 
executing commands and/or scripts. And still the device should function 
_properly_.

> 
>      b. Enabling particular traces, logs

This should not depend on the device type. If you have something 
hw-specific, check the particular device instance rather than checking 
the board kind.

> 
>      c. Changing permissions to certain paths

Excuse me, what paths? Permissions have nothing to do with the board kind.

> 
>      d. Start a userspace service, and pass custom parameters to it on 
> the fly

I think this also depends on the hardware availability rather than the 
board properties.

> 
>      e. Set certain device properties using setprop

Android specifics. Please formulate this in a generic way.

> 
>      f. Miscellaneous things like DCC (Data Capture and Compare Engine) 
> etc.

Please expand this, you can not expect one to know what is DCC and how 
it is used.

> 
> 2. In userspace services, that depend on SoC information, for its 
> configuration. Eg: Audio, Connectivity services use these.

This is handled using the device ids, models, etc.. Please see, how this 
is handled by other software (hint: ALSA UCM, pulseaudio) instead of 
inventing something vendor-specific.

> 
> 3. adb needs device serial number, sensors need SoC information to 
> decide its configuration.

Already available via /proc/cmdline thanks for your bootloader.

> 
> 
>>
>> You can find board description in /sys/firmware/devicetree/base/model
> 
> 
> Thanks for pointing this out. This is giving useful information on the 
> chip and hw_platform, but the problem is that we need other fields as 
> well, which we may want to use. Hence the ask.
> 
> model = "Qualcomm Technologies, Inc. Kalama MTP";

Generally I think that Qualcomm's socinfo is a kind of firmware 
interface, so you can probably extend /sys/firmware to provide this kind 
of information.

> 
> 
>>
>>> +
>>>   #ifdef CONFIG_DEBUG_FS
>>>   #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
>>>   #define SMEM_IMAGE_VERSION_SIZE                4096
>>> @@ -368,6 +414,140 @@ static const struct soc_id soc_id[] = {
>>>       { qcom_board_id(QRU1062) },
>>>   };
>>>   +/* sysfs attributes */
>>> +#define ATTR_DEFINE(param) \
>>> +    static DEVICE_ATTR(param, 0644, qcom_get_##param, NULL)
>>> +
>>> +/* Version 2 */
>>> +static ssize_t
>>> +qcom_get_raw_id(struct device *dev,
>>> +        struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>>> +             le32_to_cpu(soc_info->raw_id));
>>> +}
>>> +ATTR_DEFINE(raw_id);
>>> +
>>> +static ssize_t
>>> +qcom_get_raw_version(struct device *dev,
>>> +        struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>>> +             le32_to_cpu(soc_info->raw_ver));
>>> +}
>>> +ATTR_DEFINE(raw_version);
>>
>> Why are they raw? can you unraw them?
>>
>> Whose version and id are these attributes referring to?
> 
> 
> So basically, when we call them raw, it essentially means that it is not 
> parsed as such (different bits may be giving different information, and 
> the whole value may mean nothing).
> 
> *version* refers to the chip version, which can be like v1, v2, v1.1 etc 
> in real terms. Its raw value is used to map it to one of these versions. 
> *id* is used as chip ID for QC SoCs for using JTAG. It is different than 
> the soc_id that we have.

Unraw the values.

> 
> 
>>
>>> +
>>> +/* Version 3 */
>>> +static ssize_t
>>> +qcom_get_hw_platform(struct device *dev,
>>> +        struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    uint32_t hw_plat = le32_to_cpu(soc_info->hw_plat);
>>> +
>>> +    hw_plat = (hw_plat >= HW_PLATFORM_INVALID) ? HW_PLATFORM_INVALID 
>>> : hw_plat;
>>> +    return scnprintf(buf, PAGE_SIZE, "%-.32s\n",
>>> +            hw_platform[hw_plat]);
>>> +}
>>> +ATTR_DEFINE(hw_platform);
>>> +
>>> +/* Version 4 */
>>> +static ssize_t
>>> +qcom_get_platform_version(struct device *dev,
>>> +        struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>>> +             le32_to_cpu(soc_info->plat_ver));
>>> +}
>>> +ATTR_DEFINE(platform_version);
>>> +
>>> +/* Version 5 */
>>> +static ssize_t
>>> +qcom_get_accessory_chip(struct device *dev,
>>> +        struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>>> +            le32_to_cpu(soc_info->accessory_chip));
>>> +}
>>> +ATTR_DEFINE(accessory_chip);
>>
>> If this an _accessory_ chip, there should be a separate soc device 
>> describing it, rather than stuffing information into the soc0.
>>
> 
> This is used as a boolean currently to tell us whether SoC has an 
> accessory chip or not.

SoC doesn't have accessory chip. It the board having the accessory (to 
the main SoC) or not.

Also, please do not use 'currently' for the sysfs files. They are ABI. 
And changing ABI is a painful process which might be not available at 
all. So once you export something through the sysfs, it is written in 
stone. Not 'currently, to be changed later'.

> 
> 
>>> +
>>> +/* Version 6 */
>>> +static ssize_t
>>> +qcom_get_platform_subtype_id(struct device *dev,
>>> +        struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>>> +             le32_to_cpu(soc_info->hw_plat_subtype));
>>> +}
>>> +ATTR_DEFINE(platform_subtype_id);
>>
>> Again, this is the board property, not an SoC one.
> 
> 
> Same justification as one of my previous comments.

Same comment. /sys/bus/soc exists to export information about, you 
guess, SoC. If you want to export information about the board, please 
find a better way.


-- 
With best wishes
Dmitry

