Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE64E69DAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjBUGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBUGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:31:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F004241C0;
        Mon, 20 Feb 2023 22:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676961110; x=1708497110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hYUCXryiM4L3qab7cv2qTNgu2EnjgadpYPHNseM+KU=;
  b=O8vmlOTAAnNuOI3ud4H2c3nHw7l+4vJlFdKvfjyNVhsFJNcRPnPkppBt
   3AzUYcCEiiVJHl1BBoHyCVfU28WCfXEt5nALq9XXQp16GXzh1/lSp1cXf
   aLHHOVXrXQgnjTuKTpy/Se7DKKukTN4r7W7gw2hH0rrcpAP4wVQY8ZRCL
   0fHCt4wym01DKOZ3IlmyTU2EDtxo17BF0bTSdhuTteFot/Mn+VbGCowxV
   YO/F+G8aLBUgbzgOoLSlnTfz3vw62+WQGk2ka0iBesXt5JJnXSinAg5mA
   DMj2zDxeGg0JVI+yLM2AQf9H7wjnWTB5RJhTkVpVrNgCbO7QwZhEezNvb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="332563874"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="332563874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 22:31:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="703923205"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="703923205"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2023 22:31:48 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUMBn-000EWM-2Q;
        Tue, 21 Feb 2023 06:31:47 +0000
Date:   Tue, 21 Feb 2023 14:31:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        damien.lemoal@opensource.wdc.com
Cc:     oe-kbuild-all@lists.linux.dev, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ata: pata_macio: Use of_property_present() helper
Message-ID: <202302211458.tgO9izcv-lkp@intel.com>
References: <20230221023634.87925-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221023634.87925-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20230220]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li/ata-pata_macio-Use-of_property_present-helper/20230221-103834
patch link:    https://lore.kernel.org/r/20230221023634.87925-1-yang.lee%40linux.alibaba.com
patch subject: [PATCH -next] ata: pata_macio: Use of_property_present() helper
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230221/202302211458.tgO9izcv-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/257ef88e819f378a5925cd9a44857f4591d860e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Li/ata-pata_macio-Use-of_property_present-helper/20230221-103834
        git checkout 257ef88e819f378a5925cd9a44857f4591d860e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302211458.tgO9izcv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ata/pata_macio.c: In function 'pata_macio_cable_detect':
>> drivers/ata/pata_macio.c:482:37: error: incompatible types when initializing type 'const char *' using type 'bool' {aka '_Bool'}
     482 |                 const char *cable = of_property_present(priv->node, "cable-type");
         |                                     ^~~~~~~~~~~~~~~~~~~
   drivers/ata/pata_macio.c:484:37: error: incompatible types when initializing type 'const char *' using type 'bool' {aka '_Bool'}
     484 |                 const char *model = of_property_present(root, "model");
         |                                     ^~~~~~~~~~~~~~~~~~~
   drivers/ata/pata_macio.c: In function 'pata_macio_invariants':
>> drivers/ata/pata_macio.c:975:16: error: incompatible types when assigning to type 'const int *' from type 'bool' {aka '_Bool'}
     975 |         bidp = of_property_present(priv->node, "AAPL,bus-id");
         |                ^~~~~~~~~~~~~~~~~~~


vim +482 drivers/ata/pata_macio.c

   472	
   473	static int pata_macio_cable_detect(struct ata_port *ap)
   474	{
   475		struct pata_macio_priv *priv = ap->private_data;
   476	
   477		/* Get cable type from device-tree */
   478		if (priv->kind == controller_kl_ata4 ||
   479		    priv->kind == controller_un_ata6 ||
   480		    priv->kind == controller_k2_ata6 ||
   481		    priv->kind == controller_sh_ata6) {
 > 482			const char *cable = of_property_present(priv->node, "cable-type");
   483			struct device_node *root = of_find_node_by_path("/");
   484			const char *model = of_property_present(root, "model");
   485	
   486			of_node_put(root);
   487	
   488			if (cable && !strncmp(cable, "80-", 3)) {
   489				/* Some drives fail to detect 80c cable in PowerBook
   490				 * These machine use proprietary short IDE cable
   491				 * anyway
   492				 */
   493				if (!strncmp(model, "PowerBook", 9))
   494					return ATA_CBL_PATA40_SHORT;
   495				else
   496					return ATA_CBL_PATA80;
   497			}
   498		}
   499	
   500		/* G5's seem to have incorrect cable type in device-tree.
   501		 * Let's assume they always have a 80 conductor cable, this seem to
   502		 * be always the case unless the user mucked around
   503		 */
   504		if (of_device_is_compatible(priv->node, "K2-UATA") ||
   505		    of_device_is_compatible(priv->node, "shasta-ata"))
   506			return ATA_CBL_PATA80;
   507	
   508		/* Anything else is 40 connectors */
   509		return ATA_CBL_PATA40;
   510	}
   511	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
