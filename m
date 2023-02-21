Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C560169DED7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjBULaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBULax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:30:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9FE72BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:30:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 6so3653003wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umFJ1tiO/n9hpa+BXnNpOcub/MpmNvLXb5tjzxhk1I4=;
        b=iluKARp4mfH3fQdm9W69Ps1cg05QmZhN86gN5ILWqI4XwwwAg3qftABcFKmyCQIprS
         i4rCBVfE2+FxrIXJdFXIPYEEc+VhaNYYbtN8G57qBI0YQ0ulDGFjQT24aNXIN3RPiY5a
         3avEvXHWgxsq7z1Ww3IfaHEj3RXqpIdGB1nh2b8s4V5Gamp5j0tqG/3hHd2s/VEvRUoX
         AFiQCvhjHzG/SNQxeepiyE3eQodY6q9gRMPuZgHf4JnOlf5TT/9iXG8COSjR86ubEVMh
         j073+3pfojCIdhrbGQmfA4GPrGM/FjfPVdu42QMqP5NS6x6RjOTMnFakxDSDNRcAokBC
         JM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umFJ1tiO/n9hpa+BXnNpOcub/MpmNvLXb5tjzxhk1I4=;
        b=JNXQRMUiGOZYEnMIJJrNmu4b+ci8MS5wsYDkw3Rdl49Lj/cjIU540Ks3FJAaE1+Jdj
         zJRVKUSEpAK2GKR9ZlI02L6shndyXyRMPJhegHhoVDzB5iRhjUOUAL/ifXeAUFWaJhic
         jLPCe97nGQOBCNTtCcLakN9oHmDkLrWo3R7mWYFwiJ8WW0VKXAXUl+OMvZaBsqxjjhws
         Dw9yRPHteXnSzHM1zKY28nFrrwUgeLxB12vuKLbJsUDa5+YMPJJuipSGsBzIzw1nNxs+
         r7/ibSEyj0FXoGQ7PSMkvkjH2J6oSkXBl+3szRNkKiNxy/VCAbYryc5zFFOSNhI5e3Z8
         H52w==
X-Gm-Message-State: AO0yUKX4WVp8xwfz+z8/HANGW73WZlwc0zAG3Np31QAeXFw/LDZfUXM6
        pGMSkqk7FIoLMLwnQv9N8AkOkg==
X-Google-Smtp-Source: AK7set8peZP+OaNLuYyu+nhdTNuQIOszkrlILHup0MOuP6THXpxlpkTD4002mpeLacklQZcUzjYPpQ==
X-Received: by 2002:a5d:6a04:0:b0:2c3:db98:3e87 with SMTP id m4-20020a5d6a04000000b002c3db983e87mr4789413wru.20.1676979049235;
        Tue, 21 Feb 2023 03:30:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1e9:315c:bb40:e382? ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.googlemail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm3173683wrr.5.2023.02.21.03.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:30:48 -0800 (PST)
Message-ID: <b66fca52-d1f9-2761-4117-819c5820308d@linaro.org>
Date:   Tue, 21 Feb 2023 12:30:47 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <27488f102c917ce1f6d24d30f801b1e1745674e1.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rui,


On 21/02/2023 07:22, Zhang, Rui wrote:
> On Mon, 2023-02-20 at 17:24 +0100, Daniel Lezcano wrote:
>> The driver hooks the thermal framework sysfs to add some driver
>> specific information. A debatable approach as that may belong the
>> device sysfs directory, not the thermal zone directory.
>>
>> As the driver is accessing the thermal internals, we should provide
>> at
>> least an API to the thermal framework to add an attribute to the
>> existing sysfs thermal zone entry.
>>
>> Before doing that and given the age of the driver (2008) may be it is
>> worth to double check if these attributes are really needed. So my
>> first proposal is to remove them if that does not hurt.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> I don't have any device that uses this driver.
> Let's see what Sujith says.

Thanks for your answer.

I take the opportunity to ask you for the ACPI thermal additional sysfs 
entries.

The ACPI thermal driver adds a link:

/sys/class/thermal/thermal_zone0/device

which points to:

../../../LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00


And in this directory there is:

/sys/devices/LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00/thermal_zone

pointing to /sys/class/thermal/thermal_zone0


I was wondering if we have to keep it also? It is a cyclic description 
and we can have the several thermal zones having a device link pointing 
to the same location. So I'm not sure this is correct.

I can understand adding a link in the thermal zone pointing to the 
device could make sense, and that could be generalized to all the 
thermal zone creation, but the back pointer link seems strange.

Would it make sense to remove this second link ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

