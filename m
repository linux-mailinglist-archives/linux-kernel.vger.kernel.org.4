Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC36C9B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjC0GSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjC0GSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:18:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659C46A4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 23:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679897886; x=1711433886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6o0fKQmvkTDxMY4zxOWWNTnYAsFjBoC1E2c2rziwavI=;
  b=CGrxKUbN83X80XZyVNX6qfQcT5k4XW4eLdPwE/5yNcdyGErw3siuWZp6
   dOKM+/9UEQRN1HXqTMIUM3nX53+xKQszNR7rfmJ8DXjLmty3fjPovun1T
   3lNliE56nbspWWgjRGY3egyuVK7sNES8q0HknLPTFkeUTJdC7L8xBsRru
   YBiOGpeoJmP7DSwhoIyQgsQJLP5klnRja6iIAS8XjZ4BGZ6jKGDox9qQG
   xsPKKOqEArjQeknYKuF7t29U+hp2rQfTvIAcQNy2smSInGgK9g8eoZRiQ
   ryWXacu3Rz56n8hLnda9d7vhTCljXWPnd1OeuAOqWVIGN11L8x5uoJZcT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="342589953"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="342589953"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 23:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="660732137"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="660732137"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2023 23:18:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pggBB-000HaN-0h;
        Mon, 27 Mar 2023 06:18:05 +0000
Date:   Mon, 27 Mar 2023 14:17:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: xenpv_exc_double_fault+0xd: unreachable
 instruction
Message-ID: <202303271446.1FSJkyat-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   197b6b60ae7bc51dd0814953c562833143b292aa
commit: 443ed4c302fff6a26af980300463343a7adc9ee8 objtool: mem*() are not uaccess safe
date:   6 weeks ago
config: x86_64-randconfig-r035-20230327 (https://download.01.org/0day-ci/archive/20230327/202303271446.1FSJkyat-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=443ed4c302fff6a26af980300463343a7adc9ee8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 443ed4c302fff6a26af980300463343a7adc9ee8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303271446.1FSJkyat-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: xenpv_exc_double_fault+0xd: unreachable instruction


objdump-func vmlinux.o xenpv_exc_double_fault:
0000 0000000000001680 <xenpv_exc_double_fault>:
0000     1680:	f3 0f 1e fa          	endbr64
0004     1684:	55                   	push   %rbp
0005     1685:	48 89 e5             	mov    %rsp,%rbp
0008     1688:	e8 00 00 00 00       	call   168d <xenpv_exc_double_fault+0xd>	1689: R_X86_64_PLT32	exc_double_fault-0x4
000d     168d:	5d                   	pop    %rbp
000e     168e:	c3                   	ret
000f     168f:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
001a     169a:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
0025     16a5:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
0030     16b0:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
003b     16bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
