Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915869BBCE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBRUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:21:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311A149B4;
        Sat, 18 Feb 2023 12:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676751672; x=1708287672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m3g9HARJDWSQCFbwk3Iio0QGai5OhbW12/y2dD16p5M=;
  b=IUfsBixqMpAnrYj3iPRN1IIafYz/ZuVmCTZeGYYUb9YbQk0pFTu8gU86
   LN24sbzd3pK9vxkva6pjlr9butU58V+EVwTox4Q6+seLN2qGgQSUvignj
   A66O7P23N/WANBmfC0VZycuvAmzFIPkY0pYFR0kAH2+/YyRiAN99WxHTt
   az0BdjhW55ilmjk0+2RsA1BEcFJLJ2PXR7mYgLHmLdQCHeAuThAxY/XyQ
   gepAXIJo8B/nMbvHtYiIEvkk9+kcjjVRmD2dRg4itrs9dWDTGl+sXeZY3
   XPvwQ/kPTIjQh92KmuIAKgn2poknIcQOeOoeTmBJk7FPTyfXeNKBveOQF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="311830881"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="311830881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 12:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="794779148"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="794779148"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2023 12:20:13 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTTgq-000Chd-02;
        Sat, 18 Feb 2023 20:20:12 +0000
Date:   Sun, 19 Feb 2023 04:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawel Laszczak <pawell@cadence.com>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daisy.Barrera@siriusxm.com,
        Cliff.Holden@siriusxm.com, arnd@arndb.de, tony@atomide.com,
        jdelvare@suse.de, neal_liu@aspeedtech.com,
        linus.walleij@linaro.org, egtvedt@samfundet.no,
        biju.das.jz@bp.renesas.com, herve.codina@bootlin.com,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH 3/4] usb: cdns2: Add tracepoints for CDNS2 driver
Message-ID: <202302190436.AU6zwie0-lkp@intel.com>
References: <20230216105411.364157-4-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216105411.364157-4-pawell@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next soc/for-next linus/master v6.2-rc8 next-20230217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Laszczak/usb-cdns2-Device-side-header-file-for-CDNS2-driver/20230216-195428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230216105411.364157-4-pawell%40cadence.com
patch subject: [PATCH 3/4] usb: cdns2: Add tracepoints for CDNS2 driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230219/202302190436.AU6zwie0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/edb55f1c0a0ffe341211e08b1ebf162f48dd5b83
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pawel-Laszczak/usb-cdns2-Device-side-header-file-for-CDNS2-driver/20230216-195428
        git checkout edb55f1c0a0ffe341211e08b1ebf162f48dd5b83
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302190436.AU6zwie0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/gadget/udc/cdns2/cdns2-trace.h:29,
                    from drivers/usb/gadget/udc/cdns2/cdns2-gadget.c:36:
   drivers/usb/gadget/udc/cdns2/cdns2-debug.h: In function 'cdns2_decode_trb':
>> drivers/usb/gadget/udc/cdns2/cdns2-debug.h:165:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     165 |         int ret;
         |             ^~~
   drivers/usb/gadget/udc/cdns2/cdns2-gadget.c: In function 'cdns2_gadget_ep_enable':
   drivers/usb/gadget/udc/cdns2/cdns2-gadget.c:1408:49: warning: variable 'comp_desc' set but not used [-Wunused-but-set-variable]
    1408 |         const struct usb_ss_ep_comp_descriptor *comp_desc;
         |                                                 ^~~~~~~~~
--
   In file included from drivers/usb/gadget/udc/cdns2/cdns2-trace.h:29,
                    from drivers/usb/gadget/udc/cdns2/cdns2-ep0.c:13:
   drivers/usb/gadget/udc/cdns2/cdns2-debug.h: In function 'cdns2_decode_trb':
>> drivers/usb/gadget/udc/cdns2/cdns2-debug.h:165:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     165 |         int ret;
         |             ^~~
   drivers/usb/gadget/udc/cdns2/cdns2-ep0.c: In function 'cdns2_ep0_stall':
   drivers/usb/gadget/udc/cdns2/cdns2-ep0.c:93:12: warning: variable 'reg' set but not used [-Wunused-but-set-variable]
      93 |         u8 reg;
         |            ^~~


vim +/ret +165 drivers/usb/gadget/udc/cdns2/cdns2-debug.h

   160	
   161	static inline const char *cdns2_decode_trb(char *str, size_t size, u32 flags,
   162						   u32 length, u32 buffer)
   163	{
   164		int type = TRB_FIELD_TO_TYPE(flags);
 > 165		int ret;
   166	
   167		switch (type) {
   168		case TRB_LINK:
   169			ret = snprintf(str, size,
   170				       "LINK %08x type '%s' flags %c:%c:%c%c:%c",
   171				       buffer, cdns2_trb_type_string(type),
   172				       flags & TRB_CYCLE ? 'C' : 'c',
   173				       flags & TRB_TOGGLE ? 'T' : 't',
   174				       flags & TRB_CHAIN ? 'C' : 'c',
   175				       flags & TRB_CHAIN ? 'H' : 'h',
   176				       flags & TRB_IOC ? 'I' : 'i');
   177			break;
   178		case TRB_NORMAL:
   179			ret = snprintf(str, size,
   180				       "type: '%s', Buffer: %08x, length: %ld, burst len: %ld, "
   181				       "flags %c:%c:%c%c:%c",
   182				       cdns2_trb_type_string(type),
   183				       buffer, TRB_LEN(length),
   184				       TRB_FIELD_TO_BURST(length),
   185				       flags & TRB_CYCLE ? 'C' : 'c',
   186				       flags & TRB_ISP ? 'I' : 'i',
   187				       flags & TRB_CHAIN ? 'C' : 'c',
   188				       flags & TRB_CHAIN ? 'H' : 'h',
   189				       flags & TRB_IOC ? 'I' : 'i');
   190			break;
   191		default:
   192			ret = snprintf(str, size, "type '%s' -> raw %08x %08x %08x",
   193				       cdns2_trb_type_string(type),
   194				       buffer, length, flags);
   195		}
   196	
   197		return str;
   198	}
   199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
