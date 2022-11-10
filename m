Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71868624B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiKJUSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiKJUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:17:59 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9C4E432;
        Thu, 10 Nov 2022 12:17:46 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s206so3017929oie.3;
        Thu, 10 Nov 2022 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou3PQ5Tt3CEALi9RmryRLch6D2GFqIr6CN6604+GjCk=;
        b=I6C0pJQdn22XVI9xebvjdsrTN1M4+T5dC4bfR4jQw+Rvp/a9PB+0e+3OI0eHQrYw9y
         V8N18WOwS/rRPB2aB7L8k5wJtyIKILEoHCHP++qGGXCDknZA7RlQFKwpSug3cQ3sbtQo
         zA0YZ9msOeLyYH1RAHc+SBB8wqgXNyeQ2bw87tqsi7qGE3Jr7m77/GUTWd3Zmn3IMuWf
         frGAIOTYj4fU+qsyjVNMWRcp+cXXmQ6i8ml4dYZlbiWPzjCOk+kjoMKceh/PMtHW7VEe
         arJifUm0EnI6eyW3AP2+NC/v9BQG7SrYTM3qPApfy3M8hgd/TKuPk/Uah3/fEozntQg5
         Cyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ou3PQ5Tt3CEALi9RmryRLch6D2GFqIr6CN6604+GjCk=;
        b=tDN/ejIT2mbuDFjOoPQO9gTGJxU61D9NL+JBsfjuoPV+LRN5w+0Gn6ijVg/NsIemWo
         /pkcVktSJYLpI+b4GEtjKCw4Ke4Ry0fBENRz7hDd6Tkb8jp48upJshRtK0RUyHEm7oEc
         gH56UKTaIf0s4C0vdPbGGpzD4qKtTU2R66B8kyhfaaro7Pc0NXri5ukOPS3Xdf+1XmWA
         UV/k315Gsc+qWMp02BJOxtWITbj9KBQFjirduyqEjBuHBdJWD/DqqUkuZFFDJ4FmNCn/
         5II8Vk4rpQrsPAB3FBWpnmu7qy1yuZJrUaW34BGJPIt7Tl7oww+Tiw+/7TCZzdeg6oh6
         4JxQ==
X-Gm-Message-State: ACrzQf3Bxu8NkhKsL6DBmxak0EVyDJ/+daBFIKAjaP7musQm5W+YIrpt
        xxuPd5fAy++izkGrNE+QJYI=
X-Google-Smtp-Source: AMsMyM7Ne4sYytUBLN41y3GX5z+cLTd/c9obX4PJ1PtuE32PYo6OURFvkDhEtin5g3aL4jsXHsCZdA==
X-Received: by 2002:a05:6808:18a4:b0:34e:1fe0:d6ba with SMTP id bi36-20020a05680818a400b0034e1fe0d6bamr1967829oib.275.1668111465725;
        Thu, 10 Nov 2022 12:17:45 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:2818:2051:efa7:d112? (2603-8081-2802-9dfb-2818-2051-efa7-d112.res6.spectrum.com. [2603:8081:2802:9dfb:2818:2051:efa7:d112])
        by smtp.gmail.com with ESMTPSA id i13-20020aca2b0d000000b0035a9003b8edsm138271oik.40.2022.11.10.12.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 12:17:45 -0800 (PST)
Message-ID: <d975895b-1ece-9944-8162-c7cc003b86dd@gmail.com>
Date:   Thu, 10 Nov 2022 14:17:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: x86: clang: acpi-cpufreq.c:970:24: error: variable 'ret' is
 uninitialized when used here [-Werror,-Wuninitialized]
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <CA+G9fYtaNmXOKnwH_ih9vZyFeaD+Lvzxf3WTbAV50rBtwkPxpQ@mail.gmail.com>
 <f22ea97e-9d76-4c8b-a0c9-698db6e69a9f@app.fastmail.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <f22ea97e-9d76-4c8b-a0c9-698db6e69a9f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2022 5:19 AM, Arnd Bergmann wrote:
> On Thu, Nov 10, 2022, at 12:14, Naresh Kamboju wrote:
>> [Please ignore email this if it is already reported]
>>
>> Kernel build warning noticed on x86_64 with clang toolchain [1].
>> Build failures noticed from next-20221108 .. next-20221110.
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
>> ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- HOSTCC=clang
>> CC=clang
>> drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is
>> uninitialized when used here [-Werror,-Wuninitialized]
>>          acpi_cpufreq_online = ret;
>>                                ^~~
>> drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable
>> 'ret' to silence this warning
>>          int ret;
>>                 ^
>>                  = 0
>> 1 error generated.
> 
> This is caused by 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs"),
> which removes the initialization of this variable.
> 
>        Arnd

Yes, I apologize for missing that.  A patch has already been submitted to
fix this:

https://lore.kernel.org/lkml/20221108170103.3375832-1-nathan@kernel.org/
