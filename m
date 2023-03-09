Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98926B1D53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCIIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCIIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:07:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91661AAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:07:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id t11so1234006lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678349235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJjf5SXhDUnOVKgTWO2udYlDtkJmP/p6P7yAfKPKoiY=;
        b=s0WK+tFPTi01w8LgIeHC/7DNEOmp7gK1a7D+zcdN4Ie04XfqnOqZI5BaKj+Su79mBA
         1XrFeJ8dVmUtluPN5KHDhP99lTF0PXVk7X1+kXSMe7XICupWwXZwfT4PoItbzTm8OMEh
         4EPZbHG/4t11ddd1OB1DRmeDB9kiFglPqFtXvBR+CRqnDv9VfNDX7B5oDG6CYXbOm1+1
         kkvhoQKNS0rhKAcfN/JU7GACRls8d5r3+VdyNIWGtrXnF5yRWL5IIPtdbVkz/X4Ooiiq
         bUevg9+CN6H2ji4i+SzFc8/e/w+rWH0QSLlcuK/1v2RpX6g07pGtRuaWL3wldi7t92qj
         NDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678349235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJjf5SXhDUnOVKgTWO2udYlDtkJmP/p6P7yAfKPKoiY=;
        b=MefEbVKKxl/Q5DKwgMXnkFCP+byEXHrb/MFUcCX2Q2P+xh6SquM1ALdA03+uD7wCsu
         jW+Vsqmpbttsplq6qLeF7xVlXj5sNfuwyYOwPHLV5PZYPYuyu+yORuS6Wvsat8JQ6mI8
         8ZF7LVLoBHNPIfMdoH5+SAT5C+JmOz/IJ2IpzLjy6cXarSw8O//7puOST2dJVLSQTN8T
         dwv59ZK8M7QdYYFQe5nYch8WrDmCRY5UNWMH1fkjVfKqeEhz3laoZA7iF9HfBxgZDt9/
         etJKVqA81syCuprN+1MeDadBxzr3DVWqb+9dyiQYo5xbV+G62imQe46ndLKBb5wtfVHs
         1dcw==
X-Gm-Message-State: AO0yUKWU+CUvDr2z7xFRrENXmjD2IDK9pUa+ea6f/uZ4oCcJ9ceu+yYe
        s0rWzs0TgzUsXCSN8JUo+8EANA==
X-Google-Smtp-Source: AK7set9Vzw2UU4JXxOsa6OuHp0wRluytlOXjOJE27OSTzyhNvfv+VBtYRPowAgff48osf6ywGWSsqw==
X-Received: by 2002:ac2:55a9:0:b0:4dd:9f4d:7459 with SMTP id y9-20020ac255a9000000b004dd9f4d7459mr5936893lfg.67.1678349235345;
        Thu, 09 Mar 2023 00:07:15 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b23-20020ac25637000000b004d5ae3f5e9bsm2552203lff.130.2023.03.09.00.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:07:14 -0800 (PST)
Message-ID: <7ddda680-b169-5105-a3cb-20790f0868ee@linaro.org>
Date:   Thu, 9 Mar 2023 10:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] firmware: Add support for Qualcomm Secure
 Execution Environment SCM interface
Content-Language: en-GB
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-3-luzmaximilian@gmail.com>
 <6ddeba6f-9816-730e-28ce-0f1efbc11367@linaro.org>
 <157cf27f-e890-1e46-f320-8e6bf8f3be4b@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <157cf27f-e890-1e46-f320-8e6bf8f3be4b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 16:06, Maximilian Luz wrote:
> On 3/7/23 16:36, Dmitry Baryshkov wrote:
>> On 05/03/2023 04:21, Maximilian Luz wrote:
>>> Add support for SCM calls to Secure OS and the Secure Execution
>>> Environment (SEE) residing in the TrustZone (TZ) via the QSEECOM
>>> interface. This allows communication with Secure/TZ applications, for
>>> example 'uefisecapp' managing access to UEFI variables.
>>>
>>> The interface is managed by a platform device to ensure correct lifetime
>>> and establish a device link to the Qualcomm SCM device.
>>>
>>> While this patch introduces only a very basic interface without the more
>>> advanced features (such as re-entrant and blocking SCM calls and
>>> listeners/callbacks), this is enough to talk to the aforementioned
>>> 'uefisecapp'.
>>>
>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>> ---
>>>
>>> Changes in v3:
>>>   - Rebase ontop of latest qcom_scm changes (qcom_scm.h moved).
>>>   - Move qcom_qseecom.h in accordance with qcom_scm.
>>>
>>> Changes in v2:
>>>   - Bind the interface to a device.
>>>   - Establish a device link to the SCM device to ensure proper ordering.
>>>   - Register client apps as child devices instead of requiring them 
>>> to be
>>>     specified in the device tree.
>>>   - Rename (qctree -> qseecom) to allow differentiation between old
>>>     (qseecom) and new (smcinvoke) interfaces to the trusted execution
>>>     environment.
>>>
>>> ---
>>>   MAINTAINERS                                |   7 +
>>>   drivers/firmware/Kconfig                   |  15 +
>>>   drivers/firmware/Makefile                  |   1 +
>>>   drivers/firmware/qcom_qseecom.c            | 314 +++++++++++++++++++++
>>>   include/linux/firmware/qcom/qcom_qseecom.h | 190 +++++++++++++
>>>   5 files changed, 527 insertions(+)
>>>   create mode 100644 drivers/firmware/qcom_qseecom.c
>>>   create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 9201967d198d..1545914a592c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17380,6 +17380,13 @@ F:    
>>> Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
>>>   F:    drivers/net/ethernet/qualcomm/rmnet/
>>>   F:    include/linux/if_rmnet.h
>>> +QUALCOMM SECURE EXECUTION ENVIRONMENT COMMUNICATION DRIVER
>>> +M:    Maximilian Luz <luzmaximilian@gmail.com>
>>> +L:    linux-arm-msm@vger.kernel.org
>>> +S:    Maintained
>>> +F:    drivers/firmware/qcom_qseecom.c
>>> +F:    include/linux/firmware/qcom/qcom_qseecom.h
>>> +
>>>   QUALCOMM TSENS THERMAL DRIVER
>>>   M:    Amit Kucheria <amitk@kernel.org>
>>>   M:    Thara Gopinath <thara.gopinath@gmail.com>
>>
>>
>>
>>> +
>>> +
>>> +/* -- Platform specific data. 
>>> ----------------------------------------------- */
>>> +
>>> +struct qseecom_data {
>>> +    const struct mfd_cell *cells;
>>
>> The child qseecom devices are not platform devices, so MFD should not 
>> be used here. Please use aux devices instead.
> 
> Okay, makes sense. Would this still work with your suggestion in patch 4
> regarding a custom (?) bus or can the aux bus be used to implement that? 
> From a
> quick look, I believe we could use aux bus for this but I haven't worked 
> with
> that before, so I don't know if I'm missing something.

Initially I thought that a custom bus might be required, to provide 
custom probe function. After giving it a thought, I think you can get 
away with using aux bus. So, embed the struct auxiliary_device into 
qseecom_app_device.

> 
>>> +    int num_cells;
>>> +};
>>> +
>>> +static const struct of_device_id qseecom_dt_match[] = {
>>> +    { .compatible = "qcom,qseecom-sc8280xp", },
>>
>> Forgot to mention, while doign review. There is no need for this 
>> compat until you provide the actual data. Please move it to the patch 4.
> 
> Sure, will do that.
> 
>>> +    { .compatible = "qcom,qseecom", },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qseecom_dt_match);
>>
>>
> 
> Regards,
> Max

-- 
With best wishes
Dmitry

