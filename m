Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6A6DED5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDLIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDLIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:17:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB9212E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:17:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q23so17249954ejz.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681287456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPgzd/VLKqLuQj5VWjkLgmOErQ669vusy63km8xjmc0=;
        b=hw2Z5wbeJQdY3oh8mBvw2eyn8C+jprPkv41i65KsCAH2305r4v0JTumhAzGsscjfKm
         KZqo5Ya7PJUwvRywCHys4msGSo+c8TkRp+JxHo0jWDpCpGzohQFQhLw/xi8XQekvjMCh
         8DaEjj5Gj9tE3dw261q+KOR7hzgnOHjw109v8nlbeR9J8TJGcRqAyMg0Y6iK8Y03nJ3+
         TJt8hWQ2f0otq5Zo7u1W1WSOfjtKkZ6YBR0otNG/E6Mjl2z6YQtNpPWcOaK1OT5TJGud
         x9oUFht7yqMPyC0Ma163LEIDoFTlKYSox8uTQSEP/VxKkZtTlvAQU3gCbQ/tVu7/WRFb
         R/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPgzd/VLKqLuQj5VWjkLgmOErQ669vusy63km8xjmc0=;
        b=PY3rzzNFllAvB6dUce+l8QLix4XE08248CjHSkmDr4lwFO5PIlWEnLld+3GuxKiQsV
         H1hYycplPr+nxfmY3ZKVuxG6M7+7WsGtdX4mFfHE+B234RGe1Rso70Vqp9CLsWRbzI4P
         VXztt8GfmSEu/8G53871RjL49ETCXidH89UOod/79MRqFtvHWPpkVYVUI5nmDxxyPQX1
         tVRIzwa8z8gc7i8H76B2gOUvgXk3A7nosO62S16DkHEip7y67cTpNAlvIwdg4aKYYp0I
         iUgEM5Njp6SuRe512QY+3lfRrQ0YqW0TBAJUsmSOS4p/sbarY3MqRReu/Qzca7cFJg6f
         fs2A==
X-Gm-Message-State: AAQBX9eMLcblMmvro1lw9aq7HL/cOr+X2LCg3aGYqfpFcBx1fhrzBmkb
        zKwv6Hc8eNMLdehmVbS1F64wJg==
X-Google-Smtp-Source: AKy350YZSgTTZrYnjgc/O2bMS7r2SCOzfHbjKd+xcTOqV+vdlaN3wNoKqYNeDOIj4dSGzcsZjKa8Rw==
X-Received: by 2002:a17:907:8d01:b0:94a:7a0f:7851 with SMTP id tc1-20020a1709078d0100b0094a7a0f7851mr9406162ejc.41.1681287456296;
        Wed, 12 Apr 2023 01:17:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id ww1-20020a170907084100b0094a44aa90ddsm4171525ejb.216.2023.04.12.01.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:17:35 -0700 (PDT)
Message-ID: <7e180b96-6f47-6b25-8751-01b5186c8c71@linaro.org>
Date:   Wed, 12 Apr 2023 10:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
 <20230407154132.dpguz24f6rukyujq@ripper>
 <8cf793df-b676-bbb4-0601-5647d58bb2b3@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8cf793df-b676-bbb4-0601-5647d58bb2b3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 08:48, Souradeep Chowdhury wrote:
> 
> 
> On 4/7/2023 9:11 PM, Bjorn Andersson wrote:
>> On Fri, Apr 07, 2023 at 07:34:36PM +0530, Souradeep Chowdhury wrote:
>>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>>> stats, like the time when the bootloader started execution and at what
>>> point the bootloader handed over control to the kernel etc. in the IMEM
>>> region. This information is captured in a specific format by this driver
>>> by mapping a structure to the IMEM memory region and then accessing the
>>> members of the structure to print the information. This information is
>>> useful in verifying if the existing boot KPIs have regressed or not.
>>> A sample log in SM8450(waipio) device is as follows:-
>>>
>>> KPI: Pre ABL Time = 3s
>>> KPI: ABL Time = 14s
>>
>> Why are these in whole seconds?
> 
> This is to give a granular view of time.
> 
>>
>>> KPI: Kernel MPM timestamp = 890206
>>
>> And why is this presented in cycles?
> 
> This timestamp is used as an intermediate value for calculating one of 
> the KPIs. Can be changed to seconds as well for consistency.
> 
>>
>>>
>>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>>> stage and the timestamp generated by the sleep counter is logged by
>>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>>> starts execution which is logged here as "Pre ABL Time" and the second
>>> when it is about to load the kernel logged as "ABL Time". Both are
>>> logged in the unit of seconds.
>>
>> We have a policy to not taint the kernel log with "useless" information,
>> for kernel developers this seems to add no value and for end users
>> there's no benefit to this.
>>
>>> The current kernel timestamp is
>>> printed by the boot_stats driver as well.
>>>
>>
>> Why?
> 
> Same as stated above.

You did not answer. The question is "why do you think printing this
during boot is suitable for wide usage?". I don't find answer "give a
granular view of time" anyway related.

Please come with rationale why such printing should be used in Linux
kernel at all, given that as Bjorn said - we do not print
debugging/profiling information.

You should probably come with a debugfs interface for this.

Best regards,
Krzysztof

