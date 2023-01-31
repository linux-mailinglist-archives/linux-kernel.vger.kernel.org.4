Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A668327A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjAaQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAaQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:24:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB5244A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675182245; x=1706718245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=blhwIt4pXs4RZFwAJ+0oJ/pbR/6npPnMEeUr9ldlKgc=;
  b=JoNI14mJhGz9ZBmDFIM2qhbe3ZH4bZPWNDz6fTPgbwE04Su8a6ZRiDVn
   4rXu5+Gf8wFq8Up/PxJ5/XcRrxHpk+/eWDTdz0IHbaYXb19dtbuX59F/U
   qHg3djbfCsK+0JsrAntR7M6UWoGjGKuKoyqodT7wOJfgRSTPdlxSfxu6g
   kbxaUsZPTZ69RJB67ahqiHW073aqI3Oz3iwekcKUTfRHXZaqqudSTmbKl
   F5QM6ALx4RLdxeTDTLn1ObuNhu/GQrmU3cMtkg/XDW1ASoGm/JmJ3ULDV
   IZ98bI9WECJCO7DbGeAUDbqiuKgEHOB0R3S4zfgAoA9gs8VgxhWN/2Ixi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311504554"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="311504554"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909970895"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909970895"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 08:24:01 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMtQO-0004YL-2f;
        Tue, 31 Jan 2023 16:24:00 +0000
Date:   Wed, 1 Feb 2023 00:23:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v2] ASoC: tas2781: Add tas2781 driver.
Message-ID: <202302010039.V0TFjmXX-lkp@intel.com>
References: <20230131131701.7097-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131131701.7097-1-13916275206@139.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.2-rc6 next-20230131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230131-212221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230131131701.7097-1-13916275206%40139.com
patch subject: [PATCH v2] ASoC: tas2781: Add tas2781 driver.
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230201/202302010039.V0TFjmXX-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d0782b52a1274657458fa49356eacb7c56eddf6b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230131-212221
        git checkout d0782b52a1274657458fa49356eacb7c56eddf6b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/codecs/tas2781-dsp.c:591:5: warning: no previous prototype for 'fw_parse_variable_header_git' [-Wmissing-prototypes]
     591 | int fw_parse_variable_header_git(struct tasdevice_priv *tas_dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:650:5: warning: no previous prototype for 'fw_parse_variable_header_cal' [-Wmissing-prototypes]
     650 | int fw_parse_variable_header_cal(struct tasdevice_priv *tas_dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from sound/soc/codecs/tas2781-dsp.c:16:
   sound/soc/codecs/tas2781-dsp.c: In function 'fw_parse_block_data':
>> sound/soc/codecs/tas2781-dsp.c:809:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     809 |                         "%s: File Size(%lu) error offset = %d n = %d\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/codecs/tas2781-dsp.c:808:17: note: in expansion of macro 'dev_err'
     808 |                 dev_err(tas_fmw->dev,
         |                 ^~~~~~~
   sound/soc/codecs/tas2781-dsp.c:809:42: note: format string is defined here
     809 |                         "%s: File Size(%lu) error offset = %d n = %d\n",
         |                                        ~~^
         |                                          |
         |                                          long unsigned int
         |                                        %u
   sound/soc/codecs/tas2781-dsp.c: In function 'fw_parse_header':
>> sound/soc/codecs/tas2781-dsp.c:1199:39: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1199 |                 dev_err(tas_dev->dev, "File size not match, %ld %u", fmw->size,
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1199:17: note: in expansion of macro 'dev_err'
    1199 |                 dev_err(tas_dev->dev, "File size not match, %ld %u", fmw->size,
         |                 ^~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1199:63: note: format string is defined here
    1199 |                 dev_err(tas_dev->dev, "File size not match, %ld %u", fmw->size,
         |                                                             ~~^
         |                                                               |
         |                                                               long int
         |                                                             %d
   sound/soc/codecs/tas2781-dsp.c: In function 'tas2781_load_calibration':
   sound/soc/codecs/tas2781-dsp.c:1819:33: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1819 |                                 "%s: file read error: size = %ld\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1818:25: note: in expansion of macro 'dev_err'
    1818 |                         dev_err(tas_dev->dev,
         |                         ^~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1819:64: note: format string is defined here
    1819 |                                 "%s: file read error: size = %ld\n",
         |                                                              ~~^
         |                                                                |
         |                                                                long int
         |                                                              %d


vim +809 sound/soc/codecs/tas2781-dsp.c

   740	
   741	static int fw_parse_block_data(struct tasdevice_fw *tas_fmw,
   742		struct tasdevice_block *block, const struct firmware *fmw, int offset)
   743	{
   744		unsigned char *data = (unsigned char *)fmw->data;
   745		int n;
   746	
   747		if (offset + 4 > fmw->size) {
   748			dev_err(tas_fmw->dev, "%s: mnType error\n", __func__);
   749			offset = -1;
   750			goto out;
   751		}
   752		block->type = SMS_HTONL(data[offset], data[offset + 1],
   753			data[offset + 2], data[offset + 3]);
   754		offset  += 4;
   755	
   756		if (tas_fmw->fw_hdr.fixed_hdr.drv_ver >=
   757			PPC_DRIVER_CRCCHK) {
   758			if (offset + 1 > fmw->size) {
   759				dev_err(tas_fmw->dev, "%s: mbPChkSumPresent error\n",
   760					__func__);
   761				offset = -1;
   762				goto out;
   763			}
   764			block->is_pchksum_present = data[offset];
   765			offset++;
   766	
   767			if (offset + 1 > fmw->size) {
   768				dev_err(tas_fmw->dev, "%s: mnPChkSum error\n",
   769					__func__);
   770				offset = -1;
   771				goto out;
   772			}
   773			block->pchksum = data[offset];
   774			offset++;
   775	
   776			if (offset + 1 > fmw->size) {
   777				dev_err(tas_fmw->dev, "%s: mbYChkSumPresent error\n",
   778					__func__);
   779				offset = -1;
   780				goto out;
   781			}
   782			block->is_ychksum_present = data[offset];
   783			offset++;
   784	
   785			if (offset + 1 > fmw->size) {
   786				dev_err(tas_fmw->dev, "%s: mnYChkSum error\n",
   787					__func__);
   788				offset = -1;
   789				goto out;
   790			}
   791			block->ychksum = data[offset];
   792			offset++;
   793		} else {
   794			block->is_pchksum_present = 0;
   795			block->is_ychksum_present = 0;
   796		}
   797		if (offset + 4 > fmw->size) {
   798			dev_err(tas_fmw->dev, "%s: mnCommands error\n", __func__);
   799			offset = -1;
   800			goto out;
   801		}
   802		block->n_cmds = SMS_HTONL(data[offset], data[offset + 1],
   803			data[offset + 2], data[offset + 3]);
   804		offset  += 4;
   805	
   806		n = block->n_cmds * 4;
   807		if (offset + n > fmw->size) {
   808			dev_err(tas_fmw->dev,
 > 809				"%s: File Size(%lu) error offset = %d n = %d\n",
   810				__func__, fmw->size, offset, n);
   811			offset = -1;
   812			goto out;
   813		}
   814		block->data = kmemdup(&data[offset], n, GFP_KERNEL);
   815		if (block->data == NULL) {
   816			offset = -1;
   817			goto out;
   818		}
   819		offset  += n;
   820	out:
   821		return offset;
   822	}
   823	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
