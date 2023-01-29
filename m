Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09381680325
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjA2XtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA2XtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:49:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5927FF32
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675036151; x=1706572151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iaqAdkk/X3QUogkMKk0ewgVWnweWJmz2DVVxnqLLcPw=;
  b=CTc4/M59VnlIxluTOgy8wM+xTP4+xbSL7r1CQkz8/qQIcgxDX06oNNfh
   q/neABCHriK9PtqeBKZaRF/TD4DkF/20RtM7JLQxe48TbqIIKjPqlksso
   KjYi24r7axElDgpxc6E1XQFQ4J+5Nuq58jTOBVx7z4At9tqCCinszAOBw
   1FYGGSlmAwQPBlPVMC85m3QP93NNNWglUvffVxsZRcryHdWwFbFJoP1W3
   kxS4BHZP3XeBrZ6CNtPgfzKbqZI1iCqVSXTuyEx8rPNbzF9teZtGRq60e
   egBmZSo60b7+RSeEW9ZRN/I1O6EL8H3nN4NyRyozRbAWJFkDYFNRKg3Zt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="329572331"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="329572331"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 15:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="787828190"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="787828190"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2023 15:49:09 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMHQ4-0003BW-1f;
        Sun, 29 Jan 2023 23:49:08 +0000
Date:   Mon, 30 Jan 2023 07:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: error: Undefined temporary symbol .LBB5_-1
Message-ID: <202301300732.QfTDtiab-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d796c50f84ca79f1722bb131799e5a5710c4700
commit: a9f17d0c0778dd971dc9770fa0a2085a41d8c5e4 phy: ti: tusb1210: Fix an error handling path in tusb1210_probe()
date:   10 months ago
config: arm-randconfig-r006-20230130 (https://download.01.org/0day-ci/archive/20230130/202301300732.QfTDtiab-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9f17d0c0778dd971dc9770fa0a2085a41d8c5e4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a9f17d0c0778dd971dc9770fa0a2085a41d8c5e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: Undefined temporary symbol .LBB5_-1
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
