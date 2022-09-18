Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9908B5BBC49
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIRHS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIRHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 03:18:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152224BCA
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663485504; x=1695021504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sfSfQM/bWsGHy0rCKg27eWK3r7pXgUxJz8NRc+gJm70=;
  b=acbZ4op+o49LZxjlUw+GlhjAhLS2b4A1yjnyuQL0ufC+JTyNYwO8p9gH
   q4BhzhpTMt0hA4VMB/eNqB+P3Z6H0wrP+rSAWUkWaU9sJPrecQgxdC0kB
   uglRBQDsVYNzXP8o+FIpQ0LlikI29q5JM5nYflu4MDdufCg7EyM5Agfd+
   Fk0qxv4/JR8LgRIq5wSpPWVwoBYyAKMosfGh2C8wnKtyXHuVGiDVij1B/
   uxbSy4sXPv9GEvb4Q+32FiawVYV1mAwOFcOYQN5yLsT7JqM+K0l2tGzrZ
   n6wR24bp74ZvwLVuRzGM/Lfk3VzF0Cpg1pSQ1BZ7Ix7d4ug1CVL54P/3P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="299203884"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="299203884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 00:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569285571"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 00:18:21 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZoZJ-0000zT-00;
        Sun, 18 Sep 2022 07:18:21 +0000
Date:   Sun, 18 Sep 2022 15:17:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jude Shih <shenshih@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 8229/9999] htmldocs:
 ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:633: warning: expecting
 prototype for dmub_aux_setconfig_reply_callback(). Prototype was for
 dmub_aux_setconfig_callback() instead
Message-ID: <202209181501.O6IEQWli-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   d766f744e4827dc41ef6c01403a96b7bb3938132
commit: 734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd [8229/9999] drm/amd/display: Support for DMUB HPD interrupt handling
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:633: warning: expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype was for dmub_aux_setconfig_callback() instead

vim +633 ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

   622	
   623	/**
   624	 * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
   625	 * @adev: amdgpu_device pointer
   626	 * @notify: dmub notification structure
   627	 *
   628	 * Dmub AUX or SET_CONFIG command completion processing callback
   629	 * Copies dmub notification to DM which is to be read by AUX command.
   630	 * issuing thread and also signals the event to wake up the thread.
   631	 */
   632	void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
 > 633	{
   634		if (adev->dm.dmub_notify)
   635			memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
   636		if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
   637			complete(&adev->dm.dmub_aux_transfer_done);
   638	}
   639	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
