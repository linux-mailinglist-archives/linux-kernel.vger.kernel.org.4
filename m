Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1826BDDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCQAv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCQAvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:51:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECBAFBA1;
        Thu, 16 Mar 2023 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679014314; x=1710550314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F0aL+5pXfubO4Fep3HxXNB4087FElE558NDpmhmpgXc=;
  b=QNDc95xSV5PldKzEfC3aWG1lJcAVmP+xqYjVuvii2E7Y40l4B+Y7OTii
   5C6zJlsk3ejRcQVrCcs1bNyJ33jsIaCpVWIDVp+nEJ4akn95sTSB5GYSY
   cyIem3GLP2Q119rJYy9nC08hRexqAoyYnE8FnixjYYagZbB2QiJIQXhTW
   cbBCne2GKBiV+mCS6jrMvld8dyll4BD62h5lE6eZKTlg8NelgixARJ4X2
   C1J/RGqbmOgAkTfRSl53ClI4PphOiDEGy9G4rCEYZ3wEuikIicjXq4Afp
   zX4BE6AaB72lie4ajRFcgYKzMH5hDbdCX8CB1c0D9HFVthtES8OUhgvSP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="317804627"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="317804627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712560052"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="712560052"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2023 17:51:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcyJx-0008wA-0r;
        Fri, 17 Mar 2023 00:51:49 +0000
Date:   Fri, 17 Mar 2023 08:51:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: ublk: enable zoned storage support
Message-ID: <202303170851.rY3VPud2-lkp@intel.com>
References: <20230316145539.300523-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316145539.300523-1-nmi@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on eeac8ede17557680855031c6f305ece2378af326]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/block-ublk-enable-zoned-storage-support/20230316-225725
base:   eeac8ede17557680855031c6f305ece2378af326
patch link:    https://lore.kernel.org/r/20230316145539.300523-1-nmi%40metaspace.dk
patch subject: [PATCH v3] block: ublk: enable zoned storage support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230317/202303170851.rY3VPud2-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/723d5c2508e09f127226d38c698d3e4e6cff83f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Hindborg/block-ublk-enable-zoned-storage-support/20230316-225725
        git checkout 723d5c2508e09f127226d38c698d3e4e6cff83f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170851.rY3VPud2-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
>> ERROR: modpost: "ublk_set_nr_zones" [drivers/block/ublk_drv.ko] undefined!
>> ERROR: modpost: "ublk_dev_param_zoned_apply" [drivers/block/ublk_drv.ko] undefined!
>> ERROR: modpost: "ublk_revalidate_disk_zones" [drivers/block/ublk_drv.ko] undefined!
>> ERROR: modpost: "ublk_report_zones" [drivers/block/ublk_drv.ko] undefined!
WARNING: modpost: suppressed 19 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
