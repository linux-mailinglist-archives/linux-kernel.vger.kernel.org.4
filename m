Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4362169D469
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjBTUFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:05:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7A1E1F2;
        Mon, 20 Feb 2023 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676923531; x=1708459531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0JjseAxJv1MQ5aoMkYPcofLggUQw/63rn0ahWH1W61w=;
  b=BB69Rsf1g0h+6bWorBoCcj/3dTauqDAGVnWFQ3d+SCBTyd79Pk3HxbuA
   XgidkXCkF7O6IoCEY3rS3I08Qs4IvR/W9LTKfoJfHDa0wOQ8p7px9z7Tx
   Qi9UV1sS7VqMMq5UTqiyT5GNuZeBY84ooRrQwr1M8knB/2ojGRlIQVl9Y
   HVSmo5VpFPXWNOk/JY5E0p3vd4k2GoV1PELIuBn1lTUESAEr8cwCXVvjr
   Jvfj4jDTyaXKJPdnI4LfXzzf9mKXuG6e0CU5FBHG/Jyltxq8zJYtuVQda
   BIB0M6LJcfGbbeIhxEnxiUp9rLWgq5FgLZ/panATjBX4/uq977gqLFJ4O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331145105"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="331145105"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 12:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="1000368307"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="1000368307"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Feb 2023 12:05:28 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUCPf-000E9J-2I;
        Mon, 20 Feb 2023 20:05:27 +0000
Date:   Tue, 21 Feb 2023 04:04:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marius.cristea@microchip.com
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <202302210331.iKaMm4co-lkp@intel.com>
References: <20230220123232.413029-3-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220123232.413029-3-marius.cristea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.2 next-20230220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-dt-bindings-for-PAC193X/20230220-203540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230220123232.413029-3-marius.cristea%40microchip.com
patch subject: [PATCH v1 2/2] iio: adc: adding support for pac193x
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230221/202302210331.iKaMm4co-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fd3be916ffe18735a98bdc55ccc0cb5f3097582c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review marius-cristea-microchip-com/dt-bindings-iio-adc-adding-dt-bindings-for-PAC193X/20230220-203540
        git checkout fd3be916ffe18735a98bdc55ccc0cb5f3097582c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302210331.iKaMm4co-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/pac193x.c: In function 'pac193x_acpi_get_acpi_match_entry':
>> drivers/iio/adc/pac193x.c:1402:21: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    1402 |         acpi_status status;
         |                     ^~~~~~


vim +/status +1402 drivers/iio/adc/pac193x.c

  1399	
  1400	static char *pac193x_acpi_get_acpi_match_entry(acpi_handle handle)
  1401	{
> 1402		acpi_status status;
  1403		union acpi_object *name_object;
  1404		struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
  1405	
  1406		status = acpi_evaluate_object(handle, "_HID", NULL, &buffer);
  1407		name_object = buffer.pointer;
  1408	
  1409		return name_object->string.pointer;
  1410	}
  1411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
