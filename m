Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE995B2F77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIIHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIIHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:07:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A1E3D78
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:07:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw17so1003162plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5aQOmj4o6dy+y08Ndf5GP3ShJjdt3XzOKjEopk6m/lE=;
        b=TPbzxpyPzcDS/2Mu6bTugXg7Evw4zdwAU0ETEKmg6oSWWB2dTr0yCd8rRlVpzZTD1l
         A1JKGtlEa0KKAHnmb+DDf+HKhQB668P2MfErJ6E5wZHnjAIL1mElQWdH5FKfI3W14tdy
         l9eT1NqeubKDL1nNpHkATVRpnvKrBACw0b5+ALb4uPettYoqHeky9E7npLq2k5gWqO9T
         qCFcN6LLBYM+d0vhgF6eip5CM28zPLH4E8FAWfobeL7XGAzzvBC6zy8nNm3bH5ef4aHu
         TJvYlg09bqHC4hAh5HmNT8ubJngGXLekNnWPU7Stnvz7/UNY8A8x4NOke49aPy9HmgqU
         qbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5aQOmj4o6dy+y08Ndf5GP3ShJjdt3XzOKjEopk6m/lE=;
        b=FgdMFkUNFvjEDQFapTUZ8g+673bEYe+FB/3Y8e9Qpsj8BRoqsuGX6xQwD0pYOcDTmQ
         1KUaWfhgcoqkbSsBjzFCUtQQEBZZqtZCMx7xLkHXYX4oLxJmYcs/6vFqW+PHII5QFQZP
         ZmqjTKY4sSAhW7LDDgv/OJPGyjYAuTKZBHBZhrPj40WAH4czbFEoUDx9XMeTBpB0MPk1
         HSAGt6+ziILCdVgmhQ9zyX54d2k6VeKo1z0I9eA5yKVTRF9UNQs8EUep3tq+8+wOZl18
         lMyXGddKvJ+PxhwriIisxBqVn1JrVX3pcbGJCohTI11HEVq60RTiD+k4tCnH5ifLuXHb
         4trg==
X-Gm-Message-State: ACgBeo0G5PV0nJow9Z1MLFlM8U2G5ofYKE34oYM7Qu2jPPzClGX33D06
        pxcNCgrEGV2XxL43womO9cCznA==
X-Google-Smtp-Source: AA6agR6KbyVvA8JXAeum23FDcoKOigidJa7JqE+5eS/1/Rhp7TmDzQkmZjEuOFLqTQBJiEbYW6ZhDg==
X-Received: by 2002:a17:90a:c711:b0:202:5cda:765c with SMTP id o17-20020a17090ac71100b002025cda765cmr8330639pjt.35.1662707262018;
        Fri, 09 Sep 2022 00:07:42 -0700 (PDT)
Received: from [10.4.108.105] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id cv8-20020a17090afd0800b001fb53587166sm656041pjb.28.2022.09.09.00.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:07:41 -0700 (PDT)
Message-ID: <69409ea6-6daa-7973-c950-c6ca9ad96f50@bytedance.com>
Date:   Fri, 9 Sep 2022 15:07:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [ammarfaizi2-block:arm64/linux/for-next/misc 2/2]
 arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function
 'do_softirq_own_stack'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202209091157.akimiv18-lkp@intel.com>
 <a37a1b71-e7b4-4b7a-9aec-a9ce64d13d84@www.fastmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <a37a1b71-e7b4-4b7a-9aec-a9ce64d13d84@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/9 14:30, Arnd Bergmann wrote:
> On Fri, Sep 9, 2022, at 5:12 AM, kernel test robot wrote:
>> tree:   https://github.com/ammarfaizi2/linux-block
>> arm64/linux/for-next/misc
>> head:   2d2f3bb897a3de4190b1b6b296c3429d01327554
>> commit: 2d2f3bb897a3de4190b1b6b296c3429d01327554 [2/2] arm64: run
>> softirqs on the per-CPU IRQ stack
>> config: arm64-randconfig-r023-20220907
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project
>> 1546df49f5a6d09df78f569e4137ddb365a3e827)
>> reproduce (this is a W=1 build):
>>          wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm64 cross compiling tool for clang build
>>          # apt-get install binutils-aarch64-linux-gnu
>>          #
>> https://github.com/ammarfaizi2/linux-block/commit/2d2f3bb897a3de4190b1b6b296c3429d01327554
>>          git remote add ammarfaizi2-block
>> https://github.com/ammarfaizi2/linux-block
>>          git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/misc
>>          git checkout 2d2f3bb897a3de4190b1b6b296c3429d01327554
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
>> O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function 'do_softirq_own_stack' [-Wmissing-prototypes]
>>     void do_softirq_own_stack(void)
>>          ^
>>     arch/arm64/kernel/irq.c:81:1: note: declare 'static' if the function
>> is not intended to be used outside of this translation unit
>>     void do_softirq_own_stack(void)
>>     ^
>>     static
> 
> 
> I think we are missing an "#include <asm/softirq_stack.h>"
> in arch/arm64/kernel/irq.c

Indeed. Hi Catalin, do I need to resend the v4 version? Or can you help
me to apply the following code change to the for-next/misc directly?
Both are fine for me, depending on which way is convenient for you. :)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index c36ad20a52f3..181df57c812b 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -23,6 +23,7 @@
  #include <asm/daifflags.h>
  #include <asm/vmap_stack.h>
  #include <asm/exception.h>
+#include <asm/softirq_stack.h>

  /* Only access this in an NMI enter/exit */
  DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);

BTW, when I just compiled the kernel with W=1, I found a lot of
compilation warnings, which is somewhat unexpected.

Thanks,
Qi

> 
>         Arnd

-- 
Thanks,
Qi
