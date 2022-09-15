Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512C65B93C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 07:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIOFA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 01:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIOFAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:00:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623A42AE9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 22:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663218019; x=1694754019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s9wHHvsZJeNmKkQDjvmZjTNNJiJAMUznPLeaBE8mq0s=;
  b=kKKTUgad4RfT1YBYwsfF2OmAxZeeCTHKWeJWd9T89FtosAZ4iNVpY8k8
   cTgkjUk4ewzgua/BpiB/r636m9W2KTmKBjFdcHKgQYJxOJxR09vg5It8u
   PmOwxLN/KuijIt1vSkKE4NTBZe1JGKoqw8BPtgzen5DtCFTbamNWUMMme
   R639spUxCvaOAWMrpIhMPCCTCs/FdhsVFPMjbT+JgaJI3xIOn3ZL9xL0/
   k0Gqwyx6Rno44KbbHzHgGTOgwBzfVqVqytusK7r8PTZt2r41ZtmUaH1dX
   NlovNtiCSLhgTz6uAXwobXu24BWLCO+89ExUgSRVfUjrSUUNlfqnTe85i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298608648"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="298608648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 22:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="568281983"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2022 22:00:16 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYgz2-0000sW-0P;
        Thu, 15 Sep 2022 05:00:16 +0000
Date:   Thu, 15 Sep 2022 12:59:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:alt-ctrls 2/2]
 drivers/media/common/cx2341x.c:266:24: warning: 'struct v4l2_ext_control'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202209151201.CZ4aRBlf-lkp@intel.com>
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
commit: c6e0e18a5be6b8a301595a30ba369cbee4a60807 [2/2] f
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220915/202209151201.CZ4aRBlf-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree alt-ctrls
        git checkout c6e0e18a5be6b8a301595a30ba369cbee4a60807
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/common/ drivers/media/i2c/ drivers/media/pci/bt8xx/ drivers/media/pci/saa7134/ drivers/media/pci/solo6x10/ drivers/media/platform/atmel/ drivers/media/platform/chips-media/ drivers/media/platform/marvell/ drivers/media/platform/renesas/vsp1/ drivers/media/platform/samsung/s5p-mfc/ drivers/media/platform/ti/omap3isp/ drivers/media/platform/ti/vpe/ drivers/media/platform/via/ drivers/media/platform/xilinx/ drivers/media/radio/ drivers/media/test-drivers/ drivers/media/usb/cx231xx/ drivers/media/usb/go7007/ drivers/media/usb/gspca/ drivers/media/usb/pvrusb2/ drivers/media/usb/pwc/ drivers/media/usb/uvc/ drivers/media/v4l2-core/ drivers/staging/media/deprecated/cpia2/ drivers/staging/media/imx/ drivers/video/fbdev/matrox/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/videodev2.h:61,
                    from drivers/media/common/cx2341x.c:14:
   include/uapi/linux/videodev2.h:1846:39: error: 'V4L2_CTRL_MAX_DIMS' undeclared here (not in a function)
    1846 |                         __u32 offsets[V4L2_CTRL_MAX_DIMS];
         |                                       ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:1880:15: error: unknown type name 'v4l2_ctrl_ptr'
    1880 | static inline v4l2_ctrl_ptr v4l2_item_get_ptr(const struct v4l2_item *item)
         |               ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h: In function 'v4l2_item_get_ptr':
   include/uapi/linux/videodev2.h:1882:9: error: unknown type name 'v4l2_ctrl_ptr'; use 'union' keyword to refer to the type
    1882 |         v4l2_ctrl_ptr p;
         |         ^~~~~~~~~~~~~
         |         union 
   include/uapi/linux/videodev2.h:1885:18: error: request for member 'p_const' in something not a structure or union
    1885 |                 p.p_const = (const void *)(uintptr_t)item->ctrl_ptr.ptr;
         |                  ^
   include/uapi/linux/videodev2.h:1887:18: error: request for member 'p_const' in something not a structure or union
    1887 |                 p.p_const = NULL;
         |                  ^
   include/uapi/linux/videodev2.h: At top level:
   include/uapi/linux/videodev2.h:1906:38: error: unknown type name 'v4l2_ctrl_ptr'
    1906 |                                      v4l2_ctrl_ptr p, __u32 elems)
         |                                      ^~~~~~~~~~~~~
   In file included from include/media/v4l2-subdev.h:15,
                    from include/media/v4l2-mc.h:15,
                    from include/media/tuner.h:14,
                    from drivers/media/common/cx2341x.c:16:
   include/media/v4l2-common.h:95:33: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
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
   include/media/drv-intf/cx2341x.h:85:24: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
      85 |                 struct v4l2_queryctrl *qctrl);
         |                        ^~~~~~~~~~~~~~
   include/media/drv-intf/cx2341x.h:88:24: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
      88 |                 struct v4l2_ext_controls *ctrls, unsigned int cmd);
         |                        ^~~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c: In function 'cx2341x_ctrl_fill':
   drivers/media/common/cx2341x.c:141:25: error: 'V4L2_CTRL_TYPE_INTEGER' undeclared (first use in this function); did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
     141 |                 *type = V4L2_CTRL_TYPE_INTEGER;
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         V4L2_CTRL_TYPE_INTEGER_MENU
   drivers/media/common/cx2341x.c:141:25: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/common/cx2341x.c: At top level:
>> drivers/media/common/cx2341x.c:266:24: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
     266 |                 struct v4l2_ext_control *ctrl)
         |                        ^~~~~~~~~~~~~~~~
   drivers/media/common/cx2341x.c: In function 'cx2341x_get_ctrl':
   drivers/media/common/cx2341x.c:268:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     268 |         switch (ctrl->id) {
         |                     ^~
   drivers/media/common/cx2341x.c:270:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     270 |                 ctrl->value = params->audio_sampling_freq;
         |                     ^~
   drivers/media/common/cx2341x.c:273:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     273 |                 ctrl->value = params->audio_encoding;
         |                     ^~
   drivers/media/common/cx2341x.c:276:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     276 |                 ctrl->value = params->audio_l2_bitrate;
         |                     ^~
   drivers/media/common/cx2341x.c:279:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     279 |                 ctrl->value = params->audio_ac3_bitrate;
         |                     ^~
   drivers/media/common/cx2341x.c:282:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     282 |                 ctrl->value = params->audio_mode;
         |                     ^~
   drivers/media/common/cx2341x.c:285:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     285 |                 ctrl->value = params->audio_mode_extension;
         |                     ^~
   drivers/media/common/cx2341x.c:288:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     288 |                 ctrl->value = params->audio_emphasis;
         |                     ^~
   drivers/media/common/cx2341x.c:291:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     291 |                 ctrl->value = params->audio_crc;
         |                     ^~
   drivers/media/common/cx2341x.c:294:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     294 |                 ctrl->value = params->audio_mute;
         |                     ^~
   drivers/media/common/cx2341x.c:297:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     297 |                 ctrl->value = params->video_encoding;
         |                     ^~
   drivers/media/common/cx2341x.c:300:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     300 |                 ctrl->value = params->video_aspect;
         |                     ^~
   drivers/media/common/cx2341x.c:303:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     303 |                 ctrl->value = params->video_b_frames;
         |                     ^~
   drivers/media/common/cx2341x.c:306:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     306 |                 ctrl->value = params->video_gop_size;
         |                     ^~
   drivers/media/common/cx2341x.c:309:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     309 |                 ctrl->value = params->video_gop_closure;
         |                     ^~
   drivers/media/common/cx2341x.c:312:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     312 |                 ctrl->value = params->video_bitrate_mode;
         |                     ^~
   drivers/media/common/cx2341x.c:315:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     315 |                 ctrl->value = params->video_bitrate;
         |                     ^~
   drivers/media/common/cx2341x.c:318:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     318 |                 ctrl->value = params->video_bitrate_peak;
         |                     ^~
   drivers/media/common/cx2341x.c:321:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     321 |                 ctrl->value = params->video_temporal_decimation;
         |                     ^~
   drivers/media/common/cx2341x.c:324:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     324 |                 ctrl->value = params->video_mute;
         |                     ^~
   drivers/media/common/cx2341x.c:327:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     327 |                 ctrl->value = params->video_mute_yuv;
         |                     ^~
   drivers/media/common/cx2341x.c:330:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     330 |                 ctrl->value = params->stream_type;
         |                     ^~
   drivers/media/common/cx2341x.c:333:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     333 |                 ctrl->value = params->stream_vbi_fmt;
         |                     ^~
   drivers/media/common/cx2341x.c:336:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     336 |                 ctrl->value = params->video_spatial_filter_mode;
         |                     ^~
   drivers/media/common/cx2341x.c:339:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     339 |                 ctrl->value = params->video_spatial_filter;
         |                     ^~
   drivers/media/common/cx2341x.c:342:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     342 |                 ctrl->value = params->video_luma_spatial_filter_type;
         |                     ^~
   drivers/media/common/cx2341x.c:345:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     345 |                 ctrl->value = params->video_chroma_spatial_filter_type;
         |                     ^~
   drivers/media/common/cx2341x.c:348:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     348 |                 ctrl->value = params->video_temporal_filter_mode;
         |                     ^~
   drivers/media/common/cx2341x.c:351:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     351 |                 ctrl->value = params->video_temporal_filter;
         |                     ^~
   drivers/media/common/cx2341x.c:354:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     354 |                 ctrl->value = params->video_median_filter_type;
         |                     ^~
   drivers/media/common/cx2341x.c:357:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     357 |                 ctrl->value = params->video_luma_median_filter_top;
         |                     ^~
   drivers/media/common/cx2341x.c:360:21: error: invalid use of undefined type 'struct v4l2_ext_control'
     360 |                 ctrl->value = params->video_luma_median_filter_bottom;
         |                     ^~
   drivers/media/common/cx2341x.c:363:21: error: invalid use of undefined type 'struct v4l2_ext_control'
--
   In file included from include/linux/videodev2.h:61,
                    from include/media/v4l2-ctrls.h:13,
                    from drivers/media/v4l2-core/v4l2-ctrls-api.c:13:
   include/uapi/linux/videodev2.h:1846:39: error: 'V4L2_CTRL_MAX_DIMS' undeclared here (not in a function)
    1846 |                         __u32 offsets[V4L2_CTRL_MAX_DIMS];
         |                                       ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:1880:15: error: unknown type name 'v4l2_ctrl_ptr'
    1880 | static inline v4l2_ctrl_ptr v4l2_item_get_ptr(const struct v4l2_item *item)
         |               ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h: In function 'v4l2_item_get_ptr':
   include/uapi/linux/videodev2.h:1882:9: error: unknown type name 'v4l2_ctrl_ptr'; use 'union' keyword to refer to the type
    1882 |         v4l2_ctrl_ptr p;
         |         ^~~~~~~~~~~~~
         |         union 
   include/uapi/linux/videodev2.h:1885:18: error: request for member 'p_const' in something not a structure or union
    1885 |                 p.p_const = (const void *)(uintptr_t)item->ctrl_ptr.ptr;
         |                  ^
   include/uapi/linux/videodev2.h:1887:18: error: request for member 'p_const' in something not a structure or union
    1887 |                 p.p_const = NULL;
         |                  ^
   include/uapi/linux/videodev2.h: At top level:
   include/uapi/linux/videodev2.h:1906:38: error: unknown type name 'v4l2_ctrl_ptr'
    1906 |                                      v4l2_ctrl_ptr p, __u32 elems)
         |                                      ^~~~~~~~~~~~~
   include/media/v4l2-ctrls.h:58:7: error: redefinition of 'union v4l2_ctrl_ptr'
      58 | union v4l2_ctrl_ptr {
         |       ^~~~~~~~~~~~~
   include/uapi/linux/videodev2.h:1797:7: note: originally defined here
    1797 | union v4l2_ctrl_ptr {
         |       ^~~~~~~~~~~~~
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
   In file included from include/media/v4l2-subdev.h:15,
                    from include/media/v4l2-device.h:13,
                    from drivers/media/v4l2-core/v4l2-ctrls-api.c:15:
   include/media/v4l2-common.h:95:33: warning: 'struct v4l2_queryctrl' declared inside parameter list will not be visible outside of this definition or declaration
      95 | int v4l2_ctrl_query_fill(struct v4l2_queryctrl *qctrl,
         |                                 ^~~~~~~~~~~~~~
   In file included from drivers/media/v4l2-core/v4l2-ctrls-api.c:17:
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
   In file included from drivers/media/v4l2-core/v4l2-ctrls-api.c:19:
   drivers/media/v4l2-core/v4l2-ctrls-priv.h: In function 'user_flags':
   drivers/media/v4l2-core/v4l2-ctrls-priv.h:50:26: error: 'V4L2_CTRL_FLAG_HAS_PAYLOAD' undeclared (first use in this function); did you mean 'V4L2_CTRL_FLAG_READ_ONLY'?
      50 |                 flags |= V4L2_CTRL_FLAG_HAS_PAYLOAD;
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          V4L2_CTRL_FLAG_READ_ONLY
   drivers/media/v4l2-core/v4l2-ctrls-priv.h:50:26: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/v4l2-core/v4l2-ctrls-priv.h: At top level:
   drivers/media/v4l2-core/v4l2-ctrls-priv.h:77:36: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
      77 |                             struct v4l2_ext_controls *cs,
         |                                    ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-priv.h:81:37: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
      81 |                              struct v4l2_ext_controls *cs,
         |                                     ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-priv.h:88:64: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
      88 |                              struct media_device *mdev, struct v4l2_ext_controls *cs);
         |                                                                ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-priv.h:93:38: warning: 'struct v4l2_ext_controls' declared inside parameter list will not be visible outside of this definition or declaration
      93 |                               struct v4l2_ext_controls *cs, bool set);
         |                                      ^~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-ctrls-api.c:40:31: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
      40 | static int ptr_to_user(struct v4l2_ext_control *c,
         |                               ^~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: In function 'ptr_to_user':
   drivers/media/v4l2-core/v4l2-ctrls-api.c:47:38: error: invalid use of undefined type 'struct v4l2_ext_control'
      47 |                 return copy_to_user(c->ptr, ptr.p_const, c->size) ?
         |                                      ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:47:59: error: invalid use of undefined type 'struct v4l2_ext_control'
      47 |                 return copy_to_user(c->ptr, ptr.p_const, c->size) ?
         |                                                           ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:51:14: error: 'V4L2_CTRL_TYPE_STRING' undeclared (first use in this function); did you mean 'V4L2_CTRL_FLAG_STRING'?
      51 |         case V4L2_CTRL_TYPE_STRING:
         |              ^~~~~~~~~~~~~~~~~~~~~
         |              V4L2_CTRL_FLAG_STRING
   drivers/media/v4l2-core/v4l2-ctrls-api.c:53:22: error: invalid use of undefined type 'struct v4l2_ext_control'
      53 |                 if (c->size < len + 1) {
         |                      ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:54:26: error: invalid use of undefined type 'struct v4l2_ext_control'
      54 |                         c->size = ctrl->elem_size;
         |                          ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:57:38: error: invalid use of undefined type 'struct v4l2_ext_control'
      57 |                 return copy_to_user(c->string, ptr.p_char, len + 1) ?
         |                                      ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:59:14: error: 'V4L2_CTRL_TYPE_INTEGER64' undeclared (first use in this function); did you mean 'V4L2_CTRL_TYPE_INTEGER_MENU'?
      59 |         case V4L2_CTRL_TYPE_INTEGER64:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
         |              V4L2_CTRL_TYPE_INTEGER_MENU
   drivers/media/v4l2-core/v4l2-ctrls-api.c:60:18: error: invalid use of undefined type 'struct v4l2_ext_control'
      60 |                 c->value64 = *ptr.p_s64;
         |                  ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:63:18: error: invalid use of undefined type 'struct v4l2_ext_control'
      63 |                 c->value = *ptr.p_s32;
         |                  ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: At top level:
   drivers/media/v4l2-core/v4l2-ctrls-api.c:70:31: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
      70 | static int cur_to_user(struct v4l2_ext_control *c, struct v4l2_ctrl *ctrl)
         |                               ^~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: In function 'cur_to_user':
   drivers/media/v4l2-core/v4l2-ctrls-api.c:72:28: error: passing argument 1 of 'ptr_to_user' from incompatible pointer type [-Werror=incompatible-pointer-types]
      72 |         return ptr_to_user(c, ctrl, ctrl->p_cur);
         |                            ^
         |                            |
         |                            struct v4l2_ext_control *
   drivers/media/v4l2-core/v4l2-ctrls-api.c:40:49: note: expected 'struct v4l2_ext_control *' but argument is of type 'struct v4l2_ext_control *'
      40 | static int ptr_to_user(struct v4l2_ext_control *c,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/media/v4l2-core/v4l2-ctrls-api.c: At top level:
   drivers/media/v4l2-core/v4l2-ctrls-api.c:76:31: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
      76 | static int new_to_user(struct v4l2_ext_control *c,
         |                               ^~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: In function 'new_to_user':
   drivers/media/v4l2-core/v4l2-ctrls-api.c:79:28: error: passing argument 1 of 'ptr_to_user' from incompatible pointer type [-Werror=incompatible-pointer-types]
      79 |         return ptr_to_user(c, ctrl, ctrl->p_new);
         |                            ^
         |                            |
         |                            struct v4l2_ext_control *
   drivers/media/v4l2-core/v4l2-ctrls-api.c:40:49: note: expected 'struct v4l2_ext_control *' but argument is of type 'struct v4l2_ext_control *'
      40 | static int ptr_to_user(struct v4l2_ext_control *c,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/media/v4l2-core/v4l2-ctrls-api.c: At top level:
   drivers/media/v4l2-core/v4l2-ctrls-api.c:83:31: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
      83 | static int req_to_user(struct v4l2_ext_control *c,
         |                               ^~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: In function 'req_to_user':
   drivers/media/v4l2-core/v4l2-ctrls-api.c:86:28: error: passing argument 1 of 'ptr_to_user' from incompatible pointer type [-Werror=incompatible-pointer-types]
      86 |         return ptr_to_user(c, ref->ctrl, ref->p_req);
         |                            ^
         |                            |
         |                            struct v4l2_ext_control *
   drivers/media/v4l2-core/v4l2-ctrls-api.c:40:49: note: expected 'struct v4l2_ext_control *' but argument is of type 'struct v4l2_ext_control *'
      40 | static int ptr_to_user(struct v4l2_ext_control *c,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/media/v4l2-core/v4l2-ctrls-api.c: At top level:
   drivers/media/v4l2-core/v4l2-ctrls-api.c:90:31: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
      90 | static int def_to_user(struct v4l2_ext_control *c, struct v4l2_ctrl *ctrl)
         |                               ^~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: In function 'def_to_user':
   drivers/media/v4l2-core/v4l2-ctrls-api.c:94:28: error: passing argument 1 of 'ptr_to_user' from incompatible pointer type [-Werror=incompatible-pointer-types]
      94 |         return ptr_to_user(c, ctrl, ctrl->p_new);
         |                            ^
         |                            |
         |                            struct v4l2_ext_control *
   drivers/media/v4l2-core/v4l2-ctrls-api.c:40:49: note: expected 'struct v4l2_ext_control *' but argument is of type 'struct v4l2_ext_control *'
      40 | static int ptr_to_user(struct v4l2_ext_control *c,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/media/v4l2-core/v4l2-ctrls-api.c: At top level:
   drivers/media/v4l2-core/v4l2-ctrls-api.c:98:31: warning: 'struct v4l2_ext_control' declared inside parameter list will not be visible outside of this definition or declaration
      98 | static int user_to_new(struct v4l2_ext_control *c, struct v4l2_ctrl *ctrl)
         |                               ^~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-ctrls-api.c: In function 'user_to_new':
   drivers/media/v4l2-core/v4l2-ctrls-api.c:105:14: error: invalid use of undefined type 'struct v4l2_ext_control'
     105 |             c->size > ctrl->p_array_alloc_elems * ctrl->elem_size) {
         |              ^~
   drivers/media/v4l2-core/v4l2-ctrls-api.c:107:43: error: invalid use of undefined type 'struct v4l2_ext_control'
     107 |                 void *tmp = kvzalloc(2 * c->size, GFP_KERNEL);
         |                                           ^~
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
..


vim +266 drivers/media/common/cx2341x.c

f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  118  
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  119  static void cx2341x_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  120  		    s32 *min, s32 *max, s32 *step, s32 *def, u32 *flags)
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  121  {
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  122  	*name = cx2341x_get_name(id);
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  123  	*flags = 0;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  124  
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  125  	switch (id) {
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  126  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  127  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  128  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  129  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  130  	case V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  131  		*type = V4L2_CTRL_TYPE_MENU;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  132  		*min = 0;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  133  		*step = 0;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  134  		break;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  135  	case V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  136  		*type = V4L2_CTRL_TYPE_BOOLEAN;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  137  		*min = 0;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  138  		*max = *step = 1;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  139  		break;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  140  	default:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24 @141  		*type = V4L2_CTRL_TYPE_INTEGER;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  142  		break;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  143  	}
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  144  	switch (id) {
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  145  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  146  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  147  	case V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  148  		*flags |= V4L2_CTRL_FLAG_UPDATE;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  149  		break;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  150  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  151  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  152  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  153  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  154  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  155  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  156  		*flags |= V4L2_CTRL_FLAG_SLIDER;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  157  		break;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  158  	case V4L2_CID_MPEG_VIDEO_ENCODING:
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  159  		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  160  		break;
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  161  	}
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  162  }
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  163  
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  164  
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  165  /********************** OLD CODE *********************/
f6e114eed0414f drivers/media/video/cx2341x.c  Hans Verkuil    2010-05-24  166  
2ba588942c45a0 drivers/media/video/cx2341x.c  Hans Verkuil    2009-02-13  167  /* Must be sorted from low to high control ID! */
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  168  const u32 cx2341x_mpeg_ctrls[] = {
35aaa6e650c242 drivers/media/common/cx2341x.c Ezequiel Garcia 2020-11-26  169  	V4L2_CID_CODEC_CLASS,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  170  	V4L2_CID_MPEG_STREAM_TYPE,
8cbde94be34f95 drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-24  171  	V4L2_CID_MPEG_STREAM_VBI_FMT,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  172  	V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  173  	V4L2_CID_MPEG_AUDIO_ENCODING,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  174  	V4L2_CID_MPEG_AUDIO_L2_BITRATE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  175  	V4L2_CID_MPEG_AUDIO_MODE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  176  	V4L2_CID_MPEG_AUDIO_MODE_EXTENSION,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  177  	V4L2_CID_MPEG_AUDIO_EMPHASIS,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  178  	V4L2_CID_MPEG_AUDIO_CRC,
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  179  	V4L2_CID_MPEG_AUDIO_MUTE,
ee6f78cd03caae drivers/media/video/cx2341x.c  Hans Verkuil    2009-02-13  180  	V4L2_CID_MPEG_AUDIO_AC3_BITRATE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  181  	V4L2_CID_MPEG_VIDEO_ENCODING,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  182  	V4L2_CID_MPEG_VIDEO_ASPECT,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  183  	V4L2_CID_MPEG_VIDEO_B_FRAMES,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  184  	V4L2_CID_MPEG_VIDEO_GOP_SIZE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  185  	V4L2_CID_MPEG_VIDEO_GOP_CLOSURE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  186  	V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  187  	V4L2_CID_MPEG_VIDEO_BITRATE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  188  	V4L2_CID_MPEG_VIDEO_BITRATE_PEAK,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  189  	V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION,
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  190  	V4L2_CID_MPEG_VIDEO_MUTE,
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  191  	V4L2_CID_MPEG_VIDEO_MUTE_YUV,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  192  	V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  193  	V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  194  	V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  195  	V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  196  	V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  197  	V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  198  	V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  199  	V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  200  	V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  201  	V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  202  	V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP,
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  203  	V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS,
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  204  	0
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  205  };
737bd410e70c3d drivers/media/video/cx2341x.c  Hans Verkuil    2007-11-01  206  EXPORT_SYMBOL(cx2341x_mpeg_ctrls);
cc7bc648690d4e drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-19  207  
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  208  static const struct cx2341x_mpeg_params default_params = {
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  209  	/* misc */
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  210  	.capabilities = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  211  	.port = CX2341X_PORT_MEMORY,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  212  	.width = 720,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  213  	.height = 480,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  214  	.is_50hz = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  215  
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  216  	/* stream */
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  217  	.stream_type = V4L2_MPEG_STREAM_TYPE_MPEG2_PS,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  218  	.stream_vbi_fmt = V4L2_MPEG_STREAM_VBI_FMT_NONE,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  219  	.stream_insert_nav_packets = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  220  
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  221  	/* audio */
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  222  	.audio_sampling_freq = V4L2_MPEG_AUDIO_SAMPLING_FREQ_48000,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  223  	.audio_encoding = V4L2_MPEG_AUDIO_ENCODING_LAYER_2,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  224  	.audio_l2_bitrate = V4L2_MPEG_AUDIO_L2_BITRATE_224K,
0d82fe801d7c6d drivers/media/video/cx2341x.c  Andy Walls      2009-01-01  225  	.audio_ac3_bitrate = V4L2_MPEG_AUDIO_AC3_BITRATE_224K,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  226  	.audio_mode = V4L2_MPEG_AUDIO_MODE_STEREO,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  227  	.audio_mode_extension = V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_4,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  228  	.audio_emphasis = V4L2_MPEG_AUDIO_EMPHASIS_NONE,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  229  	.audio_crc = V4L2_MPEG_AUDIO_CRC_NONE,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  230  	.audio_mute = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  231  
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  232  	/* video */
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  233  	.video_encoding = V4L2_MPEG_VIDEO_ENCODING_MPEG_2,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  234  	.video_aspect = V4L2_MPEG_VIDEO_ASPECT_4x3,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  235  	.video_b_frames = 2,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  236  	.video_gop_size = 12,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  237  	.video_gop_closure = 1,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  238  	.video_bitrate_mode = V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  239  	.video_bitrate = 6000000,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  240  	.video_bitrate_peak = 8000000,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  241  	.video_temporal_decimation = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  242  	.video_mute = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  243  	.video_mute_yuv = 0x008080,  /* YCbCr value for black */
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  244  
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  245  	/* encoding filters */
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  246  	.video_spatial_filter_mode =
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  247  		V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_MANUAL,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  248  	.video_spatial_filter = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  249  	.video_luma_spatial_filter_type =
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  250  		V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_HOR,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  251  	.video_chroma_spatial_filter_type =
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  252  		V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_1D_HOR,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  253  	.video_temporal_filter_mode =
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  254  		V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_MANUAL,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  255  	.video_temporal_filter = 8,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  256  	.video_median_filter_type =
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  257  		V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_OFF,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  258  	.video_luma_median_filter_top = 255,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  259  	.video_luma_median_filter_bottom = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  260  	.video_chroma_median_filter_top = 255,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  261  	.video_chroma_median_filter_bottom = 0,
ca130eef2ca185 drivers/media/video/cx2341x.c  Hans Verkuil    2008-07-17  262  };
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  263  /* Map the control ID to the correct field in the cx2341x_mpeg_params
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  264     struct. Return -EINVAL if the ID is unknown, else return 0. */
e0e31cdb91cddc drivers/media/video/cx2341x.c  Hans Verkuil    2008-06-22  265  static int cx2341x_get_ctrl(const struct cx2341x_mpeg_params *params,
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18 @266  		struct v4l2_ext_control *ctrl)
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  267  {
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  268  	switch (ctrl->id) {
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  269  	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  270  		ctrl->value = params->audio_sampling_freq;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  271  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  272  	case V4L2_CID_MPEG_AUDIO_ENCODING:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  273  		ctrl->value = params->audio_encoding;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  274  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  275  	case V4L2_CID_MPEG_AUDIO_L2_BITRATE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  276  		ctrl->value = params->audio_l2_bitrate;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  277  		break;
0d82fe801d7c6d drivers/media/video/cx2341x.c  Andy Walls      2009-01-01  278  	case V4L2_CID_MPEG_AUDIO_AC3_BITRATE:
0d82fe801d7c6d drivers/media/video/cx2341x.c  Andy Walls      2009-01-01  279  		ctrl->value = params->audio_ac3_bitrate;
0d82fe801d7c6d drivers/media/video/cx2341x.c  Andy Walls      2009-01-01  280  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  281  	case V4L2_CID_MPEG_AUDIO_MODE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  282  		ctrl->value = params->audio_mode;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  283  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  284  	case V4L2_CID_MPEG_AUDIO_MODE_EXTENSION:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  285  		ctrl->value = params->audio_mode_extension;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  286  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  287  	case V4L2_CID_MPEG_AUDIO_EMPHASIS:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  288  		ctrl->value = params->audio_emphasis;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  289  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  290  	case V4L2_CID_MPEG_AUDIO_CRC:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  291  		ctrl->value = params->audio_crc;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  292  		break;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  293  	case V4L2_CID_MPEG_AUDIO_MUTE:
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  294  		ctrl->value = params->audio_mute;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  295  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  296  	case V4L2_CID_MPEG_VIDEO_ENCODING:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  297  		ctrl->value = params->video_encoding;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  298  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  299  	case V4L2_CID_MPEG_VIDEO_ASPECT:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  300  		ctrl->value = params->video_aspect;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  301  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  302  	case V4L2_CID_MPEG_VIDEO_B_FRAMES:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  303  		ctrl->value = params->video_b_frames;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  304  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  305  	case V4L2_CID_MPEG_VIDEO_GOP_SIZE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  306  		ctrl->value = params->video_gop_size;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  307  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  308  	case V4L2_CID_MPEG_VIDEO_GOP_CLOSURE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  309  		ctrl->value = params->video_gop_closure;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  310  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  311  	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  312  		ctrl->value = params->video_bitrate_mode;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  313  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  314  	case V4L2_CID_MPEG_VIDEO_BITRATE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  315  		ctrl->value = params->video_bitrate;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  316  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  317  	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  318  		ctrl->value = params->video_bitrate_peak;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  319  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  320  	case V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  321  		ctrl->value = params->video_temporal_decimation;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  322  		break;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  323  	case V4L2_CID_MPEG_VIDEO_MUTE:
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  324  		ctrl->value = params->video_mute;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  325  		break;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  326  	case V4L2_CID_MPEG_VIDEO_MUTE_YUV:
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  327  		ctrl->value = params->video_mute_yuv;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  328  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  329  	case V4L2_CID_MPEG_STREAM_TYPE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  330  		ctrl->value = params->stream_type;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  331  		break;
8cbde94be34f95 drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-24  332  	case V4L2_CID_MPEG_STREAM_VBI_FMT:
8cbde94be34f95 drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-24  333  		ctrl->value = params->stream_vbi_fmt;
8cbde94be34f95 drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-24  334  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  335  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  336  		ctrl->value = params->video_spatial_filter_mode;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  337  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  338  	case V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  339  		ctrl->value = params->video_spatial_filter;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  340  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  341  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  342  		ctrl->value = params->video_luma_spatial_filter_type;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  343  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  344  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  345  		ctrl->value = params->video_chroma_spatial_filter_type;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  346  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  347  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  348  		ctrl->value = params->video_temporal_filter_mode;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  349  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  350  	case V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  351  		ctrl->value = params->video_temporal_filter;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  352  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  353  	case V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  354  		ctrl->value = params->video_median_filter_type;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  355  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  356  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  357  		ctrl->value = params->video_luma_median_filter_top;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  358  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  359  	case V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  360  		ctrl->value = params->video_luma_median_filter_bottom;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  361  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  362  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  363  		ctrl->value = params->video_chroma_median_filter_top;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  364  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  365  	case V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  366  		ctrl->value = params->video_chroma_median_filter_bottom;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  367  		break;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  368  	case V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS:
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  369  		ctrl->value = params->stream_insert_nav_packets;
5eee72e88416ef drivers/media/video/cx2341x.c  Hans Verkuil    2007-04-27  370  		break;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  371  	default:
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  372  		return -EINVAL;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  373  	}
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  374  	return 0;
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  375  }
5d1a9ae6d9d7fc drivers/media/video/cx2341x.c  Hans Verkuil    2006-06-18  376  

:::::: The code at line 266 was first introduced by commit
:::::: 5d1a9ae6d9d7fc14b2259cd550eb87364a21190a V4L/DVB (4191): Add CX2341X MPEG encoder module.

:::::: TO: Hans Verkuil <hverkuil@xs4all.nl>
:::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
