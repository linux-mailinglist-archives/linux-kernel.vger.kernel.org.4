Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289BD740DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjF1JyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:54:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:4320 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbjF1Jrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687945651; x=1719481651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0rxMvXN9/9rNCH+4gQCmn1WFc0BxwRhyzO2KvFRuxfY=;
  b=KXxWEzyJgKuVEON0TQHUXf4B2wOh1kJMqU6ZZ3iZswZhjGNDx0I+AX/S
   rb2Ke5uQ/IU8ESE0BP8Kq0JBxCWKPfU+OForK38y3b2SLf7l0Lx/d+qrb
   kGWwCxVy9PqaXCPZBJ4cNw4ckQn5CzLSW7GJJw1gbHjr/cqAimOUSWExA
   PBvkf1Z7hM6OhWBX/vl+VHksk8KhCR3RLmWareOg1t6XhQ+iE1e8sV0iJ
   n6ftgslovuz/NPqQaW6V8E2Sm921i+azRx6sx+H+ossM7JaoqG/p3b14P
   2g4G7vVcs9brClTpPShYvoVpYI1CZ3ReItCZi6BRf33gsKyBhsKiFf2Dc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342137871"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342137871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 02:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="667040646"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="667040646"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 02:47:27 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qERlm-000DAP-0p;
        Wed, 28 Jun 2023 09:47:26 +0000
Date:   Wed, 28 Jun 2023 17:46:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     oe-kbuild-all@lists.linux.dev, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 5/7] media: mediatek: vcodec: Read HW active status
 from syscon
Message-ID: <202306281746.a2zk4ETu-lkp@intel.com>
References: <20230627214615.1503901-6-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627214615.1503901-6-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nícolas,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on robh/for-next]
[cannot apply to mbgg-mediatek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/N-colas-F-R-A-Prado/media-dt-bindings-mediatek-vcodec-Allow-single-clock-for-mt8183/20230628-054734
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230627214615.1503901-6-nfraprado%40collabora.com
patch subject: [PATCH v4 5/7] media: mediatek: vcodec: Read HW active status from syscon
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230628/202306281746.a2zk4ETu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306281746.a2zk4ETu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306281746.a2zk4ETu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c: In function 'mtk_vcodec_is_hw_active':
>> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:52:17: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      52 |         return !FIELD_GET(VDEC_HW_ACTIVE_MASK, cg_status);
         |                 ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +52 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c

    42	
    43	static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
    44	{
    45		u32 cg_status;
    46	
    47		if (dev->vdecsys_regmap)
    48			return !regmap_test_bits(dev->vdecsys_regmap, VDEC_HW_ACTIVE_ADDR,
    49						 VDEC_HW_ACTIVE_MASK);
    50	
    51		cg_status = readl(dev->reg_base[VDEC_SYS] + VDEC_HW_ACTIVE_ADDR);
  > 52		return !FIELD_GET(VDEC_HW_ACTIVE_MASK, cg_status);
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
