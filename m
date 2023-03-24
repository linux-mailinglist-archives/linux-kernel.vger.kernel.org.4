Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0E6C7830
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCXGv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCXGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:51:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8725233C6;
        Thu, 23 Mar 2023 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679640680; x=1711176680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JlL8rYJbsrhy2KQzEdkMafFIo26MMid90GZaZUB4ySw=;
  b=JBJjDxUNvz2z0c/mh+QMjR2pPN830ss899YYKW2NN9+rLjJlbwbMNBem
   CD3Sx/uVVBUwwvlrm9dzM7+5h2xUnEVY6NNAo+QnKINtc9t9K9yqPzfgD
   Q0xSbYnaJGN0xS4DTU2TWfgpH2t5w7BlefUfk8FBWmB5LrRQHE01UKtB1
   ZA8m6pk/Et9si/4w7RpBwZr/iKpx4jgtUFGDqkkrU2GreQ6z1QlpVqjgY
   jNq2qxrDYaNiuLLMI1ReIOh4RQxNH+Knq7PomdN14RdmnhapWsEndtnu9
   o5DJCX+jTJU4ec7y8xG1pUmqs2S+iCMzkHnsoNCW2QvcdO7pAfA/BPkJl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337217556"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="337217556"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 23:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632729355"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="632729355"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 23:51:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfbGQ-000F3k-2k;
        Fri, 24 Mar 2023 06:51:02 +0000
Date:   Fri, 24 Mar 2023 14:50:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] Makefile: use -z pack-relative-relocs
Message-ID: <202303241443.0sSziFDY-lkp@intel.com>
References: <20230323204427.3594372-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323204427.3594372-1-maskray@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangrui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on masahiroy-kbuild/fixes linus/master v6.3-rc3 next-20230323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fangrui-Song/Makefile-use-z-pack-relative-relocs/20230324-044515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20230323204427.3594372-1-maskray%40google.com
patch subject: [PATCH] Makefile: use -z pack-relative-relocs
config: arm64-randconfig-r022-20230322 (https://download.01.org/0day-ci/archive/20230324/202303241443.0sSziFDY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8f47a36faf182f96a2bbf4d3b9305fe9a90c5cde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fangrui-Song/Makefile-use-z-pack-relative-relocs/20230324-044515
        git checkout 8f47a36faf182f96a2bbf4d3b9305fe9a90c5cde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241443.0sSziFDY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> aarch64-linux-ld: warning: -z pack-relative-relocs ignored
>> aarch64-linux-ld: warning: -z pack-relative-relocs ignored
>> aarch64-linux-ld: warning: -z pack-relative-relocs ignored

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
