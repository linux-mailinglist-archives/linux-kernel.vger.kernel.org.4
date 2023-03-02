Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D166A7A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCBDvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:51:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466741EFCA;
        Wed,  1 Mar 2023 19:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677729061; x=1709265061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=toBA4mc3ny1aMwi4RV7M4RKtYQeEFpm2ZaTseCjz1HA=;
  b=Un9KSPZYfaN8vZfMoCRi11Qiodhe7yB2HQwOgYVdlhiAOidYQEzJcnYW
   skR67Mb2IAeb1vzHORmpBNYteavc70h3y/rMQ/53ymkQGA05GdQ3X5uVg
   R1yKGc6qWem8n6xwo9Rca+ucCXgxVbJAUJW4Bvxf1HaV9tufG5bU+JReN
   tWCE8z0yxDt1UVelIsDUKTVi1UfQNBGh7Mx6Z69PYe0ssGil6MdD9QWFJ
   jCD6u5hcrA0TlS9WkOaQbkkDWES9Kyjxws6pnHL/KabTjrKsTsH6vb1KE
   Cjl1sl4qnxlpIEHg88JTMn7ClR+qDzCSC6VTtZpymCB1cQ6C/akkx6RKk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="399394451"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="399394451"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 19:51:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="707263515"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="707263515"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2023 19:50:59 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXZy6-0000Ab-2O;
        Thu, 02 Mar 2023 03:50:58 +0000
Date:   Thu, 2 Mar 2023 11:50:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/16] dma-buf/sync_file: Surface sync-file uABI
Message-ID: <202303021119.RAl7HvmC-lkp@intel.com>
References: <20230228225833.2920879-6-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228225833.2920879-6-robdclark@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on drm-intel/for-linux-next-fixes drm/drm-next linus/master v6.2 next-20230301]
[cannot apply to drm-misc/drm-misc-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Clark/dma-buf-dma-fence-Add-deadline-awareness/20230301-070358
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
patch link:    https://lore.kernel.org/r/20230228225833.2920879-6-robdclark%40gmail.com
patch subject: [PATCH v8 05/16] dma-buf/sync_file: Surface sync-file uABI
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/b13821931cc3898065e4264fad78bad23c7d2208
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rob-Clark/dma-buf-dma-fence-Add-deadline-awareness/20230301-070358
        git checkout b13821931cc3898065e4264fad78bad23c7d2208
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303021119.RAl7HvmC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./include/uapi/linux/sync_file.h:82: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

vim +82 ./include/uapi/linux/sync_file.h

64907b94dab947 drivers/staging/android/uapi/sync.h Colin Cross     2014-02-17  80  
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26  81  /**
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26 @82   * Opcodes  0, 1 and 2 were burned during a API change to avoid users of the
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26  83   * old API to get weird errors when trying to handling sync_files. The API
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26  84   * change happened during the de-stage of the Sync Framework when there was
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26  85   * no upstream users available.
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26  86   */
2d75c88fefb228 drivers/staging/android/uapi/sync.h Gustavo Padovan 2016-04-26  87  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
