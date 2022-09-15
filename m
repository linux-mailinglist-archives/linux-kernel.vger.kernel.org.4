Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746395B9669
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIOIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiIOIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:32:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303597EC4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663230767; x=1694766767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yKpCtRI+05h6oOj99nvAvi26eHlk4Otmxs6a5EVTAnw=;
  b=H0KspHyGSvA32ow3/0+bHoT/24MqNEQXU9eNXAR25odOILb63M9QdUrY
   8q6UkSauCVZrvNk175PycB2RsztJi2fMPIGtiJabkKpT6Pa/ObdEePE6H
   5QD1UBEXYsRxfqPC2Vxyx5JGtN0Jmht3tc+ZeW4mFDD84P15eHWjUannW
   CWGbgNbHI8wJgxahFvFaw/lIqfAXpXl7+I/Zoub0zn3Zidsh4nQwC5UHt
   eMFQ8oC4WP+b5vE8Pe7uVOHxul0YZGRLrikX1xh2RoE7YkxfTaLdfGScX
   9PP7BQPaGv6+iwpGLrKgq1sblI5mDTUCf6bMUz2OY35zqkz9cBe7/YOOD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="279038028"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="279038028"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 01:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="594732482"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2022 01:32:44 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYkId-0000Dn-1u;
        Thu, 15 Sep 2022 08:32:43 +0000
Date:   Thu, 15 Sep 2022 16:32:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:alt-ctrls 1/2]
 drivers/media/common/cx2341x.c:141:11: error: use of undeclared identifier
 'V4L2_CTRL_TYPE_INTEGER'; did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
Message-ID: <202209151604.w1IZY8bd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git alt-ctrls
head:   c6e0e18a5be6b8a301595a30ba369cbee4a60807
commit: b28feb32252c212b4d345f0da7ceb285d763e1b9 [1/2] wip
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220915/202209151604.w1IZY8bd-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree alt-ctrls
        git checkout b28feb32252c212b4d345f0da7ceb285d763e1b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/common/ drivers/media/i2c/ drivers/media/pci/bt8xx/ drivers/media/pci/saa7134/ drivers/media/usb/cx231xx/ drivers/media/usb/pvrusb2/ drivers/media/usb/pwc/ drivers/media/usb/uvc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:703:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:173:10: note: expanded from macro '_SIG_SET_OP'
           case 4: set->sig[3] = op(set->sig[3]);                          \
                   ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/common/cx2341x.c:16:
   In file included from include/media/tuner.h:14:
   In file included from include/media/v4l2-mc.h:13:
   In file included from include/media/media-device.h:16:
   In file included from include/linux/pci.h:1530:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:703:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:20: note: expanded from macro '_SIG_SET_OP'
                   set->sig[2] = op(set->sig[2]);                          \
                                    ^        ~
   include/linux/signal.h:185:24: note: expanded from macro '_sig_not'
   #define _sig_not(x)     (~(x))
                              ^
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/common/cx2341x.c:16:
   In file included from include/media/tuner.h:14:
   In file included from include/media/v4l2-mc.h:13:
   In file included from include/media/media-device.h:16:
   In file included from include/linux/pci.h:1530:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:703:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:3: note: expanded from macro '_SIG_SET_OP'
                   set->sig[2] = op(set->sig[2]);                          \
                   ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/common/cx2341x.c:16:
   In file included from include/media/tuner.h:14:
   In file included from include/media/v4l2-mc.h:15:
   In file included from include/media/v4l2-subdev.h:15:
   include/media/v4l2-common.h:95:33: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
   int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                   ^
   In file included from drivers/media/common/cx2341x.c:17:
   In file included from include/media/drv-intf/cx2341x.h:10:
   include/media/v4l2-ctrls.h:58:7: error: redefinition of 'v4l2_ctrl_ptr'
   union v4l2_ctrl_ptr {
         ^
   include/uapi/linux/videodev2.h:1797:7: note: previous definition is here
   union v4l2_ctrl_ptr {
         ^
   In file included from drivers/media/common/cx2341x.c:17:
   In file included from include/media/drv-intf/cx2341x.h:10:
   include/media/v4l2-ctrls.h:1399:58: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
   int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc);
                                                            ^
   include/media/v4l2-ctrls.h:1433:55: warning: declaration of 'struct v4l2_control' will not be visible outside of this function [-Wvisibility]
   int v4l2_g_ctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_control *ctrl);
                                                         ^
   include/media/v4l2-ctrls.h:1447:10: warning: declaration of 'struct v4l2_control' will not be visible outside of this function [-Wvisibility]
                   struct v4l2_control *ctrl);
                          ^
   include/media/v4l2-ctrls.h:1461:42: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                        struct media_device *mdev, struct v4l2_ext_controls *c);
                                                          ^
   include/media/v4l2-ctrls.h:1477:17: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                          struct v4l2_ext_controls *c);
                                 ^
   include/media/v4l2-ctrls.h:1494:15: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                        struct v4l2_ext_controls *c);
                               ^
   In file included from drivers/media/common/cx2341x.c:17:
>> include/media/drv-intf/cx2341x.h:85:10: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
                   struct v4l2_queryctrl *qctrl);
                          ^
>> include/media/drv-intf/cx2341x.h:88:10: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                   struct v4l2_ext_controls *ctrls, unsigned int cmd);
                          ^
>> drivers/media/common/cx2341x.c:141:11: error: use of undeclared identifier 'V4L2_CTRL_TYPE_INTEGER'; did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
                   *type = V4L2_CTRL_TYPE_INTEGER;
                           ^~~~~~~~~~~~~~~~~~~~~~
                           V4L2_CTRL_TYPE_INTEGER_MENU
   include/uapi/linux/videodev2.h:1908:2: note: 'V4L2_CTRL_TYPE_INTEGER_MENU' declared here
           V4L2_CTRL_TYPE_INTEGER_MENU  = 9,
           ^
   drivers/media/common/cx2341x.c:537:43: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:542:15: error: incomplete definition of type 'struct v4l2_queryctrl'
           switch (qctrl->id) {
                   ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:556:26: error: incomplete definition of type 'struct v4l2_queryctrl'
                   cx2341x_ctrl_fill(qctrl->id, &name, &qctrl->type,
                                     ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:556:45: error: incomplete definition of type 'struct v4l2_queryctrl'
                   cx2341x_ctrl_fill(qctrl->id, &name, &qctrl->type,
                                                        ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:557:36: error: incomplete definition of type 'struct v4l2_queryctrl'
                                   &min, &max, &step, &def, &qctrl->flags);
                                                             ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:558:8: error: incomplete definition of type 'struct v4l2_queryctrl'
                   qctrl->minimum = min;
                   ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:559:8: error: incomplete definition of type 'struct v4l2_queryctrl'
                   qctrl->maximum = max;
                   ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:560:8: error: incomplete definition of type 'struct v4l2_queryctrl'
                   qctrl->step = step;
                   ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:561:8: error: incomplete definition of type 'struct v4l2_queryctrl'
                   qctrl->default_value = def;
                   ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:562:8: error: incomplete definition of type 'struct v4l2_queryctrl'
                   qctrl->reserved[0] = qctrl->reserved[1] = 0;
                   ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:562:29: error: incomplete definition of type 'struct v4l2_queryctrl'
                   qctrl->reserved[0] = qctrl->reserved[1] = 0;
                                        ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:563:16: error: incomplete definition of type 'struct v4l2_queryctrl'
                   strscpy(qctrl->name, name, sizeof(qctrl->name));
                           ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:563:42: error: incomplete definition of type 'struct v4l2_queryctrl'
                   strscpy(qctrl->name, name, sizeof(qctrl->name));
                                                     ~~~~~^
   drivers/media/common/cx2341x.c:537:43: note: forward declaration of 'struct v4l2_queryctrl'
   static int cx2341x_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                             ^
   drivers/media/common/cx2341x.c:567:31: error: incompatible pointer types passing 'struct v4l2_queryctrl *' to parameter of type 'struct v4l2_queryctrl *' [-Werror,-Wincompatible-pointer-types]
                   return v4l2_ctrl_query_fill(qctrl, min, max, step, def);
                                               ^~~~~
   include/media/v4l2-common.h:95:49: note: passing argument to parameter 'qctrl' here
   int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                                   ^
   drivers/media/common/cx2341x.c:572:17: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
                          struct v4l2_queryctrl *qctrl)
                                 ^
   drivers/media/common/cx2341x.c:571:5: error: conflicting types for 'cx2341x_ctrl_query'
   int cx2341x_ctrl_query(const struct cx2341x_mpeg_params *params,
       ^
   include/media/drv-intf/cx2341x.h:84:5: note: previous declaration is here
   int cx2341x_ctrl_query(const struct cx2341x_mpeg_params *params,
       ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   39 warnings and 20 errors generated.
--
                                    ^        ~
   include/linux/signal.h:185:24: note: expanded from macro '_sig_not'
   #define _sig_not(x)     (~(x))
                              ^
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/i2c/mt9m111.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:173:10: note: expanded from macro '_SIG_SET_OP'
           case 4: set->sig[3] = op(set->sig[3]);                          \
                   ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/i2c/mt9m111.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:20: note: expanded from macro '_SIG_SET_OP'
                   set->sig[2] = op(set->sig[2]);                          \
                                    ^        ~
   include/linux/signal.h:185:24: note: expanded from macro '_sig_not'
   #define _sig_not(x)     (~(x))
                              ^
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/i2c/mt9m111.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:3: note: expanded from macro '_SIG_SET_OP'
                   set->sig[2] = op(set->sig[2]);                          \
                   ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/media/i2c/mt9m111.c:19:
   include/media/v4l2-common.h:95:33: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
   int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
                                   ^
   In file included from drivers/media/i2c/mt9m111.c:20:
   include/media/v4l2-ctrls.h:58:7: error: redefinition of 'v4l2_ctrl_ptr'
   union v4l2_ctrl_ptr {
         ^
   include/uapi/linux/videodev2.h:1797:7: note: previous definition is here
   union v4l2_ctrl_ptr {
         ^
   In file included from drivers/media/i2c/mt9m111.c:20:
   include/media/v4l2-ctrls.h:1399:58: warning: declaration of 'struct v4l2_queryctrl' will not be visible outside of this function [-Wvisibility]
   int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc);
                                                            ^
   include/media/v4l2-ctrls.h:1433:55: warning: declaration of 'struct v4l2_control' will not be visible outside of this function [-Wvisibility]
   int v4l2_g_ctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_control *ctrl);
                                                         ^
   include/media/v4l2-ctrls.h:1447:10: warning: declaration of 'struct v4l2_control' will not be visible outside of this function [-Wvisibility]
                   struct v4l2_control *ctrl);
                          ^
   include/media/v4l2-ctrls.h:1461:42: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                        struct media_device *mdev, struct v4l2_ext_controls *c);
                                                          ^
   include/media/v4l2-ctrls.h:1477:17: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                          struct v4l2_ext_controls *c);
                                 ^
   include/media/v4l2-ctrls.h:1494:15: warning: declaration of 'struct v4l2_ext_controls' will not be visible outside of this function [-Wvisibility]
                        struct v4l2_ext_controls *c);
                               ^
>> drivers/media/i2c/mt9m111.c:869:42: error: array has incomplete element type 'const struct v4l2_control'
           static const struct v4l2_control colorfx[] = {
                                                   ^
   drivers/media/i2c/mt9m111.c:869:22: note: forward declaration of 'struct v4l2_control'
           static const struct v4l2_control colorfx[] = {
                               ^
   35 warnings and 5 errors generated.
..


vim +141 drivers/media/common/cx2341x.c

f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  118  
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  119  static void cx2341x_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  120  		    s32 *min, s32 *max, s32 *step, s32 *def, u32 *flags)
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  121  {
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  122  	*name = cx2341x_get_name(id);
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  123  	*flags = 0;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  124  
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  125  	switch (id) {
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  126  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  127  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  128  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  129  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  130  	case V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  131  		*type = V4L2_CTRL_TYPE_MENU;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  132  		*min = 0;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  133  		*step = 0;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  134  		break;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  135  	case V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  136  		*type = V4L2_CTRL_TYPE_BOOLEAN;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  137  		*min = 0;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  138  		*max = *step = 1;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  139  		break;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  140  	default:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24 @141  		*type = V4L2_CTRL_TYPE_INTEGER;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  142  		break;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  143  	}
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  144  	switch (id) {
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  145  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  146  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  147  	case V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  148  		*flags |= V4L2_CTRL_FLAG_UPDATE;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  149  		break;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  150  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  151  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  152  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  153  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  154  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  155  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  156  		*flags |= V4L2_CTRL_FLAG_SLIDER;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  157  		break;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  158  	case V4L2_CID_MPEG_VIDEO_ENCODING:
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  159  		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  160  		break;
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  161  	}
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  162  }
f6e114eed0414f drivers/media/video/cx2341x.c Hans Verkuil 2010-05-24  163  

:::::: The code at line 141 was first introduced by commit
:::::: f6e114eed0414fbba9eb73480cd8efdaba96aaa7 V4L/DVB: cx2341x: convert to the control framework

:::::: TO: Hans Verkuil <hverkuil@xs4all.nl>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
