Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7D5BEE35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiITUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiITUGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:06:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C096050E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:06:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c198so3726049pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=PWUGz0PRvdDOgM0Ab2T3T5nKb6OhR4jChuedE6kRKP8=;
        b=1NmEbPldGdjPw8Rivm7tHuXatNUeGxXgwN+BFvLdkXb/XGenizjk7CrWbAonfGj6r5
         rJmQVDAULJHCL7f/9yjG2l5N08X3omJks9isCXvo7HYvRqNaQNV+V3rV2vhso3sF1WeG
         ZoscIP7BMEDgnNmQYIXjsTPMFx07C9a8L2G04wj+tzKEJ6ZI+cGFg3eyWt31UQMipc8r
         x6bPu+a0xdw6LWvpFNMJ0zPcEJCxraHQl4lU7QoaKYrz4cuU8sazdX/cCrqZyG4m6tU5
         EBnbZNQYvPh31kskZbJ19EPKx+aTHC+9QjELV8+cQ4gTfUSDbLu9WBNMi9DyrP4E6ipx
         koVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PWUGz0PRvdDOgM0Ab2T3T5nKb6OhR4jChuedE6kRKP8=;
        b=TL2MsHAe5lCpdfgX1Lv6D52/UNNycBaun49PHg2vzr875KgyS5//rsKYCSlzSt3/zS
         LpulcjTTxUehh8ArIM4mu4Xx+7IgOdjyBc9MHSgf4/pyG93lMRWHbD6eMWiosRmmo7OT
         Jnd2kCFqtWF8nXNPeS9TRXDKhZji5W3ZLDF6ZJj75FhZVSzvPvXbU307XUNl4C9lGsy8
         pryjv/BdGCahZf1uiNFv+a6Jzfyboqo2EGr+gYlJABJg2QVQiJTNnd94Du2SUTTnvdSN
         V7lKC20avl1820N6gVpSYv4hivnBcpMHlWW35gltcUHb1/RbpJNhxVBlN8xLHgkKBq2T
         RO5A==
X-Gm-Message-State: ACrzQf03hnvK75QdgcIeyMIgyF6yfsi7KlVNxbFzVInGMfe9J+W3be+B
        MWpX7VBrgFp8CJJsc3YmIuywwQ==
X-Google-Smtp-Source: AMsMyM5yri9R+luWNYTWmVMg0VDWHKGjzrvzMzXCT3vSk0iPP333upxdS7pnCPV9LcvbUlX6FYDWxg==
X-Received: by 2002:a63:9042:0:b0:438:8ef2:2476 with SMTP id a63-20020a639042000000b004388ef22476mr22435404pge.55.1663704377133;
        Tue, 20 Sep 2022 13:06:17 -0700 (PDT)
Received: from localhost (p57a238e9.dip0.t-ipconnect.de. [87.162.56.233])
        by smtp.gmail.com with ESMTPSA id c85-20020a621c58000000b0053653c6b9f9sm275804pfc.204.2022.09.20.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:06:15 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:06:15 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Sep 2022 13:01:50 PDT (-0700)
Subject:     Re: arch/riscv/kernel/traps.c:48 die() warn: variable dereferenced before check 'regs' (see line 46)
In-Reply-To: <f6780b5a-5ce2-a7f3-dffa-2a5e5e0b2bd1@linux.alibaba.com>
CC:     dan.carpenter@oracle.com, kbuild@lists.01.org, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     xianting.tian@linux.alibaba.com
Message-ID: <mhng-0ae2d371-db11-4d05-a4e2-006c5f9303eb@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 03:42:28 PDT (-0700), xianting.tian@linux.alibaba.com wrote:
>
> 在 2022/8/11 下午6:33, Dan Carpenter 写道:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f41445645ab5d172e6090d00c332c335d8dba337
>> commit: 3f1901110a89b0e2e13adb2ac8d1a7102879ea98 RISC-V: Add fast call path of crash_kexec()
>> config: riscv-randconfig-m031-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110538.uaLOQmBs-lkp@intel.com/config)
>> compiler: riscv64-linux-gcc (GCC) 12.1.0
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> smatch warnings:
>> arch/riscv/kernel/traps.c:48 die() warn: variable dereferenced before check 'regs' (see line 46)
>>
>> vim +/regs +48 arch/riscv/kernel/traps.c
>>
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  31  void die(struct pt_regs *regs, const char *str)
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  32  {
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  33  	static int die_counter;
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  34  	int ret;
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  35
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  36  	oops_enter();
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  37
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  38  	spin_lock_irq(&die_lock);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  39  	console_verbose();
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  40  	bust_spinlocks(1);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  41
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  42  	pr_emerg("%s [#%d]\n", str, ++die_counter);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  43  	print_modules();
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  44  	show_regs(regs);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  45
>> a4c3733d32a72f Christoph Hellwig 2019-10-28 @46  	ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>>                                                                                                   ^^^^^^^^^^^
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  47
>> 3f1901110a89b0 Xianting Tian     2022-06-06 @48  	if (regs && kexec_should_crash(current))
>>                                                              ^^^^
>>
>> Delete this NULL check.
> thanks,  I will send another fixup patch to fix the issue, is it OK?

You're always welcome to send fixes, but I didn't see anything so I just 
sent along https://lore.kernel.org/r/20220920200037.6727-1-palmer@rivosinc.com/

>>
>> 3f1901110a89b0 Xianting Tian     2022-06-06  49  		crash_kexec(regs);
>> 3f1901110a89b0 Xianting Tian     2022-06-06  50
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  51  	bust_spinlocks(0);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  52  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  53  	spin_unlock_irq(&die_lock);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  54  	oops_exit();
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  55
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  56  	if (in_interrupt())
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  57  		panic("Fatal exception in interrupt");
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  58  	if (panic_on_oops)
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  59  		panic("Fatal exception");
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  60  	if (ret != NOTIFY_STOP)
>> 0e25498f8cd43c Eric W. Biederman 2021-06-28  61  		make_task_dead(SIGSEGV);
>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  62  }
>>
