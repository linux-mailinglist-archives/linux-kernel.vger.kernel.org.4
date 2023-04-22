Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A672B6EBC16
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 01:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDVXaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVXaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 19:30:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30C213D;
        Sat, 22 Apr 2023 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682206199; x=1713742199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mk/rUj7xZQRo0wJpLXl0vUvyBjGAGS0GDp1KvZ8ywtY=;
  b=UoL4LXvPoiGlOnYHwheXZtEUEvL1NSWHDO3PWJCWFFbcg5zQTJlVUwL0
   W4PJQswd5xW0ZaDUEmIEUVXmFYZRpKRjApFOkYgROLQ/eoHmUITCsYmQ4
   zSmmsJSqCbI6ZiqURc6qLcLT2ysRK+9OownHzdMkzgQpzkYkWc2Clq8RO
   cz+WXqkwpK4fEmGRqqiX2b1jLJBLhxRtXo96Kab3skzLEfiMh/rMs999Q
   /HP9vudGfVf6fi/ugfNyeowuWfCqP1z9sErcAl5jfd3FwsGNw/HySjoMM
   W1KhNWL4YxKbmXlFca6CSBwjrStQJ5Yc1aImEM2EbSoqLxw2GAJYNSogE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="335096975"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="335096975"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 16:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="781954255"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="781954255"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2023 16:29:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqMfz-000hZ8-0g;
        Sat, 22 Apr 2023 23:29:55 +0000
Date:   Sun, 23 Apr 2023 07:29:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH V5 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Message-ID: <202304230707.TM8MomW0-lkp@intel.com>
References: <142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souradeep,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-dt/for-next linus/master v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Souradeep-Chowdhury/dt-bindings-sram-qcom-imem-Add-Boot-Stat-region-within-IMEM/20230418-144757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu%40quicinc.com
patch subject: [PATCH V5 2/3] soc: qcom: boot_stat: Add Driver Support for Boot Stats
config: nios2-randconfig-s033-20230423 (https://download.01.org/0day-ci/archive/20230423/202304230707.TM8MomW0-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/1e2fc43bcc0869349f7e3698fceebbcc8333d1f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Souradeep-Chowdhury/dt-bindings-sram-qcom-imem-Add-Boot-Stat-region-within-IMEM/20230418-144757
        git checkout 1e2fc43bcc0869349f7e3698fceebbcc8333d1f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304230707.TM8MomW0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/qcom/boot_stats.c:70:36: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got struct boot_stats [noderef] __iomem *b_stats @@
   drivers/soc/qcom/boot_stats.c:70:36: sparse:     expected void *data
   drivers/soc/qcom/boot_stats.c:70:36: sparse:     got struct boot_stats [noderef] __iomem *b_stats
   drivers/soc/qcom/boot_stats.c:71:72: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got struct boot_stats [noderef] __iomem *b_stats @@
   drivers/soc/qcom/boot_stats.c:71:72: sparse:     expected void *data
   drivers/soc/qcom/boot_stats.c:71:72: sparse:     got struct boot_stats [noderef] __iomem *b_stats

vim +70 drivers/soc/qcom/boot_stats.c

    52	
    53	static int boot_stats_probe(struct platform_device *pdev)
    54	{
    55		struct device *bootstat_dev = &pdev->dev;
    56		struct bs_data *drvdata;
    57	
    58		drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
    59		platform_set_drvdata(pdev, drvdata);
    60	
    61		drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), NULL);
    62		if (IS_ERR(drvdata->dbg_dir))
    63			return dev_err_probe(bootstat_dev, -ENOENT, "failed to create debugfs directory");
    64	
    65		drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
    66		if (!drvdata->b_stats)
    67			return dev_err_probe(bootstat_dev, -ENOMEM, "failed to map imem region\n");
    68	
    69		debugfs_create_file("pre_abl_time", 0200, drvdata->dbg_dir,
  > 70				    drvdata->b_stats, &pre_abl_time_fops);
    71		debugfs_create_file("abl_time", 0200, drvdata->dbg_dir, drvdata->b_stats, &abl_time_fops);
    72	
    73		return 0;
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
