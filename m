Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB16D83BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDEQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDEQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:31:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFE2115;
        Wed,  5 Apr 2023 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680712292; x=1712248292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wBw0wnzu4XdIkQvANOn4jcZNTmE4P0o1YbVmHEHd38=;
  b=gdUvBd9W2m6uk9WzbNOm/47LAyvkf9Bs9JvQPedwix/913elttnI87qm
   PkWWZl8g59v4nJA79hVd8WwY5TDwH8NU+laQv9gQV9B2RAWp9vjhQ/5+5
   80p2mtDRlMMwBoUgb5NOjy3h6/gbVqJONLjLFyKya/DBYp9dnPp94TNJV
   RAbBJHdkeR8lEwGl8jxWk6VJeBzpBWzLyncY019T5TtGzvwTOFMq1Ub4K
   Qt/RQNEGrYEujcYXLz4ijBbq1deZGu9kur6ZXahTtaXPC/BDZIJbjSRWc
   6lP9tnN3JwIUS266A8kdeFk9v04uPm/8LaU0LK5kcr5C20B+JfaxyQeRU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="339994355"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="339994355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="932890851"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="932890851"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Apr 2023 09:31:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pk62Y-000Qdx-0p;
        Wed, 05 Apr 2023 16:31:18 +0000
Date:   Thu, 6 Apr 2023 00:30:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/2] soc: qcom: Introduce RPM master stats driver
Message-ID: <202304060002.HLUjkH63-lkp@intel.com>
References: <20230405-topic-master_stats-v1-2-1b1fa2739953@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-topic-master_stats-v1-2-1b1fa2739953@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8417c8f5007bf4567ccffda850a3157c7d905f67]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/dt-bindings-soc-qcom-Add-RPM-Master-stats/20230405-230341
base:   8417c8f5007bf4567ccffda850a3157c7d905f67
patch link:    https://lore.kernel.org/r/20230405-topic-master_stats-v1-2-1b1fa2739953%40linaro.org
patch subject: [PATCH 2/2] soc: qcom: Introduce RPM master stats driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230406/202304060002.HLUjkH63-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/76fec5cd8630399cfdb8612093bfa0a5d0d98ea9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Konrad-Dybcio/dt-bindings-soc-qcom-Add-RPM-Master-stats/20230405-230341
        git checkout 76fec5cd8630399cfdb8612093bfa0a5d0d98ea9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304060002.HLUjkH63-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/rpm_master_stats.c: In function 'master_stats_probe':
>> drivers/soc/qcom/rpm_master_stats.c:92:83: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'int' [-Wformat=]
      92 |                                              "Couldn't parse MSG RAM phandle idx %s", i);
         |                                                                                  ~^   ~
         |                                                                                   |   |
         |                                                                                   |   int
         |                                                                                   char *
         |                                                                                  %d


vim +92 drivers/soc/qcom/rpm_master_stats.c

    66	
    67	static int master_stats_probe(struct platform_device *pdev)
    68	{
    69		struct device *dev = &pdev->dev;
    70		struct device_node *msgram_np;
    71		struct master_stats_data *d;
    72		struct dentry *dent, *root;
    73		struct resource res;
    74		int count, i, ret;
    75	
    76		count = of_property_count_strings(dev->of_node, "qcom,master-names");
    77		if (count < 0)
    78			return count;
    79	
    80		d = devm_kzalloc(dev, count * sizeof(*d), GFP_KERNEL);
    81		if (!d)
    82			return -ENOMEM;
    83	
    84		root = debugfs_create_dir("rpm_master_stats", NULL);
    85		platform_set_drvdata(pdev, root);
    86	
    87		for (i = 0; i < count; i++) {
    88			msgram_np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", i);
    89			if (!msgram_np) {
    90				debugfs_remove_recursive(root);
    91				return dev_err_probe(dev, -EINVAL,
  > 92						     "Couldn't parse MSG RAM phandle idx %s", i);
    93			}
    94	
    95			/*
    96			 * Purposefully skip devm_platform helpers as we're using a
    97			 * shared resource.
    98			 */
    99			ret = of_address_to_resource(msgram_np, 0, &res);
   100			if (ret < 0) {
   101				debugfs_remove_recursive(root);
   102				return ret;
   103			}
   104	
   105			d[i].base = devm_ioremap(dev, res.start, resource_size(&res));
   106			if (IS_ERR(d[i].base)) {
   107				debugfs_remove_recursive(root);
   108				return dev_err_probe(dev, -EINVAL,
   109						     "Could not map the MSG RAM slice idx %d!\n", i);
   110			}
   111	
   112			ret = of_property_read_string_index(dev->of_node, "qcom,master-names", i,
   113							    &d[i].label);
   114			if (ret < 0) {
   115				debugfs_remove_recursive(root);
   116				return dev_err_probe(dev, ret,
   117						     "Could not read name idx %d!\n", i);
   118			}
   119	
   120			/*
   121			 * Generally it's not advised to fail on debugfs errors, but this
   122			 * driver's only job is exposing data therein.
   123			 */
   124			dent = debugfs_create_file(d[i].label, 0444, root,
   125						   &d[i], &master_stats_fops);
   126			if (!dent) {
   127				debugfs_remove_recursive(root);
   128				return -EINVAL;
   129			}
   130		}
   131	
   132		device_set_pm_not_required(dev);
   133	
   134		return 0;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
