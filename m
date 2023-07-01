Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E5744654
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGADbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGADaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:30:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF4187
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688182022; x=1719718022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s6BqK33L91Bizx8XgIMjigpeyBQfncNZWD/2WqFfwdE=;
  b=dHdIbkb5EL7hwH3HEdVhWGu9bJVxz7T4s84Jd0PhW8J9Txl3M0kLKW8J
   DzZ1ok0b9RIa+H0402Df4KqXZKq0KJSanhC+KWEDP09oc2QrYo4/mKNzY
   kz5GHFPjeu1qUjO/sp210RS5ps1o4CYSJ0N0gYhtReKjWwNszIyc/xwWj
   gJax5CTJLeySMAp4G/07048HeDscKfqADjHobufOo8ODa0Iy3AbBU50wG
   /fh/Lkv6VdcZmEccBXXt2nQG5RWhq9PiTXvhPjMUsmn3VAgsTLam9I0Gw
   nVSIWkqS30B4EhiTwMyO/Nkwi0NAyRKR9ydb1zRLmON560Ivw73SnBwvn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="360017827"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="360017827"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 20:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="721167923"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="721167923"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2023 20:04:52 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFQuq-000FbU-0A;
        Sat, 01 Jul 2023 03:04:52 +0000
Date:   Sat, 1 Jul 2023 11:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202307011017.8dSIEMMe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b25f62ccb490680a8cee755ac4528909395e0711
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   11 months ago
config: loongarch-randconfig-r073-20230627 (https://download.01.org/0day-ci/archive/20230701/202307011017.8dSIEMMe-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307011017.8dSIEMMe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307011017.8dSIEMMe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1307:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __res @@
   kernel/fork.c:1307:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1307:22: sparse:     got struct file [noderef] __rcu *[assigned] __res
   kernel/fork.c:1638:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1638:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1638:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1647:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1647:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1647:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1648:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:36: sparse:     expected void const *
   kernel/fork.c:1648:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1649:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1649:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1649:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1742:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/fork.c:1742:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/fork.c:1742:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/fork.c:2061:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2061:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2061:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2065:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2065:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2065:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
   kernel/fork.c:2385:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *task @@
   kernel/fork.c:2385:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2385:32: sparse:     got struct task_struct *task
   kernel/fork.c:2394:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2394:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2394:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2439:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2439:54: sparse:     expected struct list_head *head
   kernel/fork.c:2439:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2460:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2460:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2460:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2481:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2481:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2481:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2508:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2508:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2508:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2537:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2537:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2537:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2539:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2539:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2539:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2975:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2975:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2975:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3056:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3056:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3056:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2106:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/loongarch/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2437:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2438:59: sparse: sparse: dereference of noderef expression
--
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
--
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
   kernel/workqueue.c:3537:13: sparse: sparse: context imbalance in 'wq_manager_inactive' - different lock contexts for basic block
   kernel/workqueue.c:3592:9: sparse: sparse: context imbalance in 'put_unbound_pool' - unexpected unlock
--
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
--
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
--
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
   kernel/sched/fair.c:930:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:930:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:930:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:2527:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/fair.c:2527:13: sparse:     expected struct task_struct *tsk
   kernel/sched/fair.c:2527:13: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10928:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10928:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10928:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6774:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6774:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:6774:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6908:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6908:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:6908:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7106:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7106:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7106:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7404:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7404:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7404:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8389:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:8389:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:8389:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:8933:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:8933:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:8933:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10203:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10203:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10203:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:9863:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:9863:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:9863:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:10299:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10299:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10299:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:5520:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
--
   kernel/sched/topology.c:1076:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1076:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1180:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1180:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1180:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1589:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1589:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1589:43: sparse:     got struct sched_domain *child
   kernel/sched/topology.c:1727:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/topology.c:1727:21: sparse:    int [noderef] __rcu *
   kernel/sched/topology.c:1727:21: sparse:    int *
   kernel/sched/topology.c:1853:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/topology.c:1853:9: sparse:    int [noderef] __rcu *
   kernel/sched/topology.c:1853:9: sparse:    int *
   kernel/sched/topology.c:1908:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/topology.c:1908:9: sparse:    struct cpumask **[noderef] __rcu *
   kernel/sched/topology.c:1908:9: sparse:    struct cpumask ***
   kernel/sched/topology.c:1966:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/topology.c:1966:9: sparse:    int [noderef] __rcu *
   kernel/sched/topology.c:1966:9: sparse:    int *
   kernel/sched/topology.c:1968:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/topology.c:1968:9: sparse:    struct cpumask **[noderef] __rcu *
   kernel/sched/topology.c:1968:9: sparse:    struct cpumask ***
   kernel/sched/topology.c:2052:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/topology.c:2052:17: sparse:    struct cpumask **[noderef] __rcu *
   kernel/sched/topology.c:2052:17: sparse:    struct cpumask ***
   kernel/sched/topology.c:2186:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2186:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2186:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2289:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2289:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2289:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2310:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2310:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2310:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:2309:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2309:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2309:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2357:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2357:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2357:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/psi.c:143:1: sparse: sparse: symbol 'psi_cgroups_enabled' was not declared. Should it be static?
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/membarrier.c:205:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:205:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:205:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:205:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:205:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:205:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:205:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:205:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:205:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:205:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:205:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:205:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:229:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:229:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:229:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:229:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:229:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:229:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:229:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:229:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:229:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:229:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:229:9: sparse:     expected void *ptr
   kernel/sched/membarrier.c:229:9: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:432:17: sparse:     expected void *ptr
   kernel/sched/membarrier.c:432:17: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:432:17: sparse:     expected void *ptr
   kernel/sched/membarrier.c:432:17: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:432:17: sparse:     expected void *ptr
   kernel/sched/membarrier.c:432:17: sparse:     got int [noderef] __percpu *
   kernel/sched/membarrier.c:432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/membarrier.c:432:17: sparse:     expected void *ptr
   kernel/sched/membarrier.c:432:17: sparse:     got int [noderef] __percpu *
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1737:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1737:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1737:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1750:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1750:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1750:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1737:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1737:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1737:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1750:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1750:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1750:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:949:31: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1610:19: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2340:51: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2341:49: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2343:52: sparse: sparse: dereference of noderef expression
   kernel/sched/build_utility.c: note: in included file (through include/linux/hrtimer.h, include/linux/sched.h, include/linux/sched/signal.h, ...):
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/psi.c:746:13: sparse: sparse: dereference of noderef expression
   kernel/sched/psi.c:770:38: sparse: sparse: dereference of noderef expression
   kernel/sched/psi.c:990:6: sparse: sparse: context imbalance in 'cgroup_move_task' - different lock contexts for basic block
--
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
   kernel/sched/core.c:1033:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1033:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1033:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1091:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:1091:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:1091:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:2197:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2197:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2197:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2197:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2197:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2197:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3597:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3597:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3597:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3794:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3794:28: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3794:28: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:9084:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:9084:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:9084:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5404:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5404:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5404:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5495:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5495:14: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5495:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6350:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6350:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6350:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6872:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6872:17: sparse:    struct task_struct *
   kernel/sched/core.c:6872:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7076:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7076:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7076:22: sparse:    struct task_struct *
   kernel/sched/core.c:11116:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11116:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11116:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:537:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:562:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:586:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:624:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:665:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:78:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:78:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:78:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2188:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2189:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2190:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/core.c:2163:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2163:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2163:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/core.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:242:9: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_w'
   arch/loongarch/include/asm/loongarch.h:242:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_d'
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:232:16: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/loongarch.h:232:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:242:9: sparse: sparse: cast from unknown type
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
--
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
--
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
--
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3337:49: sparse: sparse: cast truncates bits from constant value (50000 becomes 0)
   kernel/locking/lockdep.c:3337:49: sparse: sparse: cast truncates bits from constant value (50000 becomes 0)
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:118:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:118:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:118:13: sparse:     got unsigned int [noderef] __percpu *
--
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:2475:9: sparse: sparse: context imbalance in 'deactivate_slab' - different lock contexts for basic block
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:2509:55: sparse: sparse: context imbalance in '__unfreeze_partials' - unexpected unlock
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:3350:47: sparse: sparse: context imbalance in '__slab_free' - unexpected unlock
--
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
--
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
--
   kernel/rcu/update.c: note: in included file:
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:476:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:476:9: sparse:     expected void *ptr
--
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:958:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:958:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:958:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:958:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:958:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:958:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: too many warnings
--
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c: note: in included file:
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
--
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
--
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
   kernel/time/hrtimer.c:175:33: sparse: sparse: context imbalance in 'lock_hrtimer_base' - wrong count at exit
   kernel/time/hrtimer.c:1301:28: sparse: sparse: context imbalance in 'hrtimer_start_range_ns' - unexpected unlock
   kernel/time/hrtimer.c:1336:28: sparse: sparse: context imbalance in 'hrtimer_try_to_cancel' - unexpected unlock
   kernel/time/hrtimer.c:1457:9: sparse: sparse: context imbalance in '__hrtimer_get_remaining' - unexpected unlock
--
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
   kernel/time/posix-cpu-timers.c: note: in included file:
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/time/posix-cpu-timers.c:42:5: sparse: sparse: context imbalance in 'update_rlimit_cpu' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
--
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:490:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/time/tick-sched.c:490:17: sparse:     expected struct lockdep_map const *lock
   kernel/time/tick-sched.c:490:17: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
--
   net/core/gen_estimator.c:71:9: sparse: sparse: context imbalance in 'est_fetch_counters' - different lock contexts for basic block
   net/core/gen_estimator.c: note: in included file (through include/linux/hrtimer.h, include/linux/sched.h, include/linux/uaccess.h):
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   net/core/gen_estimator.c:192:9: sparse: sparse: context imbalance in 'gen_new_estimator' - different lock contexts for basic block
--
   net/core/dev.c:3325:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3325:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3325:23: sparse:     got unsigned int
   net/core/dev.c:3325:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:204:9: sparse: sparse: context imbalance in 'unlist_netdevice' - different lock contexts for basic block
   net/core/dev.c:3829:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
   net/core/dev.c:5056:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
--
   lib/flex_proportions.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/percpu_counter.h, ...):
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
--
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:2864:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2864:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2864:38: sparse:     got struct event_filter [noderef] __rcu *filter
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *
--
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:94:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:94:17: sparse:     expected void *ptr
--
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:999:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace_events.c:999:31: sparse:     expected struct event_filter *filter
   kernel/trace/trace_events.c:999:31: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *

vim +2096 kernel/fork.c

67197a4f28d28d Suren Baghdasaryan    2020-10-13  1966  
^1da177e4c3f41 Linus Torvalds        2005-04-16  1967  /*
^1da177e4c3f41 Linus Torvalds        2005-04-16  1968   * This creates a new process as a copy of the old one,
^1da177e4c3f41 Linus Torvalds        2005-04-16  1969   * but does not actually start it yet.
^1da177e4c3f41 Linus Torvalds        2005-04-16  1970   *
^1da177e4c3f41 Linus Torvalds        2005-04-16  1971   * It copies the registers, and all the appropriate
^1da177e4c3f41 Linus Torvalds        2005-04-16  1972   * parts of the process environment (as per the clone
^1da177e4c3f41 Linus Torvalds        2005-04-16  1973   * flags). The actual kick-off is left to the caller.
^1da177e4c3f41 Linus Torvalds        2005-04-16  1974   */
0766f788eb727e Emese Revfy           2016-06-20  1975  static __latent_entropy struct task_struct *copy_process(
09a05394fe2448 Roland McGrath        2008-07-25  1976  					struct pid *pid,
3033f14ab78c32 Josh Triplett         2015-06-25  1977  					int trace,
7f192e3cd316ba Christian Brauner     2019-05-25  1978  					int node,
7f192e3cd316ba Christian Brauner     2019-05-25  1979  					struct kernel_clone_args *args)
^1da177e4c3f41 Linus Torvalds        2005-04-16  1980  {
b3e5838252665e Christian Brauner     2019-03-27  1981  	int pidfd = -1, retval;
a24efe62dd165b Mariusz Kozlowski     2007-10-18  1982  	struct task_struct *p;
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  1983  	struct multiprocess_signals delayed;
6fd2fe494b17bf Al Viro               2019-06-26  1984  	struct file *pidfile = NULL;
c5febea0956fd3 Eric W. Biederman     2022-04-08  1985  	const u64 clone_flags = args->flags;
769071ac9f20b6 Andrei Vagin          2019-11-12  1986  	struct nsproxy *nsp = current->nsproxy;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1987  
667b60946ef9b8 Marcos Paulo de Souza 2018-02-06  1988  	/*
667b60946ef9b8 Marcos Paulo de Souza 2018-02-06  1989  	 * Don't allow sharing the root directory with processes in a different
667b60946ef9b8 Marcos Paulo de Souza 2018-02-06  1990  	 * namespace
667b60946ef9b8 Marcos Paulo de Souza 2018-02-06  1991  	 */
^1da177e4c3f41 Linus Torvalds        2005-04-16  1992  	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
^1da177e4c3f41 Linus Torvalds        2005-04-16  1993  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1994  
e66eded8309ebf Eric W. Biederman     2013-03-13  1995  	if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) == (CLONE_NEWUSER|CLONE_FS))
e66eded8309ebf Eric W. Biederman     2013-03-13  1996  		return ERR_PTR(-EINVAL);
e66eded8309ebf Eric W. Biederman     2013-03-13  1997  
^1da177e4c3f41 Linus Torvalds        2005-04-16  1998  	/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  1999  	 * Thread groups must share signals as well, and detached threads
^1da177e4c3f41 Linus Torvalds        2005-04-16  2000  	 * can only be started up within the thread group.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2001  	 */
^1da177e4c3f41 Linus Torvalds        2005-04-16  2002  	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
^1da177e4c3f41 Linus Torvalds        2005-04-16  2003  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2004  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2005  	/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  2006  	 * Shared signal handlers imply shared VM. By way of the above,
^1da177e4c3f41 Linus Torvalds        2005-04-16  2007  	 * thread groups also imply shared VM. Blocking this case allows
^1da177e4c3f41 Linus Torvalds        2005-04-16  2008  	 * for various simplifications in other code.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2009  	 */
^1da177e4c3f41 Linus Torvalds        2005-04-16  2010  	if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
^1da177e4c3f41 Linus Torvalds        2005-04-16  2011  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2012  
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2013  	/*
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2014  	 * Siblings of global init remain as zombies on exit since they are
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2015  	 * not reaped by their parent (swapper). To solve this and to avoid
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2016  	 * multi-rooted process trees, prevent global and container-inits
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2017  	 * from creating siblings.
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2018  	 */
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2019  	if ((clone_flags & CLONE_PARENT) &&
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2020  				current->signal->flags & SIGNAL_UNKILLABLE)
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2021  		return ERR_PTR(-EINVAL);
123be07b0b3996 Sukadev Bhattiprolu   2009-09-23  2022  
8382fcac1b813a Eric W. Biederman     2012-12-20  2023  	/*
40a0d32d1eaffe Oleg Nesterov         2013-09-11  2024  	 * If the new process will be in a different pid or user namespace
faf00da544045f Eric W. Biederman     2015-08-10  2025  	 * do not allow it to share a thread group with the forking task.
8382fcac1b813a Eric W. Biederman     2012-12-20  2026  	 */
faf00da544045f Eric W. Biederman     2015-08-10  2027  	if (clone_flags & CLONE_THREAD) {
40a0d32d1eaffe Oleg Nesterov         2013-09-11  2028  		if ((clone_flags & (CLONE_NEWUSER | CLONE_NEWPID)) ||
769071ac9f20b6 Andrei Vagin          2019-11-12  2029  		    (task_active_pid_ns(current) != nsp->pid_ns_for_children))
769071ac9f20b6 Andrei Vagin          2019-11-12  2030  			return ERR_PTR(-EINVAL);
769071ac9f20b6 Andrei Vagin          2019-11-12  2031  	}
769071ac9f20b6 Andrei Vagin          2019-11-12  2032  
769071ac9f20b6 Andrei Vagin          2019-11-12  2033  	/*
769071ac9f20b6 Andrei Vagin          2019-11-12  2034  	 * If the new process will be in a different time namespace
769071ac9f20b6 Andrei Vagin          2019-11-12  2035  	 * do not allow it to share VM or a thread group with the forking task.
769071ac9f20b6 Andrei Vagin          2019-11-12  2036  	 */
769071ac9f20b6 Andrei Vagin          2019-11-12  2037  	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
769071ac9f20b6 Andrei Vagin          2019-11-12  2038  		if (nsp->time_ns != nsp->time_ns_for_children)
8382fcac1b813a Eric W. Biederman     2012-12-20  2039  			return ERR_PTR(-EINVAL);
40a0d32d1eaffe Oleg Nesterov         2013-09-11  2040  	}
8382fcac1b813a Eric W. Biederman     2012-12-20  2041  
b3e5838252665e Christian Brauner     2019-03-27  2042  	if (clone_flags & CLONE_PIDFD) {
b3e5838252665e Christian Brauner     2019-03-27  2043  		/*
b3e5838252665e Christian Brauner     2019-03-27  2044  		 * - CLONE_DETACHED is blocked so that we can potentially
b3e5838252665e Christian Brauner     2019-03-27  2045  		 *   reuse it later for CLONE_PIDFD.
b3e5838252665e Christian Brauner     2019-03-27  2046  		 * - CLONE_THREAD is blocked until someone really needs it.
b3e5838252665e Christian Brauner     2019-03-27  2047  		 */
7f192e3cd316ba Christian Brauner     2019-05-25  2048  		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
b3e5838252665e Christian Brauner     2019-03-27  2049  			return ERR_PTR(-EINVAL);
b3e5838252665e Christian Brauner     2019-03-27  2050  	}
b3e5838252665e Christian Brauner     2019-03-27  2051  
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2052  	/*
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2053  	 * Force any signals received before this point to be delivered
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2054  	 * before the fork happens.  Collect up signals sent to multiple
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2055  	 * processes that happen during the fork and delay them so that
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2056  	 * they appear to happen after the fork.
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2057  	 */
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2058  	sigemptyset(&delayed.signal);
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2059  	INIT_HLIST_NODE(&delayed.node);
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2060  
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2061  	spin_lock_irq(&current->sighand->siglock);
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2062  	if (!(clone_flags & CLONE_THREAD))
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2063  		hlist_add_head(&delayed.node, &current->signal->multiprocess);
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2064  	recalc_sigpending();
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2065  	spin_unlock_irq(&current->sighand->siglock);
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2066  	retval = -ERESTARTNOINTR;
66ae0d1e2d9fe6 Jens Axboe            2021-03-22  2067  	if (task_sigpending(current))
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2068  		goto fork_out;
c3ad2c3b02e953 Eric W. Biederman     2018-07-23  2069  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2070  	retval = -ENOMEM;
725fc629ff2545 Andi Kleen            2016-05-23  2071  	p = dup_task_struct(current, node);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2072  	if (!p)
^1da177e4c3f41 Linus Torvalds        2005-04-16  2073  		goto fork_out;
753550eb0ce1fe Eric W. Biederman     2022-04-11  2074  	p->flags &= ~PF_KTHREAD;
753550eb0ce1fe Eric W. Biederman     2022-04-11  2075  	if (args->kthread)
753550eb0ce1fe Eric W. Biederman     2022-04-11  2076  		p->flags |= PF_KTHREAD;
b16b3855d89fba Jens Axboe            2021-03-26  2077  	if (args->io_thread) {
b16b3855d89fba Jens Axboe            2021-03-26  2078  		/*
b16b3855d89fba Jens Axboe            2021-03-26  2079  		 * Mark us an IO worker, and block any signal that isn't
b16b3855d89fba Jens Axboe            2021-03-26  2080  		 * fatal or STOP
b16b3855d89fba Jens Axboe            2021-03-26  2081  		 */
cc440e8738e5c8 Jens Axboe            2021-03-04  2082  		p->flags |= PF_IO_WORKER;
b16b3855d89fba Jens Axboe            2021-03-26  2083  		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
b16b3855d89fba Jens Axboe            2021-03-26  2084  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  2085  
7f192e3cd316ba Christian Brauner     2019-05-25  2086  	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
4d6501dce079c1 Vegard Nossum         2017-05-09  2087  	/*
4d6501dce079c1 Vegard Nossum         2017-05-09  2088  	 * Clear TID on mm_release()?
4d6501dce079c1 Vegard Nossum         2017-05-09  2089  	 */
7f192e3cd316ba Christian Brauner     2019-05-25  2090  	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;
4d6501dce079c1 Vegard Nossum         2017-05-09  2091  
f7e8b616ed1cc6 Steven Rostedt        2009-06-02  2092  	ftrace_graph_init_task(p);
f7e8b616ed1cc6 Steven Rostedt        2009-06-02  2093  
bea493a031fe33 Peter Zijlstra        2006-10-17  2094  	rt_mutex_init_task(p);
bea493a031fe33 Peter Zijlstra        2006-10-17  2095  
a21ee6055c30ce Peter Zijlstra        2020-05-25 @2096  	lockdep_assert_irqs_enabled();
d12c1a37925a8e Ingo Molnar           2008-07-14  2097  #ifdef CONFIG_PROVE_LOCKING
de30a2b355ea85 Ingo Molnar           2006-07-03  2098  	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
de30a2b355ea85 Ingo Molnar           2006-07-03  2099  #endif
8f2f9c4d82f24f Eric W. Biederman     2022-02-09  2100  	retval = copy_creds(p, clone_flags);
8f2f9c4d82f24f Eric W. Biederman     2022-02-09  2101  	if (retval < 0)
8f2f9c4d82f24f Eric W. Biederman     2022-02-09  2102  		goto bad_fork_free;
8f2f9c4d82f24f Eric W. Biederman     2022-02-09  2103  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2104  	retval = -EAGAIN;
21d1c5e386bc75 Alexey Gladkov        2021-04-22  2105  	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
b57922b6c76c3e Eric Paris            2013-07-03  2106  		if (p->real_cred->user != INIT_USER &&
b57922b6c76c3e Eric Paris            2013-07-03  2107  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
8f2f9c4d82f24f Eric W. Biederman     2022-02-09  2108  			goto bad_fork_cleanup_count;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2109  	}
72fa59970f8698 Vasiliy Kulikov       2011-08-08  2110  	current->flags &= ~PF_NPROC_EXCEEDED;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2111  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2112  	/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  2113  	 * If multiple threads are within copy_process(), then this check
^1da177e4c3f41 Linus Torvalds        2005-04-16  2114  	 * triggers too late. This doesn't hurt, the check is only there
^1da177e4c3f41 Linus Torvalds        2005-04-16  2115  	 * to stop root fork bombs.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2116  	 */
04ec93fe9bc98e Li Zefan              2009-02-06  2117  	retval = -EAGAIN;
c17d1a3a8ee4da Weilong Chen          2020-06-23  2118  	if (data_race(nr_threads >= max_threads))
^1da177e4c3f41 Linus Torvalds        2005-04-16  2119  		goto bad_fork_cleanup_count;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2120  
ca74e92b469827 Shailabh Nagar        2006-07-14  2121  	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
a8ea6fc9b08915 Frederic Weisbecker   2021-05-26  2122  	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
514ddb446c5c5a David Rientjes        2014-04-07  2123  	p->flags |= PF_FORKNOEXEC;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2124  	INIT_LIST_HEAD(&p->children);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2125  	INIT_LIST_HEAD(&p->sibling);
f41d911f8c49a5 Paul E. McKenney      2009-08-22  2126  	rcu_copy_process(p);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2127  	p->vfork_done = NULL;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2128  	spin_lock_init(&p->alloc_lock);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2129  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2130  	init_sigpending(&p->pending);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2131  
648616343cdbe9 Martin Schwidefsky    2011-12-15  2132  	p->utime = p->stime = p->gtime = 0;
40565b5aedd6d0 Stanislaw Gruszka     2016-11-15  2133  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
648616343cdbe9 Martin Schwidefsky    2011-12-15  2134  	p->utimescaled = p->stimescaled = 0;
40565b5aedd6d0 Stanislaw Gruszka     2016-11-15  2135  #endif
9d7fb04276481c Peter Zijlstra        2015-06-30  2136  	prev_cputime_init(&p->prev_cputime);
9d7fb04276481c Peter Zijlstra        2015-06-30  2137  

:::::: The code at line 2096 was first introduced by commit
:::::: a21ee6055c30ce68c4e201c6496f0ed2a1936230 lockdep: Change hardirq{s_enabled,_context} to per-cpu variables

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
