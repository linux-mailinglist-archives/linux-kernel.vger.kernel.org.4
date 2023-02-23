Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510816A028E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjBWFt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjBWFty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:49:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E413D4B;
        Wed, 22 Feb 2023 21:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677131393; x=1708667393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2BvGZOyrRV/ARB/RLRFOzlYyTNSknOt2HV3K4OfnmfU=;
  b=e0rjd4RXme5rN+ihan2Z6hC8xUFUPBGnVsvW+rUUrbgBTdjsXCRHMA3x
   1fBNKtWOI2oeAnjVRseyF2hrr9jpaWEg9oHMEftArwlaJfAXvDb6cqu0t
   kEEnH/cr2IH6OOVnqIfl+A7vgk1UGN25/Jvw7eLxf9FiuqdLl/zvyR66l
   Rd15v3jk7AiyJ/goHs90CEmtwuJLhZUzr6XsBOuKfSoyOMKWGgRSmIFuP
   3lSC2nbgCzE/ERT6WYE15Xoy7YrcENkZ4YRNZ7SGJvFk83YJ7epJVfyJO
   DW7Y56WvAdd0cFavS79m94Wt6DT+bHx2ensiHkn7O0XihsFAypV3uzngz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="395603334"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="395603334"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 21:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="741137139"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="741137139"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2023 21:49:50 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV4UH-000169-2k;
        Thu, 23 Feb 2023 05:49:49 +0000
Date:   Thu, 23 Feb 2023 13:48:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: htmldocs: Warning: Documentation/mm/physical_memory.rst references a
 file that doesn't exist: Documentation/admin-guide/mm/memory_hotplug.rst
Message-ID: <202302231311.567PAoS2-lkp@intel.com>
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
head:   a5c95ca18a98d742d0a4a04063c32556b5b66378
commit: 353c7dd636ed12fdaedea782de612aceb1923ed9 docs/mm: Physical Memory: remove useless markup
date:   3 weeks ago
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=353c7dd636ed12fdaedea782de612aceb1923ed9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 353c7dd636ed12fdaedea782de612aceb1923ed9
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231311.567PAoS2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/mm/physical_memory.rst references a file that doesn't exist: Documentation/admin-guide/mm/memory_hotplug.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
