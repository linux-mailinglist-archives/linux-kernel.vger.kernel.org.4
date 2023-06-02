Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822271F863
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjFBC2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFBC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:27:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915E184;
        Thu,  1 Jun 2023 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685672878; x=1717208878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQBY6CSkF8HVOgom8PLO7+N9vZQlh9ITh/b+24j0gaw=;
  b=OBaO2K0sT5WUJ6xpLrIEUoWljkhh7rf2/BCOeFG/PkOs8AlDrl8kkOs/
   xbFEmf0lYiL4yYdH0RciLcS7E/flSOMAjjidZnrD9r8J4mgK4x+ceve1k
   B2EJeMWYeDbmWAEyC2AMKXB/R4nOP++pGO2G+/7LGNsgQhBbScHmkvL3j
   xQm6kAe7seTY91nyEj2h0NjceWDaPbGPr8+R33TAgUv2JsUyjFqHYEBU3
   IAn72TM0r4XbovbzZfTkmlMGpUPhBaRzRNkzJfQcMA3FSHNg9WbgcPLym
   HNDDs/51k7s24oXHOH/NCFK7e5E+OzNQVfVLPc0d0HjmH2QymknHKdHdX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335360372"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="335360372"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881872738"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="881872738"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2023 19:27:55 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4uWB-0002vu-0K;
        Fri, 02 Jun 2023 02:27:55 +0000
Date:   Fri, 2 Jun 2023 10:27:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        keyrings@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] certs/extract-cert: Fix checkpatch issues
Message-ID: <202306021040.UTvXfH5J-lkp@intel.com>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601190508.56610-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Franziska,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7877cb91f1081754a1487c144d85dc0d2e2e7fc4]

url:    https://github.com/intel-lab-lkp/linux/commits/Franziska-Naepelt/certs-extract-cert-Fix-checkpatch-issues/20230602-030657
base:   7877cb91f1081754a1487c144d85dc0d2e2e7fc4
patch link:    https://lore.kernel.org/r/20230601190508.56610-1-franziska.naepelt%40gmail.com
patch subject: [PATCH] certs/extract-cert: Fix checkpatch issues
config: mips-buildonly-randconfig-r002-20230602 (https://download.01.org/0day-ci/archive/20230602/202306021040.UTvXfH5J-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7fdfaec7a3c9f58676a5892e679d8bca319abd8a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Franziska-Naepelt/certs-extract-cert-Fix-checkpatch-issues/20230602-030657
        git checkout 7fdfaec7a3c9f58676a5892e679d8bca319abd8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021040.UTvXfH5J-lkp@intel.com/

All errors (new ones prefixed by >>):

>> certs/extract-cert.c:36:8: error: unknown type name '__noreturn'
   static __noreturn
          ^
   1 error generated.


vim +/__noreturn +36 certs/extract-cert.c

    35	
  > 36	static __noreturn
    37	void format(void)
    38	{
    39		fprintf(stderr,
    40			"Usage: extract-cert <source> <dest>\n");
    41		exit(2);
    42	}
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
