Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415787386C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjFUOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjFUOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:23:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3F19A3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687357392; x=1718893392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EByyF0O5U64+uxoyOlrBs5UmT/Dwl52uk411TVhfsE8=;
  b=WUuvSA7MmKxoiqplgzofYnRdNHGPW6ZMuPIZvuXJalj1pOyz1RQ57UQ/
   yxR4JOoVafP0p+WX9qCYPV7uVnewQW6eJFgF159Hn2OJfrXQscXQFVSOV
   /wVmjJPbp81Ppmk93DF+Dhm8ewen7FuXyuZNuhnPOTDpBvA3ue6Y6xgKr
   D20YgZ4/vqHvtlFmbyH3MrAa/OVDrBWswsKrfuE102Wo8h5CvXINjmmsX
   P6CgiPMPyIG34BKweG0+Wa+4OzS74HbL8MEHKqbTGqSfLUrPFpk8mn/rA
   3PXZSQZES4d+OKiR6F0N6zax5N6LVqOq7WvwtyH/U46L7C0ci3TPeYOIO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="344922440"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="344922440"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="779868742"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="779868742"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2023 07:23:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qByjk-0006st-2I;
        Wed, 21 Jun 2023 14:23:08 +0000
Date:   Wed, 21 Jun 2023 22:23:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/mtd/nand/raw/omap_elm.c:180:37: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202306212211.WDXokuWh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e660abd551f1172e428b4e4003de887176a8a1fd
commit: be34f45f0d4aa91c6b83d140f9ace1ca40a5f9dc memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
date:   1 year, 2 months ago
config: arm64-randconfig-s031-20230621 (https://download.01.org/0day-ci/archive/20230621/202306212211.WDXokuWh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306212211.WDXokuWh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306212211.WDXokuWh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/omap_elm.c:180:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:180:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:180:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:185:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:185:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:185:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:190:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:190:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:190:37: sparse:     got restricted __be32 [usertype]
>> drivers/mtd/nand/raw/omap_elm.c:200:40: sparse: sparse: restricted __be32 degrades to integer
   drivers/mtd/nand/raw/omap_elm.c:206:39: sparse: sparse: restricted __be32 degrades to integer
>> drivers/mtd/nand/raw/omap_elm.c:210:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:210:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:210:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:213:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:213:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:213:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:216:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:216:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:216:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:219:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:219:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:219:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:222:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:222:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:222:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:225:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/omap_elm.c:225:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:225:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:228:39: sparse: sparse: restricted __be32 degrades to integer

vim +180 drivers/mtd/nand/raw/omap_elm.c

bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  155  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  156  /**
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  157   * elm_load_syndrome - Load ELM syndrome reg
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  158   * @info:	elm info
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  159   * @err_vec:	elm error vectors
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  160   * @ecc:	buffer with calculated ecc
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  161   *
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  162   * Load syndrome fragment registers with calculated ecc in reverse order.
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  163   */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  164  static void elm_load_syndrome(struct elm_info *info,
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  165  		struct elm_errorvec *err_vec, u8 *ecc)
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  166  {
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  167  	int i, offset;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  168  	u32 val;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  169  
79f013518d435e drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  170  	for (i = 0; i < info->ecc_steps; i++) {
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  171  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  172  		/* Check error reported */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  173  		if (err_vec[i].error_reported) {
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  174  			elm_configure_page_mode(info, i, true);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  175  			offset = ELM_SYNDROME_FRAGMENT_0 +
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  176  				SYNDROME_FRAGMENT_REG_SIZE * i;
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  177  			switch (info->bch_type) {
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  178  			case BCH8_ECC:
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  179  				/* syndrome fragment 0 = ecc[9-12B] */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04 @180  				val = cpu_to_be32(*(u32 *) &ecc[9]);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  181  				elm_write_reg(info, offset, val);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  182  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  183  				/* syndrome fragment 1 = ecc[5-8B] */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  184  				offset += 4;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  185  				val = cpu_to_be32(*(u32 *) &ecc[5]);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  186  				elm_write_reg(info, offset, val);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  187  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  188  				/* syndrome fragment 2 = ecc[1-4B] */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  189  				offset += 4;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  190  				val = cpu_to_be32(*(u32 *) &ecc[1]);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  191  				elm_write_reg(info, offset, val);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  192  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  193  				/* syndrome fragment 3 = ecc[0B] */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  194  				offset += 4;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  195  				val = ecc[0];
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  196  				elm_write_reg(info, offset, val);
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  197  				break;
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  198  			case BCH4_ECC:
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  199  				/* syndrome fragment 0 = ecc[20-52b] bits */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04 @200  				val = (cpu_to_be32(*(u32 *) &ecc[3]) >> 4) |
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  201  					((ecc[2] & 0xf) << 28);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  202  				elm_write_reg(info, offset, val);
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  203  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  204  				/* syndrome fragment 1 = ecc[0-20b] bits */
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  205  				offset += 4;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  206  				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  207  				elm_write_reg(info, offset, val);
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  208  				break;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  209  			case BCH16_ECC:
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19 @210  				val = cpu_to_be32(*(u32 *) &ecc[22]);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  211  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  212  				offset += 4;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  213  				val = cpu_to_be32(*(u32 *) &ecc[18]);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  214  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  215  				offset += 4;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  216  				val = cpu_to_be32(*(u32 *) &ecc[14]);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  217  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  218  				offset += 4;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  219  				val = cpu_to_be32(*(u32 *) &ecc[10]);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  220  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  221  				offset += 4;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  222  				val = cpu_to_be32(*(u32 *) &ecc[6]);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  223  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  224  				offset += 4;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  225  				val = cpu_to_be32(*(u32 *) &ecc[2]);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  226  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  227  				offset += 4;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  228  				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 16;
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  229  				elm_write_reg(info, offset, val);
2be589e4b28457 drivers/mtd/devices/elm.c pekon gupta    2014-05-19  230  				break;
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  231  			default:
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  232  				pr_err("invalid config bch_type\n");
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  233  			}
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  234  		}
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  235  
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  236  		/* Update ecc pointer with ecc byte size */
ea0760244d2356 drivers/mtd/devices/elm.c Pekon Gupta    2014-03-20  237  		ecc += info->ecc_syndrome_size;
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  238  	}
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  239  }
bf22433575ef30 drivers/mtd/devices/elm.c Philip Avinash 2013-01-04  240  

:::::: The code at line 180 was first introduced by commit
:::::: bf22433575ef30a4807f0620498017df0f27df67 mtd: devices: elm: Add support for ELM error correction

:::::: TO: Philip Avinash <avinashphilip@ti.com>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
