Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EAA6D23DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjCaPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:19:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B8C1FFC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680275986; x=1711811986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6DYU9YNmKUr0TE/DUc3vf67LbYHXMXPhNj+QtfqCNPI=;
  b=ScqPLaj/4ogiH7FLZB+nXZt8Sm0Hlmc7be/kv4OVokPFNIbRK3dCCk5I
   3KSUWUh1YH2JrSeCAw0PqJlUhQEGgJw5ehmXRFiHQfYRAUk1/4rolxFhQ
   qBv7TDyuO8XkUcSi+y15xZS+p7LNbR403prjEgc+MEkyN8oSAEQm4m4V8
   7sYJFkfDn7b1fER9XhLhXT7OPxHdgLLUH2i9yBf8Q4Oiw4ZiRHZn8OI2F
   95yyuO+HKjD+8bfQuA2InUCfRJ6Pr4a5++b4wunbvrD/1jnnxaDNCNg3a
   nQHlSzbkdG6sN76z15GTsIGAhuavFKclcl9m8HWd3iQNfgbPJum3DWKXM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="340201925"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="340201925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="796160263"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="796160263"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2023 08:19:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piGXX-000Lu3-03;
        Fri, 31 Mar 2023 15:19:43 +0000
Date:   Fri, 31 Mar 2023 23:18:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 07/19] drm/i915/gem/i915_gem_create: Provide the function
 names for proper kerneldoc headers
Message-ID: <202303312304.LMo1KsTB-lkp@intel.com>
References: <20230331092607.700644-8-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331092607.700644-8-lee@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on drm-misc/drm-misc-next next-20230331]
[cannot apply to drm-intel/for-linux-next-fixes lee-leds/for-leds-next linus/master v6.3-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lee-Jones/drm-i915-i915_scatterlist-Fix-kerneldoc-formatting-issue-missing/20230331-173046
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
patch link:    https://lore.kernel.org/r/20230331092607.700644-8-lee%40kernel.org
patch subject: [PATCH 07/19] drm/i915/gem/i915_gem_create: Provide the function names for proper kerneldoc headers
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230331/202303312304.LMo1KsTB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7c87f97c7f11c1a2b3931d46ae1382c5ee0c14f7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lee-Jones/drm-i915-i915_scatterlist-Fix-kerneldoc-formatting-issue-missing/20230331-173046
        git checkout 7c87f97c7f11c1a2b3931d46ae1382c5ee0c14f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303312304.LMo1KsTB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gem/i915_gem_create.c:411: warning: expecting prototype for i915_gem_create_ext_ioct(). Prototype was for i915_gem_create_ext_ioctl() instead


vim +411 drivers/gpu/drm/i915/gem/i915_gem_create.c

ebcb40298947bdb Matthew Auld 2021-04-29  401  
ebcb40298947bdb Matthew Auld 2021-04-29  402  /**
7c87f97c7f11c1a Lee Jones    2023-03-31  403   * i915_gem_create_ext_ioct - Creates a new mm object and returns a handle to it.
ebcb40298947bdb Matthew Auld 2021-04-29  404   * @dev: drm device pointer
ebcb40298947bdb Matthew Auld 2021-04-29  405   * @data: ioctl data blob
ebcb40298947bdb Matthew Auld 2021-04-29  406   * @file: drm file pointer
ebcb40298947bdb Matthew Auld 2021-04-29  407   */
ebcb40298947bdb Matthew Auld 2021-04-29  408  int
ebcb40298947bdb Matthew Auld 2021-04-29  409  i915_gem_create_ext_ioctl(struct drm_device *dev, void *data,
ebcb40298947bdb Matthew Auld 2021-04-29  410  			  struct drm_file *file)
ebcb40298947bdb Matthew Auld 2021-04-29 @411  {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
