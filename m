Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26D66E211C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjDNKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:40:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F70E57
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:40:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so2637528a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681468814; x=1684060814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs0P23ZMO+LruuNwmypPjWabWjGS7nfftHA6CsPpU3M=;
        b=jkdUqXwP/irlgk5X0L2xgpFA5rfHiRv/3UVA7aBwaeMkOvaavcJQAQ1vfQWoWqrlkF
         GMBeT4f1ZG4bhVjRWEln/QmvebFimgEnaPqOMaldF16NFVzxUAHqsZqqi9Gv+iZPIfD7
         PjKBt5U90vIyv7JZqP40SPx7ImWH9Vwi1blJVceTWDlwpkumVsLUUgiWKhXMfXOcG1SN
         CPUgef7U5A2vimVwq48UG2Q+8ie03gDBJrmztc0Pj1UWLla++t8LJUSiv2jERPPkuqZp
         9twpZfx6BPkYFnckD8+qn5lYQAtQ4FE+hX2j+msD3eiNmkRpAn469XoJ1HnCP8rCPWgj
         5rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468814; x=1684060814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs0P23ZMO+LruuNwmypPjWabWjGS7nfftHA6CsPpU3M=;
        b=PtYk/XW6CjyESl75SR9Tj4OrJAHHHDy+M/QkqCqiEx09cBEzEwJASVU1bPNxCSMtYY
         6B4s2LduWkGQ4WqeU1v1BSU+76jh3s41dxedwkzsogXXqreuGvINUWojr3G9o4opJx9M
         fGd6HIwVgNDAZk9OVjBwLEr5KwQJb4Cr5GZEM92/UBNz5jeLOi0EG/Y0iCJrrRgryafi
         H+xHbkE1/R3nF92rFv1zDrNwPdceMJnE5AGn3H2joEbbHtjs9BbKfuUHLDAuPr6zxtZn
         wRKvqt7A0E+x5WzrjcLATV7ravtcuM5dxvUY5XPnNWq+BXujz0VVI/iC1HoRam4u6m7r
         L5XQ==
X-Gm-Message-State: AAQBX9fBLA/vog7M+nUyqZfeg2AYyUAX6AgbqBtS4g3ticLPJ1xXtpx0
        HWQ+VNNeP2Uf0VHK3l3dEuIh6w==
X-Google-Smtp-Source: AKy350Zjnj1pJcAKCjydAyDOPIDl8TWOzZxFqLViTsFC+JZdNjbRiyVmqNFwdFPvnkuen5hUTjDP0Q==
X-Received: by 2002:a05:6402:382:b0:502:67b6:9734 with SMTP id o2-20020a056402038200b0050267b69734mr6105712edv.6.1681468814512;
        Fri, 14 Apr 2023 03:40:14 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056402100900b0050508605c1dsm1958172edu.37.2023.04.14.03.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:40:13 -0700 (PDT)
Message-ID: <040a1992-baff-c3e4-69a9-ff3110de62e7@linaro.org>
Date:   Fri, 14 Apr 2023 11:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/6] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-3-git-send-email-quic_mojha@quicinc.com>
 <e74fb30d-4268-86b1-cdf7-ad3d104c6c40@linaro.org>
 <3df1ec27-7e4d-1f84-ff20-94e8ea91c86f@quicinc.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <3df1ec27-7e4d-1f84-ff20-94e8ea91c86f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 08:05, Mukesh Ojha wrote:
> Thanks again for coming back on this.
> 
> On 4/14/2023 4:02 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 22/03/2023 13:30, Mukesh Ojha wrote:
>>> Move minidump specific data types and macros to a separate internal
>>> header(qcom_minidump.h) so that it can be shared among different
>>
>> minidump.h should be good as we are already in include/soc/qcom/
> 
> 
> Initially, i wanted to protect the content of qcom_minidump.h between 
> qcom_minidump.c and qcom_common.c
> 
> Ideally, here qcom_minidump.h should be supplier/provider header and can 

Am not sure if I understand the supplier concept correctly.
AFAIU, we have a 2 sets of apis

1. get hold of minidump descriptor based on minidump_id fro gtoc using 
qcom_minidump_subsystem_desc(). Am assuming which ever driver uses this 
api will set there segments and regions in there respective drivers.

2. setting regions/segments in APSS minidump descriptors which are done 
via qcom_minidump_region_register(). TBH this should be renamed to 
qcom_apss_minidump_region_register().

mixing of thsee apis makes it bit confusing, specially we have these two 
category of apis that deal with different things.

Does it make sense to spit and abstract them properly by doing?


1. minidump driver to deal with handling gtoc and providing descriptors 
to the consumers like remoteproc or apss, This can probably live within 
smem driver as loc for this support is very minimal and proabably rename 
the api accordingly.

2. apss_minidump driver to allow other qcom drivers to 
register/unregister regions within apss minidump descriptor.

did I miss something?

thanks,
Srini

> be shared among above qcom_minidump.c and qcom_common.c but since they 
> are not in same directory, moved it inside include/soc/qcom/ as separate 
> header than consumer header minidump.h . >
> -Mukesh
>>
>> --srini
>>
>>> Qualcomm drivers.
>>>
>>> There is no change in functional behavior after this.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>>   drivers/remoteproc/qcom_common.c | 56 
>>> +---------------------------------
>>>   include/soc/qcom/qcom_minidump.h | 66 
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 67 insertions(+), 55 deletions(-)
>>>   create mode 100644 include/soc/qcom/qcom_minidump.h
>>>
>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>> b/drivers/remoteproc/qcom_common.c
>>> index 805e525..88fc984 100644
>>> --- a/drivers/remoteproc/qcom_common.c
>>> +++ b/drivers/remoteproc/qcom_common.c
>>> @@ -18,6 +18,7 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/soc/qcom/mdt_loader.h>
>>>   #include <linux/soc/qcom/smem.h>
>>> +#include <soc/qcom/qcom_minidump.h>
>>>   #include "remoteproc_internal.h"
>>>   #include "qcom_common.h"
>>> @@ -26,61 +27,6 @@
>>>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, 
>>> subdev)
>>>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, 
>>> subdev)
>>> -#define MAX_NUM_OF_SS           10
>>> -#define MAX_REGION_NAME_LENGTH  16
>>> -#define SBL_MINIDUMP_SMEM_ID    602
>>> -#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' << 
>>> 8 | 'I' << 0)
>>> -#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' << 
>>> 8 | 'E' << 0)
>>> -#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 8 
>>> | 'L' << 0)
>>> -
>>> -/**
>>> - * struct minidump_region - Minidump region
>>> - * @name        : Name of the region to be dumped
>>> - * @seq_num:        : Use to differentiate regions with same name.
>>> - * @valid        : This entry to be dumped (if set to 1)
>>> - * @address        : Physical address of region to be dumped
>>> - * @size        : Size of the region
>>> - */
>>> -struct minidump_region {
>>> -    char    name[MAX_REGION_NAME_LENGTH];
>>> -    __le32    seq_num;
>>> -    __le32    valid;
>>> -    __le64    address;
>>> -    __le64    size;
>>> -};
>>> -
>>> -/**
>>> - * struct minidump_subsystem - Subsystem's SMEM Table of content
>>> - * @status : Subsystem toc init status
>>> - * @enabled : if set to 1, this region would be copied during coredump
>>> - * @encryption_status: Encryption status for this subsystem
>>> - * @encryption_required : Decides to encrypt the subsystem regions 
>>> or not
>>> - * @region_count : Number of regions added in this subsystem toc
>>> - * @regions_baseptr : regions base pointer of the subsystem
>>> - */
>>> -struct minidump_subsystem {
>>> -    __le32    status;
>>> -    __le32    enabled;
>>> -    __le32    encryption_status;
>>> -    __le32    encryption_required;
>>> -    __le32    region_count;
>>> -    __le64    regions_baseptr;
>>> -};
>>> -
>>> -/**
>>> - * struct minidump_global_toc - Global Table of Content
>>> - * @status : Global Minidump init status
>>> - * @md_revision : Minidump revision
>>> - * @enabled : Minidump enable status
>>> - * @subsystems : Array of subsystems toc
>>> - */
>>> -struct minidump_global_toc {
>>> -    __le32                status;
>>> -    __le32                md_revision;
>>> -    __le32                enabled;
>>> -    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>>> -};
>>> -
>>>   struct qcom_ssr_subsystem {
>>>       const char *name;
>>>       struct srcu_notifier_head notifier_list;
>>> diff --git a/include/soc/qcom/qcom_minidump.h 
>>> b/include/soc/qcom/qcom_minidump.h
>>> new file mode 100644
>>> index 0000000..84c8605
>>> --- /dev/null
>>> +++ b/include/soc/qcom/qcom_minidump.h
>>> @@ -0,0 +1,66 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Qualcomm minidump shared data structures and macros
>>> + *
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>> reserved.
>>> + */
>>> +
>>> +#ifndef _QCOM_MINIDUMP_H_
>>> +#define _QCOM_MINIDUMP_H_
>>> +
>>> +#define MAX_NUM_OF_SS           10
>>> +#define MAX_REGION_NAME_LENGTH  16
>>> +#define SBL_MINIDUMP_SMEM_ID    602
>>> +#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' << 
>>> 8 | 'I' << 0)
>>> +#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' << 
>>> 8 | 'E' << 0)
>>> +#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 8 
>>> | 'L' << 0)
>>> +
>>> +/**
>>> + * struct minidump_region - Minidump region
>>> + * @name        : Name of the region to be dumped
>>> + * @seq_num:        : Use to differentiate regions with same name.
>>> + * @valid        : This entry to be dumped (if set to 1)
>>> + * @address        : Physical address of region to be dumped
>>> + * @size        : Size of the region
>>> + */
>>> +struct minidump_region {
>>> +    char    name[MAX_REGION_NAME_LENGTH];
>>> +    __le32    seq_num;
>>> +    __le32    valid;
>>> +    __le64    address;
>>> +    __le64    size;
>>> +};
>>> +
>>> +/**
>>> + * struct minidump_subsystem - Subsystem's SMEM Table of content
>>> + * @status : Subsystem toc init status
>>> + * @enabled : if set to 1, this region would be copied during coredump
>>> + * @encryption_status: Encryption status for this subsystem
>>> + * @encryption_required : Decides to encrypt the subsystem regions 
>>> or not
>>> + * @region_count : Number of regions added in this subsystem toc
>>> + * @regions_baseptr : regions base pointer of the subsystem
>>> + */
>>> +struct minidump_subsystem {
>>> +    __le32    status;
>>> +    __le32    enabled;
>>> +    __le32    encryption_status;
>>> +    __le32    encryption_required;
>>> +    __le32    region_count;
>>> +    __le64    regions_baseptr;
>>> +};
>>> +
>>> +/**
>>> + * struct minidump_global_toc - Global Table of Content
>>> + * @status : Global Minidump init status
>>> + * @md_revision : Minidump revision
>>> + * @enabled : Minidump enable status
>>> + * @subsystems : Array of subsystems toc
>>> + */
>>> +struct minidump_global_toc {
>>> +    __le32                status;
>>> +    __le32                md_revision;
>>> +    __le32                enabled;
>>> +    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>>> +};
>>> +
>>> +#endif  /* _QCOM_MINIDUMP_H_ */
