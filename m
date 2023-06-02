Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7419271F8BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjFBDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFBDKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:10:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD141A7;
        Thu,  1 Jun 2023 20:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685675403; x=1717211403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6n29GT5zDRIzg7PRY9i2i6FcdkwF+KLEldJ1Q1w68bU=;
  b=MquP8uUyVWscG7l9Na7wbNqO5TlRdJQR6u63NzkGzTTJlpBmWs4dcsGF
   AXToozqlEP8leMJal0HtEFcroKsFk797mGfMPHCR6m3XMcKrLoqIuY9rU
   niLHq8QhfNy2BnWRAvdCDmH5ckrsRC6qTJUENVgLdr0kLiSCkWxK8FSE2
   Y/B2Yo80Lr+HXL10Sxky/Nzl40P/MhPE+Z1jSqva8wRw23qimThfs/C5Q
   bI4atKT0kR1lvQ7YmCQ8Unz/mwycKTe91nCRZpe+VaH8/GqvmAqpyCkQa
   Q0iXp4jpVSCyCXZtchsgFJLo9EvonaOiHr/YPrdNOyfR0vR8z9CKWpxZk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353246159"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="353246159"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 20:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="954284982"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="954284982"
Received: from lkp-server01.sh.intel.com (HELO d1d49124694e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 20:10:00 -0700
Received: from kbuild by d1d49124694e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4vAu-00001l-0w;
        Fri, 02 Jun 2023 03:10:00 +0000
Date:   Fri, 2 Jun 2023 11:09:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        keyrings@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, dhowells@redhat.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] certs/extract-cert: Fix checkpatch issues
Message-ID: <202306021102.zQU95cMI-lkp@intel.com>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601190508.56610-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Franziska,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7877cb91f1081754a1487c144d85dc0d2e2e7fc4]

url:    https://github.com/intel-lab-lkp/linux/commits/Franziska-Naepelt/certs-extract-cert-Fix-checkpatch-issues/20230602-030657
base:   7877cb91f1081754a1487c144d85dc0d2e2e7fc4
patch link:    https://lore.kernel.org/r/20230601190508.56610-1-franziska.naepelt%40gmail.com
patch subject: [PATCH] certs/extract-cert: Fix checkpatch issues
config: arm-randconfig-r046-20230531 (https://download.01.org/0day-ci/archive/20230602/202306021102.zQU95cMI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7fdfaec7a3c9f58676a5892e679d8bca319abd8a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Franziska-Naepelt/certs-extract-cert-Fix-checkpatch-issues/20230602-030657
        git checkout 7fdfaec7a3c9f58676a5892e679d8bca319abd8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021102.zQU95cMI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> certs/extract-cert.c:36:18: error: expected ';' before 'void'
      36 | static __noreturn
         |                  ^
         |                  ;
      37 | void format(void)
         | ~~~~              
>> certs/extract-cert.c:37:6: warning: no previous prototype for 'format' [-Wmissing-prototypes]
      37 | void format(void)
         |      ^~~~~~


vim +36 certs/extract-cert.c

    35	
  > 36	static __noreturn
  > 37	void format(void)
    38	{
    39		fprintf(stderr,
    40			"Usage: extract-cert <source> <dest>\n");
    41		exit(2);
    42	}
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
