Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5268A6C8F62
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCYQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:17:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF74C01;
        Sat, 25 Mar 2023 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679761031; x=1711297031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vrcn0rGVgrXIQf6tSvf4FE1wbGH838j2OtTvkbDyXDw=;
  b=NRZ1i7NCCvQF5HJfvkUWLcqYMkEyL96Dl3LrcPbeNA/DwguAx/Canfxa
   1Yi/aggSNNQVVUwdgVrt4C0OkQhv4lmYwP9FVufpBUrz9YHqZRlQpLySD
   6pqS2kp1YR8azNFhMP6g37jUfwQ/bfnTcq0wCfSoZUQIL3O09C4Nxs6E3
   0robPUd/xcZ6uLkl7OtnFXMcuNcvkaxfkuMF0voXlessMTi+nU/LBZP5O
   8EbrdyzUyJdzZoBdRLdHp9FIEiQHIXClwlGiKvQrsYwVrIpMvqq+ihdNW
   7oU7Pka2A+8kgJhb+w3QfoZkTF7gFRIYeGUFvmNt0VpJmer2Kr+vdUYNs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="404914160"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="404914160"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="685520387"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="685520387"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2023 09:17:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg6Zn-000GNO-0v;
        Sat, 25 Mar 2023 16:17:07 +0000
Date:   Sun, 26 Mar 2023 00:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: Re: [PATCH 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Message-ID: <202303260005.DW8hkIxU-lkp@intel.com>
References: <20230325135114.21688-3-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325135114.21688-3-me@dylanvanassche.be>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dylan-Van-Assche/dts-arm64-qcom-sdm845-add-SLPI-remoteproc/20230325-215354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230325135114.21688-3-me%40dylanvanassche.be
patch subject: [PATCH 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230326/202303260005.DW8hkIxU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/df03f51210d03566bf0d35a56633d55e3c57b5ad
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dylan-Van-Assche/dts-arm64-qcom-sdm845-add-SLPI-remoteproc/20230325-215354
        git checkout df03f51210d03566bf0d35a56633d55e3c57b5ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303260005.DW8hkIxU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sdm845.dtsi:3360.4-5 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
