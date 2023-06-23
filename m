Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FE73ADBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFWA0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFWAZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:25:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CE2126;
        Thu, 22 Jun 2023 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687479955; x=1719015955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWb6G7Cg4aCmo6Vqc7o2CYZbvqZ1NqGkHb/WQ0tI0zo=;
  b=iXJDOyDbjRh5cEvA6iwh2lzLaeWVMiMxH3BOn1j7s1B6kcnEcJGgdgaP
   2SQFBmYUng9WQ5AvfLHDXwrIKITyMrn//6ucJoSbasOXJRlHLAFruf2qm
   iB3vX+PYXIscwqdjWg2atAa4LbnGQ0yJr7frM7+E3BM1bT6Udqp0K9Nle
   q/+ubEHpTgr0FAI+goJaO76yEezi0etO5U8kpAcfUIMPQ32NusDWc49W3
   YmH3+nYZllUHW8ap+MeEitF7B9vfffZvaTwCMHg1xtAy7y4+rr5vyxMxE
   qLB8bYqkb/do8tkuveqF22nDo3TpzjJKesRsyVpttm4AX6SxX2XK/2IEM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426630063"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426630063"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="839254554"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="839254554"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2023 17:25:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCUcX-0007qN-2K;
        Fri, 23 Jun 2023 00:25:49 +0000
Date:   Fri, 23 Jun 2023 08:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
Message-ID: <202306230822.0CCLmVt5-lkp@intel.com>
References: <20230622131349.144160-11-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622131349.144160-11-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.4-rc7]
[cannot apply to next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230622-214122
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230622131349.144160-11-benjamin.gaignard%40collabora.com
patch subject: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
config: i386-randconfig-i012-20230622 (https://download.01.org/0day-ci/archive/20230623/202306230822.0CCLmVt5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230822.0CCLmVt5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230822.0CCLmVt5-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vb2_core_delete_buf" [drivers/media/common/videobuf2/videobuf2-v4l2.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
