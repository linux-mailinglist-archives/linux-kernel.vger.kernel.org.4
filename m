Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104145E5744
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIVAWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIVAWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:22:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A0EA5715;
        Wed, 21 Sep 2022 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663806172; x=1695342172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suI+CfiK0vZ0xqyxyfYRHjqOciiRcs1MgqvAcaA1Mcc=;
  b=HXpwjos7rhOFq+eZJQr6/Nc6fi74yMqtYlDCyWYSzGUmKbKLE71pyEAE
   6Ms9qO9pyod3NW/GkYNUF+0LUco0fVCsjzkEPhU4EIJ+2i15CcPF5GpxC
   TF6FsPUdVqVJkAHkNUWsTtZQKfmT3+13oSyaXZtL8PHt25pWlGzvhzeXc
   yBO/YS4rCq7EFGMbNERRjnk1sPDZf2LnnVW15QpA2ZFuXX/vDAVb6H236
   FVlVzE1ypjty2yXtoSiEvYPwby1F7tGBDPC+H8nVBm5hi0Hrz9z0RJ9MZ
   kP1HI/dGUXs3/YMiF3MYFVjV14VFjrPe05cGEsbKtLPbxF7wBU88zH3iy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280530643"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="280530643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 17:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="761971990"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2022 17:22:49 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob9zM-00046a-20;
        Thu, 22 Sep 2022 00:22:48 +0000
Date:   Thu, 22 Sep 2022 08:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: Add sysfs entry to detect
 device shutdown
Message-ID: <202209220842.14LbOlkM-lkp@intel.com>
References: <42d3ab9227ac3d299abcedbbdd68c86e1dd6acce.1663604826.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d3ab9227ac3d299abcedbbdd68c86e1dd6acce.1663604826.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gokul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gokul-krishna-Krishnakumar/remoteproc-qcom-Add-sysfs-entry-to-detect-device-shutdown/20220920-004947
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220922/202209220842.14LbOlkM-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/dcf1afc28aee2a1770cdabe1f52d7e90532018c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gokul-krishna-Krishnakumar/remoteproc-qcom-Add-sysfs-entry-to-detect-device-shutdown/20220920-004947
        git checkout dcf1afc28aee2a1770cdabe1f52d7e90532018c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/qcom_common.c:97:27: warning: unused variable 'ssr_timeout_msg' [-Wunused-const-variable]
   static const char * const ssr_timeout_msg = "srcu notifier chain for %s:%s taking too long";
                             ^
   1 warning generated.


vim +/ssr_timeout_msg +97 drivers/remoteproc/qcom_common.c

    96	
  > 97	static const char * const ssr_timeout_msg = "srcu notifier chain for %s:%s taking too long";
    98	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
