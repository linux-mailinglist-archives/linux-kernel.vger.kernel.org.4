Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03912742BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjF2STg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjF2STX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:19:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C1D35A3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688062750; x=1719598750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9DOLFbhO0O3J0HemaMykBjcHL+MYDHY5ezxdTvkUU38=;
  b=VzJ9WSWoUFwMdlzIyvZcZgzPzXCYVUhqd3at8dJqz68VyemUYK8a9YVH
   ukv4Ze5+YHCcTPvEs5VX4oLXw0oLte1OdmM+Ej0OXR6wqb6agDA0YN43E
   9QCt7Ti4lDPwewjHq6S2yMXNJ/9TnqYn7SNijDJGjEKNYufmFRl50vv5A
   80DD2yfTsw0GCoF0YS6f+i0BMovv/MhSEbo5Y/CR0PwiCr0JsCcKq5mkO
   jQE3w7xUj9ezrJgj2wY9yc/JBVhNzYiM64CdRtbiwL28Mq1H1j46xmf6X
   vlTlYEEenlJMJ/gVhzhPzKC/nu6dU/8rI9ONo1nzf/MGnHvB9pFdEE6fp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="362228699"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="362228699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 11:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="752736543"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="752736543"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2023 11:16:37 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEwC4-000EKH-0s;
        Thu, 29 Jun 2023 18:16:36 +0000
Date:   Fri, 30 Jun 2023 02:15:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3364:5: warning: stack frame
 size (2208) exceeds limit (2048) in 'psp_init_ta_microcode'
Message-ID: <202306300240.df8pU5Dy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a8a670eeeaa40d87bd38a587438952741980c18
commit: 994a97447e38182f530f246117a882c074d02af7 drm/amd: Parse both v1 and v2 TA microcode headers using same function
date:   6 months ago
config: arm64-randconfig-r026-20230629 (https://download.01.org/0day-ci/archive/20230630/202306300240.df8pU5Dy-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306300240.df8pU5Dy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306300240.df8pU5Dy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3116:5: warning: stack frame size (2688) exceeds limit (2048) in 'psp_init_sos_microcode' [-Wframe-larger-than]
   int psp_init_sos_microcode(struct psp_context *psp,
       ^
   2603/2688 (96.84%) spills, 85/2688 (3.16%) variables
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3364:5: warning: stack frame size (2208) exceeds limit (2048) in 'psp_init_ta_microcode' [-Wframe-larger-than]
   int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
       ^
   2114/2208 (95.74%) spills, 94/2208 (4.26%) variables
   2 warnings generated.


vim +/psp_init_ta_microcode +3364 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

  3363	
> 3364	int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
  3365	{
  3366		const struct common_firmware_header *hdr;
  3367		struct amdgpu_device *adev = psp->adev;
  3368		char fw_name[PSP_FW_NAME_LEN];
  3369		int err;
  3370	
  3371		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
  3372		err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
  3373		if (err)
  3374			return err;
  3375		err = amdgpu_ucode_validate(adev->psp.ta_fw);
  3376		if (err)
  3377			return err;
  3378	
  3379		hdr = (const struct common_firmware_header *)adev->psp.ta_fw->data;
  3380		switch (le16_to_cpu(hdr->header_version_major)) {
  3381		case 1:
  3382			err = parse_ta_v1_microcode(psp);
  3383			break;
  3384		case 2:
  3385			err = parse_ta_v2_microcode(psp);
  3386			break;
  3387		default:
  3388			dev_err(adev->dev, "unsupported TA header version\n");
  3389			err = -EINVAL;
  3390		}
  3391	
  3392		if (err) {
  3393			dev_err(adev->dev, "fail to initialize ta microcode\n");
  3394			release_firmware(adev->psp.ta_fw);
  3395			adev->psp.ta_fw = NULL;
  3396		}
  3397	
  3398		return err;
  3399	}
  3400	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
