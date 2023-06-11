Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D4A72B379
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjFKSyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 14:54:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB22A1AB;
        Sun, 11 Jun 2023 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686509655; x=1718045655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xnHJA5weoJg6GxFX8RokeU3V9+mWmJin9gvDUSp+TIY=;
  b=TgySv1JMIKE51fK/15WAs9EoM7Eai77Jf/v+mY8m/9qxOQ0ZfXE3U4pF
   BcnTpJzr2GdIC+MLb+iYxoUqlCqNbbH5mVoAZ2sjLt5bCCALcnQasgeqm
   auy8SRVJYNvh2rgBeDOlqwfpDtRttY1ftVhLrhI6RSuHwB9kl+6VBmzn+
   Lj/L/aUWYoJ6W+LDkTIfYd9zti1QxPOJapDX2bIlwA1aHIelkkzsTUoGH
   5OQr/8a2M5IgK0SOo9fHlV5QsgyRC39nA8QPg7Hn5LBEtzYv/g3Mgv1LM
   cFYFh0cINGauv1F6OGBt+pPb7B9hQJ8fZlUaCrEWp5JBb23fl9BJyJ8Tp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="421489035"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="421489035"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 11:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="705135052"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="705135052"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2023 11:54:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8QCb-000B3w-0K;
        Sun, 11 Jun 2023 18:54:13 +0000
Date:   Mon, 12 Jun 2023 02:53:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Roith <johannes@gnu-linux.rocks>, jikos@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Roith <johannes@gnu-linux.rocks>
Subject: Re: [PATCH 2/2] hid-mcp2200 - updated hid-id.h
Message-ID: <202306120204.6ROntFhJ-lkp@intel.com>
References: <20230611164811.1388-2-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611164811.1388-2-johannes@gnu-linux.rocks>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4-rc5]
[also build test WARNING on linus/master next-20230609]
[cannot apply to hid/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Roith/hid-mcp2200-updated-hid-id-h/20230612-005025
base:   v6.4-rc5
patch link:    https://lore.kernel.org/r/20230611164811.1388-2-johannes%40gnu-linux.rocks
patch subject: [PATCH 2/2] hid-mcp2200 - updated hid-id.h
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20230612/202306120204.6ROntFhJ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout v6.4-rc5
        b4 shazam https://lore.kernel.org/r/20230611164811.1388-2-johannes@gnu-linux.rocks
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306120204.6ROntFhJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/hid/hid-core.c:36:
>> drivers/hid/hid-ids.h:915: warning: "USB_DEVICE_ID_MCP2221" redefined
     915 | #define USB_DEVICE_ID_MCP2221           0x00df
         | 
   drivers/hid/hid-ids.h:914: note: this is the location of the previous definition
     914 | #define USB_DEVICE_ID_MCP2221           0x00dd
         | 


vim +/USB_DEVICE_ID_MCP2221 +915 drivers/hid/hid-ids.h

   905	
   906	#define USB_VENDOR_ID_MICROCHIP		0x04d8
   907	#define USB_DEVICE_ID_PICKIT1		0x0032
   908	#define USB_DEVICE_ID_PICKIT2		0x0033
   909	#define USB_DEVICE_ID_PICOLCD		0xc002
   910	#define USB_DEVICE_ID_PICOLCD_BOOTLOADER	0xf002
   911	#define USB_DEVICE_ID_PICK16F1454	0x0042
   912	#define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7
   913	#define USB_DEVICE_ID_LUXAFOR		0xf372
   914	#define USB_DEVICE_ID_MCP2221		0x00dd
 > 915	#define USB_DEVICE_ID_MCP2221		0x00df
   916	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
