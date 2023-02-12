Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70E693580
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBLBsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 20:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLBsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 20:48:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451ACA2A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 17:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676166514; x=1707702514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PhAygreb3oLikijwNv3wBlSTqlFo5y8e8Q/XwizXPtE=;
  b=N1NaV55UFz1LdTStqKh4MbMYkw0CDT5CHWQW3NQzXt3u63m0TT25iPKG
   pvHWPWXk8F3DdwkPBV7IIxCfcfGk0NnXXpA1bNujafqogR+r+QJrqOk68
   N5Sg1m8DRShRykCsdDrm7pLOCIIjjSlHi6jy560Kuwo6lrMBWcuAWmgcH
   fA72LODtFVNHCtRT3WtKKMSOdYvpPy21Y5u2ByzzCCUW/qduy/ekzJAFH
   evPnI8uSjV70342YsB/8yLIDPTxhY071Pnlm1A8EBsR3z2QQ4TPmbKbJT
   jsJAG2wBc+wE9yoYgfPO9q9RxQbDOvD6Bo72npE4swhGaui1O0zzM51a9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="330691522"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="330691522"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 17:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="618254234"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="618254234"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2023 17:48:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pR1Ti-0006vp-33;
        Sun, 12 Feb 2023 01:48:30 +0000
Date:   Sun, 12 Feb 2023 09:48:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse: sparse: incorrect
 type in return expression (different address spaces)
Message-ID: <202302120935.shmdDgY7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f339c2597ebb00e738f2b6328c14804ed19f5d57
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   10 months ago
config: arm-randconfig-s051-20230212 (https://download.01.org/0day-ci/archive/20230212/202302120935.shmdDgY7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/ti/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302120935.shmdDgY7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/soc/ti/knav_qmss_queue.c:70:12: sparse: sparse: symbol 'knav_acc_firmwares' was not declared. Should it be static?
>> drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse:     expected void [noderef] __iomem *
   drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse:     got void *
>> drivers/soc/ti/knav_qmss_queue.c:1553:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *[noderef] __iomem addr @@     got unsigned int [noderef] __iomem * @@
   drivers/soc/ti/knav_qmss_queue.c:1553:41: sparse:     expected unsigned int [usertype] *[noderef] __iomem addr
   drivers/soc/ti/knav_qmss_queue.c:1553:41: sparse:     got unsigned int [noderef] __iomem *
>> drivers/soc/ti/knav_qmss_queue.c:1597:17: sparse: sparse: cast to restricted __be32
>> drivers/soc/ti/knav_qmss_queue.c:1624:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *[noderef] __iomem addr @@     got void [noderef] __iomem *command @@
   drivers/soc/ti/knav_qmss_queue.c:1624:40: sparse:     expected unsigned int [usertype] *[noderef] __iomem addr
   drivers/soc/ti/knav_qmss_queue.c:1624:40: sparse:     got void [noderef] __iomem *command
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *[noderef] __iomem addr @@
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     got unsigned int [usertype] *[noderef] __iomem addr
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *[noderef] __iomem addr @@
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     got unsigned int [usertype] *[noderef] __iomem addr
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression

vim +1381 drivers/soc/ti/knav_qmss_queue.c

41f93af900a20d Sandeep Nair     2014-02-28  1369  
41f93af900a20d Sandeep Nair     2014-02-28  1370  static void __iomem *knav_queue_map_reg(struct knav_device *kdev,
41f93af900a20d Sandeep Nair     2014-02-28  1371  					struct device_node *node, int index)
41f93af900a20d Sandeep Nair     2014-02-28  1372  {
41f93af900a20d Sandeep Nair     2014-02-28  1373  	struct resource res;
41f93af900a20d Sandeep Nair     2014-02-28  1374  	void __iomem *regs;
41f93af900a20d Sandeep Nair     2014-02-28  1375  	int ret;
41f93af900a20d Sandeep Nair     2014-02-28  1376  
41f93af900a20d Sandeep Nair     2014-02-28  1377  	ret = of_address_to_resource(node, index, &res);
41f93af900a20d Sandeep Nair     2014-02-28  1378  	if (ret) {
dc37a25252717a Rob Herring      2018-08-27  1379  		dev_err(kdev->dev, "Can't translate of node(%pOFn) address for index(%d)\n",
dc37a25252717a Rob Herring      2018-08-27  1380  			node, index);
41f93af900a20d Sandeep Nair     2014-02-28 @1381  		return ERR_PTR(ret);
41f93af900a20d Sandeep Nair     2014-02-28  1382  	}
41f93af900a20d Sandeep Nair     2014-02-28  1383  
41f93af900a20d Sandeep Nair     2014-02-28  1384  	regs = devm_ioremap_resource(kdev->dev, &res);
41f93af900a20d Sandeep Nair     2014-02-28  1385  	if (IS_ERR(regs))
dc37a25252717a Rob Herring      2018-08-27  1386  		dev_err(kdev->dev, "Failed to map register base for index(%d) node(%pOFn)\n",
dc37a25252717a Rob Herring      2018-08-27  1387  			index, node);
41f93af900a20d Sandeep Nair     2014-02-28  1388  	return regs;
41f93af900a20d Sandeep Nair     2014-02-28  1389  }
41f93af900a20d Sandeep Nair     2014-02-28  1390  
41f93af900a20d Sandeep Nair     2014-02-28  1391  static int knav_queue_init_qmgrs(struct knav_device *kdev,
41f93af900a20d Sandeep Nair     2014-02-28  1392  					struct device_node *qmgrs)
41f93af900a20d Sandeep Nair     2014-02-28  1393  {
41f93af900a20d Sandeep Nair     2014-02-28  1394  	struct device *dev = kdev->dev;
41f93af900a20d Sandeep Nair     2014-02-28  1395  	struct knav_qmgr_info *qmgr;
41f93af900a20d Sandeep Nair     2014-02-28  1396  	struct device_node *child;
41f93af900a20d Sandeep Nair     2014-02-28  1397  	u32 temp[2];
41f93af900a20d Sandeep Nair     2014-02-28  1398  	int ret;
41f93af900a20d Sandeep Nair     2014-02-28  1399  
41f93af900a20d Sandeep Nair     2014-02-28  1400  	for_each_child_of_node(qmgrs, child) {
41f93af900a20d Sandeep Nair     2014-02-28  1401  		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
41f93af900a20d Sandeep Nair     2014-02-28  1402  		if (!qmgr) {
a88f66d4a8668e Vasyl Gomonovych 2021-01-24  1403  			of_node_put(child);
41f93af900a20d Sandeep Nair     2014-02-28  1404  			dev_err(dev, "out of memory allocating qmgr\n");
41f93af900a20d Sandeep Nair     2014-02-28  1405  			return -ENOMEM;
41f93af900a20d Sandeep Nair     2014-02-28  1406  		}
41f93af900a20d Sandeep Nair     2014-02-28  1407  
41f93af900a20d Sandeep Nair     2014-02-28  1408  		ret = of_property_read_u32_array(child, "managed-queues",
41f93af900a20d Sandeep Nair     2014-02-28  1409  						 temp, 2);
41f93af900a20d Sandeep Nair     2014-02-28  1410  		if (!ret) {
41f93af900a20d Sandeep Nair     2014-02-28  1411  			qmgr->start_queue = temp[0];
41f93af900a20d Sandeep Nair     2014-02-28  1412  			qmgr->num_queues = temp[1];
41f93af900a20d Sandeep Nair     2014-02-28  1413  		} else {
41f93af900a20d Sandeep Nair     2014-02-28  1414  			dev_err(dev, "invalid qmgr queue range\n");
41f93af900a20d Sandeep Nair     2014-02-28  1415  			devm_kfree(dev, qmgr);
41f93af900a20d Sandeep Nair     2014-02-28  1416  			continue;
41f93af900a20d Sandeep Nair     2014-02-28  1417  		}
41f93af900a20d Sandeep Nair     2014-02-28  1418  
41f93af900a20d Sandeep Nair     2014-02-28  1419  		dev_info(dev, "qmgr start queue %d, number of queues %d\n",
41f93af900a20d Sandeep Nair     2014-02-28  1420  			 qmgr->start_queue, qmgr->num_queues);
41f93af900a20d Sandeep Nair     2014-02-28  1421  
41f93af900a20d Sandeep Nair     2014-02-28  1422  		qmgr->reg_peek =
41f93af900a20d Sandeep Nair     2014-02-28  1423  			knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1424  					   KNAV_QUEUE_PEEK_REG_INDEX);
350601b4f7ab45 Murali Karicheri 2018-04-17  1425  
350601b4f7ab45 Murali Karicheri 2018-04-17  1426  		if (kdev->version == QMSS) {
41f93af900a20d Sandeep Nair     2014-02-28  1427  			qmgr->reg_status =
41f93af900a20d Sandeep Nair     2014-02-28  1428  				knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1429  						   KNAV_QUEUE_STATUS_REG_INDEX);
350601b4f7ab45 Murali Karicheri 2018-04-17  1430  		}
350601b4f7ab45 Murali Karicheri 2018-04-17  1431  
41f93af900a20d Sandeep Nair     2014-02-28  1432  		qmgr->reg_config =
41f93af900a20d Sandeep Nair     2014-02-28  1433  			knav_queue_map_reg(kdev, child,
350601b4f7ab45 Murali Karicheri 2018-04-17  1434  					   (kdev->version == QMSS_66AK2G) ?
350601b4f7ab45 Murali Karicheri 2018-04-17  1435  					   KNAV_L_QUEUE_CONFIG_REG_INDEX :
41f93af900a20d Sandeep Nair     2014-02-28  1436  					   KNAV_QUEUE_CONFIG_REG_INDEX);
41f93af900a20d Sandeep Nair     2014-02-28  1437  		qmgr->reg_region =
41f93af900a20d Sandeep Nair     2014-02-28  1438  			knav_queue_map_reg(kdev, child,
350601b4f7ab45 Murali Karicheri 2018-04-17  1439  					   (kdev->version == QMSS_66AK2G) ?
350601b4f7ab45 Murali Karicheri 2018-04-17  1440  					   KNAV_L_QUEUE_REGION_REG_INDEX :
41f93af900a20d Sandeep Nair     2014-02-28  1441  					   KNAV_QUEUE_REGION_REG_INDEX);
350601b4f7ab45 Murali Karicheri 2018-04-17  1442  
41f93af900a20d Sandeep Nair     2014-02-28  1443  		qmgr->reg_push =
41f93af900a20d Sandeep Nair     2014-02-28  1444  			knav_queue_map_reg(kdev, child,
350601b4f7ab45 Murali Karicheri 2018-04-17  1445  					   (kdev->version == QMSS_66AK2G) ?
350601b4f7ab45 Murali Karicheri 2018-04-17  1446  					    KNAV_L_QUEUE_PUSH_REG_INDEX :
41f93af900a20d Sandeep Nair     2014-02-28  1447  					    KNAV_QUEUE_PUSH_REG_INDEX);
350601b4f7ab45 Murali Karicheri 2018-04-17  1448  
350601b4f7ab45 Murali Karicheri 2018-04-17  1449  		if (kdev->version == QMSS) {
41f93af900a20d Sandeep Nair     2014-02-28  1450  			qmgr->reg_pop =
41f93af900a20d Sandeep Nair     2014-02-28  1451  				knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1452  						   KNAV_QUEUE_POP_REG_INDEX);
350601b4f7ab45 Murali Karicheri 2018-04-17  1453  		}
41f93af900a20d Sandeep Nair     2014-02-28  1454  
350601b4f7ab45 Murali Karicheri 2018-04-17  1455  		if (IS_ERR(qmgr->reg_peek) ||
350601b4f7ab45 Murali Karicheri 2018-04-17  1456  		    ((kdev->version == QMSS) &&
350601b4f7ab45 Murali Karicheri 2018-04-17  1457  		    (IS_ERR(qmgr->reg_status) || IS_ERR(qmgr->reg_pop))) ||
41f93af900a20d Sandeep Nair     2014-02-28  1458  		    IS_ERR(qmgr->reg_config) || IS_ERR(qmgr->reg_region) ||
350601b4f7ab45 Murali Karicheri 2018-04-17  1459  		    IS_ERR(qmgr->reg_push)) {
41f93af900a20d Sandeep Nair     2014-02-28  1460  			dev_err(dev, "failed to map qmgr regs\n");
350601b4f7ab45 Murali Karicheri 2018-04-17  1461  			if (kdev->version == QMSS) {
41f93af900a20d Sandeep Nair     2014-02-28  1462  				if (!IS_ERR(qmgr->reg_status))
41f93af900a20d Sandeep Nair     2014-02-28  1463  					devm_iounmap(dev, qmgr->reg_status);
350601b4f7ab45 Murali Karicheri 2018-04-17  1464  				if (!IS_ERR(qmgr->reg_pop))
350601b4f7ab45 Murali Karicheri 2018-04-17  1465  					devm_iounmap(dev, qmgr->reg_pop);
350601b4f7ab45 Murali Karicheri 2018-04-17  1466  			}
350601b4f7ab45 Murali Karicheri 2018-04-17  1467  			if (!IS_ERR(qmgr->reg_peek))
350601b4f7ab45 Murali Karicheri 2018-04-17  1468  				devm_iounmap(dev, qmgr->reg_peek);
41f93af900a20d Sandeep Nair     2014-02-28  1469  			if (!IS_ERR(qmgr->reg_config))
41f93af900a20d Sandeep Nair     2014-02-28  1470  				devm_iounmap(dev, qmgr->reg_config);
41f93af900a20d Sandeep Nair     2014-02-28  1471  			if (!IS_ERR(qmgr->reg_region))
41f93af900a20d Sandeep Nair     2014-02-28  1472  				devm_iounmap(dev, qmgr->reg_region);
41f93af900a20d Sandeep Nair     2014-02-28  1473  			if (!IS_ERR(qmgr->reg_push))
41f93af900a20d Sandeep Nair     2014-02-28  1474  				devm_iounmap(dev, qmgr->reg_push);
41f93af900a20d Sandeep Nair     2014-02-28  1475  			devm_kfree(dev, qmgr);
41f93af900a20d Sandeep Nair     2014-02-28  1476  			continue;
41f93af900a20d Sandeep Nair     2014-02-28  1477  		}
41f93af900a20d Sandeep Nair     2014-02-28  1478  
350601b4f7ab45 Murali Karicheri 2018-04-17  1479  		/* Use same push register for pop as well */
350601b4f7ab45 Murali Karicheri 2018-04-17  1480  		if (kdev->version == QMSS_66AK2G)
350601b4f7ab45 Murali Karicheri 2018-04-17  1481  			qmgr->reg_pop = qmgr->reg_push;
350601b4f7ab45 Murali Karicheri 2018-04-17  1482  
41f93af900a20d Sandeep Nair     2014-02-28  1483  		list_add_tail(&qmgr->list, &kdev->qmgrs);
41f93af900a20d Sandeep Nair     2014-02-28  1484  		dev_info(dev, "added qmgr start queue %d, num of queues %d, reg_peek %p, reg_status %p, reg_config %p, reg_region %p, reg_push %p, reg_pop %p\n",
41f93af900a20d Sandeep Nair     2014-02-28  1485  			 qmgr->start_queue, qmgr->num_queues,
41f93af900a20d Sandeep Nair     2014-02-28  1486  			 qmgr->reg_peek, qmgr->reg_status,
41f93af900a20d Sandeep Nair     2014-02-28  1487  			 qmgr->reg_config, qmgr->reg_region,
41f93af900a20d Sandeep Nair     2014-02-28  1488  			 qmgr->reg_push, qmgr->reg_pop);
41f93af900a20d Sandeep Nair     2014-02-28  1489  	}
41f93af900a20d Sandeep Nair     2014-02-28  1490  	return 0;
41f93af900a20d Sandeep Nair     2014-02-28  1491  }
41f93af900a20d Sandeep Nair     2014-02-28  1492  
41f93af900a20d Sandeep Nair     2014-02-28  1493  static int knav_queue_init_pdsps(struct knav_device *kdev,
41f93af900a20d Sandeep Nair     2014-02-28  1494  					struct device_node *pdsps)
41f93af900a20d Sandeep Nair     2014-02-28  1495  {
41f93af900a20d Sandeep Nair     2014-02-28  1496  	struct device *dev = kdev->dev;
41f93af900a20d Sandeep Nair     2014-02-28  1497  	struct knav_pdsp_info *pdsp;
41f93af900a20d Sandeep Nair     2014-02-28  1498  	struct device_node *child;
41f93af900a20d Sandeep Nair     2014-02-28  1499  
41f93af900a20d Sandeep Nair     2014-02-28  1500  	for_each_child_of_node(pdsps, child) {
41f93af900a20d Sandeep Nair     2014-02-28  1501  		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
41f93af900a20d Sandeep Nair     2014-02-28  1502  		if (!pdsp) {
a88f66d4a8668e Vasyl Gomonovych 2021-01-24  1503  			of_node_put(child);
41f93af900a20d Sandeep Nair     2014-02-28  1504  			dev_err(dev, "out of memory allocating pdsp\n");
41f93af900a20d Sandeep Nair     2014-02-28  1505  			return -ENOMEM;
41f93af900a20d Sandeep Nair     2014-02-28  1506  		}
41f93af900a20d Sandeep Nair     2014-02-28  1507  		pdsp->name = knav_queue_find_name(child);
41f93af900a20d Sandeep Nair     2014-02-28  1508  		pdsp->iram =
41f93af900a20d Sandeep Nair     2014-02-28  1509  			knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1510  					   KNAV_QUEUE_PDSP_IRAM_REG_INDEX);
41f93af900a20d Sandeep Nair     2014-02-28  1511  		pdsp->regs =
41f93af900a20d Sandeep Nair     2014-02-28  1512  			knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1513  					   KNAV_QUEUE_PDSP_REGS_REG_INDEX);
41f93af900a20d Sandeep Nair     2014-02-28  1514  		pdsp->intd =
41f93af900a20d Sandeep Nair     2014-02-28  1515  			knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1516  					   KNAV_QUEUE_PDSP_INTD_REG_INDEX);
41f93af900a20d Sandeep Nair     2014-02-28  1517  		pdsp->command =
41f93af900a20d Sandeep Nair     2014-02-28  1518  			knav_queue_map_reg(kdev, child,
41f93af900a20d Sandeep Nair     2014-02-28  1519  					   KNAV_QUEUE_PDSP_CMD_REG_INDEX);
41f93af900a20d Sandeep Nair     2014-02-28  1520  
41f93af900a20d Sandeep Nair     2014-02-28  1521  		if (IS_ERR(pdsp->command) || IS_ERR(pdsp->iram) ||
41f93af900a20d Sandeep Nair     2014-02-28  1522  		    IS_ERR(pdsp->regs) || IS_ERR(pdsp->intd)) {
41f93af900a20d Sandeep Nair     2014-02-28  1523  			dev_err(dev, "failed to map pdsp %s regs\n",
41f93af900a20d Sandeep Nair     2014-02-28  1524  				pdsp->name);
41f93af900a20d Sandeep Nair     2014-02-28  1525  			if (!IS_ERR(pdsp->command))
41f93af900a20d Sandeep Nair     2014-02-28  1526  				devm_iounmap(dev, pdsp->command);
41f93af900a20d Sandeep Nair     2014-02-28  1527  			if (!IS_ERR(pdsp->iram))
41f93af900a20d Sandeep Nair     2014-02-28  1528  				devm_iounmap(dev, pdsp->iram);
41f93af900a20d Sandeep Nair     2014-02-28  1529  			if (!IS_ERR(pdsp->regs))
41f93af900a20d Sandeep Nair     2014-02-28  1530  				devm_iounmap(dev, pdsp->regs);
41f93af900a20d Sandeep Nair     2014-02-28  1531  			if (!IS_ERR(pdsp->intd))
41f93af900a20d Sandeep Nair     2014-02-28  1532  				devm_iounmap(dev, pdsp->intd);
41f93af900a20d Sandeep Nair     2014-02-28  1533  			devm_kfree(dev, pdsp);
41f93af900a20d Sandeep Nair     2014-02-28  1534  			continue;
41f93af900a20d Sandeep Nair     2014-02-28  1535  		}
41f93af900a20d Sandeep Nair     2014-02-28  1536  		of_property_read_u32(child, "id", &pdsp->id);
41f93af900a20d Sandeep Nair     2014-02-28  1537  		list_add_tail(&pdsp->list, &kdev->pdsps);
96ee19becc3bd7 Murali Karicheri 2015-10-13  1538  		dev_dbg(dev, "added pdsp %s: command %p, iram %p, regs %p, intd %p\n",
41f93af900a20d Sandeep Nair     2014-02-28  1539  			pdsp->name, pdsp->command, pdsp->iram, pdsp->regs,
96ee19becc3bd7 Murali Karicheri 2015-10-13  1540  			pdsp->intd);
41f93af900a20d Sandeep Nair     2014-02-28  1541  	}
41f93af900a20d Sandeep Nair     2014-02-28  1542  	return 0;
41f93af900a20d Sandeep Nair     2014-02-28  1543  }
41f93af900a20d Sandeep Nair     2014-02-28  1544  
41f93af900a20d Sandeep Nair     2014-02-28  1545  static int knav_queue_stop_pdsp(struct knav_device *kdev,
41f93af900a20d Sandeep Nair     2014-02-28  1546  			  struct knav_pdsp_info *pdsp)
41f93af900a20d Sandeep Nair     2014-02-28  1547  {
41f93af900a20d Sandeep Nair     2014-02-28  1548  	u32 val, timeout = 1000;
41f93af900a20d Sandeep Nair     2014-02-28  1549  	int ret;
41f93af900a20d Sandeep Nair     2014-02-28  1550  
41f93af900a20d Sandeep Nair     2014-02-28  1551  	val = readl_relaxed(&pdsp->regs->control) & ~PDSP_CTRL_ENABLE;
41f93af900a20d Sandeep Nair     2014-02-28  1552  	writel_relaxed(val, &pdsp->regs->control);
41f93af900a20d Sandeep Nair     2014-02-28 @1553  	ret = knav_queue_pdsp_wait(&pdsp->regs->control, timeout,
41f93af900a20d Sandeep Nair     2014-02-28  1554  					PDSP_CTRL_RUNNING);
41f93af900a20d Sandeep Nair     2014-02-28  1555  	if (ret < 0) {
41f93af900a20d Sandeep Nair     2014-02-28  1556  		dev_err(kdev->dev, "timed out on pdsp %s stop\n", pdsp->name);
41f93af900a20d Sandeep Nair     2014-02-28  1557  		return ret;
41f93af900a20d Sandeep Nair     2014-02-28  1558  	}
045016902bf7ab Murali Karicheri 2015-10-13  1559  	pdsp->loaded = false;
045016902bf7ab Murali Karicheri 2015-10-13  1560  	pdsp->started = false;
41f93af900a20d Sandeep Nair     2014-02-28  1561  	return 0;
41f93af900a20d Sandeep Nair     2014-02-28  1562  }
41f93af900a20d Sandeep Nair     2014-02-28  1563  

:::::: The code at line 1381 was first introduced by commit
:::::: 41f93af900a20d1a0a358b522b5129c89677e9dc soc: ti: add Keystone Navigator QMSS driver

:::::: TO: Sandeep Nair <sandeep_n@ti.com>
:::::: CC: Santosh Shilimkar <santosh.shilimkar@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
