Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32FF683229
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjAaQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAaQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:04:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9681853991;
        Tue, 31 Jan 2023 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675181044; x=1706717044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rPmI8NFTKFtV4xhsN35E9c3s3k7pVuZjYYwYdF5DF30=;
  b=LDMKGYSusNQu7dWju4CxvYi7Q8F2k8+TRE8RGANfkMbWOQ2RkCV9TcMf
   y4SR2c3M0HeSA6Mg2ynbqjkjfim7W3PXAeUGvNKMRF9yU1xNNwXUZjGCP
   0drPfjrohTgKy5Lr3vPnKiIniDMNEq94zJAube1T4nKsmtEH3yMBJCmDQ
   m5FeOK5LOzkrus83sHPR3CAFPFbopmBxd8nN5UlKzx874IO4sxmBsRkUR
   kOWHrqoIwq5O2fShtplNrefAgxlCtsHkwjKfpfKcvBXI7ehevkdj0Xnk0
   GQP1FmYaCN/96bnHsslF2ITg41sRCFtextKDGSiEGrn5pz9EpJuddAJM+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326539386"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="326539386"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="733164535"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="733164535"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2023 08:02:59 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMt62-0004XC-2w;
        Tue, 31 Jan 2023 16:02:58 +0000
Date:   Wed, 1 Feb 2023 00:02:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: Re: [PATCH 2/2] docs/mm: remove useless markup
Message-ID: <202301312351.WrB0VfS9-lkp@intel.com>
References: <20230129075018.207678-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129075018.207678-3-rppt@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.2-rc6]
[cannot apply to akpm-mm/mm-everything next-20230131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Rapoport/docs-admin-guide-mm-remove-useless-markup/20230129-155123
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20230129075018.207678-3-rppt%40kernel.org
patch subject: [PATCH 2/2] docs/mm: remove useless markup
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/379db4d59bd650ce02960ca6a4ee2e7d3846452e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Rapoport/docs-admin-guide-mm-remove-useless-markup/20230129-155123
        git checkout 379db4d59bd650ce02960ca6a4ee2e7d3846452e
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/mm/hugetlbfs_reserv.rst references a file that doesn't exist: Documentation/mm/hugetlbpage.rst
>> Documentation/mm/physical_memory.rst:61: WARNING: undefined label: page_migration (if the link has no caption the label must precede a section header)
>> Documentation/translations/zh_CN/mm/hmm.rst:251: WARNING: undefined label: page_migration (if the link has no caption the label must precede a section header)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
