Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C92724885
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbjFFQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbjFFQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:07:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C7119
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686067655; x=1717603655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJ2V10bIpMP9rSfInUH+3MYBVcnBoqDyA2KN9iBUC3c=;
  b=NX7y3gQQVgNdSxK1A0v7CTw6ek7HruoQFxMXIcyWZUkuaUxpAa2+HFJp
   N91eMpkK9xjNMIQUBsxK2h1wOody6iLvtB1xj7Cni2RwIDsaVaCbAzYVf
   JLezuzezv/zSWGsZUXLkD35CqVo6u6YKrIX0AJWbpFqoT5HfVG6eaBlq1
   7KxCCrvNaTGml+ASugQ4rDxyGl/S2/I7AVy7lFtF6S0ivfRj3Um4u6SaZ
   WpmhdIfimeTA00HP3l30nXrPd6ci2bslfpkVIl0H1OdO3FBz2Db/kcUp+
   xfIRQIBBWinhTW5P7Udnth6Fyw5P1Okv7s+xVpyZSQl/qeZpKDip65beC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341372630"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="341372630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 09:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853504796"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853504796"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2023 09:06:52 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6ZCu-0005St-08;
        Tue, 06 Jun 2023 16:06:52 +0000
Date:   Wed, 7 Jun 2023 00:06:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neel Chakraborty <neelchakrabortykernelwork@gmail.com>,
        abbotti@mev.co.uk
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Subject: Re: [PATCH] drivers: comedi: drivers: s526: fixed a commented out if
 else coding style issue
Message-ID: <202306062334.IyXxcuto-lkp@intel.com>
References: <20230605131306.427682-1-neelchakrabortykernelwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605131306.427682-1-neelchakrabortykernelwork@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc5 next-20230606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neel-Chakraborty/drivers-comedi-drivers-s526-fixed-a-commented-out-if-else-coding-style-issue/20230605-211421
base:   linus/master
patch link:    https://lore.kernel.org/r/20230605131306.427682-1-neelchakrabortykernelwork%40gmail.com
patch subject: [PATCH] drivers: comedi: drivers: s526: fixed a commented out if else coding style issue
config: arm-randconfig-r031-20230606 (https://download.01.org/0day-ci/archive/20230606/202306062334.IyXxcuto-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git checkout linus/master
        b4 shazam https://lore.kernel.org/r/20230605131306.427682-1-neelchakrabortykernelwork@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/comedi/drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306062334.IyXxcuto-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/comedi/drivers/s526.c:251:18: error: use of undeclared identifier 'GPCT_X2'
                   if (data[1] == GPCT_X2)
                                  ^
>> drivers/comedi/drivers/s526.c:251:18: error: use of undeclared identifier 'GPCT_X2'
>> drivers/comedi/drivers/s526.c:251:18: error: use of undeclared identifier 'GPCT_X2'
>> drivers/comedi/drivers/s526.c:253:23: error: use of undeclared identifier 'GPCT_X4'
                   else if (data[1] == GPCT_X4)
                                       ^
>> drivers/comedi/drivers/s526.c:253:23: error: use of undeclared identifier 'GPCT_X4'
>> drivers/comedi/drivers/s526.c:253:23: error: use of undeclared identifier 'GPCT_X4'
>> drivers/comedi/drivers/s526.c:267:18: error: use of undeclared identifier 'GPCT_RESET_COUNTER_ON_INDEX'
                   if (data[3] == GPCT_RESET_COUNTER_ON_INDEX) {
                                  ^
>> drivers/comedi/drivers/s526.c:267:18: error: use of undeclared identifier 'GPCT_RESET_COUNTER_ON_INDEX'
>> drivers/comedi/drivers/s526.c:267:18: error: use of undeclared identifier 'GPCT_RESET_COUNTER_ON_INDEX'
>> drivers/comedi/drivers/s526.c:291:9: error: use of undeclared identifier 'S526_GPCT_CTRL_CT_LOAD'
                           outw(S526_GPCT_CTRL_CT_LOAD,
                                ^
   drivers/comedi/drivers/s526.c:294:2: error: #endif without #if
   #endif
    ^
   11 errors generated.


vim +/GPCT_X2 +251 drivers/comedi/drivers/s526.c

0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  208  
0a85b6f0ab0d2e drivers/staging/comedi/drivers/s526.c Mithlesh Thukral  2009-06-08  209  static int s526_gpct_insn_config(struct comedi_device *dev,
0a85b6f0ab0d2e drivers/staging/comedi/drivers/s526.c Mithlesh Thukral  2009-06-08  210  				 struct comedi_subdevice *s,
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  211  				 struct comedi_insn *insn,
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  212  				 unsigned int *data)
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  213  {
5f2210627f8d3c drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  214  	struct s526_private *devpriv = dev->private;
43a352760e6c1c drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  215  	unsigned int chan = CR_CHAN(insn->chanspec);
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  216  	unsigned int val;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  217  
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  218  	/*
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  219  	 * Check what type of Counter the user requested
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  220  	 * data[0] contains the Application type
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  221  	 */
b2abd982c484ba drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  222  	switch (data[0]) {
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  223  	case INSN_CONFIG_GPCT_QUADRATURE_ENCODER:
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  224  		/*
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  225  		 * data[0]: Application Type
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  226  		 * data[1]: Counter Mode Register Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  227  		 * data[2]: Pre-load Register Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  228  		 * data[3]: Conter Control Register
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  229  		 */
675f98f101fb6d drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  230  		devpriv->gpct_config[chan] = data[0];
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  231  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  232  		/*  Set Counter Mode Register */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  233  		val = data[1] & 0xffff;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  234  		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  235  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  236  		/*  Reset the counter if it is software preload */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  237  		if ((val & S526_GPCT_MODE_AUTOLOAD_MASK) ==
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  238  		    S526_GPCT_MODE_AUTOLOAD_NONE) {
c9c62f4e2c9b52 drivers/staging/comedi/drivers/s526.c Xenofon Foukas    2010-12-15  239  			/*  Reset the counter */
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  240  			outw(S526_GPCT_CTRL_CT_RESET,
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  241  			     dev->iobase + S526_GPCT_CTRL_REG(chan));
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  242  			/*
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  243  			 * Load the counter from PR0
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  244  			 * outw(S526_GPCT_CTRL_CT_LOAD,
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  245  			 *      dev->iobase + S526_GPCT_CTRL_REG(chan));
c9c62f4e2c9b52 drivers/staging/comedi/drivers/s526.c Xenofon Foukas    2010-12-15  246  			 */
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  247  		}
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  248  		val = S526_GPCT_MODE_CTDIR_CTRL_QUAD;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  249  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  250  		/*  data[1] contains GPCT_X1, GPCT_X2 or GPCT_X4 */
b2abd982c484ba drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19 @251  		if (data[1] == GPCT_X2)
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  252  			val |= S526_GPCT_MODE_CLK_SRC_QUADX2;
b2abd982c484ba drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19 @253  		else if (data[1] == GPCT_X4)
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  254  			val |= S526_GPCT_MODE_CLK_SRC_QUADX4;
c9c62f4e2c9b52 drivers/staging/comedi/drivers/s526.c Xenofon Foukas    2010-12-15  255  		else
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  256  			val |= S526_GPCT_MODE_CLK_SRC_QUADX1;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  257  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  258  		/*  When to take into account the indexpulse: */
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  259  		/*
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  260  		 * if (data[2] == GPCT_IndexPhaseLowLow) {
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  261  		 * } else if (data[2] == GPCT_IndexPhaseLowHigh) {
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  262  		 * } else if (data[2] == GPCT_IndexPhaseHighLow) {
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  263  		 * } else if (data[2] == GPCT_IndexPhaseHighHigh) {
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  264  		 * }
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  265  		 */
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  266  		/*  Take into account the index pulse? */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19 @267  		if (data[3] == GPCT_RESET_COUNTER_ON_INDEX) {
c9c62f4e2c9b52 drivers/staging/comedi/drivers/s526.c Xenofon Foukas    2010-12-15  268  			/*  Auto load with INDEX^ */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  269  			val |= S526_GPCT_MODE_AUTOLOAD_IXRISE;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  270  		}
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  271  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  272  		/*  Set Counter Mode Register */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  273  		val = data[1] & 0xffff;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  274  		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  275  
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  276  		/*  Load the pre-load register */
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  277  		s526_gpct_write(dev, chan, data[2]);
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  278  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  279  		/*  Write the Counter Control Register */
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  280  		if (data[3])
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  281  			outw(data[3] & 0xffff,
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  282  			     dev->iobase + S526_GPCT_CTRL_REG(chan));
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  283  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  284  		/*  Reset the counter if it is software preload */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  285  		if ((val & S526_GPCT_MODE_AUTOLOAD_MASK) ==
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  286  		    S526_GPCT_MODE_AUTOLOAD_NONE) {
c9c62f4e2c9b52 drivers/staging/comedi/drivers/s526.c Xenofon Foukas    2010-12-15  287  			/*  Reset the counter */
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  288  			outw(S526_GPCT_CTRL_CT_RESET,
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  289  			     dev->iobase + S526_GPCT_CTRL_REG(chan));
c9c62f4e2c9b52 drivers/staging/comedi/drivers/s526.c Xenofon Foukas    2010-12-15  290  			/*  Load the counter from PR0 */
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19 @291  			outw(S526_GPCT_CTRL_CT_LOAD,
e5417e49965a47 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  292  			     dev->iobase + S526_GPCT_CTRL_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  293  		}
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  294  #endif
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  295  		break;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  296  
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  297  	case INSN_CONFIG_GPCT_SINGLE_PULSE_GENERATOR:
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  298  		/*
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  299  		 * data[0]: Application Type
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  300  		 * data[1]: Counter Mode Register Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  301  		 * data[2]: Pre-load Register 0 Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  302  		 * data[3]: Pre-load Register 1 Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  303  		 * data[4]: Conter Control Register
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  304  		 */
675f98f101fb6d drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  305  		devpriv->gpct_config[chan] = data[0];
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  306  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  307  		/*  Set Counter Mode Register */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  308  		val = data[1] & 0xffff;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  309  		/* Select PR0 */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  310  		val &= ~S526_GPCT_MODE_PR_SELECT_MASK;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  311  		val |= S526_GPCT_MODE_PR_SELECT_PR0;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  312  		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  313  
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  314  		/* Load the pre-load register 0 */
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  315  		s526_gpct_write(dev, chan, data[2]);
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  316  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  317  		/*  Set Counter Mode Register */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  318  		val = data[1] & 0xffff;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  319  		/* Select PR1 */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  320  		val &= ~S526_GPCT_MODE_PR_SELECT_MASK;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  321  		val |= S526_GPCT_MODE_PR_SELECT_PR1;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  322  		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  323  
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  324  		/* Load the pre-load register 1 */
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  325  		s526_gpct_write(dev, chan, data[3]);
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  326  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  327  		/*  Write the Counter Control Register */
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  328  		if (data[4]) {
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  329  			val = data[4] & 0xffff;
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  330  			outw(val, dev->iobase + S526_GPCT_CTRL_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  331  		}
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  332  		break;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  333  
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  334  	case INSN_CONFIG_GPCT_PULSE_TRAIN_GENERATOR:
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  335  		/*
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  336  		 * data[0]: Application Type
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  337  		 * data[1]: Counter Mode Register Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  338  		 * data[2]: Pre-load Register 0 Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  339  		 * data[3]: Pre-load Register 1 Value
a399d81d41e174 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  340  		 * data[4]: Conter Control Register
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  341  		 */
675f98f101fb6d drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  342  		devpriv->gpct_config[chan] = data[0];
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  343  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  344  		/*  Set Counter Mode Register */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  345  		val = data[1] & 0xffff;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  346  		/* Select PR0 */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  347  		val &= ~S526_GPCT_MODE_PR_SELECT_MASK;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  348  		val |= S526_GPCT_MODE_PR_SELECT_PR0;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  349  		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  350  
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  351  		/* Load the pre-load register 0 */
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  352  		s526_gpct_write(dev, chan, data[2]);
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  353  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  354  		/*  Set Counter Mode Register */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  355  		val = data[1] & 0xffff;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  356  		/* Select PR1 */
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  357  		val &= ~S526_GPCT_MODE_PR_SELECT_MASK;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  358  		val |= S526_GPCT_MODE_PR_SELECT_PR1;
479bd5edab3ca8 drivers/staging/comedi/drivers/s526.c Ian Abbott        2015-11-19  359  		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  360  
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  361  		/* Load the pre-load register 1 */
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  362  		s526_gpct_write(dev, chan, data[3]);
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  363  
232f650253a04b drivers/staging/comedi/drivers/s526.c Bill Pemberton    2009-03-27  364  		/*  Write the Counter Control Register */
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  365  		if (data[4]) {
5a5614cb669f9f drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2012-09-19  366  			val = data[4] & 0xffff;
1d0d1c00daff96 drivers/staging/comedi/drivers/s526.c H Hartley Sweeten 2015-08-17  367  			outw(val, dev->iobase + S526_GPCT_CTRL_REG(chan));
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  368  		}
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  369  		break;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  370  
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  371  	default:
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  372  		return -EINVAL;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  373  	}
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  374  
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  375  	return insn->n;
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  376  }
0c988d008cedca drivers/staging/comedi/drivers/s526.c Everett Wang      2009-02-17  377  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
