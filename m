Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C239723175
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjFEUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjFEUc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:32:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688B94;
        Mon,  5 Jun 2023 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685997146; x=1717533146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btZahgC1h/ESCrvkTLalt9h2IyYRaP2vn69sQbCp+ZM=;
  b=i6Ymdy0/adVfFVaLO9v88T1qrKvgrLg9UUq/hioe0Of5giHv6g/Sob6C
   fV9XBrgUOMWyt7U8R/7JdfrtHdprO8su9jiesjp2unyuXgd3ciDqs0FcG
   XMOiv/LKqQ0GcqgrNQZxDYZ/VA+RRE1uefCGJeHUOjF3UIe4h8h4jf/x5
   id9dBn9iHUlOEdrRPI2+6YnCFxvd3dwJO+LE3hIYRdLmJJ67En4UDhko0
   5UbCQXeGKqITZFsAQifPIkA7LaQZA2W+CFlJ84DL88uAVrhgUBKDhFHnp
   a8EgjgEcBVdiAQATkkyUOunpcxzRAT5gd+rqFVMtPn5nuRjs9XHNlflC/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336831470"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="336831470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="708798601"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="708798601"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2023 13:32:23 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6GsI-0004QT-1h;
        Mon, 05 Jun 2023 20:32:22 +0000
Date:   Tue, 6 Jun 2023 04:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 10/14] soc: qcom: Add RPM processor/subsystem driver
Message-ID: <202306060446.CAOHuKLm-lkp@intel.com>
References: <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8d5a57ea6a0b1722725170e32e511701ca7c454c]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephan-Gerhold/dt-bindings-soc-qcom-smd-rpm-Fix-sort-order/20230605-151438
base:   8d5a57ea6a0b1722725170e32e511701ca7c454c
patch link:    https://lore.kernel.org/r/20230531-rpm-rproc-v1-10-e0a3b6de1f14%40gerhold.net
patch subject: [PATCH 10/14] soc: qcom: Add RPM processor/subsystem driver
config: m68k-randconfig-r023-20230605 (https://download.01.org/0day-ci/archive/20230606/202306060446.CAOHuKLm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e08a6ffdb1d65902d0c4fed40968ff2e4d83a476
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stephan-Gerhold/dt-bindings-soc-qcom-smd-rpm-Fix-sort-order/20230605-151438
        git checkout e08a6ffdb1d65902d0c4fed40968ff2e4d83a476
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306060446.CAOHuKLm-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/soc/qcom/rpm-proc.o: in function `rpm_proc_remove':
>> rpm-proc.c:(.text+0x12): undefined reference to `qcom_smd_unregister_edge'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
