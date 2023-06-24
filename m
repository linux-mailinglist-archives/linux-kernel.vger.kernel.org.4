Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5173CC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjFXSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFXSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:30:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A831BC1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687631418; x=1719167418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=335Eso4n/kaqrLq9eASRQ6LXjTYDoqNxbDIwBw02Z/g=;
  b=KezW8NRm42em1jcpuuscv8HIShfe9WNXgh9becsKJwKLiAp/YRWobQgv
   fpDB3cvyewKduXFfpXQRLARWiItchoNprXvu+HGGLNvgoNluS4XtCfZkd
   Ndac163eFVu3FRsuPTONNObxjHVgxb+Hjb1o/tmPBXovgp4y3o2JrItIP
   vOEtoF+qdkO4pu6PbcgoQ+doDGSeiw4/aoHqYkG9NkGw00W8Fia4+85fc
   mlWDndTnASfmWmic1alsinn1W1/Yaoxggovx0qnWzqqooqiBHy2ufo3oG
   Sga+X6Oi3zMfrzY7+IowicPw/cLyoMWd4O/kX+4zzB8LjiV2X+UbZh0GH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="359840983"
X-IronPort-AV: E=Sophos;i="6.01,155,1684825200"; 
   d="scan'208";a="359840983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 11:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="839790677"
X-IronPort-AV: E=Sophos;i="6.01,155,1684825200"; 
   d="scan'208";a="839790677"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2023 11:30:14 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qD81V-0009Kf-34;
        Sat, 24 Jun 2023 18:30:13 +0000
Date:   Sun, 25 Jun 2023 02:30:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alison Wang <alison.wang@nxp.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, leoyang.li@nxp.com,
        xuelin.shi@nxp.com, xiaofeng.ren@nxp.com, feng.guo@nxp.com,
        Alison Wang <alison.wang@nxp.com>
Subject: Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Message-ID: <202306250204.6o8RGyDl-lkp@intel.com>
References: <20230616055913.2360-2-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616055913.2360-2-alison.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alison,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.4-rc7 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alison-Wang/ethosu-Add-Arm-Ethos-U-driver/20230616-141036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230616055913.2360-2-alison.wang%40nxp.com
patch subject: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
config: mips-randconfig-s032-20230625 (https://download.01.org/0day-ci/archive/20230625/202306250204.6o8RGyDl-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230625/202306250204.6o8RGyDl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306250204.6o8RGyDl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/ethosu/ethosu_inference.c:54:28: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/firmware/ethosu/ethosu_inference.c:54:28: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/firmware/ethosu/ethosu_inference.c:54:28: sparse:     got unsigned int ( * )( ... )
   drivers/firmware/ethosu/ethosu_inference.c:361:44: sparse: sparse: non size-preserving integer to pointer cast

vim +54 drivers/firmware/ethosu/ethosu_inference.c

    37	
    38	/****************************************************************************
    39	 * Variables
    40	 ****************************************************************************/
    41	
    42	static int ethosu_inference_release(struct inode *inode,
    43					    struct file *file);
    44	
    45	static unsigned int ethosu_inference_poll(struct file *file,
    46						  poll_table *wait);
    47	
    48	static long ethosu_inference_ioctl(struct file *file,
    49					   unsigned int cmd,
    50					   unsigned long arg);
    51	
    52	static const struct file_operations ethosu_inference_fops = {
    53		.release        = &ethosu_inference_release,
  > 54		.poll           = &ethosu_inference_poll,
    55		.unlocked_ioctl = &ethosu_inference_ioctl,
    56	#ifdef CONFIG_COMPAT
    57		.compat_ioctl   = &ethosu_inference_ioctl,
    58	#endif
    59	};
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
