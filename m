Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991A74DEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGJUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:01:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D7194;
        Mon, 10 Jul 2023 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689019287; x=1720555287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZ45qk7hVluta2GMMn37Fyi3fXfY6yfPSBwe92peGkM=;
  b=cY2faqJ4t4FjuhxMEj3aNkLQGeHkvqg/fm2/2RgjREXQ8/v76WsaDH+F
   0IaPi7e6bXL0Ef4VFARa3Haa52O3zy9Gq9qBOJjjnIxd7zYFBWLX7sJOp
   /gr62IAL0B5RyXeOja783qZbquZ224Lmq7H/qaV2FfPDvntjUQQGW1V0c
   TjkEMgmaraMNLzhC6y5avPo8HyTbEnJuXEzB9jOHt2Gzu9wIrH3LbY6HF
   qPCaa/dIb+38zzA0Hc8JkE2RcdImtpmLD8n4JqWX/F1HbEwHaLYbWM9n3
   RBLnfht5h3jZYTIuqptwAbxImgdFDrBK0QJboY1khSCT0yCMOfv56wNzd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="363309444"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="363309444"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 13:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967538695"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="967538695"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 13:01:25 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIx4W-0003vK-1c;
        Mon, 10 Jul 2023 20:01:24 +0000
Date:   Tue, 11 Jul 2023 04:00:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     alison@she-devel.com, johan@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alison@she-devel.com, achaiken@aurora.tech
Subject: Re: [PATCH v8 1/2] gnss: ubx: customize serial device open to set
 U-Blox Zed-F9P baud
Message-ID: <202307110347.FjEbD70k-lkp@intel.com>
References: <20230628150948.908273-2-alison@she-devel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628150948.908273-2-alison@she-devel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6995e2de6891c724bfeb2db33d7b87775f913ad1]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-she-devel-com/gnss-ubx-customize-serial-device-open-to-set-U-Blox-Zed-F9P-baud/20230628-231318
base:   6995e2de6891c724bfeb2db33d7b87775f913ad1
patch link:    https://lore.kernel.org/r/20230628150948.908273-2-alison%40she-devel.com
patch subject: [PATCH v8 1/2] gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
config: microblaze-randconfig-r062-20230710 (https://download.01.org/0day-ci/archive/20230711/202307110347.FjEbD70k-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307110347.FjEbD70k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307110347.FjEbD70k-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gnss/ubx.c:293:5-11: ERROR: allocation function on line 292 returns NULL not ERR_PTR on failure

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
