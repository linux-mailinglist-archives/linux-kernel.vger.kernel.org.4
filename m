Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F3D73F8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjF0J0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0J0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:26:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420D1737;
        Tue, 27 Jun 2023 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687858007; x=1719394007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FaFTUsuBZJ02JNJ3CCmt7qbSzKUt2W9+oeZFpl/EjGE=;
  b=iJ4eFSgth/hcmpJDQ8dZHuk1lzkptNfO2TnXc73WxlvOkdKdHaWNCY2L
   v6RjgtW5/jX3b3M2PHVoIcoMykG6+ClgWwadtjPpJVuLn8Kq1L62tS/9d
   k1XnV26aAtLDiO1HWN0lVeiCP/dbAwZXYssuSjq0TX8dacSenPJpTdIKo
   QatpqedqN8XLN89KwJ/Xg5DJSZSwwU0yZTIm99ePytfsr2Wfk7Ttm41bj
   4cRRyjnKWRwBgsLBKad92BYmm46sqPBWc0Sa7Pj3LEUoary9ncIcU4RTF
   1K35rwrhL7wQEj22GXr3fhoNwjK8RD9LqdpqZzqGHZB517urgEG3UJock
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341112633"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="341112633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 02:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666630604"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="666630604"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2023 02:26:03 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qE4xW-000BrB-2Y;
        Tue, 27 Jun 2023 09:26:02 +0000
Date:   Tue, 27 Jun 2023 17:25:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: Re: [PATCH v3 3/4] Input: st1232 - add overlay touchscreen and
 buttons handling
Message-ID: <202306271711.B8sjkaYH-lkp@intel.com>
References: <20230510-feature-ts_virtobj_patch-v3-3-b4fb7fc4bab7@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v3-3-b4fb7fc4bab7@wolfvision.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

kernel test robot noticed the following build errors:

[auto build test ERROR on ac9a78681b921877518763ba0e89202254349d1b]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/Input-ts-overlay-Add-touchscreen-overlay-object-handling/20230616-153203
base:   ac9a78681b921877518763ba0e89202254349d1b
patch link:    https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-3-b4fb7fc4bab7%40wolfvision.net
patch subject: [PATCH v3 3/4] Input: st1232 - add overlay touchscreen and buttons handling
config: microblaze-randconfig-r051-20230625 (https://download.01.org/0day-ci/archive/20230627/202306271711.B8sjkaYH-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306271711.B8sjkaYH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306271711.B8sjkaYH-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ts_overlay_is_button_slot" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_button_press" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_mt_on_touchscreen" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_mapped_buttons" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_button_release" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_map_objects" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_mapped_touchscreen" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_get_touchscreen_abs" [drivers/input/touchscreen/st1232.ko] undefined!
>> ERROR: modpost: "ts_overlay_set_button_caps" [drivers/input/touchscreen/st1232.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
