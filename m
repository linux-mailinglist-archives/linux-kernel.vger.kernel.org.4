Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE906F3D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjEBFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjEBFiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:38:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F77E52;
        Mon,  1 May 2023 22:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683005895; x=1714541895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IbzAOE6Ia8T4XdxydP/sh8DuUMvMcKuaOuf20lN87z4=;
  b=XMNbqxsImiCusydzRTolLYdiBQZvoLyAjsXwGMQpY4qzeRlwvAIyCwoi
   dJnqwvb6z4FbeGxTrGIKMIiFZETeGP8YX3xMw3i/t/1zIfaREtCj3ooPU
   A1XI9H6A/q/eIyFPZb7jOiG0K+F7bfFsguL0M/O8rc34cndUnumk6TKHO
   2tY2WbI9XxfwL6+TR/jkLdJUjBuH27uT8I0TeAFoIJS7Z5hhTlHDSA06r
   aSv3obMPHz/A7DaHCbneap7wjje/pDyyDQnfm0a2M+iRJ0VEkq2bWxEm4
   jxxUPTUEfb1KeZ7PmQ1Zg0VnJyyDmH6drz1cVVOyS6FMwdVSx4abB4pBU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="351292743"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="351292743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 22:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="785545764"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="785545764"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 May 2023 22:38:14 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptiiL-0000s6-0Z;
        Tue, 02 May 2023 05:38:13 +0000
Date:   Tue, 2 May 2023 13:37:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] docs: consolidate human interface subsystems
Message-ID: <202305021306.dKifEdb7-lkp@intel.com>
References: <20230501154258.277866-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501154258.277866-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Costa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Costa-Shulyupin/docs-consolidate-human-interface-subsystems/20230501-234438
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20230501154258.277866-1-costa.shul%40redhat.com
patch subject: [PATCH v2] docs: consolidate human interface subsystems
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/2df620e4b9e2c2827f8a5519f6c266e9e5ef85be
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Costa-Shulyupin/docs-consolidate-human-interface-subsystems/20230501-234438
        git checkout 2df620e4b9e2c2827f8a5519f6c266e9e5ef85be
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305021306.dKifEdb7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/subsystem-apis.rst:14: WARNING: Title underline too short.

vim +14 Documentation/subsystem-apis.rst

    12	
    13	Human interfaces
  > 14	---------------
    15	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
