Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB516BBC89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjCOSms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCOSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:42:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2424ECDA;
        Wed, 15 Mar 2023 11:42:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so1926266wmb.3;
        Wed, 15 Mar 2023 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678905670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvpv3s3T6ce613wn0kOd1EG+kUFMvEFpxxq8dyeNauE=;
        b=KWIB9Znc77Xux4NHtF+VORx54+AP3zl5mHYEkO7++8WwPJU9ZfRyKlLPOWmdyQ5Puu
         PHPDS7r30fbTgpF6lkdpo3U77TPkwyi4bTN0qcm1wZ+Xuo5tS09zhzrQWOXh6xRKL90K
         T7tRP7UyR6uHN9zNz0OwsOOVBwlGYel4JktTOqfXKM/FmaH4nHd9xPeugApZYeGjaoIS
         VowDjhP4wWYnnQFYpyvzKWuheHO2P9E/qDS0Rp8OzpnWwmriL3dw2Va1dxaLrlgJ+jwg
         rVwxcOxcxDlj8iUlJrhXJqT3CXYX19tknwTpY0eULNaURfY8fnxMsPDeuYEW52ge4i7A
         glLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvpv3s3T6ce613wn0kOd1EG+kUFMvEFpxxq8dyeNauE=;
        b=ssuQinmWBideHgDixuqeJ+1aOEN5YzWygpB614TE21rhKd/zV3W88qCOWJmr8SMLBq
         aliDk6xaQbPhpEEIUkHPFyQnhZVgd9QqSIT32dTbxFWW9NokZYkavfKiDoPWWPce6/bL
         00LD0LPRWJ76Wj3v3Blo2bF5tJdwVru7jNc4qOaM3JM97dchCUo8c+kLEFaEteWISTH4
         0rLbeKkE8jz2vY+09eexwDQhHrJl4n1cqe3QVLVXwlvye5lskKABcG4DarX3iDQwMi4c
         Ivs5MYZ4ZLhR+DIlcKG5bq9JFwOdEFNdj6Niq4Zo+MqmMj9ukHHK/mEHnlqQn1sVEPq0
         +hEg==
X-Gm-Message-State: AO0yUKXoptKfu4SMVO9McopQDlM4V+OCVEUlvvE9OZhYHZpITCzngfAr
        JsEqZqU9HnxQkAtLil2Vcr4=
X-Google-Smtp-Source: AK7set8rfF13aLru59EQ38BwA5vPJ1MrK7LT2FdAJ5DOFuxnA+YrcoU5KXtYFaoaLZW2K6wSUypslw==
X-Received: by 2002:a05:600c:4fcb:b0:3eb:2e32:72c3 with SMTP id o11-20020a05600c4fcb00b003eb2e3272c3mr19366981wmq.22.1678905669788;
        Wed, 15 Mar 2023 11:41:09 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:bb77:36d:cdaf:f7f2? ([2a02:908:1256:79a0:bb77:36d:cdaf:f7f2])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d498b000000b002c7b229b1basm5341878wrq.15.2023.03.15.11.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:41:08 -0700 (PDT)
Message-ID: <980021d5-09f7-9fc3-2726-44884a57822f@gmail.com>
Date:   Wed, 15 Mar 2023 19:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG 6.3-rc1] Bad lock in ttm_bo_delayed_delete()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-media@vger.kernel.org
References: <20230307212223.7e49384a@gandalf.local.home>
 <20230307212615.7a099103@gandalf.local.home>
 <b919b550-6da8-f9f0-a0eb-0fd8af513817@amd.com>
 <20230308074333.49546088@gandalf.local.home>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230308074333.49546088@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.03.23 um 13:43 schrieb Steven Rostedt:
> On Wed, 8 Mar 2023 07:17:38 +0100
> Christian König <christian.koenig@amd.com> wrote:
>
>> What test case/environment do you run to trigger this?
> I'm running a 32bit x86 qemu instance. Attached is the config.
>
> The libvirt xml file is here: https://rostedt.org/vm-images/tracetest-32.xml
> and the VM image itself is here: https://rostedt.org/vm-images/tracetest-32.qcow2.bz2

I've started to download that, but it will take about an hour. So I 
tried to avoid that for now.

But looks like there isn't any other way to reproduce this, the code 
seems to work with both amdgpu and radeon.

My suspicion is that we just have a reference count issue in qxl or ttm 
which was never noticed because it didn't caused any problems (except 
for a minor memory corruption).

Now you get a rain of warnings because we try to grab the lock in the 
delete worker.

Christian.

>
> It happened again in another test (it's not 100% reproducible).
>
> [   23.234838] ------------[ cut here ]------------
> [   23.236391] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [   23.236429] WARNING: CPU: 0 PID: 61 at kernel/locking/mutex.c:582 __ww_mutex_lock.constprop.0+0x566/0xfec
> [   23.240990] Modules linked in:
> [   23.242368] CPU: 0 PID: 61 Comm: kworker/0:1H Not tainted 6.3.0-rc1-test-00001-ga98bd42762ed-dirty #972
> [   23.245106] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> [   23.247900] Workqueue: ttm ttm_bo_delayed_delete
> [   23.249642] EIP: __ww_mutex_lock.constprop.0+0x566/0xfec
> [   23.251563] Code: e8 2b 5a 95 ff 85 c0 0f 84 25 fb ff ff 8b 0d 18 71 3b c8 85 c9 0f 85 17 fb ff ff 68 c0 58 07 c8 68 07 77 05 c8 e8 e6 0a 40 ff <0f> 0b 58 5a e9 ff fa ff ff e8 f8 59 95 ff 85 c0 74 0e 8b 0d 18 71
> [   23.256901] EAX: 00000028 EBX: 00000000 ECX: c1847dd8 EDX: 00000002
> [   23.258849] ESI: 00000000 EDI: c12958bc EBP: c1847f00 ESP: c1847eac
> [   23.260786] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
> [   23.262840] CR0: 80050033 CR2: ffbff000 CR3: 0850e000 CR4: 00150ef0
> [   23.264781] Call Trace:
> [   23.265899]  ? lock_is_held_type+0xbe/0x10c
> [   23.267434]  ? ttm_bo_delayed_delete+0x30/0x94
> [   23.268971]  ww_mutex_lock+0x32/0x94
> [   23.270327]  ttm_bo_delayed_delete+0x30/0x94
> [   23.271818]  process_one_work+0x21a/0x538
> [   23.273242]  worker_thread+0x146/0x398
> [   23.274616]  kthread+0xea/0x10c
> [   23.275859]  ? process_one_work+0x538/0x538
> [   23.277312]  ? kthread_complete_and_exit+0x1c/0x1c
> [   23.278899]  ret_from_fork+0x1c/0x28
> [   23.280223] irq event stamp: 33
> [   23.281440] hardirqs last  enabled at (33): [<c7d28089>] _raw_spin_unlock_irqrestore+0x2d/0x58
> [   23.283860] hardirqs last disabled at (32): [<c71d4ba5>] kvfree_call_rcu+0x155/0x2ec
> [   23.286066] softirqs last  enabled at (0): [<c71217fd>] copy_process+0x989/0x2368
> [   23.288220] softirqs last disabled at (0): [<00000000>] 0x0
> [   23.289952] ---[ end trace 0000000000000000 ]---
> [   23.291501] ------------[ cut here ]------------
> [   23.293027] refcount_t: underflow; use-after-free.
> [   23.294644] WARNING: CPU: 0 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xb6/0xfc
> [   23.296959] Modules linked in:
> [   23.298168] CPU: 0 PID: 61 Comm: kworker/0:1H Tainted: G        W          6.3.0-rc1-test-00001-ga98bd42762ed-dirty #972
> [   23.301073] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> [   23.303642] Workqueue: ttm ttm_bo_delayed_delete
> [   23.305190] EIP: refcount_warn_saturate+0xb6/0xfc
> [   23.306767] Code: 68 70 e1 0c c8 e8 f6 d6 a9 ff 0f 0b 58 c9 c3 90 80 3d 8a 78 38 c8 00 75 8a c6 05 8a 78 38 c8 01 68 9c e1 0c c8 e8 d6 d6 a9 ff <0f> 0b 59 c9 c3 80 3d 88 78 38 c8 00 0f 85 67 ff ff ff c6 05 88 78
> [   23.311935] EAX: 00000026 EBX: c1295950 ECX: c1847e40 EDX: 00000002
> [   23.313884] ESI: c12958bc EDI: f7591100 EBP: c1847f18 ESP: c1847f14
> [   23.315840] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   23.317887] CR0: 80050033 CR2: ffbff000 CR3: 0850e000 CR4: 00150ef0
> [   23.319859] Call Trace:
> [   23.320978]  ttm_bo_delayed_delete+0x8c/0x94
> [   23.322492]  process_one_work+0x21a/0x538
> [   23.323959]  worker_thread+0x146/0x398
> [   23.325353]  kthread+0xea/0x10c
> [   23.326609]  ? process_one_work+0x538/0x538
> [   23.328081]  ? kthread_complete_and_exit+0x1c/0x1c
> [   23.329683]  ret_from_fork+0x1c/0x28
> [   23.331011] irq event stamp: 33
> [   23.332251] hardirqs last  enabled at (33): [<c7d28089>] _raw_spin_unlock_irqrestore+0x2d/0x58
> [   23.334334] hardirqs last disabled at (32): [<c71d4ba5>] kvfree_call_rcu+0x155/0x2ec
> [   23.336176] softirqs last  enabled at (0): [<c71217fd>] copy_process+0x989/0x2368
> [   23.337904] softirqs last disabled at (0): [<00000000>] 0x0
> [   23.339313] ---[ end trace 0000000000000000 ]---
>
> -- Steve

