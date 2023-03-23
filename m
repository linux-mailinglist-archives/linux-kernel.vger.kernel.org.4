Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91796C6A19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjCWNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:55:25 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE7C17E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:55:15 -0700 (PDT)
Date:   Thu, 23 Mar 2023 21:55:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679579713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29bski4AH18YLW45CQQaNIU5QK0dwmKXOt5GeB2ShiQ=;
        b=JdTONWS7F4QEHGdNXcYtxY95SDs7LQaMkUxgpCMDhT1nepsWZ2Qr1mOPRD2Xe5Su8NzNpZ
        BB+CiypluDEuqkXod4Efgt1fM/saIMdQD3Qw+ueZ7WEWnWOHSkq3Pyabogpi9ojucIB3SP
        0O3Ap/Xt5c9VxpwFLLBUplHQwqQVCXY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ntb: epf: Remove redundant pci_clear_master
Message-ID: <ZBxaPcKZNo1CmnVa@chq-MS-7D45>
References: <20230323115336.12986-2-cai.huoqing@linux.dev>
 <202303232151.ldN29HC6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202303232151.ldN29HC6-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 3月 23 21:15:02, kernel test robot wrote:
> Hi Cai,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on jonmason-ntb/ntb-next]
> [also build test ERROR on linus/master v6.3-rc3 next-20230323]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/ntb-epf-Remove-redundant-pci_clear_master/20230323-195616
> base:   https://github.com/jonmason/ntb ntb-next
> patch link:    https://lore.kernel.org/r/20230323115336.12986-2-cai.huoqing%40linux.dev
> patch subject: [PATCH 2/3] ntb: epf: Remove redundant pci_clear_master
> config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230323/202303232151.ldN29HC6-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/aa42a659eb567a583441b91cb47fd1727fa714df
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Cai-Huoqing/ntb-epf-Remove-redundant-pci_clear_master/20230323-195616
>         git checkout aa42a659eb567a583441b91cb47fd1727fa714df
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/ntb/hw/epf/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303232151.ldN29HC6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/ntb/hw/epf/ntb_hw_epf.c: In function 'ntb_epf_init_pci':
> >> drivers/ntb/hw/epf/ntb_hw_epf.c:609:25: error: label 'err_dma_mask' used but not defined
>      609 |                         goto err_dma_mask;
>          |                         ^~~~

Will fix it and resend v2.

> 
> 
> vim +/err_dma_mask +609 drivers/ntb/hw/epf/ntb_hw_epf.c
> 
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  565  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  566  static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  567  			    struct pci_dev *pdev)
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  568  {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  569  	struct device *dev = ndev->dev;
> e75d5ae8ab88b7 Frank Li               2022-02-22  570  	size_t spad_sz, spad_off;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  571  	int ret;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  572  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  573  	pci_set_drvdata(pdev, ndev);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  574  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  575  	ret = pci_enable_device(pdev);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  576  	if (ret) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  577  		dev_err(dev, "Cannot enable PCI device\n");
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  578  		goto err_pci_enable;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  579  	}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  580  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  581  	ret = pci_request_regions(pdev, "ntb");
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  582  	if (ret) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  583  		dev_err(dev, "Cannot obtain PCI resources\n");
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  584  		goto err_pci_regions;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  585  	}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  586  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  587  	pci_set_master(pdev);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  588  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  589  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  590  	if (ret) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  591  		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  592  		if (ret) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  593  			dev_err(dev, "Cannot set DMA mask\n");
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  594  			goto err_dma_mask;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  595  		}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  596  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  597  	}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  598  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  599  	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  600  	if (!ndev->ctrl_reg) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  601  		ret = -EIO;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  602  		goto err_dma_mask;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  603  	}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  604  
> e75d5ae8ab88b7 Frank Li               2022-02-22  605  	if (ndev->peer_spad_reg_bar) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  606  		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  607  		if (!ndev->peer_spad_reg) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  608  			ret = -EIO;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02 @609  			goto err_dma_mask;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  610  		}
> e75d5ae8ab88b7 Frank Li               2022-02-22  611  	} else {
> e75d5ae8ab88b7 Frank Li               2022-02-22  612  		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> e75d5ae8ab88b7 Frank Li               2022-02-22  613  		spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> e75d5ae8ab88b7 Frank Li               2022-02-22  614  		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
> e75d5ae8ab88b7 Frank Li               2022-02-22  615  	}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  616  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  617  	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  618  	if (!ndev->db_reg) {
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  619  		ret = -EIO;
> aa42a659eb567a Cai Huoqing            2023-03-23  620  		goto err_pci_regions;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  621  	}
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  622  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  623  	return 0;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  624  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  625  err_pci_regions:
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  626  	pci_disable_device(pdev);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  627  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  628  err_pci_enable:
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  629  	pci_set_drvdata(pdev, NULL);
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  630  
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  631  	return ret;
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  632  }
> 812ce2f8d14ea7 Kishon Vijay Abraham I 2021-02-02  633  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
