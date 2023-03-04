Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2C6AAB9E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCDRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCDRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:39:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06484113CB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677951546; x=1709487546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pbPn0ihTjgWHra9d+ukE2EBA1AezAnHSV6eFrbKC9oo=;
  b=g+a0HdHbKfk0XlLrHO9CbsVWxo4DMndZb+640V07oDRczNsOpMv1GNzK
   9QaVi9vgPvo2PcT+cY2LSiy3HXbCVNDYuWQsHprixkF8YATvO8a82tsZA
   jdwYNKQ4FxeVoBM3ojUd/oxpfyNOEsSuY0NK89BaeCf1YVXPutRW0yBZf
   SfyAfOKG2GNu4p4fzPNTAvsZ3HAUif/lvhdCH52bxijSaXH2/MyZ5HqjT
   qhvoKNUCeR6cdEEHwp1FwJRA5/a71GrFu++3lRBz+2sqRG0JM/1wDfe72
   uro7jSG6dp3Cmc3pNuPe5l515/Cbckk2g/yc+yb6K8GR96Bmk4ZN3l9H8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="337602406"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="337602406"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 09:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708181145"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="708181145"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Mar 2023 09:39:02 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYVqY-0002HQ-0W;
        Sat, 04 Mar 2023 17:39:02 +0000
Date:   Sun, 5 Mar 2023 01:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rakesh Babu Saladi <rsaladi2@marvell.com>, mark.rutland@arm.com,
        lpieralisi@kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gcherian@marvell.com, naveenm@marvell.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Rakesh Babu Saladi <rsaladi2@marvell.com>
Subject: Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
Message-ID: <202303050135.zEqZYkVJ-lkp@intel.com>
References: <20230304125850.32687-1-rsaladi2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304125850.32687-1-rsaladi2@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rakesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on arm/for-next arm/fixes arm64/for-next/core kvmarm/next soc/for-next xilinx-xlnx/master linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rakesh-Babu-Saladi/arm64-smccc-Add-trace-events-to-SMC-calls/20230304-210103
patch link:    https://lore.kernel.org/r/20230304125850.32687-1-rsaladi2%40marvell.com
patch subject: [PATCH] arm64: smccc: Add trace events to SMC calls.
config: m68k-randconfig-r032-20230302 (https://download.01.org/0day-ci/archive/20230305/202303050135.zEqZYkVJ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ebdc6e981b26c56978d65ad39d650fd2a7862d1a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rakesh-Babu-Saladi/arm64-smccc-Add-trace-events-to-SMC-calls/20230304-210103
        git checkout ebdc6e981b26c56978d65ad39d650fd2a7862d1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303050135.zEqZYkVJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: section .rodata VMA [0000000000002000,000000000039d947] overlaps section .text VMA [0000000000000400,0000000000876c3f]
   m68k-linux-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
>> drivers/firmware/qcom_scm-legacy.c:176: undefined reference to `arm_smccc_smc'
   m68k-linux-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
   drivers/firmware/qcom_scm-legacy.c:234: undefined reference to `arm_smccc_smc'


vim +176 drivers/firmware/qcom_scm-legacy.c

b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  119  
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  120  /**
e1cd92da0b3321 drivers/firmware/qcom_scm-legacy.c Stephen Boyd        2021-02-23  121   * scm_legacy_call() - Sends a command to the SCM and waits for the command to
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  122   * finish processing.
ebf21bbc2ff56a drivers/firmware/qcom_scm-legacy.c Krzysztof Kozlowski 2022-05-19  123   * @dev:	device
ebf21bbc2ff56a drivers/firmware/qcom_scm-legacy.c Krzysztof Kozlowski 2022-05-19  124   * @desc:	descriptor structure containing arguments and return values
ebf21bbc2ff56a drivers/firmware/qcom_scm-legacy.c Krzysztof Kozlowski 2022-05-19  125   * @res:        results from SMC call
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  126   *
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  127   * A note on cache maintenance:
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  128   * Note that any buffers that are expected to be accessed by the secure world
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  129   * must be flushed before invoking qcom_scm_call and invalidated in the cache
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  130   * immediately after qcom_scm_call returns. Cache maintenance on the command
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  131   * and response buffers is taken care of by qcom_scm_call; however, callers are
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  132   * responsible for any other cached buffers passed over to the secure world.
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  133   */
9a434cee773ae1 drivers/firmware/qcom_scm-legacy.c Elliot Berman       2020-01-07  134  int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  135  		    struct qcom_scm_res *res)
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  136  {
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  137  	u8 arglen = desc->arginfo & 0xf;
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  138  	int ret = 0, context_id;
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  139  	unsigned int i;
e0aa153965041c drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  140  	struct scm_legacy_command *cmd;
e0aa153965041c drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  141  	struct scm_legacy_response *rsp;
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  142  	struct arm_smccc_args smc = {0};
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  143  	struct arm_smccc_res smc_res;
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  144  	const size_t cmd_len = arglen * sizeof(__le32);
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  145  	const size_t resp_len = MAX_QCOM_SCM_RETS * sizeof(__le32);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  146  	size_t alloc_len = sizeof(*cmd) + cmd_len + sizeof(*rsp) + resp_len;
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  147  	dma_addr_t cmd_phys;
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  148  	__le32 *arg_buf;
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  149  	const __le32 *res_buf;
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  150  
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  151  	cmd = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  152  	if (!cmd)
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  153  		return -ENOMEM;
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  154  
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  155  	cmd->len = cpu_to_le32(alloc_len);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  156  	cmd->buf_offset = cpu_to_le32(sizeof(*cmd));
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  157  	cmd->resp_hdr_offset = cpu_to_le32(sizeof(*cmd) + cmd_len);
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  158  	cmd->id = cpu_to_le32(SCM_LEGACY_FNID(desc->svc, desc->cmd));
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  159  
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  160  	arg_buf = scm_legacy_get_command_buffer(cmd);
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  161  	for (i = 0; i < arglen; i++)
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  162  		arg_buf[i] = cpu_to_le32(desc->args[i]);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  163  
e0aa153965041c drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  164  	rsp = scm_legacy_command_to_response(cmd);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  165  
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  166  	cmd_phys = dma_map_single(dev, cmd, alloc_len, DMA_TO_DEVICE);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  167  	if (dma_mapping_error(dev, cmd_phys)) {
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  168  		kfree(cmd);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  169  		return -ENOMEM;
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  170  	}
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  171  
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  172  	smc.args[0] = 1;
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  173  	smc.args[1] = (unsigned long)&context_id;
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  174  	smc.args[2] = cmd_phys;
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  175  
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11 @176  	mutex_lock(&qcom_scm_lock);
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  177  	__scm_legacy_do(&smc, &smc_res);
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  178  	if (smc_res.a0)
590e92809a58a5 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  179  		ret = qcom_scm_remap_error(smc_res.a0);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  180  	mutex_unlock(&qcom_scm_lock);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  181  	if (ret)
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  182  		goto out;
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  183  
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  184  	do {
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  185  		dma_sync_single_for_cpu(dev, cmd_phys + sizeof(*cmd) + cmd_len,
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  186  					sizeof(*rsp), DMA_FROM_DEVICE);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  187  	} while (!rsp->is_complete);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  188  
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  189  	dma_sync_single_for_cpu(dev, cmd_phys + sizeof(*cmd) + cmd_len +
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  190  				le32_to_cpu(rsp->buf_offset),
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  191  				resp_len, DMA_FROM_DEVICE);
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  192  
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  193  	if (res) {
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  194  		res_buf = scm_legacy_get_response_buffer(rsp);
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  195  		for (i = 0; i < MAX_QCOM_SCM_RETS; i++)
efd2b15c21a043 drivers/firmware/qcom_scm-32.c     Elliot Berman       2020-01-07  196  			res->result[i] = le32_to_cpu(res_buf[i]);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  197  	}
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  198  out:
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  199  	dma_unmap_single(dev, cmd_phys, alloc_len, DMA_TO_DEVICE);
16e59467a44651 drivers/firmware/qcom_scm-32.c     Andy Gross          2016-06-03  200  	kfree(cmd);
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  201  	return ret;
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  202  }
b6a1dfbc7d5740 drivers/firmware/qcom_scm-32.c     Kumar Gala          2015-03-11  203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
