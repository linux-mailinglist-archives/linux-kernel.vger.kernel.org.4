Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE573C5B4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFXBH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXBH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:07:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AE26B9;
        Fri, 23 Jun 2023 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687568845; x=1719104845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6wZk7MF4SlFUpTpCcuRbEr7K9Mso347QOjbT+IxNlc=;
  b=Kd0VUo7hbiJ8OVl82u9dZb3AK1qryJFtMQc8uqtxuTH+zCu/FLrrFA9O
   8XOWk2QcIfzIH8BjapH72SenE4XyB1CxrzERrvQKiY7ZwGgYobs1pNwJZ
   y+Y38dREuhgj8PA1nu8t1B7qtQIuJ8v7mDRKW9xFlH/w5vB96DlxV4gWv
   CdFfY8ExIkk8L9pFNDZjLf5YknWR1tYKDcgizl1iglvLGmaxTzximYSUh
   fqiIWO9wnqRDySzOvYdsPvjUm+RMzWVypeW2tMC8vfR7AOCXEsp9HHY2J
   YmZWfZ02F4uoF3hQHTqvsbaCCyFXkjCCmrYircEYYURUzGvaRQWP5c+qV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="390970069"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="390970069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="805378537"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="805378537"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2023 18:07:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCrkH-0008cn-2g;
        Sat, 24 Jun 2023 01:07:21 +0000
Date:   Sat, 24 Jun 2023 09:06:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: Re: [PATCH v4 3/6] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support.
Message-ID: <202306240837.Keyvmt2I-lkp@intel.com>
References: <20230623141806.13388-4-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623141806.13388-4-quic_kbajaj@quicinc.com>
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

Hi Komal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.4-rc7 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Komal-Bajaj/dt-bindings-nvmem-sec-qfprom-Add-bindings-for-secure-qfprom/20230623-222054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230623141806.13388-4-quic_kbajaj%40quicinc.com
patch subject: [PATCH v4 3/6] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support.
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230624/202306240837.Keyvmt2I-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306240837.Keyvmt2I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306240837.Keyvmt2I-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvmem/sec-qfprom.c:31: warning: expecting prototype for struct sec_sec_qfprom_priv. Prototype was for struct sec_qfprom_priv instead


vim +31 drivers/nvmem/sec-qfprom.c

    20	
    21	
    22	/**
    23	 * struct sec_sec_qfprom_priv - structure holding secure qfprom attributes
    24	 *
    25	 * @qfpseccorrected: iomapped memory space for secure qfprom corrected address space.
    26	 * @dev: qfprom device structure.
    27	 */
    28	struct sec_qfprom_priv {
    29		phys_addr_t qfpseccorrected;
    30		struct device *dev;
  > 31	};
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
