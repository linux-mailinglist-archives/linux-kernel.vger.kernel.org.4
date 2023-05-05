Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17446F8AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjEEVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjEEVVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:21:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D30525D;
        Fri,  5 May 2023 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683321691; x=1714857691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NcrdFZhFRig2Ni9b5QUbKvT5QpeRHY0bJM+OZxzy1Uw=;
  b=DlhDnA/NzOiS2pFNoRYf6RQy9JnEMwvKJA5WI4yt9oNrI3HGRxcMN0ra
   5mDvR2XGwJtgEtTkDYiJwsAF6f501/dJ4bSxCCoxbehxzQwpv7VlseDTc
   5zCZkKO033EZpEpT0XXa0sA81B0ofMid7vq5BKRHW8HwZQkqBU8lUz/XC
   EAIf0kFVD9TqG4UUA2Pt4cW38c62FPh5I8niUL8+dD2l9+DfXDc+aIJO5
   1bQAx86M6TUmcmewZ/rsUg15rb6vq0IK0on1MwzFWKicfOTR/PgjBThRu
   5QdDQYdKwxXjRpmTeYI9PhaEAkpkfaQWA/XEGkU8bJljd9iLVPqzcv623
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="412541880"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="412541880"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="697746745"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="697746745"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2023 14:21:28 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pv2rn-0000rh-1E;
        Fri, 05 May 2023 21:21:27 +0000
Date:   Sat, 6 May 2023 05:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, Oleksii_Moisieiev@epam.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, peng.fan@oss.nxp.com, sudeep.holla@arm.com
Subject: Re: [PATCH] [REVIEW][PINCTRL]: Misc Fixes and refactor
Message-ID: <202305060517.oC3TTnp4-lkp@intel.com>
References: <20230505201012.3171817-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505201012.3171817-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

kernel test robot noticed the following build warnings:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20230506-041158/Oleksii-Moisieiev/pinctrl-Implementation-of-the-generic-scmi-pinctrl-driver/20230426-222739
base:   the 1th patch of https://lore.kernel.org/r/b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev%40epam.com
patch link:    https://lore.kernel.org/r/20230505201012.3171817-1-cristian.marussi%40arm.com
patch subject: [PATCH] [REVIEW][PINCTRL]: Misc Fixes and refactor
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230506/202305060517.oC3TTnp4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c3e47504d3b8eac203b4ae3fc56c3791790dd88b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20230506-041158/Oleksii-Moisieiev/pinctrl-Implementation-of-the-generic-scmi-pinctrl-driver/20230426-222739
        git checkout c3e47504d3b8eac203b4ae3fc56c3791790dd88b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305060517.oC3TTnp4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/arm_scmi/pinctrl.c: In function 'scmi_pinctrl_attributes':
   drivers/firmware/arm_scmi/pinctrl.c:227:45: error: passing argument 4 of '((const struct scmi_proto_helpers_ops *)ph->hops)->extended_name_get' from incompatible pointer type [-Werror=incompatible-pointer-types]
     227 |                                             (u32 *)&type, name,
         |                                             ^~~~~~~~~~~~
         |                                             |
         |                                             u32 * {aka unsigned int *}
   drivers/firmware/arm_scmi/pinctrl.c:227:45: note: expected 'char *' but argument is of type 'u32 *' {aka 'unsigned int *'}
>> drivers/firmware/arm_scmi/pinctrl.c:227:59: warning: passing argument 5 of '((const struct scmi_proto_helpers_ops *)ph->hops)->extended_name_get' makes integer from pointer without a cast [-Wint-conversion]
     227 |                                             (u32 *)&type, name,
         |                                                           ^~~~
         |                                                           |
         |                                                           char *
   drivers/firmware/arm_scmi/pinctrl.c:227:59: note: expected 'size_t' {aka 'unsigned int'} but argument is of type 'char *'
   drivers/firmware/arm_scmi/pinctrl.c:226:17: error: too many arguments to function '((const struct scmi_proto_helpers_ops *)ph->hops)->extended_name_get'
     226 |                 ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
         |                 ^~
   cc1: some warnings being treated as errors


vim +227 drivers/firmware/arm_scmi/pinctrl.c

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
 > 227						    (u32 *)&type, name,
   228						    SCMI_MAX_STR_SIZE);
   229		return ret;
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
