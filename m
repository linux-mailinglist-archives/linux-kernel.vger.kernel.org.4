Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1335E5B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIVGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIVGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:39:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3146B6D00;
        Wed, 21 Sep 2022 23:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663828746; x=1695364746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=obk4N+2lv46lmCRfrPLcAtsdnjc8XXyT+8+jHw3SMic=;
  b=YU/TiJHkLKv1984Y/ziaVByCK2ngNc0ucKYHfv91KHgYi6qxi7eSZuc/
   tsV0vKUktYLFx6xcPYPXkD4CbfUjWYcPZDwW91wkxVo40T7o1i6dKQ1io
   hj78ITCp52qT45crNAWjeuCCvGCFGe5chIR+OogAjpuWE6kXM8qE2ZOI4
   z2/55hsIjkfHwOwjLOz2QqTluU7e2lGWj7ZA3F7QhTXPA1k7inj16NVuA
   jrxhg1UtwYE15dq+Uf4lttIONUJPcrTHbdNx8AuDbRZ9lWJUrApqCmO4+
   ropdX6oZ3o2p459F8bjYYD2Fqf3rRnPhYqcTjo7V4z7O6B+8q9hZy8wdR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300199744"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="300199744"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 23:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="650394136"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Sep 2022 23:39:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obFrT-0004OO-2X;
        Thu, 22 Sep 2022 06:39:03 +0000
Date:   Thu, 22 Sep 2022 14:38:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        linux-doc@vger.kernel.org
Subject: htmldocs: Warning:
 Documentation/translations/zh_CN/devicetree/changesets.rst references a file
 that doesn't exist: Documentation/Devicetree/changesets.rst
Message-ID: <202209221415.peH8XStP-lkp@intel.com>
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

tree:   git://git.lwn.net/linux.git docs-next
head:   a8249d62a611f398fafebbb8f6129888e98d5354
commit: 702f436ab07b88a778ced4561ad62dadb7c919c9 docs/zh_CN: add dt changesets translation
date:   10 hours ago
reproduce:
        git remote add lwn git://git.lwn.net/linux.git
        git fetch --no-tags lwn docs-next
        git checkout 702f436ab07b88a778ced4561ad62dadb7c919c9
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/translations/zh_CN/devicetree/changesets.rst references a file that doesn't exist: Documentation/Devicetree/changesets.rst

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
