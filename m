Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881EF6C3644
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCUPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCUPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:53:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE08E521E6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 684AFB818B2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095ADC433D2;
        Tue, 21 Mar 2023 15:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679413952;
        bh=b4WRK4pizy5CLjtQO+7ym0LvEmB3fKGHGSY0Zeq50qw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mygoKmMkzZ3m89pWPs1ii93kes15sAzdsiJiea5cZUxoKpo/0kxEWDdu6HCJBCQqh
         6whPFkjXjOIXJ9DsuGgqp65pqIkdiNWdn3UUCBT0GEb+vC7g76eG7xvVY0vs/rfNYq
         uycjiVCOKhAzFXY5iAV1Y5sbPIsXwntQtdRJC1Ldxs1FQZ6XteefxS5Exoy5gRzssc
         a2dIGBKgV/ws2cit/zwQdBh+Gz2J6rBU8kOBXdsUdsaHIzuGc/I6zWWl6bwil5nVyZ
         113bErBxlXTS5TWpmLM4h0YXaPf/BJUGVYNXiCdCIB5rD55vk4YBHHv4cGtyBi0M6K
         8OVJblfpcHwuA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 41CE2154033A; Tue, 21 Mar 2023 08:52:31 -0700 (PDT)
Date:   Tue, 21 Mar 2023 08:52:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [paulmck-rcu:dev.2023.03.17a 33/38] kernel/rcu/tasks.h:140:20:
 warning: 'tasks_rcu_exit_srcu' defined but not used
Message-ID: <75ca890c-8f97-4879-a094-ab8dfb6f483a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202303191536.XzMSyzTl-lkp@intel.com>
 <be0bf772-bac1-4a18-a46a-922a93093314@paulmck-laptop>
 <9c716b77dd0743089a40f933ccdcbd57222e21f4.camel@intel.com>
 <5b73fe0e-bacc-4aee-a632-3160e38e42db@paulmck-laptop>
 <3c163348df52f9501c5759b60642939d47088816.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c163348df52f9501c5759b60642939d47088816.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 06:16:04AM +0000, Liu, Yujie wrote:
> On Mon, 2023-03-20 at 21:18 -0700, Paul E. McKenney wrote:
> > On Tue, Mar 21, 2023 at 02:49:08AM +0000, Liu, Yujie wrote:
> > > Hi Paul,
> > > 
> > > On Sun, 2023-03-19 at 17:33 -0700, Paul E. McKenney wrote:
> > > > On Sun, Mar 19, 2023 at 03:05:43PM +0800, kernel test robot
> > > > wrote:
> > > > > tree:  
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > >  dev.2023.03.17a
> > > > > head:   19d218a4b125a4dce12eb88097a9c55f7126ce8c
> > > > > commit: 61eea4556e8cf92d4c9b483110a679d2652aa451 [33/38] srcu:
> > > > > Move work-scheduling fields from srcu_struct to srcu_usage
> > > > > config: x86_64-kexec
> > > > > (https://download.01.org/0day-ci/archive/20230319/202303191536
> > > > > .XzMSyzTl-lkp@intel.com/config)
> > > > > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > > > > reproduce (this is a W=1 build):
> > > > >         #
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=61eea4556e8cf92d4c9b483110a679d2652aa451
> > > > >         git remote add paulmck-rcu
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > >         git fetch --no-tags paulmck-rcu dev.2023.03.17a
> > > > >         git checkout 61eea4556e8cf92d4c9b483110a679d2652aa451
> > > > >         # save the config file
> > > > >         mkdir build_dir && cp config build_dir/.config
> > > > >         make W=1 O=build_dir ARCH=x86_64 olddefconfig
> > > > >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > > > > kernel/
> > > > > 
> > > > > If you fix the issue, kindly add following tag where applicable
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Link:
> > > > > > https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
> > > > > 
> > > > > All warnings (new ones prefixed by >>):
> > > > > 
> > > > >    In file included from include/linux/srcu.h:49,
> > > > >                     from include/linux/notifier.h:16,
> > > > >                     from arch/x86/include/asm/uprobes.h:13,
> > > > >                     from include/linux/uprobes.h:49,
> > > > >                     from include/linux/mm_types.h:16,
> > > > >                     from include/linux/sched/signal.h:13,
> > > > >                     from kernel/rcu/update.c:26:
> > > > > > > kernel/rcu/tasks.h:140:20: warning: 'tasks_rcu_exit_srcu'
> > > > > > > defined but not used [-Wunused-variable]
> > > > >      140 | DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> > > > >          |                    ^~~~~~~~~~~~~~~~~~~
> > > > >    include/linux/srcutree.h:184:38: note: in definition of
> > > > > macro '__DEFINE_SRCU'
> > > > >      184 |         is_static struct srcu_struct name
> > > > > =                                                     \
> > > > >          |                                      ^~~~
> > > > >    kernel/rcu/tasks.h:140:1: note: in expansion of macro
> > > > > 'DEFINE_STATIC_SRCU'
> > > > >      140 | DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> > > > >          | ^~~~~~~~~~~~~~~~~~
> > > > 
> > > > Good catch, thank you!
> > > > 
> > > > Does the patch shown below fix this?
> > > 
> > > We've tested the patch and the build warning is fixed by it.
> > > Thanks.
> > 
> > Thank you!  May I apply your Tested-by?
> 
> Sure, with pleasure.
> 
> Tested-by: Yujie Liu <yujie.liu@intel.com>

Thank you, and I will apply on my next rebase.

							Thanx, Paul

> Thanks.
> 
> >                                                         Thanx, Paul
> > 
> > > --
> > > Best Regards,
> > > Yujie
> > > 
> > > >                                                         Thanx,
> > > > Paul
> > > > 
> > > > -----------------------------------------------------------------
> > > > -------
> > > > 
> > > > commit a9b8406e51603238941dbc6fa1437f8915254ebb
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Sun Mar 19 17:29:20 2023 -0700
> > > > 
> > > >     rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu
> > > >     
> > > >     The tasks_rcu_exit_srcu variable is used only by kernels
> > > > built
> > > >     with CONFIG_TASKS_RCU=y, but is defined for all kernesl with
> > > >     CONFIG_TASKS_RCU_GENERIC=y.  Therefore, in kernels built with
> > > >     CONFIG_TASKS_RCU_GENERIC=y but CONFIG_TASKS_RCU=n, this gives
> > > >     a "defined but not used" warning.
> > > >     
> > > >     This commit therefore moves this variable under
> > > > CONFIG_TASKS_RCU
> > > >     
> > > >     Link:
> > > > https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
> > > >     Reported-by: kernel test robot <lkp@intel.com>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > index baf7ec178155..85a874d4166b 100644
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > > > @@ -136,10 +136,10 @@ static struct rcu_tasks rt_name
> > > > =                                                 \
> > > >         .kname =
> > > > #rt_name,                                                        
> > > >       \
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_TASKS_RCU
> > > >  /* Track exiting tasks in order to allow them to be waited for.
> > > > */
> > > >  DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> > > >  
> > > > -#ifdef CONFIG_TASKS_RCU
> > > >  /* Report delay in synchronize_srcu() completion in
> > > > rcu_tasks_postscan(). */
> > > >  static void tasks_rcu_exit_srcu_stall(struct timer_list
> > > > *unused);
> > > >  static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer,
> > > > tasks_rcu_exit_srcu_stall);
> > > > 
> > > 
> > 
> 
