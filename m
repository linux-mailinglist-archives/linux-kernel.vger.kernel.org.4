Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231757370C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFTPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjFTPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:44:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4DE60;
        Tue, 20 Jun 2023 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687275869; x=1718811869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZGADFVJXd8Du1pooes+jrLE2cK1+HAS0de7DtytrOFA=;
  b=J0JGoQ8/Mn5W0TobdgJvBFjFH1NrFLu4Ex8TeL16Fa9ymloRdp5nY7kE
   ZlBa4yffmt8oGLRG56ofY91o6UOPFHID0/BYKidPWR9r8hbmxWY+Tic4f
   mMppKXODrIe+mwT6mWU/SedqtwoKa4Z3usNXsGQ8+HNgiysXFr0Bpklsp
   6AiDbEphjSMUALFrx8dmcOPHj0VYpi53FwY2h3sULFJWDtWuyuC+7yXE2
   NSe3FRbB7MVwCMU+IFOlQQ1xglmLUzLK7tUupChdahDMjdZoiiOq+FkGd
   PCzU4Ru1xD18uQ/f1xoPO20WyIRtRNDDc2xF6kB3tBN9kYwUeBGtAQOYZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389180223"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="389180223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 08:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="743815729"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="743815729"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 08:44:24 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBdWq-00061Q-0L;
        Tue, 20 Jun 2023 15:44:24 +0000
Date:   Tue, 20 Jun 2023 23:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Message-ID: <202306202308.y7ERKbSP-lkp@intel.com>
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master sailus-media-tree/streams v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuji-Ishikawa/dt-bindings-media-platform-visconti-Add-Toshiba-Visconti-Video-Input-Interface-bindings/20230620-120839
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230620031111.3776-3-yuji2.ishikawa%40toshiba.co.jp
patch subject: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230620/202306202308.y7ERKbSP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306202308.y7ERKbSP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306202308.y7ERKbSP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/visconti_viif.h:12,
                    from <command-line>:
>> usr/include/linux/videodev2.h:2464:41: error: field 'timestamp' has incomplete type
    2464 |         struct timespec                 timestamp;
         |                                         ^~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
