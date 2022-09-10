Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752C5B44F3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIJHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIJHug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 03:50:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915731CB01
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 00:50:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u132so3747148pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dt2OAvtuqDumbkn/MrsQ9uanevxL0KkSOfPOC0rhFvA=;
        b=JHtIiq70aFWQwaChjGYCDAdDui7sJYmQCZgghJ6c6OO/6w1ZiTLwUfLI/0Toa6I5Cq
         JKoq44S+/axf7YzU3jou6t/MObjG12PoDx+E+k4gbtSwW7WAWY5kjLXPdjslQFxydEkq
         gzgC7Ykrud5COuHEMj7lLE/Lcp3wStyVwvyC+MsQQRDV/BeUnnhF7ZAloeoWM5WcR8Do
         guXPvzQANnK1bg2qYJ5uTOypimi5ohiphAQmTYdCK/Ur/YloomOZG8XVi8DHQMxtMhEL
         Li1T3zsRAuhly0+kyxNn6nvGK+10pqZ/jl6IipsCmZmgAhwoJELnmxUCPj+shyzU+fB9
         YxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dt2OAvtuqDumbkn/MrsQ9uanevxL0KkSOfPOC0rhFvA=;
        b=oZotbAvhI1jzV7lrNPpvsWKxcgUmndViqe+LrDa2pEUsawTr4CPVlObo2SQFO+/aWW
         Dr+e4TzxJ5InVDZGMhfPd87+XHkH4fft99V4kHJ4o1gXtBedRDEyHFTRxiXreP110kZj
         52vLyeQZOEYnBC+caPW3SMpB32pbz3evSx/IbWwTU4fNUDzAEejGMMzY4HSuwDm1/Uhw
         dRvomNinPgc0b1gocUeSQFjq++0cCMtmkmj0dmQ44LVSSn2Vk3/0KI/Gt8xB9IgeSQZx
         zDCEzx1cpVK19ce1uWxQ8DJS7k+2YOMxQ1+9E8cSD4zrAVUPllkG5MJmYhk7NXhag2dX
         u3Lw==
X-Gm-Message-State: ACgBeo0iSzzJXz4x1scVeitWt2G5ShKbWlgoq8co5ED9MURIKhmXmdG8
        h8LpvfIopcaD7tf2jT2xCDOf7Q==
X-Google-Smtp-Source: AA6agR4HDi5XYbZZ1HQqACG68+NrdY4RdmXUW55j8pwyIXVZlASdBcrbE2rMZ4Om4jLkH8LXhuH9dg==
X-Received: by 2002:a65:4609:0:b0:434:8f0b:5d05 with SMTP id v9-20020a654609000000b004348f0b5d05mr15222722pgq.606.1662796233107;
        Sat, 10 Sep 2022 00:50:33 -0700 (PDT)
Received: from [10.4.108.105] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00535e950aa28sm1032535pfq.131.2022.09.10.00.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 00:50:31 -0700 (PDT)
Message-ID: <0c594ac2-d775-6424-6850-191c0c30275d@bytedance.com>
Date:   Sat, 10 Sep 2022 15:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [ammarfaizi2-block:arm64/linux/for-next/misc 2/2]
 arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function
 'do_softirq_own_stack'
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202209091157.akimiv18-lkp@intel.com>
 <a37a1b71-e7b4-4b7a-9aec-a9ce64d13d84@www.fastmail.com>
 <69409ea6-6daa-7973-c950-c6ca9ad96f50@bytedance.com>
 <Yxt/ICkxAH/+tn08@arm.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Yxt/ICkxAH/+tn08@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/10 02:00, Catalin Marinas wrote:
> On Fri, Sep 09, 2022 at 03:07:36PM +0800, Qi Zheng wrote:
>> On 2022/9/9 14:30, Arnd Bergmann wrote:
>>> On Fri, Sep 9, 2022, at 5:12 AM, kernel test robot wrote:
>>>> tree:   https://github.com/ammarfaizi2/linux-block
>>>> arm64/linux/for-next/misc
>>>> head:   2d2f3bb897a3de4190b1b6b296c3429d01327554
>>>> commit: 2d2f3bb897a3de4190b1b6b296c3429d01327554 [2/2] arm64: run
>>>> softirqs on the per-CPU IRQ stack
>>>> config: arm64-randconfig-r023-20220907
>>>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project
>>>> 1546df49f5a6d09df78f569e4137ddb365a3e827)
>>>> reproduce (this is a W=1 build):
>>>>           wget
>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>>> -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # install arm64 cross compiling tool for clang build
>>>>           # apt-get install binutils-aarch64-linux-gnu
>>>>           #
>>>> https://github.com/ammarfaizi2/linux-block/commit/2d2f3bb897a3de4190b1b6b296c3429d01327554
>>>>           git remote add ammarfaizi2-block
>>>> https://github.com/ammarfaizi2/linux-block
>>>>           git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/misc
>>>>           git checkout 2d2f3bb897a3de4190b1b6b296c3429d01327554
>>>>           # save the config file
>>>>           mkdir build_dir && cp config build_dir/.config
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
>>>> O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/
>>>>
>>>> If you fix the issue, kindly add following tag where applicable
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>>> arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function 'do_softirq_own_stack' [-Wmissing-prototypes]
>>>>      void do_softirq_own_stack(void)
>>>>           ^
>>>>      arch/arm64/kernel/irq.c:81:1: note: declare 'static' if the function
>>>> is not intended to be used outside of this translation unit
>>>>      void do_softirq_own_stack(void)
>>>>      ^
>>>>      static
>>>
>>>
>>> I think we are missing an "#include <asm/softirq_stack.h>"
>>> in arch/arm64/kernel/irq.c
>>
>> Indeed. Hi Catalin, do I need to resend the v4 version? Or can you help
>> me to apply the following code change to the for-next/misc directly?
>> Both are fine for me, depending on which way is convenient for you. :)
> 
> I'll fold this in, that's the easiest.

Thank you very much! :)

> 
> Thanks.
> 

-- 
Thanks,
Qi
