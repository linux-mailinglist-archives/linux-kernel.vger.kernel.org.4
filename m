Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC4E723347
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjFEWie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFEWic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:38:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB7F3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686004711; x=1717540711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LqOBzGUF/ig7ymEXy7eew8beh61DQfT0AV43emlgyR4=;
  b=QYr3QYizDY4xeWMiBl9WQ9F6dfPyYwKf2/D7HtlvhtsvrMV542HfZgcv
   5nITu7EPRig7c7+AZ28/xrNi2IYWmni92GHcDRSDMRO6H6/EVH+GAaINi
   6UB7gB9xWfOO3cA4bT97SeUVnfZMs/ydWH+jqxYPEVAG0pLSBmZyM7FwH
   PGBwg4RGHRgsiQFSAXAyiH5BsnJPG3AQMen2tOuU2JFtDj/vYHKAB6Uzf
   HF78JI8HT0Q6Fhj7feRvO5Oy40d9FPycyurdretrJO0nfr028JuQqZMx0
   5e3V0rOFB05zjDAhMGl1V3rPLbBunujG21cLRygpZYZ9w37BfipMhkJDe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="341139298"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="341139298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 15:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821347435"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821347435"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2023 15:38:29 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6IqK-0004UZ-13;
        Mon, 05 Jun 2023 22:38:28 +0000
Date:   Tue, 6 Jun 2023 06:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>
Subject: drivers/scsi/csiostor/csio_lnode.o: warning: objtool:
 csio_ln_fdmi_rhba_cbfn() falls through to next function csio_lns_online()
Message-ID: <202306060605.uO2QarfW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8dba31b0a826e691949cd4fdfa5c30defaac8c5
commit: e240e53ae0abb0896e0f399bdfef41c69cec3123 mm, slub: add CONFIG_SLUB_TINY
date:   6 months ago
config: x86_64-randconfig-a011-20230606 (https://download.01.org/0day-ci/archive/20230606/202306060605.uO2QarfW-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e240e53ae0abb0896e0f399bdfef41c69cec3123
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e240e53ae0abb0896e0f399bdfef41c69cec3123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/crypto/ drivers/scsi/csiostor/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306060605.uO2QarfW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/csiostor/csio_lnode.o: warning: objtool: csio_ln_fdmi_rhba_cbfn() falls through to next function csio_lns_online()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
