Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385946291EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiKOGht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKOGhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:37:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FD1EC78
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:37:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a14so22546129wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UuKsrtaUQJeoL6SglHIU57kxBsjCPLAPtRrqxxSJak=;
        b=aDYn8xC4iZwLEHcvbYuBDXyg+6vze6cdda5CscjPQGhfWiBZwtVH5WEQej6YAUhqtU
         xI8tqaBQJbBndJU2wfh+yigIjD7dgu6GcqduM5t0T2gH1IuEEkvZmXqCC+hOxYhJIuIz
         ge3DIKFr6esYlHA3ROwk7+kJ/UYNjQLpXoryYYPjLLzo4w475MJlbU12k9QUCijC6BU7
         NIzJmZ8A7SWz2R4vnzpjO7yJ7HpAsNFfdHJ63N5QxFbjn5rlu06Xiu1m3T/0rrr4TQZs
         YmUQ7Ha25qMBEH8hUEo83S0G9DUCuYJTXLEUdkS7R0M9zV2+K0YZmAj94L0jzklUbc6L
         ZbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UuKsrtaUQJeoL6SglHIU57kxBsjCPLAPtRrqxxSJak=;
        b=LHTEGUJJ/aP7Z4w37GDp/e96L0cnDCuXVDutrCBD0Q+5IQ1ob3YlL28vuyqcQc2adB
         43FvgjJVKxwcHpLKVu1v/I8sq5Y5lf2CJRZL931HpkKH5hnSvZVbFVn/WDd7hMurmnMd
         254g0svPoPA/rCT103mibYCio2P9YCtiitqLTJZNLZCJQ0+w9vIDO+20xYO5cffdV5qY
         tffZGLqlOvOBzgwThVkWPiFqT0PPIKGOTxEw3Lj99trXq349kvh6/GKh5nUuQBPX2OWu
         XCxCXnoFGABjb5MyXw/IBuiCUVPUA9zViv9PxcLy+liz/5RePYcWqctWv2MrW0mXyWig
         yZUw==
X-Gm-Message-State: ANoB5pnU/b8Bew6BYYGuhf0K9NqjcpPFohed2vAc6jxzGf5YeXwf6JGe
        7wPCZlpENF6L9svlunETSbo=
X-Google-Smtp-Source: AA0mqf7TM9Xx4ma8nFWt9AmCGjecDJFIXIL4bv9HkOXZFPxhJUnhGX+sbI19rjp3Rim2FlQlLI60sA==
X-Received: by 2002:adf:e812:0:b0:241:7277:990b with SMTP id o18-20020adfe812000000b002417277990bmr9711630wrm.672.1668494260564;
        Mon, 14 Nov 2022 22:37:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003cf878c4468sm22411983wms.5.2022.11.14.22.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:37:40 -0800 (PST)
Date:   Tue, 15 Nov 2022 09:37:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Youling Tang <tangyouling@loongson.cn>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: arch/loongarch/kernel/traps.c:250 die() warn: variable dereferenced
 before check 'regs' (see line 244)
Message-ID: <202211150324.eLx8WYhx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   094226ad94f471a9f19e8f8e7140a09c2625abaa
commit: 4e62d1d86585e1b62b4f96ee586881dd45a443dc LoongArch: Add kdump support
config: loongarch-randconfig-m031-20221114
compiler: loongarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
arch/loongarch/kernel/traps.c:250 die() warn: variable dereferenced before check 'regs' (see line 244)

vim +/regs +250 arch/loongarch/kernel/traps.c

0603839b18f4fb Huacai Chen  2022-05-31  228  void __noreturn die(const char *str, struct pt_regs *regs)
0603839b18f4fb Huacai Chen  2022-05-31  229  {
0603839b18f4fb Huacai Chen  2022-05-31  230  	static int die_counter;
0603839b18f4fb Huacai Chen  2022-05-31  231  	int sig = SIGSEGV;
0603839b18f4fb Huacai Chen  2022-05-31  232  
0603839b18f4fb Huacai Chen  2022-05-31  233  	oops_enter();
0603839b18f4fb Huacai Chen  2022-05-31  234  
0603839b18f4fb Huacai Chen  2022-05-31  235  	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
0603839b18f4fb Huacai Chen  2022-05-31  236  		       SIGSEGV) == NOTIFY_STOP)
0603839b18f4fb Huacai Chen  2022-05-31  237  		sig = 0;
0603839b18f4fb Huacai Chen  2022-05-31  238  
0603839b18f4fb Huacai Chen  2022-05-31  239  	console_verbose();
0603839b18f4fb Huacai Chen  2022-05-31  240  	raw_spin_lock_irq(&die_lock);
0603839b18f4fb Huacai Chen  2022-05-31  241  	bust_spinlocks(1);
0603839b18f4fb Huacai Chen  2022-05-31  242  
0603839b18f4fb Huacai Chen  2022-05-31  243  	printk("%s[#%d]:\n", str, ++die_counter);
0603839b18f4fb Huacai Chen  2022-05-31 @244  	show_registers(regs);
                                                               ^^^^
Dereferenced without checking.

0603839b18f4fb Huacai Chen  2022-05-31  245  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
0603839b18f4fb Huacai Chen  2022-05-31  246  	raw_spin_unlock_irq(&die_lock);
0603839b18f4fb Huacai Chen  2022-05-31  247  
0603839b18f4fb Huacai Chen  2022-05-31  248  	oops_exit();
0603839b18f4fb Huacai Chen  2022-05-31  249  
4e62d1d86585e1 Youling Tang 2022-10-12 @250  	if (regs && kexec_should_crash(current))
                                                    ^^^^
Too late.

4e62d1d86585e1 Youling Tang 2022-10-12  251  		crash_kexec(regs);
4e62d1d86585e1 Youling Tang 2022-10-12  252  
0603839b18f4fb Huacai Chen  2022-05-31  253  	if (in_interrupt())
0603839b18f4fb Huacai Chen  2022-05-31  254  		panic("Fatal exception in interrupt");
0603839b18f4fb Huacai Chen  2022-05-31  255  
0603839b18f4fb Huacai Chen  2022-05-31  256  	if (panic_on_oops)
0603839b18f4fb Huacai Chen  2022-05-31  257  		panic("Fatal exception");
0603839b18f4fb Huacai Chen  2022-05-31  258  
0603839b18f4fb Huacai Chen  2022-05-31  259  	make_task_dead(sig);
0603839b18f4fb Huacai Chen  2022-05-31  260  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

