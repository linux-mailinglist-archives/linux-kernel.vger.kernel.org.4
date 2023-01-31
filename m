Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74691682629
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjAaIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjAaIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:10:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927E2CFF7;
        Tue, 31 Jan 2023 00:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675152646; x=1706688646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SZg+ATBpQouuriYsZdGoO7xxdxxxXNbSQpPCmxzri1E=;
  b=OORWhdbu8nx1AVDDNlBL6+b+x/kXzRd2jN3Jbt903W1swyuPRw8uLaWW
   EgJWCGUw/vaHFYYq9xSNRPi8k28qq3MfrJRNXGqaL7VfZEMsNyOZx/og4
   m7OATk3aDPqU0OFL8DPbpIRobrfBgk/bP6DZ25pr1OGg1BqturCX4/edv
   UGEaGqRzKXamM1RbTViqDMSdd97GZde9U1er86WWSo3GujvWZ4BmRm2LG
   37Y7dvi9OqWLj4CBvHxDEq1Wi03dBeSxI9XomzPDKZhW3dNi9zbJwbMDQ
   bAymg8XaFO38MW9v4pCfv6C2Ip/L7I+PU2FdwLUb0HQH6OBCAB8Ayitgp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326442606"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326442606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 00:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="838282611"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="838282611"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2023 00:10:43 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMlj1-0004IE-0p;
        Tue, 31 Jan 2023 08:10:43 +0000
Date:   Tue, 31 Jan 2023 16:10:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: Re: [PATCH 1/2] docs/admin-guide/mm: remove useless markup
Message-ID: <202301311643.qUUNW7oe-lkp@intel.com>
References: <20230129075018.207678-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129075018.207678-2-rppt@kernel.org>
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
patch link:    https://lore.kernel.org/r/20230129075018.207678-2-rppt%40kernel.org
patch subject: [PATCH 1/2] docs/admin-guide/mm: remove useless markup
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/2e25559918a12ca208ce26ac82fc538d05dde591
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Rapoport/docs-admin-guide-mm-remove-useless-markup/20230129-155123
        git checkout 2e25559918a12ca208ce26ac82fc538d05dde591
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/mm/physical_memory.rst:61: WARNING: undefined label: admin_guide_memory_hotplug (if the link has no caption the label must precede a section header)
>> Documentation/translations/zh_CN/admin-guide/mm/index.rst:24: WARNING: undefined label: mm_concepts (if the link has no caption the label must precede a section header)
>> Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst:18: WARNING: undefined label: hugetlbpage (if the link has no caption the label must precede a section header)
>> Documentation/translations/zh_CN/mm/numa.rst:76: WARNING: undefined label: numa_memory_policy (if the link has no caption the label must precede a section header)

vim +24 Documentation/translations/zh_CN/admin-guide/mm/index.rst

72e1bfd1b8e9d7 xu xin 2022-03-10  23  
72e1bfd1b8e9d7 xu xin 2022-03-10 @24  Linux内存管理有它自己的术语，如果你还不熟悉它，请考虑阅读下面参考：
72e1bfd1b8e9d7 xu xin 2022-03-10  25  :ref:`Documentation/admin-guide/mm/concepts.rst <mm_concepts>`.
72e1bfd1b8e9d7 xu xin 2022-03-10  26  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
