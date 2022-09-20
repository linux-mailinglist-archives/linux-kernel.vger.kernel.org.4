Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9FC5BEF74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiITVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:55:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3A61124
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:55:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u69so4063430pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=moSdgyUQl//VdZ9FP+Uw4o8zPHAVDSY+Cj1OuTJQUDw=;
        b=mHxlbgZpxeAXsEQunnTmzHYHyl0SxcZ4dsdNRzQT7muGS5AG3abMLk7v8XqMHso292
         FCoYGbuYLfeIpKsAt1gji+9UZyNwaJCWrd5x4ncRiDELmD+QByaXzb8oes5O9SKDsHSo
         JenxGWE+f9EhUa+GwAvtCzeTV7uYbq/f/yOWsbULWm3NEbvH6tgwVPBcjTy2ZxK85SDb
         5itDN5pXlZk7e5fEkwUl41zL3QwMGB5sLUBYWq8HEeLBqCfN/cvzSZEdbOAdfldBg7oK
         6uBcMW+6EGRm8f5ziIZvB6bRpIW+Jpr/z3sQZSlZa9/0x8OPm6+3q+hLQWKsLhUHl7BU
         JrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=moSdgyUQl//VdZ9FP+Uw4o8zPHAVDSY+Cj1OuTJQUDw=;
        b=iRvnijiZ85LY4u1NuVa821di9h2D2N7J4MmAyaga63S7O2yvP57RahoymDVu2XQ6U+
         xYx1x4IoJRgN7lYALYV19cuZC3JuTrwcL+DUcS2y2pVPkL/vy7VDCY2ijc6eCW6wtehj
         SuC1dR7ls2NnGV4BAn9S81qWFBNe23amMdcBZRe+WHbZ2wZmdKSOkT3yfZLx4lZXfIfa
         tuZ2eoPFR+EORvxcL/g7lU7OcYydyoimI+PpcgyU61hzVEYQzFQ5awTHIKhRyIdAAuia
         XUppyyWnb8FHbl9j/YwhgnGGV5KDeQzJBbevD97gwxV8Qby1nnEkz5o1u2TW5vKyQh0h
         HrEQ==
X-Gm-Message-State: ACrzQf0goOEZrA89roAeHjnY4aQzIzyN1X1SG3rqoeFVPMQXFxcUYoBq
        ahf+0y1htT46cD8XyYL8+OM=
X-Google-Smtp-Source: AMsMyM6MCtPVOyUx9VroC4l7EuR8z9rxuYzk3M8uylCRz0MfBOPdI3/5Q01ELslA/pYqwvBc104hvQ==
X-Received: by 2002:a63:20e:0:b0:439:34d7:5e16 with SMTP id 14-20020a63020e000000b0043934d75e16mr22099878pgc.373.1663710948369;
        Tue, 20 Sep 2022 14:55:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b0016f1ef2cd44sm367378ple.154.2022.09.20.14.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 14:55:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <edd24375-2529-bad3-acd2-f1d7b01e63e8@roeck-us.net>
Date:   Tue, 20 Sep 2022 14:55:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] riscv: enable Docker requirements in defconfig
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     heinrich.schuchardt@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        Atish Patra <atishp@rivosinc.com>, guoren@kernel.org,
        mchitale@ventanamicro.com, arnaud.pouliquen@foss.st.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-3d4c5572-e386-45d8-9ed5-fd6971a60237@palmer-ri-x1c9>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <mhng-3d4c5572-e386-45d8-9ed5-fd6971a60237@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 13:25, Palmer Dabbelt wrote:
> On Sat, 13 Aug 2022 08:58:51 PDT (-0700), linux@roeck-us.net wrote:
>> On Wed, Jun 08, 2022 at 02:02:51AM +0200, Heinrich Schuchardt wrote:
>>> The defconfig kernel should be able to run Docker.
>>>
>>> Enable the missing settings according to [1].
>>> make savedefconfig eliminates CONFIG_STACKTRACE
>>> which is enabled by default.
>>>
>>> Many of the settings are also needed to run a defconfig kernel
>>> on default distro installations or to run snaps.
>>>
>>> [1] https://github.com/moby/moby/blob/master/contrib/check-config.sh
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> This patch results in (or exposes) the following boot warning with all
>> riscv32 and riscv64 qemu boots.
>>
>> [   12.278014] DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
>> [   12.278218] WARNING: CPU: 0 PID: 140 at kernel/locking/lockdep.c:5510 check_flags+0xe2/0x1c2
>> [   12.278446] Modules linked in:
>> [   12.278623] CPU: 0 PID: 140 Comm: S01syslogd Tainted: G                 N 5.19.0-14184-g69dac8e431af #1
>> [   12.278791] Hardware name: riscv-virtio,qemu (DT)
>> [   12.278931] epc : check_flags+0xe2/0x1c2
>> [   12.279024]  ra : check_flags+0xe2/0x1c2
>> [   12.279092] epc : ffffffff80a8ea50 ra : ffffffff80a8ea50 sp : ff200000107f3cb0
>> [   12.279180]  gp : ffffffff819fec50 tp : ff600000049895c0 t0 : ffffffff81833520
>> [   12.279287]  t1 : 0000000000000001 t2 : 2d2d2d2d2d2d2d2d s0 : ff200000107f3cd0
>> [   12.279395]  s1 : ffffffff81a00130 a0 : 0000000000000030 a1 : ffffffff818925e8
>> [   12.279502]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
>> [   12.279608]  a5 : 0000000000000000 a6 : ffffffff80066d80 a7 : 0000000000000038
>> [   12.279714]  s2 : ffffffff81a024e0 s3 : ffffffff818935b0 s4 : ff200000107f3e28
>> [   12.279825]  s5 : ffffffff80e27708 s6 : 0000000200000022 s7 : ffffffffffffffff
>> [   12.279932]  s8 : ffffffff8249da18 s9 : 0000000000001000 s10: 0000000000000001
>> [   12.280037]  s11: 0000000000000001 t3 : ffffffff824740af t4 : ffffffff824740af
>> [   12.280142]  t5 : ffffffff824740b0 t6 : ff200000107f3aa8
>> [   12.280227] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
>> [   12.280382] [<ffffffff80a8eba8>] lock_is_held_type+0x78/0x14a
>> [   12.280505] [<ffffffff8003d648>] __might_resched+0x26/0x232
>> [   12.280608] [<ffffffff8003d892>] __might_sleep+0x3e/0x66
>> [   12.280690] [<ffffffff8002262c>] get_signal+0xa6/0x8f6
>> [   12.280771] [<ffffffff800051da>] do_notify_resume+0x68/0x418
>> [   12.280863] [<ffffffff80003af4>] ret_from_exception+0x0/0x10
>> [   12.280978] irq event stamp: 2900
>> [   12.281041] hardirqs last  enabled at (2899): [<ffffffff80a9761c>] _raw_spin_unlock_irqrestore+0x54/0x62
>> [   12.281176] hardirqs last disabled at (2900): [<ffffffff8000812c>] __trace_hardirqs_off+0xc/0x14
>> [   12.281303] softirqs last  enabled at (1860): [<ffffffff80a98092>] __do_softirq+0x3e2/0x51c
>> [   12.281435] softirqs last disabled at (1843): [<ffffffff80016fc8>] __irq_exit_rcu+0xb4/0xdc
>> [   12.281564] ---[ end trace 0000000000000000 ]---
>> [   12.281735] possible reason: unannotated irqs-on.
>> [   12.281815] irq event stamp: 2900
>> [   12.281875] hardirqs last  enabled at (2899): [<ffffffff80a9761c>] _raw_spin_unlock_irqrestore+0x54/0x62
>> [   12.282004] hardirqs last disabled at (2900): [<ffffffff8000812c>] __trace_hardirqs_off+0xc/0x14
>> [   12.282125] softirqs last  enabled at (1860): [<ffffffff80a98092>] __do_softirq+0x3e2/0x51c
>> [   12.282242] softirqs last disabled at (1843): [<ffffffff80016fc8>] __irq_exit_rcu+0xb4/0xdc
>>
>> Reverting this patch fixes the problem. Bisect log attached.
> 
> Sorry for having missed this report, but I don't see this now and don't remember having seen it before.  Are you still seeing the issue?
> 

Yes and no. The backtrace is only seen if CONFIG_CGROUP_FREEZER is enabled.
I disabled it in my boot tests, so I don't see it anymore.

Guenter
