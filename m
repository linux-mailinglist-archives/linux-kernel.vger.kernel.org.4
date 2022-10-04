Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD25F4566
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJDOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJDOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:24:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44867E03F;
        Tue,  4 Oct 2022 07:24:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso1270232pjq.1;
        Tue, 04 Oct 2022 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=dy/iH2hFr+D4ymKD44eYtHeCLV31egGwJ4ArCKNUmEA=;
        b=EvFBk8EJerLr35URx9NGeeexZJtc+l4vYpRDAwZNN5FgE5DvIiHVD+8plqtDXS+JZH
         8P0PTZiXT/kuUTem3Js+pYJucykY5mddKinKZZvhwqcftY4zQm6VebVfdMQJIQWQ43TW
         zOEyz7QxjhAt3Vm1Q6WbcnYcE1nc5BLElt5exv2tsaxAwfUtEJH2d5eQsldhcvpHUvnV
         6OCtw91z7K4yv2aOTPk69VNdfHsqk7BpL8DFRo8Xoc+0rzMe4Gd9oz9gx1/2Phc6ac9m
         ufIKh9Ff7dj+nDgjuiqPmxF3aC91VBEBflt62WAkTRMKSHO1eB4Rz647Ct2QpdZD5AKz
         ciXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dy/iH2hFr+D4ymKD44eYtHeCLV31egGwJ4ArCKNUmEA=;
        b=02C7VVt6cH1h7l+nNhEB3LETaLnmcI0qywJFpRnCH0DwZreXxr/14GQu3yrowHnUr6
         +M8PwButtOgFav00N9FaWL43EK/WK/+ufjae4gCZxkMP2dujAvPEemaduCQuITmb1dUD
         kocN8p0GpkviB5eIfYuxNf6KS+xD8eK4kP7zYWFqxDn9FpXV7sz/x9vCgShjGd5wl6fI
         QNIWivs81wbdxROeoR4oEOObl/xhF5gLftFkKmSx/8KB0Z+K9MzJvVkLs3dxamvXH9CA
         Q7GDs1dKMMiOsJTS36QhvFNmMhcib5EKtnTbrh9onPin7rMjpSgePwSHfcKYz7QBw6yT
         UZyw==
X-Gm-Message-State: ACrzQf1wBEbbZPpP4acJyuDuf0I4GLwcutuPl/RrNKm6vx7CG8XKvD6X
        2Rmsnksipc39Kp3k3x4KbTA=
X-Google-Smtp-Source: AMsMyM6zN+i/uoD//PFvSgXop40rSSMw3vOPpw9qjuzNNgfw+QpQN1Q35KZYTlc6gffkGw0DbzDHoA==
X-Received: by 2002:a17:90b:4a52:b0:20a:7c0b:5c0 with SMTP id lb18-20020a17090b4a5200b0020a7c0b05c0mr18402pjb.23.1664893494712;
        Tue, 04 Oct 2022 07:24:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b005614793a06dsm5099346pfk.14.2022.10.04.07.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:24:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <50423dd3-a190-80e3-79ca-0a0328dfd4c1@roeck-us.net>
Date:   Tue, 4 Oct 2022 07:24:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
References: <20221004033936.1047691-1-linux@roeck-us.net>
 <fe6c90ea-7b19-36d9-2568-f484c54eafff@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC/RFT PATCH resend] thermal: Protect thermal device operations
 against thermal device removal
In-Reply-To: <fe6c90ea-7b19-36d9-2568-f484c54eafff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 04:49, Daniel Lezcano wrote:
> On 04/10/2022 05:39, Guenter Roeck wrote:
>> A call to thermal_zone_device_unregister() results in thermal device
>> removal. While the thermal device itself is reference counted and
>> protected against removal of its associated data structures, the
>> thermal device operations are owned by the calling code and unprotected.
>> This may result in crashes such as
>>
>> BUG: unable to handle page fault for address: ffffffffc04ef420
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>> PGD 5d60e067 P4D 5d60e067 PUD 5d610067 PMD 110197067 PTE 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 1 PID: 3209 Comm: cat Tainted: G        W         5.10.136-19389-g615abc6eb807 #1 02df41ac0b12f3a64f4b34245188d8875bb3bce1
>> Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.92.0 11/27/2018
>> RIP: 0010:thermal_zone_get_temp+0x26/0x73
>> Code: 89 c3 eb d3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 85 ff 74 50 48 89 fb 48 81 ff 00 f0 ff ff 77 44 48 8b 83 98 03 00 00 <48> 83 78 10 00 74 36 49 89 f6 4c 8d bb d8 03 00 00 4c 89 ff e8 9f
>> RSP: 0018:ffffb3758138fd38 EFLAGS: 00010287
>> RAX: ffffffffc04ef410 RBX: ffff98f14d7fb000 RCX: 0000000000000000
>> RDX: ffff98f17cf90000 RSI: ffffb3758138fd64 RDI: ffff98f14d7fb000
>> RBP: ffffb3758138fd50 R08: 0000000000001000 R09: ffff98f17cf90000
>> R10: 0000000000000000 R11: ffffffff8dacad28 R12: 0000000000001000
>> R13: ffff98f1793a7d80 R14: ffff98f143231708 R15: ffff98f14d7fb018
>> FS:  00007ec166097800(0000) GS:ffff98f1bbd00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffffc04ef420 CR3: 000000010ee9a000 CR4: 00000000003506e0
>> Call Trace:
>>   temp_show+0x31/0x68
>>   dev_attr_show+0x1d/0x4f
>>   sysfs_kf_seq_show+0x92/0x107
>>   seq_read_iter+0xf5/0x3f2
>>   vfs_read+0x205/0x379
>>   __x64_sys_read+0x7c/0xe2
>>   do_syscall_64+0x43/0x55
>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>
>> if a thermal device is removed while accesses to its device attributes
>> are ongoing.
>>
>> Use the thermal device mutex to protect device operations. Clear the
>> device operations pointer in thermal_zone_device_unregister() under
>> protection of this mutex, and only access it while the mutex is held.
>> Flatten and simplify device mutex operations to only acquire the mutex
>> once and hold it instead of acquiring and releasing it several times
>> during thermal operations. Only validate parameters once at module entry
>> points after acquiring the mutex. Execute governor operations under mutex
>> instead of expecting governors to acquire and release it.
> 
> Does the following series:
> 
> https://lore.kernel.org/lkml/20220805153834.2510142-1-daniel.lezcano@linaro.org/
> 
> goes to the same direction than your proposal?
> 

Thanks for the pointer.

The series simplifies the mutex problem, but it doesn't solve the problem
I was trying to solve (the problem causing the crash above). There
is still no guarantee that thermal device ops are not accessed after
the call to thermal_zone_device_unregister().

Thanks,
Guenter
