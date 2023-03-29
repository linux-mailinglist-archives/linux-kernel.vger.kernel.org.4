Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BCA6CEE64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjC2QAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjC2P74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:59:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FE59EB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:59:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v1so16288026wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680105565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBJkXabIUFXjdoz3ymumlCy03vftbPDEKeNtnyEkrz8=;
        b=YdpfQk27kKNVYmWdxp/LTVIpL9/Vlb9z8P04OSPiTEBLZiAg8hINsKbJvWjGMQu38+
         VsF5S6kmYNBG8R3BlrvDWxdd60oHj8KvJ8AtLzOyVpUUPEkp/aqmKIZwITpd9UnZ9hgg
         tVJLyE2hbIYhPCFHpmFpwBfY/wibcSVGXRPa1fFWkF/SQ68kNXFv2W5TbzGE3Y8w1wA9
         SKEbKkEptThZMsDVhs7KhfSUnZRwpncmEfxBv+YdKPsNnS65c/BtNfRHLuxL0TlY1LFg
         9TBqqaVm6LyF8vju9vovFEAZELJVSX9FSL6gAn+pIxeag4Zuis4kiwDebgdTkhfx6oqw
         URSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBJkXabIUFXjdoz3ymumlCy03vftbPDEKeNtnyEkrz8=;
        b=5WhSwlwEolZpBVA8irFwGO5sAP5JQCqYgWsTVIkOetrLxRlnvUfnE4LNK6gz+In7yl
         nkcKgYieAJ/Nhge07FD2Hv9qTqX2LPNBxf8LABNyi51qSduvoKObiXOmJUkv2XCj8+9w
         zcs+Mg75F6/q/oZeoJ8dNJmF/ZEKinA6AyVuG83pvXzbXft88DaZNDgDOKRFRGtuMNs2
         wxP9F/Ex5ZnstPRbEf8x60ulRO2jHjqucMSTjOJhJTn7P/c/0SIpzNXjyMYiCtqNHjFM
         MizE+NxYeae8/tNQCz9QefoBKRVVe7lXh75IKvJIORvnHHXACxQmyxNYSNcmCTBfgbLN
         q42g==
X-Gm-Message-State: AAQBX9fDFUj46SiZfO3Q4buisWR35Klzn2S2xLT/kTtHnCD2jV787qVE
        qWNrEPqK2ppG/d8AH0QvnLptxg==
X-Google-Smtp-Source: AKy350ZSxEEdqeCzQKvyuviroGk7pylDiYLPqXxp6c6D7Prd4vO3vN5n7oGZ9fbGXUSlETdYe/Wpww==
X-Received: by 2002:adf:db4b:0:b0:2d9:eb77:90d2 with SMTP id f11-20020adfdb4b000000b002d9eb7790d2mr14716100wrj.70.1680105565439;
        Wed, 29 Mar 2023 08:59:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7c0e:2838:74e9:d05? ([2a05:6e02:1041:c10:7c0e:2838:74e9:d05])
        by smtp.googlemail.com with ESMTPSA id q1-20020a5d61c1000000b002e463bd49e3sm506904wrv.66.2023.03.29.08.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:59:25 -0700 (PDT)
Message-ID: <c1c0945b-4772-e6b1-e662-d9901d224f6a@linaro.org>
Date:   Wed, 29 Mar 2023 17:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
References: <20230329090055.7537-1-rui.zhang@intel.com>
 <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
 <016dc073-c9a3-4b96-6c58-7b21e0f998a5@linaro.org>
 <CAJZ5v0jmo_bj4iMVe9ARei4-oyP3TdD+FXiiu+-g55FqJxLJsg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jmo_bj4iMVe9ARei4-oyP3TdD+FXiiu+-g55FqJxLJsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 16:38, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 4:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 29/03/2023 14:06, Rafael J. Wysocki wrote:
>>> On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 29/03/2023 11:00, Zhang Rui wrote:
>>>>> When the hwmon device node of a thermal zone device is not found,
>>>>> using hwmon->device causes a kernel NULL pointer dereference.
>>>>>
>>>>> Reported-by: Preble Adam C <adam.c.preble@intel.com>
>>>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>>>> ---
>>>>> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
>>>>> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
>>>>> I'm not sure if the Fix tag applies to such commit or not.
>>>>
>>>> Actually it reverts the work done to encapsulate the thermal zone device
>>>> structure.
>>>
>>> So maybe instead of the wholesale switch to using "driver-specific"
>>> device pointers for printing messages, something like
>>> thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
>>> the first argument can be defined?
>>>
>>> At least this particular bug could be avoided this way.
>>
>> Actually we previously said the thermal_hwmon can be considered as part
>> of the thermal core code, so we can keep using tz->device.
>>
>> I'll drop this change from the series.
> 
> But it's there in my thermal branch already.
> 
> Do you want to revert the thermal_hwmon.c part of commit dec07d399cc8?

Oh, right. Fair enough.

I think Rui's patch is fine then.


>> On the other side, adding more thermal_zone_debug/info.. gives
>> opportunities to external components of the core thermal framework to
>> write thermal zone device related message. I'm not sure that is a good
>> thing, each writer should stay in its namespace, no ?
> 
> IMV whoever is allowed to use a thermal zone pointer should also be
> allowed to print messages related to its use, especially debug ones.
> 
> "Encapsulation" means that the members of a thermal zone device object
> should not be accessed directly by its users other than the core, not
> that it cannot be used as a message tag.

Actually it is not about the encapsulation but the namespace of the 
messages. If a driver has an issue, IMO it is better it uses the device 
related messages and let thermal zone messages to be related to what is 
happening in the thermal framework, not in the back end.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

