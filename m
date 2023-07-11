Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B345074EB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGKJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGKJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:56:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE96A1;
        Tue, 11 Jul 2023 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689069361; x=1720605361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/f+ykgD0/00bi7s9VfR+ZWCB9q02eWktKsVZC95AV4=;
  b=YW9rZdgQxBi7gWLadRP6qG8+TjxfpZbX2QtUtKxk948Z+ajbXQytarDf
   +DTMZuEc4pygVCwl4sAMRGzQkOrpbyNpZcwXMjIrDIRjAZbrnR17Tl9no
   U29yBgVQT0xAKxgaDFY8AaonJE0Z2qgb+dkOSssH+RbW/3zAMkqOVLXhu
   qLaPTNykJ3VfTo/vytgIg3zMLhtehUSNr0buYZOn6ouCJr2OcdtkZgx2F
   S257R7u94ZI8m8vAWAXn9pV22lVYiCWLFsbDdbWHfmgUPc7j3cZriE9pw
   DmKm5juLZjo2KNUNZOyP1uwnL+EMCO4PRtaKNBbdeKX6jFghvyub6Jouj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="368075976"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368075976"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 02:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="715126919"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715126919"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 02:55:58 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJA69-0004hd-1f;
        Tue, 11 Jul 2023 09:55:57 +0000
Date:   Tue, 11 Jul 2023 17:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, corentin.chary@gmail.com,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH v2 8/8] platform/x86: asus-wmi: expose dGPU and CPU
 tunables for ROG
Message-ID: <202307111702.ErlUZY2B-lkp@intel.com>
References: <20230630053552.976579-9-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630053552.976579-9-luke@ljones.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc1 next-20230711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/platform-x86-asus-wmi-add-support-for-showing-charger-mode/20230630-133937
base:   linus/master
patch link:    https://lore.kernel.org/r/20230630053552.976579-9-luke%40ljones.dev
patch subject: [PATCH v2 8/8] platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307111702.ErlUZY2B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307111702.ErlUZY2B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-platform-asus-wmi:131: WARNING: Unexpected indentation.

vim +131 Documentation/ABI/testing/sysfs-platform-asus-wmi

 > 131	Date:		Jun 2023
   132	KernelVersion:	6.5
   133	Contact:	"Luke Jones" <luke@ljones.dev>
   134	Description:
   135			Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
   136			Shown on Intel+Nvidia or AMD+Nvidia based systems.
   137				* min=5, max=250
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
