Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242616B0A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjCHOI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjCHOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468AE5BDA6;
        Wed,  8 Mar 2023 06:06:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1383209wmq.1;
        Wed, 08 Mar 2023 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678284395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFlmPDElyG87htysg0UzjnhJZ1l7Ep2HxQRmeo0TmSQ=;
        b=l8mz48osJ+th9mVFB3Ck/6hTwjZZKpVJ2idPwlNuUE7TyMpjz1fLuKB5WDg286sAe/
         x7gma3MYuAXAnLc1xZWro5rqiqXvrRaSYAmTXa/ZAWmw4u63lc4eakJiEZqQcZuUATkK
         k5FpSBDKIxLnm1zjOQv7/k3SF/qmVhZkQBB3yE5zTLfBmFTYhoK7saM3+MyyuyvvoTH9
         bSxuGl0z8+a2lhawPVCuJnVq6OzQoOskgY8kX/52PSZoqW1GDwO/vdmgtNDauXVXeF4d
         WAt0xZdNcot7Zjk5a36ySGzFN+ePUl50mgNNqaKIp/TXcJ6yhy8PmY4oHqQCLi13sTVA
         S09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFlmPDElyG87htysg0UzjnhJZ1l7Ep2HxQRmeo0TmSQ=;
        b=KMoOexewnyQ2xwWyQEfK39aIwz1K56k5aStZfIqFgcjKNVTNpgyJ14Fck/JIwrLV5F
         a2lmA5BT3hwoSJVdjWttsUBOeg1uSf2sO6GAjuS/G5Ok5Q8hFAXn2ETKt4LjBJmCkIp+
         +En23z7Lh4ZTT9prAFof1NDWb5TWlWTG62NveZl/E5yrVdN/sFg4yEPNBQSiz16HvjsL
         38Mdf0yEzKdBBKB1FrvVpdknnWGJzaUv47CBbuYuwdS/7K/stsnKzkFbpivzKm0Yjzxi
         /plihkviLPNwyPrPT+k35Z2pTZKTCqAbFSVUC3SsJGybtHIXZ0NVE9GulZuTQl8kiCwg
         +qQQ==
X-Gm-Message-State: AO0yUKX2PdmKV0Y4oKQcou2oIEA+D0ReHxdAet0O8hvlwTusZZBS4+zA
        Wnld9rBM47+XiPCK80L5frg=
X-Google-Smtp-Source: AK7set8Qcnl5j/JoHRBKCpe+gkYVNBJDXu1SxPZEFDlUNjmAY/C/h95kxfp7kM6VU332UK/A6gnJmQ==
X-Received: by 2002:a05:600c:3552:b0:3eb:3692:644d with SMTP id i18-20020a05600c355200b003eb3692644dmr16702589wmq.22.1678284394650;
        Wed, 08 Mar 2023 06:06:34 -0800 (PST)
Received: from [10.28.0.5] ([194.126.177.75])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b002c5503a8d21sm15642055wrq.70.2023.03.08.06.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:06:33 -0800 (PST)
Message-ID: <157cf27f-e890-1e46-f320-8e6bf8f3be4b@gmail.com>
Date:   Wed, 8 Mar 2023 15:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] firmware: Add support for Qualcomm Secure
 Execution Environment SCM interface
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <6ddeba6f-9816-730e-28ce-0f1efbc11367@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 16:36, Dmitry Baryshkov wrote:
> On 05/03/2023 04:21, Maximilian Luz wrote:
>> Add support for SCM calls to Secure OS and the Secure Execution
>> Environment (SEE) residing in the TrustZone (TZ) via the QSEECOM
>> interface. This allows communication with Secure/TZ applications, for
>> example 'uefisecapp' managing access to UEFI variables.
>>
>> The interface is managed by a platform device to ensure correct lifetime
>> and establish a device link to the Qualcomm SCM device.
>>
>> While this patch introduces only a very basic interface without the more
>> advanced features (such as re-entrant and blocking SCM calls and
>> listeners/callbacks), this is enough to talk to the aforementioned
>> 'uefisecapp'.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Changes in v3:
>>   - Rebase ontop of latest qcom_scm changes (qcom_scm.h moved).
>>   - Move qcom_qseecom.h in accordance with qcom_scm.
>>
>> Changes in v2:
>>   - Bind the interface to a device.
>>   - Establish a device link to the SCM device to ensure proper ordering.
>>   - Register client apps as child devices instead of requiring them to be
>>     specified in the device tree.
>>   - Rename (qctree -> qseecom) to allow differentiation between old
>>     (qseecom) and new (smcinvoke) interfaces to the trusted execution
>>     environment.
>>
>> ---
>>   MAINTAINERS                                |   7 +
>>   drivers/firmware/Kconfig                   |  15 +
>>   drivers/firmware/Makefile                  |   1 +
>>   drivers/firmware/qcom_qseecom.c            | 314 +++++++++++++++++++++
>>   include/linux/firmware/qcom/qcom_qseecom.h | 190 +++++++++++++
>>   5 files changed, 527 insertions(+)
>>   create mode 100644 drivers/firmware/qcom_qseecom.c
>>   create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9201967d198d..1545914a592c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17380,6 +17380,13 @@ F:    Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
>>   F:    drivers/net/ethernet/qualcomm/rmnet/
>>   F:    include/linux/if_rmnet.h
>> +QUALCOMM SECURE EXECUTION ENVIRONMENT COMMUNICATION DRIVER
>> +M:    Maximilian Luz <luzmaximilian@gmail.com>
>> +L:    linux-arm-msm@vger.kernel.org
>> +S:    Maintained
>> +F:    drivers/firmware/qcom_qseecom.c
>> +F:    include/linux/firmware/qcom/qcom_qseecom.h
>> +
>>   QUALCOMM TSENS THERMAL DRIVER
>>   M:    Amit Kucheria <amitk@kernel.org>
>>   M:    Thara Gopinath <thara.gopinath@gmail.com>
> 
> 
> 
>> +
>> +
>> +/* -- Platform specific data. ----------------------------------------------- */
>> +
>> +struct qseecom_data {
>> +    const struct mfd_cell *cells;
> 
> The child qseecom devices are not platform devices, so MFD should not be used here. Please use aux devices instead.

Okay, makes sense. Would this still work with your suggestion in patch 4
regarding a custom (?) bus or can the aux bus be used to implement that? From a
quick look, I believe we could use aux bus for this but I haven't worked with
that before, so I don't know if I'm missing something.

>> +    int num_cells;
>> +};
>> +
>> +static const struct of_device_id qseecom_dt_match[] = {
>> +    { .compatible = "qcom,qseecom-sc8280xp", },
> 
> Forgot to mention, while doign review. There is no need for this compat until you provide the actual data. Please move it to the patch 4.

Sure, will do that.

>> +    { .compatible = "qcom,qseecom", },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, qseecom_dt_match);
> 
> 

Regards,
Max
