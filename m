Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F769EB98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBVADN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:03:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFFE1258B;
        Tue, 21 Feb 2023 16:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677024189; x=1708560189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=epyd3QksYFiJJ74Tc2rcXaGFKrh/A+RaElz44nVqtEU=;
  b=MlWEhRxTANYHTWweLm6qsbgGdWxcmAD6FmGQIRlM2991J3UduldBz2vt
   VAV0gIcG8b/SPNfb/vzAPlFJWjr2LBT7EkAzpoY3cRmGBrejSGCQ5FTRo
   6YvKEJc8MTgqZ898rLkccLPkNFDKC+g+ZUf9Fi4/XisMZu0JMW+8G+ZQ/
   emsZM0O/XHfJJYiEvmfK5kBQwzrFBb3AUnxsk9VA2mBkKt67BwejrAPoH
   znJx27aJJGlNSxVpxx06BfKFmw4bwY3LiL+Ro6sQ6utFDj3KEcN1dUYY1
   qcEZ/BE9VUTfs00S8IaZpveE5dYWr+mgSV0WER3cpogzDEvt0wAbWtsRJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334150616"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="334150616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 16:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="704251646"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="704251646"
Received: from lkp-server01.sh.intel.com (HELO eac18b5d7d93) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2023 16:02:51 -0800
Received: from kbuild by eac18b5d7d93 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUcaw-0000OH-03;
        Wed, 22 Feb 2023 00:02:50 +0000
Date:   Wed, 22 Feb 2023 08:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v5 2/2] trigger: ledtrig-tty: add additional modes
Message-ID: <202302220740.2RKDHnof-lkp@intel.com>
References: <20230221081901.15557-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221081901.15557-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus staging/staging-testing staging/staging-next staging/staging-linus pavel-leds/for-next linus/master v6.2 next-20230221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230221-162126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230221081901.15557-3-fe%40dev.tdt.de
patch subject: [PATCH v5 2/2] trigger: ledtrig-tty: add additional modes
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/445b7555bccd279bf106995ee42f5dbef2e97c8b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Eckert/tty-new-helper-function-tty_get_mget/20230221-162126
        git checkout 445b7555bccd279bf106995ee42f5dbef2e97c8b
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302220740.2RKDHnof-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-class-led-trigger-tty:9: WARNING: Unexpected indentation.
>> Documentation/ABI/testing/sysfs-class-led-trigger-tty:9: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +9 Documentation/ABI/testing/sysfs-class-led-trigger-tty

   > 9	Date:		January 2023

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
