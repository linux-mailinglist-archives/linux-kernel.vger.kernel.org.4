Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB27331DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345352AbjFPNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFPNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:06:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9302D77;
        Fri, 16 Jun 2023 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686920794; x=1718456794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kmDwdXdCqysX9s168Eg4s4iYxEBlcW+iZlTT/8p/uPE=;
  b=XHWdQbVxueB9BeT+OIpquWomEr7kDmy9Q5NSJHoWnnC1gyWGBT0zXubl
   dbIG7KJsz4mMLogPAIHSmlR00298DDi316vMzMJYp84gpSxWTOmuF6V2d
   GopHoJcO0wP0KPwxlkFMIf/ofSt85jluftqMRBU94lIMnp7NUaWICNNzi
   EyeQi+Mf3lq70UFMbpHzvSPw/33uEcHB2O+rmEpbLhKeceScCbM4usQ/e
   kkwyY232W2Oft/jSIqigw9qt8Sp+waCQrbcxvjse+BBUkPu7UIQvGQX5R
   kmcCCeYn4OojLZRetB0+IEppwdw6MUkpA2uaPZ3Jd2USArGsnaJpF4nKT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445591175"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="445591175"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 06:06:33 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="746257381"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="746257381"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2023 06:06:27 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qA99m-0001G4-2i;
        Fri, 16 Jun 2023 13:06:26 +0000
Date:   Fri, 16 Jun 2023 21:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, jacopo.mondi@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        hdegoede@redhat.com, Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] media: i2c: Add support for alvium camera
Message-ID: <202306162030.twEiu4Wm-lkp@intel.com>
References: <20230616095713.187544-4-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616095713.187544-4-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on robh/for-next linus/master v6.4-rc6 next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tommaso-Merciai/dt-bindings-vendor-prefixes-Add-prefix-alliedvision/20230616-180025
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230616095713.187544-4-tomm.merciai%40gmail.com
patch subject: [PATCH v6 3/3] media: i2c: Add support for alvium camera
config: sparc-randconfig-r002-20230616 (https://download.01.org/0day-ci/archive/20230616/202306162030.twEiu4Wm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230616/202306162030.twEiu4Wm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306162030.twEiu4Wm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/media/i2c/alvium-csi2.c:33:
>> drivers/media/i2c/alvium-csi2.h:15:10: fatal error: media/v4l2-cci.h: No such file or directory
      15 | #include <media/v4l2-cci.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +15 drivers/media/i2c/alvium-csi2.h

    12	
    13	#include <linux/kernel.h>
    14	#include <linux/regulator/consumer.h>
  > 15	#include <media/v4l2-cci.h>
    16	#include <media/v4l2-common.h>
    17	#include <media/v4l2-ctrls.h>
    18	#include <media/v4l2-fwnode.h>
    19	#include <media/v4l2-subdev.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
