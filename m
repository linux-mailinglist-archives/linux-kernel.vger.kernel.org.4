Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E266728E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjARUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjARUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:00:22 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF95B59F;
        Wed, 18 Jan 2023 12:00:16 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id y8so24503262qvn.11;
        Wed, 18 Jan 2023 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=andB3doITSBHKSy+htfRN+ol1iSE/XegjfPSm0zM4hs=;
        b=kwyb6W8yXdcOtoToCEOAPzPvMuW8dat12NW8s3vbkMA9Xxx2+s63/ifESdzTGzFxyH
         EDNbyLY+XVqayZmRyXaZodzRzN6cRWlj5lxL5sEvxX3to5gZoFhNcZ+sPJ19E69rNxmE
         gbFzpK2WSgA4wn2WGNFcx3fuQp3UcQbsG5dvW52LpPl7gJevvQ8k+KPOrAqcJ2I2CaSU
         x99Wx+bmMCy3c2Y0iiZagO9FLEv7Ou0/N09oRvPaDLDaaZ/nnRst9R/eKokIyt506qpJ
         YT1ANb7kP5CAvXbfOAHJq0upPXrBk7x4rCp0ORd+RZm0/MtmXr6K25AbRiXSC4Nfi8F7
         kFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=andB3doITSBHKSy+htfRN+ol1iSE/XegjfPSm0zM4hs=;
        b=mhLdg8iKOWD+bbjC9d1jERvedktUYqFNUhDyGXYiLLpqtp1/n5nOWfyJj2JcO3nSp8
         BNHqW+/e2lsiJ8NTwUyPdLvEzxZH19beT4NPLHV0FkoqEFcbD3c9rZrHQC8NaR8Z5/Oc
         cSYIql5newLkkcO8/hcfkBKN0Hy7/Y+yfvbUpSNvnZ5RrzHQEeFLlDBmPNomALSKPPfQ
         f/RYsO3Kxpn1JBxCAbectQp8V5CHHgrZB1rGUyABqOsuAa8bIcu00TATn5jt81+Rb27R
         okFW3SYKZrT8G0zwsvY7FDZ4D7KC4aEYP2XpHAghrC8kzGo7p2p7CV/KPZzmyHOLAoMI
         LZcg==
X-Gm-Message-State: AFqh2kr4saBQaZbETKM/Cotru1cXs2OFEDalL/Ov5s1tLkh6SKr+MooV
        RAf26P5DIZcN4ITS6pG60Dc=
X-Google-Smtp-Source: AMrXdXverounyME9EDBg7TZCPA8c7AvbFtikLQe5KHZMa5yy1a00bJ6sakYUOfVZpl49htTo4G82eA==
X-Received: by 2002:a05:6214:cb:b0:532:3b95:5186 with SMTP id f11-20020a05621400cb00b005323b955186mr10902798qvs.44.1674072015978;
        Wed, 18 Jan 2023 12:00:15 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:c0fe:24db:874d:3fd8? ([2600:1700:2442:6db0:c0fe:24db:874d:3fd8])
        by smtp.gmail.com with ESMTPSA id bk7-20020a05620a1a0700b00706b42c0842sm1700669qkb.49.2023.01.18.12.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:00:15 -0800 (PST)
Message-ID: <75784ae1-6bf9-3b94-1097-d750c366e7ea@gmail.com>
Date:   Wed, 18 Jan 2023 14:00:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: WARNING in __thermal_cooling_device_register()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <06ed7c15-cd37-a0ce-b75e-b0c8d3188f3a@gmail.com>
 <b1bf9ec6-f762-e993-edc6-1c293584c51a@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <b1bf9ec6-f762-e993-edc6-1c293584c51a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 1/18/23 02:23, Daniel Lezcano wrote:
> 
> Hi Frank,
> 
> Thanks for reporting the WARNING.
> 
> It is currently being fixed:
> 
> https://lore.kernel.org/all/20230112154721.452292-1-caleb.connolly@linaro.org/

Thanks for that pointer!

Viresh did a V4 of the patch this morning, which worked for my case.  I sent my
tested-by.

-Frank

> 
>   -- Daniel
> 
> 
> On 18/01/2023 08:38, Frank Rowand wrote:
>> I am getting two new warning traces in v6.2-rc1 on boot that are not present in v6.1-rc1.
>>
>> I have not done a bisect yet, but wanted to report the issue without further delay.
>>
>> The configuration is qcom_defconfig
>>
>> The system is a Qualcomm Dragon 8074
>>
>> I have not done any debugging, but noted some changes to the file that contains
>> __thermal_cooling_device_register() since 6.1-rc1:
>>
>> linux--6.2-rc> git log --oneline v6.1-rc1.. -- drivers/thermal/thermal_core.c
>> 4748f9687caa thermal: core: fix some possible name leaks in error paths
>> b778b4d782d4 thermal/core: Protect thermal device operations against thermal device removal
>> 05eeee2b51b4 thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
>> 1c439dec359c thermal/core: Introduce locked version of thermal_zone_device_update
>> 30b2ae07d3d6 thermal/core: Delete device under thermal device zone lock
>> d35f29ed9d11 thermal/core: Destroy thermal zone device mutex in release function
>> e49a1e1ee078 thermal/core: fix error code in __thermal_cooling_device_register()
>> c408b3d1d9bb thermal: Validate new state in cur_state_store()
>>
>>
>>
>> The stack traces are:
>>
>> -----------[ cut here ]------------
>> WARNING: CPU: 0 PID: 31 at lib/kobject.c:718 kobject_put+0x114/0x29c
>> kobject: '(null)' ((ptrval)): is not initialized, yet kobject_put() is being called.
>> Modules linked in:
>> CPU: 0 PID: 31 Comm: kworker/u8:2 Not tainted 6.2.0-rc1 #1
>> Hardware name: Generic DT based system
>> Workqueue: events_unbound deferred_probe_work_func
>>   unwind_backtrace from show_stack+0x10/0x14
>>   show_stack from dump_stack_lvl+0x40/0x4c
>>   dump_stack_lvl from __warn+0x7c/0x15c
>>   __warn from warn_slowpath_fmt+0x98/0xcc
>>   warn_slowpath_fmt from kobject_put+0x114/0x29c
>>   kobject_put from __thermal_cooling_device_register+0x11c/0x388
>>   __thermal_cooling_device_register from __power_supply_register+0x49c/0x5dc
>>   __power_supply_register from devm_power_supply_register+0x54/0x90
>>   devm_power_supply_register from smbb_charger_probe+0x358/0x61c
>>   smbb_charger_probe from platform_probe+0x5c/0xb8
>>   platform_probe from really_probe+0xe0/0x3dc
>>   really_probe from __driver_probe_device+0x9c/0x208
>>   __driver_probe_device from driver_probe_device+0x30/0xcc
>>   driver_probe_device from __device_attach_driver+0xa8/0x120
>>   __device_attach_driver from bus_for_each_drv+0x84/0xd4
>>   bus_for_each_drv from __device_attach+0x108/0x1d8
>>   __device_attach from bus_probe_device+0x84/0x8c
>>   bus_probe_device from deferred_probe_work_func+0x9c/0xdc
>>   deferred_probe_work_func from process_one_work+0x1d4/0x510
>>   process_one_work from worker_thread+0x1fc/0x4d0
>>   worker_thread from kthread+0xf4/0x124
>>   kthread from ret_from_fork+0x14/0x2c
>> Exception stack(0xf0901fb0 to 0xf0901ff8)
>> 1fa0:                                     00000000 00000000 00000000 00000000
>> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> ---[ end trace 0000000000000000 ]---
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 31 at lib/refcount.c:28 __thermal_cooling_device_register+0x11c/0x388
>> refcount_t: underflow; use-after-free.
>> Modules linked in:
>> CPU: 0 PID: 31 Comm: kworker/u8:2 Tainted: G        W          6.2.0-rc1 #1
>> Hardware name: Generic DT based system
>> Workqueue: events_unbound deferred_probe_work_func
>>   unwind_backtrace from show_stack+0x10/0x14
>>   show_stack from dump_stack_lvl+0x40/0x4c
>>   dump_stack_lvl from __warn+0x7c/0x15c
>>   __warn from warn_slowpath_fmt+0x98/0xcc
>>   warn_slowpath_fmt from __thermal_cooling_device_register+0x11c/0x388
>>   __thermal_cooling_device_register from __power_supply_register+0x49c/0x5dc
>>   __power_supply_register from devm_power_supply_register+0x54/0x90
>>   devm_power_supply_register from smbb_charger_probe+0x358/0x61c
>>   smbb_charger_probe from platform_probe+0x5c/0xb8
>>   platform_probe from really_probe+0xe0/0x3dc
>>   really_probe from __driver_probe_device+0x9c/0x208
>>   __driver_probe_device from driver_probe_device+0x30/0xcc
>>   driver_probe_device from __device_attach_driver+0xa8/0x120
>>   __device_attach_driver from bus_for_each_drv+0x84/0xd4
>>   bus_for_each_drv from __device_attach+0x108/0x1d8
>>   __device_attach from bus_probe_device+0x84/0x8c
>>   bus_probe_device from deferred_probe_work_func+0x9c/0xdc
>>   deferred_probe_work_func from process_one_work+0x1d4/0x510
>>   process_one_work from worker_thread+0x1fc/0x4d0
>>   worker_thread from kthread+0xf4/0x124
>>   kthread from ret_from_fork+0x14/0x2c
>> Exception stack(0xf0901fb0 to 0xf0901ff8)
>> 1fa0:                                     00000000 00000000 00000000 00000000
>> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> ---[ end trace 0000000000000000 ]---
>>
>>
>> -Frank
> 

