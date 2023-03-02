Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7D6A79A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCBCqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBCqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:46:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CFD231ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677725161; x=1709261161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3zIR95njavNPxl7UuonQWvsYNmzbZr7IWX/jC+1D1wQ=;
  b=ergLRkiMb1X3wK8rAnyrmvNYIGeDawqWaQ9j8vw51Xq+pBjsRMHGc5Rv
   NPOX3RGxkwfHq5Ut48ekI7dBAfBD+sndPbch/WdmcB15TzIXrz38OFRlY
   iR2JV/ko427hqssxhZrpEfAESAehUlUtLBLeroxN459YKU3wCR6ml79lI
   hRwaa92iEi74t/RN4pAEci7Dcm+9X0C4bYWq+tkN5tSkqpX/cE2PduKkc
   kYoO9Vi6gOG+e9unMbbqik7KD8TgXqGC257vQpyHHHoFsybkqRhAlmaEL
   jPIFhSDktAtE1e5JvxMJXYYGhUN8EP9ccB0uxRUXYF7QWFMEwEaR4XwKV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="399383294"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="399383294"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 18:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784617306"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="784617306"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Mar 2023 18:45:56 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXYxA-00006c-16;
        Thu, 02 Mar 2023 02:45:56 +0000
Date:   Thu, 2 Mar 2023 10:45:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: Re: [PATCH v3] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Message-ID: <202303021005.N2ff5BAJ-lkp@intel.com>
References: <20230301124447.17672-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301124447.17672-1-lucas.tanure@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.2 next-20230302]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Tanure/ASoC-cs35l41-Steam-Deck-Shared-boost-properties-quirk/20230301-204645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230301124447.17672-1-lucas.tanure%40collabora.com
patch subject: [PATCH v3] ASoC: cs35l41: Steam Deck Shared boost properties quirk
config: arm-randconfig-r031-20230302 (https://download.01.org/0day-ci/archive/20230302/202303021005.N2ff5BAJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/72d9f3ad356badf4a65161004a8160fb89a13669
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lucas-Tanure/ASoC-cs35l41-Steam-Deck-Shared-boost-properties-quirk/20230301-204645
        git checkout 72d9f3ad356badf4a65161004a8160fb89a13669
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/char/tpm/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303021005.N2ff5BAJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/codecs/cs35l41.c:1041:22: error: use of undeclared identifier 'CS35L41_SHD_BOOST_ACTV'
                   hw_cfg->bst_type = CS35L41_SHD_BOOST_ACTV;
                                      ^
>> sound/soc/codecs/cs35l41.c:1043:22: error: use of undeclared identifier 'CS35L41_SHD_BOOST_PASS'
                   hw_cfg->bst_type = CS35L41_SHD_BOOST_PASS;
                                      ^
   2 errors generated.


vim +/CS35L41_SHD_BOOST_ACTV +1041 sound/soc/codecs/cs35l41.c

  1032	
  1033	static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cfg)
  1034	{
  1035		struct cs35l41_gpio_cfg *gpio1 = &hw_cfg->gpio1;
  1036		struct cs35l41_gpio_cfg *gpio2 = &hw_cfg->gpio2;
  1037		unsigned int val;
  1038		int ret;
  1039	
  1040		if (device_property_read_bool(dev, "cirrus,shared-boost-active")){
> 1041			hw_cfg->bst_type = CS35L41_SHD_BOOST_ACTV;
  1042		} else if (device_property_read_bool(dev, "cirrus,shared-boost-passive")) {
> 1043			hw_cfg->bst_type = CS35L41_SHD_BOOST_PASS;
  1044		} else {
  1045			ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
  1046			if (ret >= 0)
  1047				hw_cfg->bst_type = val;
  1048		}
  1049	
  1050		ret = device_property_read_u32(dev, "cirrus,boost-peak-milliamp", &val);
  1051		if (ret >= 0)
  1052			hw_cfg->bst_ipk = val;
  1053		else
  1054			hw_cfg->bst_ipk = -1;
  1055	
  1056		ret = device_property_read_u32(dev, "cirrus,boost-ind-nanohenry", &val);
  1057		if (ret >= 0)
  1058			hw_cfg->bst_ind = val;
  1059		else
  1060			hw_cfg->bst_ind = -1;
  1061	
  1062		ret = device_property_read_u32(dev, "cirrus,boost-cap-microfarad", &val);
  1063		if (ret >= 0)
  1064			hw_cfg->bst_cap = val;
  1065		else
  1066			hw_cfg->bst_cap = -1;
  1067	
  1068		ret = device_property_read_u32(dev, "cirrus,asp-sdout-hiz", &val);
  1069		if (ret >= 0)
  1070			hw_cfg->dout_hiz = val;
  1071		else
  1072			hw_cfg->dout_hiz = -1;
  1073	
  1074		/* GPIO1 Pin Config */
  1075		gpio1->pol_inv = device_property_read_bool(dev, "cirrus,gpio1-polarity-invert");
  1076		gpio1->out_en = device_property_read_bool(dev, "cirrus,gpio1-output-enable");
  1077		ret = device_property_read_u32(dev, "cirrus,gpio1-src-select", &val);
  1078		if (ret >= 0) {
  1079			gpio1->func = val;
  1080			gpio1->valid = true;
  1081		}
  1082	
  1083		/* GPIO2 Pin Config */
  1084		gpio2->pol_inv = device_property_read_bool(dev, "cirrus,gpio2-polarity-invert");
  1085		gpio2->out_en = device_property_read_bool(dev, "cirrus,gpio2-output-enable");
  1086		ret = device_property_read_u32(dev, "cirrus,gpio2-src-select", &val);
  1087		if (ret >= 0) {
  1088			gpio2->func = val;
  1089			gpio2->valid = true;
  1090		}
  1091	
  1092		hw_cfg->valid = true;
  1093	
  1094		return 0;
  1095	}
  1096	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
