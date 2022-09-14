Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91F5B85F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiINKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiINKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:10:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72417059;
        Wed, 14 Sep 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663150198; x=1694686198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nDq1Jq+CBdwiqeg0WoX/BodjNBVR/c2opxgpCEwHwLo=;
  b=a611p2sxzkoOesMM+3zXI8JB7/lHb/lydKmwJ5CNnv2v35FUxWgHDHnL
   5R3qXQQzbJHcN0ZU3OI2KqHbMHjpSd2q5UH+iVOH2TdsgX5Rt6Ewa0T0z
   wFQg6K280edoT+0ph9EwZD3wmYi6rJPEU2ypG+XFE+HNJmtN6AAKfTS43
   aP/rd29t3z0c9rX0u/8al2oeAWXboiyHBdYly5Q1GEicecWxJv47HunqB
   kqH/g/YDM22RPo028uuUgJO499nifRT9caOEClX8CmVDYZ2+u2eNGxSOR
   AzBKIRF0caYxIS4UQ17a6olpj52x3qo36WcjZC8MMbftZw+xOd5O4mhD9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="360130832"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="360130832"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 03:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594325009"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 03:09:57 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYPLA-00005a-0o;
        Wed, 14 Sep 2022 10:09:56 +0000
Date:   Wed, 14 Sep 2022 18:09:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 16/22] drivers/dax/mapping.c:646:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202209141710.pI0d0v9N-lkp@intel.com>
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

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   e27a0356de15f16934325784c6b1d89cf0f13458
commit: 155ac6b670cf6385f6dd14910560d569560af889 [16/22] devdax: Move address_space helpers to the DAX core
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220914/202209141710.pI0d0v9N-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=155ac6b670cf6385f6dd14910560d569560af889
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 155ac6b670cf6385f6dd14910560d569560af889
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dax/mapping.c:646: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return NULL if the entry is zapped and all pages in the entry are


vim +646 drivers/dax/mapping.c

   644	
   645	/**
 > 646	 * Return NULL if the entry is zapped and all pages in the entry are
   647	 * idle, otherwise return the non-idle page in the entry
   648	 */
   649	static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
   650	{
   651		struct page *ret = NULL;
   652		unsigned long pfn;
   653		bool zap;
   654	
   655		if (!dax_entry_size(entry))
   656			return NULL;
   657	
   658		zap = !dax_is_zapped(entry);
   659	
   660		for_each_mapped_pfn(entry, pfn) {
   661			struct page *page = pfn_to_page(pfn);
   662	
   663			if (zap)
   664				page_ref_dec(page);
   665	
   666			if (!ret && !dax_page_idle(page))
   667				ret = page;
   668		}
   669	
   670		if (zap)
   671			dax_zap_entry(xas, entry);
   672	
   673		return ret;
   674	}
   675	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
