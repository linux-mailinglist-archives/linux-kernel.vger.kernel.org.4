Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97F6A4EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjB0WvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjB0WvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:51:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F62701;
        Mon, 27 Feb 2023 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677538245; x=1709074245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8EQEDnNgik7vnpTEjnl9m5Ob62pXFbz6h8ZFZUz/KE=;
  b=k7CRWZMUHFfew86T0egTxu0AHaMtr2szeS4CgP/xUtv7Z6Ai0H1iZWqc
   zpzqjaysKYPRirefTuTMCq/z5FTh3uqHqvBP/uL/y/cjiBi7aNoB0QMSN
   56ROOdaK9SONsmYfkk8gDNDVQZjkHNqeduAMZSISUuGBYaf3I5XruNloL
   n6kzqzLsk0UezDv+AK4pM4jQ23oMxDQ7H8fC8wh9uf68gemVgtly5jgyp
   MJDZ/Ty1WQVzcmWQDz+jLHamadIauGdSD4LtKnHZgXC3P5ftvqFFmLKP0
   gVBQQ/zUSY9lcLaO421GMZEE0pwelYexDfD/lDuk4JGGAKUHQO6GjderC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313662027"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313662027"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:47:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="742737576"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="742737576"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 27 Feb 2023 14:47:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pWmHO-00D1zp-2q;
        Tue, 28 Feb 2023 00:47:34 +0200
Date:   Tue, 28 Feb 2023 00:47:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <Y/0zBv/vyn2aU0Di@smile.fi.intel.com>
References: <20230227133255.32301-2-mike.looijmans@topic.nl>
 <202302272311.tpyMXtCV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302272311.tpyMXtCV-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:47:08PM +0800, kernel test robot wrote:
> Hi Mike,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on v6.2]
> [cannot apply to jic23-iio/togreg linus/master next-20230227]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Looijmans/iio-adc-Add-TI-ADS1100-and-ADS1000/20230227-213529
> patch link:    https://lore.kernel.org/r/20230227133255.32301-2-mike.looijmans%40topic.nl
> patch subject: [PATCH v2 2/2] iio: adc: Add TI ADS1100 and ADS1000
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230227/202302272311.tpyMXtCV-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/8bc0b6e697641a7c6274a492bf210faccdeb55bf
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Mike-Looijmans/iio-adc-Add-TI-ADS1100-and-ADS1000/20230227-213529
>         git checkout 8bc0b6e697641a7c6274a492bf210faccdeb55bf
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302272311.tpyMXtCV-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Missing bitgield.h (and actually bits.h as well).

-- 
With Best Regards,
Andy Shevchenko


