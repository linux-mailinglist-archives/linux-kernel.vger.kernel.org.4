Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653E5B936B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIOD6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOD6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:58:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A59019C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663214294; x=1694750294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ou3orovDGO7Ym4T55ovtKj+SV+c4Frp8323Ah7DjXmk=;
  b=TRICfY1WUB/hpa9aK5v4/G/od13PZACmkCKXjwzKTDg1+8n2ATvNHcDz
   8Jkcrm7nBO5kVqv6TRx2PQIaRMw8+/QzdHwsh5iTAcIFBpZh9VVk9psRh
   G9ejBBXbv2U+6I+NoCuhlOM8BeT50+RkM1K2fhmP153lb0w3gK4NdONSW
   33r+cZBZBV57J4NGAiV7Z14j0X9jmBXmjJh+XtyOarEfyNOLKBtS0Etc9
   qUSNjs+39ZVqj4wjRvehxh85MkMyHL1O1sJM2Abt/azSUvVS1NhfDuk7U
   Q+DuiMG0TuZrM87y4j3xgotFbGksG0nYHCXC+Z4GDFdjXGf41+XxXpXho
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285645984"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="285645984"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="594657122"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 20:58:12 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYg0y-0000qe-0P;
        Thu, 15 Sep 2022 03:58:12 +0000
Date:   Thu, 15 Sep 2022 11:57:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:alt-ctrls 1/2]
 include/media/v4l2-common.h:95:33: warning: 'struct v4l2_queryctrl' declared
 inside parameter list will not be visible outside of this definition or
 declaration
Message-ID: <202209151110.eqcNpg4j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git alt-ctrls
head:   c6e0e18a5be6b8a301595a30ba369cbee4a60807
commit: b28feb32252c212b4d345f0da7ceb285d763e1b9 [1/2] wip
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220915/202209151110.eqcNpg4j-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree alt-ctrls
        git checkout b28feb32252c212b4d345f0da7ceb285d763e1b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/common/ drivers/media/i2c/ drivers/media/pci/bt8xx/ drivers/media/pci/saa7134/ drivers/media/pci/solo6x10/ drivers/media/platform/atmel/ drivers/media/platform/chips-media/ drivers/media/platform/marvell/ drivers/media/platform/renesas/vsp1/ drivers/media/platform/samsung/s5p-mfc/ drivers/media/platform/ti/omap3isp/ drivers/media/platform/ti/vpe/ drivers/media/platform/via/ drivers/media/platform/xilinx/ drivers/media/radio/ drivers/media/test-drivers/ drivers/media/usb/cx231xx/ drivers/media/usb/go7007/ drivers/media/usb/gspca/ drivers/media/usb/pvrusb2/ drivers/media/usb/pwc/ drivers/media/usb/uvc/ drivers/media/v4l2-core/ drivers/staging/media/deprecated/cpia2/ drivers/staging/media/imx/ drivers/video/fbdev/matrox/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/videodev2.h:61,
                    from drivers/media/common/cx2341x.c:14:
   include/uapi/linux/videodev2.h:1859:15: error: unknown type name 'v4l2_ctrl_ptr'
    1859 | static inline v4l2_ctrl_ptr v4l2_ctrl_get_ptr(const struct v4l2_ext_control *c)
         |               ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h: In function 'v4l2_ctrl_get_ptr':
   include/uapi/linux/videodev2.h:1861:9: error: unknown type name 'v4l2_ctrl_ptr'; use 'union' keyword to refer to the type
    1861 |         v4l2_ctrl_ptr p;
         |         ^~~~~~~~~~~~~
         |         union 
   include/uapi/linux/videodev2.h:1864:18: error: request for member 'p_const' in something not a structure or union
    1864 |                 p.p_const = (const void *)(uintptr_t)c->ptr;
         |                  ^
   include/uapi/linux/videodev2.h:1866:18: error: request for member 'p_const' in something not a structure or union
    1866 |                 p.p_const = &c->value;
         |                  ^
   include/uapi/linux/videodev2.h: At top level:
   include/uapi/linux/videodev2.h:1883:38: error: unknown type name 'v4l2_ctrl_ptr'
    1883 |                                      v4l2_ctrl_ptr p, unsigned int elems)
         |                                      ^~~~~~~~~~~~~
   In file included from include/media/v4l2-subdev.h:15,
                    from include/media/v4l2-mc.h:15,
                    from include/media/tuner.h:14,
                    from drivers/media/common/cx2341x.c:16:
>> include/media/v4l2-common.h:95:33: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                                 ^~~~~~~~~~~~~~
   In file included from include/media/drv-intf/cx2341x.h:10,
                    from drivers/media/common/cx2341x.c:17:
   include/media/v4l2-ctrls.h:58:7: error: redefinition of 'union v4l2_ctrl_ptr'
      58 | union v4l2_ctrl_ptr {
         |       ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:1797:7: note: originally defined here
    1797 | union v4l2_ctrl_ptr {
         |       ^~~~~~~~~~~~~
>> include/media/v4l2-ctrls.h:1399:58: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
    1399 | int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc);
         |                                                          ^~~~~~~~~~~~~~
>> include/media/v4l2-ctrls.h:1433:55: warning: 'struct v4l2_control' declared inside parameter list will not be visible outside of this definition or declaration
    1433 | int v4l2_g_ctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_control *ctrl);
         |                                                       ^~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1447:24: warning: 'struct v4l2_control' declared inside parameter list will not be visible outside of this definition or declaration
    1447 |                 struct v4l2_control *ctrl);
         |                        ^~~~~~~~~~~~
>> include/media/v4l2-ctrls.h:1461:56: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1461 |                      struct media_device *mdev, struct v4l2_ext_controls *c);
         |                                                        ^~~~~~~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1477:31: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1477 |                        struct v4l2_ext_controls *c);
         |                               ^~~~~~~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1494:29: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1494 |                      struct v4l2_ext_controls *c);
         |                             ^~~~~~~~~~~~~~~~~
>> include/media/drv-intf/cx2341x.h:85:24: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
      85 |                 struct v4l2_queryctrl *qctrl);
         |                        ^~~~~~~~~~~~~~
>> include/media/drv-intf/cx2341x.h:88:24: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
      88 |                 struct v4l2_ext_controls *ctrls, unsigned int cmd);
         |                        ^~~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c: In function 'cx2341x_ctrl_fill':
   drivers/media/common/cx2341x.c:141:25: error: 'V4L2_CTRL_TYPE_INTEGER' undeclared (first use in this function); did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
     141 |                 *type = V4L2_CTRL_TYPE_INTEGER;
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         V4L2_CTRL_TYPE_INTEGER_MENU
   drivers/media/common/cx2341x.c:141:25: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/common/cx2341x.c: At top level:
>> drivers/media/common/cx2341x.c:537:43: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
     537 | static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                                           ^~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c: In function 'cx2341x_ctrl_query_fill':
   drivers/media/common/cx2341x.c:542:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     542 |         switch (qctrl->id) {
         |                      ^~
   drivers/media/common/cx2341x.c:556:40: error: invalid use of undefined type 'struct v4l2_queryctrl'
     556 |                 cx2341x_ctrl_fill(qctrl->id, &name, &qctrl->type,
         |                                        ^~
   drivers/media/common/cx2341x.c:556:59: error: invalid use of undefined type 'struct v4l2_queryctrl'
     556 |                 cx2341x_ctrl_fill(qctrl->id, &name, &qctrl->type,
         |                                                           ^~
   drivers/media/common/cx2341x.c:557:64: error: invalid use of undefined type 'struct v4l2_queryctrl'
     557 |                                 &min, &max, &step, &def, &qctrl->flags);
         |                                                                ^~
   drivers/media/common/cx2341x.c:558:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     558 |                 qctrl->minimum = min;
         |                      ^~
   drivers/media/common/cx2341x.c:559:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     559 |                 qctrl->maximum = max;
         |                      ^~
   drivers/media/common/cx2341x.c:560:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     560 |                 qctrl->step = step;
         |                      ^~
   drivers/media/common/cx2341x.c:561:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     561 |                 qctrl->default_value = def;
         |                      ^~
   drivers/media/common/cx2341x.c:562:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     562 |                 qctrl->reserved[0] = qctrl->reserved[1] = 0;
         |                      ^~
   drivers/media/common/cx2341x.c:562:43: error: invalid use of undefined type 'struct v4l2_queryctrl'
     562 |                 qctrl->reserved[0] = qctrl->reserved[1] = 0;
         |                                           ^~
   drivers/media/common/cx2341x.c:563:30: error: invalid use of undefined type 'struct v4l2_queryctrl'
     563 |                 strscpy(qctrl->name, name, sizeof(qctrl->name));
         |                              ^~
   drivers/media/common/cx2341x.c:563:56: error: invalid use of undefined type 'struct v4l2_queryctrl'
     563 |                 strscpy(qctrl->name, name, sizeof(qctrl->name));
         |                                                        ^~
   drivers/media/common/cx2341x.c:567:45: error: passing argument 1 of 'v4l2_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     567 |                 return v4l2_ctrl_query_fill(qctrl, min, max, step, def);
         |                                             ^~~~~
         |                                             |
         |                                             struct v4l2_queryctrl *
   include/media/v4l2-common.h:95:49: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/common/cx2341x.c: At top level:
   drivers/media/common/cx2341x.c:572:31: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
     572 |                        struct v4l2_queryctrl *qctrl)
         |                               ^~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c:571:5: error: conflicting types for 'cx2341x_ctrl_query'; have 'int(const struct cx2341x_mpeg_params *, struct v4l2_queryctrl *)'
     571 | int cx2341x_ctrl_query(const struct cx2341x_mpeg_params *params,
         |     ^~~~~~~~~~~~~~~~~~
   include/media/drv-intf/cx2341x.h:84:5: note: previous declaration of 'cx2341x_ctrl_query' with type 'int(const struct cx2341x_mpeg_params *, struct v4l2_queryctrl *)'
      84 | int cx2341x_ctrl_query(const struct cx2341x_mpeg_params *params,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c: In function 'cx2341x_ctrl_query':
   drivers/media/common/cx2341x.c:576:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     576 |         switch (qctrl->id) {
         |                      ^~
   drivers/media/common/cx2341x.c:578:45: error: passing argument 1 of 'v4l2_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     578 |                 return v4l2_ctrl_query_fill(qctrl, 0, 0, 0, 0);
         |                                             ^~~~~
         |                                             |
         |                                             struct v4l2_queryctrl *
   include/media/v4l2-common.h:95:49: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/common/cx2341x.c:580:45: error: passing argument 1 of 'v4l2_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     580 |                 return v4l2_ctrl_query_fill(qctrl,
         |                                             ^~~~~
         |                                             |
         |                                             struct v4l2_queryctrl *
   include/media/v4l2-common.h:95:49: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/common/cx2341x.c:587:53: error: passing argument 1 of 'v4l2_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     587 |                         return v4l2_ctrl_query_fill(qctrl,
         |                                                     ^~~~~
         |                                                     |
         |                                                     struct v4l2_queryctrl *
   include/media/v4l2-common.h:95:49: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/common/cx2341x.c:591:48: error: passing argument 1 of 'cx2341x_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     591 |                 return cx2341x_ctrl_query_fill(qctrl,
         |                                                ^~~~~
         |                                                |
         |                                                struct v4l2_queryctrl *
   drivers/media/common/cx2341x.c:537:59: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
     537 | static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/common/cx2341x.c:597:45: error: passing argument 1 of 'v4l2_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     597 |                 return v4l2_ctrl_query_fill(qctrl,
         |                                             ^~~~~
         |                                             |
         |                                             struct v4l2_queryctrl *
   include/media/v4l2-common.h:95:49: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
--
   drivers/media/common/cx2341x.c:826:22: error: invalid use of undefined type 'struct v4l2_queryctrl'
     826 |                 qctrl->flags |= V4L2_CTRL_FLAG_SLIDER;
         |                      ^~
   drivers/media/common/cx2341x.c:829:30: error: invalid use of undefined type 'struct v4l2_queryctrl'
     829 |                         qctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
         |                              ^~
   drivers/media/common/cx2341x.c:833:48: error: passing argument 1 of 'cx2341x_ctrl_query_fill' from incompatible pointer type [-Werror=incompatible-pointer-types]
     833 |                 return cx2341x_ctrl_query_fill(qctrl, 0, 1, 1,
         |                                                ^~~~~
         |                                                |
         |                                                struct v4l2_queryctrl *
   drivers/media/common/cx2341x.c:537:59: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
     537 | static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/s390/include/asm/timex.h:13,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/media/common/cx2341x.c:9:
   drivers/media/common/cx2341x.c: At top level:
   drivers/media/common/cx2341x.c:841:15: error: conflicting types for 'cx2341x_ctrl_query'; have 'int(const struct cx2341x_mpeg_params *, struct v4l2_queryctrl *)'
     841 | EXPORT_SYMBOL(cx2341x_ctrl_query);
         |               ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:87:28: note: in definition of macro '___EXPORT_SYMBOL'
      87 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
     147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:150:41: note: in expansion of macro '_EXPORT_SYMBOL'
     150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c:841:1: note: in expansion of macro 'EXPORT_SYMBOL'
     841 | EXPORT_SYMBOL(cx2341x_ctrl_query);
         | ^~~~~~~~~~~~~
   include/media/drv-intf/cx2341x.h:84:5: note: previous declaration of 'cx2341x_ctrl_query' with type 'int(const struct cx2341x_mpeg_params *, struct v4l2_queryctrl *)'
      84 | int cx2341x_ctrl_query(const struct cx2341x_mpeg_params *params,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c:924:66: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
     924 | static int v4l2_ctrl_check(struct v4l2_ext_control *ctrl, struct v4l2_queryctrl *qctrl,
         |                                                                  ^~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c: In function 'v4l2_ctrl_check':
   drivers/media/common/cx2341x.c:927:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     927 |         if (qctrl->flags & V4L2_CTRL_FLAG_DISABLED)
         |                  ^~
   drivers/media/common/cx2341x.c:927:28: error: 'V4L2_CTRL_FLAG_DISABLED' undeclared (first use in this function); did you mean 'V4L2_CTRL_FLAG_SLIDER'?
     927 |         if (qctrl->flags & V4L2_CTRL_FLAG_DISABLED)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
         |                            V4L2_CTRL_FLAG_SLIDER
   drivers/media/common/cx2341x.c:929:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     929 |         if (qctrl->flags & V4L2_CTRL_FLAG_GRABBED)
         |                  ^~
   drivers/media/common/cx2341x.c:929:28: error: 'V4L2_CTRL_FLAG_GRABBED' undeclared (first use in this function); did you mean 'V4L2_CTRL_FLAG_SLIDER'?
     929 |         if (qctrl->flags & V4L2_CTRL_FLAG_GRABBED)
         |                            ^~~~~~~~~~~~~~~~~~~~~~
         |                            V4L2_CTRL_FLAG_SLIDER
   drivers/media/common/cx2341x.c:931:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     931 |         if (qctrl->type == V4L2_CTRL_TYPE_STRING)
         |                  ^~
   drivers/media/common/cx2341x.c:931:28: error: 'V4L2_CTRL_TYPE_STRING' undeclared (first use in this function); did you mean 'V4L2_CTRL_FLAG_STRING'?
     931 |         if (qctrl->type == V4L2_CTRL_TYPE_STRING)
         |                            ^~~~~~~~~~~~~~~~~~~~~
         |                            V4L2_CTRL_FLAG_STRING
   drivers/media/common/cx2341x.c:933:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     933 |         if (qctrl->type == V4L2_CTRL_TYPE_BUTTON ||
         |                  ^~
   drivers/media/common/cx2341x.c:934:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     934 |             qctrl->type == V4L2_CTRL_TYPE_INTEGER64 ||
         |                  ^~
   drivers/media/common/cx2341x.c:934:28: error: 'V4L2_CTRL_TYPE_INTEGER64' undeclared (first use in this function); did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
     934 |             qctrl->type == V4L2_CTRL_TYPE_INTEGER64 ||
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
         |                            V4L2_CTRL_TYPE_INTEGER_MENU
   drivers/media/common/cx2341x.c:935:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     935 |             qctrl->type == V4L2_CTRL_TYPE_CTRL_CLASS)
         |                  ^~
   drivers/media/common/cx2341x.c:935:28: error: 'V4L2_CTRL_TYPE_CTRL_CLASS' undeclared (first use in this function); did you mean 'V4L2_CTRL_TYPE_HEVC_PPS'?
     935 |             qctrl->type == V4L2_CTRL_TYPE_CTRL_CLASS)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                            V4L2_CTRL_TYPE_HEVC_PPS
   drivers/media/common/cx2341x.c:937:32: error: invalid use of undefined type 'struct v4l2_queryctrl'
     937 |         if (ctrl->value < qctrl->minimum || ctrl->value > qctrl->maximum)
         |                                ^~
   drivers/media/common/cx2341x.c:937:64: error: invalid use of undefined type 'struct v4l2_queryctrl'
     937 |         if (ctrl->value < qctrl->minimum || ctrl->value > qctrl->maximum)
         |                                                                ^~
   drivers/media/common/cx2341x.c:939:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     939 |         if (qctrl->type == V4L2_CTRL_TYPE_MENU && menu_items != NULL) {
         |                  ^~
   drivers/media/common/cx2341x.c:944:18: error: invalid use of undefined type 'struct v4l2_queryctrl'
     944 |         if (qctrl->type == V4L2_CTRL_TYPE_BITMASK &&
         |                  ^~
   drivers/media/common/cx2341x.c:945:46: error: invalid use of undefined type 'struct v4l2_queryctrl'
     945 |                         (ctrl->value & ~qctrl->maximum))
         |                                              ^~
   drivers/media/common/cx2341x.c: At top level:
>> drivers/media/common/cx2341x.c:951:26: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
     951 |                   struct v4l2_ext_controls *ctrls, unsigned int cmd)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c:950:5: error: conflicting types for 'cx2341x_ext_ctrls'; have 'int(struct cx2341x_mpeg_params *, int,  struct v4l2_ext_controls *, unsigned int)'
     950 | int cx2341x_ext_ctrls(struct cx2341x_mpeg_params *params, int busy,
         |     ^~~~~~~~~~~~~~~~~
   include/media/drv-intf/cx2341x.h:87:5: note: previous declaration of 'cx2341x_ext_ctrls' with type 'int(struct cx2341x_mpeg_params *, int,  struct v4l2_ext_controls *, unsigned int)'
      87 | int cx2341x_ext_ctrls(struct cx2341x_mpeg_params *params, int busy,
         |     ^~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/ioctl.h:5,
                    from ./arch/s390/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/random.h:12,
                    from include/linux/random.h:11,
                    from include/linux/nodemask.h:97,
                    from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17:
   drivers/media/common/cx2341x.c: In function 'cx2341x_ext_ctrls':
   include/uapi/linux/videodev2.h:2694:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_ext_controls'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2694:33: note: in expansion of macro '_IOWR'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                 ^~~~~
   drivers/media/common/cx2341x.c:956:20: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
     956 |         if (cmd == VIDIOC_G_EXT_CTRLS) {
         |                    ^~~~~~~~~~~~~~~~~~
   include/asm-generic/ioctl.h:13:32: error: array type has incomplete element type 'struct v4l2_ext_controls'
      13 |         ((sizeof(t) == sizeof(t[1]) && \
         |                                ^
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2694:33: note: in expansion of macro '_IOWR'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                 ^~~~~
   drivers/media/common/cx2341x.c:956:20: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
     956 |         if (cmd == VIDIOC_G_EXT_CTRLS) {
         |                    ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2694:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_ext_controls'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2694:33: note: in expansion of macro '_IOWR'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                 ^~~~~
   drivers/media/common/cx2341x.c:956:20: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
     956 |         if (cmd == VIDIOC_G_EXT_CTRLS) {
         |                    ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2694:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_ext_controls'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2694:33: note: in expansion of macro '_IOWR'
    2694 | #define VIDIOC_G_EXT_CTRLS      _IOWR('V', 71, struct v4l2_ext_controls)
         |                                 ^~~~~
   drivers/media/common/cx2341x.c:956:20: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
     956 |         if (cmd == VIDIOC_G_EXT_CTRLS) {
         |                    ^~~~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c:957:38: error: invalid use of undefined type 'struct v4l2_ext_controls'
     957 |                 for (i = 0; i < ctrls->count; i++) {
         |                                      ^~
   drivers/media/common/cx2341x.c:958:62: error: invalid use of undefined type 'struct v4l2_ext_controls'
     958 |                         struct v4l2_ext_control *ctrl = ctrls->controls + i;
         |                                                              ^~
   drivers/media/common/cx2341x.c:962:38: error: invalid use of undefined type 'struct v4l2_ext_controls'
     962 |                                 ctrls->error_idx = i;
         |                                      ^~
   drivers/media/common/cx2341x.c:968:30: error: invalid use of undefined type 'struct v4l2_ext_controls'
     968 |         for (i = 0; i < ctrls->count; i++) {
         |                              ^~
   drivers/media/common/cx2341x.c:969:54: error: invalid use of undefined type 'struct v4l2_ext_controls'
     969 |                 struct v4l2_ext_control *ctrl = ctrls->controls + i;
         |                                                      ^~
   drivers/media/common/cx2341x.c:970:39: error: storage size of 'qctrl' isn't known
     970 |                 struct v4l2_queryctrl qctrl;
         |                                       ^~~~~
   drivers/media/common/cx2341x.c:970:39: warning: unused variable 'qctrl' [-Wunused-variable]
   drivers/media/common/cx2341x.c:990:22: error: invalid use of undefined type 'struct v4l2_ext_controls'
..


vim +95 include/media/v4l2-common.h

7e8b09ea1636e3 Hans Verkuil          2006-01-09  55  
dd99120c7165c6 Hans Verkuil          2008-11-23  56  /* These printk constructs can be used with v4l2_device and v4l2_subdev */
dd99120c7165c6 Hans Verkuil          2008-11-23  57  #define v4l2_printk(level, dev, fmt, arg...) \
dd99120c7165c6 Hans Verkuil          2008-11-23  58  	printk(level "%s: " fmt, (dev)->name , ## arg)
dd99120c7165c6 Hans Verkuil          2008-11-23  59  
dd99120c7165c6 Hans Verkuil          2008-11-23  60  #define v4l2_err(dev, fmt, arg...) \
dd99120c7165c6 Hans Verkuil          2008-11-23  61  	v4l2_printk(KERN_ERR, dev, fmt , ## arg)
dd99120c7165c6 Hans Verkuil          2008-11-23  62  
dd99120c7165c6 Hans Verkuil          2008-11-23  63  #define v4l2_warn(dev, fmt, arg...) \
dd99120c7165c6 Hans Verkuil          2008-11-23  64  	v4l2_printk(KERN_WARNING, dev, fmt , ## arg)
dd99120c7165c6 Hans Verkuil          2008-11-23  65  
dd99120c7165c6 Hans Verkuil          2008-11-23  66  #define v4l2_info(dev, fmt, arg...) \
dd99120c7165c6 Hans Verkuil          2008-11-23  67  	v4l2_printk(KERN_INFO, dev, fmt , ## arg)
dd99120c7165c6 Hans Verkuil          2008-11-23  68  
dd99120c7165c6 Hans Verkuil          2008-11-23  69  /* These three macros assume that the debug level is set with a module
dd99120c7165c6 Hans Verkuil          2008-11-23  70     parameter called 'debug'. */
dd99120c7165c6 Hans Verkuil          2008-11-23  71  #define v4l2_dbg(level, debug, dev, fmt, arg...)			\
dd99120c7165c6 Hans Verkuil          2008-11-23  72  	do {								\
dd99120c7165c6 Hans Verkuil          2008-11-23  73  		if (debug >= (level))					\
dd99120c7165c6 Hans Verkuil          2008-11-23  74  			v4l2_printk(KERN_DEBUG, dev, fmt , ## arg);	\
dd99120c7165c6 Hans Verkuil          2008-11-23  75  	} while (0)
dd99120c7165c6 Hans Verkuil          2008-11-23  76  
b871915893c324 Mauro Carvalho Chehab 2016-07-21  77  /**
b871915893c324 Mauro Carvalho Chehab 2016-07-21  78   * v4l2_ctrl_query_fill- Fill in a struct v4l2_queryctrl
b871915893c324 Mauro Carvalho Chehab 2016-07-21  79   *
b871915893c324 Mauro Carvalho Chehab 2016-07-21  80   * @qctrl: pointer to the &struct v4l2_queryctrl to be filled
b871915893c324 Mauro Carvalho Chehab 2016-07-21  81   * @min: minimum value for the control
b871915893c324 Mauro Carvalho Chehab 2016-07-21  82   * @max: maximum value for the control
b871915893c324 Mauro Carvalho Chehab 2016-07-21  83   * @step: control step
b871915893c324 Mauro Carvalho Chehab 2016-07-21  84   * @def: default value for the control
b871915893c324 Mauro Carvalho Chehab 2016-07-21  85   *
b871915893c324 Mauro Carvalho Chehab 2016-07-21  86   * Fills the &struct v4l2_queryctrl fields for the query control.
b871915893c324 Mauro Carvalho Chehab 2016-07-21  87   *
b871915893c324 Mauro Carvalho Chehab 2016-07-21  88   * .. note::
b871915893c324 Mauro Carvalho Chehab 2016-07-21  89   *
b871915893c324 Mauro Carvalho Chehab 2016-07-21  90   *    This function assumes that the @qctrl->id field is filled.
b871915893c324 Mauro Carvalho Chehab 2016-07-21  91   *
b871915893c324 Mauro Carvalho Chehab 2016-07-21  92   * Returns -EINVAL if the control is not known by the V4L2 core, 0 on success.
b871915893c324 Mauro Carvalho Chehab 2016-07-21  93   */
dd99120c7165c6 Hans Verkuil          2008-11-23  94  
b871915893c324 Mauro Carvalho Chehab 2016-07-21 @95  int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
b871915893c324 Mauro Carvalho Chehab 2016-07-21  96  			 s32 min, s32 max, s32 step, s32 def);
9cb2318b885d20 Hans Verkuil          2006-06-18  97  

:::::: The code at line 95 was first introduced by commit
:::::: b871915893c32473ef5ce0d075c1952ed8232ce1 [media] v4l2-common.h: Add documentation for other functions

:::::: TO: Mauro Carvalho Chehab <mchehab@s-opensource.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
