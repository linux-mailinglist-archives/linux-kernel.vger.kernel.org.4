Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DE69176F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjBJD71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBJD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:59:25 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CF56F224
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:59:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbIVgC-_1676001560;
Received: from 30.97.49.39(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbIVgC-_1676001560)
          by smtp.aliyun-inc.com;
          Fri, 10 Feb 2023 11:59:21 +0800
Message-ID: <a2133204-98c8-4733-1062-e26abead28e7@linux.alibaba.com>
Date:   Fri, 10 Feb 2023 11:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast
 truncates bits from constant value (ffffffffe0f510cc becomes cc)
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yue Hu <huyue2@coolpad.com>, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <202302101104.mgetTzwR-lkp@intel.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <202302101104.mgetTzwR-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/2/10 11:52, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   38c1e0c65865426676123cc9a127526fa02bcac6
> commit: 2f44013e39984c127c6efedf70e6b5f4e9dcf315 erofs: fix pcluster use-after-free on UP platforms
> date:   5 months ago
> config: alpha-randconfig-s042-20230210 (https://download.01.org/0day-ci/archive/20230210/202302101104.mgetTzwR-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-39-gce1a6720-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f44013e39984c127c6efedf70e6b5f4e9dcf315
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 2f44013e39984c127c6efedf70e6b5f4e9dcf315
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash fs/erofs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302101104.mgetTzwR-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>     fs/erofs/utils.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
>>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>>> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes 10cc)
> --
>     fs/erofs/zdata.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
>>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>>> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes 10cc)
>     arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>     arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
>     arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>     arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0edead becomes ad)
>     arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
>     arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0edead becomes dead)

As I reported in
https://lore.kernel.org/r/b8dfa8cd-f3f9-d10c-fbd0-eac8067ee39c@intel.com

I'm not sure how we could do something for these reports in EROFS.

Thanks,
Gao Xiang

> 
> vim +234 arch/alpha/include/asm/xchg.h
> 
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  227
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  228  static __always_inline unsigned long
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  229  ____cmpxchg(, volatile void *ptr, unsigned long old, unsigned long new,
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  230  	      int size)
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  231  {
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  232  	switch (size) {
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  233  		case 1:
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31 @234  			return ____cmpxchg(_u8, ptr, old, new);
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  235  		case 2:
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31 @236  			return ____cmpxchg(_u16, ptr, old, new);
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  237  		case 4:
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  238  			return ____cmpxchg(_u32, ptr, old, new);
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  239  		case 8:
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  240  			return ____cmpxchg(_u64, ptr, old, new);
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  241  	}
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  242  	__cmpxchg_called_with_bad_pointer();
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  243  	return old;
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  244  }
> a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  245
> 
> :::::: The code at line 234 was first introduced by commit
> :::::: a6209d6d71f2ab8c63cc1587ef65490d83022baf alpha: xchg/cmpxchg cleanup and fixes
> 
> :::::: TO: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
