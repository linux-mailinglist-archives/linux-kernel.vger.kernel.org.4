Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9591A6D3515
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 02:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDBAiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 20:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 20:38:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216EA5C6;
        Sat,  1 Apr 2023 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680395928; x=1711931928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTSvSuJZHP7riTVhzk3BSd8g6ONdydlSKSHTjFQslcI=;
  b=eFwPU0DlOARIUqPD2Cq4vU8ACzCczxe1fLtHptjUtb/hhCVKZxRdtj7u
   PdTwdobbY0aCDXAWJMmbuCFB8YWe1Gg8XF037frRJ0f4LO8LrsjCCEAp7
   P1tHaF8eecIafY1zwT03wtr6M1bY1UfUWpVe9ngIsr+FJBOc0gaLrTXmU
   zKAaviXgfyPAUu4eHsFI+uNYj72PBrQBWFHGI3UC/1zqOm8/a6qxl3No5
   7MvHdHIoTtnh5XN+DNruBdYDFuCSf0MUjQw3KJDFqFO3aM36ccbSIbVRR
   ZgA9LSOWZGb/LBAyS9Ggtl0fbycwbSJW15qvU4lIGmmUYEkCQXIXAYxd+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="341709326"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="341709326"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 17:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="715852649"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="715852649"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2023 17:38:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pilk4-000N8l-1W;
        Sun, 02 Apr 2023 00:38:44 +0000
Date:   Sun, 2 Apr 2023 08:37:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        v9fs-developer@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH] fs/9p: Rework cache modes and add new options to
 Documentation
Message-ID: <202304020858.JARvGo8W-lkp@intel.com>
References: <20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 1543b4c5071c54d76aad7a7a26a6e43082269b0c]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Van-Hensbergen/fs-9p-Rework-cache-modes-and-add-new-options-to-Documentation/20230402-071815
base:   1543b4c5071c54d76aad7a7a26a6e43082269b0c
patch link:    https://lore.kernel.org/r/20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a%40kernel.org
patch subject: [PATCH] fs/9p: Rework cache modes and add new options to Documentation
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230402/202304020858.JARvGo8W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8d563b947e70b7fe9a067ef3be10471a05452505
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-Van-Hensbergen/fs-9p-Rework-cache-modes-and-add-new-options-to-Documentation/20230402-071815
        git checkout 8d563b947e70b7fe9a067ef3be10471a05452505
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/9p/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020858.JARvGo8W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/9p/vfs_inode.c: In function 'v9fs_evict_inode':
>> fs/9p/vfs_inode.c:375:16: warning: variable 'version' set but not used [-Wunused-but-set-variable]
     375 |         __le32 version;
         |                ^~~~~~~
   fs/9p/vfs_inode.c: In function 'v9fs_vfs_atomic_open':
>> fs/9p/vfs_inode.c:799:28: warning: variable 'v9inode' set but not used [-Wunused-but-set-variable]
     799 |         struct v9fs_inode *v9inode;
         |                            ^~~~~~~
--
   fs/9p/vfs_inode_dotl.c: In function 'v9fs_vfs_setattr_dotl':
>> fs/9p/vfs_inode_dotl.c:541:35: warning: variable 'v9ses' set but not used [-Wunused-but-set-variable]
     541 |         struct v9fs_session_info *v9ses;
         |                                   ^~~~~


vim +/version +375 fs/9p/vfs_inode.c

2bad8471511ce5 Eric Van Hensbergen 2005-09-09  366  
60e78d2c993e58 Abhishek Kulkarni   2009-09-23  367  /**
bc868036569e1d David Howells       2021-10-04  368   * v9fs_evict_inode - Remove an inode from the inode cache
60e78d2c993e58 Abhishek Kulkarni   2009-09-23  369   * @inode: inode to release
60e78d2c993e58 Abhishek Kulkarni   2009-09-23  370   *
60e78d2c993e58 Abhishek Kulkarni   2009-09-23  371   */
b57922d97fd6f7 Al Viro             2010-06-07  372  void v9fs_evict_inode(struct inode *inode)
60e78d2c993e58 Abhishek Kulkarni   2009-09-23  373  {
6b39f6d22fbf67 Aneesh Kumar K.V    2011-02-28  374  	struct v9fs_inode *v9inode = V9FS_I(inode);
93c846143d8630 David Howells       2020-11-18 @375  	__le32 version;
6b39f6d22fbf67 Aneesh Kumar K.V    2011-02-28  376  
4ad78628445d26 Al Viro             2015-12-08  377  	truncate_inode_pages_final(&inode->i_data);
93c846143d8630 David Howells       2020-11-18  378  	version = cpu_to_le32(v9inode->qid.version);
8d563b947e70b7 Eric Van Hensbergen 2023-04-01  379  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
