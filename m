Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FB692154
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjBJPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjBJPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:00:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D305A900
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:00:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id by3so4029921wrb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K3+P+KUFXvw1apoaL31HXOu2YL3RmY3Kb2P1uEHJDNc=;
        b=alUpfBodLxY9kFtV/M3kwZoV13ak/JNqddq/STESMZYMiaKWURdGqY90Iewy/098VT
         p5QEet9/3knhYcsJ2/CjIQ2xq1UTXLtPTcbviPDN/WF7qeXsU5R8F+tbz/5DcE21CgpV
         Mx9AFyn5YrEQbE17Th5ZYjo7dK94E63vnYRYxPGnQjV2K+Cb+MllAC2+Q6G8aCqE1L8A
         AGEzqQDxQt0jybY/Lx9ScPEMPILzAz4ch/bMtPAzwHVUC+WCau2kjVz0ygU1f19/gWSj
         i7wYIovR4u9cQJJ6JJnuCFWEuPqNsQdxKWSD5JyxnPp4uXavTZQE6Tb5Uk+XicxXr6xw
         pqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3+P+KUFXvw1apoaL31HXOu2YL3RmY3Kb2P1uEHJDNc=;
        b=Sya6vQptknVXehmwtvj/S8D8b483mBiMIm9QtnRnBjZP+CcbfBuXK5iDRkfgRHcDnf
         LgVchys9xM/cbM7bYdW15RxTWj7Kr+PKCsUdNmB/kIVSy2W3i+JaIpecSyQmVZsLXVBU
         eP/Ia/YSzQz46r5l8UY+n3IsNDD0c0SO5bpY7NSbCcUlmd7Iour0aIXD7JApeI6/9QTq
         CaHLV97nOna/LIa0pgAI3KEKOJgVmP2qs+O0MwxM4Fbujs7ViWu8rR81h66JdVN7DlGL
         W2r4Ghk7dDrjYP0vmQUBJyZGiYYY8OP7ZPM0uBeyInwy+BG9vY1yaLPpHv7RFoaAXXPt
         J0xg==
X-Gm-Message-State: AO0yUKWeyKcMwmfYuGGki4jZDdTKE6I6uX4dLfwgeqPNWd5kY3tg/gmy
        zBL/d22CtVjaf1OC58cwXQdxuw==
X-Google-Smtp-Source: AK7set+zJKGiSqj5eqPg+UEcnSf7H71aMVHQPkkvM154artPj3Ez+65Mh8QBqfERGqYAgN/a5FUqog==
X-Received: by 2002:adf:f5c8:0:b0:2c3:ed14:8319 with SMTP id k8-20020adff5c8000000b002c3ed148319mr15222290wrp.14.1676041248911;
        Fri, 10 Feb 2023 07:00:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a65:5553:55cf:3027? ([2a01:e0a:982:cbb0:5a65:5553:55cf:3027])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b002c53cc7504csm3603457wri.78.2023.02.10.07.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:00:48 -0800 (PST)
Message-ID: <62ede719-e7f8-4d7e-883e-a4b8eb47f987@linaro.org>
Date:   Fri, 10 Feb 2023 16:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/7] usb: typec: ucsi: add PMIC Glink UCSI driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
 <Y9jcYdc30G026/fs@kroah.com>
 <720aee1d-87e8-5291-c6a0-ef53e830a21d@linaro.org>
 <Y+YerQrfWgmwTErM@kroah.com>
 <06670a10-c8e9-6f87-9c16-e88a90a74469@linaro.org>
 <Y+YkHZASzN97QtUY@kroah.com>
Organization: Linaro Developer Services
In-Reply-To: <Y+YkHZASzN97QtUY@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 12:01, Greg Kroah-Hartman wrote:
> On Fri, Feb 10, 2023 at 11:44:22AM +0100, Neil Armstrong wrote:
>> On 10/02/2023 11:38, Greg Kroah-Hartman wrote:
>>> On Fri, Feb 10, 2023 at 11:31:08AM +0100, Neil Armstrong wrote:
>>>> On 31/01/2023 10:16, Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 30, 2023 at 10:54:32AM +0100, Neil Armstrong wrote:
>>>>>> Introduce the UCSI PMIC Glink aux driver that communicates
>>>>>> with the aDSP firmware with the UCSI protocol which handles
>>>>>> the USB-C Port(s) Power Delivery.
>>>>>>
>>>>>> The UCSI messaging is necessary on newer Qualcomm SoCs to
>>>>>> provide USB role switch and altmode notifications.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>>     drivers/usb/typec/ucsi/Kconfig      |   7 +
>>>>>>     drivers/usb/typec/ucsi/Makefile     |   1 +
>>>>>>     drivers/usb/typec/ucsi/ucsi_glink.c | 321 ++++++++++++++++++++++++++++++++++++
>>>>>>     3 files changed, 329 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
>>>>>> index 8f9c4b9f31f7..dee6069e46a2 100644
>>>>>> --- a/drivers/usb/typec/ucsi/Kconfig
>>>>>> +++ b/drivers/usb/typec/ucsi/Kconfig
>>>>>> @@ -58,4 +58,11 @@ config UCSI_STM32G0
>>>>>>     	  To compile the driver as a module, choose M here: the module will be
>>>>>>     	  called ucsi_stm32g0.
>>>>>> +config UCSI_PMIC_GLINK
>>>>>> +	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
>>>>>> +	depends on QCOM_PMIC_GLINK
>>>>>
>>>>> No way to test build this code without this option?
>>>>
>>>> Nop, the QCOM_PMIC_GLINK is a build dependency, this can't be removed
>>>
>>> Then perhaps the QCOM_PMIC_GLINK code needs to be fixed up to allow for
>>> it to be built on all platforms properly?  Otherwise you are
>>> guaranteeing you will not get much, if any, build coverage and api
>>> changes will cause this code to stagnate over time :(
>>
>> The QCOM_PMIC_GLINK deps are:
>>          depends on RPMSG
>>          depends on TYPEC
>>          depends on DRM
>>          depends on NET
>>          depends on OF
>>          select AUXILIARY_BUS
>>          select QCOM_PDR_HELPERS
>>
>> What would be the changes needed here ?
> 
> I do not know, try unwinding it and maybe just adding a COMPILE_TEST
> build option in a few places is all that is needed?

Sure, I'll investigate and send a separate patch for that.

Thanks,
Neil

> 
> thanks,
> 
> greg k-h

