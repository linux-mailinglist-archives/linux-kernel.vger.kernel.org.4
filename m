Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124166C06DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCTAeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCTAeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0D19AD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4453B80D37
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E97BC433EF;
        Mon, 20 Mar 2023 00:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679272439;
        bh=OfBojTIToxTPZ/STigpxfZ48b4RfgVXqNe33YfVBrjo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g/wobLgQwMEdnR3xNknsE38K7yprr8p8Fm76l7xHkknxauIRkfnVTuD6sOWVgsbz2
         m//pIsoHjngsBvW244CDtkpHLHi8GkVmWceqKYk7qw3txZ9AW7llT+Q8u/T5nZgIo7
         xYd/ylHGPLp7ZCHX//A74hNhlqzGBxkBbSjGfP/ypb5u4K7WJeaAPl36MPrJ68BJds
         a/u9mZFCcto+2TubUtRSbKvqS+iWmvWrU5n1WOOZPS+3xh9hQnM0XUO21DzJmJaLf9
         Qn+oiSPpaD339k8k0gIyzATBSE1q8mBPlJ/DP6vgRVNH22MgzZGZLVj/ak82nJvEhZ
         bR36DKP6ZfOgw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F3E9F1540381; Sun, 19 Mar 2023 17:33:58 -0700 (PDT)
Date:   Sun, 19 Mar 2023 17:33:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.03.17a 33/38] kernel/rcu/tasks.h:140:20:
 warning: 'tasks_rcu_exit_srcu' defined but not used
Message-ID: <be0bf772-bac1-4a18-a46a-922a93093314@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202303191536.XzMSyzTl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303191536.XzMSyzTl-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 03:05:43PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.17a
> head:   19d218a4b125a4dce12eb88097a9c55f7126ce8c
> commit: 61eea4556e8cf92d4c9b483110a679d2652aa451 [33/38] srcu: Move work-scheduling fields from srcu_struct to srcu_usage
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230319/202303191536.XzMSyzTl-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=61eea4556e8cf92d4c9b483110a679d2652aa451
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2023.03.17a
>         git checkout 61eea4556e8cf92d4c9b483110a679d2652aa451
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/srcu.h:49,
>                     from include/linux/notifier.h:16,
>                     from arch/x86/include/asm/uprobes.h:13,
>                     from include/linux/uprobes.h:49,
>                     from include/linux/mm_types.h:16,
>                     from include/linux/sched/signal.h:13,
>                     from kernel/rcu/update.c:26:
> >> kernel/rcu/tasks.h:140:20: warning: 'tasks_rcu_exit_srcu' defined but not used [-Wunused-variable]
>      140 | DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
>          |                    ^~~~~~~~~~~~~~~~~~~
>    include/linux/srcutree.h:184:38: note: in definition of macro '__DEFINE_SRCU'
>      184 |         is_static struct srcu_struct name =                                                     \
>          |                                      ^~~~
>    kernel/rcu/tasks.h:140:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
>      140 | DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
>          | ^~~~~~~~~~~~~~~~~~

Good catch, thank you!

Does the patch shown below fix this?

							Thanx, Paul

------------------------------------------------------------------------

commit a9b8406e51603238941dbc6fa1437f8915254ebb
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Mar 19 17:29:20 2023 -0700

    rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu
    
    The tasks_rcu_exit_srcu variable is used only by kernels built
    with CONFIG_TASKS_RCU=y, but is defined for all kernesl with
    CONFIG_TASKS_RCU_GENERIC=y.  Therefore, in kernels built with
    CONFIG_TASKS_RCU_GENERIC=y but CONFIG_TASKS_RCU=n, this gives
    a "defined but not used" warning.
    
    This commit therefore moves this variable under CONFIG_TASKS_RCU
    
    Link: https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index baf7ec178155..85a874d4166b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -136,10 +136,10 @@ static struct rcu_tasks rt_name =							\
 	.kname = #rt_name,								\
 }
 
+#ifdef CONFIG_TASKS_RCU
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
-#ifdef CONFIG_TASKS_RCU
 /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
 static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
