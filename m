Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410596D3417
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjDAVcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:32:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27139EFD;
        Sat,  1 Apr 2023 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680384763; x=1711920763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hm6iKi12m6qOMRGW9i867PuVG7qZH1Ke4QnQNHTAwaY=;
  b=PUPw8Cqr16gT3s37Qmz7dGs0XkxwbtemS1m5t8tpw3WghS0Z+Euo5D0W
   fT0edPNsIz/+wSijX9newCCyHAwjfaXV+DxXtXyAQJix5wFSrpuYaMz3n
   XWws6ia8mZBUgNAKB3Ph4jxrWB7eJAxuw67IWAa2SbfqX3f20fEvqXydy
   fV70Kub3Jzk1voVt0vELkMcoz1/RcUjZLqPLFxBnoAwXkuQfz5qHMctD2
   SgPBLtYX0dQqeWZl3GmsoAOM8bxayQ5RZ/Oj7ow0cyX5BJ/ItAYL1o4Ju
   VtqtcTb3wqa2SrY2PoAq8AB7wTIorck8T3aXZ7QZSprTV1ExZhtog6Ja6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="369483028"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="369483028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 14:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="715826777"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="715826777"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2023 14:32:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piipz-000N3p-2F;
        Sat, 01 Apr 2023 21:32:39 +0000
Date:   Sun, 2 Apr 2023 05:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add Honeywell mpr sensor
Message-ID: <202304020552.JHWqEIwX-lkp@intel.com>
References: <ZCf1B9kfw/N0UX8Q@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCf1B9kfw/N0UX8Q@arbad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mpr-sensors/20230401-171226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/ZCf1B9kfw%2FN0UX8Q%40arbad
patch subject: [PATCH 3/3] MAINTAINERS: Add Honeywell mpr sensor
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/a6d0553e9b84f7572a2808e9d4653957e6bd27cf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mpr-sensors/20230401-171226
        git checkout a6d0553e9b84f7572a2808e9d4653957e6bd27cf
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020552.JHWqEIwX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/pressure/mpr.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
