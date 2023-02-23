Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49B36A0623
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjBWK0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjBWK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:26:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1E726863;
        Thu, 23 Feb 2023 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147984; x=1708683984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yk1mjkoR0tSeW0gPd6MGxEf6ev0w+CVpivJhqFa1wX0=;
  b=kOg9xhvcL6zSOCRfPdYKXNILIrSpiezeY+KPziyU71Gb9FOXa6rNgYHS
   Sg4O112DNdfWj+sq51it4ieR4LCCq3jUGpQQnZUmS0oeCCAm49haSGN2l
   g28cK5EqdLD5odgeAHLawTcYDnrcUKrv31/CKQbusaaqPKd+G5rSjJOyW
   L5STihkNO/aVpxDmjnagHsHLpPgWFQ2wTF7lDL73e/7H/x0qwfVzUHt5T
   q5xyfUSZR+VQlh/hXu9dm/vDw6yCn41mcUNPApwyqKSB/VZMoS/4y3w6f
   /QTVhLeQEmmAm2+/+ZPCMcIIDKopg6D7QSyay1gKinsclO/p/cjk6VYrI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313545701"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="313545701"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="649912023"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="649912023"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2023 02:25:56 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV8nU-0001G1-01;
        Thu, 23 Feb 2023 10:25:56 +0000
Date:   Thu, 23 Feb 2023 18:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: htmldocs: Warning: Documentation/mm/hugetlbfs_reserv.rst references
 a file that doesn't exist: Documentation/mm/hugetlbpage.rst
Message-ID: <202302231854.sKlCmx9K-lkp@intel.com>
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
commit: ee86588960e259760236a537323d5c7d945e378c docs/mm: remove useless markup
date:   3 weeks ago
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee86588960e259760236a537323d5c7d945e378c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee86588960e259760236a537323d5c7d945e378c
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231854.sKlCmx9K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/mm/hugetlbfs_reserv.rst references a file that doesn't exist: Documentation/mm/hugetlbpage.rst
>> Warning: Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst references a file that doesn't exist: Documentation/mm/hugetlbpage.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
