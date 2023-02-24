Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02C6A1D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBXONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBXONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:13:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0772C211F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677248015; x=1708784015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fp4tA+iUltAlnGLma9o8GDd9EzYWAtujwIKXsR/KuG8=;
  b=ixrm1LWuTlZumI35jVhNQwQ3d6V1ANbbhtiJ23RIty3qiww2uwlsFia4
   Y5YR52aDmY7XurG/ZEQ6M36Aztvtzks+ZWVle3kCB2Z76JhBuGXCG3rvt
   MpRyisdHGlxPEbDJIQ6QbqbvSLq99AJAgIf2wi0mrX5mu0xQSKuPi2d1S
   iTaXE387kXKwvy7ku87hkOlx5c0AIh2DILAZutTaxR79Srzzux+g7VrMr
   ePqYTOuPcS7mLtPjNx3pF1RKLXIV8m3I3P0ZgiwdZP3pztuZ5HVZD/6bO
   Z0WM2MSwk022XDVDx43jIDc3rHd6GP+L98Fhtj/f1u6D/6zCt74nuGRmP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331218420"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="331218420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736810634"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="736810634"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2023 06:12:53 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVYoe-0002Sf-1Q;
        Fri, 24 Feb 2023 14:12:52 +0000
Date:   Fri, 24 Feb 2023 22:12:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/host/core.c:3109:44: sparse: sparse: invalid
 assignment: &=
Message-ID: <202302242222.PevBhzvC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2980d8d826554fa6981d621e569a453787472f8
commit: baff6491448b487e920faaa117e432989cbafa89 nvme: mask CSE effects for security receive
date:   3 weeks ago
config: m68k-randconfig-s051-20230222 (https://download.01.org/0day-ci/archive/20230224/202302242222.PevBhzvC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=baff6491448b487e920faaa117e432989cbafa89
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout baff6491448b487e920faaa117e432989cbafa89
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302242222.PevBhzvC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:3109:44: sparse: sparse: invalid assignment: &=
>> drivers/nvme/host/core.c:3109:44: sparse:    left side has type restricted __le32
>> drivers/nvme/host/core.c:3109:44: sparse:    right side has type int

vim +3109 drivers/nvme/host/core.c

  3083	
  3084	static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
  3085	{
  3086		struct nvme_effects_log	*log = ctrl->effects;
  3087	
  3088		log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
  3089							NVME_CMD_EFFECTS_NCC |
  3090							NVME_CMD_EFFECTS_CSE_MASK);
  3091		log->acs[nvme_admin_sanitize_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
  3092							NVME_CMD_EFFECTS_CSE_MASK);
  3093	
  3094		/*
  3095		 * The spec says the result of a security receive command depends on
  3096		 * the previous security send command. As such, many vendors log this
  3097		 * command as one to submitted only when no other commands to the same
  3098		 * namespace are outstanding. The intention is to tell the host to
  3099		 * prevent mixing security send and receive.
  3100		 *
  3101		 * This driver can only enforce such exclusive access against IO
  3102		 * queues, though. We are not readily able to enforce such a rule for
  3103		 * two commands to the admin queue, which is the only queue that
  3104		 * matters for this command.
  3105		 *
  3106		 * Rather than blindly freezing the IO queues for this effect that
  3107		 * doesn't even apply to IO, mask it off.
  3108		 */
> 3109		log->acs[nvme_admin_security_recv] &= ~NVME_CMD_EFFECTS_CSE_MASK;
  3110	
  3111		log->iocs[nvme_cmd_write] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
  3112		log->iocs[nvme_cmd_write_zeroes] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
  3113		log->iocs[nvme_cmd_write_uncor] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
  3114	}
  3115	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
