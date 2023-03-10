Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB86B4338
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCJOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCJOKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:10:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280EAD1AC0;
        Fri, 10 Mar 2023 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678457437; x=1709993437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQKZIOF/wMb0UoRLhTSf5HRmzAguZQNRAQCPCfA7mto=;
  b=R2wg4yp/7emgIT+eqB7x91TIEIy7jbDMchUqqdUjF3n+uonCxWyoMB4D
   QFOBtziAZtb5WLuxU+ppoYhFEvnYIYCPGkwqMqT/kuZLSHuxxjib0rEf4
   6rv1WtJjyg/yRddalZ08/BtjVa6g3vVL++4k7bEMx4tP0t6QvVrJG2Vfq
   iR+GA0P0KkOV0XJqCl33C3vYz9atks9x/bF14CN23tvPaSHiuCYdS27BO
   GPypEdSeZZeybbJm2mxsFGi7WMBPoFBxt1IbjCWh1N8gsszO0rC68prVL
   CHDi6MjZqEq6RJgAn6Aa8m5lG4cHkgEbMLGw9qbC5M4PCEM0fxDwJlaLk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336753280"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="336753280"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="741990954"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="741990954"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 06:10:20 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1padRs-0003u7-0G;
        Fri, 10 Mar 2023 14:10:20 +0000
Date:   Fri, 10 Mar 2023 22:09:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack.zhu@starfivetech.com, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v2 6/6] media: starfive: Add Starfive Camera Subsystem
 driver
Message-ID: <202303102141.A9LHC4MD-lkp@intel.com>
References: <20230310120553.60586-7-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310120553.60586-7-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on robh/for-next linus/master v6.3-rc1 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jack-Zhu/media-dt-bindings-Add-bindings-for-JH7110-Camera-Subsystem/20230310-200747
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230310120553.60586-7-jack.zhu%40starfivetech.com
patch subject: [PATCH v2 6/6] media: starfive: Add Starfive Camera Subsystem driver
config: i386-randconfig-c021 (https://download.01.org/0day-ci/archive/20230310/202303102141.A9LHC4MD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/99a31fd3820a2d95b0d0f381491c473975e0b068
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jack-Zhu/media-dt-bindings-Add-bindings-for-JH7110-Camera-Subsystem/20230310-200747
        git checkout 99a31fd3820a2d95b0d0f381491c473975e0b068
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303102141.A9LHC4MD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/stf_isp_ioctl.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/stf_isp_ioctl.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1394: headers] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:242: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
