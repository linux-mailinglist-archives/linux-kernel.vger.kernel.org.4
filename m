Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6627213EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 03:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFDBEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 21:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 21:04:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC2E1A4;
        Sat,  3 Jun 2023 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685840648; x=1717376648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wJqTTbsk/iHJD7CbhDVzaKecBsql3rMokp64c3Bl3M=;
  b=X9NrkbLtLLVqQ/+/w+E4ME2kSyGlkhz2qlLfW5BhNxCMWEQYFJ5QCIPn
   ZG2332nzqnsQM857qzhyxrC4uLu9gXjvVMylZH44aItO+WEMumzx1u8/9
   FIrIfS4Wekf+pAGqKuzMw5DaA2xuDhEpJCLwy+TIazYo1mtDSsmAa/4z0
   5WGJ6VmDj+XLjbF3rKOCY5hJp0nhLWmEDIUlROvdajERDiDMd1vRmIBgR
   3X7bkRZMis09vpCDzFDDWLKMRXg9An879vXP6ZjjPNRUnbEvL6JiA4hzn
   6d2VfN6zZSGxt/mDWr5SGBWrxHGpkzM5mRC4j2OSYX+KAMv5GMFryDGMQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="442508655"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442508655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 18:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="741236515"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741236515"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2023 18:04:04 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5cA8-0002Bn-0F;
        Sun, 04 Jun 2023 01:04:04 +0000
Date:   Sun, 4 Jun 2023 09:03:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, corbet@lwn.net
Cc:     oe-kbuild-all@lists.linux.dev, rdunlap@infradead.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH v2 -next] tty: serial: add panic serial helper
Message-ID: <202306040839.IrnnKYxH-lkp@intel.com>
References: <20230602011835.582430-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602011835.582430-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongyu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230601]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongyu-Xie/tty-serial-add-panic-serial-helper/20230602-092109
base:   next-20230601
patch link:    https://lore.kernel.org/r/20230602011835.582430-1-xiehongyu1%40kylinos.cn
patch subject: [PATCH v2 -next] tty: serial: add panic serial helper
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/0d2aa58f592716807757b3c92fb62fe7aa4eef66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongyu-Xie/tty-serial-add-panic-serial-helper/20230602-092109
        git checkout 0d2aa58f592716807757b3c92fb62fe7aa4eef66
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306040839.IrnnKYxH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/dev-tools/panic_serial_helper.rst:66: WARNING: Unexpected indentation.
>> Documentation/dev-tools/panic_serial_helper.rst:62: WARNING: Inline interpreted text or phrase reference start-string without end-string.
>> Documentation/dev-tools/panic_serial_helper.rst:69: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/dev-tools/panic_serial_helper.rst:86: WARNING: Enumerated list ends without a blank line; unexpected unindent.
>> Documentation/dev-tools/panic_serial_helper.rst:92: WARNING: Option list ends without a blank line; unexpected unindent.
>> Documentation/dev-tools/panic_serial_helper.rst:130: WARNING: Inconsistent literal block quoting.

vim +66 Documentation/dev-tools/panic_serial_helper.rst

    61	
  > 62	First you need to enable ``CONFIG_PANIC_SERIAL_HELPER`` in your
    63	config. To enable ``CONFIG_PANIC_SERIAL_HELPER`` you should look under
    64	:menuselection:
    65	`Device Drivers
  > 66	  --> Character devices
    67	    --> Enable TTY (TTY [=y])
    68	      --> Serial drivers`
  > 69	and select
    70	:menuselection:`debug through UART after panic`.
    71	
    72	Second, build and update the kernel image. Then wait for panic.
    73	
    74	After panic, you need to do the following,
    75	1. connect the UART side of an USB-to-UART tool to any UART
    76	  port on your device (PC, server, Laptop, etc...).
    77	  Connect the USB side of that tool to another PC. Open
    78	  minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
    79	  "/dev/ttyUSB1 if there is already another USB-to-UART tool
    80	  connected to your device) with "115200 8N1".
    81	
    82	  It automatically selects the port where you first press the
    83	  "Enter" key (some keyboard labeled this with "Return").
    84	
    85	2. press "Enter" (or "Return") in that
  > 86	  minicom window; you'll get a help menu:
    87	  "
    88	  help:
    89	      -a      show all kernel msg
    90	      -3      show S3 msg
    91	      -4      show S4 msg
  > 92	      -filter-[string]        show msg containing [string]
    93	      -q-     quit
    94	  "
    95	
    96	see ``Help menu options`` for details.
    97	
    98	3. finally, type 'a', '3', '4', 'q' or "filter-xxx" then press
    99	 "Enter" to get what you want.
   100	
   101	Help menu options
   102	-----------------
   103	Available options:
   104	
   105	 - a
   106	
   107	   Show all the messages starting from ``Booting Linux on ...``
   108	
   109	 - 3
   110	
   111	   If STR happened before panic, this will show messages starting from
   112	   ``PM: suspend entry...``
   113	
   114	 - 4
   115	
   116	   If STD happened before panic, this will show messages starting from
   117	   ``PM: hibernation entry...``
   118	
   119	 - filter-[string]
   120	
   121	   Provide case-ignored filter matching. Only show messages that containing
   122	   ``string``. For example, if you're only interesting in message lines
   123	   that containing ``CPU`` or ``cpu``, you just input
   124	   ``filter-CPU`` or ``filter-cpu``.
   125	   Here is an output example for filtering ``CPU``::
   126	
   127	   <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
   128	   <6>[    0.000000] Detected PIPT I-cache on CPU0
   129	   <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
 > 130	   ...

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
