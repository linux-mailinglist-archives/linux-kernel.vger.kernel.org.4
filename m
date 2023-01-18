Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0F6715DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjARIIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjARIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:05:41 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7B37550;
        Tue, 17 Jan 2023 23:38:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fd15so19332459qtb.9;
        Tue, 17 Jan 2023 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1iGZ5/GI1ftx5bXyZvLIEDu341DI6h5lnVp/beeYxs=;
        b=Amv1SgoM8nsMpQnxAtYRnRwNKazGpBx7zF1RsVtZXMLUBGVhwls4EMgSXCRM09S7wm
         g5k+YXRZuzjIQGhqBbagivPT93o36t2AJRThTi9F4/F1DtOPb/LNxqM2YzEEssdY3DSA
         gNmmtl1xZX7+komBMD7ITD6/BhoslmephqMSS8NEIIVnhWb6CwBb3E+3uar6uJoRTiG0
         tDz4yrOpyM/GxyQ0IYpfRjbslnwxunvPZ3IFyxjEL1q7Fm/Sh/3MLuvoZWqGpBT9+Saz
         yyRBoiOAZ9yc1I8zLJr4HYlEhNStK0WaEX06taqQShabc60FqeUDHlbGT8ARK+75X0v+
         5RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H1iGZ5/GI1ftx5bXyZvLIEDu341DI6h5lnVp/beeYxs=;
        b=cY7/pVzx9YqmfbHtHu0n128MzFlmRbJCnN818Q3wUH8wvnZVN41bhPhs/4BEjoWnEX
         49VnkqjSLWF13Vks5ATtIwIekUA/yyV3HICZ0jDDlLIdnjN4fn50ouGBteNc3c4kJzf6
         4rwnvHt3QOMMFbA7rqX2OGtXbSWgYoTGsn/oK0SLeCH6gI5e6MuLvvoRIgyixl/P8Z7F
         HS48p11Yd7jaCs8Cwdad6FogXL9/ow4qvngHv/NabT7kubigXY7O800iiU121NEOPJ2X
         grASqTuy/GicQxseZPobjt5KM1MygtN6Ce5egTIUmTpGv2ZH1gQB4RPsDkCNTTwdwYn2
         V9LQ==
X-Gm-Message-State: AFqh2koA7oiFuOqostueGRBO4CWAXOQgSOvgoy0YmJTv0piJaaIFoMKb
        jgcsL8tTqg0tWmfXxbpypig=
X-Google-Smtp-Source: AMrXdXuQFRVoyeqq1q8kvdW9qSsch1QYQOW3CtRIyQXLkYt3IrPA7GrYroSj6fA97gXAJOy/3TQvRA==
X-Received: by 2002:ac8:65d4:0:b0:3b6:308e:94a8 with SMTP id t20-20020ac865d4000000b003b6308e94a8mr14626348qto.43.1674027492598;
        Tue, 17 Jan 2023 23:38:12 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:f4b4:b4d2:cf71:89f7? ([2600:1700:2442:6db0:f4b4:b4d2:cf71:89f7])
        by smtp.gmail.com with ESMTPSA id fe13-20020a05622a4d4d00b003a580cd979asm17326293qtb.58.2023.01.17.23.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 23:38:12 -0800 (PST)
Message-ID: <06ed7c15-cd37-a0ce-b75e-b0c8d3188f3a@gmail.com>
Date:   Wed, 18 Jan 2023 01:38:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Subject: WARNING in __thermal_cooling_device_register()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting two new warning traces in v6.2-rc1 on boot that are not present in v6.1-rc1.

I have not done a bisect yet, but wanted to report the issue without further delay.

The configuration is qcom_defconfig

The system is a Qualcomm Dragon 8074

I have not done any debugging, but noted some changes to the file that contains
__thermal_cooling_device_register() since 6.1-rc1:

linux--6.2-rc> git log --oneline v6.1-rc1.. -- drivers/thermal/thermal_core.c
4748f9687caa thermal: core: fix some possible name leaks in error paths
b778b4d782d4 thermal/core: Protect thermal device operations against thermal device removal
05eeee2b51b4 thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
1c439dec359c thermal/core: Introduce locked version of thermal_zone_device_update
30b2ae07d3d6 thermal/core: Delete device under thermal device zone lock
d35f29ed9d11 thermal/core: Destroy thermal zone device mutex in release function
e49a1e1ee078 thermal/core: fix error code in __thermal_cooling_device_register()
c408b3d1d9bb thermal: Validate new state in cur_state_store()



The stack traces are:

-----------[ cut here ]------------
WARNING: CPU: 0 PID: 31 at lib/kobject.c:718 kobject_put+0x114/0x29c
kobject: '(null)' ((ptrval)): is not initialized, yet kobject_put() is being called.
Modules linked in:
CPU: 0 PID: 31 Comm: kworker/u8:2 Not tainted 6.2.0-rc1 #1
Hardware name: Generic DT based system
Workqueue: events_unbound deferred_probe_work_func
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x40/0x4c
 dump_stack_lvl from __warn+0x7c/0x15c
 __warn from warn_slowpath_fmt+0x98/0xcc
 warn_slowpath_fmt from kobject_put+0x114/0x29c
 kobject_put from __thermal_cooling_device_register+0x11c/0x388
 __thermal_cooling_device_register from __power_supply_register+0x49c/0x5dc
 __power_supply_register from devm_power_supply_register+0x54/0x90
 devm_power_supply_register from smbb_charger_probe+0x358/0x61c
 smbb_charger_probe from platform_probe+0x5c/0xb8
 platform_probe from really_probe+0xe0/0x3dc
 really_probe from __driver_probe_device+0x9c/0x208
 __driver_probe_device from driver_probe_device+0x30/0xcc
 driver_probe_device from __device_attach_driver+0xa8/0x120
 __device_attach_driver from bus_for_each_drv+0x84/0xd4
 bus_for_each_drv from __device_attach+0x108/0x1d8
 __device_attach from bus_probe_device+0x84/0x8c
 bus_probe_device from deferred_probe_work_func+0x9c/0xdc
 deferred_probe_work_func from process_one_work+0x1d4/0x510
 process_one_work from worker_thread+0x1fc/0x4d0
 worker_thread from kthread+0xf4/0x124
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf0901fb0 to 0xf0901ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 31 at lib/refcount.c:28 __thermal_cooling_device_register+0x11c/0x388
refcount_t: underflow; use-after-free.
Modules linked in:
CPU: 0 PID: 31 Comm: kworker/u8:2 Tainted: G        W          6.2.0-rc1 #1
Hardware name: Generic DT based system
Workqueue: events_unbound deferred_probe_work_func
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x40/0x4c
 dump_stack_lvl from __warn+0x7c/0x15c
 __warn from warn_slowpath_fmt+0x98/0xcc
 warn_slowpath_fmt from __thermal_cooling_device_register+0x11c/0x388
 __thermal_cooling_device_register from __power_supply_register+0x49c/0x5dc
 __power_supply_register from devm_power_supply_register+0x54/0x90
 devm_power_supply_register from smbb_charger_probe+0x358/0x61c
 smbb_charger_probe from platform_probe+0x5c/0xb8
 platform_probe from really_probe+0xe0/0x3dc
 really_probe from __driver_probe_device+0x9c/0x208
 __driver_probe_device from driver_probe_device+0x30/0xcc
 driver_probe_device from __device_attach_driver+0xa8/0x120
 __device_attach_driver from bus_for_each_drv+0x84/0xd4
 bus_for_each_drv from __device_attach+0x108/0x1d8
 __device_attach from bus_probe_device+0x84/0x8c
 bus_probe_device from deferred_probe_work_func+0x9c/0xdc
 deferred_probe_work_func from process_one_work+0x1d4/0x510
 process_one_work from worker_thread+0x1fc/0x4d0
 worker_thread from kthread+0xf4/0x124
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf0901fb0 to 0xf0901ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 0000000000000000 ]---


-Frank
