Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38036FC30D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjEIJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjEIJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:47:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7675E7;
        Tue,  9 May 2023 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683625675; x=1715161675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qHyAThXYmVHluBPVN2uS0ad8NkGdnwbxCZvndMHC6J4=;
  b=HUV+LuzEzmVoMPdcYBcS2+W9Z4XD1iwhLPVnf6S1Ugpn+GMhevY0uavP
   XDV6o+TBRy9WBnO538zMVAyN703NnSCKKuLeNh8F6VW59E/D55SMhOyGL
   x1GhJcVcAoaFKkNdtTy46o5PPdzyBKCwp7H9jUV/Rre1YPsqjZQ1/fOdb
   /hItIa8txHmgBXBE6JXi3qXezqKAg51+nGueKqckULShibc1kotnfluSj
   KDy20LFcENQrwq7+MRiHzkfx1yjgaExLeeKTHYUwf31SXMgGV3lIQjDr9
   cCoLsWji2wlCgGEaXro3xNQZPUBcEn6p1XehO8YacGG/OY6xcgzRzUfVr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="415445309"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="415445309"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 02:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="698835080"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="698835080"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2023 02:47:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwJwl-00021Y-0t;
        Tue, 09 May 2023 09:47:51 +0000
Date:   Tue, 9 May 2023 17:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com,
        peng.fan@oss.nxp.com, sudeep.holla@arm.com
Subject: Re: [PATCH] [REVIEW][PINCTRL]: Misc Fixes and refactor
Message-ID: <202305091719.8LNihq5L-lkp@intel.com>
References: <20230505201012.3171817-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505201012.3171817-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

kernel test robot noticed the following build errors:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20230506-041158/Oleksii-Moisieiev/pinctrl-Implementation-of-the-generic-scmi-pinctrl-driver/20230426-222739
base:   the 1th patch of https://lore.kernel.org/r/b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev%40epam.com
patch link:    https://lore.kernel.org/r/20230505201012.3171817-1-cristian.marussi%40arm.com
patch subject: [PATCH] [REVIEW][PINCTRL]: Misc Fixes and refactor
config: arm-randconfig-r011-20230508 (https://download.01.org/0day-ci/archive/20230509/202305091719.8LNihq5L-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/c3e47504d3b8eac203b4ae3fc56c3791790dd88b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20230506-041158/Oleksii-Moisieiev/pinctrl-Implementation-of-the-generic-scmi-pinctrl-driver/20230426-222739
        git checkout c3e47504d3b8eac203b4ae3fc56c3791790dd88b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/firmware/arm_scmi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091719.8LNihq5L-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/arm_scmi/pinctrl.c:228:10: error: too many arguments to function call, expected 5, have 6
                                               SCMI_MAX_STR_SIZE);
                                               ^~~~~~~~~~~~~~~~~
   include/linux/scmi_protocol.h:16:28: note: expanded from macro 'SCMI_MAX_STR_SIZE'
   #define SCMI_MAX_STR_SIZE               64
                                           ^~
   1 error generated.


vim +228 drivers/firmware/arm_scmi/pinctrl.c

   182	
   183	static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
   184					   enum scmi_pinctrl_selector_type type,
   185					   u32 selector, char *name,
   186					   unsigned int *n_elems)
   187	{
   188		int ret;
   189		u32 attrs;
   190		struct scmi_xfer *t;
   191		struct scmi_msg_pinctrl_attributes *tx;
   192		struct scmi_resp_pinctrl_attributes *rx;
   193	
   194		if (!name)
   195			return -EINVAL;
   196	
   197		ret = scmi_pinctrl_validate_id(ph, selector, type);
   198		if (ret)
   199			return ret;
   200	
   201		ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
   202					      sizeof(*rx), &t);
   203		if (ret)
   204			return ret;
   205	
   206		tx = t->tx.buf;
   207		rx = t->rx.buf;
   208		tx->identifier = cpu_to_le32(selector);
   209		tx->flags = cpu_to_le32(type);
   210	
   211		ret = ph->xops->do_xfer(ph, t);
   212		if (!ret) {
   213			attrs = le32_to_cpu(rx->attributes);
   214			if (n_elems)
   215				*n_elems = NUM_ELEMS(attrs);
   216			strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
   217		}
   218	
   219		ph->xops->xfer_put(ph, t);
   220	
   221		/*
   222		 * If supported overwrite short name with the extended one;
   223		 * on error just carry on and use already provided short name.
   224		 */
   225		if (!ret && EXT_NAME_FLAG(attrs))
   226			ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
   227						    (u32 *)&type, name,
 > 228						    SCMI_MAX_STR_SIZE);
   229		return ret;
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
