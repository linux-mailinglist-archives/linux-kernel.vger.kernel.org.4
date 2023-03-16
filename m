Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F16BCAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCPJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCPJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:33:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E89EF56;
        Thu, 16 Mar 2023 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678959213; x=1710495213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vviP9jkscFvbPc1PciingGxOCazB42N7+7fnQuehKsk=;
  b=U1WWYTDFSKZNFKEm0ibP9Jx8UjsTLQMpmVqrKzB7Gi8a89A/l6yzgewl
   P52kbkNzmEgc2fiSU4k6PXibmDy+hkSjMRJVL6cp8ROElccutfN1PkGvs
   JTda8GAmdsBt2TaX80Xvpwwz24U4JqtdK3eqBYLYORWh/IrB1FAVOpg+4
   MoDtAZ/bc+WyoCHWlQB+DIHFLwUkFTTLxdcKHg9nhibY80VSYAtwLdqcG
   d/6krdMtZTlmu1m/TjthFpFvQ+Ht46qtd80XxmsChxiXV3ny7GJimzdQL
   Lgsk/ePssRsJaqP54+EvAlTZPflJp6dc69SaHeAx3bUyvhIDPminnKB+f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339466441"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339466441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 02:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="710026419"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="710026419"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2023 02:33:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcjzC-0008RS-0S;
        Thu, 16 Mar 2023 09:33:26 +0000
Date:   Thu, 16 Mar 2023 17:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     oe-kbuild-all@lists.linux.dev, Hao Zhang <quic_hazha@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Coresight: Add coresight dummy driver
Message-ID: <202303161702.oIkvUip5-lkp@intel.com>
References: <20230316032005.6509-2-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316032005.6509-2-quic_hazha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.3-rc2 next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hao-Zhang/Coresight-Add-coresight-dummy-driver/20230316-112827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230316032005.6509-2-quic_hazha%40quicinc.com
patch subject: [PATCH v1 1/3] Coresight: Add coresight dummy driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230316/202303161702.oIkvUip5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/140cd28ed9031020826cfb5e62e80e28f7504895
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hao-Zhang/Coresight-Add-coresight-dummy-driver/20230316-112827
        git checkout 140cd28ed9031020826cfb5e62e80e28f7504895
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303161702.oIkvUip5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-dummy.c:163:12: warning: no previous prototype for 'dummy_init' [-Wmissing-prototypes]
     163 | int __init dummy_init(void)
         |            ^~~~~~~~~~
>> drivers/hwtracing/coresight/coresight-dummy.c:169:13: warning: no previous prototype for 'dummy_exit' [-Wmissing-prototypes]
     169 | void __exit dummy_exit(void)
         |             ^~~~~~~~~~


vim +/dummy_init +163 drivers/hwtracing/coresight/coresight-dummy.c

   162	
 > 163	int __init dummy_init(void)
   164	{
   165		return platform_driver_register(&dummy_driver);
   166	}
   167	module_init(dummy_init);
   168	
 > 169	void __exit dummy_exit(void)
   170	{
   171		platform_driver_unregister(&dummy_driver);
   172	}
   173	module_exit(dummy_exit);
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
