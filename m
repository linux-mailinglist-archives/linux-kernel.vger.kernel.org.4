Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9773271D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbjFPGLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbjFPGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:11:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5318D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:10:58 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qj7xK4lwhzGpkt;
        Fri, 16 Jun 2023 14:07:49 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 14:10:54 +0800
Message-ID: <cb02c057-1fdb-9844-4911-b8406e6108da@huawei.com>
Date:   Fri, 16 Jun 2023 14:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm/memcg: remove return value of mem_cgroup_scan_tasks()
To:     kernel test robot <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230616021955.872413-1-zhangpeng362@huawei.com>
 <202306161306.9YKbncNT-lkp@intel.com>
Content-Language: en-US
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <202306161306.9YKbncNT-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/16 13:13, kernel test robot wrote:

> Hi Peng,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/mm-memcg-remove-return-value-of-mem_cgroup_scan_tasks/20230616-102145
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230616021955.872413-1-zhangpeng362%40huawei.com
> patch subject: [PATCH] mm/memcg: remove return value of mem_cgroup_scan_tasks()
> config: x86_64-randconfig-r005-20230616 (https://download.01.org/0day-ci/archive/20230616/202306161306.9YKbncNT-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=1 build):
>          mkdir -p ~/bin
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>          git fetch akpm-mm mm-everything
>          git checkout akpm-mm/mm-everything
>          b4 shazam https://lore.kernel.org/r/20230616021955.872413-1-zhangpeng362@huawei.com
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 prepare
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306161306.9YKbncNT-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     In file included from arch/x86/kernel/asm-offsets.c:14:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>>> include/linux/memcontrol.h:1370:2: error: void function 'mem_cgroup_scan_tasks' should not return a value [-Wreturn-type]
>             return 0;

Thanks for reporting. I'll drop this line.

>             ^      ~
>     1 error generated.
>     make[2]: *** [scripts/Makefile.build:114: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=3878817758
>     make[2]: Target 'prepare' not remade because of errors.
>     make[1]: *** [Makefile:1287: prepare0] Error 2 shuffle=3878817758
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:226: __sub-make] Error 2 shuffle=3878817758
>     make: Target 'prepare' not remade because of errors.
>
>
> vim +/mem_cgroup_scan_tasks +1370 include/linux/memcontrol.h
>
> 5660048ccac873 Johannes Weiner  2012-01-12  1366
> 5044a2e0ddbf82 ZhangPeng        2023-06-16  1367  static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> 7c5f64f84483bd Vladimir Davydov 2016-10-07  1368  		int (*fn)(struct task_struct *, void *), void *arg)
> 7c5f64f84483bd Vladimir Davydov 2016-10-07  1369  {
> 7c5f64f84483bd Vladimir Davydov 2016-10-07 @1370  	return 0;
> 7c5f64f84483bd Vladimir Davydov 2016-10-07  1371  }
> 7c5f64f84483bd Vladimir Davydov 2016-10-07  1372
>
