Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BF69E14D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjBUNbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjBUNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:31:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F332914F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:31:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z8so4164125wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou0Xxb1ANHUtLSjHJzkplnWc8Iame8WOMDRsp2ccWvc=;
        b=rHZgSP1CVvKTTZntkGj4fkpBX/mKKc8qULuu9LPToh/IGfYHudQD3Qbia7vH0BkY03
         1JN/b5f5D1OLQKx4SYks3tLGx1AHpQXEj5TYlNxDvoSaojC0LUIJzZxpJe4By/JT9cs8
         fAT8P1pyZocZzqbkDPNOEw8fTyIfctwuqhyzMJczNgYnXSC/rjmXOOizhDCj5UF0dBCw
         GtHjqmzW2DUSsFxTttCugb7xhXXVIHAw5hm8sI+M7haReODugzqcDYXjUrJuYuQ2Znug
         R5/4WMIUxJq/cV+UeIvavcbHwJBHW7/4ak6mdSYCSz+iPYi0PykaxVRhOzHEfSKUEfMW
         /kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ou0Xxb1ANHUtLSjHJzkplnWc8Iame8WOMDRsp2ccWvc=;
        b=YX/qcohi2VwRZeRiXuPKEEPXEmmaqXKDlI8760v2sCyMYd3jFW/jxeFExml+79Zc7Q
         8rN8xRZVqqFPhf2xn2U8GDCopA0L7a2A7nTc8pPEMqPIImScSHDFZE82Maqsz+1gecaL
         gSYj0Gwtctt8pO6gLD6uccdT8NdcytjDfCH2tOa/EuULYmIl9MgQyLfNEV77ASE8BIRw
         SnFxKbVf9YtUEJ0c+WBhBZPSh4A3IIoQqwGgWTVHFdjPREk59C8I2o/6LbaucSCKzuRk
         Jsr5ghIm1mcazOMCbsJbM2G/jlvMhICKeb5G8/+TlZryVluMRiW1kE9V19rk+zmsnWf+
         tKpA==
X-Gm-Message-State: AO0yUKX5PIi6DJVeiJCKAXHqWzEB6TFvCl93dzGitgvexee2Ge0VHkDm
        6mervA5zNUK+E+jB4GClvVrzAQ==
X-Google-Smtp-Source: AK7set98PsxfIQfbzLOnguBlATa7Lc/wiRo1c9CJwnSBgUm6y4CfPZ1S8S1fumWoJl2mq+1NywWeKA==
X-Received: by 2002:adf:e255:0:b0:2c5:52ef:61c5 with SMTP id bl21-20020adfe255000000b002c552ef61c5mr4000020wrb.41.1676986291418;
        Tue, 21 Feb 2023 05:31:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1e9:315c:bb40:e382? ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.googlemail.com with ESMTPSA id o24-20020a5d58d8000000b002c7066a6f77sm1331664wrf.31.2023.02.21.05.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:31:31 -0800 (PST)
Message-ID: <9932fe61-9a33-79f4-8680-8f504357d514@linaro.org>
Date:   Tue, 21 Feb 2023 14:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "amitk@kernel.org" <amitk@kernel.org>
References: <20230220162419.1276952-1-daniel.lezcano@linaro.org>
 <27488f102c917ce1f6d24d30f801b1e1745674e1.camel@intel.com>
 <b66fca52-d1f9-2761-4117-819c5820308d@linaro.org>
 <6b63db0832fadffa56ff85a1c4ca2b98d165df50.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6b63db0832fadffa56ff85a1c4ca2b98d165df50.camel@intel.com>
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

On 21/02/2023 13:58, Zhang, Rui wrote:
> Hi, Daniel,
> 
> On Tue, 2023-02-21 at 12:30 +0100, Daniel Lezcano wrote:
>> Hi Rui,
>>
>>
>> On 21/02/2023 07:22, Zhang, Rui wrote:
>>> On Mon, 2023-02-20 at 17:24 +0100, Daniel Lezcano wrote:
>>>> The driver hooks the thermal framework sysfs to add some driver
>>>> specific information. A debatable approach as that may belong the
>>>> device sysfs directory, not the thermal zone directory.
>>>>
>>>> As the driver is accessing the thermal internals, we should
>>>> provide
>>>> at
>>>> least an API to the thermal framework to add an attribute to the
>>>> existing sysfs thermal zone entry.
>>>>
>>>> Before doing that and given the age of the driver (2008) may be
>>>> it is
>>>> worth to double check if these attributes are really needed. So
>>>> my
>>>> first proposal is to remove them if that does not hurt.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> I don't have any device that uses this driver.
>>> Let's see what Sujith says.
>>
>> Thanks for your answer.
>>
>> I take the opportunity to ask you for the ACPI thermal additional
>> sysfs
>> entries.
>>
>> The ACPI thermal driver adds a link:
>>
>> /sys/class/thermal/thermal_zone0/device
>>
>> which points to:
>>
>> ../../../LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00
>>
>>
>> And in this directory there is:
>>
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00/thermal_zone
>>
>> pointing to /sys/class/thermal/thermal_zone0
>>
>>
>> I was wondering if we have to keep it also? It is a cyclic
>> description
>> and we can have the several thermal zones having a device link
>> pointing
>> to the same location.
> 
> I don't think so. So far, ACPI Thermal object and the generic thermal
> zone device are 1:1 match.
> 
>>   So I'm not sure this is correct.
>>
>> I can understand adding a link in the thermal zone pointing to the
>> device could make sense, and that could be generalized to all the
>> thermal zone creation, but the back pointer link seems strange.
>>
>> Would it make sense to remove this second link ?
> 
> That was required by some userpsace tool running on menlow, similar to
> this one. But TBH, I don't recall the userspace details.

If there is a 1:1 relationship, how can the userspace require the kernel 
to describe an information it already has?

eg.

/sys/class/thermal/thermal_zone0/device points to 
../../../LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00

So, userspace has already the opposite relationship as the 1:1 tells 
thermal_zone0 -> LNXTHERM:00, then LNXTHERM:00 is associated to 
thermal_zone0. It is a duplicate information in sysfs.

Anyway, I guess that now it is in sysfs, the removal will be very hard 
to achieve *sigh*

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

