Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5166472DD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbjFMJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbjFMJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:17:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A095B10EC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686647866; x=1718183866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEoMNzuuvXSuMflDY7mvoN7sBa2jkXZCTsDIB/QocmU=;
  b=F8F8D2owM71WYQnAmYC33PP9rk1gR5elZnlfSB6kNFr1exMaWejYBZbm
   z6uEs9g8aabcGHlHVKrhUpz7rgqeKLX2G9+T7uT/N/Pravwg/KGUsBhH5
   cjPqksKpvtY9LGtp6i+FLGpEN0OxaanyP7IaFSwTEG71FXvEkFjgHNWU8
   FtBA0dcoWWCNzSRVyrTJWZ53vDybOsim5zu6v0efCVz2MBplBsX/0GWwt
   2UG1XTXiJP6Bj/Fkt4jp1amItIL6R11yG9hlYpHapgTmPYa3q3Alm3gll
   VGXzQSjx+cyxMklo+5E/cJhEaa2xSECoNGUnkCsLK8CuBx3bTQxl7x0Re
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347930549"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347930549"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="714719482"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="714719482"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 02:17:44 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q909n-00019U-1Q;
        Tue, 13 Jun 2023 09:17:43 +0000
Date:   Tue, 13 Jun 2023 17:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yogesh Hegde <yogi.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/5] staging: rtl8192e: Remove variable
 SetBWModeHandler
Message-ID: <202306131731.yvRofzzm-lkp@intel.com>
References: <0af9595916447a28e27c249f3696fe107382ca53.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af9595916447a28e27c249f3696fe107382ca53.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v6.4-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yogesh-Hegde/staging-rtl8192e-Remove-variable-SetWirelessMode/20230607-230636
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/0af9595916447a28e27c249f3696fe107382ca53.1686149467.git.yogi.kernel%40gmail.com
patch subject: [PATCH v2 2/5] staging: rtl8192e: Remove variable SetBWModeHandler
config: x86_64-randconfig-s053-20230611 (https://download.01.org/0day-ci/archive/20230613/202306131731.yvRofzzm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/58c941ed304bd37db4311cd7151f399f8e77daa6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yogesh-Hegde/staging-rtl8192e-Remove-variable-SetWirelessMode/20230607-230636
        git checkout 58c941ed304bd37db4311cd7151f399f8e77daa6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131731.yvRofzzm-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rtl92e_set_bw_mode" [drivers/staging/rtl8192e/rtllib.ko] undefined!
ERROR: modpost: "rtl92e_set_wireless_mode" [drivers/staging/rtl8192e/rtllib.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
