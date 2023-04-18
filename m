Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417776E6693
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjDRODJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDRODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:03:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F6A13C04
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:03:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f17b967bfbso8529285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681826580; x=1684418580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dN7o3UP/8Ao66FSvmdNpzzSQHj/Mh8nRWTpz1hPrNo=;
        b=FuUrP7BM015JZUf6hSRffuAcqb/unMMZQh0YBPISalK5+6DUo7gCi54O5BuG0njui7
         qBR9jxEuXfMxXBpk7+vUD7lSGs20ERHZcvMuq6M/wAV0piHAbVqpY8raZqb07HEKolHX
         4xHEHeqGub4tUzV3EvSI9zMdsXgLNv0hlsAUH6437woRbvLarb0CQfacj2kqjt49tb1P
         JooJKMnUJ5t1MOawH7M1UIwGK0wRQJHYFVWF3Zv5pILWMr8f8zoD7GAwTf6E5A4ZP3Sj
         Sg3sKPqEbU090CRq/Lc02a+l8EutKPiILdBWE6RbOoAzX8KAYCR5p/iIv/I6dpeYJjwl
         8LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681826580; x=1684418580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dN7o3UP/8Ao66FSvmdNpzzSQHj/Mh8nRWTpz1hPrNo=;
        b=ijhOtEAc5+khQQDxQPcSvVWeosPsfGxwLhhHdgSdtI4klpPZD8Ls3sZ2P0JvjeWRDp
         IQtyoGxjOryACF90urx2w3NFBgcIm+uNpUTqzE9BGrwdf9YL3NhG1UWatnNGgkQuSHvP
         gjGnlpy6eHvMAvxD/IfLaERSvYA7Jt18CE7yyRmcoHemiKeIYJiHzVGEnNJ4HzTgyQ1r
         LT8qqt0zoUJgD5G3zEJdESShRqzk5L9KNyESoC/buRhq1uhslHAXRGvNccc3fP2bHP4c
         bQS7DWG7D0v8QlQs8Pv0hE0EDn3oxs1GLeRLcKIYyrxqHwwcO2+C+r8J5rIiDrk90Qfm
         M5dg==
X-Gm-Message-State: AAQBX9fTr/tPeORPQWQsCUfBIobUoxxtVm0Ns5Q3HGuqy7j5cAYSglDi
        wAnyc6p4/Lc28q7I1BTl6PQIUg==
X-Google-Smtp-Source: AKy350ZgZ7a9inQ+l/9iKwTimjDQqbaqVtdJwumC2sGEGjekSVfmNsKwCmgKRfTyDkxoQzm1pafHmQ==
X-Received: by 2002:a05:6000:100f:b0:2fd:c315:bb2c with SMTP id a15-20020a056000100f00b002fdc315bb2cmr1480122wrx.22.1681826580003;
        Tue, 18 Apr 2023 07:03:00 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id w16-20020a5d6810000000b002e5ff05765esm13281414wru.73.2023.04.18.07.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:02:59 -0700 (PDT)
Message-ID: <f74dfcde-e59b-a9b3-9bbc-a8de644f6740@linaro.org>
Date:   Tue, 18 Apr 2023 15:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/6] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
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
 <040a1992-baff-c3e4-69a9-ff3110de62e7@linaro.org>
 <a33e2d43-d6a6-f830-8421-ec68baf8159d@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <a33e2d43-d6a6-f830-8421-ec68baf8159d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/04/2023 14:22, Mukesh Ojha wrote:
> 
> 
> On 4/14/2023 4:10 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 14/04/2023 08:05, Mukesh Ojha wrote:
>>> Thanks again for coming back on this.
>>>
>>> On 4/14/2023 4:02 AM, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 22/03/2023 13:30, Mukesh Ojha wrote:
>>>>> Move minidump specific data types and macros to a separate internal
>>>>> header(qcom_minidump.h) so that it can be shared among different
>>>>
>>>> minidump.h should be good as we are already in include/soc/qcom/
>>>
>>>
>>> Initially, i wanted to protect the content of qcom_minidump.h between 
>>> qcom_minidump.c and qcom_common.c
>>>
>>> Ideally, here qcom_minidump.h should be supplier/provider header and can 
>>
>> Am not sure if I understand the supplier concept correctly.
>> AFAIU, we have a 2 sets of apis
>>
>> 1. get hold of minidump descriptor based on minidump_id fro gtoc using 
>> qcom_minidump_subsystem_desc(). Am assuming which ever driver uses 
>> this api will set there segments and regions in there respective drivers.
>>
>> 2. setting regions/segments in APSS minidump descriptors which are 
>> done via qcom_minidump_region_register(). TBH this should be renamed 
>> to qcom_apss_minidump_region_register().
>>
>> mixing of thsee apis makes it bit confusing, specially we have these 
>> two category of apis that deal with different things.
>>
>> Does it make sense to spit and abstract them properly by doing?
>>
>>
>> 1. minidump driver to deal with handling gtoc and providing 
>> descriptors to the consumers like remoteproc or apss, This can 
>> probably live within smem driver as loc for this support is very 
>> minimal and proabably rename the api accordingly.
>>
> 
>> 2. apss_minidump driver to allow other qcom drivers to 
>> register/unregister regions within apss minidump descriptor.
>>
>> did I miss something?
> 
> No, you are correct with your understanding.
> 
> To your suggestion to split code and to keep 
> qcom_minidump_subsystem_desc() live inside smem driver,
> 
> And how about the header qcom_minidump.h, should we keep it separate 
> than the apss minidump client header minidump.h ?

I tried to do what I suggested and it kinda looked okay w.r.t design but 
started to look like a bit overdo.

other thing that I tried like what you have in patches but creating a 
dedicated platform driver for minidump (along with apss minidump), just 
like other smem devices like socinfo..

This should also get rid of qcom_minidump_ready().

> 
> Since, you kind of understand the driver now, do you think it is worth
> to create platform device for minidump from smem driver, and
> have a probe inside apss minidump driver to solve chicken and egg 
> problem for the clients who comes before minidump and try to register 
> itself without doing ready check and apss_minidump can note this client 
> entry and only register this region once minidump probe success and then 
> it can register all the noted clients in one go.
yes, it is doable.

> 
> The reason to do this would be apss_minidump driver has no meaning 
> without smem, and for this reason checking qcom_minidump_ready() would 
> not be ideal for at least qcom clients and for core kernel may be.
> 

how about something like this:

-------------------->cut<-----------------------
diff --git a/drivers/soc/qcom/minidump.c b/drivers/soc/qcom/minidump.c
new file mode 100644
index 000000000000..4171054b268d
--- /dev/null
+++ b/drivers/soc/qcom/minidump.c
@@ -0,0 +1,100 @@
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/minidump.h>
+
+...
+
+struct minidump {
+       struct minidump_global_toc      *md_gbl_toc;
+       struct minidump_subsystem       *md_apss_toc;
+       ...
+};
+
+struct minidump *__md;
+
+struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int 
minidump_index)
+{
+       if (!__md)
+               return PTR_ERR(-EPROBE_DEFER);
+
+       return &__mdgtoc->subsystems[minidump_index];
+}
+EXPORT_SYMBOL(qcom_minidump_subsystem_desc);
+
+
+int qcom_minidump_apss_region_register(const struct 
qcom_minidump_region *region)
+{
+       if (!__mdgtoc)
+               return -EPROBE_DEFER;
+       ...
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_apss_region_register);
+
+static int qcom_minidump_init_apss_subsystem(struct minidumd *md)
+{
+       struct minidump_subsystem *apsstoc;
+
+       apsstoc = qcom_minidump_subsystem_desc(MINIDUMP_APSS_DESC);
+       if (IS_ERR(apsstoc))
+               return -EINVAL;
+
+       md->md_regions = kcalloc(MAX_NUM_ENTRIES,
+                             sizeof(struct minidump_region), GFP_KERNEL);
+       if (!md->md_regions)
+               return -ENOMEM;
+
+       minidump.apss_toc = apsstoc;
+
+       ...
+
+       return 0;
+}
+static int qcom_minidump_probe(struct platform_device *pdev)
+{
+       struct minidump *md;
+       struct minidump_global_toc *mdgtoc;
+
+       md = devm_kzalloc(&pdev->dev, sizeof(*md), GFP_KERNEL);
+
+       ...
+       mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, 
&size);
+       if (IS_ERR(mdgtoc)) {
+               dev_err(&pdev->dev, "Couldn't find minidump\n");
+               return ERR_PTR(mdgtoc);
+       }
+
+       if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
+               dev_err(&pdev->dev, "Minidump table is not initialized\n");
+               return ERR_PTR(-EINVAL);
+       }
+       ...
+       qcom_minidump_init_apss_subsystem(md);
+
+       __md = md;
+       ...
+       return 0;
+}
+
+static int qcom_minidump_remove(struct platform_device *pdev)
+{
+       struct qcom_minidump *qs = platform_get_drvdata(pdev);
+
+       ...
+
+       return 0;
+}
+
+static struct platform_driver qcom_minidump_driver = {
+       .probe = qcom_minidump_probe,
+       .remove = qcom_minidump_remove,
+       .driver  = {
+               .name = "qcom-minidump",
+       },
+};
+
+module_platform_driver(qcom_minidump_driver);
+
+MODULE_DESCRIPTION("Qualcomm minidump driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-minidump");
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 4f163d62942c..d54b07095ddd 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -279,6 +279,7 @@ struct qcom_smem {

         u32 item_count;
         struct platform_device *socinfo;
+       struct platform_device *minidump;
         struct smem_ptable *ptable;
         struct smem_partition global_partition;
         struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1151,12 +1152,19 @@ static int qcom_smem_probe(struct 
platform_device *pdev)
         if (IS_ERR(smem->socinfo))
                 dev_dbg(&pdev->dev, "failed to register socinfo device\n");

+       smem->minidump = platform_device_register_data(&pdev->dev, 
"qcom-minidump",
+ 
PLATFORM_DEVID_NONE, NULL,
+                                                     0);
+       if (IS_ERR(smem->minidump))
+               dev_dbg(&pdev->dev, "failed to register minidump device\n");
+
         return 0;
  }

  static int qcom_smem_remove(struct platform_device *pdev)
  {
         platform_device_unregister(__smem->socinfo);
+       platform_device_unregister(__smem->minidump);

         hwspin_lock_free(__smem->hwlock);
         __smem = NULL;
(END)
-------------------->cut<-----------------------

> --Mukesh
>>
>> thanks,
>> Srini
>>
>>> be shared among above qcom_minidump.c and qcom_common.c but since 
>>> they are not in same directory, moved it inside include/soc/qcom/ as 
>>> separate header than consumer header minidump.h . >
>>> -Mukesh
>>>>
>>>> --srini
>>>>
>>>>> Qualcomm drivers.
>>>>>
>>>>> There is no change in functional behavior after this.
>>>>>
>>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>>> ---
>>>>>   drivers/remoteproc/qcom_common.c | 56 
>>>>> +---------------------------------
>>>>>   include/soc/qcom/qcom_minidump.h | 66 
>>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 67 insertions(+), 55 deletions(-)
>>>>>   create mode 100644 include/soc/qcom/qcom_minidump.h
>>>>>
>>>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>>>> b/drivers/remoteproc/qcom_common.c
>>>>> index 805e525..88fc984 100644
>>>>> --- a/drivers/remoteproc/qcom_common.c
>>>>> +++ b/drivers/remoteproc/qcom_common.c
>>>>> @@ -18,6 +18,7 @@
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/soc/qcom/mdt_loader.h>
>>>>>   #include <linux/soc/qcom/smem.h>
>>>>> +#include <soc/qcom/qcom_minidump.h>
>>>>>   #include "remoteproc_internal.h"
>>>>>   #include "qcom_common.h"
>>>>> @@ -26,61 +27,6 @@
>>>>>   #define to_smd_subdev(d) container_of(d, struct 
>>>>> qcom_rproc_subdev, subdev)
>>>>>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, 
>>>>> subdev)
>>>>> -#define MAX_NUM_OF_SS           10
>>>>> -#define MAX_REGION_NAME_LENGTH  16
>>>>> -#define SBL_MINIDUMP_SMEM_ID    602
>>>>> -#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' 
>>>>> << 8 | 'I' << 0)
>>>>> -#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' 
>>>>> << 8 | 'E' << 0)
>>>>> -#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 
>>>>> 8 | 'L' << 0)
>>>>> -
>>>>> -/**
>>>>> - * struct minidump_region - Minidump region
>>>>> - * @name        : Name of the region to be dumped
>>>>> - * @seq_num:        : Use to differentiate regions with same name.
>>>>> - * @valid        : This entry to be dumped (if set to 1)
>>>>> - * @address        : Physical address of region to be dumped
>>>>> - * @size        : Size of the region
>>>>> - */
>>>>> -struct minidump_region {
>>>>> -    char    name[MAX_REGION_NAME_LENGTH];
>>>>> -    __le32    seq_num;
>>>>> -    __le32    valid;
>>>>> -    __le64    address;
>>>>> -    __le64    size;
>>>>> -};
>>>>> -
>>>>> -/**
>>>>> - * struct minidump_subsystem - Subsystem's SMEM Table of content
>>>>> - * @status : Subsystem toc init status
>>>>> - * @enabled : if set to 1, this region would be copied during 
>>>>> coredump
>>>>> - * @encryption_status: Encryption status for this subsystem
>>>>> - * @encryption_required : Decides to encrypt the subsystem regions 
>>>>> or not
>>>>> - * @region_count : Number of regions added in this subsystem toc
>>>>> - * @regions_baseptr : regions base pointer of the subsystem
>>>>> - */
>>>>> -struct minidump_subsystem {
>>>>> -    __le32    status;
>>>>> -    __le32    enabled;
>>>>> -    __le32    encryption_status;
>>>>> -    __le32    encryption_required;
>>>>> -    __le32    region_count;
>>>>> -    __le64    regions_baseptr;
>>>>> -};
>>>>> -
>>>>> -/**
>>>>> - * struct minidump_global_toc - Global Table of Content
>>>>> - * @status : Global Minidump init status
>>>>> - * @md_revision : Minidump revision
>>>>> - * @enabled : Minidump enable status
>>>>> - * @subsystems : Array of subsystems toc
>>>>> - */
>>>>> -struct minidump_global_toc {
>>>>> -    __le32                status;
>>>>> -    __le32                md_revision;
>>>>> -    __le32                enabled;
>>>>> -    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>>>>> -};
>>>>> -
>>>>>   struct qcom_ssr_subsystem {
>>>>>       const char *name;
>>>>>       struct srcu_notifier_head notifier_list;
>>>>> diff --git a/include/soc/qcom/qcom_minidump.h 
>>>>> b/include/soc/qcom/qcom_minidump.h
>>>>> new file mode 100644
>>>>> index 0000000..84c8605
>>>>> --- /dev/null
>>>>> +++ b/include/soc/qcom/qcom_minidump.h
>>>>> @@ -0,0 +1,66 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> +/*
>>>>> + * Qualcomm minidump shared data structures and macros
>>>>> + *
>>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>>>> reserved.
>>>>> + */
>>>>> +
>>>>> +#ifndef _QCOM_MINIDUMP_H_
>>>>> +#define _QCOM_MINIDUMP_H_
>>>>> +
>>>>> +#define MAX_NUM_OF_SS           10
>>>>> +#define MAX_REGION_NAME_LENGTH  16
>>>>> +#define SBL_MINIDUMP_SMEM_ID    602
>>>>> +#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' 
>>>>> << 8 | 'I' << 0)
>>>>> +#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' 
>>>>> << 8 | 'E' << 0)
>>>>> +#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 
>>>>> 8 | 'L' << 0)
>>>>> +
>>>>> +/**
>>>>> + * struct minidump_region - Minidump region
>>>>> + * @name        : Name of the region to be dumped
>>>>> + * @seq_num:        : Use to differentiate regions with same name.
>>>>> + * @valid        : This entry to be dumped (if set to 1)
>>>>> + * @address        : Physical address of region to be dumped
>>>>> + * @size        : Size of the region
>>>>> + */
>>>>> +struct minidump_region {
>>>>> +    char    name[MAX_REGION_NAME_LENGTH];
>>>>> +    __le32    seq_num;
>>>>> +    __le32    valid;
>>>>> +    __le64    address;
>>>>> +    __le64    size;
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct minidump_subsystem - Subsystem's SMEM Table of content
>>>>> + * @status : Subsystem toc init status
>>>>> + * @enabled : if set to 1, this region would be copied during 
>>>>> coredump
>>>>> + * @encryption_status: Encryption status for this subsystem
>>>>> + * @encryption_required : Decides to encrypt the subsystem regions 
>>>>> or not
>>>>> + * @region_count : Number of regions added in this subsystem toc
>>>>> + * @regions_baseptr : regions base pointer of the subsystem
>>>>> + */
>>>>> +struct minidump_subsystem {
>>>>> +    __le32    status;
>>>>> +    __le32    enabled;
>>>>> +    __le32    encryption_status;
>>>>> +    __le32    encryption_required;
>>>>> +    __le32    region_count;
>>>>> +    __le64    regions_baseptr;
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct minidump_global_toc - Global Table of Content
>>>>> + * @status : Global Minidump init status
>>>>> + * @md_revision : Minidump revision
>>>>> + * @enabled : Minidump enable status
>>>>> + * @subsystems : Array of subsystems toc
>>>>> + */
>>>>> +struct minidump_global_toc {
>>>>> +    __le32                status;
>>>>> +    __le32                md_revision;
>>>>> +    __le32                enabled;
>>>>> +    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>>>>> +};
>>>>> +
>>>>> +#endif  /* _QCOM_MINIDUMP_H_ */
