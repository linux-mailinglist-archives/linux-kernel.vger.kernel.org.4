Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F886804BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjA3EFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjA3EEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:04:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293572B2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675051477; x=1706587477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uWRBDX06yfsvaLDQqXqjxqoiHRKTeZYlGFtkHLtLP9Y=;
  b=depSzQOizpu6u7piTEz5H/CW+9o+cYp4tykOvRq6QjS+443vs/PmJYDu
   SWAjowOSHrgYCUAesgiIv7WKHrMtiqyKgdELGminjeJgS4AxH+8gkCH81
   YO9J22QMSb93HXeID1lrLlT7wThJDSpbysE9T23Fddf9xBEm5CPV33WEE
   JASx+MF51nGqa2EcvRzyfFrXp3juNeSORUoF98UHgjOVbS92YiPf6lxAi
   djP56DAWj8KRJhTIaPgDPND1HQ0lz9gFOC1UzCUMpPC2eps8wtVQhqisr
   8Bmu72obuaHpYH39yeu9PTwHFquUuJ98fgvDRgnUxgHdCu1LpfTjlIA5q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="328746245"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="328746245"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 20:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="696264357"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="696264357"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2023 20:02:45 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMLNU-0003MA-1y;
        Mon, 30 Jan 2023 04:02:44 +0000
Date:   Mon, 30 Jan 2023 12:02:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: sound/soc/qcom/lpass-sc7280.c:419:34: warning:
 'sc7280_lpass_cpu_device_id' defined but not used
Message-ID: <202301301221.zDFityoS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d796c50f84ca79f1722bb131799e5a5710c4700
commit: b62c4e5fba2f910bc9f23ae152d11627e4c2f00f ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
date:   11 months ago
config: x86_64-buildonly-randconfig-r001-20230130 (https://download.01.org/0day-ci/archive/20230130/202301301221.zDFityoS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b62c4e5fba2f910bc9f23ae152d11627e4c2f00f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b62c4e5fba2f910bc9f23ae152d11627e4c2f00f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/qcom/lpass-sc7280.c:419:34: warning: 'sc7280_lpass_cpu_device_id' defined but not used [-Wunused-const-variable=]
     419 | static const struct of_device_id sc7280_lpass_cpu_device_id[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sc7280_lpass_cpu_device_id +419 sound/soc/qcom/lpass-sc7280.c

   418	
 > 419	static const struct of_device_id sc7280_lpass_cpu_device_id[] = {
   420		{.compatible = "qcom,sc7280-lpass-cpu", .data = &sc7280_data},
   421		{}
   422	};
   423	MODULE_DEVICE_TABLE(of, sc7280_lpass_cpu_device_id);
   424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
