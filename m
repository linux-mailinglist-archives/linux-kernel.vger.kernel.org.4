Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29B736C76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjFTM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjFTM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:58:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AB1709;
        Tue, 20 Jun 2023 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687265896; x=1718801896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rx06My1wOKBznlmcIkXlAcrSPxj2xuDSszYHKnhTV3U=;
  b=QISstDTPhLF8U/co/b9f2WsKEvIgE0Av1Wd7EtXZZN8stLsaBsvqVVDB
   a+T7QhoTIxHBRSl0hMzm8MKQKwQr1ORXkEWxS/5wMK8/HfuonZoqWPwrF
   y0iWCxN5hb6HcpeRjn8wxZWB8qmopPtsN7o8BUUCqfYKn/Upm+ygsKPTk
   vTEl2RVX8/omCStpvkHyqxnPLUaFQ2M1O2pJWlEuSaxUeI7H6T0VNTtee
   /XJpLXOTgeaPdn5ck9pczgysUCzPPns1PNfXQs1r2BE2FSwPYyFUr9lJR
   +ZSzX9RACb/OMZrHIJvU2mexUqi4a0nzcv3Ziads0JiKZ7co7crEmNSY3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363271845"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="363271845"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 05:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="784066018"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="784066018"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2023 05:58:12 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBavz-0005tA-3B;
        Tue, 20 Jun 2023 12:58:11 +0000
Date:   Tue, 20 Jun 2023 20:57:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Message-ID: <202306202006.FUjZfd9O-lkp@intel.com>
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master sailus-media-tree/streams v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuji-Ishikawa/dt-bindings-media-platform-visconti-Add-Toshiba-Visconti-Video-Input-Interface-bindings/20230620-120839
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230620031111.3776-3-yuji2.ishikawa%40toshiba.co.jp
patch subject: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
config: x86_64-buildonly-randconfig-r001-20230620 (https://download.01.org/0day-ci/archive/20230620/202306202006.FUjZfd9O-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306202006.FUjZfd9O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306202006.FUjZfd9O-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/visconti_viif.h:12:
>> usr/include/linux/videodev2.h:2464:20: error: field has incomplete type 'struct timespec'
           struct timespec                 timestamp;
                                           ^
   usr/include/linux/videodev2.h:2464:9: note: forward declaration of 'struct timespec'
           struct timespec                 timestamp;
                  ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
