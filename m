Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C893872AEF4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjFJVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFJVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 17:14:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C1DA;
        Sat, 10 Jun 2023 14:14:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3be6c0b4cso790685ad.3;
        Sat, 10 Jun 2023 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686431649; x=1689023649;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwSnkwhmwp112bJQnIFMHYgVOaOrFSdte6uBVZoZTyw=;
        b=YHiV1L1XrQ05Vmg1SThZ3JwAuNoT9YM+/3VKDVsHR5LLuvBg/UL4GpbFVUih/CYBLy
         9acra23fFx1pVt18NUez5UMP3dJobntDaY9IIGd3Mbshiut/qGXHdcciEOsbUuA9emRC
         OTCkuu+qcSm9sm8rItGX4R0JLmK+67j7lD9HEuSospLH9z9zMWlSYz7vLh6g90BmMiR9
         7v9mJmVhfsPspLzw9l/0zefSkxRDNJvBiBh8FE2/gUIs6BhGtFZGpKIiItl1tL0/38hm
         b7T1+zh0DEvsvbqaca8e5ALQB5cF5neZTmATekH4GiJLT0nkGwUi3qQF43oAL7x1ynSE
         ro9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686431649; x=1689023649;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwSnkwhmwp112bJQnIFMHYgVOaOrFSdte6uBVZoZTyw=;
        b=UtDs1fmfumRBTdsLy6JImmX532XxQbKRIVIwZ2dFpPfVcwlp7V80G+O1rXiKKrCP4W
         3c/SQu0RGf9cwcTsn6URk1IVar4HDUimUWlsk83oZgGkLBzzAfBhgTJ6TPvhECA2TMhA
         6PxFHe/OoyfdpZgH11HANKFVVv3AxRmKuf+sHmUUnqa6m7C63yKKYdZHbpGbJ99WTF5s
         OSB+v0FNWZ5QaLOKBAYbWnRbP4LPLC+4TYR5z2b3T/3okUQlGjetP4VB7LHe6imZCT2v
         tgAKgBZYeDhrIbnWQXi4MfUduHeZEO5ETRA0OLBMhMIH2rEeM/mX/c3zT6ye8PHOzG47
         lKog==
X-Gm-Message-State: AC+VfDwA43C4yGScmtMm5oVOCDudHlAoUYJelGIil6J7D49PR9CfDOn3
        u7Y8PvzR3bddXC48cshVYyc=
X-Google-Smtp-Source: ACHHUZ4bIToj/UioCH9Fxd3nKofkQ4Bv57VphE1mNt36PvZjW0S7G2634DFjzInhqgWukrl7vQTFNA==
X-Received: by 2002:a17:902:d492:b0:1b0:113e:1047 with SMTP id c18-20020a170902d49200b001b0113e1047mr3161439plg.62.1686431648868;
        Sat, 10 Jun 2023 14:14:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b001a24cded097sm5402462plg.236.2023.06.10.14.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 14:14:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <39b34446-88a7-eeb5-cf95-e4f1843100b3@roeck-us.net>
Date:   Sat, 10 Jun 2023 14:14:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
References: <20230607200903.652580797@linuxfoundation.org>
 <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
 <ZITNw9cv/WoZcSaO@duo.ucw.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
In-Reply-To: <ZITNw9cv/WoZcSaO@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/10/23 12:23, Pavel Machek wrote:
> Hi!
> 
>>> Build results:
>>> 	total: 155 pass: 155 fail: 0
>>> Qemu test results:
>>> 	total: 499 pass: 498 fail: 1
>>> Failed tests:
>>> 	arm:kudo-bmc:multi_v7_defconfig:npcm:usb0.1:nuvoton-npcm730-kudo:rootfs
>>>
>>> The test failure is spurious and not new. I observe it randomly on
>>> multi_v7_defconfig builds, primarily on npcm platforms. There is no error
>>> message, just a stalled boot. I have been trying to bisect for a while,
>>> but I have not been successful so far. No immediate concern; I just wanted
>>> to mention it in case someone else hits the same or a similar problem.
>>>
>>
>> I managed to revise my bisect script sufficiently enough to get reliable
>> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
>> Ensure pool refill (again)"); see bisect log below. Bisect on four
>> different systems all have the same result. After reverting this patch,
>> I do not see the problem anymore (again, confirmed on four different
>> systems). If anyone has an idea how to debug this, please let me know.
>> I'll be happy to give it a try.
> 
> You may want to comment out debug_objects_fill_pool() in
> debug_object_activate or debug_object_assert_init to see which one is
> causing the failure...
> 
> CONFIG_PREEMPT_RT is disabled for you, right? (Should 5.15 even have
> that option?)
> 

CONFIG_PREEMPT_RT is disabled (it depends on ARCH_SUPPORTS_RT which is not
enabled by any architecture in v5.15.y).

The added call in debug_object_activate() triggers the problem.
Any idea what to do about it or how to debug it further ?

Thanks,
Guenter

