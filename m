Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084A06CFB82
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjC3G25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjC3G2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:28:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA634ED2;
        Wed, 29 Mar 2023 23:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157733; x=1711693733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wD8GKP3B56Z03DGtVse0/Ba7FvgZ/IA3mt3zB6FExL4=;
  b=WaPIrW9y11NDiJNJD5SdAcNbVnCddLw/NCjqNl76V5DOwJpNMb+CSEra
   B0qAFHzOdakXN6EVGO1mZ2X7cxegNS2qROxkEU2uReGk9d/hRCW7S3zvK
   YmAPNwMthP9OFxiGHxRYQ6WFxMLibXQ9To4tkD65O9QKxHzE9sh61rQTI
   LKIePFcV7jr/ZEvNO+UPKfbzwu4rOLhw6XprYPIju1WbLukh7+Vvx9TlR
   GDRhQ890NvusJUIQWRFIEKrTNMuJNwthhHZuWNX3DiT2l+rIpwexhOaMh
   a0d62d6miDygkSd4AMzvEj2PRvMGRBXYLxHd9fBGXn0ki0oQvHexlz862
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="325003986"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="325003986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753872393"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="753872393"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2023 23:28:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phllx-000KRS-38;
        Thu, 30 Mar 2023 06:28:33 +0000
Date:   Thu, 30 Mar 2023 14:28:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
Message-ID: <202303301456.qfo36qC0-lkp@intel.com>
References: <20230329154235.615349-3-brenda.streiff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329154235.615349-3-brenda.streiff@ni.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brenda,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brenda-Streiff/serial-8250-add-driver-for-NI-UARTs/20230330-010726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230329154235.615349-3-brenda.streiff%40ni.com
patch subject: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230330/202303301456.qfo36qC0-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6c50983e6760b2db288e3f8b7254cea537c0f052
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brenda-Streiff/serial-8250-add-driver-for-NI-UARTs/20230330-010726
        git checkout 6c50983e6760b2db288e3f8b7254cea537c0f052
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303301456.qfo36qC0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_ni.c:423:36: warning: unused variable 'ni16550_acpi_match' [-Wunused-const-variable]
   static const struct acpi_device_id ni16550_acpi_match[] = {
                                      ^
   1 warning generated.


vim +/ni16550_acpi_match +423 drivers/tty/serial/8250/8250_ni.c

   422	
 > 423	static const struct acpi_device_id ni16550_acpi_match[] = {
   424		{ "NIC7750",	(kernel_ulong_t)&nic7750 },
   425		{ "NIC7772",	(kernel_ulong_t)&nic7772 },
   426		{ "NIC792B",	(kernel_ulong_t)&nic792b },
   427		{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
   428		{ },
   429	};
   430	MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
