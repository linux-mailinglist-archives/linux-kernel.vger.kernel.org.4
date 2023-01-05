Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6EB65F01C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjAEPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjAEPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:31:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB07626E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:30:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso1561955wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvvnKOeX+ZlMaRKV3hslb79tQ89vWLcDjGlEy66UrG4=;
        b=rJUFNlrAUdphD6+xz/QdUo9cCVH2OtCU5DmhSloFQhuXQ4A2q+ANHVaTm6RLC6xGYL
         YUHiUpLyD0RGadGQjkY6Lnt2ZVngthDvNM7DVo0r1sEuoeBQZ8FdzsXdluy40rN1VGo4
         CuU5fAucH2oJ+dvIfdC3RtWZfdcOq79U2Om82sKWccMOwDVRGq0tOMDrOlABoGMDlYmp
         uA6EuC5P8IPQZJPJpYXImKIXI0gnLRX3UzeQt2Iw0g6KQHq1Z8O5LetVwfS1NrNysJfs
         FCMdygUZPytvsIs+mQWaHvkUdj1BirPasTFlfrKopRKSlSxuFLGQh/cQnjKP66yPcUFO
         gVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvvnKOeX+ZlMaRKV3hslb79tQ89vWLcDjGlEy66UrG4=;
        b=sNJz38e8qlY2gKsQIrEvWqZOdEL38WtaKawmHc99peh7nz/+0+ElZOUzIe1EB8WM6X
         qbz9nDceDcFt9xf59ovsaj2Wvzn+vwhkc3r4ycex8iTVbbJAwL1reP7qt+aG3CKH3wFl
         BVyurYjKx3oSCG5woY42h0VxW6kj+8ANBl9wz8Vr6kJ8psKEG/JOcIq/3qEEJSOnoD+X
         oEEgVkaLpn7Aw7C961Y8SIJyxffspoJ2n2Hn2Wr/HdeMZwllVQaGCZJVMaIAuzl0Y2tT
         q6nXyK3YXBXwIG7FHXD2B2b2Zakk3RlW3i59aj+zNmaY8wNoqrSi5+fcy9Swb3+bURaR
         RTAw==
X-Gm-Message-State: AFqh2krjrIXW4QkwdR5jKkCXUeCf809YdTz5hhNYBbAKXuZYo5Tn7cYc
        GSPxXqqJWYEv5kCw2mjVp+HXdg==
X-Google-Smtp-Source: AMrXdXtT/Q/phSTIZb/AyjObyLc0LTWLwwdNBsOIpGEgGhuvk/k6VOib0W5GULN5qpm8nZxIwumevA==
X-Received: by 2002:a05:600c:35ca:b0:3d1:f2de:195a with SMTP id r10-20020a05600c35ca00b003d1f2de195amr39933713wmq.32.1672932657109;
        Thu, 05 Jan 2023 07:30:57 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b003c6b7f5567csm8035801wmo.0.2023.01.05.07.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 07:30:56 -0800 (PST)
Message-ID: <ea9167d4-0978-fc4b-755f-8df09fc7360e@linaro.org>
Date:   Thu, 5 Jan 2023 16:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Content-Language: en-US
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230105101054.108ad186@canb.auug.org.au>
 <20230105103519.4e849420@canb.auug.org.au>
 <bb71721b-ba20-90d9-df35-aff3c175194e@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <bb71721b-ba20-90d9-df35-aff3c175194e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 15:27, Wysocki, Rafael J wrote:
> 
> On 1/5/2023 12:35 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Thu, 5 Jan 2023 10:10:54 +1100 Stephen Rothwell 
>> <sfr@canb.auug.org.au> wrote:
>>> Today's linux-next merge of the thermal tree got a conflict in:
>>>
>>>    drivers/thermal/intel/x86_pkg_temp_thermal.c
>>>
>>> between commit:
>>>
>>>    58374a3970a0 ("thermal/x86_pkg_temp_thermal: Add support for 
>>> handling dynamic tjmax")
>>>
>>> from the pm tree and commit:
>>>
>>>    03b2e86a24aa ("thermal/drivers/intel: Use generic 
>>> thermal_zone_get_trip() function")
>>>
>>> from the thermal tree.
> 
> I'm wondering why the above commit is in the linux-next branch of the 
> thermal tree, though.

If you are referring to commit 03b2e86a24aa, it is part of the series 
which was reviewed but got some locking conflict issues just before the 
merge window so we dropped it. You asked me to reintroduce it with the 
fixes after v6.2-rc1 is out [1].

The previous conflict and this one is because some changes were picked 
in the linux-pm branch instead of the thermal/linux-branch.

We find thermal Intel changes going directly in linux-pm and thermal 
changes going through the thermal tree. And sometime thermal core 
changes picked through linux-pm and sometime through thermal/linux-next.

In order to prevent these conflicts in the future, I suggest to always 
merge thermal patches through the thermal tree.

> It is still under review AFAICS.

The series including the patch "thermal/drivers/intel: Use generic ..." 
are reviewed and ready for inclusion AFAICT.

I'm was waiting for an update of linux-pm/thermal to send a PR against 
this branch.

> Daniel, can you possibly create a bleeding-edge branch for such things? 
> I can merge it into my bleeding-edge branch on a daily basis.

Yes, I can create a bleeding-edge branch for other patches. Some 
questions about it:

  - thermal/linux-next will be based on linux-pm/thermal, and 
thermal/bleeding-edge will be based on thermal/linux-next, right?

  - When patches can be considered for the bleeding-edge?

  - When patches can be considered moving from bleeding-edge to linux-next?

(the questions above are for the thermal tree).

Thanks

   -- Daniel

[1] 
https://lore.kernel.org/all/CAJZ5v0gY-Lhgf_1Kfg6P5O8s+YMkP4TxggxyS=LU9jVgJikAkg@mail.gmail.com/


>>> I fixed it up (see below) and can carry the fix as necessary. This
>>> is now fixed as far as linux-next is concerned, but any non trivial
>>> conflicts should be mentioned to your upstream maintainer when your tree
>>> is submitted for merging.  You may also want to consider cooperating
>>> with the maintainer of the conflicting tree to minimise any particularly
>>> complex conflicts.
>> Actually, the resolution I needed was this:
>>
>> diff --cc drivers/thermal/intel/x86_pkg_temp_thermal.c
>> index 9e08d8c8f5fb,494f25250c2d..24c7774cc4a9
>> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
>> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
>> @@@ -107,56 -108,37 +108,17 @@@ static struct zone_device *pkg_temp_the
>>    static int sys_get_curr_temp(struct thermal_zone_device *tzd, int 
>> *temp)
>>    {
>>        struct zone_device *zonedev = tzd->devdata;
>>   -    u32 eax, edx;
>>   +    int val;
>>   -    rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
>>   -            &eax, &edx);
>>   -    if (eax & 0x80000000) {
>>   -        *temp = zonedev->tj_max - ((eax >> 16) & 0x7f) * 1000;
>>   -        pr_debug("sys_get_curr_temp %d\n", *temp);
>>   -        return 0;
>>   -    }
>>   -    return -EINVAL;
>>   +    val = intel_tcc_get_temp(zonedev->cpu, true);
>>   +    if (val < 0)
>>   +        return val;
>>   +
>>   +    *temp = val * 1000;
>>   +    pr_debug("sys_get_curr_temp %d\n", *temp);
>>   +    return 0;
>>    }
>> - static int sys_get_trip_temp(struct thermal_zone_device *tzd,
>> -                  int trip, int *temp)
>> - {
>> -     struct zone_device *zonedev = tzd->devdata;
>> -     unsigned long thres_reg_value;
>> -     u32 mask, shift, eax, edx;
>> -     int tj_max, ret;
>> -
>> -     if (trip >= MAX_NUMBER_OF_TRIPS)
>> -         return -EINVAL;
>> -
>> -     if (trip) {
>> -         mask = THERM_MASK_THRESHOLD1;
>> -         shift = THERM_SHIFT_THRESHOLD1;
>> -     } else {
>> -         mask = THERM_MASK_THRESHOLD0;
>> -         shift = THERM_SHIFT_THRESHOLD0;
>> -     }
>> -
>> -     tj_max = intel_tcc_get_tjmax(zonedev->cpu);
>> -     if (tj_max < 0)
>> -         return tj_max;
>> -     tj_max *= 1000;
>> -
>> -     ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
>> -                &eax, &edx);
>> -     if (ret < 0)
>> -         return ret;
>> -
>> -     thres_reg_value = (eax & mask) >> shift;
>> -     if (thres_reg_value)
>> -         *temp = tj_max - thres_reg_value * 1000;
>> -     else
>> -         *temp = THERMAL_TEMP_INVALID;
>> -     pr_debug("sys_get_trip_temp %d\n", *temp);
>> -
>> -     return 0;
>> - }
>> -
>>    static int
>>    sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>>    {
>> @@@ -330,18 -340,25 +325,25 @@@ static int pkg_temp_thermal_device_add(
>>        thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
>> -     err = intel_tcc_get_tjmax(cpu);
>> -     if (err < 0)
>>   -    err = get_tj_max(cpu, &tj_max);
>>   -    if (err)
>> --        return err;
>> ++    tj_max = intel_tcc_get_tjmax(cpu);
>> ++    if (tj_max < 0)
>> ++        return tj_max;
>> ++    tj_max *= 1000;
>>        zonedev = kzalloc(sizeof(*zonedev), GFP_KERNEL);
>>        if (!zonedev)
>>            return -ENOMEM;
>> +     zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, 
>> thres_count);
>> +     if (IS_ERR(zonedev->trips)) {
>> +         err = PTR_ERR(zonedev->trips);
>> +         goto out_kfree_zonedev;
>> +     }
>> +
>>        INIT_DELAYED_WORK(&zonedev->work, 
>> pkg_temp_thermal_threshold_work_fn);
>>        zonedev->cpu = cpu;
>> -     zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
>> -             thres_count,
>>   -    zonedev->tj_max = tj_max;
>> +     zonedev->tzone = 
>> thermal_zone_device_register_with_trips("x86_pkg_temp",
>> +             zonedev->trips, thres_count,
>>                (thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
>>                zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
>>        if (IS_ERR(zonedev->tzone)) {
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

