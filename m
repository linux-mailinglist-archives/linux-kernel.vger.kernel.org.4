Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89D75B95EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiIOIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:05:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0F58DC4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663229146; x=1694765146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NGES17OH48p3MCeYbxr65cmk4UrfeKt3jDNzKqEFq1M=;
  b=g+7a5FUfLK2VGBs+AKXbd5MwXBOXEl3+xuOEq0bjWMjgWmE0HzLmQdlC
   DLbCLr/wxlhvjvnBCxDSl6hVTsEggspILM1GuUYNGw9GI9T6WHyusErQ+
   3YqZNnGuTC7Q8AxsX9BZuBLGJrB6Zqw4cmdXGxJE4dbmC8mACWvb+cHdj
   CuoxHG18jQ7wMQ4R37Gw4c6LXzcsib0J6RbZ6gv1n2qg+j0GD2zzEqke2
   8Xhe+/6+uJCO3EgltvRG2RGy+aa/QNiE0c4yrDRKaWdc5wIsyZKbke4cw
   XhYEQ7hH3IDwebbkJi2KN60RUIidHKZjVIYtpSo7PjN4UQXe5hNJGraOj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="296235786"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="296235786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 01:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="568334631"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2022 01:05:44 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYjsV-0000Cn-0q;
        Thu, 15 Sep 2022 08:05:43 +0000
Date:   Thu, 15 Sep 2022 16:05:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:alt-ctrls 1/2]
 drivers/media/v4l2-core/v4l2-ioctl.c:2256:34: warning: unused variable
 'ctrls'
Message-ID: <202209151644.XpZIThge-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220915/202209151644.XpZIThge-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree alt-ctrls
        git checkout b28feb32252c212b4d345f0da7ceb285d763e1b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/usb/uvc/ drivers/media/v4l2-core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |                                                ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2264:53: error: passing argument 3 of 'ops->vidioc_g_ctrl' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2264 |                 return ops->vidioc_g_ctrl(file, fh, p);
         |                                                     ^
         |                                                     |
         |                                                     struct v4l2_control *
   drivers/media/v4l2-core/v4l2-ioctl.c:2264:53: note: expected 'struct v4l2_control *' but argument is of type 'struct v4l2_control *'
   In file included from include/linux/videodev2.h:61,
                    from drivers/media/v4l2-core/v4l2-ioctl.c:19:
   drivers/media/v4l2-core/v4l2-ioctl.c:2268:43: error: invalid use of undefined type 'struct v4l2_control'
    2268 |         ctrls.which = V4L2_CTRL_ID2WHICH(p->id);
         |                                           ^~
   include/uapi/linux/videodev2.h:1893:37: note: in definition of macro 'V4L2_CTRL_ID2WHICH'
    1893 | #define V4L2_CTRL_ID2WHICH(id)    ((id) & 0x0fff0000UL)
         |                                     ^~
   drivers/media/v4l2-core/v4l2-ioctl.c:2271:20: error: invalid use of undefined type 'struct v4l2_control'
    2271 |         ctrl.id = p->id;
         |                    ^~
   drivers/media/v4l2-core/v4l2-ioctl.c:2272:23: error: invalid use of undefined type 'struct v4l2_control'
    2272 |         ctrl.value = p->value;
         |                       ^~
   In file included from include/asm-generic/ioctl.h:5,
                    from ./arch/x86/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/apm_bios.h:133,
                    from include/linux/apm_bios.h:9,
                    from arch/x86/include/uapi/asm/bootparam.h:46,
                    from arch/x86/include/asm/mem_encrypt.h:18,
                    from include/linux/mem_encrypt.h:17,
                    from arch/x86/include/asm/processor-flags.h:6,
                    from arch/x86/include/asm/processor.h:5,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from drivers/media/v4l2-core/v4l2-ioctl.c:11:
   include/uapi/linux/videodev2.h:2660:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_control'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2660:33: note: in expansion of macro '_IOWR'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                 ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2273:37: note: in expansion of macro 'VIDIOC_G_CTRL'
    2273 |         if (check_ext_ctrls(&ctrls, VIDIOC_G_CTRL)) {
         |                                     ^~~~~~~~~~~~~
   include/asm-generic/ioctl.h:13:32: error: array type has incomplete element type 'struct v4l2_control'
      13 |         ((sizeof(t) == sizeof(t[1]) && \
         |                                ^
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2660:33: note: in expansion of macro '_IOWR'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                 ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2273:37: note: in expansion of macro 'VIDIOC_G_CTRL'
    2273 |         if (check_ext_ctrls(&ctrls, VIDIOC_G_CTRL)) {
         |                                     ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2660:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_control'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2660:33: note: in expansion of macro '_IOWR'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                 ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2273:37: note: in expansion of macro 'VIDIOC_G_CTRL'
    2273 |         if (check_ext_ctrls(&ctrls, VIDIOC_G_CTRL)) {
         |                                     ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2660:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_control'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2660:33: note: in expansion of macro '_IOWR'
    2660 | #define VIDIOC_G_CTRL           _IOWR('V', 27, struct v4l2_control)
         |                                 ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2273:37: note: in expansion of macro 'VIDIOC_G_CTRL'
    2273 |         if (check_ext_ctrls(&ctrls, VIDIOC_G_CTRL)) {
         |                                     ^~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2277:26: error: invalid use of undefined type 'struct v4l2_control'
    2277 |                         p->value = ctrl.value;
         |                          ^~
>> drivers/media/v4l2-core/v4l2-ioctl.c:2256:34: warning: unused variable 'ctrls' [-Wunused-variable]
    2256 |         struct v4l2_ext_controls ctrls;
         |                                  ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c: In function 'v4l_s_ctrl':
   drivers/media/v4l2-core/v4l2-ioctl.c:2290:34: error: storage size of 'ctrls' isn't known
    2290 |         struct v4l2_ext_controls ctrls;
         |                                  ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2295:60: error: passing argument 3 of 'v4l2_s_ctrl' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2295 |                 return v4l2_s_ctrl(vfh, vfh->ctrl_handler, p);
         |                                                            ^
         |                                                            |
         |                                                            struct v4l2_control *
   In file included from drivers/media/v4l2-core/v4l2-ioctl.c:24:
   include/media/v4l2-ctrls.h:1447:38: note: expected 'struct v4l2_control *' but argument is of type 'struct v4l2_control *'
    1447 |                 struct v4l2_control *ctrl);
         |                 ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2297:61: error: passing argument 3 of 'v4l2_s_ctrl' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2297 |                 return v4l2_s_ctrl(NULL, vfd->ctrl_handler, p);
         |                                                             ^
         |                                                             |
         |                                                             struct v4l2_control *
   In file included from drivers/media/v4l2-core/v4l2-ioctl.c:24:
   include/media/v4l2-ctrls.h:1447:38: note: expected 'struct v4l2_control *' but argument is of type 'struct v4l2_control *'
    1447 |                 struct v4l2_control *ctrl);
         |                 ~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2299:53: error: passing argument 3 of 'ops->vidioc_s_ctrl' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2299 |                 return ops->vidioc_s_ctrl(file, fh, p);
         |                                                     ^
         |                                                     |
         |                                                     struct v4l2_control *
   drivers/media/v4l2-core/v4l2-ioctl.c:2299:53: note: expected 'struct v4l2_control *' but argument is of type 'struct v4l2_control *'
   In file included from include/linux/videodev2.h:61,
                    from drivers/media/v4l2-core/v4l2-ioctl.c:19:
   drivers/media/v4l2-core/v4l2-ioctl.c:2303:43: error: invalid use of undefined type 'struct v4l2_control'
    2303 |         ctrls.which = V4L2_CTRL_ID2WHICH(p->id);
         |                                           ^~
   include/uapi/linux/videodev2.h:1893:37: note: in definition of macro 'V4L2_CTRL_ID2WHICH'
    1893 | #define V4L2_CTRL_ID2WHICH(id)    ((id) & 0x0fff0000UL)
         |                                     ^~
   drivers/media/v4l2-core/v4l2-ioctl.c:2306:20: error: invalid use of undefined type 'struct v4l2_control'
    2306 |         ctrl.id = p->id;
         |                    ^~
   drivers/media/v4l2-core/v4l2-ioctl.c:2307:23: error: invalid use of undefined type 'struct v4l2_control'
    2307 |         ctrl.value = p->value;
         |                       ^~
   In file included from include/asm-generic/ioctl.h:5,
                    from ./arch/x86/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/apm_bios.h:133,
                    from include/linux/apm_bios.h:9,
                    from arch/x86/include/uapi/asm/bootparam.h:46,
                    from arch/x86/include/asm/mem_encrypt.h:18,
                    from include/linux/mem_encrypt.h:17,
                    from arch/x86/include/asm/processor-flags.h:6,
                    from arch/x86/include/asm/processor.h:5,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from drivers/media/v4l2-core/v4l2-ioctl.c:11:
   include/uapi/linux/videodev2.h:2661:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_control'
    2661 | #define VIDIOC_S_CTRL           _IOWR('V', 28, struct v4l2_control)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2661:33: note: in expansion of macro '_IOWR'
    2661 | #define VIDIOC_S_CTRL           _IOWR('V', 28, struct v4l2_control)
         |                                 ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2308:38: note: in expansion of macro 'VIDIOC_S_CTRL'
    2308 |         if (!check_ext_ctrls(&ctrls, VIDIOC_S_CTRL))
         |                                      ^~~~~~~~~~~~~
   include/asm-generic/ioctl.h:13:32: error: array type has incomplete element type 'struct v4l2_control'
      13 |         ((sizeof(t) == sizeof(t[1]) && \
         |                                ^
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2661:33: note: in expansion of macro '_IOWR'
    2661 | #define VIDIOC_S_CTRL           _IOWR('V', 28, struct v4l2_control)
         |                                 ^~~~~
   drivers/media/v4l2-core/v4l2-ioctl.c:2308:38: note: in expansion of macro 'VIDIOC_S_CTRL'
    2308 |         if (!check_ext_ctrls(&ctrls, VIDIOC_S_CTRL))
         |                                      ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2661:48: error: invalid application of 'sizeof' to incomplete type 'struct v4l2_control'
    2661 | #define VIDIOC_S_CTRL           _IOWR('V', 28, struct v4l2_control)
         |                                                ^~~~~~
   include/uapi/asm-generic/ioctl.h:73:12: note: in definition of macro '_IOC'
      73 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/uapi/asm-generic/ioctl.h:88:72: note: in expansion of macro '_IOC_TYPECHECK'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                                                        ^~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:2661:33: note: in expansion of macro '_IOWR'
--
   include/media/v4l2-common.h:95:33: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                                 ^~~~~~~~~~~~~~
   In file included from drivers/media/usb/uvc/uvc_v4l2.c:22:
   include/media/v4l2-ctrls.h:58:7: error: redefinition of 'union v4l2_ctrl_ptr'
      58 | union v4l2_ctrl_ptr {
         |       ^~~~~~~~~~~~~
   In file included from include/linux/videodev2.h:61,
                    from drivers/media/usb/uvc/uvc_v4l2.c:15:
   include/uapi/linux/videodev2.h:1797:7: note: originally defined here
    1797 | union v4l2_ctrl_ptr {
         |       ^~~~~~~~~~~~~
   In file included from drivers/media/usb/uvc/uvc_v4l2.c:22:
   include/media/v4l2-ctrls.h:1399:58: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
    1399 | int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc);
         |                                                          ^~~~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1433:55: warning: 'struct v4l2_control' declared inside parameter list will not be visible outside of this definition or declaration
    1433 | int v4l2_g_ctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_control *ctrl);
         |                                                       ^~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1447:24: warning: 'struct v4l2_control' declared inside parameter list will not be visible outside of this definition or declaration
    1447 |                 struct v4l2_control *ctrl);
         |                        ^~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1461:56: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1461 |                      struct media_device *mdev, struct v4l2_ext_controls *c);
         |                                                        ^~~~~~~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1477:31: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1477 |                        struct v4l2_ext_controls *c);
         |                               ^~~~~~~~~~~~~~~~~
   include/media/v4l2-ctrls.h:1494:29: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1494 |                      struct v4l2_ext_controls *c);
         |                             ^~~~~~~~~~~~~~~~~
   In file included from drivers/media/usb/uvc/uvc_v4l2.c:24:
   include/media/v4l2-ioctl.h:461:40: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
     461 |                                 struct v4l2_queryctrl *a);
         |                                        ^~~~~~~~~~~~~~
   include/media/v4l2-ioctl.h:465:37: warning: 'struct v4l2_control' declared inside parameter list will not be visible outside of this definition or declaration
     465 |                              struct v4l2_control *a);
         |                                     ^~~~~~~~~~~~
   include/media/v4l2-ioctl.h:467:37: warning: 'struct v4l2_control' declared inside parameter list will not be visible outside of this definition or declaration
     467 |                              struct v4l2_control *a);
         |                                     ^~~~~~~~~~~~
   include/media/v4l2-ioctl.h:469:42: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
     469 |                                   struct v4l2_ext_controls *a);
         |                                          ^~~~~~~~~~~~~~~~~
   include/media/v4l2-ioctl.h:471:42: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
     471 |                                   struct v4l2_ext_controls *a);
         |                                          ^~~~~~~~~~~~~~~~~
   include/media/v4l2-ioctl.h:473:44: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
     473 |                                     struct v4l2_ext_controls *a);
         |                                            ^~~~~~~~~~~~~~~~~
   In file included from drivers/media/usb/uvc/uvc_v4l2.c:26:
   drivers/media/usb/uvc/uvcvideo.h:878:32: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
     878 |                         struct v4l2_queryctrl *v4l2_ctrl);
         |                                ^~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvcvideo.h:894:30: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
     894 |                       struct v4l2_ext_controls *ctrls);
         |                              ^~~~~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvcvideo.h:896:42: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
     896 |                                   struct v4l2_ext_controls *ctrls)
         |                                          ^~~~~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvcvideo.h: In function 'uvc_ctrl_commit':
   drivers/media/usb/uvc/uvcvideo.h:898:45: error: passing argument 3 of '__uvc_ctrl_commit' from incompatible pointer type [-Werror=incompatible-pointer-types]
     898 |         return __uvc_ctrl_commit(handle, 0, ctrls);
         |                                             ^~~~~
         |                                             |
         |                                             struct v4l2_ext_controls *
   drivers/media/usb/uvc/uvcvideo.h:894:49: note: expected 'struct v4l2_ext_controls *' but argument is of type 'struct v4l2_ext_controls *'
     894 |                       struct v4l2_ext_controls *ctrls);
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/usb/uvc/uvc_v4l2.c: In function 'uvc_ioctl_ctrl_map':
   drivers/media/usb/uvc/uvc_v4l2.c:60:14: error: 'V4L2_CTRL_TYPE_INTEGER' undeclared (first use in this function); did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
      60 |         case V4L2_CTRL_TYPE_INTEGER:
         |              ^~~~~~~~~~~~~~~~~~~~~~
         |              V4L2_CTRL_TYPE_INTEGER_MENU
   drivers/media/usb/uvc/uvc_v4l2.c:60:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/usb/uvc/uvc_v4l2.c: At top level:
   drivers/media/usb/uvc/uvc_v4l2.c:977:39: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
     977 |                                struct v4l2_queryctrl *qc)
         |                                       ^~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvc_v4l2.c: In function 'uvc_ioctl_queryctrl':
   drivers/media/usb/uvc/uvc_v4l2.c:982:43: error: passing argument 2 of 'uvc_query_v4l2_ctrl' from incompatible pointer type [-Werror=incompatible-pointer-types]
     982 |         return uvc_query_v4l2_ctrl(chain, qc);
         |                                           ^~
         |                                           |
         |                                           struct v4l2_queryctrl *
   In file included from drivers/media/usb/uvc/uvc_v4l2.c:26:
   drivers/media/usb/uvc/uvcvideo.h:878:48: note: expected 'struct v4l2_queryctrl *' but argument is of type 'struct v4l2_queryctrl *'
     878 |                         struct v4l2_queryctrl *v4l2_ctrl);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
   drivers/media/usb/uvc/uvc_v4l2.c: In function 'uvc_ioctl_query_ext_ctrl':
   drivers/media/usb/uvc/uvc_v4l2.c:990:16: error: variable 'qc' has initializer but incomplete type
     990 |         struct v4l2_queryctrl qc = { qec->id };
         |                ^~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvc_v4l2.c:990:38: warning: excess elements in struct initializer
     990 |         struct v4l2_queryctrl qc = { qec->id };
         |                                      ^~~
   drivers/media/usb/uvc/uvc_v4l2.c:990:38: note: (near initialization for 'qc')
   drivers/media/usb/uvc/uvc_v4l2.c:990:31: error: storage size of 'qc' isn't known
     990 |         struct v4l2_queryctrl qc = { qec->id };
         |                               ^~
>> drivers/media/usb/uvc/uvc_v4l2.c:990:31: warning: unused variable 'qc' [-Wunused-variable]
   drivers/media/usb/uvc/uvc_v4l2.c: At top level:
   drivers/media/usb/uvc/uvc_v4l2.c:1015:41: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
    1015 |                                  struct v4l2_ext_controls *ctrls,
         |                                         ^~~~~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvc_v4l2.c: In function 'uvc_ctrl_check_access':
   drivers/media/usb/uvc/uvc_v4l2.c:1018:46: error: invalid use of undefined type 'struct v4l2_ext_controls'
    1018 |         struct v4l2_ext_control *ctrl = ctrls->controls;
         |                                              ^~
   drivers/media/usb/uvc/uvc_v4l2.c:1022:30: error: invalid use of undefined type 'struct v4l2_ext_controls'
    1022 |         for (i = 0; i < ctrls->count; ++ctrl, ++i) {
         |                              ^~
   In file included from include/asm-generic/ioctl.h:5,
                    from ./arch/x86/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/apm_bios.h:133,
                    from include/linux/apm_bios.h:9,
                    from arch/x86/include/uapi/asm/bootparam.h:46,
                    from arch/x86/include/asm/mem_encrypt.h:18,
                    from include/linux/mem_encrypt.h:17,
                    from arch/x86/include/asm/processor-flags.h:6,
                    from arch/x86/include/asm/processor.h:5,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from drivers/media/usb/uvc/uvc_v4l2.c:9:
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
   drivers/media/usb/uvc/uvc_v4l2.c:1024:54: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
    1024 |                                             ioctl == VIDIOC_G_EXT_CTRLS);
         |                                                      ^~~~~~~~~~~~~~~~~~
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
   drivers/media/usb/uvc/uvc_v4l2.c:1024:54: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
    1024 |                                             ioctl == VIDIOC_G_EXT_CTRLS);
         |                                                      ^~~~~~~~~~~~~~~~~~
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
   drivers/media/usb/uvc/uvc_v4l2.c:1024:54: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
    1024 |                                             ioctl == VIDIOC_G_EXT_CTRLS);
         |                                                      ^~~~~~~~~~~~~~~~~~
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
   drivers/media/usb/uvc/uvc_v4l2.c:1024:54: note: in expansion of macro 'VIDIOC_G_EXT_CTRLS'
    1024 |                                             ioctl == VIDIOC_G_EXT_CTRLS);
         |                                                      ^~~~~~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvc_v4l2.c:1029:14: error: invalid use of undefined type 'struct v4l2_ext_controls'
    1029 |         ctrls->error_idx = ioctl == VIDIOC_TRY_EXT_CTRLS ? i : ctrls->count;
         |              ^~
   In file included from include/asm-generic/ioctl.h:5,
                    from ./arch/x86/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/apm_bios.h:133,
                    from include/linux/apm_bios.h:9,
                    from arch/x86/include/uapi/asm/bootparam.h:46,
                    from arch/x86/include/asm/mem_encrypt.h:18,
                    from include/linux/mem_encrypt.h:17,
                    from arch/x86/include/asm/processor-flags.h:6,
                    from arch/x86/include/asm/processor.h:5,
..


vim +/ctrls +2256 drivers/media/v4l2-core/v4l2-ioctl.c

efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2248  
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2249  static int v4l_g_ctrl(const struct v4l2_ioctl_ops *ops,
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2250  				struct file *file, void *fh, void *arg)
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2251  {
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2252  	struct video_device *vfd = video_devdata(file);
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2253  	struct v4l2_control *p = arg;
7a3ed2d95e9ef3 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-07-07  2254  	struct v4l2_fh *vfh =
7a3ed2d95e9ef3 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-07-07  2255  		test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09 @2256  	struct v4l2_ext_controls ctrls;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2257  	struct v4l2_ext_control ctrl;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2258  
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2259  	if (vfh && vfh->ctrl_handler)
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2260  		return v4l2_g_ctrl(vfh->ctrl_handler, p);
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2261  	if (vfd->ctrl_handler)
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2262  		return v4l2_g_ctrl(vfd->ctrl_handler, p);
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2263  	if (ops->vidioc_g_ctrl)
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2264  		return ops->vidioc_g_ctrl(file, fh, p);
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2265  	if (ops->vidioc_g_ext_ctrls == NULL)
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2266  		return -ENOTTY;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2267  
0f8017bebf3efd drivers/media/v4l2-core/v4l2-ioctl.c Ricardo Ribalda 2015-10-29  2268  	ctrls.which = V4L2_CTRL_ID2WHICH(p->id);
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2269  	ctrls.count = 1;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2270  	ctrls.controls = &ctrl;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2271  	ctrl.id = p->id;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2272  	ctrl.value = p->value;
861f92cb9160b1 drivers/media/v4l2-core/v4l2-ioctl.c Ricardo Ribalda 2021-06-18  2273  	if (check_ext_ctrls(&ctrls, VIDIOC_G_CTRL)) {
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2274  		int ret = ops->vidioc_g_ext_ctrls(file, fh, &ctrls);
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2275  
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2276  		if (ret == 0)
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2277  			p->value = ctrl.value;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2278  		return ret;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2279  	}
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2280  	return -EINVAL;
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2281  }
efbceecd4522a4 drivers/media/video/v4l2-ioctl.c     Hans Verkuil    2012-06-09  2282  

:::::: The code at line 2256 was first introduced by commit
:::::: efbceecd4522a41b8442c6b4f68b4508d57d1ccf [media] v4l2-ioctl.c: use the new table for control ioctls

:::::: TO: Hans Verkuil <hans.verkuil@cisco.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
