Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202B6FFED2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbjELCOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjELCOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:14:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C41FD4;
        Thu, 11 May 2023 19:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683857676; x=1715393676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uP3qdeQwkNNyPV4cDI0woVqqifLQC8W3QFlpDqZ5rw=;
  b=F4RRofB/TqVdWNMqcWSV2VTr5oEbxfzszF4QI2BHmzFGYPjiHxrP9X0X
   AZf9XUZYJi+g+iDNlF2Ag1NRvT8SgstWCmrXl1bv5Yfn4dCDXxYzQWOfO
   sxZJJRlzAMzQstwT7B6Kxn1GHrZsz6o3kpaF8mE8VjphslFaA/h0u7CJD
   sd/R1rdK2AOJzpKwh4DWFPuESIe1cRA4iv/f1UVQJxvVkC8ijQQOMlgTs
   5e29YY1IbCtB57J8JN0ST01mRpglfoZoTjN5dfHsQr8628LaRqKmIlJPf
   qvN0SRxK4A+dBYULY2ykFiUemc5D5uXEdMEhZdwuTVEG5+JiBljIvE0UW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="437016856"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="437016856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 19:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730630998"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="730630998"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 19:14:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxIIj-0004Q8-0p;
        Fri, 12 May 2023 02:14:33 +0000
Date:   Fri, 12 May 2023 10:13:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: make header files self-including
Message-ID: <202305121044.Q88iF2NQ-lkp@intel.com>
References: <20230511123236.723025-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511123236.723025-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v6.4-rc1 next-20230511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-G-ttsche/selinux-make-header-files-self-including/20230511-203619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20230511123236.723025-1-cgzones%40googlemail.com
patch subject: [PATCH] selinux: make header files self-including
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230512/202305121044.Q88iF2NQ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b237d995d423baa5707fe9f59441d4744892eda
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-G-ttsche/selinux-make-header-files-self-including/20230511-203619
        git checkout 2b237d995d423baa5707fe9f59441d4744892eda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305121044.Q88iF2NQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from security/selinux/ibpkey.c:26:
>> security/selinux/include/ibpkey.h:18:10: fatal error: ../flask.h: No such file or directory
      18 | #include "../flask.h"
         |          ^~~~~~~~~~~~
   compilation terminated.


vim +18 security/selinux/include/ibpkey.h

    16	
    17	#include <linux/types.h>
  > 18	#include "../flask.h"
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
