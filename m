Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73926B573C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCKBGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCKBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:06:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D714626B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678496799; x=1710032799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFlIn+JZ3z1wP1i72hr4lJuGlwH1uBFpybV7Fncs9cY=;
  b=agWdhWAV4XxHLbePMKEsWQhqsNNo8MwSRXxc8scuJsUpcqQ8IEaEEJ7Z
   TknIfsfv7PeVeXEuqull6BVyT9aerq3RbVvJFsaIMMFHREY07RlpTzmwY
   g7eqctx0GHH++oIkz2Zg4s7YeNOarUVgxukbnuQxlDqvYXx9/K/BVW4vk
   eqz8vv7py93r+fHMmg51JsXCeY72AxhUZ6ncCm17anbhqGV5OLOygVPw1
   no0I9xEhtLXeLulkjt0PFzDcoJEVHb1tHvSIIBpSXaESykY/sKoNA/dT7
   bwiF28pXuiU9egbS/MIfLIKPBMJWNRwv4ZilsUHlGBBMI+Gzp/jlgzJWS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="317252720"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="317252720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 17:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746943351"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="746943351"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 17:06:37 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pangy-0004F3-0i;
        Sat, 11 Mar 2023 01:06:36 +0000
Date:   Sat, 11 Mar 2023 09:06:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750: Rename camel case functions in
 sm750_cursor.*
Message-ID: <202303110849.X24WnHnM-lkp@intel.com>
References: <ZAuiDTDT8dmBcRoH@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAuiDTDT8dmBcRoH@CloudiRingWorld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kloudifold,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Kloudifold/staging-sm750-Rename-camel-case-functions-in-sm750_cursor/20230311-053447
patch link:    https://lore.kernel.org/r/ZAuiDTDT8dmBcRoH%40CloudiRingWorld
patch subject: [PATCH] staging: sm750: Rename camel case functions in sm750_cursor.*
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230311/202303110849.X24WnHnM-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c82f66fbd5902ae486c4e2227e5071a59c49a05a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kloudifold/staging-sm750-Rename-camel-case-functions-in-sm750_cursor/20230311-053447
        git checkout c82f66fbd5902ae486c4e2227e5071a59c49a05a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_ops_cursor':
>> drivers/staging/sm750fb/sm750.c:124:17: error: implicit declaration of function 'sm750_hw_cursor_setSize'; did you mean 'sm750_hw_cursor_set_size'? [-Werror=implicit-function-declaration]
     124 |                 sm750_hw_cursor_setSize(cursor,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 sm750_hw_cursor_set_size
>> drivers/staging/sm750fb/sm750.c:129:17: error: implicit declaration of function 'sm750_hw_cursor_setPos'; did you mean 'sm750_hw_cursor_set_pos'? [-Werror=implicit-function-declaration]
     129 |                 sm750_hw_cursor_setPos(cursor,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 sm750_hw_cursor_set_pos
>> drivers/staging/sm750fb/sm750.c:145:17: error: implicit declaration of function 'sm750_hw_cursor_setColor'; did you mean 'sm750_hw_cursor_set_color'? [-Werror=implicit-function-declaration]
     145 |                 sm750_hw_cursor_setColor(cursor, fg, bg);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 sm750_hw_cursor_set_color
>> drivers/staging/sm750fb/sm750.c:149:17: error: implicit declaration of function 'sm750_hw_cursor_setData'; did you mean 'sm750_hw_cursor_set_data'? [-Werror=implicit-function-declaration]
     149 |                 sm750_hw_cursor_setData(cursor,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 sm750_hw_cursor_set_data
   cc1: some warnings being treated as errors


vim +124 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee      2015-03-03  104  
81dee67e215b23 Sudip Mukherjee      2015-03-03  105  /* no hardware cursor supported under version 2.6.10, kernel bug */
81dee67e215b23 Sudip Mukherjee      2015-03-03  106  static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
81dee67e215b23 Sudip Mukherjee      2015-03-03  107  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  108  	struct lynxfb_par *par;
81dee67e215b23 Sudip Mukherjee      2015-03-03  109  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  110  	struct lynx_cursor *cursor;
81dee67e215b23 Sudip Mukherjee      2015-03-03  111  
81dee67e215b23 Sudip Mukherjee      2015-03-03  112  	par = info->par;
81dee67e215b23 Sudip Mukherjee      2015-03-03  113  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  114  	cursor = &crtc->cursor;
81dee67e215b23 Sudip Mukherjee      2015-03-03  115  
39f9137268ee3d Benjamin Philip      2021-07-26  116  	if (fbcursor->image.width > cursor->max_w ||
cfdafb7608b4cf Benjamin Philip      2021-07-26  117  	    fbcursor->image.height > cursor->max_h ||
81dee67e215b23 Sudip Mukherjee      2015-03-03  118  	    fbcursor->image.depth > 1) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  119  		return -ENXIO;
81dee67e215b23 Sudip Mukherjee      2015-03-03  120  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  121  
52d0744d751d8f Arnd Bergmann        2016-11-09  122  	sm750_hw_cursor_disable(cursor);
f46a04c75605fd Michel von Czettritz 2015-03-27  123  	if (fbcursor->set & FB_CUR_SETSIZE)
52d0744d751d8f Arnd Bergmann        2016-11-09 @124  		sm750_hw_cursor_setSize(cursor,
3318bb5e945f70 Michel von Czettritz 2015-03-26  125  					fbcursor->image.width,
3318bb5e945f70 Michel von Czettritz 2015-03-26  126  					fbcursor->image.height);
81dee67e215b23 Sudip Mukherjee      2015-03-03  127  
3318bb5e945f70 Michel von Czettritz 2015-03-26  128  	if (fbcursor->set & FB_CUR_SETPOS)
52d0744d751d8f Arnd Bergmann        2016-11-09 @129  		sm750_hw_cursor_setPos(cursor,
3318bb5e945f70 Michel von Czettritz 2015-03-26  130  				       fbcursor->image.dx - info->var.xoffset,
81dee67e215b23 Sudip Mukherjee      2015-03-03  131  				       fbcursor->image.dy - info->var.yoffset);
81dee67e215b23 Sudip Mukherjee      2015-03-03  132  
81dee67e215b23 Sudip Mukherjee      2015-03-03  133  	if (fbcursor->set & FB_CUR_SETCMAP) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  134  		/* get the 16bit color of kernel means */
81dee67e215b23 Sudip Mukherjee      2015-03-03  135  		u16 fg, bg;
876e5a701f17e4 Michel von Czettritz 2015-03-26  136  
81dee67e215b23 Sudip Mukherjee      2015-03-03  137  		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
81dee67e215b23 Sudip Mukherjee      2015-03-03  138  		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
81dee67e215b23 Sudip Mukherjee      2015-03-03  139  		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
81dee67e215b23 Sudip Mukherjee      2015-03-03  140  
81dee67e215b23 Sudip Mukherjee      2015-03-03  141  		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800)) |
81dee67e215b23 Sudip Mukherjee      2015-03-03  142  		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
81dee67e215b23 Sudip Mukherjee      2015-03-03  143  		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
81dee67e215b23 Sudip Mukherjee      2015-03-03  144  
52d0744d751d8f Arnd Bergmann        2016-11-09 @145  		sm750_hw_cursor_setColor(cursor, fg, bg);
81dee67e215b23 Sudip Mukherjee      2015-03-03  146  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  147  
70407df77665c0 Michel von Czettritz 2015-03-26  148  	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
52d0744d751d8f Arnd Bergmann        2016-11-09 @149  		sm750_hw_cursor_setData(cursor,
81dee67e215b23 Sudip Mukherjee      2015-03-03  150  					fbcursor->rop,
81dee67e215b23 Sudip Mukherjee      2015-03-03  151  					fbcursor->image.data,
81dee67e215b23 Sudip Mukherjee      2015-03-03  152  					fbcursor->mask);
81dee67e215b23 Sudip Mukherjee      2015-03-03  153  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  154  
f46a04c75605fd Michel von Czettritz 2015-03-27  155  	if (fbcursor->enable)
52d0744d751d8f Arnd Bergmann        2016-11-09  156  		sm750_hw_cursor_enable(cursor);
81dee67e215b23 Sudip Mukherjee      2015-03-03  157  
81dee67e215b23 Sudip Mukherjee      2015-03-03  158  	return 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  159  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
