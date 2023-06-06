Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8556E724825
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbjFFPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFFPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:46:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A6139;
        Tue,  6 Jun 2023 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066402; x=1717602402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zF/fEVl6MHKWIe2ynqPywg19p+43Sr/+dB18evdwwEg=;
  b=AIctuMP9ObXDsDqkBJdk/5kD1X1LfDVcMrSF40QtzWLM1+2zBJ7ihsCh
   At//HQgN97FgJI2b73A1YoHcweVMEoCQ9fcbKPmzfEllWgWyL/Zc2vWkE
   kcejYarB/AF9+3DVdnAn7g9KU8yxUcxdXEJbRmUzq81gKJyjpjUnhdgnw
   0NOFQ5ZYTBLiCG/IjUJYV0K0ZCyCVPW/Pq/iTMvzjzAjW3RfICp075oEz
   cG/MAQNw6/BrO9gAGwpFqwES7bwQOHaPA01RRJaya10X3uYx74T0fCzVc
   v1tesahN6II8+SKz5sZtYb1xVQ8NexSLWMUQCMKYglzAY3k1G/t2ieNqt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="356728020"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="356728020"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="779027112"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="779027112"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2023 08:46:39 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6YtK-0005Pv-2f;
        Tue, 06 Jun 2023 15:46:38 +0000
Date:   Tue, 6 Jun 2023 23:45:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] powercap: intel_rapl: Fix CONFIG_IOSF_MBI dependency
Message-ID: <202306062334.5Z1NkD1F-lkp@intel.com>
References: <20230606140000.385223-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606140000.385223-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on next-20230606]
[cannot apply to linus/master v6.4-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Rui/powercap-intel_rapl-Fix-CONFIG_IOSF_MBI-dependency/20230606-220222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230606140000.385223-1-rui.zhang%40intel.com
patch subject: [PATCH] powercap: intel_rapl: Fix CONFIG_IOSF_MBI dependency
config: i386-randconfig-i011-20230606 (attached as .config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch rafael-pm linux-next
        git checkout rafael-pm/linux-next
        b4 shazam https://lore.kernel.org/r/20230606140000.385223-1-rui.zhang@intel.com
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306062334.5Z1NkD1F-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/Kconfig:674:error: recursive dependency detected!
   arch/x86/Kconfig:674:	symbol IOSF_MBI is selected by INTEL_RAPL_CORE
   drivers/powercap/Kconfig:19:	symbol INTEL_RAPL_CORE is selected by INTEL_RAPL_TPMI
   drivers/powercap/Kconfig:38:	symbol INTEL_RAPL_TPMI depends on IOSF_MBI
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"


vim +674 arch/x86/Kconfig

506f1d07b31081 Sam Ravnborg              2007-11-09  592  
ddd70cf93d784a Jun Nakajima              2013-01-21  593  config X86_GOLDFISH
ddd70cf93d784a Jun Nakajima              2013-01-21  594  	bool "Goldfish (Virtual Platform)"
cb7b80237a9f41 Ben Hutchings             2013-06-24  595  	depends on X86_EXTENDED_PLATFORM
a7f7f6248d9740 Masahiro Yamada           2020-06-14  596  	help
ddd70cf93d784a Jun Nakajima              2013-01-21  597  	  Enable support for the Goldfish virtual platform used primarily
ddd70cf93d784a Jun Nakajima              2013-01-21  598  	  for Android development. Unless you are building for the Android
ddd70cf93d784a Jun Nakajima              2013-01-21  599  	  Goldfish emulator say N here.
ddd70cf93d784a Jun Nakajima              2013-01-21  600  
c751e17b5371ad Thomas Gleixner           2010-11-09  601  config X86_INTEL_CE
c751e17b5371ad Thomas Gleixner           2010-11-09  602  	bool "CE4100 TV platform"
c751e17b5371ad Thomas Gleixner           2010-11-09  603  	depends on PCI
c751e17b5371ad Thomas Gleixner           2010-11-09  604  	depends on PCI_GODIRECT
6084a6e23c971e Jiang Liu                 2014-06-09  605  	depends on X86_IO_APIC
c751e17b5371ad Thomas Gleixner           2010-11-09  606  	depends on X86_32
c751e17b5371ad Thomas Gleixner           2010-11-09  607  	depends on X86_EXTENDED_PLATFORM
37bc9f5078c62b Dirk Brandewie            2010-11-09  608  	select X86_REBOOTFIXUPS
da6b737b9ab768 Sebastian Andrzej Siewior 2011-02-22  609  	select OF
da6b737b9ab768 Sebastian Andrzej Siewior 2011-02-22  610  	select OF_EARLY_FLATTREE
a7f7f6248d9740 Masahiro Yamada           2020-06-14  611  	help
c751e17b5371ad Thomas Gleixner           2010-11-09  612  	  Select for the Intel CE media processor (CE4100) SOC.
c751e17b5371ad Thomas Gleixner           2010-11-09  613  	  This option compiles in support for the CE4100 SOC for settop
c751e17b5371ad Thomas Gleixner           2010-11-09  614  	  boxes and media devices.
c751e17b5371ad Thomas Gleixner           2010-11-09  615  
4cb9b00f42e078 David Cohen               2013-12-16  616  config X86_INTEL_MID
43605ef188cd39 Alan Cox                  2011-07-12  617  	bool "Intel MID platform support"
43605ef188cd39 Alan Cox                  2011-07-12  618  	depends on X86_EXTENDED_PLATFORM
edc6bc784028f2 David Cohen               2014-01-21  619  	depends on X86_PLATFORM_DEVICES
1ea7c6737c8f68 Alan Cox                  2011-11-10  620  	depends on PCI
3fda5bb420e79b Andy Shevchenko           2016-01-15  621  	depends on X86_64 || (PCI_GOANY && X86_32)
1ea7c6737c8f68 Alan Cox                  2011-11-10  622  	depends on X86_IO_APIC
4cb9b00f42e078 David Cohen               2013-12-16  623  	select I2C
7c9c3a1e5fc872 Alan Cox                  2011-12-29  624  	select DW_APB_TIMER
54b34aa0a7295c Mika Westerberg           2020-04-16  625  	select INTEL_SCU_PCI
a7f7f6248d9740 Masahiro Yamada           2020-06-14  626  	help
4cb9b00f42e078 David Cohen               2013-12-16  627  	  Select to build a kernel capable of supporting Intel MID (Mobile
4cb9b00f42e078 David Cohen               2013-12-16  628  	  Internet Device) platform systems which do not have the PCI legacy
4cb9b00f42e078 David Cohen               2013-12-16  629  	  interfaces. If you are building for a PC class system say N here.
1ea7c6737c8f68 Alan Cox                  2011-11-10  630  
4cb9b00f42e078 David Cohen               2013-12-16  631  	  Intel MID platforms are based on an Intel processor and chipset which
4cb9b00f42e078 David Cohen               2013-12-16  632  	  consume less power than most of the x86 derivatives.
43605ef188cd39 Alan Cox                  2011-07-12  633  
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  634  config X86_INTEL_QUARK
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  635  	bool "Intel Quark platform support"
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  636  	depends on X86_32
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  637  	depends on X86_EXTENDED_PLATFORM
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  638  	depends on X86_PLATFORM_DEVICES
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  639  	depends on X86_TSC
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  640  	depends on PCI
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  641  	depends on PCI_GOANY
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  642  	depends on X86_IO_APIC
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  643  	select IOSF_MBI
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  644  	select INTEL_IMR
9ab6eb51ef4ad6 Andy Shevchenko           2015-03-05  645  	select COMMON_CLK
a7f7f6248d9740 Masahiro Yamada           2020-06-14  646  	help
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  647  	  Select to include support for Quark X1000 SoC.
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  648  	  Say Y here if you have a Quark based system such as the Arduino
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  649  	  compatible Intel Galileo.
8bbc2a135b63be Bryan O'Donoghue          2015-01-30  650  
3d48aab1d5035f Mika Westerberg           2013-01-18  651  config X86_INTEL_LPSS
3d48aab1d5035f Mika Westerberg           2013-01-18  652  	bool "Intel Low Power Subsystem Support"
5962dd22f0ff6f Sinan Kaya                2019-01-02  653  	depends on X86 && ACPI && PCI
3d48aab1d5035f Mika Westerberg           2013-01-18  654  	select COMMON_CLK
0f531431d3de88 Mathias Nyman             2013-09-13  655  	select PINCTRL
eebb3e8d8aaf28 Andy Shevchenko           2015-12-12  656  	select IOSF_MBI
a7f7f6248d9740 Masahiro Yamada           2020-06-14  657  	help
3d48aab1d5035f Mika Westerberg           2013-01-18  658  	  Select to build support for Intel Low Power Subsystem such as
3d48aab1d5035f Mika Westerberg           2013-01-18  659  	  found on Intel Lynxpoint PCH. Selecting this option enables
0f531431d3de88 Mathias Nyman             2013-09-13  660  	  things like clock tree (common clock framework) and pincontrol
0f531431d3de88 Mathias Nyman             2013-09-13  661  	  which are needed by the LPSS peripheral drivers.
3d48aab1d5035f Mika Westerberg           2013-01-18  662  
92082a8886f30a Ken Xue                   2015-02-06  663  config X86_AMD_PLATFORM_DEVICE
92082a8886f30a Ken Xue                   2015-02-06  664  	bool "AMD ACPI2Platform devices support"
92082a8886f30a Ken Xue                   2015-02-06  665  	depends on ACPI
92082a8886f30a Ken Xue                   2015-02-06  666  	select COMMON_CLK
92082a8886f30a Ken Xue                   2015-02-06  667  	select PINCTRL
a7f7f6248d9740 Masahiro Yamada           2020-06-14  668  	help
92082a8886f30a Ken Xue                   2015-02-06  669  	  Select to interpret AMD specific ACPI device to platform device
92082a8886f30a Ken Xue                   2015-02-06  670  	  such as I2C, UART, GPIO found on AMD Carrizo and later chipsets.
92082a8886f30a Ken Xue                   2015-02-06  671  	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
92082a8886f30a Ken Xue                   2015-02-06  672  	  implemented under PINCTRL subsystem.
92082a8886f30a Ken Xue                   2015-02-06  673  
ced3ce760b8df0 David E. Box              2014-09-17 @674  config IOSF_MBI
ced3ce760b8df0 David E. Box              2014-09-17  675  	tristate "Intel SoC IOSF Sideband support for SoC platforms"
ced3ce760b8df0 David E. Box              2014-09-17  676  	depends on PCI
a7f7f6248d9740 Masahiro Yamada           2020-06-14  677  	help
ced3ce760b8df0 David E. Box              2014-09-17  678  	  This option enables sideband register access support for Intel SoC
ced3ce760b8df0 David E. Box              2014-09-17  679  	  platforms. On these platforms the IOSF sideband is used in lieu of
ced3ce760b8df0 David E. Box              2014-09-17  680  	  MSR's for some register accesses, mostly but not limited to thermal
ced3ce760b8df0 David E. Box              2014-09-17  681  	  and power. Drivers may query the availability of this device to
ced3ce760b8df0 David E. Box              2014-09-17  682  	  determine if they need the sideband in order to work on these
ced3ce760b8df0 David E. Box              2014-09-17  683  	  platforms. The sideband is available on the following SoC products.
ced3ce760b8df0 David E. Box              2014-09-17  684  	  This list is not meant to be exclusive.
ced3ce760b8df0 David E. Box              2014-09-17  685  	   - BayTrail
ced3ce760b8df0 David E. Box              2014-09-17  686  	   - Braswell
ced3ce760b8df0 David E. Box              2014-09-17  687  	   - Quark
ced3ce760b8df0 David E. Box              2014-09-17  688  
ced3ce760b8df0 David E. Box              2014-09-17  689  	  You should say Y if you are running a kernel on one of these SoC's.
ced3ce760b8df0 David E. Box              2014-09-17  690  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
