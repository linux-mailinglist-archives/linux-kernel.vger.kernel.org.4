Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E35F424F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJDLty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJDLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:49:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8845C5F48
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:49:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a3so8654769wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qFB9sDD05avVlpNPZ5ecrbhywdXZAZIDy0PBMHVfs4I=;
        b=xQ09P01WTqO1XKPpjfomMIKugoQszaJVgbdv/oMHNSywyPLkUe2ZVe3k33Yx+gYA/D
         f8aXDfhI0dpGix3mE4UKIyjWu56OcjcAzM/QICzGuNp6VdGY4xKg7BIZgfKt/iletYiF
         xpyjLWFczsbyYC75xi3g0gRf7WINXodwV8MsbVXJW1fYenWdGqawqZ5kfH9FmFLiIjNJ
         027Hrpl/q8qqk/GpBYUk6NYKmIKBf6sX1Ko4kunHQeGvQgOURSr+wajndVnyGLmKbtue
         YO3r1MAdcGRyVeVRH0yVY40VXSuARy7utffXLP+/G9xpfJtgoF7Ib8Bdq4053DA1Fd0M
         m+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qFB9sDD05avVlpNPZ5ecrbhywdXZAZIDy0PBMHVfs4I=;
        b=KZ9tCV3WZyQflFmxD8cA69qzYs4QIU0yQ7efLl8NA4UJbzqzo1Q15GJUCD84m2Co//
         T+hMgkTrAlc0l13Jur+a57Acj3csMIijpt8DwfSA3KAqyV6Fd8ZPYFC3kjX4NUNRTNXW
         hwo/Ncm2urhtTuAbaSEVQtxFiWmF3+Q7cO/Z23RWC4YvjxiinkbnDZsrsSrMHO5LE4Jf
         nIykax0BiaeOAXklolGpgt6CiaujDluOig0rpNJdWejH85pjeQa8nF7KSiekMSb82lPx
         StS/Od/u+Jow3gca2kba+Qc9xbLArPe06Yg7eVo5xXqb7xmQDGtndgzh+agWpohgou1p
         xESA==
X-Gm-Message-State: ACrzQf3rgxceqQJvY57Fmm6JhM/6eRTpfntISRHW2/ZU18Aed4IS+0Vk
        6K90ccLf3oADiQNYQN32A9p8tQ==
X-Google-Smtp-Source: AMsMyM6gUbXQw0vLgvUXF7Gu1Las9a/mmXt+0iRTWJvfbyVyrbvVriY5uhq8gNWl3WMAaSJlN7KieA==
X-Received: by 2002:a05:6000:184e:b0:22e:4612:496d with SMTP id c14-20020a056000184e00b0022e4612496dmr4357252wri.91.1664884178590;
        Tue, 04 Oct 2022 04:49:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id d16-20020adfe890000000b0022e035a4e93sm11624681wrm.87.2022.10.04.04.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 04:49:38 -0700 (PDT)
Message-ID: <fe6c90ea-7b19-36d9-2568-f484c54eafff@linaro.org>
Date:   Tue, 4 Oct 2022 13:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC/RFT PATCH resend] thermal: Protect thermal device operations
 against thermal device removal
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
References: <20221004033936.1047691-1-linux@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221004033936.1047691-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 05:39, Guenter Roeck wrote:
> A call to thermal_zone_device_unregister() results in thermal device
> removal. While the thermal device itself is reference counted and
> protected against removal of its associated data structures, the
> thermal device operations are owned by the calling code and unprotected.
> This may result in crashes such as
> 
> BUG: unable to handle page fault for address: ffffffffc04ef420
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
> PGD 5d60e067 P4D 5d60e067 PUD 5d610067 PMD 110197067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 3209 Comm: cat Tainted: G        W         5.10.136-19389-g615abc6eb807 #1 02df41ac0b12f3a64f4b34245188d8875bb3bce1
> Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.92.0 11/27/2018
> RIP: 0010:thermal_zone_get_temp+0x26/0x73
> Code: 89 c3 eb d3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 85 ff 74 50 48 89 fb 48 81 ff 00 f0 ff ff 77 44 48 8b 83 98 03 00 00 <48> 83 78 10 00 74 36 49 89 f6 4c 8d bb d8 03 00 00 4c 89 ff e8 9f
> RSP: 0018:ffffb3758138fd38 EFLAGS: 00010287
> RAX: ffffffffc04ef410 RBX: ffff98f14d7fb000 RCX: 0000000000000000
> RDX: ffff98f17cf90000 RSI: ffffb3758138fd64 RDI: ffff98f14d7fb000
> RBP: ffffb3758138fd50 R08: 0000000000001000 R09: ffff98f17cf90000
> R10: 0000000000000000 R11: ffffffff8dacad28 R12: 0000000000001000
> R13: ffff98f1793a7d80 R14: ffff98f143231708 R15: ffff98f14d7fb018
> FS:  00007ec166097800(0000) GS:ffff98f1bbd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc04ef420 CR3: 000000010ee9a000 CR4: 00000000003506e0
> Call Trace:
>   temp_show+0x31/0x68
>   dev_attr_show+0x1d/0x4f
>   sysfs_kf_seq_show+0x92/0x107
>   seq_read_iter+0xf5/0x3f2
>   vfs_read+0x205/0x379
>   __x64_sys_read+0x7c/0xe2
>   do_syscall_64+0x43/0x55
>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> if a thermal device is removed while accesses to its device attributes
> are ongoing.
> 
> Use the thermal device mutex to protect device operations. Clear the
> device operations pointer in thermal_zone_device_unregister() under
> protection of this mutex, and only access it while the mutex is held.
> Flatten and simplify device mutex operations to only acquire the mutex
> once and hold it instead of acquiring and releasing it several times
> during thermal operations. Only validate parameters once at module entry
> points after acquiring the mutex. Execute governor operations under mutex
> instead of expecting governors to acquire and release it.

Does the following series:

https://lore.kernel.org/lkml/20220805153834.2510142-1-daniel.lezcano@linaro.org/

goes to the same direction than your proposal?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
