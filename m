Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B272B536
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjFLBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:52:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A36136
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 18:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686534776; x=1718070776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m46vQZk4pefLmm8P5SfQHMea4c/QsvdPEaoeo/+mU18=;
  b=d4MnuauMbtK5FlL0pQEx5UTkUf4XeAfgUGynsmG6fw8235qHjNNyfTu1
   58fgnuU0qPXfwSLYblV0p2QBVO0YMxGz7h9JunbeUZ7qsrpfq/lC5f6ZF
   dGVURe67YhDQoPmjJYaylL8z5i2JjZHmJHX3Ir3nr5yq2vjCQkfLJ+HvK
   +uSyVKw6lwEx1u6AF9YDgWWnKEIbye6rbmYA1U99m7ZmFRPKG9JOppmCz
   nHPeRlCttSyZ91xEd53WlmoayDPUF1Je/JLfk4EVgQ032CAlBvT5QdAIN
   SEqKsMEoV8xPpgYy3I5OUMDDWdcgdJJjuGgtvYDUFwVTe+/vDBHNq3Bzu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="338286803"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="338286803"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 18:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="1041156934"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="1041156934"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2023 18:52:55 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8Wjm-00001A-14;
        Mon, 12 Jun 2023 01:52:54 +0000
Date:   Mon, 12 Jun 2023 09:52:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yogesh Hegde <yogi.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
Message-ID: <202306120923.uMeOfojk-lkp@intel.com>
References: <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v6.4-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yogesh-Hegde/staging-rtl8192e-Remove-variable-SetWirelessMode/20230607-230636
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel%40gmail.com
patch subject: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
config: x86_64-randconfig-s053-20230611 (https://download.01.org/0day-ci/archive/20230612/202306120923.uMeOfojk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/823187b988791852e562dba90e5eb7c7e7df8eca
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yogesh-Hegde/staging-rtl8192e-Remove-variable-SetWirelessMode/20230607-230636
        git checkout 823187b988791852e562dba90e5eb7c7e7df8eca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306120923.uMeOfojk-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rtl92e_set_wireless_mode" [drivers/staging/rtl8192e/rtllib.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
