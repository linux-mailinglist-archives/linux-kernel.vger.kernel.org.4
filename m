Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9C4727699
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjFHFSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjFHFSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:18:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C526B8;
        Wed,  7 Jun 2023 22:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686201514; x=1717737514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cHXrEY01bYvheOLH7fG7jjiblWcaaSIEo6dV4ZMjUe0=;
  b=LocKE1V9IsHhQOMmoyx+6Xu8aCJCT/IkxHeS2XhU57zhfTKCKzMh0F6K
   ABCuJQnaPti6QoMosND/6tIMxAfGI4Yn13SbcAGAGOOxlWODFSHP26bjr
   klQJuQjwkkMnCJDcy6A/uIkYD8QxlEHcYyIcbLMCXKsD92JbJ/Dzp3coc
   Y5qifYizJtpJb3hHlV+GJQ8ATxksDpXpk6cH6ha4CwP7IEzt4LDQFlt7j
   drpdnplxb2dTLH/N/gb7RgQV3jeq0/g+j6xG8BtBE/R7ILouEqzD9sAqZ
   ZNb9xUqE6UG00LLAY6L5kysA27BIGgBss9NfhhtzsLn7A8x5oFBTqlEaA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="357213723"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="357213723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 22:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703942649"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="703942649"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2023 22:18:27 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q782U-0007Ih-2L;
        Thu, 08 Jun 2023 05:18:26 +0000
Date:   Thu, 8 Jun 2023 13:18:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, hsinyi@google.com
Subject: Re: [PATCH v2 08/10] HID: i2c-hid: Support being a panel follower
Message-ID: <202306081344.M0jNn0Ce-lkp@intel.com>
References: <20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on hid/for-next dtor-input/next dtor-input/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Douglas-Anderson/dt-bindings-HID-i2c-hid-Add-panel-property-to-i2c-hid-backed-touchscreens/20230608-055515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15%40changeid
patch subject: [PATCH v2 08/10] HID: i2c-hid: Support being a panel follower
config: arc-randconfig-r021-20230607 (https://download.01.org/0day-ci/archive/20230608/202306081344.M0jNn0Ce-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add robh https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
        git fetch robh for-next
        git checkout robh/for-next
        b4 shazam https://lore.kernel.org/r/20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306081344.M0jNn0Ce-lkp@intel.com/

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of lib/test_dynamic_debug.o: defined in discarded section `.exit.text' of lib/test_dynamic_debug.o
   `.exit.text' referenced in section `__jump_table' of lib/test_dynamic_debug.o: defined in discarded section `.exit.text' of lib/test_dynamic_debug.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/phantom.o: defined in discarded section `.exit.text' of drivers/misc/phantom.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/phantom.o: defined in discarded section `.exit.text' of drivers/misc/phantom.o
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   arceb-elf-ld: drivers/hid/i2c-hid/i2c-hid-core.o: in function `i2c_hid_core_remove':
   drivers/hid/i2c-hid/i2c-hid-core.c:1218: undefined reference to `drm_panel_remove_follower'
>> arceb-elf-ld: drivers/hid/i2c-hid/i2c-hid-core.c:1218: undefined reference to `drm_panel_remove_follower'
   arceb-elf-ld: drivers/hid/i2c-hid/i2c-hid-core.o: in function `i2c_hid_core_probe':
   drivers/hid/i2c-hid/i2c-hid-core.c:1159: undefined reference to `drm_panel_add_follower'
>> arceb-elf-ld: drivers/hid/i2c-hid/i2c-hid-core.c:1159: undefined reference to `drm_panel_add_follower'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
