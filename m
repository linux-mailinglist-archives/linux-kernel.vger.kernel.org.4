Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76186BC73B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCPHcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCPHcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:32:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955FACBAE;
        Thu, 16 Mar 2023 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678951893; x=1710487893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRuPOGfZnu4JByDAsSat1lIPi/d4YuYFnKKqk6RPkbs=;
  b=Ui/p35oUu+km//R0LdE1K6YyvnNuQX+Z4MfWuYQEOsGyRgmXLiDrjEI7
   UXyB63a02rjXfcqmpdwX7Vq+nylF96/DK5luaefXaao+qP6AZbugHDsae
   KflEcbclu7ix14PcPhCi0kiJTl6rf1iogSp90U24qBrDDgK+tp8SxOzva
   t300Xh3hsCsdHulFgpdPuilKIPg+ugjyPh1o+v4TP7TyQkUvi7ptjMFtt
   HU+3kv0JNoVLFYEIOIopnLFadYkypqcMTBPodap5AOwCux/Wun7CQ5nZy
   9fa5DqOSy1TN/C3b02BwDNmg7HXtDUQ/8g/7PBMJYE3Z6KWszYiIIUyHk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="336606548"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="336606548"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679794068"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679794068"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 00:31:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pci56-0008PO-2a;
        Thu, 16 Mar 2023 07:31:24 +0000
Date:   Thu, 16 Mar 2023 15:30:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herve Codina via Alsa-devel <alsa-devel@alsa-project.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/7] Documentation: sysfs: Document the Lantiq PEF2256
 sysfs entry
Message-ID: <202303161547.ZzSQWnIQ-lkp@intel.com>
References: <167888779364.26.9200222608363841485@mailman-core.alsa-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167888779364.26.9200222608363841485@mailman-core.alsa-project.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on robh/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.3-rc2 next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina-via-Alsa-devel/drivers-misc-Add-support-for-the-Lantiq-PEF2256-framer/20230315-214833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/167888779364.26.9200222608363841485%40mailman-core.alsa-project.org
patch subject: [PATCH 3/7] Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/0140596e508d18933cd319314838bc802214b345
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Herve-Codina-via-Alsa-devel/drivers-misc-Add-support-for-the-Lantiq-PEF2256-framer/20230315-214833
        git checkout 0140596e508d18933cd319314838bc802214b345
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303161547.ZzSQWnIQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256:2: WARNING: Unexpected indentation.
>> Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256:2: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +2 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256

   > 2	KernelVersion:	6.4

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
