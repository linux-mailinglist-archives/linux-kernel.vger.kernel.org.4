Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987996F16FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjD1Lpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbjD1Lp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:45:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B359FC;
        Fri, 28 Apr 2023 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682682321; x=1714218321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rBbdv+hk3UP8M0WMEzt4+wWIQYS5wnCgtva4F2d/DLY=;
  b=eXta0Jh3H6+9xn8MRC/gAGsDxuTbZYhDeYhbikCeHMbXr7C2I/8PObww
   2gjDsaRRLkAxlu/suco67pWL2EHiPaEIRc1LluNevvIq6Kd/RTBFihS/p
   Tt5mriybMZvmS899f0/ietktWJtluqbgbpJ0agHEncfxsqsLdszpoyRL4
   +nr7KJSrGua1lw+5PZyYIexYKlPkdJvxq3Ry2H2u+6qai9/3Wip3a+a6N
   HgJOkq/DvIgrRD25YmtJ/kltZdBen5aI0HFQtzW3Ry4Lbg2UnGacC5yHK
   SHIJAfLjBNjdTmnaSj+XShnf5OByWtNjE3Nj8Vgv6RpldyBd4y7MgFvRB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="349750747"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="349750747"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 04:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="645092016"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="645092016"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2023 04:42:31 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psMUh-0000Ov-0s;
        Fri, 28 Apr 2023 11:42:31 +0000
Date:   Fri, 28 Apr 2023 19:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "Nicolas F . R . A . Prado" <nfraprado@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2] media: mediatek: vcodec: support stateless hevc
 decoder
Message-ID: <202304281935.cHbo4d1P-lkp@intel.com>
References: <20230428082329.28606-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428082329.28606-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.3 next-20230427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunfei-Dong/media-mediatek-vcodec-support-stateless-hevc-decoder/20230428-162427
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230428082329.28606-1-yunfei.dong%40mediatek.com
patch subject: [PATCH v2] media: mediatek: vcodec: support stateless hevc decoder
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230428/202304281935.cHbo4d1P-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/193b8e8eece4506c90eac97b973ef059aaf5c0e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yunfei-Dong/media-mediatek-vcodec-support-stateless-hevc-decoder/20230428-162427
        git checkout 193b8e8eece4506c90eac97b973ef059aaf5c0e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304281935.cHbo4d1P-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c: In function 'vdec_hevc_fill_dpb_info':
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c:412:24: warning: ordered comparison of pointer with integer zero [-Wextra]
     412 |                 if (vb < 0) {
         |                        ^
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c: In function 'vdec_hevc_copy_decode_params':
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c:587:63: error: 'const struct v4l2_ctrl_hevc_decode_params' has no member named 'num_delta_pocs_of_ref_rps_idx'
     587 |         dst_params->num_delta_pocs_of_ref_rps_idx = src_params->num_delta_pocs_of_ref_rps_idx;
         |                                                               ^~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c: In function 'vdec_hevc_slice_fill_decode_parameters':
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c:630:27: error: 'const struct v4l2_ctrl_hevc_decode_params' has no member named 'num_delta_pocs_of_ref_rps_idx'
     630 |                 dec_params->num_delta_pocs_of_ref_rps_idx;
         |                           ^~


vim +412 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c

   395	
   396	static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
   397					    struct slice_api_hevc_decode_param *decode_params,
   398					    struct mtk_hevc_dpb_info *hevc_dpb_info)
   399	{
   400		const struct slice_hevc_dpb_entry *dpb;
   401		struct vb2_queue *vq;
   402		struct vb2_buffer *vb;
   403		int index;
   404	
   405		vq = v4l2_m2m_get_vq(ctx->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
   406		for (index = 0; index < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; index++) {
   407			dpb = &decode_params->dpb[index];
   408			if (index >= decode_params->num_active_dpb_entries)
   409				continue;
   410	
   411			vb = vb2_find_buffer(vq, dpb->timestamp);
 > 412			if (vb < 0) {
   413				dev_err(&ctx->dev->plat_dev->dev,
   414					"Reference invalid: dpb_index(%d) timestamp(%lld)",
   415					index, dpb->timestamp);
   416				continue;
   417			}
   418	
   419			hevc_dpb_info[index].field = dpb->field_pic;
   420	
   421			hevc_dpb_info[index].y_dma_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
   422			if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
   423				hevc_dpb_info[index].c_dma_addr = vb2_dma_contig_plane_dma_addr(vb, 1);
   424			else
   425				hevc_dpb_info[index].c_dma_addr =
   426					hevc_dpb_info[index].y_dma_addr + ctx->picinfo.fb_sz[0];
   427		}
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
