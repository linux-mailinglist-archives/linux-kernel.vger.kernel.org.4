Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA66839B4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjAaWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:54:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBDA3C30
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675205672; x=1706741672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TlDpM4JxpT631r62xY5llqyLQDbSYM3Crt0zBN/mQ40=;
  b=RH2liA2crO7t8qyV25rpwqEx3Y3EKFynoV0lE8umv/GHg6wzx9pscuLE
   jytnqiynnu9bNmEwpR1/ikTYO/rrCgQESBif/5dQuLM/jIDRXvtYUL9vX
   PhppnP/MR7siuQYAcieqVwPwTm7exOz66ZXW1tJ48rXAzqP4eyei33R4S
   DddfZiT4AMY+Xfc7uc4YNzlxZfhlCq4J3du2VtD7Tz+MY4aNrmKSIW8Ay
   L7oHNJVqn3tA9jU0SexJTi6qP+PbRvx1xE5YY7ycljpckDW5mqIW62tq6
   yqKZxfZeFDc5nsKy596hcRwMPCRGXwwtR0+S/otv/IDkYe8L34q009xpE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="392537108"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="392537108"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="697001679"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="697001679"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2023 14:54:29 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMzWG-0004mA-1f;
        Tue, 31 Jan 2023 22:54:28 +0000
Date:   Wed, 1 Feb 2023 06:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v2] ASoC: tas2781: Add tas2781 driver.
Message-ID: <202302010621.HbhoRa8c-lkp@intel.com>
References: <20230131131701.7097-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131131701.7097-1-13916275206@139.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: m68k-randconfig-m031-20230129 (https://download.01.org/0day-ci/archive/20230201/202302010621.HbhoRa8c-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
sound/soc/codecs/tas2781-i2c.c:220 tasdevice_process_block() warn: inconsistent indenting
sound/soc/codecs/tas2781-i2c.c:471 tas2781_digital_putvol() warn: unsigned 'val' is never less than zero.
sound/soc/codecs/tas2781-i2c.c:544 tas2781_amp_putvol() warn: unsigned 'val' is never less than zero.
sound/soc/codecs/tas2781-i2c.c:841 tasdevice_rca_ready() error: we previously assumed 'tas_dev' could be null (see line 840)
sound/soc/codecs/tas2781-i2c.c:1095 tasdevice_dapm_event() error: uninitialized symbol 'pwr_state'.
sound/soc/codecs/tas2781-i2c.c:1818 tasdevice_pm_suspend() error: we previously assumed 'tas_dev' could be null (see line 1817)
sound/soc/codecs/tas2781-dsp.c:1670 tasdevice_load_block() warn: inconsistent indenting
sound/soc/codecs/tas2781-dsp.c:732 tas2781_clear_calfirmware() warn: inconsistent indenting
sound/soc/codecs/tas2781-dsp.c:2038 tasdevice_dsp_remove() warn: inconsistent indenting

Old smatch warnings:
sound/soc/codecs/tas2781-dsp.c:1688 tasdevice_load_block() warn: inconsistent indenting
sound/soc/codecs/tas2781-dsp.c:2042 tasdevice_dsp_remove() warn: inconsistent indenting
sound/soc/codecs/tas2781-dsp.c:2069 tasdevice_dsp_remove() warn: inconsistent indenting
sound/soc/codecs/tas2781-dsp.c:2073 tasdevice_dsp_remove() warn: inconsistent indenting

vim +220 sound/soc/codecs/tas2781-i2c.c

    94	
    95	int tasdevice_process_block(void *context,
    96		unsigned char *data, unsigned char dev_idx, int sublocksize)
    97	{
    98		struct tasdevice_priv *tas_dev =
    99			(struct tasdevice_priv *)context;
   100		unsigned char subblk_typ = data[1];
   101		int subblk_offset = 2;
   102		int chn = 0, chnend = 0;
   103		int rc = 0;
   104		int blktyp = dev_idx & 0xC0, idx = dev_idx & 0x3F;
   105		bool is_err = false;
   106	
   107		if (idx) {
   108			chn = idx-1;
   109			chnend = idx;
   110		} else {
   111			if (tas_dev->set_global_mode) {
   112				chn = tas_dev->ndev;
   113				chnend = tas_dev->ndev + 1;
   114			} else {
   115				chn = 0;
   116				chnend = tas_dev->ndev;
   117			}
   118		}
   119	
   120		for (; chn < chnend; chn++) {
   121			if (tas_dev->set_global_mode == NULL &&
   122				tas_dev->tasdevice[chn].is_loading == false)
   123				continue;
   124	
   125			is_err = false;
   126			subblk_offset = 2;
   127			switch (subblk_typ) {
   128			case TASDEVICE_CMD_SING_W: {
   129				int i = 0;
   130				unsigned short len = SMS_HTONS(data[2], data[3]);
   131	
   132				subblk_offset  += 2;
   133				if (subblk_offset + 4 * len > sublocksize) {
   134					dev_err(tas_dev->dev,
   135						"process_block: Out of memory\n");
   136					is_err = true;
   137					break;
   138				}
   139	
   140				for (i = 0; i < len; i++) {
   141					rc = tasdevice_dev_write(tas_dev, chn,
   142						TASDEVICE_REG(data[subblk_offset],
   143							data[subblk_offset + 1],
   144							data[subblk_offset + 2]),
   145						data[subblk_offset + 3]);
   146					if (rc < 0) {
   147						is_err = true;
   148						dev_err(tas_dev->dev,
   149						"process_block: single write error\n");
   150					}
   151					subblk_offset  += 4;
   152				}
   153			}
   154				break;
   155			case TASDEVICE_CMD_BURST: {
   156				unsigned short len = SMS_HTONS(data[2], data[3]);
   157	
   158				subblk_offset  += 2;
   159				if (subblk_offset + 4 + len > sublocksize) {
   160					dev_err(tas_dev->dev,
   161					"process_block: BURST Out of memory\n");
   162					is_err = true;
   163					break;
   164				}
   165				if (len % 4) {
   166					dev_err(tas_dev->dev,
   167						"%s: Burst len(%u) can be div by 4\n",
   168						__func__, len);
   169					break;
   170				}
   171	
   172				rc = tasdevice_dev_bulk_write(tas_dev, chn,
   173					TASDEVICE_REG(data[subblk_offset],
   174						data[subblk_offset + 1],
   175						data[subblk_offset + 2]),
   176						&(data[subblk_offset + 4]), len);
   177				if (rc < 0) {
   178					is_err = true;
   179					dev_err(tas_dev->dev,
   180						"%s: bulk_write error = %d\n",
   181						__func__, rc);
   182				}
   183				subblk_offset  += (len + 4);
   184			}
   185				break;
   186			case TASDEVICE_CMD_DELAY: {
   187				unsigned short delay_time = 0;
   188	
   189				if (subblk_offset + 2 > sublocksize) {
   190					dev_err(tas_dev->dev,
   191						"%s: deley Out of memory\n",
   192						__func__);
   193					is_err = true;
   194					break;
   195				}
   196				delay_time = SMS_HTONS(data[2], data[3]);
   197				usleep_range(delay_time*1000, delay_time*1000);
   198				subblk_offset  += 2;
   199			}
   200				break;
   201			case TASDEVICE_CMD_FIELD_W:
   202			if (subblk_offset + 6 > sublocksize) {
   203				dev_err(tas_dev->dev,
   204					"process_block: bit write Out of memory\n");
   205				is_err = true;
   206				break;
   207			}
   208			rc = tasdevice_dev_update_bits(tas_dev, chn,
   209				TASDEVICE_REG(data[subblk_offset + 2],
   210					data[subblk_offset + 3],
   211					data[subblk_offset + 4]),
   212					data[subblk_offset + 1],
   213					data[subblk_offset + 5]);
   214			if (rc < 0) {
   215				is_err = true;
   216				dev_err(tas_dev->dev,
   217					"process_block: update_bits error = %d\n", rc);
   218			}
   219			subblk_offset  += 6;
 > 220				break;
   221			default:
   222				break;
   223			};
   224			if (is_err == true && blktyp != 0) {
   225				if (blktyp == 0x80) {
   226					tas_dev->tasdevice[chn].cur_prog = -1;
   227					tas_dev->tasdevice[chn].cur_conf = -1;
   228				} else
   229					tas_dev->tasdevice[chn].cur_conf = -1;
   230			}
   231		}
   232		return subblk_offset;
   233	}
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
