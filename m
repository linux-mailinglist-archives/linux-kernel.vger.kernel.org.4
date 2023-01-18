Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6B67170F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjARJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjARJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:04:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A53838658
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:23:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m15so2863508wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntwZ5V+lwcuNIqseOgUdBN0ZeQdpnadVeyJPes4mYw0=;
        b=qAcvkdrwZWHVcNstCzsHYwDd5iq0jfV72sZQA0qYP8uX8umaa01DrLKu7RGHAk4vGG
         I9aL8yJosuURm/xZ5+jXWYLa0hZDIXXhgrtYIlv/j8WEFHmUqPoyv4MdizN1EpH8D6yh
         HJpxOME8v3DZCcN83nIfQ982zhP+oHkPXqvf5GfuAaj1r2VNP6pqF8QvM2zCFCDMa18x
         2oKG8SiCWy6Outaf/qowvVJIqcjE8jJfhKsooNZGBECFSRs87sP6oXywAQ/U78srKbAs
         N42F60mtqV8Z0BzJznjKg2zSmhQxtRV4MX2MEf2DMdAfmMKWFOdz61ixV/ZzLhoYh0Mf
         gWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntwZ5V+lwcuNIqseOgUdBN0ZeQdpnadVeyJPes4mYw0=;
        b=nmn8bngXvIh4IGIiiJAA2IJbwG9yrOqPjX8ZPk/Cwga4MiFTKqibclOUWMeKOuyJiS
         sNhKWqd0CDFJ0jiZ/LE9wI6PbZC9TU2xXKssBoGk+A4A12DPnKBbXSgA9lpuZSNsy35r
         WBvW4v+EpY/vsUJ5Xjy3bLR/nNWSR/RjPfEJqzSW8YI0uGCpsVgYTwpP/5bYF6Wq3kW7
         IA8ZMRZrGspg+AnC6Rs8mMvk9Uh3gJa+Yth7JZt8z+50nHvf/MRIvsFByxAoaosD9b6/
         wOewHUyoFzZF48WFFuXFnrH4nCbSB5rbKIgRN+jFvO75TFI5itIG7OGszfgyszMZwIqb
         /f3g==
X-Gm-Message-State: AFqh2ko9LxV0I1HWz2A/t+DTY+mBusbhjGavUhpPgrMmPPtx1oiYSovk
        awOSr9RRxOUulzfH2p/jugMBIw==
X-Google-Smtp-Source: AMrXdXvv1P6q/BEGO+kEaR3NCNAI+uTRe2+X7D0g9xb/FAwoHRKuCJQWY4YCGlUA2C6RsSokNfa59w==
X-Received: by 2002:a05:600c:5545:b0:3d9:f806:2d26 with SMTP id iz5-20020a05600c554500b003d9f8062d26mr6133937wmb.7.1674030236698;
        Wed, 18 Jan 2023 00:23:56 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u20-20020a05600c19d400b003c6f1732f65sm1245803wmq.38.2023.01.18.00.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:23:56 -0800 (PST)
Message-ID: <b1bf9ec6-f762-e993-edc6-1c293584c51a@linaro.org>
Date:   Wed, 18 Jan 2023 09:23:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: WARNING in __thermal_cooling_device_register()
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <06ed7c15-cd37-a0ce-b75e-b0c8d3188f3a@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <06ed7c15-cd37-a0ce-b75e-b0c8d3188f3a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frank,

Thanks for reporting the WARNING.

It is currently being fixed:

https://lore.kernel.org/all/20230112154721.452292-1-caleb.connolly@linaro.org/

   -- Daniel


On 18/01/2023 08:38, Frank Rowand wrote:
> I am getting two new warning traces in v6.2-rc1 on boot that are not present in v6.1-rc1.
> 
> I have not done a bisect yet, but wanted to report the issue without further delay.
> 
> The configuration is qcom_defconfig
> 
> The system is a Qualcomm Dragon 8074
> 
> I have not done any debugging, but noted some changes to the file that contains
> __thermal_cooling_device_register() since 6.1-rc1:
> 
> linux--6.2-rc> git log --oneline v6.1-rc1.. -- drivers/thermal/thermal_core.c
> 4748f9687caa thermal: core: fix some possible name leaks in error paths
> b778b4d782d4 thermal/core: Protect thermal device operations against thermal device removal
> 05eeee2b51b4 thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
> 1c439dec359c thermal/core: Introduce locked version of thermal_zone_device_update
> 30b2ae07d3d6 thermal/core: Delete device under thermal device zone lock
> d35f29ed9d11 thermal/core: Destroy thermal zone device mutex in release function
> e49a1e1ee078 thermal/core: fix error code in __thermal_cooling_device_register()
> c408b3d1d9bb thermal: Validate new state in cur_state_store()
> 
> 
> 
> The stack traces are:
> 
> -----------[ cut here ]------------
> WARNING: CPU: 0 PID: 31 at lib/kobject.c:718 kobject_put+0x114/0x29c
> kobject: '(null)' ((ptrval)): is not initialized, yet kobject_put() is being called.
> Modules linked in:
> CPU: 0 PID: 31 Comm: kworker/u8:2 Not tainted 6.2.0-rc1 #1
> Hardware name: Generic DT based system
> Workqueue: events_unbound deferred_probe_work_func
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from __warn+0x7c/0x15c
>   __warn from warn_slowpath_fmt+0x98/0xcc
>   warn_slowpath_fmt from kobject_put+0x114/0x29c
>   kobject_put from __thermal_cooling_device_register+0x11c/0x388
>   __thermal_cooling_device_register from __power_supply_register+0x49c/0x5dc
>   __power_supply_register from devm_power_supply_register+0x54/0x90
>   devm_power_supply_register from smbb_charger_probe+0x358/0x61c
>   smbb_charger_probe from platform_probe+0x5c/0xb8
>   platform_probe from really_probe+0xe0/0x3dc
>   really_probe from __driver_probe_device+0x9c/0x208
>   __driver_probe_device from driver_probe_device+0x30/0xcc
>   driver_probe_device from __device_attach_driver+0xa8/0x120
>   __device_attach_driver from bus_for_each_drv+0x84/0xd4
>   bus_for_each_drv from __device_attach+0x108/0x1d8
>   __device_attach from bus_probe_device+0x84/0x8c
>   bus_probe_device from deferred_probe_work_func+0x9c/0xdc
>   deferred_probe_work_func from process_one_work+0x1d4/0x510
>   process_one_work from worker_thread+0x1fc/0x4d0
>   worker_thread from kthread+0xf4/0x124
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf0901fb0 to 0xf0901ff8)
> 1fa0:                                     00000000 00000000 00000000 00000000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 31 at lib/refcount.c:28 __thermal_cooling_device_register+0x11c/0x388
> refcount_t: underflow; use-after-free.
> Modules linked in:
> CPU: 0 PID: 31 Comm: kworker/u8:2 Tainted: G        W          6.2.0-rc1 #1
> Hardware name: Generic DT based system
> Workqueue: events_unbound deferred_probe_work_func
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from __warn+0x7c/0x15c
>   __warn from warn_slowpath_fmt+0x98/0xcc
>   warn_slowpath_fmt from __thermal_cooling_device_register+0x11c/0x388
>   __thermal_cooling_device_register from __power_supply_register+0x49c/0x5dc
>   __power_supply_register from devm_power_supply_register+0x54/0x90
>   devm_power_supply_register from smbb_charger_probe+0x358/0x61c
>   smbb_charger_probe from platform_probe+0x5c/0xb8
>   platform_probe from really_probe+0xe0/0x3dc
>   really_probe from __driver_probe_device+0x9c/0x208
>   __driver_probe_device from driver_probe_device+0x30/0xcc
>   driver_probe_device from __device_attach_driver+0xa8/0x120
>   __device_attach_driver from bus_for_each_drv+0x84/0xd4
>   bus_for_each_drv from __device_attach+0x108/0x1d8
>   __device_attach from bus_probe_device+0x84/0x8c
>   bus_probe_device from deferred_probe_work_func+0x9c/0xdc
>   deferred_probe_work_func from process_one_work+0x1d4/0x510
>   process_one_work from worker_thread+0x1fc/0x4d0
>   worker_thread from kthread+0xf4/0x124
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf0901fb0 to 0xf0901ff8)
> 1fa0:                                     00000000 00000000 00000000 00000000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 0000000000000000 ]---
> 
> 
> -Frank

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

