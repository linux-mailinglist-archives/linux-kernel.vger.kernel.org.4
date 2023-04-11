Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C4A6DE1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDKRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDKRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:02:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0F6585;
        Tue, 11 Apr 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681232551; x=1712768551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=djm8bQ+Qt9WvMFf87Ox1tbM+gNLQTqi3MwetRSRW8Fk=;
  b=YHfw7YXxQdDQ89xL5s/FyprFev0+qHZtrB9duA2qey0sIxukqaT58ZYT
   FTTp6cA9Ml3Ery7+fRQMX7ZfRobm0C1YooNDhSj/yunJHcjl3S8eBudL7
   vGbeNDtvVfAXTBVYr3DC0AvipsqEcoaQ+AhXBHJK9iyiGwmGH9VTwXVEZ
   PX55Va04CJNu1tsUga3jizUcbpEcw/fMPRGASESOeC3ErSlxF+K9y5K3Z
   f3JH0Ly+3ZJ3Be6PPLcdERqODllNGEeLqPkbti2IuEZduMquxhjlNTiHF
   KsxKry3bzt7ix654eYLk7rFLASQd4z3n7DlRoHI4V8tuImKx2AXhzm8Fk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323305928"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323305928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="638898583"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638898583"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2023 10:01:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmHMt-000WVv-0s;
        Tue, 11 Apr 2023 17:01:19 +0000
Date:   Wed, 12 Apr 2023 01:01:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Message-ID: <202304120048.v4uqUq9Q-lkp@intel.com>
References: <20230410011325.26850-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410011325.26850-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on uml/next]
[also build test WARNING on uml/fixes wireless-next/main wireless/main linus/master v6.3-rc6 next-20230411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randy-Dunlap/UML-pata_cs5536-fix-build-for-X86_32-UML-with-TRACEPOINTS/20230410-091733
base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20230410011325.26850-1-rdunlap%40infradead.org
patch subject: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230412/202304120048.v4uqUq9Q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2782ce24954318f1698ec910691250f4d287d817
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Randy-Dunlap/UML-pata_cs5536-fix-build-for-X86_32-UML-with-TRACEPOINTS/20230410-091733
        git checkout 2782ce24954318f1698ec910691250f4d287d817
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120048.v4uqUq9Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/um/../lib/msr.c:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Read an MSR with error handling
   arch/x86/um/../lib/msr.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Write an MSR with error handling
   arch/x86/um/../lib/msr.c:91: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set @bit in a MSR @msr.
   arch/x86/um/../lib/msr.c:104: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Clear @bit in a MSR @msr.


vim +30 arch/x86/um/../lib/msr.c

22085a66c2fab6 Borislav Petkov 2014-03-09  28  
22085a66c2fab6 Borislav Petkov 2014-03-09  29  /**
22085a66c2fab6 Borislav Petkov 2014-03-09 @30   * Read an MSR with error handling
22085a66c2fab6 Borislav Petkov 2014-03-09  31   *
22085a66c2fab6 Borislav Petkov 2014-03-09  32   * @msr: MSR to read
22085a66c2fab6 Borislav Petkov 2014-03-09  33   * @m: value to read into
22085a66c2fab6 Borislav Petkov 2014-03-09  34   *
22085a66c2fab6 Borislav Petkov 2014-03-09  35   * It returns read data only on success, otherwise it doesn't change the output
22085a66c2fab6 Borislav Petkov 2014-03-09  36   * argument @m.
22085a66c2fab6 Borislav Petkov 2014-03-09  37   *
22085a66c2fab6 Borislav Petkov 2014-03-09  38   */
3e7bbe15ed84e3 Zhao Xuehui     2021-04-08  39  static int msr_read(u32 msr, struct msr *m)
22085a66c2fab6 Borislav Petkov 2014-03-09  40  {
22085a66c2fab6 Borislav Petkov 2014-03-09  41  	int err;
22085a66c2fab6 Borislav Petkov 2014-03-09  42  	u64 val;
22085a66c2fab6 Borislav Petkov 2014-03-09  43  
22085a66c2fab6 Borislav Petkov 2014-03-09  44  	err = rdmsrl_safe(msr, &val);
22085a66c2fab6 Borislav Petkov 2014-03-09  45  	if (!err)
22085a66c2fab6 Borislav Petkov 2014-03-09  46  		m->q = val;
22085a66c2fab6 Borislav Petkov 2014-03-09  47  
22085a66c2fab6 Borislav Petkov 2014-03-09  48  	return err;
22085a66c2fab6 Borislav Petkov 2014-03-09  49  }
22085a66c2fab6 Borislav Petkov 2014-03-09  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
