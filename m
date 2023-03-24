Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FDA6C76A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCXEsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXEsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:48:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3261272C;
        Thu, 23 Mar 2023 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679633292; x=1711169292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iuSVJySxch0+zE7YbQ4dkxYZSIAl4bM37WBu6B7ujFQ=;
  b=CnR90AdrXp6bSRLFVXEFUhu3kEmRSQLYdlrJIz40fKC35v4BmNMixw/Y
   ePDdoZ0z5vCBM6LEbsOBHpj4qbk0gmJC+hB7cZxeDn9addhglnG4rpXKY
   KHiOtpwLWIYYmicvQVe3JogcMlt2ibjxYnCwtWNki/VrLKEBiueq29t2r
   2uazrcZSalzTwCHIqxVpkf6+NJBC/WrO33olU34HSzSp5CZyp3Cj0AYR/
   QTAya2oXhDffkukHjPNg2OJwU4IH4v8RwA2vY+cFMMARUdXL5cOK2N/hC
   /lcd7lc9eMxDvVCHMM+/YthuFFrOnhOwkUHchN/q9QjadZbYJfV4UwES5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339723841"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="339723841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 21:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632698101"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="632698101"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 21:48:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfZLK-000EzC-3C;
        Fri, 24 Mar 2023 04:47:58 +0000
Date:   Fri, 24 Mar 2023 12:47:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mailbox: pcc: Use mbox_bind_client
Message-ID: <202303241233.htC8Sxvg-lkp@intel.com>
References: <20230323191527.1472695-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323191527.1472695-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 6ccbe33a39523f6d62b22c5ee99c6695993c935e]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/mailbox-Allow-direct-registration-to-a-channel/20230324-031813
base:   6ccbe33a39523f6d62b22c5ee99c6695993c935e
patch link:    https://lore.kernel.org/r/20230323191527.1472695-4-quic_eberman%40quicinc.com
patch subject: [PATCH v2 3/3] mailbox: pcc: Use mbox_bind_client
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20230324/202303241233.htC8Sxvg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/5db6edf9f393224193ab13e82d63e0d7616c74c9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/mailbox-Allow-direct-registration-to-a-channel/20230324-031813
        git checkout 5db6edf9f393224193ab13e82d63e0d7616c74c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mailbox/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241233.htC8Sxvg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/pcc.c:355:5: sparse: sparse: symbol 'pcc_startup' was not declared. Should it be static?
>> drivers/mailbox/pcc.c:378:6: sparse: sparse: symbol 'pcc_shutdown' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
