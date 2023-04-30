Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA06F2738
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjD3AUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 20:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjD3AUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 20:20:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5856210F3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682814018; x=1714350018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DOKIRVWZ3MCEKY5SmxQxqvb4fyBZlD3jZ64Y8inPPf0=;
  b=LPzZt+6qii5cDKjkuLG9KMBnIKlo6bkKlBKFC1RhYh+D5wlyjX2rzqIS
   tNQc2rAqnyHJoJdqAkJiH5c3bsASxlPIzW8FFqRVJY+HW4tkjlxPNu4Gm
   XlZX1ZQtRV/sxJGyIryrLuglOXyY8XqrGZioW6gZxjZUyK2d+wloAHw7y
   Rmb5BQ7ZzzFlAjnY/d+onTZHZY/iTy5uNRhIEQPOm/ffscqtuP8TaKCSf
   TERRwW3r7oT1D5n7NcsozKpZ62LqkN2+ZD/b5Hs9kf5V09EiL2pN9ZQRI
   E84XlvpE5LawTu/mahh19VKTmiB+eqaXSrhrhcJNcBmzGlGcZieEvOj1J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="350020696"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="350020696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 17:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="672720726"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="672720726"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2023 17:20:15 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psunW-0001Pt-38;
        Sun, 30 Apr 2023 00:20:14 +0000
Date:   Sun, 30 Apr 2023 08:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     alison@she-devel.com, johan@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison@she-devel.com, achaiken@aurora.tech
Subject: Re: [PATCH 1/2] gnss: ubx: customize serial device open to set
 U-Blox Zed-F9P baud
Message-ID: <202304300819.u0hfUj33-lkp@intel.com>
References: <20230429224349.1935029-2-alison@she-devel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429224349.1935029-2-alison@she-devel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-she-devel-com/gnss-ubx-customize-serial-device-open-to-set-U-Blox-Zed-F9P-baud/20230430-065242
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230429224349.1935029-2-alison%40she-devel.com
patch subject: [PATCH 1/2] gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230430/202304300819.u0hfUj33-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/743f5061f999abbdc0b6f366cf4b85a5a8685014
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review alison-she-devel-com/gnss-ubx-customize-serial-device-open-to-set-U-Blox-Zed-F9P-baud/20230430-065242
        git checkout 743f5061f999abbdc0b6f366cf4b85a5a8685014
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gnss/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304300819.u0hfUj33-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gnss/ubx.c:246:37: warning: 'ubx_gserial_ops' defined but not used [-Wunused-const-variable=]
     246 | static const struct gnss_serial_ops ubx_gserial_ops = {
         |                                     ^~~~~~~~~~~~~~~


vim +/ubx_gserial_ops +246 drivers/gnss/ubx.c

1ad69f10e3a58d Johan Hovold   2018-06-01  245  
55570f1a441787 Colin Ian King 2018-07-16 @246  static const struct gnss_serial_ops ubx_gserial_ops = {
1ad69f10e3a58d Johan Hovold   2018-06-01  247  	.set_power = ubx_set_power,
1ad69f10e3a58d Johan Hovold   2018-06-01  248  };
1ad69f10e3a58d Johan Hovold   2018-06-01  249  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
