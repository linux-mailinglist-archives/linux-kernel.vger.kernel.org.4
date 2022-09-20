Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A335BDBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiITEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiITEjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:39:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F164D26B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663648743; x=1695184743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t65hmtg+Ohe926b49LfToFG3Rs/HO2BwCzV0502QZys=;
  b=dYHvEqtyFlFOU3ug1vIOt9BRxrBvUzQ0vyn0ZnoiatuEHhoaeuy6nEiE
   Vq7IuZFVNfv0WGTMRp9dQZQA5zQ1FWQ4jO13kjiNVzBEyVwAvibjyLKc+
   MT+be33e4jeJR95MgvBBs5pwb8TICdwlg8jNgUZKadJLpEQWaa1oaE7qi
   7y9cM/x9i3yk37A6Gz8B0kwDU53NCUChJih+Ag3/GjHUNP7AN3BhY0xOQ
   hHEXsyG/s4XV4AyiM1fY9k9zNFhauKH2BOQwcCDoNCuwZKXuX+rAHzMgj
   PY+NsWocJq6NBIRveXjjvrpB5C9DAhpROrIwzZYuaQDmdsPySx5AmLDlF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325893569"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="325893569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 21:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="761151340"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2022 21:39:01 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaV2C-0002TR-39;
        Tue, 20 Sep 2022 04:39:00 +0000
Date:   Tue, 20 Sep 2022 12:38:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:linux-5.10.y 2319/8454] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x7434): Section mismatch in reference from the
 function trace_define_generic_fields() to the variable
 .init.data:initcall_level_names
Message-ID: <202209201214.BcI4RWh1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   02c4837d98bf509b70afb8368175c489a5ba7b4a
commit: 092a58f0d9ef5013ad3c197a9a5ecf2d7f797a88 [2319/8454] tracing: Fix pid filtering when triggers are attached
config: xtensa-randconfig-r016-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201214.BcI4RWh1-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=092a58f0d9ef5013ad3c197a9a5ecf2d7f797a88
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 092a58f0d9ef5013ad3c197a9a5ecf2d7f797a88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x722c): Section mismatch in reference from the function __list_add() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x7434): Section mismatch in reference from the function trace_define_generic_fields() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
