Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB926A46A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjB0QBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjB0QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:01:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2EC20D33
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:01:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l1so3716077wry.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMO+fA1MIl81zKq6OpToM8j6lL3UYLiZJAoDm7QQyIw=;
        b=cTYNMmkD63U5RpdJ5vRp0vRQb/GAOyyzPu5FYWKiUpsZlqf42UuY8/BhleHQtk0A2a
         PDCU9S28O+aJfPuFDPLVOwlrccOPcfbfyd1JF/aWIOdKAjSTN/FG688ER+pMlprJKwaL
         5SB49wCOgqPZ/dcTr1iKNE9e4FOwIZczX1QjG7tIHSgF6PU1obVMB3ri7LsrEs1ug1Yw
         OjABw2cgL+K2oyYKKILNnK/TYJ8Vy8f1A0cWXkMonWChIAX+xZ8WXn8o6iH01zto8L/H
         +6T+DzNWfeRaVV+uD8y50WJojdap0NX/gWyTnIXuYVFJyuzN80CJnfhfk9xcLFWCAhi0
         +xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMO+fA1MIl81zKq6OpToM8j6lL3UYLiZJAoDm7QQyIw=;
        b=oVQqJB7Q8Fg3GSWQISvDAvikoRzSRc1FGQLMAOmm7jpKuqj1TgZwmQp04hc/KXzebn
         ldQ4u+WM8tRKIg2KHphWJEYzGpEjGRGfS6R0PyVyAF7VaSuTVeMNDPvefa81dDAvonZv
         q5yDX/Gez/dud5Gz2le0v2tu32rwSgMuOhIBAyHhMgW9RTxh8M0xxzTQRhx1qRkTjBRf
         AZEnJK8qxutqdQJORkHTKMnhug9Wpwib3/fqLhJQryh2vTwCjaeE3W1Cb2K7TBt/b2AC
         IP46yZPF5prZaV5aKrAtzwKYYLhvq2ArATNqV2EL03gps5QNhjaZ3/2+bQMEYfgJ7rZT
         GhYg==
X-Gm-Message-State: AO0yUKVTzTJECZ4BwRfM+d6fkyAvrGTyoryus8C9miRwIxnHYlmc8q/z
        /k4WVf4tfcihiBiztVyOXyR83w==
X-Google-Smtp-Source: AK7set8OI0zIVwExIwjpmyxmhAKwEjDQvw3qCiwG/NVjp/4rLL7HN0tK2+VtPdNw1PwJUcztmP1fUA==
X-Received: by 2002:a05:6000:1703:b0:2c5:4ffb:b5d4 with SMTP id n3-20020a056000170300b002c54ffbb5d4mr6547533wrc.19.1677513700809;
        Mon, 27 Feb 2023 08:01:40 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:8baa:6b32:391b:62de? ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.googlemail.com with ESMTPSA id e9-20020a5d5309000000b002c70d269b4esm7362220wrv.91.2023.02.27.08.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:01:40 -0800 (PST)
Message-ID: <b7b99ec6-5c6f-34a1-05be-a109b4328eab@linaro.org>
Date:   Mon, 27 Feb 2023 17:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 20/20] thermal/traces: Replace the thermal zone
 structure parameter with the field value
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
 <20230226225406.979703-21-daniel.lezcano@linaro.org>
 <20230227100715.7d896836@gandalf.local.home>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230227100715.7d896836@gandalf.local.home>
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


Hi Steven,


On 27/02/2023 16:07, Steven Rostedt wrote:
> On Sun, 26 Feb 2023 23:54:06 +0100
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
>> In the work of the thermal zone device self-encapsulation, let's pass
>> the field value instead of dereferencing them in the traces which
>> force us to export publicly the thermal_zone_device structure.
>>
>> No fonctionnal change intended.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/gov_fair_share.c              |  4 +++-
>>   drivers/thermal/gov_power_allocator.c         |  6 +++--
>>   drivers/thermal/gov_step_wise.c               |  4 +++-
>>   drivers/thermal/thermal_core.c                |  8 +++++--
>>   include/trace/events/thermal.h                | 24 +++++++++----------
>>   .../trace/events/thermal_power_allocator.h    | 12 +++++-----
>>   6 files changed, 34 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
>> index aad7d5fe3a14..cdddd593021d 100644
>> --- a/drivers/thermal/gov_fair_share.c
>> +++ b/drivers/thermal/gov_fair_share.c
>> @@ -35,7 +35,9 @@ static int get_trip_level(struct thermal_zone_device *tz)
>>   	 * point, in which case, trip_point = count - 1
>>   	 */
>>   	if (count > 0)
>> -		trace_thermal_zone_trip(tz, count - 1, trip.type);
>> +		trace_thermal_zone_trip(thermal_zone_device_type(tz),
>> +					thermal_zone_device_id(tz),
>> +					count - 1, trip.type);
> 
> The problem with this approach is that you are moving all the work to
> dereference the pointers into the hot paths (the code execution), instead
> of doing it in the slow path (where the tracepoint work is done).

Good point, that is something I did not realize, thanks for pointing it out.

> If you are concerned with exporting a structure then move the trace file
> from:
>
>    include/trace/events/thermal.h to drivers/thermal/trace.h
> 
> like drivers/vfio/pci/trace.h and many other drivers do.

Good idea, I'll do that

> Read
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/trace_events/Makefile
> to see how to use a trace header outside the include/trace/events directory.
> 
> also, by removing the pointer, you lose out on BPF and kprobe traces that
> could dereference the pointer if you needed to trace something that was not
> exported by the trace point itself.

As the trace will be in the drivers/thermal/trace.h, it will be able to 
use the thermal_core.h private file and no longer 
include/linux/thermal.h, so preventing to unexport the thermal zone 
structure from thermal.h. Consequently, we no longer have to change the 
prototype of the traces and the pointer will stay in place.

Thanks for your suggestions


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

