Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A96745F86
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGCPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGCPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:10:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746F1A8;
        Mon,  3 Jul 2023 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688397028; x=1719933028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zq4TPE/ConExquqFCC1NYBoUWWFuvgyzWL4EOSrGXpA=;
  b=MteHHtkMYgyzuKJ+dmPW67aVL437C4Ms16ntADlJDHCqr0E51eeRlUCa
   nfmcQAbYw+7KoPxHSxg8G0YYh289kAyOuGhVKqU7v6FW7+Ue5KoZaHKXM
   nToroxNyrUgNUt2OQ/4CJsYNPme6X8hyOCtq752SNqxGPNa7/nVhJkj9s
   GFVBmCYzTQKAxfcnQvkS7VUidFnTDemN+i0UqM1+UoDeh6Pa8w7XVYw+D
   CTwFAIKf6Sdxr+wRzeR2xN2l+HV8QNM7snq/0Lm1Kf01I8pwXqJarDL3m
   FCEjaTc8hKKzYxpLYJ+HUx4oVI3+3rfIOEQuteGvh9DLjyIbHrRIEhF/s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393646570"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393646570"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831859555"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831859555"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 08:10:13 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGLBs-000HR5-2E;
        Mon, 03 Jul 2023 15:10:12 +0000
Date:   Mon, 3 Jul 2023 23:09:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5] HID: steelseries: Add support for Arctis 1 XBox
Message-ID: <202307032208.b5brKeCt-lkp@intel.com>
References: <20230703102918.9941-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703102918.9941-1-hadess@hadess.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastien,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v6.4 next-20230703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/HID-steelseries-Add-support-for-Arctis-1-XBox/20230703-183124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230703102918.9941-1-hadess%40hadess.net
patch subject: [PATCH v5] HID: steelseries: Add support for Arctis 1 XBox
config: parisc-randconfig-r032-20230703 (https://download.01.org/0day-ci/archive/20230703/202307032208.b5brKeCt-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307032208.b5brKeCt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307032208.b5brKeCt-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/hid/hid-steelseries.o: in function `.LC10':
>> hid-steelseries.c:(.rodata.cst4+0x8): undefined reference to `hid_is_usb'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
