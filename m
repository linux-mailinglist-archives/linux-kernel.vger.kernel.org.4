Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B945B671C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIMFDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMFDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:03:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B533E75D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663045429; x=1694581429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1GO7jM/v6bQrjNt3E47x10cYeR5nP1YvgFkKfBS6Ing=;
  b=ePb+QNdEZhJrP4h3ldXgwzljg0OL7OCQT1HwVUZLTqWsqof3XS56iYdX
   eyRSTInboGxEor/a9oh+ML3qjgoDoZKyibvwAi1xXIkxqAw/g+ifgd40F
   Lim3f4WCFtIO6VT6h2LYwDczvlfT+rxneJDS7DO50GKWZ/qsdFlNV0cm6
   TsQ4/gBvAqgdKGSjnXicSPOPd0aoFs1AGxnE5MitWycsffhkQFhn089Zd
   OCdOMgWkySw6H2zyTr4oQ6pJErhrTO9WvyKTSLzKTxIbZpQFTUemPUtQe
   tXd7Jw+euiqJxQqeSdS6NEyBWC6nLgOiXX8oDHgcnxxxXC8T734Pa9cRw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384333822"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="384333822"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="684709969"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 22:03:46 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXy5J-0003EF-2X;
        Tue, 13 Sep 2022 05:03:45 +0000
Date:   Tue, 13 Sep 2022 13:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:call-depth-tracking 8/59] vmlinux.o: warning: objtool:
 filter_irq_stacks+0x12: relocation to !ENDBR: .entry.text+0x190
Message-ID: <202209131228.rZOu3vwX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking
head:   3a02739baf0302d9ba295686fc7a48fdd235ad15
commit: 6efb77a560aee91d353acb9ec943c621243bbd51 [8/59] arch: Introduce CONFIG_FUNCTION_ALIGNMENT
config: x86_64-randconfig-a004-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131228.rZOu3vwX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=6efb77a560aee91d353acb9ec943c621243bbd51
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue call-depth-tracking
        git checkout 6efb77a560aee91d353acb9ec943c621243bbd51
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: filter_irq_stacks+0x12: relocation to !ENDBR: .entry.text+0x190


objdump-func vmlinux.o filter_irq_stacks:
0000 00000000000c52ae <filter_irq_stacks>:
0000    c52ae:	f3 0f 1e fa          	endbr64
0004    c52b2:	89 f0                	mov    %esi,%eax
0006    c52b4:	31 d2                	xor    %edx,%edx
0008    c52b6:	39 d0                	cmp    %edx,%eax
000a    c52b8:	89 d6                	mov    %edx,%esi
000c    c52ba:	76 31                	jbe    c52ed <filter_irq_stacks+0x3f>
000e    c52bc:	48 8b 0c d7          	mov    (%rdi,%rdx,8),%rcx
0012    c52c0:	48 81 f9 00 00 00 00 	cmp    $0x0,%rcx	c52c3: R_X86_64_32S	__irqentry_text_start
0019    c52c7:	72 0d                	jb     c52d6 <filter_irq_stacks+0x28>
001b    c52c9:	48 81 f9 00 00 00 00 	cmp    $0x0,%rcx	c52cc: R_X86_64_32S	__irqentry_text_end
0022    c52d0:	73 04                	jae    c52d6 <filter_irq_stacks+0x28>
0024    c52d2:	8d 46 01             	lea    0x1(%rsi),%eax
0027    c52d5:	c3                   	ret
0028    c52d6:	48 81 f9 00 00 00 00 	cmp    $0x0,%rcx	c52d9: R_X86_64_32S	__softirqentry_text_start
002f    c52dd:	72 09                	jb     c52e8 <filter_irq_stacks+0x3a>
0031    c52df:	48 81 f9 00 00 00 00 	cmp    $0x0,%rcx	c52e2: R_X86_64_32S	__softirqentry_text_end
0038    c52e6:	72 ea                	jb     c52d2 <filter_irq_stacks+0x24>
003a    c52e8:	48 ff c2             	inc    %rdx
003d    c52eb:	eb c9                	jmp    c52b6 <filter_irq_stacks+0x8>
003f    c52ed:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
