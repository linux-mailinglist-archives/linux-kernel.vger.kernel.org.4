Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97C6C9092
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCYTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCYTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:49:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149B2101;
        Sat, 25 Mar 2023 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679773759; x=1711309759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/55eFo1NR1xT1wYp3Cp0xIc5nr1VWKvWhVajJLz/C+s=;
  b=MeCW5674rMYgwwVwiwsgyakrM3qZMYiy0qUHi+BB9TBkBNFQgZG2fYpi
   Y4OV3beu89GO7/7L3m8u9YXYQ19DHJPFRLA5mNsltlkSbvoEKKbgGIc00
   ytwYyE6qzDdjzNsEHMWGsLp/GXfFYJOwrC/xDqSODld0qJ1ZioKZd1hiC
   uolyg9qlrhQ66KpVCYFNF3c2sjqxI7MjtD3zzvkziUFnnqx+PQImtgtkN
   HNrzuaQ8iRbRNV3KRCwpy/cvfarQCB4fss84mlT0Q3HfNp8cFa1b6Jiig
   efXqbZHKLpT78lJRh3eLSumYXk8XxFDnKVbwfLAHJMdbsoYEho3+MDrw/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="402606821"
X-IronPort-AV: E=Sophos;i="5.98,291,1673942400"; 
   d="scan'208";a="402606821"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 12:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="807039644"
X-IronPort-AV: E=Sophos;i="5.98,291,1673942400"; 
   d="scan'208";a="807039644"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2023 12:49:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg9t5-000GdD-3B;
        Sat, 25 Mar 2023 19:49:15 +0000
Date:   Sun, 26 Mar 2023 03:49:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     ye.xingchen@zte.com.cn, andersson@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc/davinci: Use dev_err_probe()
Message-ID: <202303260319.W0GPLfaj-lkp@intel.com>
References: <202303231600496082749@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303231600496082749@zte.com.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/remoteproc-davinci-Use-dev_err_probe/20230323-160242
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/202303231600496082749%40zte.com.cn
patch subject: [PATCH] remoteproc/davinci: Use dev_err_probe()
config: arm-davinci_all_defconfig (https://download.01.org/0day-ci/archive/20230326/202303260319.W0GPLfaj-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/a0080d71b9ef7a6f3996093945ea5578f8e43ce1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ye-xingchen-zte-com-cn/remoteproc-davinci-Use-dev_err_probe/20230323-160242
        git checkout a0080d71b9ef7a6f3996093945ea5578f8e43ce1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303260319.W0GPLfaj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/da8xx_remoteproc.c:283:42: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
                                        "unable to get reset control: %ld\n");
                                                                      ~~^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
   Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
   Selected by [y]:
   - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y] && CPU_LITTLE_ENDIAN [=y]


vim +283 drivers/remoteproc/da8xx_remoteproc.c

   235	
   236	static int da8xx_rproc_probe(struct platform_device *pdev)
   237	{
   238		struct device *dev = &pdev->dev;
   239		struct da8xx_rproc *drproc;
   240		struct rproc *rproc;
   241		struct irq_data *irq_data;
   242		struct resource *bootreg_res;
   243		struct resource *chipsig_res;
   244		struct clk *dsp_clk;
   245		struct reset_control *dsp_reset;
   246		void __iomem *chipsig;
   247		void __iomem *bootreg;
   248		int irq;
   249		int ret;
   250	
   251		irq = platform_get_irq(pdev, 0);
   252		if (irq < 0)
   253			return irq;
   254	
   255		irq_data = irq_get_irq_data(irq);
   256		if (!irq_data) {
   257			dev_err(dev, "irq_get_irq_data(%d): NULL\n", irq);
   258			return -EINVAL;
   259		}
   260	
   261		bootreg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
   262							   "host1cfg");
   263		bootreg = devm_ioremap_resource(dev, bootreg_res);
   264		if (IS_ERR(bootreg))
   265			return PTR_ERR(bootreg);
   266	
   267		chipsig_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
   268							   "chipsig");
   269		chipsig = devm_ioremap_resource(dev, chipsig_res);
   270		if (IS_ERR(chipsig))
   271			return PTR_ERR(chipsig);
   272	
   273		dsp_clk = devm_clk_get(dev, NULL);
   274		if (IS_ERR(dsp_clk)) {
   275			dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
   276	
   277			return PTR_ERR(dsp_clk);
   278		}
   279	
   280		dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
   281		if (IS_ERR(dsp_reset))
   282			return dev_err_probe(dev, PTR_ERR(dsp_reset),
 > 283					     "unable to get reset control: %ld\n");
   284	
   285		if (dev->of_node) {
   286			ret = of_reserved_mem_device_init(dev);
   287			if (ret) {
   288				dev_err(dev, "device does not have specific CMA pool: %d\n",
   289					ret);
   290				return ret;
   291			}
   292		}
   293	
   294		rproc = rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
   295			sizeof(*drproc));
   296		if (!rproc) {
   297			ret = -ENOMEM;
   298			goto free_mem;
   299		}
   300	
   301		/* error recovery is not supported at present */
   302		rproc->recovery_disabled = true;
   303	
   304		drproc = rproc->priv;
   305		drproc->rproc = rproc;
   306		drproc->dsp_clk = dsp_clk;
   307		drproc->dsp_reset = dsp_reset;
   308		rproc->has_iommu = false;
   309	
   310		ret = da8xx_rproc_get_internal_memories(pdev, drproc);
   311		if (ret)
   312			goto free_rproc;
   313	
   314		platform_set_drvdata(pdev, rproc);
   315	
   316		/* everything the ISR needs is now setup, so hook it up */
   317		ret = devm_request_threaded_irq(dev, irq, da8xx_rproc_callback,
   318						handle_event, 0, "da8xx-remoteproc",
   319						rproc);
   320		if (ret) {
   321			dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
   322			goto free_rproc;
   323		}
   324	
   325		/*
   326		 * rproc_add() can end up enabling the DSP's clk with the DSP
   327		 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
   328		 * held in reset at the time it is called.
   329		 */
   330		ret = reset_control_assert(dsp_reset);
   331		if (ret)
   332			goto free_rproc;
   333	
   334		drproc->chipsig = chipsig;
   335		drproc->bootreg = bootreg;
   336		drproc->ack_fxn = irq_data->chip->irq_ack;
   337		drproc->irq_data = irq_data;
   338		drproc->irq = irq;
   339	
   340		ret = rproc_add(rproc);
   341		if (ret) {
   342			dev_err(dev, "rproc_add failed: %d\n", ret);
   343			goto free_rproc;
   344		}
   345	
   346		return 0;
   347	
   348	free_rproc:
   349		rproc_free(rproc);
   350	free_mem:
   351		if (dev->of_node)
   352			of_reserved_mem_device_release(dev);
   353		return ret;
   354	}
   355	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
