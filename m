Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4686B98CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCNPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjCNPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:16:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9443D910;
        Tue, 14 Mar 2023 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678806968; x=1710342968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2rqT3CeZIAN6S64dIuFFBFFTOixUjZD0EjEoloUfSXw=;
  b=TVe2VxDgDtlGGE3uAAcgrlCE7y1vAwZMsdah8DeV/CDXm0l/1KKqWyHL
   8BL6Xl4zC3far2yBJt2dKIcgXLnrLGqFZuKwxvaq9NZLcnZCLr+oQ2xKJ
   48oGd83iajq2B3GmmLULrRNuqwGiJwHbh4lW0aGHa7iEBHg5Zr319ux4L
   FrBQVa1McSgAYTAngDm6QxwmypMwfRmMhTGIU+3ewcYVars8NVS5kaZXd
   dQ5rpH3rNr6t0Y1Uq841VrreO3eFLZNONOu+c/aiI9s7mNWEhrDv77Xm2
   1ji2Zt59WHrbBPMss93xJfET2Wecx5jwXGJ98Ox2+nariiaLe2DVYxYU9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="325815683"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="325815683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="711552927"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="711552927"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2023 08:15:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pc6My-003Hh3-0v;
        Tue, 14 Mar 2023 17:15:20 +0200
Date:   Tue, 14 Mar 2023 17:15:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com,
        linus.walleij@linaro.org
Subject: Re: [PATCHv3 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZBCPiJwVoe9gw2X8@smile.fi.intel.com>
References: <20230301142835.19614-3-m.zatovic1@gmail.com>
 <202303020615.0F00suDa-lkp@intel.com>
 <CAPGNi97oc+tSrt-NF4KZhcEyUfZTo4PT0ms8zYSFVEyzOBq4ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPGNi97oc+tSrt-NF4KZhcEyUfZTo4PT0ms8zYSFVEyzOBq4ZA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:34:40PM +0100, Martin Zaťovič wrote:
> Thank you for the code review Andy!

I'm not sure why you mentioned this in the reply to kernel build bot
message.

> Regarding the OF only code - I have been told, that implementing my own ID
> table
> so that a device can be added from another driver is no longer the way to
> go.
> The only other option I can think of is ACPI device enumeration, which I
> did not
> implement as I really believe that Wiegand will only be used on embedded
> devices.
> 
> Despite that I respect the message - the code should be agnostic and count
> with
> every option so I will add ACPI support. Is there any other way of
> instantiating
> devices I am not aware of?

This is also seems to me unrelated to this message. Can you reply to
the correct message with enough context, please?

> st 1. 3. 2023 o 23:53 kernel test robot <lkp@intel.com> napísal(a):
> 
> > Hi Martin,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on robh/for-next]
> > [also build test ERROR on linus/master v6.2 next-20230301]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:
> > https://github.com/intel-lab-lkp/linux/commits/Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230301-223030
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> > for-next
> > patch link:
> > https://lore.kernel.org/r/20230301142835.19614-3-m.zatovic1%40gmail.com
> > patch subject: [PATCHv3 2/4] wiegand: add Wiegand bus driver
> > config: sh-allmodconfig (
> > https://download.01.org/0day-ci/archive/20230302/202303020615.0F00suDa-lkp@intel.com/config
> > )
> > compiler: sh4-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         #
> > https://github.com/intel-lab-lkp/linux/commit/c62b833f42989e355d82cd20b7803e0228e33792
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review
> > Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230301-223030
> >         git checkout c62b833f42989e355d82cd20b7803e0228e33792
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross
> > W=1 O=build_dir ARCH=sh olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross
> > W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/wiegand/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link:
> > https://lore.kernel.org/oe-kbuild-all/202303020615.0F00suDa-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/wiegand/wiegand.c:441:27: error: initialization of 'void
> > (*)(struct device *)' from incompatible pointer type 'int (*)(struct device
> > *)' [-Werror=incompatible-pointer-types]
> >      441 |         .remove         = wiegand_remove,
> >          |                           ^~~~~~~~~~~~~~
> >    drivers/wiegand/wiegand.c:441:27: note: (near initialization for
> > 'wiegand_bus_type.remove')
> >    cc1: some warnings being treated as errors
> >
> >
> > vim +441 drivers/wiegand/wiegand.c
> >
> >    436
> >    437  static struct bus_type wiegand_bus_type = {
> >    438          .name           = "wiegand",
> >    439          .match          = wiegand_match_device,
> >    440          .probe          = wiegand_probe,
> >  > 441          .remove         = wiegand_remove,
> >    442  };
> >    443
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
> >

-- 
With Best Regards,
Andy Shevchenko


