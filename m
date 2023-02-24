Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F76A1617
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBXFAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:00:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810C019F3C;
        Thu, 23 Feb 2023 21:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677214839; x=1708750839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tZQIvNF2fQT5ZTTmF4013c95rvzv4D1YYc0RCv0VrnQ=;
  b=B2KrAyOjPPn1/CV8cITS3US006iM4JFw2c6QYI99JWYj2bcR7pbgrvJY
   cjbb1F4b+M5HEgGE56kR7+3D6MMiBvh+RVChN0SHEZZymDOw71v0QrX1Q
   CBumWGMeuucDT9F8zO4HtQtHx4dd0QdsZuYDU8FBiObPPShNxyATv/Ta5
   HGlnCEEAPxD2pJu1dGiHPteP8WsTo6KqPlbg9GxQfYj8ddSW2A9OSZZol
   uasvzEJpuqmLwpWG+qulqRNVWfBs2x7iSpb90eF/+T1rRqgedmVYDVP8I
   ge+UAn1XykjhEiupD9/elP/rPZSKpCQtPFnTsTS4YW3dyhy8aMnfVg3gL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="317156415"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="317156415"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 21:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="782206623"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="782206623"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2023 21:00:37 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVQCC-000290-36;
        Fri, 24 Feb 2023 05:00:36 +0000
Date:   Fri, 24 Feb 2023 13:00:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c:38:32:
 warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned
 int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int,
 void *)') converts to incompatible f...
Message-ID: <202302241258.Q3rgDf4M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2980d8d826554fa6981d621e569a453787472f8
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
date:   11 months ago
config: hexagon-randconfig-r041-20230224 (https://download.01.org/0day-ci/archive/20230224/202302241258.Q3rgDf4M-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2023a99811110aebba9eee4aa09ef7bd21a8a249
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2023a99811110aebba9eee4aa09ef7bd21a8a249
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302241258.Q3rgDf4M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c:38:32: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
           ipi_handler_t handler_const = (ipi_handler_t)handler;
                                         ^~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +38 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c

46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  27  
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  28  static int mtk_vcodec_vpu_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  29  					   mtk_vcodec_ipi_handler handler,
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  30  					   const char *name, void *priv)
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  31  {
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  32  	/*
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  33  	 * The handler we receive takes a void * as its first argument. We
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  34  	 * cannot change this because it needs to be passed down to the rproc
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  35  	 * subsystem when SCP is used. VPU takes a const argument, which is
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  36  	 * more constrained, so the conversion below is safe.
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  37  	 */
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13 @38  	ipi_handler_t handler_const = (ipi_handler_t)handler;
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  39  
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  40  	return vpu_ipi_register(fw->pdev, id, handler_const, name, priv);
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  41  }
46233e91fa24a9 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c Alexandre Courbot 2020-10-13  42  

:::::: The code at line 38 was first introduced by commit
:::::: 46233e91fa24a91bffca0680b1c55282ba601918 media: mtk-vcodec: move firmware implementations into their own files

:::::: TO: Alexandre Courbot <acourbot@chromium.org>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
