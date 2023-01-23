Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A167813A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjAWQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjAWQTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:19:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD046EC7D;
        Mon, 23 Jan 2023 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674490762; x=1706026762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lmu2v7OpTbu6dqk7bQ9CsXmK8c+nQata6XlQ8c9vCME=;
  b=fRcHElqMEi/4o2Aenro818D6o3Ist4rPAUDfDu/Tq0xh9PfPVR8j1iWI
   +j3QX8DGa20u+pVVqwgHG/EMxKhCgePPBnCMnCo5hLGbRbdKDWkEPDfyv
   Sw5xIEGhZJVP0aTM+FLZY5WcMS0JRZFwDoXhunmmxPnVCIq+bDnI98WjG
   b6UlZkjTmMK76ACFUUK8wIVpyDG0y3xJM0ZNFW6u/3wJ5tzFM9v/XtZ8T
   PBZsuV0Rkw3dD++hlC3NQWY6IE+oC0Hgkxqo8sAYYgjaIweiRWU9wCV7G
   dhqoUmbuLXGIe/j0N+ydHf56n73NX7yRgIa9k1UTJiuSbEnqAXrQKok9/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="327340445"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="327340445"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663690168"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663690168"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 08:19:17 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJzXN-0005lU-1V;
        Mon, 23 Jan 2023 16:19:13 +0000
Date:   Tue, 24 Jan 2023 00:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Benjamin Roszak <benjamin545@gmail.com>
Subject: Re: [PATCH 2/2] media: meson: vdec: add HEVC decode codec
Message-ID: <202301240007.NkZA19qq-lkp@intel.com>
References: <20230123133113.3254659-3-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123133113.3254659-3-christianshewitt@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.2-rc5 next-20230123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/media-meson-vdec-implement-10bit-bitstream-handling/20230123-213323
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230123133113.3254659-3-christianshewitt%40gmail.com
patch subject: [PATCH 2/2] media: meson: vdec: add HEVC decode codec
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301240007.NkZA19qq-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/498d420e9c7cdc6e694be643c47ee69c8b5b2142
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Hewitt/media-meson-vdec-implement-10bit-bitstream-handling/20230123-213323
        git checkout 498d420e9c7cdc6e694be643c47ee69c8b5b2142
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/media/meson/vdec/codec_hevc.c: In function 'codec_hevc_set_mpred_mv':
>> drivers/staging/media/meson/vdec/codec_hevc.c:1002:13: warning: variable 'val' set but not used [-Wunused-but-set-variable]
    1002 |         u32 val;
         |             ^~~


vim +/val +1002 drivers/staging/media/meson/vdec/codec_hevc.c

   990	
   991	static void codec_hevc_set_mpred_mv(struct amvdec_core *core,
   992					    struct codec_hevc *hevc,
   993					    struct hevc_frame *frame,
   994					    struct hevc_frame *col_frame)
   995	{
   996		union rpm_param *param = &hevc->rpm_param;
   997		u32 lcu_size_log2 = ilog2(hevc->lcu_size);
   998		u32 mv_mem_unit = lcu_size_log2 == 6 ? 0x200 :
   999				  lcu_size_log2 == 5 ? 0x80 : 0x20;
  1000		dma_addr_t col_mv_rd_start_addr, col_mv_rd_ptr, col_mv_rd_end_addr;
  1001		dma_addr_t mpred_mv_wr_ptr;
> 1002		u32 val;
  1003	
  1004		val = amvdec_read_dos(core, HEVC_MPRED_CURR_LCU);
  1005	
  1006		col_mv_rd_start_addr = codec_hevc_get_frame_mv_paddr(hevc, col_frame);
  1007		mpred_mv_wr_ptr = codec_hevc_get_frame_mv_paddr(hevc, frame) +
  1008				  (hevc->slice_addr * mv_mem_unit);
  1009		col_mv_rd_ptr = col_mv_rd_start_addr +
  1010				(hevc->slice_addr * mv_mem_unit);
  1011		col_mv_rd_end_addr = col_mv_rd_start_addr +
  1012				     (hevc->lcu_total * mv_mem_unit);
  1013	
  1014		amvdec_write_dos(core, HEVC_MPRED_MV_WR_START_ADDR,
  1015				 codec_hevc_get_frame_mv_paddr(hevc, frame));
  1016		amvdec_write_dos(core, HEVC_MPRED_MV_RD_START_ADDR,
  1017				 col_mv_rd_start_addr);
  1018	
  1019		if (param->p.slice_segment_address == 0) {
  1020			amvdec_write_dos(core, HEVC_MPRED_ABV_START_ADDR,
  1021					 hevc->workspace_paddr + MPRED_ABV_OFFSET);
  1022			amvdec_write_dos(core, HEVC_MPRED_MV_WPTR, mpred_mv_wr_ptr);
  1023			amvdec_write_dos(core, HEVC_MPRED_MV_RPTR,
  1024					 col_mv_rd_start_addr);
  1025		} else {
  1026			amvdec_write_dos(core, HEVC_MPRED_MV_RPTR, col_mv_rd_ptr);
  1027		}
  1028	
  1029		amvdec_write_dos(core, HEVC_MPRED_MV_RD_END_ADDR, col_mv_rd_end_addr);
  1030	}
  1031	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
