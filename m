Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA37132CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 08:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjE0GW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE0GW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 02:22:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10742EC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 23:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685168545; x=1716704545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UEUfNo8vSQVHjoqAZjViTd9hunkPQrbIOmvUwlgY6jA=;
  b=XyDjs3obllbOyOPVLMXDC3BDY10MNkJliLmXhF9lhkSNYlu1MZb1MrRJ
   WkGgr3/ZEwLuCHmtJhzt0hsRbgw/putpYgOvFpv5JKADHX4/EKyuH7cZf
   LUYBfc8Pd+LwjDirIGA6SKuNpn66WLa7UguRMbmaeH7VWSe8NKvt4L8D1
   ZjTT3/t6IxnPuF1uGW2ngS6mNKn4DnROu0XdpRtwu2cpdDGFR/KYE4h4Q
   rWJ3xexkWL5DD8Z3P32ZZVGIyR1S1xk+1bl/YwgZJqbDQz6/UTSuKN7ZZ
   LucJOKv0HICk7+zGjXZTGTGvzfzG2Jj7TGsqwaei/2L+cDj1tMrcyel5a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="354383195"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="354383195"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 23:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="708628452"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="708628452"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2023 23:21:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2nJK-000JoS-1P;
        Sat, 27 May 2023 06:21:54 +0000
Date:   Sat, 27 May 2023 14:21:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve French <stfrench@microsoft.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/smb/client/ioctl.c:324:10: warning: variable 'caps' set but not
 used
Message-ID: <202305271421.pwX0wfIT-lkp@intel.com>
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

Hi Steve,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   49572d5361298711207ab387a6c318407deb963a
commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and server files to common directory fs/smb
date:   2 days ago
config: i386-randconfig-i054-20230527 (https://download.01.org/0day-ci/archive/20230527/202305271421.pwX0wfIT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=38c8a9a52082579090e34c033d439ed2cd1a462d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 38c8a9a52082579090e34c033d439ed2cd1a462d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/smb/client/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305271421.pwX0wfIT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/smb/client/ioctl.c:324:10: warning: variable 'caps' set but not used [-Wunused-but-set-variable]
           __u64   caps;
                   ^
   1 warning generated.


vim +/caps +324 fs/smb/client/ioctl.c

7ba3d1cdb7988c fs/cifs/ioctl.c Steve French    2021-05-02  312  
f9ddcca4cf7d95 fs/cifs/ioctl.c Steve French    2008-05-15  313  long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
^1da177e4c3f41 fs/cifs/ioctl.c Linus Torvalds  2005-04-16  314  {
496ad9aa8ef448 fs/cifs/ioctl.c Al Viro         2013-01-23  315  	struct inode *inode = file_inode(filep);
7e7db86c7e1088 fs/cifs/ioctl.c Steve French    2019-09-19  316  	struct smb3_key_debug_info pkey_inf;
^1da177e4c3f41 fs/cifs/ioctl.c Linus Torvalds  2005-04-16  317  	int rc = -ENOTTY; /* strange error - but the precedent */
6d5786a34d98bf fs/cifs/ioctl.c Pavel Shilovsky 2012-06-20  318  	unsigned int xid;
ba00ba64cf0895 fs/cifs/ioctl.c Jeff Layton     2010-09-20  319  	struct cifsFileInfo *pSMBFile = filep->private_data;
96daf2b09178d8 fs/cifs/ioctl.c Steve French    2011-05-27  320  	struct cifs_tcon *tcon;
a77592a70081ed fs/cifs/ioctl.c Ronnie Sahlberg 2020-07-09  321  	struct tcon_link *tlink;
d26c2ddd335696 fs/cifs/ioctl.c Steve French    2020-02-06  322  	struct cifs_sb_info *cifs_sb;
f654bac2227adc fs/cifs/ioctl.c Steve French    2005-04-28  323  	__u64	ExtAttrBits = 0;
618763958b2291 fs/cifs/ioctl.c Jeff Layton     2010-11-08 @324  	__u64   caps;

:::::: The code at line 324 was first introduced by commit
:::::: 618763958b2291a09057dbfa553da6ded93dcfad cifs: make cifs_ioctl handle NULL filp->private_data correctly

:::::: TO: Jeff Layton <jlayton@redhat.com>
:::::: CC: Steve French <sfrench@us.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
