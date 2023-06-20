Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26448736497
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFTHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFTHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:31:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F541700
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687246274; x=1718782274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i7kG41A2Xomj8VRTEMb1+3KdeQRecNejJAW3tC1g1UE=;
  b=ccHTMhpHLEjGeu6F+qFs9qG7J/owmRZ1lhXFmhWKslTIC32dIDZq0hEC
   zfDJ38OaZTYx8KPdSlb1zSPf4+lgTC4Xx09F+g2hgM3iSr/B21PVsVcRS
   4xhW1LWvatrpDt6OCgcTtS9tNGFBNnGNYOlQFkXf3M+V2Nix7YySJvTup
   zn0PlbKIrnJa2NqO7JGhtBNqWrzbpf6ATKnSt+DSDAgIvHKuCcymtZisF
   Echb0HPkK1mkAScBHIGcd/cpolc54aY+TI4IvVyMOqvuqRFVBrdoCS85o
   QzRmqREZdS2u4WY0j7Q3aaFWFzphwVLxZ7kN8hq1wXFo67n/NicKw6P8m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="358659182"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="358659182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 00:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="708153740"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="708153740"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 00:31:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBVpM-0005do-38;
        Tue, 20 Jun 2023 07:31:00 +0000
Date:   Tue, 20 Jun 2023 15:30:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     tien.sung.ang@intel.com, Dinh Nguyen <dinguyen@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: Re: [PATCH 1/2] firmware: stratix10-svc: Support up to N SVC clients
Message-ID: <202306201523.U6yvKscG-lkp@intel.com>
References: <20230620035205.1158032-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620035205.1158032-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4-rc7 next-20230619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/tien-sung-ang-intel-com/firmware-stratix10-svc-Support-up-to-N-SVC-clients/20230620-115443
base:   linus/master
patch link:    https://lore.kernel.org/r/20230620035205.1158032-1-tien.sung.ang%40intel.com
patch subject: [PATCH 1/2] firmware: stratix10-svc: Support up to N SVC clients
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230620/202306201523.U6yvKscG-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201523.U6yvKscG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201523.U6yvKscG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/stratix10-svc.c: In function 'stratix10_svc_free_channels':
>> drivers/firmware/stratix10-svc.c:1149:21: warning: the comparison will always evaluate as 'true' for the address of 'svc_fifo' will never be NULL [-Waddress]
    1149 |                 if (&ctrl->chans[i].svc_fifo)
         |                     ^
   drivers/firmware/stratix10-svc.c:167:22: note: 'svc_fifo' declared here
     167 |         struct kfifo svc_fifo;
         |                      ^~~~~~~~


vim +1149 drivers/firmware/stratix10-svc.c

  1138	
  1139	static void stratix10_svc_free_channels(struct stratix10_svc_controller *ctrl)
  1140	{
  1141		int i;
  1142	
  1143		for (i = 0; i < SVC_NUM_CHANNEL; i++) {
  1144			if (ctrl->chans[i].task) {
  1145				kthread_stop(ctrl->chans[i].task);
  1146				ctrl->chans[i].task = NULL;
  1147			}
  1148	
> 1149			if (&ctrl->chans[i].svc_fifo)
  1150				kfifo_free(&ctrl->chans[i].svc_fifo);
  1151		}
  1152	}
  1153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
