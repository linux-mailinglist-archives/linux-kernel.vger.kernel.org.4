Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0C72FE60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbjFNMWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbjFNMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:22:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327019A5;
        Wed, 14 Jun 2023 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686745329; x=1718281329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wurr3a70A1th1nzJb1CFm7v+4FT74d7krbArrguyJE=;
  b=jQQyuaNexP4PiwYFBCQYvSH4nNQ9LzzCDv3356pGq6KXuFwp3uxzE4lJ
   1b04I/VOGF0nt6Ky08zd7D7vZ0eq6Hsvscw4I80sgqxfPt6H7sLnjFZg0
   I2LfnflNtP0KZJPoScrC8mka6+1MnWRIR1RstqDdOIu1EE/2RmjyC48RB
   uL+62qLsYiYodeT4BFqE/3/jH7HdpKVop8Pnieo2L/sTDIjXRiTwNfgQN
   MI/8EtK9vEKiSu6D+E/cYuRYCnQ1015ko99LDHNpjn0PErbHwAZg5V9US
   hqpHLaEnsG6KanvWFb4qaBZuGVPu0Km6JFDNbLrCZboTNpvQaNnzKAyBe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="343294392"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="343294392"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="801888082"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="801888082"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2023 05:22:04 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9PVg-0000cf-12;
        Wed, 14 Jun 2023 12:22:01 +0000
Date:   Wed, 14 Jun 2023 20:21:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maso Hunag <maso.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, Maso Huang <maso.huang@mediatek.com>
Subject: Re: [PATCH 3/7] ASoC: mediatek: mt79xx: add platform driver
Message-ID: <202306142005.uUyPtOQT-lkp@intel.com>
References: <20230612105250.15441-4-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612105250.15441-4-maso.huang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maso,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maso-Hunag/ASoC-mediatek-mt79xx-add-common-header/20230612-211033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230612105250.15441-4-maso.huang%40mediatek.com
patch subject: [PATCH 3/7] ASoC: mediatek: mt79xx: add platform driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230614/202306142005.uUyPtOQT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add broonie-sound https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
        git fetch broonie-sound for-next
        git checkout broonie-sound/for-next
        b4 shazam https://lore.kernel.org/r/20230612105250.15441-4-maso.huang@mediatek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/mediatek/mt79xx/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306142005.uUyPtOQT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c: In function 'mt79xx_afe_irq_handler':
>> sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:35: warning: missing terminating " character
     322 |                 dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
         |                                   ^
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:323:38: warning: missing terminating " character
     323 |                         mcu_en 0x%x\n", __func__, ret, status, mcu_en);
         |                                      ^
>> sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:608:23: error: unterminated argument list invoking macro "dev_err"
     608 | MODULE_LICENSE("GPL");
         |                       ^
>> sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:17: error: 'dev_err' undeclared (first use in this function); did you mean '_dev_err'?
     322 |                 dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
         |                 ^~~~~~~
         |                 _dev_err
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:17: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:24: error: expected ';' at end of input
     322 |                 dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
         |                        ^
         |                        ;
   ......
>> sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:17: error: expected declaration or statement at end of input
     322 |                 dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
         |                 ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:17: error: expected declaration or statement at end of input
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:312:21: warning: unused variable 'irq_ret' [-Wunused-variable]
     312 |         irqreturn_t irq_ret = IRQ_HANDLED;
         |                     ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:311:13: warning: unused variable 'i' [-Wunused-variable]
     311 |         int i;
         |             ^
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:306:34: warning: unused variable 'irq' [-Wunused-variable]
     306 |         struct mtk_base_afe_irq *irq;
         |                                  ^~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:322:17: error: no return statement in function returning non-void [-Werror=return-type]
     322 |                 dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
         |                 ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c: At top level:
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:303:20: warning: 'mt79xx_afe_irq_handler' defined but not used [-Wunused-function]
     303 | static irqreturn_t mt79xx_afe_irq_handler(int irq_id, void *dev)
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:294:35: warning: 'mt79xx_afe_regmap_config' defined but not used [-Wunused-const-variable=]
     294 | static const struct regmap_config mt79xx_afe_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:232:39: warning: 'irq_data' defined but not used [-Wunused-const-variable=]
     232 | static const struct mtk_base_irq_data irq_data[MT79XX_IRQ_NUM] = {
         |                                       ^~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:183:41: warning: 'memif_data' defined but not used [-Wunused-const-variable=]
     183 | static const struct mtk_base_memif_data memif_data[MT79XX_MEMIF_NUM] = {
         |                                         ^~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:179:46: warning: 'mt79xx_afe_pcm_dai_component' defined but not used [-Wunused-const-variable=]
     179 | static const struct snd_soc_component_driver mt79xx_afe_pcm_dai_component = {
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:170:40: warning: 'mt79xx_memif_routes' defined but not used [-Wunused-const-variable=]
     170 | static const struct snd_soc_dapm_route mt79xx_memif_routes[] = {
         |                                        ^~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:158:41: warning: 'mt79xx_memif_widgets' defined but not used [-Wunused-const-variable=]
     158 | static const struct snd_soc_dapm_widget mt79xx_memif_widgets[] = {
         |                                         ^~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:122:34: warning: 'mt79xx_memif_dai_driver' defined but not used [-Wunused-variable]
     122 | static struct snd_soc_dai_driver mt79xx_memif_dai_driver[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:101:12: warning: 'mt79xx_irq_fs' defined but not used [-Wunused-function]
     101 | static int mt79xx_irq_fs(struct snd_pcm_substream *substream,
         |            ^~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:90:12: warning: 'mt79xx_memif_fs' defined but not used [-Wunused-function]
      90 | static int mt79xx_memif_fs(struct snd_pcm_substream *substream,
         |            ^~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c:75:38: warning: 'mt79xx_afe_hardware' defined but not used [-Wunused-const-variable=]
      75 | static const struct snd_pcm_hardware mt79xx_afe_hardware = {
         |                                      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c: In function 'mt79xx_init_clock':
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:43: warning: missing terminating " character
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                                           ^
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:42: warning: missing terminating " character
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                          ^
   In file included from include/linux/kernel.h:30,
                    from include/linux/clk.h:13,
                    from sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:10:
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:43: error: missing terminating " character
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:33: error: 'ret' undeclared (first use in this function); did you mean 'net'?
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                 ^~~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:33: note: each undeclared identifier is reported only once for each function it appears in
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                 ^~~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:40: error: stray '\' in program
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                        ^
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:38: error: 'ld' undeclared (first use in this function)
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                      ^~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:41: error: expected ')' before 'n'
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                         ^
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   include/linux/printk.h:379:41: note: to match this '('
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                         ^
   include/linux/printk.h:422:9: note: in expansion of macro '__printk_index_emit'
     422 |         __printk_index_emit(fmt, level, subsys_fmt_prefix)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:42: error: missing terminating " character
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                                          ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:43: error: missing terminating " character
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:388:61: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                             ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:40: error: stray '\' in program
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                        ^
   include/linux/printk.h:388:61: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                             ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:41: error: expected ')' before 'n'
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                         ^
   include/linux/printk.h:388:61: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                             ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   include/linux/printk.h:388:60: note: to match this '('
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                            ^
   include/linux/printk.h:422:9: note: in expansion of macro '__printk_index_emit'
     422 |         __printk_index_emit(fmt, level, subsys_fmt_prefix)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:42: error: missing terminating " character
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:388:61: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                             ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:43: error: missing terminating " character
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:388:70: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                                      ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:40: error: stray '\' in program
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                        ^
   include/linux/printk.h:388:70: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                                      ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:41: error: expected ')' before 'n'
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                         ^
   include/linux/printk.h:388:70: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                                      ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   include/linux/printk.h:388:69: note: to match this '('
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                                     ^
   include/linux/printk.h:422:9: note: in expansion of macro '__printk_index_emit'
     422 |         __printk_index_emit(fmt, level, subsys_fmt_prefix)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:42: error: missing terminating " character
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:388:70: note: in definition of macro '__printk_index_emit'
     388 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                                                      ^~~~
   include/linux/dev_printk.h:105:9: note: in expansion of macro 'printk_index_subsys_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:17: note: in expansion of macro 'dev_printk_index_emit'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from include/sound/soc.h:14,
                    from sound/soc/mediatek/mt79xx/mt79xx-afe-common.h:13,
                    from sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:12:
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:43: error: missing terminating " character
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:40: error: stray '\' in program
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                        ^
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
>> sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:41: error: expected ')' before 'n'
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                         ^
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   include/linux/dev_printk.h:110:24: note: to match this '('
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                        ^
   include/linux/dev_printk.h:144:9: note: in expansion of macro 'dev_printk_index_wrap'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:47:42: error: missing terminating " character
      47 |                                 ret %ld\n", __func__, aud_clks[i],
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c:46:25: note: in expansion of macro 'dev_err'
      46 |                         dev_err(afe->dev, "%s(), devm_clk_get %s fail,
         |                         ^~~~~~~


vim +/dev_err +608 sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c

   605	
   606	MODULE_DESCRIPTION("Mediatek SoC AFE platform driver for ALSA MT79xx");
   607	MODULE_AUTHOR("Vic Wu <vic.wu@mediatek.com>");
 > 608	MODULE_LICENSE("GPL");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
