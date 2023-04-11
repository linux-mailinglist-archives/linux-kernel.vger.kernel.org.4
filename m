Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E846DE288
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDKRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDKRcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:32:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EB5BB5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681234350; x=1712770350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYu2VOdyLChmKOsBaksULDPYyAcnFIA61rGyIqo32/E=;
  b=VyDkC8je7Qo1Y0tPWZX0tdBRjaf2fkyFmrPFaoHvbalECYHfmwpN2POZ
   2OSVTdk8nh4DD7D5cQdWyqnIPLylFpKDMx3l501/7Sorik2g3IY1YLr2A
   tEqSz2bruk3RSA86TC3WIv1wAA+RMg7G3dxgbPlHxB/yEAELJk329QS+m
   4tabZFJoy9nr/LBd0sCVhUyvOTcjBJ2o5WSWI/tEsCjHE+G1GVRmrbdDx
   D8jYtZn3DyuH7EKHHJKghLOVMRGh7+afdMVvbQ03JRLrwys7Gbpw1E6B/
   my61ywAJyaNoJ7eqRk9BWK07vsT6F13q99m9vvON7y90znHFPvmrGGYHZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343692747"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343692747"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="832409212"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="832409212"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2023 10:32:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmHqu-000WXz-1f;
        Tue, 11 Apr 2023 17:32:20 +0000
Date:   Wed, 12 Apr 2023 01:31:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        sahil.malhotra@nxp.com, aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     oe-kbuild-all@lists.linux.dev, Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: Re: [NXP ELE-MUAP 6/7] firmware: imx: add ELE MU driver support
Message-ID: <202304120141.95PmXzH6-lkp@intel.com>
References: <20230411162536.30604-7-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411162536.30604-7-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on robh/for-next arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next soc/for-next linus/master v6.3-rc6 next-20230411]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Gupta/doc-device-tree-binding-addition-for-ele-MU/20230411-231913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230411162536.30604-7-pankaj.gupta%40nxp.com
patch subject: [NXP ELE-MUAP 6/7] firmware: imx: add ELE MU driver support
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230412/202304120141.95PmXzH6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/80f6b85e97e7f7eb4b5d59c638adb2bdbe6d48d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Gupta/doc-device-tree-binding-addition-for-ele-MU/20230411-231913
        git checkout 80f6b85e97e7f7eb4b5d59c638adb2bdbe6d48d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/firmware/imx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120141.95PmXzH6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/imx/ele_mu.c: In function 'ele_mu_fops_read':
>> drivers/firmware/imx/ele_mu.c:408:23: warning: variable 'header' set but not used [-Wunused-but-set-variable]
     408 |         struct mu_hdr header;
         |                       ^~~~~~
   drivers/firmware/imx/ele_mu.c:404:29: warning: unused variable 'ele_mu_priv' [-Wunused-variable]
     404 |         struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
         |                             ^~~~~~~~~~~


vim +/header +408 drivers/firmware/imx/ele_mu.c

   392	
   393	/*
   394	 * Read a message from the MU.
   395	 * Blocking until a message is available.
   396	 */
   397	static ssize_t ele_mu_fops_read(struct file *fp, char __user *buf,
   398					 size_t size, loff_t *ppos)
   399	{
   400		struct ele_mu_device_ctx *dev_ctx
   401			= container_of(fp->private_data,
   402				       struct ele_mu_device_ctx,
   403				       miscdev);
   404		struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
   405		u32 data_size = 0, size_to_copy = 0;
   406		struct ele_obuf_desc *b_desc;
   407		int err;
 > 408		struct mu_hdr header;
   409	
   410		devctx_dbg(dev_ctx, "read to buf %p(%ld), ppos=%lld\n", buf, size,
   411			   ((ppos) ? *ppos : 0));
   412	
   413		if (down_interruptible(&dev_ctx->fops_lock))
   414			return -EBUSY;
   415	
   416		if (dev_ctx->status != MU_OPENED) {
   417			err = -EINVAL;
   418			goto exit;
   419		}
   420	
   421		/* Wait until the complete message is received on the MU. */
   422		err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
   423		if (err) {
   424			devctx_err(dev_ctx, "Err[0x%x]:Interrupted by signal.\n", err);
   425			goto exit;
   426		}
   427	
   428		devctx_dbg(dev_ctx, "%s %s\n", __func__,
   429			   "message received, start transmit to user");
   430	
   431		/* Check that the size passed as argument is larger than
   432		 * the one carried in the message.
   433		 */
   434		data_size = dev_ctx->temp_resp_size * sizeof(u32);
   435		size_to_copy = data_size;
   436		if (size_to_copy > size) {
   437			devctx_dbg(dev_ctx, "User buffer too small (%ld < %d)\n",
   438				   size, size_to_copy);
   439			size_to_copy = size;
   440		}
   441	
   442		/* We may need to copy the output data to user before
   443		 * delivering the completion message.
   444		 */
   445		while (!list_empty(&dev_ctx->pending_out)) {
   446			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
   447							  struct ele_obuf_desc,
   448							  link);
   449			if (b_desc->out_usr_ptr && b_desc->out_ptr) {
   450				devctx_dbg(dev_ctx, "Copy output data to user\n");
   451				err = (int)copy_to_user(b_desc->out_usr_ptr,
   452							b_desc->out_ptr,
   453							b_desc->out_size);
   454				if (err) {
   455					devctx_err(dev_ctx,
   456						   "Failure copying output data to user.");
   457					err = -EFAULT;
   458					goto exit;
   459				}
   460			}
   461			__list_del_entry(&b_desc->link);
   462			devm_kfree(dev_ctx->dev, b_desc);
   463		}
   464	
   465		header = *((struct mu_hdr *) (&dev_ctx->temp_resp[0]));
   466	
   467		/* Copy data from the buffer */
   468		print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
   469				     dev_ctx->temp_resp, size_to_copy, false);
   470		err = (int)copy_to_user(buf, dev_ctx->temp_resp, size_to_copy);
   471		if (err) {
   472			devctx_err(dev_ctx, "Failed to copy to user\n");
   473			err = -EFAULT;
   474			goto exit;
   475		}
   476	
   477		err = size_to_copy;
   478	
   479		/* free memory allocated on the shared buffers. */
   480		dev_ctx->secure_mem.pos = 0;
   481		dev_ctx->non_secure_mem.pos = 0;
   482	
   483		dev_ctx->pending_hdr = 0;
   484	
   485	exit:
   486	
   487		up(&dev_ctx->fops_lock);
   488		return err;
   489	}
   490	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
