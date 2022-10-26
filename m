Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651A060DA52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiJZEdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZEdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:33:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B5A2A9E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666758820; x=1698294820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dTw6k1BsnVW54JWpsv8AsuykuI8Z5UcNM6TrRPbeBl8=;
  b=DP4wdWqYAUsOvP0N/rtCzgQb+8W+rEnAcruGhlgwgH/WffT+AqHwOUGA
   3aCWyKtMdKCqBofMmP3ZriK9rtXYUseOfB5Z5+dwmmGuLEOm80nWTm8k1
   Plp0xbZUsHFtn+VugFlJZgfjsRiGLw4klDPlOyARk7gveWO5nK9spm2oR
   sAzX2eHOQ/T61mQyyc3RD+aGdWphI8dgIsLLp9Ioj/vMdpuA04TUVchrE
   +KZcMUGLd/lQb+G7rjhIPu/cGGQqlL8/q7aB/E7ca4+22LDnuNYnHgida
   D06geq8EXhNyUxrQK3GkWF0GxDxGcDMfHb0ZliJL3iXFM1Cr/W2G8gZO9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334470503"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="gz'50?scan'50,208,50";a="334470503"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 21:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="806913121"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="gz'50?scan'50,208,50";a="806913121"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2022 21:33:37 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onY6j-00070N-0W;
        Wed, 26 Oct 2022 04:33:37 +0000
Date:   Wed, 26 Oct 2022 12:33:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7935/9135] signal.c:undefined
 reference to `uml_pm_wake'
Message-ID: <202210261222.GYUo74MX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o9BMTZH73blnETUQ"
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o9BMTZH73blnETUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   b4f4370de958b2655d6a93d4fc386eed8fe36cd6
commit: b58294ce1a8ac8e234abd991255b1d1905520aed [7935/9135] um: Allow PM with suspend-to-idle
config: um-allnoconfig (attached as .config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b58294ce1a8ac8e234abd991255b1d1905520aed
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout b58294ce1a8ac8e234abd991255b1d1905520aed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: arch/x86/um/checksum_32.o: missing .note.GNU-stack section implies executable stack
   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
   /usr/bin/ld: arch/um/os-Linux/signal.o: in function `sigusr1_handler':
>> signal.c:(.text+0x211): undefined reference to `uml_pm_wake'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--o9BMTZH73blnETUQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
f9UE60EAAA==

--o9BMTZH73blnETUQ--
