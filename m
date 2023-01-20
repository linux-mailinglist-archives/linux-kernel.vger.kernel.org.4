Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCC67590C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjATPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:49:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5559754
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:49:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE4FB82866
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5CDC433D2;
        Fri, 20 Jan 2023 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674229776;
        bh=6845bVsAtbRue0sz+/lpKrQPW1JJoCygvCbZDqXm1Vw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q6yO7vujOBbOgdmqT95LnvBsD1BqXE3D+6NPT7tcNTVeFEsa39AK0niTzJUrFgIiB
         G30lHCsD+WKyI6CSj7olS824xKi5/4qsiT4yv9cjOe75npyHQBTjXlC1IBrqz725uz
         yYcuQm0fIkt1Qb46CJFuiC6xpusebCHMxGQeuwPPr3pSCXvGHEKdk+F/x24Ff0/i7R
         bbEbIf1iR8zIRPQgiM3iG+UgOa8n4j+sYdONquePFTmcDztCdXw0MW/W6rGrAuhkC2
         t9mtHGppWMS8rkg437ialTC9m8QpV6ZrIuemRd6OWQIBTscLcICurR64iWbDBY2TBL
         9+ZEmqSH1f/GA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E64315C0DFC; Fri, 20 Jan 2023 07:49:35 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:49:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:slownmi.2023.01.19a] BUILD REGRESSION
 06901681acde9854a9a9a337cebbf3ab537f4543
Message-ID: <20230120154935.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <63caa325.8m2/A3WoZ768xRxh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63caa325.8m2/A3WoZ768xRxh%lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:20:21PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git slownmi.2023.01.19a
> branch HEAD: 06901681acde9854a9a9a337cebbf3ab537f4543  x86/nmi: Test commit for delayed NMI handlers
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202301201335.5rpVzsvW-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> ERROR: modpost: "dump_cpu_task" [kernel/rcu/rcutorture.ko] undefined!

Good catch as always, but this is a testing-only commit not destined
for mainline.  Except that now that you mention it, the next stage of
testing requires modules.

Will fix, and thank you!

							Thanx, Paul

> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- i386-randconfig-a001
> |   `-- ERROR:dump_cpu_task-kernel-rcu-rcutorture.ko-undefined
> `-- s390-allmodconfig
>     `-- ERROR:dump_cpu_task-kernel-rcu-rcutorture.ko-undefined
> 
> elapsed time: 793m
> 
> configs tested: 66
> configs skipped: 2
> 
> gcc tested configs:
> x86_64                            allnoconfig
> um                             i386_defconfig
> um                           x86_64_defconfig
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                           allyesconfig
> x86_64                           rhel-8.3-syz
> x86_64                           rhel-8.3-kvm
> x86_64                           rhel-8.3-bpf
> x86_64                         rhel-8.3-kunit
> x86_64                    rhel-8.3-kselftests
> x86_64                          rhel-8.3-func
> ia64                             allmodconfig
> arc                                 defconfig
> i386                          randconfig-a001
> s390                             allmodconfig
> arm                                 defconfig
> i386                          randconfig-a003
> alpha                               defconfig
> arm64                            allyesconfig
> i386                          randconfig-a005
> i386                                defconfig
> x86_64                        randconfig-a004
> arm                  randconfig-r046-20230119
> x86_64                        randconfig-a002
> s390                                defconfig
> arc                  randconfig-r043-20230119
> x86_64                        randconfig-a006
> m68k                             allmodconfig
> arm                              allyesconfig
> m68k                             allyesconfig
> alpha                            allyesconfig
> arc                              allyesconfig
> s390                             allyesconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> mips                             allyesconfig
> sh                               allmodconfig
> x86_64                        randconfig-a013
> x86_64                        randconfig-a011
> i386                          randconfig-a014
> x86_64                        randconfig-a015
> i386                          randconfig-a012
> i386                          randconfig-a016
> i386                             allyesconfig
> powerpc                  storcenter_defconfig
> sh                           se7722_defconfig
> riscv                               defconfig
> 
> clang tested configs:
> x86_64                          rhel-8.3-rust
> i386                          randconfig-a002
> i386                          randconfig-a004
> hexagon              randconfig-r041-20230119
> i386                          randconfig-a006
> x86_64                        randconfig-a001
> x86_64                        randconfig-a003
> hexagon              randconfig-r045-20230119
> x86_64                        randconfig-a005
> riscv                randconfig-r042-20230119
> s390                 randconfig-r044-20230119
> i386                          randconfig-a013
> x86_64                        randconfig-a012
> x86_64                        randconfig-a014
> x86_64                        randconfig-a016
> i386                          randconfig-a011
> i386                          randconfig-a015
> mips                      pic32mzda_defconfig
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
