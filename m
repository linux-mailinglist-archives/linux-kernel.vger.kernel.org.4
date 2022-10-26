Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F72260D8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiJZBdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiJZBdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:33:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAF3A4BA5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666748017; x=1698284017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T8eNGJ+rRQG511Ih1tbQkuz326Wb4sMp0Jw7BS6iIvc=;
  b=KUOE37AJ+116ajTM1IGPnWKW2MC9GhgaY7TArATvqKh6QGYANpkg1Ln4
   zavGYJnwXgzU31kB1oEcPArs7Db7O43IV6YaN8B3sU3H/eYUdqPWNt00w
   o/ZaJ8oI3hzvu+zz1wQGer0osrL7HXt7X0za9UJgbuPgo0IMOQaHMYKZ7
   wFhuzlZzCodVY2+Tm28Il1hOrIKl1B1YvfIV45kpzW89ReJVGZPOP1pCR
   3kP8urstSf7/14CVZDr/pR6cjHyQDIP0uNKDYjC/wWYGZxd0FUEYNqMls
   buacIaVNimBfi4kov1+AdW/Ahpz0uadCx+Sx/6chGSMJkC6OM1DO9zaoG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="295238293"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="gz'50?scan'50,208,50";a="295238293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 18:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="774409733"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="gz'50?scan'50,208,50";a="774409733"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 18:33:29 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onVIO-0006nw-2P;
        Wed, 26 Oct 2022 01:33:28 +0000
Date:   Wed, 26 Oct 2022 09:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/18] drivers/hid/hid-roccat.c:397:21: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202210260902.Ich00BrO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yjPt96/CA0uljPd2"
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yjPt96/CA0uljPd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   9cc7511961c632c50ba6b34edf7bc23c5361fbd2
commit: 3ec4ab922483bc46ceed4c4bd4007a0a3201c384 [5/18] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s053-20221024 (attached as .config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=3ec4ab922483bc46ceed4c4bd4007a0a3201c384
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 3ec4ab922483bc46ceed4c4bd4007a0a3201c384
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/ drivers/hid/ drivers/iommu/ drivers/misc/genwqe/ drivers/usb/mon/ drivers/video/fbdev/aty/ sound/core/ sound/firewire/motu/ sound/hda/ sound/pci/asihpi/ sound/pci/emu10k1/ sound/pci/hda/ sound/pci/lola/ sound/synth/emux/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/hid-roccat.c:397:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hid-roccat.c:397:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hid-roccat.c:397:21: sparse:     got int *
--
>> sound/core/hwdep.c:243:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:243:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:243:24: sparse:     got int *
   sound/core/hwdep.c:273:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:273:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:273:29: sparse:     got int *
   sound/core/hwdep.c:292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:292:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:292:29: sparse:     got int *
>> sound/core/hwdep.c:302:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/hwdep.c:302:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:302:29: sparse:     got unsigned int *
--
>> sound/hda/hdmi_chmap.c:678:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:678:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:678:13: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:710:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:710:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:710:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:711:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:711:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:711:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:732:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:732:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:732:13: sparse:     got unsigned int *
--
>> drivers/hid/usbhid/hiddev.c:573:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:573:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:573:13: sparse:     got int *
   drivers/hid/usbhid/hiddev.c:621:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:621:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:621:21: sparse:     got int *
   drivers/hid/usbhid/hiddev.c:660:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:660:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:660:21: sparse:     got int *
   drivers/hid/usbhid/hiddev.c:668:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:668:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:668:29: sparse:     got int *
--
>> drivers/gpu/drm/i915/i915_perf.c:3643:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_perf.c:3643:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3643:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/i915_perf.c:3647:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_perf.c:3647:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3647:23: sparse:     got unsigned long long *
>> drivers/gpu/drm/i915/i915_perf.c:4064:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_perf.c:4064:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4064:23: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_perf.c:4075:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_perf.c:4075:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4075:23: sparse:     got unsigned int *
--
>> drivers/gpu/drm/i915/i915_getparam.c:183:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/i915/i915_getparam.c:183:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_getparam.c:183:13: sparse:     got int *
--
>> drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:412:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:412:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:412:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:428:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:428:13: sparse:     got unsigned short *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:431:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:431:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:431:15: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:435:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:435:15: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:435:15: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:503:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:503:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:503:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:525:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:525:15: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:525:15: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:530:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:530:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:530:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:553:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:553:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:553:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:591:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:591:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:591:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:594:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:594:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:594:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:597:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:597:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:597:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:619:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:619:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:619:13: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:628:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:628:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:628:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:796:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:796:14: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:796:14: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/i915/i915_query.c:258:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_query.c:258:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:258:13: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/i915_query.c:285:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_query.c:285:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:285:21: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/i915_query.c:388:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_query.c:388:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:388:13: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_query.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_query.c:428:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:428:13: sparse:     got unsigned long long *
>> drivers/gpu/drm/i915/i915_query.c:597:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/i915/i915_query.c:597:43: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:597:43: sparse:     got signed int *
--
>> sound/firewire/motu/motu-hwdep.c:78:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/firewire/motu/motu-hwdep.c:78:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/firewire/motu/motu-hwdep.c:78:29: sparse:     got unsigned int *
   sound/firewire/motu/motu-hwdep.c:92:9: sparse: sparse: context imbalance in 'hwdep_read' - different lock contexts for basic block
--
>> drivers/misc/genwqe/card_dev.c:1073:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean @@     got unsigned int enum genwqe_card_state * @@
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     got unsigned int enum genwqe_card_state *
>> drivers/misc/genwqe/card_dev.c:1080:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1087:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1116:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1123:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1136:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1142:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     got unsigned long long *
--
>> drivers/usb/mon/mon_bin.c:928:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:928:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:928:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1094:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1118:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1120:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     got unsigned int *
--
>> sound/synth/emux/emux_hwdep.c:86:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/synth/emux/emux_hwdep.c:86:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/synth/emux/emux_hwdep.c:86:24: sparse:     got unsigned int *
   sound/synth/emux/emux_hwdep.c:98:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/synth/emux/emux_hwdep.c:98:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/synth/emux/emux_hwdep.c:98:32: sparse:     got unsigned int *
--
>> sound/pci/asihpi/hpioctl.c:118:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   sound/pci/asihpi/hpioctl.c:118:13: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:118:13: sparse:     got void [noderef] __user **
   sound/pci/asihpi/hpioctl.c:119:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   sound/pci/asihpi/hpioctl.c:119:20: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:119:20: sparse:     got void [noderef] __user **
>> sound/pci/asihpi/hpioctl.c:125:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   sound/pci/asihpi/hpioctl.c:125:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:125:13: sparse:     got unsigned short *
   sound/pci/asihpi/hpioctl.c:144:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   sound/pci/asihpi/hpioctl.c:144:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:144:13: sparse:     got unsigned short *
--
>> drivers/video/fbdev/aty/aty128fb.c:2314:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2314:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2314:22: sparse:     got unsigned int *
   drivers/video/fbdev/aty/aty128fb.c:2328:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2328:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2328:24: sparse:     got unsigned int *
--
>> sound/pci/emu10k1/emufx.c:518:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:518:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:518:26: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:534:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:534:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:534:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:554:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:554:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:554:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:555:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:555:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:555:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:585:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:585:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:585:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:586:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:586:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:586:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:605:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:605:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:605:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:606:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:606:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:606:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:623:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:623:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:623:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:626:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:626:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:626:21: sparse:     got unsigned int *
>> sound/pci/emu10k1/emufx.c:2560:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/pci/emu10k1/emufx.c:2560:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2560:24: sparse:     got int *
   sound/pci/emu10k1/emufx.c:2614:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:2614:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2614:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:2652:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:2652:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2652:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:2671:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:2671:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2671:21: sparse:     got unsigned int *
--
>> sound/pci/hda/hda_hwdep.c:26:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:26:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:26:13: sparse:     got unsigned int *
   sound/pci/hda/hda_hwdep.c:30:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:30:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:30:13: sparse:     got unsigned int *
   sound/pci/hda/hda_hwdep.c:40:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:40:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:40:13: sparse:     got unsigned int *
   sound/pci/hda/hda_hwdep.c:52:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:52:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:52:13: sparse:     got unsigned int *
>> sound/pci/hda/hda_hwdep.c:68:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/pci/hda/hda_hwdep.c:68:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:68:24: sparse:     got int *
--
>> sound/pci/lola/lola_mixer.c:561:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:561:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:561:13: sparse:     got unsigned int *
   sound/pci/lola/lola_mixer.c:563:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:563:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:563:13: sparse:     got unsigned int *
   sound/pci/lola/lola_mixer.c:565:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:565:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:565:13: sparse:     got unsigned int *
   sound/pci/lola/lola_mixer.c:567:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:567:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:567:13: sparse:     got unsigned int *

vim +397 drivers/hid/hid-roccat.c

206f5f2fcb5ff5 Stefan Achatz 2010-05-19  379  
8211e46004518c Stefan Achatz 2011-01-30  380  static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
8211e46004518c Stefan Achatz 2011-01-30  381  {
496ad9aa8ef448 Al Viro       2013-01-23  382  	struct inode *inode = file_inode(file);
8211e46004518c Stefan Achatz 2011-01-30  383  	struct roccat_device *device;
8211e46004518c Stefan Achatz 2011-01-30  384  	unsigned int minor = iminor(inode);
8211e46004518c Stefan Achatz 2011-01-30  385  	long retval = 0;
8211e46004518c Stefan Achatz 2011-01-30  386  
8211e46004518c Stefan Achatz 2011-01-30  387  	mutex_lock(&devices_lock);
8211e46004518c Stefan Achatz 2011-01-30  388  
8211e46004518c Stefan Achatz 2011-01-30  389  	device = devices[minor];
8211e46004518c Stefan Achatz 2011-01-30  390  	if (!device) {
8211e46004518c Stefan Achatz 2011-01-30  391  		retval = -ENODEV;
8211e46004518c Stefan Achatz 2011-01-30  392  		goto out;
8211e46004518c Stefan Achatz 2011-01-30  393  	}
8211e46004518c Stefan Achatz 2011-01-30  394  
8211e46004518c Stefan Achatz 2011-01-30  395  	switch (cmd) {
8211e46004518c Stefan Achatz 2011-01-30  396  	case ROCCATIOCGREPSIZE:
8211e46004518c Stefan Achatz 2011-01-30 @397  		if (put_user(device->report_size, (int __user *)arg))
8211e46004518c Stefan Achatz 2011-01-30  398  			retval = -EFAULT;
8211e46004518c Stefan Achatz 2011-01-30  399  		break;
8211e46004518c Stefan Achatz 2011-01-30  400  	default:
8211e46004518c Stefan Achatz 2011-01-30  401  		retval = -ENOTTY;
8211e46004518c Stefan Achatz 2011-01-30  402  	}
8211e46004518c Stefan Achatz 2011-01-30  403  out:
8211e46004518c Stefan Achatz 2011-01-30  404  	mutex_unlock(&devices_lock);
8211e46004518c Stefan Achatz 2011-01-30  405  	return retval;
8211e46004518c Stefan Achatz 2011-01-30  406  }
8211e46004518c Stefan Achatz 2011-01-30  407  

:::::: The code at line 397 was first introduced by commit
:::::: 8211e46004518c977f70f2661da961d5ba617399 HID: roccat: Add ioctl command to retreive report size from chardev

:::::: TO: Stefan Achatz <erazor_de@users.sourceforge.net>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--yjPt96/CA0uljPd2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICOR9WGMAAy5jb25maWcAjFxNd9u20t73V+ikm3aR1nIcv7nnHi8gEhQRkQQDgJLsDY/j
KKlPHTvXH+9N/v2dAfgBgEOlXaQmZvA9mHlmMNCvv/y6YC/PD1+vn29vru/ufiy+HO4Pj9fP
h0+Lz7d3h38vUrmopFnwVJg/gLm4vX/5/uf3d+ft+dni/I/lHyevH2+Wi83h8f5wt0ge7j/f
fnmB+rcP97/8+ksiq0ys2yRpt1xpIavW8L25ePXl5ub1crn4LT18vL2+XyyXf7yBht793v31
yqsodLtOkosffdF6bOxiuTx5c3IyMBesWg+0oZhp20bVjG1AUc92+uZfYwtFiqyrLB1ZoYhm
9Qgn3nATVrWFqDZjC15hqw0zIgloOQyG6bJdSyNb2Zi6MSRdVNACn5Aq2dZKZqLgbVa1zBg1
stQsl1A+rNbpm6GyrLRRTWKk0iO/UB/anVTe2FeNKFIjSt4atoKmtFTe6EyuOIMlqzIJ/wCL
xqqw7b8u1laK7hZPh+eXb6MgrJTc8KoFOdBl7XVcCdPyatsyBSsrSmEu3pxCK8NoyxonaLg2
i9unxf3DMzY8Muy4UlL5pH6XZMKKfv6vXlHFLWuMjGbcalYYjz9nW95uuKp40a6vhDdyn7IC
yilNKq5KRlP2V3M15BzhjCZcaYNyOyyKN15y0fxRH2PAsR+j76+O15bHyWfEtoUz6gpTnrGm
MFZYvL3pi3OpTcVKfvHqt/uH+8Pvr8a+9KXeijohx1FLLfZt+aHhDadli5kkb+fpiZJatyUv
pbrE88eSnJhRo3khVv72sAY0KsFpt5Qp6NNywNhBVov+XMERXTy9fHz68fR8+DqeqzWvuBKJ
PcGgDlaenvBJOpc7X3hUCqW61btWcc2rlK6V5L7EY0kqSyaqsEyLkmJqc8EVTucypJZatEKW
ZUP3WTKjYF9g5nBUQUvRXDhqtQWVCse4lCkPu8ikSnjaaSlRrUeqrpnSHJn8HfFbTvmqWWc6
3PHD/afFw+doD0brI5ONlg306WQmlV6PdkN9FivFP6jKW1aIlBneFkybNrlMCmI3rU7ejsIR
kW17fMsro48SUSGzNIGOjrOVsJEsfd+QfKXUbVPjkCPF5M5WUjd2uEpbCxFZmKM8VuTN7dfD
4xMl9flVW8MQZGpN6rCPYBKBItKCPrCWTFJysc5RprqhEIeT2mSQ1X2rN3wHh/xiCQhhEJTJ
yAcjU2fRUnEoat/7ImElZscqM2i4kcWuC3xSi4Jco1wMc+sqk/NGWlPVSmyHvmSWzbLWihcg
NeTZCAc1bLLivKxNu5VFUxkGitKaWX98PUslK04s/KQFou6RaomEWlR36SXYDBGYBru4IJB/
muunvxfPsIeLa5jc0/P189Pi+ubm4eX++fb+y7jigOg2VoJZYvtxqmboaiuUich4dsjlRdVj
j/bIS2+DTlHPJxxMD7DS24onCQGnpg2fFuQO/oOZ2xVSSbPQU/GDIV+2QBsFGT5avoeD6gm3
DjhsnagIx26rdmpmJFm1PjIQdWZ4m5STFSblfi2jWEJWIwg43IqDydF8nawK4WvLqFJrkXPp
EEG38uGKDpZs4/7wbNtmEGIZKD6xyaFVWnMVErEtqIZcZObi9GQ8IaIy4JiwjEc8yzf+cbFc
okr5fg6zNOBSOCchyWENrKrsdZW++evw6eXu8Lj4fLh+fnk8PNnibuIENdCCuqlrcDzA2WlK
1q4Y+HlJYM9HXblCpQy9N1XJ6tYUqzYrGp1P3CaYzvL0XVAsyroQCTgiGahOAA2yWecXr17v
br9+u7u9uX1+/Rn84+e/Hh9evvx18XbAn+CPLk/RqDClGCg2OLapjoY2TGDS7Rq6qT32mq25
01Zc+VvrGGFoW6lQaQHaoXYZYGiyjpt3G+KJNxOqJSlJBoiAVelOpCb3uwcN5lWgDKMj18LO
PR62SkMXIpoU6OIrcrp5s+awh/NVU74VCSdqghaL9WI0Uq4yoh7ar9k6pdDJZHEtUgzgBzgh
ADBBN9P+Qs6TTS1BEhBqALSlzJ07QuiZ2k785sG2wy6lHCwYIGNyM8A+Mw9ur4oNLpSFnMrb
bfvNSmjNIRrPqVJp7+eOIpBOXcWR1Dm4PnfoF/qsnmdrv8+imuj3EXVXUqIl75ThaAvH4paX
K3JFxqnWzmfgbYl2NlAAsoYiccVR/1v5kKoETROKV8Sm4Q9K26atVHXOKtBKynOUEJiZIv4G
85jw2nox1kDEMDrR9QZGVDCDQxqpsVUtAbkJ8DSDo6ThCJWIqTtQSEmbFamJM5HB+FPf+XBY
3YFjr9TaBj+CEmxPNHpqXxn4YlkTdN0Yvo8+Qbl4U6+lz6/FumKFH7ezo/QLrCfjF+gctKWn
qIUnlkK2jYpwHEu3AgbaLdOM9l2BFRDcc1c3yHtZ6mlJGyz2UGpXA0+wEVtv7a0dQcs1dgJD
qcD9Ag3iNZOU4anV/AMxUntOUl/1O0mDJWtjt9EWglS129K64+HmLk/OJuC5CwbXh8fPD49f
r+9vDgv+/4d7AJEMDH6CMBL8ohEzkt1avUp33sGGf9iNj2IwUBph6l5e8OBZtaz9PsI4Zs98
frbyXbW9jYYH376WdZFWPN0pT2TqS4eL97ZW05iLV4e7z+dnr7+/O399fuYHKzeg7nsQ4Qmw
YcnGIcoJLQisWNkpERCpCrS4cA79xem7YwxsjzFYkgHjscyMDc20E7BBc8vzOHTgVMW0cJD/
1u5IoG6GsAMrxEphnCQNzd1wUtDnwob2MU2suKpc1AhUmharIj5oFQCkGhTC8uT0LEJyuuYw
N6IeRuss0xz4a2xkzptKBtqUM1VcJhi/8pVRvXZQuoBTUeiLtxF61azibvuhScMTFyCzZ69+
fLg5PD09PC6ef3xz/lsAuXvZKWviEKAgZ5yZRnEHY/yzjsT9KatDb9kjlrUNqwUhNVmkmdBU
RBRruB0CE6iK8DTxvYFVBgjkGb1gIFTDAQOKTQHSmf6Eo6g1jdOQhZXjCDqsSYELqTNw5Tzr
1JcM4NBrcxCHLmQMaLxoVLBqDv3JEn0RQC3DKaA8r0vQkGCXAIqsG+47nLAXDEMPgbruyty4
ZjYl3+LZKlYgXe22l61xWcLIRW92tmXcv4t41g3G4UBoC9NZ7HEwW3r3hkEeCYTErL2z2ZW/
hzXNJZqNflCjFU9U5UopA7555/OWtaYvDUo0uvSlCehxWZKUQXHVzczK202uwELABoAIdH74
uc9SLOdpTqAR/yWyvgylDteiBmXh3A/dlCHZ+I6NPZllvU/ydWTVMNa7DUtA/4uyKe1Rzlgp
isuL8zOfwYoagNxSe3ZPsDenVtO0ARxG/m25n+ig0X5jxAthNy9AMj30Dr3DwXJLEOD1jgAn
mfbGOnp+uZZ0SK7nSACesEYd5bnKmdwL6oDkNXcC7S2CLeMA2tGIKRMAq7QUcx7Qlms2Nfhg
sWAUulWsWvN2xddgl5c0ES96JqQu8DshjAUwPzvS8ObCCiVep7ZoGcJyQNFdYaBVFQef1jj/
qbsQthPDu6g50+I7RV0BRqsKvmbJ5YQ0yEFUjFdBOpdFStV47yTKWVEPU359uL99fngMQr4e
Yu2PXdUB8VGPTXgUqwta5U1YEwzcRvcXHSSdGVu4xsvzFXm7aE9Y58J0sodX49EOCVkX+A9X
tCorRQJHERTV3Hb5Z70z9CJa9LcW24RlqVCwCe16hWEwHTfBXPqENiKZBNgs8gCLCsLNpnBu
JPdiHmFjZ4qjm1NRoHgVvfXFi7mGX5x8/3S4/nTi/ReunVWwAHqlRtdMNdavp2yNUYFhxW8E
dsKIK06rGWweEPUsrSkFher6kOfKxPvc3bMD5Wc4alggRJsInDf8cu6wuipG7+2dLF4lTeQr
4qA1L8GJETGSl2eUvsyv2uXJid87lJy+PaFv/67aNyezJGjnhOzBXvn1MIjveaDubEGL2Tkz
uQNM523akGC8zi+1QMUKUg+a/uT7MhY3vIdLmPUUjtUHR2ldQf1TV723MO7mq99acKGkn3nk
NOuoK/ayKoJLt5ghvrgbJ1mmmLmEOp4KPsG+igz6Tw11bQm+swCNoAUcRGM9nrmQmw1gFOAz
1ngF4Pvwx1yi2LEqPM3SlSkOWKQC29H4WV3gBiad9gR1aGB8+GccyXdeHMDzQc8OW4d42CV0
eftpO6GOMAAM8HY1qDejPHsXjHdwfFmatpEGdWour3G70T93Didu/KAwneF7+O/hcQHG5frL
4evh/tmuFktqsXj4hjl9XtSmc4W9wXS+8RjPjwh6I2obtPJWqYQ5cB7ErKAMz7ktp+S6tBjX
hthHxqiBHdtwe1dPNhAxz3lDQEqKjc+8+wDWYAe2gGeZSAQfb+eJ6qH3j4vo7cfkqz9QVmQ0
YCq5aep4A8U6N12GEFap0yRqBI6QATPnBmkxhJ5iRcvZBRiipCSk2OVYk+6m66NOlKs+qZrV
KbkSdn61iMfQ75xfpvi2lVuulEi5H2YJOwKtSqTo+BwsXpoVM2DFL+PSxhj/YNrCLfQto7KM
VZNRmDgLIlhGEL+5wVlvSXGQJq2jfkYnx2HAWbIIYvMhcTJSUZdifqhjo2y9ViCHhsymdHPO
ARWyIuo5aTT4vW2qQY2jufPukka1NIpdU68VS+PhxzRCLI/MIUF5kjSScWOU4MGByqXBlWXJ
pamLZt3pxrkl6LmEjN0bJ9UrOqLk6vIjItOtYgl2QB5hUzxtMLMNE/h2TCGAKqjBjoqC1dxT
N2F5W5ViMgckHBHt2tDpQf06w99x8lywV5lq6I2qEZLIGmSQRs3d8ZSRBwqauneu+/SdRfZ4
+M/L4f7mx+Lp5vrOuW+Bx44HcC4Fhqg9NCw+3R283HY0zcFR7EvatdwCrkrT6G7bJ5e8amjU
5HMZTqPegKmPsZGC4Eh9PM5HR8OMvDwSC7qnCXQ9nvopRnD5aS9PfcHiNzidi8PzzR+/ez40
HFjn8IU3SqItS/dBmWQgJ9Xq9AQm/aERKrDOQjPQ57TcIS0tGQYk6MQ1erRuJrf3148/Fvzr
y911D4LGhjGUNXjSs47MHrjYaqbvSfvBSd1svWgdhjsbQPRXEaBE/brdv12eBkU6Z8u2EnHZ
6dvzuNTUrNEDDOyvva4fb/66fT7cIFh+/enwDQaMGz7Bgs6Ria4ire8TlvUx0AjGbuKbkffg
EsHRWfHIGcDXE9b1xAhgNvseoGO0fgnF2LHJ2sQdu2TMAdw1lXWeMBcjQQsZ4TGMqmImoxFV
u9I75mGZDSL8qPGhDOE3gn3AeFHXApYL8Tl62hFpskiulOjHEuYm1zWDQ8iibAMXspfKBmG8
20V09/tuotaypnLxAPsCo4uiBYJp2ZyJ6Upco0J9yAq2JuBpRIe6U54xS95yEyuJhx0tvlg3
siHuDzVImNWdLj+ccKMy6BFd0y47ZsqguemQwgyxi2eVLH4x4kbuns+46+F2lwvQumJyhYJp
bXrw1m12tKtB8lXSXTjH/ekSHe3uyUssEmBtQXugg2YdbCfqqCljPs0/xEVBSngoEviYZ7at
fNeuYPouEyqilWIPJ24kazvCiAl9wN43ryRsVJB2EaczhBLoRgDoCV1Em8PlLlH7rLBJI0T/
fWaC6lYNozjULgeq7AiVyPkoy6YFLA6Au4PG6FmTZMwo/QkLoKO1TaOYRgzcAXU5oN3FTzTW
rtRF+mdoqWyCyOs4Sc0TzAU4QkKfIcp47ChHX8jYlS9ATKKmJ1fjo10Iy32L4VHwhEnyxjH0
6Qsj3avDON48YYDD7j+YwXIMmM3VSzIRNzzOeiewsU7s7AVxLJuo9/jeWN24wXzzLinspzwY
rLXtRswzOeyx8Zpmr8cnW+LJaeK8I1dcxsW9fq8wfo/mGPNBMbD1T/mIrpzIN+4okCLZE7t0
o1jHOjoMFoGUouVdZlb3m8vJPNP+QoInoLG89oHUYNwHIQUgFqsNiOXle2HQHtsXV8RGYddI
Axa5q2KW49TBdNn+wR5ITHOkJhikCsXgCUdI2tSw1ph9ZHcKo7ptgbbCYNrk+dlm5UUJCQ7A
sD6Lwzyr90bKWEF5OjafrlglrcE8RupeZE1hTdOZt1kGd0ZnybDJwqXMD2Br5Oi8mdB2djlV
b05Xwt0nU9uDkh1vLlU21hh2u924IaMe4IFjNsMypyMtBHLB++6WSe28RKwjpLi6OxlkdYo0
TgrfKYHX1d2SdLhnvL8A0+/Agcu3JwOJXtIl+CyJuqxjrOK5GvOUyeNthyDCN0jHqVEPozqa
SzUODUqXTQnniNJrA5t3aWHvMWnlgD5dJ4kEAyblwMlJ22KZxq8v+slosbaGi6gOZhEsemY1
7CVszHrwSRO5ff3x+unwafG3y/z89vjw+fYuuJhHpk6qiLYttX8uH900xTTSUz82hmD38FcK
MEYofLD9k0KbXlEZ6xy7BJ5JGupP/PG+TTDWJaZM+8DA5hVrNGvj7xV0Rsdfhu5IuSdQ8TO/
kKepkD5b2ZHp/AG/gRaDsiMOmavQ+y7HGtQqGV71xzsYcZLRpY6Ioq1Qr3cQLa480Gff1seM
M2/kY7b44UPMiGd3h89QNAKw4aEJPl3C40vPyEUc4KzmF6/+fPp4e//n14dPILYfD94TedCn
JewHoI8U9PtlOdOWhSgGNNN4PzW+wyhmLjx0tRzFsKmcLgQIBBKPEjDRMuOVmZGoLFS5izgQ
JNkX+altxl70zbOoHcXQ6Rp711SwusYVZWlq98GuKmWR+oT7dsUz/B9i5vDhucfr7sV3Chr3
0fd4PWrVGv9+uHl5vv54d7A/uLKwuT3PXmxtJaqsNKh3xzY6JeydbsekEyXqwGx3BHy6RIeQ
Jd4mlDWp7ubGZgdeHr4+PP5YlGMceAwLukd/gLkW13d3DzfXzw+PHnX0upCDDOAVDfXqSxcy
eDE508PAnjdZVnBn1YifEugT1FVwr9+lChFFmJasuG+1RtK2u1iP848mHHG0BB/5r/2b3u5e
nkga4PsEzCmmxXfXvGBCo+YwkQ47s7/JUk0l0w2v76O7yPoZD8xZBnGJmdph+fiWPAI/Rxom
EhT8pSwA9NbGIjebm3hGjbtjw9RtE2oXu99ReLIrA02E6d0O+oy5kF5S8hrhOuolOhW5FGsV
h+S9QQ0eKcGX2ChlGwEzTN+xCqk1w3uTMa9IUw+p+gW3C+h+siFVF2cn/zoPhjSfgR5uEJGZ
nu9qCYJZdYHeOchsgakNtLKif8RJYFf05MApcXFzzxRNHXmiI/vQGhSrDUtsvHMQEOxDpzYT
Cn9KI8zgCfjs3pBsDstz496MuiAIOLfe9pXhR5z0PxRlOiy0z+7CImxZX/zfgA376xJ8JNLf
DURusY1hY6Tc8xzTXun1oIqwTy6N3JniwM0fORplN8G5e10WJAX47RucMJwyEK8AQtlYvHMn
O3JfOi15c+rLgiude3gBcmWtaeuuiyNnt86CEt/XC98vcmXzt/GXEgKHAHZ85uIomLqN5fhR
0bJDEzYC1Oa8qF1/Q8uIGuxJzWi0V6gm/oUIazXT6+frBbvBZLZF6Wclj2njrIzvIDtTOVe3
p89b8/G8+G/PNiv3SKe/T7CjqA7P/314/Bsanl4Rgpbd8Og1CpbAMjFKoQJQ9Lx6/AJ047/X
zFyhlEEGky2Lmxx1SzHz2CdTLquMpMLM8dKRrpmCBsMfyiHht6jCKYvaPdLFX9yhr6lrfGeK
r44Bt2KWPJWHA0x15f8kk/1u0zypo86wGCEB7aV0DIopmo7zFvWMi+OIa4Xns2yoX4VwHK1p
qiq6x72s4BzKjZh5Iu8qbg2dgYLUTNJZEx1t7HYmGQD5GP38yNLAr5oninrmYsJSh+n6hSiQ
UZFJ6r44bL5J63kBthyK7X7CgVTYF7zGoMUWe4c/14O0EdMZeJJm5YenepjR0y9e3bx8vL15
FbZepm9pJxt29jwU0+15J+sY9KITiyyTe3mP+f+g6GjVibM/P7a150f39pzY3P9x9izNjdtI
/xUfdw+7EfWwpUMOEAlJGPFlgqKoubCcsTfjWo89ZTu7+f791w3wAYANMbWpmpTV3QBBEGj0
G/YYEpHf+rHOmjVRUpSjtwZYc1uQBQsQnUagtSkpvrzkfNRar7QrQ0VOk8etQc+zExShmn0/
XvL9bROfp56nyA4JoxVN/Znz+C90JDKWTDwQvpWy6FOSeF6GubPZFMzZhRrmrkagxuJj6H5M
WEHZM7C/vMzRPyel2F2o1iC8K+s8CBVJ7jNqAbF2e5LYbX4FCfwtCkMvV5ehh+MXEb0MSl95
RFbSGUDx3POEbSGivafwGjImSdeSrGKWNuvZPLinHxeHdLolK1l8JDH1fEV3xXLa5pAfQNik
T+XbODvnzFOyi3OOA18tvS89KpozyGshZeaIUox4AP2/Ann7hzG38DUYanUV2VmW87SSZ1GG
NPurCDnF2lBYodZ7riS55zDFN0w9mdgH6Zeo9EhBuPdSxAuQpSWeCz6q+6L0PyAN3RJnnaal
K/eojVwIT2jlQKM3OsWl1WFco5fu0tgFSbb3sSMU33w+fXw64roawbH0VYNTG6bI4CzNUuGE
ZPeC+6h7B2EK48aHYUnBIt+7e5a6J00MJPGiLnwMZIc1SegV5XCpFnwWBY91rN0wot0e91gw
Uol6xOvT0+PHzefbzW9PMAFosnxEc+UNHEeKYFBEOghqfKjEHXQBR9SBzdyq3VGQsbT4UTbG
+aJ/N2ZlmRaEQROqqIz1QTf5lUj2kAla/gl5fsBkDXqd7Dy1bSWcPr4qmCjI7mgcdfJ2rAkN
JGg5MBxYmFXOYzMTSW1vtNIl0jhwdUSG9s/bhjUENqNShS0FmqEyzQlbCC8P6ObveFa30aKn
/zx/e7qJ3p//Y5WX0WEJQhrWhvEvOIG2yA0Sp+qPwmHUMf5BjE631UG5IMWaUZsKlRLhOdCd
MSvOj7ZurrSAyvC4PTlAZkdMtSC/bQ4JGh4W4aiVzCl7oqLPE+6SN1FO1QDR5GXikGOpX5pa
R3BLl96/PRBbaA92Z1h1M0INSlmetvbUYmnUEZCV0v0A3AagFVkFnmiYjRSqIoI1RFhGniHl
TJp50KpzN8pZTSMGfsAm5N5CrD0VkX82JsLQvusURr0z36fVZLyY4/8M09oe7ZbbEUCx1b0q
IXBrHDytcwBD7F1mjrBvb6+f728vWAzysd/I7fb+eP799fzw/qQIwzf4Q/7x8+fb+6dZTPIa
mfZbvf0G/T6/IPrJ280VKn3wPDw+YQa+Qg+Dxmq/o76mafvUCnoG+tnhr48/355fP00hQjGn
NFL2WVJCsBr2XX389/nz23d6vq2+5bkV1Uoeevv399abt+u4sTgYAjTzG065WqWaKwMHqOGw
Gskql0hmJ1C2DZ3OrYhxhIxSVhHYG4+Ntw4ZqZUXLBeRfaS3oKaU4m4e+Ns0SpdHnRDTrBez
cQ8tQwN5sqwbnz+/7832MQx9nBKM9LCz0jpsCMo5lVTV4VUUQROCsN0dqcXDz+dHkBKl/ryP
7tHa95zLpq7JZwIG5FuybGRLUtSKZGF6dj0PHpJTnr+1B/1N5lqa2akWsdBVpm27u3YBaIs8
6T+ryiTfWW06GMjgJ3d/uSReLguiTRqx2Jchnxd6YDtRJCqfT1XHHrHH3fP7j/8iX3t5A4by
Przw7qwidUymjJ5q1neI2Zj903pqHfHrnY2BrotPMedljPUFuRCU3jgXoFXSpQ95yr2Vx93Z
6dUJXUK96iMdzLfQATUm1vOFMXouKkTlWTcKzauCO2sH4ehDats22uFNm2CQjKkIk5ZYBe4Q
jzMKSSnxx3PhA6KrU4xO2C3sh1KYcigwPctfp383Yh6OYCAbihHwHIxASWJW0Ow6LIyMEeUG
xKDpCMtM72zpFZE7nobaaUlnHnp2fp9u+Kg0AIMVJAdhHzotYFy1t0PgidfOIGVbbKnaegNG
7mD3aOMwy0CHCh213d7IkS3hsCK5kar6N16khAepSq00fHICS1r+6wFlife3z7dvby+mnPE/
te85RmSF8sFPr+zZ8ykdq+Hdybu2tCwxkQg3REb1E68QAXXVhIfwpaSxTPdZto/5wNesUoMK
hftYVZMalUXRl0k8/f7+cPOv7gPoc8WcQw/BiMtEjnizT83sQPzVAHe1/MIKmGCxdQohRbGj
Madt7UFIy/WZeJhqRpW0dutJ5CEG7rYik6GdKxClEZgOSOV9VMwOlF3ZVh7pylGqZWY6gtO8
Fd60eaxKOCWAW3AtuD9/fBtvcclTmRWyiYVcxNVsbq1iFq3mqxr01Yx6B+D3ycVmUWKbYLKc
NQcHOEEySj8uxS5xElwV6K6uA8tbE8rNYi6XM0o+BJYXZxKr3WFdahFa1gJgoLFZiCKP5GY9
m7PYOmeEjOeb2WxB+ZEUaj4ztlo7XyVgVisCsT0Ed3cEXD18MzND7ZPwdrEyMo4jGdyurQCO
qhVo8KAlE/qlFcMWnZs6YqWyuLhmh17J8UVloNSXwlaJdtxMrEG5G4RpSzoN5+6y1rGYHM7S
xFDhum+k4A0r50Y9xBbolqBrwaD83q7vVhZL1ZjNIqxpF2JLIKKyWW8OOZeUV70l4jyYzZbm
KeQMvmeh27tg5qxSDXPjlAYgbAEJslBpxnaUT38+fMAB8vH5/scPVWX54zswwsebz/eH1w98
5M3L8ytwTNilzz/xT1ORLNEcQ57p/0O/1Na3RReGnjNVLy63XPG6lpkgQI0Z1jlAy5oE7816
mQP4ENmexw6e1wa43RJVYhr+QOQ433P391B8VqdXFzxES+jFNFTz8EAZwNSyZ3GISa22kt1v
CNcGM8I758uBbVnKGkY1UplQxoFQ5Sy1ldAWpMRE6jxp0c5g9zlCghr+I1ePdSboqGP0+mgI
ZYuh0L3Gc5JWGJn+rd0De/5rMF8b8o3Gxdl+7/h39T1tnPObYLFZ3vwNRIanM/z7+5ivgBzD
0d1hKVYtrMkOIe2+6ilSMv1qQGfSSiK5OiZjfbAQVm6GhemUHkKJb/BkHZXnGP3dGpjbLI18
7m91+pIYHP3+5JhghgV/r+pfXInVKjnzeJxYiI5mX+SBD1XVPgxqCh59bgub/BTRwvHe4zyH
8UnXyDa8F/wlM587p9y2H4X2+wuvb7s80a8G8KZS31RdcOh5bsVLqri3dn2pkEHDf53Go+hE
Q6/yDRAkVXqhc8xrt6IScbgViAnA9BZhZklxPF7QLwByAK/pGbjkB1poMZ7DIpaXdtHHFqTq
NuJmnOhgz+09w8tgEfji6bpGMQsLAQ+xbumRsQgz6dmvQ9OSZ04pM54Kj/dWn6OlnHqJhH21
O7WQPt95RwA7Oi2FdYEMu/fUTTXbFSH57Zk0Q0dNBK6YzJKdWRn7IkviwIugNwNifPNIL7Gw
bvAWn+uvqe9otJfzdkmHm2zDBHmS556/tKbfNfR9/1Lss5TeONgZ/VI6OcUVsM2GEy8csog7
9+4AZ6QiZaxGlThZc4TFNNHsqMQK2pJhklTTJNu9h1MYNIWHRo8PI8don7u4P4mIFI3Mlzzw
WNoOiBbUlPRq7dH0V+zR9HIa0BVlRDBHJoriJMldF4JAaQ3ZZTdEE5Vnw8juIphIZzdE9AFh
NrJZtA7UjclyyWarNrxgeFA8p6PNJCwAj+/U6A/LhHFLEd3y+eTYebqPuVNErpQpWRzVbPbV
vrjXQO1O6d6+vcRAakMaiTqc2NnUngyUWM9XNc11R0X5UXWlznMscOzSzTxxqXs6FAbgnn0s
al8TQHgesvQ+fWL9nlm6r0/2geh7Sul9/pdkYj3Fwromy8AkrKi4neCeVIkv4EsePSGb8nih
T4wsRCmimVqDCYyBpZm15JO4XjaeiDfArZQS4cPK81X07jwxHhEW9lo8yvV6FUBbOs74KL+u
10ufquz0nLUbbmDqLL1bLiZkOdVS8oTeVxqb7WgpN7kUtm4Pv4OZ52PuOIvTicGkVnepaGrM
WQS1f88TXZtgilulrGxfZuhGg2jFRa4X6znFDsw+eYn3PFv7Sc6nDkv4s8jSLKF52XqxmdlH
wvw4/ZnTCg5pS1DVt4zTapDRMDtaU4LF/yZ4SJseBdxfpLZf8QDiNiw1cj4vHF2aO/ISErNz
nkos6GKZkbPJc/k+zva2Wec+ZouRcabHeQVL6LPmaeND35MJKbZMHDpFgrcpFZ9nDv6E9rDE
khzuQ7Sl+nIWimRyuReRHWpxO1tOLGYMYCu5JVasg8XGE82PqDKj2XaxDm43Uw+DtcNouazA
cPCCREmWyJMdCCnxmGom17nkZo1AEyFiu4K2DDfz2YJyiVitrJUPPzeeOxoAFWwmph5T6osd
/LOv2/KEzwIc7wIOPTYLREvBp1adTKS1QnguwsD3DkC7CQKPWoXI5RSrlFmItp6aPi9kqc4T
6+3LBJb/X/iwtjhzYHl+SWAp+8RhODA8ehBWL/EcBoK6GsscxCXNctAvLZn8HDZ1vHf28Lht
yQ+n0mLCGjLRym6BpdtBBsH8HulJTSpjMsjK6LPiaHPSOgyBtc8X+NkUB+EJHUJshQWuRElV
ADdFUvE1tZNRNaQ5r3zLsSdYkPK60bl2vZmdt844ZK0opZL9tzSsFn4W3NLEMXwtH80uiuj1
BOKYW+7ZGLvcupe69Gj4vr5g+1zq2olFFsceG3SiI/QqJ2u9Db2UnfvBjLfsQylHWOPJOX1E
SFqPPcltm0GirPjmx0FUyEp6NhF5BD2vpFN6EJ3zPZOeQtuIL8p4HXiu2RnwtGaBeJSb1x6h
AvHwz2fjQrTIDzQ7O+sjyPg1mHETfSZTOPsudPh57S6C8rDyyZF2p4mZJWyiDHsfge2sKQTK
ufXMRRVwBFssPEP/6MQ4B0WSQnIQhr3zZqpEBDo/YfnDnaCxBWttLxSul6AopPT0iALIVnpw
JQ0vPX19vUTM05WyZfM0tZj4mY2rOaD/7QXLMQDSdJWfz66zqWUOVgPjCEhq2Ay0eW93+iJK
eWo82b+wWZZev4t2J0lBRb4gXzHycgYVQkbjFxWvP//4HLtkuyZpbt47pX42MY+kC9vtMN4s
tqqwa4yusXRM7DoyGpewshD1MSEXuiapRMXiSOx0ezXk08fT+wvGzj13AXMfzogxHlhyHSrt
PrLFYP4VWRjBIZNhwUEXqq3bhmmay693t2ub5Et20aOwoLwih8Yrh28ZH8iXPqVbHvllm7HC
iq7qYMA96aPEIMhXq/X6rxBRCs1AUh639BDuy2DmOXEsmrtJmnlwO0ETtZmyxe2azjHuKeMj
jPc6Cd4zPU2h0ks9ScQ9YRmy22VAxxaZROtlMPEp9K6ZeLdkvZjTbMeiWUzQJKy+W6w2E0Qh
zcEGgrwI5rQLpKdJ+bn0KHM9DSZRo4Vx4nE5COQqYfw6WatHTxCV2ZmdGR0LMVCd0sm1VCbz
psxO4cFXraanrMvJztDu2HiiEYZpL4/qzp6Jri467l9STiSD01mmTHV/cy491ywrrI6KJfrU
aFBRY67mY9zxNkxWmzva66UpwgvLKd1eYzke+TrmzGnXYfDfZHPQ6u34dIWtZF3XjI37dpmF
PRuXlOV4OaodC+cinaiu/hTBuipUvQtNoMKpzUs61G8lbrOQh2axbxMlcktQM1AHlp6tAvcG
7riFH5bePeAI3cMm0osCRC4QoZfjN1XrQR+n5Mdvl6NTL7NFFolYOrGUCmTnTSAEvqsD2c0W
Y4gabebA51Eb2ujSB8EIMnchC8uq3cLodd4i6YocGrmyDjglLRwe3h9VCLz4JbtBWc4Kxrbe
hggydyjUz0asZ8u5C4T/u+HoGhGW63l4F1AmCU0A2hfwDbc/UOg11OmuYJTTSOPa+BeiNwAl
+iJhpzt4Zy/X0hT6PPeQnBQNidqzhI+jKlrlgPoqfeAfJYBrleP7w/vDt09M13Tj6svSqmxT
UXZwLLa2WTd5eTFYWHuPpQ+oK/D9Ol8ZScGxSo7EXCY3vUuHdD69Pz+8jLMP252uqiOGZuBm
i1jP7fj2Hgj6OxxIIaiukSoqZV2JY9LpLAfr+3Wo4Ha1mrGmYgCiq8eb1DtUwI/0Q0Id1+d7
UO4JAzVpEtANEjJCxqRKi+bEitKom2piC7yxI+HXSFTFv4hH9HskLL3oxFUar1K/7HQL+5vg
5St+fGGWbLAanp1bTG3k5OQV5Xy9pvQ0kyi2buq0XltE3k+HaWR26ojOeXl7/QcSAEStbBXl
bgYr233hF3GNqDaFfSQZwCuL6wtZQ7ZFxhiQd0+00oiu22tzK8MwrT0Wy44iuBXyrr4y9y0D
/lIyDAgesdsxBTUyskHbnReHeolezO5WMIm27BQVeEtrEKzmw+XaBOXwIRwauxzHAP0LbwJE
sKf1KAMHWeTz0bMANjCBxXz01J2ED5wj+tpnU1Qi3cW8niJFvvQ1WKz87yDzgto+CKYXWRfH
b58JTq9JWBaxOmiJvlPoViVkewLM02ZPbo00+5pZURon9EpYl/xUXfKuIZXlidzbZO040K5j
Cf8GXI0fGjk348HxmRdwlBwpGByyFY9/7Ys9t0HYo4WHdwGj+B3F5jgVFPNNGkzAcuEqN0Nl
qVsS9YDDG1nIwtiKRjtDtBV6Z99yg2jTZKsBUuwcEPxvO3r2Ge96jzJPJUw1OrwJ20lkHfDb
KyM7nNs7bwiQvm1WZFbNiQE7ingbUE4wNEGxZUvSKz5QaA8hAXbrTQ24Gn0iBaXOopIsLG9D
cmaVdWBgcWdO7ojKzt7jlSuxH3IygAJW315dMNNf29ut5hD+5fSUm2BFJ6SbfamhYzJLPzOA
TViYIqKJcRw0Jgp4n0idIHoTn56qrCSD15EqteMBEKSeRTuTw33/OC9BWFCSH2IqmDSsI1Bf
qLHKcrH4ms+XrqXCcJDHoedWj1rE8QVT4VV1vGGeOrgDcYwO3SfF6yOxUAGlapskmNHdl7gY
6uqMtBdtzoa3GbsZ5u598PilupumDV4DUGW0whsUbLB745GC4S2SlvkdgMmp7hwJyR8vn88/
X57+hEHiuMLvzz/JwWGj7sByoHEZLhez2zEiD9lmtQx8iD/HCHjbMTCJ6zCPI3Nmrw7b4LDQ
g64f4qvDZZq4+o/DXn5/e3/+/P7jw54CFu8zfdGBA8zDHQVk5pCdjvuH9YoxVmkYZr51xt/A
4AD+/e3jky6FZH7rcF83p9A6rNRYRLBaWJm+PfiWtn33+PoKPonuVp5Swxq9DgLa4N3imySn
yu4oDraeBe6AQQWnfOYalThfJReiXro9pCoW0vdMHTqJFcHsrqSQq9VmNQLeLmYj2Oa2tmHW
UdgCchXgpCtq4K3kRF0r1V2YjEuQKd6hS2j8hlU9dNObv/2ABfLyfzdPP357enx8erz5paX6
B2hy32Bz/N1ZKsgZx7s54lLsU5X+62ZKOmgZM09eoUPYZQh7Jt2kDJ2FyxNezW2QKzF3sEZX
/NaVBTOyJj1yU+U4cdvDPp0apRRJaebsI6wPKWpvSQI2/woCP6B+0Xv24fHh56dvr0YiQwv7
ae70GsWp88phPr8NnNXXpRzb0CLbZuXu9PVrk9ni6RzvZUZniXlRu4KK9DKyt6tFCixTnTKj
BZh9ftc8t31LYxW6C7jl295V0jpwiDrh1lB6odFgpCTTdLZPSV7RpFAxM2/16UFt7QIKgyUd
TqlTIl2tXyxH4A35H0jwRJgg2boRS8YLu6ngYmEsnBALMgOkrUZsCLxnEixBDbTggxdHoOAB
KF9ut8ypwKG2BJNBhRqckGJxe0eZwQ/mGQU/LIlGG/GlWWiwr0CkwC/PWIbBqJ8KHaCcM3SZ
53bRzlxeiYhKyxwpRisdYe2zKNsXdhrGApMOjkpJIDs3qJQReYrIdaD1I/ld3bD4+fY+FhLK
HMb59u3fY7kNy8AHq/W6Ce2Lpmx4a2JmfUVoruoT37RBhhhm4q0b//kGw3y6AaYA/O7xGetd
ARNUw/n4p28gzbGyK9jYWBGV63nuccuPaT3Vmx3CKjmTm2s8e/2YRYpWDmPWRKolZ4MA/hoA
XWWzAWGoqOp+U90lPV6N82Qjd9jwsg43q9ryoXW4BI6KhZzRoRMdkayD1YwyaPa9oBbD7LdU
T5bLu3i98iA2816Afv3Ea0efX799vr+QNTvbdlt2KQsmrs8GKOFFcakEp83kHVl8SWuiwKg7
tXGEdykePVUOu3GBOuoLw+iHxVK8B3aqq5BHDMvW0jmZHVXEU4y4nngkj48HtLNPPZMniSjl
9lR4ShS3ZHueiFRM9iZCPknzhcn8L8wrEuwE9wgEPRU/i+nRJ7zk2fQj5SkthOTTK6MUe+oN
ev8ktaR1AVJgyx8PH+R670qFekh6rgEsXzuIbIC6ehGvRW1iAZ/011UwNymcCrNdI1Hcu1l+
mvd447hUZ6M6eDY6dAp3mLiW69lD0VFTs8HOoK/v+vHw8ydoJ2os/0/ZlSy3rSTbX1H0ouPe
eHHDqMJUWHgBAiCJK4CEWCBFe8Ngy7TNaE1Byd32+/pXA4YaskC/jULMc1DzkDVlAkODzFed
N9CenADz+7Qximocdjsl3kzJjEQ03pvSYvUZ4diQ0nJtEnd7EmqL5z6Rh7npx0J3VQblVU7Y
bJb5q0P5abhRGmo08xgRYqaobElsJYg6nGr0oI9Amx0Cvi9X3BCOFeY9RVEWEHjenMrEsFQV
0tPPV6ZD2JmTTcSDGg7eW4np5LyBuzMqNpbAB60jHJsxNtmchLEdY9uUGSbIg8cEO3eyoc/z
6Vynm/LzWjUdIKSznCUM1fc7Q56niReGplBbJApR1ZDYt9q4MZXL3KZVnVIrs5ssbEMCmejr
yoJGoUciIzAhTpBZop3YTOQ2m6FAf0Iv21lNYIsyAxqaMTBhkmjm5YCCH2yJWxVidWZzr0qr
m5bsraJlU+N6aeVEGNznr2v0W64GpZAc1VifrIM88zHaq7kCUi8vgNPZdDMbl/BqcMBnIrjd
+fL+gynu0wPzYrEpFqnl6EUrF6Zrbx1GpWSy+HLeVTa0rNXUgqnqPxAWfkUa0V//PXdbAfXx
7V0ri3vUu+jhV4bVwX1EcoqDxHMhur1IFUP30H7RyND310Y5XZRqLoHkq9mij8f/nLTKYCF1
mxJMOXYkQRKoPP+zv+QZ86BTb51BtOSrAH/jks9SdVGpMZDvjhfqGhoDOz8m1xOt3y/UIaiL
6wzfkR/fP2SqNScddJRT6O1hICaeC0AwQAovcCEoBppT12wUVZcfNHO3XeCBp0S55+VKO4pT
5fYeCkRa3tfqeVWTpxLXxspOY0vzjDsNY50CehxaNuF+vx++7qRMDyAJDk2xnEMOvEmqzso7
MUDm15/MdAkb50IKjmB8k2nBz5LyJvQi+Gyjy84hu8cegl9f9BRe3xG0PaYSiNacNWQ6AYIC
3+HsKd3t/wPNoU29gTXTXV11hcDEYODSGIeFG4HO7nCsbWAbgH4eaoLL/A4qlR7O28OWtTtW
m4fVDhog+zww7QqpqsVQdr3crvp9gz344Un/sU3pCBKwWx2XE3KYbwu2LE+3DusoffCs/aMY
NuJgULCdMYFIFcPIGFOCWZtWx78eKWnDQ4NKQ/RF0K5zz+B6qbrK6uXmQc4Yomg9k92vav0o
hIbykZAFKMKVHS3PfxDGsSMzcZzE0Oyk5TeBv24j3/EuS6U4nnf1FNaCAxRCjUdjJGDb5BAO
4ysfx35olwsDQhYvDBBndGFCruYnjBwPpYeBpJ75QTxJkasP0HpG37JFx+E1jxP1xsEAr6t8
XtKljWza0IOa/aZNAn3h3yPi3KrJltBUOGQ8T5IkDOzotgsfeUoNGNOl+Mm0ZG0xLoXdUdNS
f0wv7+se35lyDCnug3H0PA4Q/MpCo8CbxyOlRh7oRUhnKPnTAc2VrQ7BD+w0jg/PeCoHxVD7
VxgJU0Ch1LXxHjmAwA0gBxBhBxB7cAlwCL6F2jGWLZiKuy1/RtQI59R5qNtVGUjUd0RLszhy
PEocOPvyME9XvUmJSe4t4XY1p3LBH7zROoPSyI1dAPJ23wCFnLE/acm6YmMYizHwhsJ+2Hte
TiPsMHUzMNC1IsqLqmKjGHwMNZDERs4kpQxvD2kNW/XoOXxD0Auh26Iqg+D5wi60eRz6cUih
8qoz5MfENx9KmwHQbFnndsCLKkREd0qhQNij00WzYFow/MZLYUC3dnp4WS4j5AOtp5zVqXoD
VpE3qmHCQV6uzQF5rJwQap/85J83euADuUtrSP/OAmBoYCrhBmHIC0ZVrgqmEAGAmOmAgVYC
QNQdoGvWGphACRAAkGahZIVA3+QARiHUGgSEXW/PFE4wNRYKRgSnlQEIbOBM8cNTUwMnRF4E
FKhAUOIAIgIDCVADTO6j2AfHYok5NEiFFEWghS2dAdSKAPzEEXUUBVMdTDAgXywCcGcValB1
1vgelMI2i8IASh/T/rBPoim1oy5Wc4xmdebqvvUmZgORD7SZOgKlMSyFOlwdQ72tjoGWUdUE
arc1AWMjcCeqCawtjwRQU1ZgDIebQCs5BQ6xH0DpZEAA9joJTfXlJiOxD/VlDgQYKNhVm8mN
z5K26gvkAc9a1imB8uRAHIfWWzQNhXLRf+i6ha7wYuJNj26rJqtjx4Jo4Hzet4fbTXpruKWE
ibRON+1U5xXHWwnQ4Zoi4+bitt38ZQUv8Lys6ytaHedpe4b1DHz/3vPprKUlFCGdbWrwelmP
MyUY6IBMjMHmxwD/53R46iV0RZwBxWXdAx6ATzFb+6c2kNcFG+6BNlwwfSuARiMGYOQCfA+I
nAER32oEklXTLIhruGQ6LJlqOJI08/UNjwFtWxqH05oxU4rZvDG5IMsQJjlBwFiZ5jQmmIAL
F5ZpMrkOLVcp9oA5m8t1R7Aq4pPpIH0MT1wxMCy2yzqDpsy2bthqF5znODI1BAsCUFJMHkAt
gMvhnsGRaHo7gFFCNJUabtpxYvRgcEQi6EXXwGgRhlbQu5ZgH0z2PfHj2IevBqkcgqA7dCoj
QcA6RgDYBfiuFCXTyzpGqWIStvB2uc6KwCeKCifC8XLuSAjDiiVsXH5guU7aVYJotZPPE4Z+
yN8puc9LBlp76yHzHoXJoVseu8uUgEIqoCWq0AhS7U1jJ+K24Lg9LDDgnkPbtC25gRnQbktH
KupisyhW3ExE92iTL/3TT4eafvRMsqGH9uL7TSnMwBzaTalfUu4ZeSHfMizWO5asojncl9Rh
mB/4Ys53PYQhg4mMqB8IH8u0SXV3Jj3THSRIBdML8GbpaiH+2AVkpanD82I33xR3UxXNvVek
plce5U4qf7nwBNnpkI7wRKVmVaou5vckGoLfiaclasQcbW75sWHd9DSwjGQEdJ0d8pZCzLG3
MaofeHsgsWponALH2LvanQrLyHe2VEpVg9qMvypcs+6jmdruHQeuqjV8LVcSlvNyMo1wrcCn
xFOlCz2y7gcObpBpTWnnTGQcUCj0NmSW1alKV8T6L2GaVFz2gQLXGK5oBM5ahPVh71zb/Smd
V6l2kqF8xs1MH7J65UCNUzeJmaf648PQrz+eH/iVftsicBdAPc+N9RSX8A1npE3g3ASbtJ/o
2G4Vn6UtJrE34UCDkYRdNA80ySFg+x6dCFocvUIywxbZfLArd9CezXLAvE43yixDazwYfi3e
cQNgwEHLEwOqr/8HMbi6H1FsFTzfe/bhNSf/TGxNY5c5uJ5gpYVLwW3ZAfT1sjJP24VMu8oo
SjRDvnYzQBFC5Vw3OHIcHrF13KFJaZnBT0k4zAJ0PVHjgcuB7G6bbm6Ht4YguWpYWOD7VI7Q
bKnnR4bb2ewBYuSI0K4cxauwTO+pA9rU2WG2h++9C9YdjRwe0jj8d7r6zEaStcsnD+fcsomv
glRtDhLS1MQz6lsKrbYkxBF4a0L2MvvYvpPHcZTA1TsQSAAtYzqYJF5sdmlxwQgQJlACmBha
NQpU3AkwAhKXAGxZYqai39HUxdq1TkW+KdqtLrEvdPQSPqECUv26YndXFxjdre0OEf9wdVUV
tgHxkSnTj9s7GcJGmXT3kY2oyyCO9lCaStYQC9mszfGc1qH+mHwQuruzoNx+IqzVuUY4+olm
qobPZW15SGvfD5luRrM0t8aqqvETZ2PkV2UIsQKsarNi+wvcvfrb0Ah5obapIS9MgCYIJRQb
VWXf7x6liWcnqr9urmVP0Enk6sX2ZXFFimGpOeK391Xg+RM6AiNwFzfTSsR9hXDsT3Oq2g8d
bxBFAu9qpv47ctq/GVG1DfPavyJ0qg/YYf+VZ6EOkWOvuYcdK24J89FsGnaNagwMzGFd7itA
Mrs/mvf5RxnIldf81UJrMxxZypwUmiW5EbegG6CmVUMiLjW3j4B7e65S7bRhEJle6kdgXu4L
1hTWVasd4I4Efhd+K+zgrei21u8Ejiy+GBZr4YEH1MtIZzPpgkR7OKxuSgbrfWSlWUsIuG2r
cPLQTwiUq75NV/kaTeFMMeU3hkGKtX5QMFnR04nrtX3g+2GBMBmC+exGQ7A6hBkImOV5ugr9
UNegR9Q5CY2UklaJD1591zgRjlEKR8JGswh8F6VQ2OQUg+kXCIYREuO9C4FLcJjnoGS2mQ+b
2Nc5URzBAfSa4pUC5bSQwNZrNBaJAnhtYbDAe9w6h+g7yDrItNCrAWhKqQGFYPUAWqsGYs8D
5zCNxBRoHIGhd4sy01SMzojBR2U6h+iLVgVsCAmnmwNXnuFuJxC4yBiCXbXBMPChiEFxpZhh
ITR1GpTEla4IHFyGZYMjSsdkPpKk1niNlKVJEE43ZXtdoWA7Qjw4AwIibiiBofsaEguviKbR
EQPmtth38EH0yBxXGUAwfPniwQecOslxL1Ul8UXPdRIC7/bolMRLoSJhUBwmroxELp8hGgm+
qqFS7jDyA1ck9e5q8u+iGB6paLUITffKCiqXnJOBsxVDiCIfDF1ZIoEYdvQ6uf7BYFtX1lFA
ivv11LUk98srVxDIh9afBkmuqVxBsFXUlaq3TwUdpCtDg7ky0BBNjzf6apXOyplugDGzdPYO
yYrM2ADgktW6Leel0KHlUUkB2FgU7sAEnWuemuVaEeoy9jE2ZHIzWNkX4ScK24oWhOO6fJOW
K7pM8/V9h42WIAvbhJNMzZiScQWmAmwZwY00w0u1jjjLNzth4JAWVZFpO36d8YUv52O/uHn/
9aqa0e/KJK35NrZVLBJNV2m1ZkvrnYuQl4uyZSsZN2OT8hfPDpDmGxfU23Rw4eLFnlqGgw0G
K8tKUTy8XE6QTaddmRfCMyK09JUFte49K44pyXezUQfS4tfi0eIfLDm+vPKVp3a+Z8bEI4AX
r67ARGj5+dv5/fh40+6USJQkr1R3KVzAdD22rksb7onvI4pUKP+0SvlJQl2u1rqrRoEW3Ewn
ZU2vXK8O1ZpS9ge+pcHp26qAzHF1mQKSrTbi4QQKFBplyDtl1zicNcpP8cYGpFbS8fX9h9ZO
bPDD8fn4+PKNJ/Y3aB++//rX5fzFyf4yZp0f/6XSgKBRbTOc4QO3bZ6tG91mIoSa2xOiuvLZ
pszVPQnRHPhxq1mzTcVGFWgGEmCL9CCa1nf2X8DL5y6oLBw6w2WjAxCMlkoLlQfqrFN8u7zc
5Lv25kmU8Ovj8f3ry+XJbEfpE6ue88NV1ut3sU1kiN9eT6cv1759fzo9XuFkxy+nZzZeXWF9
P7++/VO2mGmmPGCf5tTHy39Oj1dZHH0//fsKbbU7X08Vd7owzbj7cXx8eHl6ukLrDStdYb08
/JtbQL1Co8entx/P366x2vr8cHk5PZ4e2Jj7fH64Fjv98fzzfIXTnn6yXJTPb++XH0/C3KBB
2J0u57fz45mN9FeC2pXpFcaehfP881p119kHyg/++MxzHIeh8f5ETfmrcTZXbnbOcV7MzUC/
FgHNz5cTdxh680dZFMUN8pPgT8eINy83Rd7u9D7fCU33nOYYODE69iOjqTOoNoyk6Pj8cH58
PF5+ARcgpILUtql2xCt1k+1KUUh/vL2/PJ3/98RH9/cfz+B8Jb44zDPPA63RWCRsq40KCh40
KaSyTZBxiKOgNSEbGrElmeMEWaWme4zADWONlQUBJZ41RXRoi+XOARwDR6/lh5O0iwM6hrSj
SB3DUeTA9pXvoc3ciYaepz+ps/H4egne1ShHM1bYwZU8CiKrXPUVmYa3yEPOYtwQ/BvVSUuM
wGfkOomfuLoiavMUEexYeAJE+NmxTQQXoDYtdtQ0QxnoaCIC1M46dTAhutk1DS7SMAZfKNms
2BHDNk08z5HwfYY9/Sq8jgaGo3iQFPb7K/2iFBiS1LHq7STG/zmb6N7ZJ+PswM/M3t6Pz1+O
ly83f7wxxeDx8fx++vPmq0JVFxaE5NSX7xq0GYL3D/AqFwdpO/NIkugjOBNG2kNhKdx5iffT
DF2IwTPwDo0QAr+KDGNgUK4fhInc/7lh09XlxGbu8/HRmf98s7/VU1yvCAlibJWHEMMbhSJt
pTnO6hNu1/gznNuGuxnhL/o7tZXtcYCQUcRSGEHCGBBi6HN1H00UC/U9syq5scbUjKduffV+
gCiJcIkC7FmVxwrI8bqqbz1wT+nbC1ZvYAzCJAHb1lRIkVWEvHbYZIAgKYksKfGIbwvl81ZL
uDeElA0XZvTb1O45cmiQ9WjG1ukIObIqaVdQtE8M/ueKEf0IEia9EsTbYHvzx+/0mXSeeGaS
WDpxbCZGCq2ulO1zzGY76LB8gANkbuPk5Yy3SdU3qirOLHHMxdZ+iJRDb+Y6ODG2urtRArpK
x6Eis2quigLNWFjXT0Kjn6z2bQTEtWkrTHz4SGDE4el76H5TOB+ooFMwATZsJt1DPcqPILVj
7CYBgTpPYIX1OUdMa+P7Umv4bmffNv3QBwfKrBvgnc1TDgsxlBz9xZUih/TXvjsRPD66aSmL
fvVyef9+kz6xpd/D8fnD7cvldHxmS8Wh53zIxAzE1kDuPrQlITYahJQd5HpKS+Usq/3QOV1W
C+533miDi7z1tVeJilS9IaiIjZGKaQBRYnVe1mqx5zCzxfH1JkTwyUiPYmTVgmizHnSYPKBo
sClZ0vy3hyrWnwnQx8RUhj34zFVEmWBbzRAR6/P0P/9fqRE6ROCbM0LG73gPRtr7TVYlwJuX
58dfnRr4oakqPVQmgKYHlnU2pYGTioCSoVXTIut3qntvWDdfXy5SLTGaLVPDLVWRzweOI1QB
02zdYui8SKDtjOmgvpHOZVHJLU9Vtt5sqZ+asfPLNYbBTBsHH6SOqJWlcs/WMyF01iD7CyWL
yupbTLg36rZazZbYJHJZYskajACZMUSIlT+2Zn02ikVR+FMXsknLT/af/h62OV6enl6exc7j
5evx4XTzR7EKPYzRn7D7KmvO9hL4vo2cOIwZR1/IWOsVubv28vL4xv1UsFZ3enx5vXk+/Vfr
O/okvK3rT4e547KgYzdIBLK4HF+/8w1B69gxbYpNu90UnSsyZfM6XTTaj8ExoyKipf6B4VJK
XPVftNoB4m6RHuh92XLnCWvI2G6uGklnP6Tfl1z1ysKl0uJYbXBva9rlBGLnzaGm3It9s67W
i0+HTTHXz4vGcNc5N0Z6cDjw48T5jPsaHd716fFJcL0rNmnFwvjIplg9GkmoilT4LaHCGi7c
thiZe+87sOVyzncWa+6QypGmvKQNf/QJFkGHsUKYgpd5do3A/ef0BL3sGjaF73u/fq40Nvrh
NJe1rVGPs22ef9JF3F0mmDD2MShfFPWBLlm5gihlDTD/qDjWOz0/vHzh55SXm++nx1f2H9+Z
1zsh+046LmQqNHR9oifQskJRYBaPcOS2b8R+TUIcGoTJCz2wu0+lWGpqm1rxSz++vVTEeqyb
NHf5yeRwWueLBjZYxuHVersrUsgXpchRot516yUH4fKOu9icFR//8Q8LztJGDE3FZrO22ppk
rOtmU1AqKe4C5Vx+V7lpr5CavW3A8Mvl6cOZgTf56V8/vn07P3+z2gT/9P430uB29KRT2LgG
GiIfWPSezQOrrDurPqxn3LecNZbpVOkzNk9/KwGLLWxPZgy2qOb8EGWaVa3vpWflQ7tJM+ns
BDpHNWLfzap0dXsodqxNAu1GkjbbFXf3dGg0u+xAbem12Fxevp7Z4mTx48ydEa5f389sej7y
03xF1euj2hR3W35UxGNab9uPXPXw7IYsCrjnIJDD25982i5uw2xpU6zyj0zLspjLIt20syJt
pWflXVpxms1jTb+omzFtTAu0OPzeRJ+H2ZZ+uk/L9iOB0kfZtKhmwSII31oVd/icbzdyzkNA
uU+VrzaeL3T770LG5m9H69jV94v53pgShIzNpZnuT1jB6lvK7Sc4Fjp8lqjT0PHqgMPbHHL+
JwZE2ppx1ot0geGNN4be7Ss9+U26Kga/Zvn57fXx+OumOT6fHq1ZR1DZEE2bGfc5xRSidr3N
ljRjTWAFThBGeNrkat6wGCIYEC1Jo8I8u5y/fDtZqZN3sMo9+2cfE3OP00iQHZqajqJdpbty
pyeuE9qWAERu/o+xZ1ty3Mb1V/rpnN2HrbIky1bvqTzQuthM6zaiZMt5cXVmOklXOjOpzMzW
5u8PQOrCC+iZl5k2AFK8gCAIgkAD42CCUt7BSen2LpfP06zpDsIh8jz0lnqBvDvKOr82dj40
o3TG8szzccjsrwqBRh/yMgHVu/zIUkvb6TOb2bvAvGSR6zKhbSKKFy2Fh1ujZOjqkoKdGc0X
TYcJAOWav70bePdkVVU3k8I8s07x1/MfLw8/f/3lF9BKskUNmYoUcJyqMgwfuVYDMOknedVB
en9n1VcqwkSnC3QeSo0K0wLv4suyg83RQaRNe4XqmIPgFYzCoeRmEQFKOlkXIsi6EKHXtfbk
gJpPzo/1DbYAzqhk5/MXm1YYlWZ5AQIgz276e9gC7QXpcLC+D0ctI3cXwDAFQcmPJ7MLOHnu
ARAQPS9l63sVZMOd2t/mXKfEqRmHUy5EunttFVqDAhAY4qLBowZAa8tdVKv2ClLQNALo0IkP
9KpZR6sziAJlHeaAVmQkO4jei4QhJrPpFNJyas5HbYRkxjk7MquZDegEMg+whyOCzIo/gNXK
1NBWRVO+aDpswoq3HPBWhM4ner0dP1Oe7jhM+605HWWebGI9ziROEetgCTWYn153SUEWnDPg
6F9TwFsFZfKaD7RI1uiuoueg6nyDjNZ/V7wvlCJ23zkjaXzUX5WEtkHewQS0Z54jcyFHjmRb
RLVenwLea/9EwdKUzGmMFNyUAPD7FlkLTcLMILrI79zDGXXegBTkZgeermZwbABFsOV511nT
ZE1D2TAR2Se70ByyHhQZ2LHM2eieHIFDXXsoPq3s3WmCwX7HKjyZGGGeDGQ6gC5NpfbAsbMf
/EuYSIeC0g4ACQqo0Qx+AA1j7LexNSnTg117BeXA0rA7UwajQl0DhJY8mWDSQfdosd2MM95C
S46wHW4QKJUe+u2X7PXe9sGZNEVSeZA7y+H5/e9vr7/+9uXhfx7KNJt96B2rJuBuackExj8/
cz1UF2LcXIzLCvWUWvFPfRbGhrVcK6tLN2LAV0r1dIyoYnpKebew+9xuxckg9ndLyzctlzLP
qN7ZQTFWjGAnpscXWjH283qtMVmbJDtfSxFJJuDWhsl5zrfi5KPhDdkiiXokMW0Sx2Rb7QAX
WkPnB98OxgxKotV1jsPNvmwp3CHbBXpQF+07XTqmda3bMr7B7nMdoITgGVfjV7TR6sMOp7OG
XGrOxcBcg2iGWg82af2QxoDOBLVpZQKyiuX1EcWigzpdsrw1QSJ/56w7hHfsUoFOYgIXw19T
FGgdN7E/GrnfZohyx51CZ63ewoBthEA7PuXfr/pFddd5dqLh0OoC0iATP0Sh+an55VRTZrBY
yYDC+MmuSW+FVekZg+sIaS9NzXsLE8vrnrqzkMPWlzJzLzBEo1KRGXX4zZNzYTWEsPnxzIlm
qDdGZRN02OEmjoehsKayx8TKmcMMA9rUOoJH8BbMBSOPwLZsbPo6zlcC5t1FwWbqlqnaYbsJ
bgPrrE80bRndjJOWDsUKrYkcXWqWPu6Bq7M8dSbF//hEMqfVSpYFSfJoV8JK9GfzTi3MZ7wl
01ZJrOCn1v5Mz/nYUjB5mrSWOxuSxEgRM8FCAmalIEDohYwEjZif+ijSlW4EHnrLg2cBygu5
1HOnJ3mRbYLNzuLPijuD3IzXY15Ps2iKEonxVS+2oe4XNcF2uga2wkBxvtwy4azStB8Ln+DI
WFcye1SPMuC0CSvZ1SVUpbdE6a3dCFXeE6UZF0tTk+GVEWWeVhGUp6cmImNk1hgxLuPHxmyU
gpkBI1d49qO3XXNBT5R7rQoyEjG2tRqCzZM1ixPQXesTwprgvBaBEWltBQbO2IjgkY79PSF3
Fv8r2PL4xKisqKyoAfqerHhNmX4/ffzfL+gD8+vLF/RPeP7wARTy17cv/3r9+PDL619/oNFH
Oclgscn8syrgc32WHIDNPdibL0MW8B1mko4EyUgmjtDQ1seemu4YhLpzrmTcpnTYrxx3292W
tLqo3TwXcIyKzIpmKD3QFR8Z+bATkXUVxpaUadPxZG12HW97ntnaUJVHoQN63BGg2KIT+c4R
i6KpeXrmh9wTABw1PXWU9u30nCV20PoVrPYCb9XyzNoIypCu9skwtPpwrQoljCWXnrJ/sa8f
Xj/ZfMfMQgBY4vWCpuGoToiXPORdGIxSWBHc5QpAV4m60iHP6ZTTM1mLEYKli4cvUvlEKKR6
AJtDFJfbwJ/xYyJX1F3Oyj6nA4yblOoS584QKDLBjxUzHIFM/NmV7isSzyXf0RSv2dgiE8l2
46g6Gr6p85F5WVcjZJvAVk9MrL3mbCy1T2s08q3Ld3Rc8GgTU8+sLDZ2GzOlOZZ5l1UE9R82
6zFvWShuH7rcrQw6MzEk1euqhXG11WzJ8IaXxwzNx97zmRaZE7Qx6PZP+RqlfhHpt/pUWp9R
8ExGzZvWnYOVR9cL73IZpNaelYGMri33RiiCxcw6Z6irsmfOUbUZi4uztwk83d/7ZGNcp0ll
NT80jma5NAQDWvgckA3CnomUUXZIg6pq+oH6VsFSypKkdg2LAzF6vDzBHAbhYmbZe8cegGTz
md7FzA571EfdGZbwzC9nJL7CI5dfMGs0ZpYekqrL64ZTrzmsqnQHVQu1+y/ZDUBeU1A1THui
eTpSFUwL4nt6hCNdeVy9jG61pWraNylbv/rA+kqlF/AMzyGtdpE0KYvb5cRFXzp2gxyWUC2v
foHIi1M8pfy5P6UPUt5JBbX46+Xl8/vnt5eHtB3WSAXKGXglnQJ6EEX+bbwun7pdCBgc4blW
1IkE8x3WlmoG2BZHlzVkaWFbLmZEm/GCRuXwSRpT8bTgtr1jwo3p2ba2TJih5yWxKhHVtZU4
uihejbJXw6ibM+9OiyHHQ8ybuQuDjTvjqnpH4ZrAsii/z9ozWTP4xPJM1TJ030X/h8G2Kk0U
chbgg/ew3sItcDusbN4oP68as58wx/4jqdXGpnyXpT/dvZZLYnZeQo2oUBsAeKie3//2+vHF
if/xn+fXN/ViB85y7z99/OX1169/PVtxeZz6pVyCJu/DwNHCKELgvu9ptqIGBWHI3AM+QYlz
6fVE9JSp2PiYRPHeZ6PwFtlH39GiWtq2yNxidIGuD/dbgkkcqmT3HZ8HOjJAspc83iX2WdEl
E6Laxru9vqD9jOW2seqfboc+PQv60dtMJpqC5HFfhBMAReEDbi/PUrLogbNmsfP9pewhGHnJ
63ESQk5bJ6zkU/ToqWQa9TsDPxXwiO6xL9oj80i8EA9o8He7HH7licEN+jGXuFSYpM6+Y5n1
tNnS7KhNbPCJe8QF0Z5glBljB7g28Huv3WklGQNP5fvdHYyVNFjD7jcbT3P3QZD4MXDa9/VD
omm3moXsaatqdyt42kZ0JvWVYBtTDXvaxjEhIAC+CyIavqW6/hRHyY6Ex+R3yzTehaTIY5dk
7zVLIsEhC023jAXRoymD0P+n3DbkLYgkQMsH+bLSpCC+qRCOFXtF3ZsVRUEM22yKcY6GGtJf
imRbhYxvMhEbsQonvL+gp9ZtWG5D4hyuYT2ImOyCRNz5mGN8XBDkOAJiT04bIBIPIiIWBMJ3
5Ohsw71zsbRg7lvTZrJxdJY+RRcFkc9SPVNsHSv/gqHeAK8EcVRGG6J7Y7gxYp3PCKmcEeO3
KG02vLKNSwjNxT6gRhvgIcXhuUiigJhnhIc+OCF+FNy3rRz7and3U3EMwXInlaMcOXcQSuOp
m1v3FG0iOvr6osugKrhJ7km/RcF0WyBR8YYYT4nRY/AYiMdwTzVaVUcnXjcaQy2wGUOvZIV9
JBhuwpDaqOrF3faIKnkMdrdLmk1mZ7IejWoK4nqnTjj+Bzv7cnVG7BOC1ycE3XWJfCRW1ITw
MSWik53jROpSRUYscgvhbRMsq4RgqRnjLYf5WOhycRASVqkJ4eslrBFYmHc62JW7MCImA+DR
lloUnhPQfORxwPEuIJkPMZ6Q5zrJ9h57IkFMMIzvoKTg9Nh3/WNgX7PLc86xL2PDg33B4AUL
qbnPGIxQXTGSQGaaYvDvHHCaplCGGRs3HUvcM1mXbqcEd/fPbqIK6UwgOkVMad6I2FHK+oSg
B3c9ktqInkXUdojwmFQDRM9vgvnunJCiZyKMKbVGInYexH5HKp0SRXo/GhQJwR+AmJJhUbXG
ezqFsk5B8SMikk1MmOUBA2cJYm32oERsactPX7DHZH9PlZEUj8R9NKDKcxRuWJbiU4d7VSg6
nlKHDA3pE2ILSeQLy+VShuP2G6J9pSX4T0PSHL30fQy21CyJiIXhPie7I5SOer8nSBT7PS2Q
ZshYEEX3aS5VEvuSZmskZFghg4DgK4RTjA9wwxFXh1PaI8KpPUjB6fGXOEKgIJzSdBEee9oa
k+dmxOzvq5dIktw75gJBQumPCu7t2eOGWCgSTsooxNzdJ5GAUmIknJCHCKc2eQmnJ/AxIQ5z
qGDuqQ1aJq8hj1bezDcawY7qC5pyrbcuOiq+O0A15fe4IEKCnxSCGDuFoKRwy3Zw4GREmbLF
twwVS7tmuvKjuqGoLoIpyrucqWjPBClJ2I2K0Ne0fsWv8XIMs6ZRTuku6FdN2ihXtIkYzc1S
xi8p21zZbX19uNb9CZ33CM+mrieLafffyjmJZ+7DFACujYMft4O0GV9B/+jy+tifjJbyrGN0
EvPhRL6BxRpXFxFlM//z5T1G0MICjrEY6dm2z/XHeBKWpoN8YG6DO3NAFuCtKDzNkS9SrGoQ
xDsLKAbhVD2gh4in4kNePukXbwqGQQyKwoLy4yGvHTBGIOqu9jfTE4df1MM8iW06wXjnFGqG
I6Ms/4gEFmdleTU/3nZNxp/yq7DaJD2FLBgMQs8xV+RhE283zrev0muCZBPEAw8dm7rjgn4X
iSR5JfwTmJfMGmVM5NJUNqyxAD9B70zQMa8OvLMWwLHorKqOZdPxZrBG5tSgH5vReQmxGm70
69g0RxAJJ1ZVHt86pDrzMysz6pJe1tHvksiZcOibXB/eSp+u/uEeUoyWQJ+lEH9hJbCxpz1n
nl+k16Y5POcuDe1Gjpw1lbdf126OW2UU4inL/E3nPeUThJgf2aFjdmX9hdcn8n27GsRacBB6
biPKVPqzecoZr0UUoG7OjQ3rxVPe2yIMR96VdzMUf7SGI9+CIdcHYruhOpR5y7JQSRij6BE0
KH/RyynPS2EVUyID+KOCNeAb7QpYpGusdVmxa1EyYfWtyo/s0nRl5gjALleywfk6x6uYpqDc
IyS+QXcFe3VXQ9lzYtOo8R65zrTpmSFEx+ue9ttSuM7j34TYprPcXHVhy2oMHQJyxYjMoYH9
4q/Na5gI3d1RQXtWXuvRgsLWUaYZCVTRLAg4+TpcJ8CXf75eLzR5RtkuJAnIb+QVnloSFaO5
id4KXqcBHX5px86SOh37Kbf28bbjoJ/bjAYNyCwtoGvSlFnDCnurEvIGrBJDfbRHR+QV98+4
NJVJPrYqg63d0Ojg970dRLR5joFKvN/pc2ZtXwCCRQ0qWG6NN/SiLe1trTMfakrJjDF9mPA4
DMuaKtb1PzZXrM5LBCoDpaZKVNOK3BaiAOysKepPIJ4ru339qRtEr174+fc4VF1vraCjokqK
sADm8TXxwpSKYW6MnFdN79+dRg5r1VMhfmsa/qXMDLvHAT9dMzyi0C5lihFr0XS300D5FUst
tmytSa/SNgynUMyzkwqhpkv9Hf2VyaME5g9TxwlLIlAHg4l4fvs6fdSue4mFaH5wqR+9UJTK
31piWotK6FYovYS4OHmrlY5GQHCzTjWWo5FdhfJdq7IHUSiEcOtG71RAe2smiy9u8/rHtJFs
TikcIXnfg3KpIvis86uldTOBywlcg4HYxvc1RxM6lC03PalV+bq2npwjmHWotjBxO+kbD2B0
xpCJIVNKFZRV1DXscGmuHhzKJ9jLKbZ6/fz+5e3t+ePLp6+fJcMQSQGxkunVwQ1jCHFBqQ5I
VcAXeM17uSUYElLW4c3kJ0e9p3f/CSePVEPal9zjCjjTZVygcwU+TFBOl9bSNQrgxiqn6Jhj
uvuDJ12fHMY1rB+MBuyjP4Q6Wk3+uqY/ff7ykK5hhzP7bC7nfLcfNxtnam8jMqCCGq2V8Oxw
TBnt2r7QYHCPLq9z+spjJXMiZSAqX79uQ7um6XE8b31PYPseWWyOvGpjC1HS39GbYc7mOITB
5tQikacbXLRBsBupwSqAGdDF2F+4ITvaEM3SVy8+B3IKiTIJgjtgaKi1sLsEQ1o/7t1CSH5I
K2Z3COEyrxm+unOcJ5HpVDCVh/Tt+fNn1xokmTi1uiPjCehKHgIvmTMXfZU6n6xhs/73g+xn
38BRI3/48PInRrZ+QM/7VPCHn79+eTiUTyh1biJ7+OP579kn+fnt86eHn18ePr68fHj58H9Q
6YtR0+nl7U/pR/4H5jF9/fjLp7kkdpT/8YyhP7UIuPpKzNLEDIkPUN76kvrKhZjVwiPWEXNq
BAGOCBBBWsm5y3TdegUratmvdk6Id3z7+vJQPv8tH9wqKS0nt2IwGB9ejNRtcgp5c2vq8uoV
CdklpfW0CUndRcgenTioG3rYOx06N96obUFWgnqZZJA4j93mBb3XLfUa0F0qCwKaAsKpzHUR
jPs6vQpQfWeWNFIw3IZFo1s0NRzZ4AnnhkjSkIx3Ke5JnhGZqbqnyMhzpOFsa6je4pPlb6bh
Lic4RJ1y5t8xJ0J0wFFxw/I7W+D8xRbk6kg3Rlkrb1VCovOqzY+ethZ9xmEYKQVfozqDIO3I
unnL3nmq5vRBRm9YdnQ6fo/u1vu0rbk3SRDqr0pNVGzmPtR5TEYau183by/0CAwDCUc7dMvq
W5uxe3hPi55K8Y2+PjUHDisg7cnaq7SHw6BnLGQAMxrTiL3hymDhkq0t4hfsOHzPVNbsXJG2
S42mLcPITB2nIZue75KYTh+okb1L2UDf2utEAyvxBPEtOtGmbTJSPjg6ESt8kghRt5bBSZE2
OhkSLe/gkM87kAnCp0bOtNfq0JSeb35rqcjAnmZMJ12EXbyc2bSeGEU6TVVzI9u4VT5tfLWP
ePK/Vd+QhRc4tR6amt4whBiM5Fn6hPf0ghjabJ8Um31EFxtp2TcH+lz2PvNcR26CecV3VhsA
FFr7D8uGfnBk/Vnk1qG2zI9Nj0Z9C+zq5fMWkV73KZlXVRHJYNB2WZ75rOZS48cdxLzPkl3A
+8gpvcWKkdBbVXAZMQtzWhzdRcPhwHc4H2lTneyf72zRY5RAOGsfOtab2Q1kP5oL6zruyScg
y/tevKmTEyYvkWeBgo+YRMF7PELLs/lqHeFXKEL5XsnKf5JjOVq8gac++D+Mg9GxPZwEnOrh
jyje+CZ0JtnuTG8UOYi8fsKIQzJNqde2AFPUCHXpuLB5+9vfn1/fP78pdZnm8/akzXrdtOr4
m+Z6FHIEoe3ldjbsMj07nRtE6i1egErrPFxn28idI2q0MayBd5pujsyRgb5B80F/bXPKUQ2L
oSY8ZeGxxxpRYjLJoQ2AqKHScw3KTNtTTLT12FGlzkxpybtV/u5vWkCwljURtgYUmbdh+GRJ
1/9kS3hRQRkTmB72Vi7iSgYvAcKqosZN4oeDEQwXYYM4pXY9A7SQ72AoycS31RKWZWIdvVnv
TnqwMQSdxDtnbBtx4gdm2/QMmoqMAljllYBNTdtKZ4i5R1QvcK7+W3x5ff87Fdt7KTTUUmMA
gT1Urs1Br8U/3W6tcsbIVBALyY/ydqe+RYmVJXzCd/EjdWxd8dQMoAF0ihA0QaT9TwaF1b+y
Qm/yxpW6311J5M1o2pQ6X0r0oUPpW+Nmd7qg/KqPa04ioKBGXhYsqyj2ZMhc8XQGzBm/21LD
I7HoLKf71Epgm7LHWFfSdehslza/gsA7bWijxy0V62bBxqFTZdnGG9IpeMKaQVzXJupBX3Uo
3XBE7iLvZ1TEW3Qm7weXLRBrJ20yKr9Qhg+J6vIjZhNz+SQLk4099GUfxY/2LFVpEO0TG9qn
bBfrUWcVtEzjx2C0R0aGIH60iZGj4v86na3yugiDQ0U7s0gSLqKgKKPgcXTEw8ri0pL389vr
x9//EfxTbn/d8SDxUObrR8xyRdyQPfxjvaX8p7NIDqg2eMe6KsfONDVIMGbp8fel5uk+OXgZ
o+cwToNz07MsOfXExayyb8Uu2MTu4BRvz59/+3/Knq07cZzJv8KZp+87Z2fHFzDwsA/GNuDB
xo5lCOkXn0zCdLObQDYhu9P767dK8kUll8l8L92hqiTrUiqVpLqMHkEhKC/vTz8MeSBJmjHq
qTUNo1HR0455+X76/r1foH7mMKVf8/rRxMA12l9j4Ygj1hmn4xCyNrfRYEWtPcTwNDSkQc4l
HCMkflDG+7h8GOgTu/wbZPOkRY+QchRPb1eMl/Exuqqh7Nh0e7z+eXq5YjI2GUdj9A8c8esj
RlLs82g7tnAaELERZm+g0z5MA3/gIHS5D9z6NRmcfflcfUZlaKZq8nQ7yHWkDrZnZauQi9Pr
28txaGPDy0Uh4kWcxCV/VR3Dv1tQe7bcmSoKfVD+ygzfD0VQ7LRdXaK6y/u2PoQzNRVlQD26
EQCCdezN7Fkf0ygHGmgdgIL2wAObGNe/vF+frF+6xiAJoMtszU8a4ofjMyN2uzdySCoZUUJ9
TcolbcVjCdDyl/jRpdFUCccw0wzYCJ+tw6tdHFVmIG3agWLPnwvQcABbyvBFU242y9MZm0Op
ofAXi8m3SH926TBR9m1utlthDrcrDQUmMehXqeBVAGt2VzzweCruNYw35ZSvhsBUYxo47Mze
nD5caajZfCDXAqFx+DzBhGbOJTpvKAoxCUgUkAYRi8R2LKbZCuEwRQ4An3DdyYOl6TzE01je
3yBy2VskQuIxTCMRM5cd7rFdzngdryFZ3LkOdwBra/eT1Bf9r6I+AGoZO8tFMCmhRTdqFaD3
z/WsCA1imWJYgj68APYf+NgBes+51+tF9dTODTxKXYu6qrcl9oDhvHB0Auqa32FmM+v2XIsQ
FuSsJ1pEHhuiRRdd/bg6SI9aV18k9daxS14tKBxOdEQJ1LjKsR1GoMjBmQdMhQrTVsjMlGdT
Zzz6XnyzF0GaMVwIMoo4XmvwCc1er2MmtycIBd9sUi39NB54jNYop2P+/NqROGOLOz62BP7c
mjDsiXBuuYtyY09Lf8av91k54532dBI2ioxOoDuttXCRes6YmfbF3Zic+trpzieBZffhyCXM
Cm/zs/Sa3D+p9nnVyL/Sco2K1dOsmcv5V9TFv9jBlyX8ZbEZC9vBCIwEZy2i9Fx5KG19q8Tx
/AGHxpvMvcqScBkLcskZpn5t49ZbMYBa7JaahVtdRDxsA0z+R/1u7yWcv4Ova+JwClWl2T6q
Mx7eIruRMVgRNHl42bypigTOXLoFalMQ9T55idHHyRJSHdUzORBkY3/UZPekQ9c+ouwOvYcV
fEohVvKYCBKpOsg6HI+nM6t3kq7hHQDDKPoiiGPzIWld2t7G5bZKINQjrOUywaW6e6tSOIGQ
FJgKu0CrtgbXJaquO1ItEkxDo39dx/CWwxrF0A3ijph6xlkV6FHjEJBLHo+2cXFHESFmPecQ
vh71DQEiKoJM0BdsrBmTfylrFp7BgQZOjuwTERYvdvqZCEHp0qNZJGQ7l5x3336p9xx/VTEw
wk4+adgGZg99XIYGcJvJAgYUO0UjYLXglMTTaMFwsjn0wXovWtKhR8CurhV3bJXoVB2qGp4u
7qrFQ+27uwWWI5cu6H96IyeMck+tMAOZfo2owGY9+Oloyyd134f5QIfkq5ZZrjYWfnq/fFz+
vI7WP9+O77/uR98/jx9XzuZ7DVNZ7OkHalHyVS1dJasieliwgeJBcEQhmSgF6ctTE62ufKSA
jL9F1WbxH441nt0ggyOTTmn1PpnGIrgxYzVVLPyGSBOVCpcHCYl8oIF1l3Ad7LFg/QTQgWc0
I4eO4HUenYI3b2kpUtdI7EEJMFQNDE6cOZaFQ9BrniLIA8f1buM9l8UDk8+sfq8lmOt16AcW
r3i2BKDFpty5qCOwZmxbZFEOyrUQiQfg3lhXCxt46cysPo8gmGEdCe6zjgRPePCUBTsHbhDT
1HUGbAprkmUyMbM/GhOLUizObKfiDowaURwXWcWMayyt3B1rE/RQgXdAe8ash0jzwGNWlB/e
2c6iB94Cpqx8x570p6nGZczoSFQ68DRm0Nget2l0RIm/yAOW2WDp6WnxOmjoDyz3NGVtKzv8
jhsxfGC4c3twMXE89isxJwpNMml3/JXEnDmT/lQBsM+/CKyEz7Rno/5PYs55i5FRt+QTt1T1
+zBj1pjW9PT47rBR+qt4y25c6wIKt74I5D1S4eCkZjpsmfgcreojtmi5YK0hugNgV6SO3zoU
JqzBJ/mNCvHaudTZDMGbhfRw5bKXt0FjQZ8mWlT7NaRf+AXXUqkMLFkWqymUc996t+CKyxPU
cFeBifPw1hGvG35Mqx084LtFFPHnhTRKEn+bHdqJZhotdgUm7eB5oUG6daoY9PZcxUNZIGri
dVbmyVBKyOZrmANrsSvLL+ryV6CurfB1m2n6Yea1zdZc0Gossm91n2p2MfCjWqQZ9R/f+feR
pONH8JAO4vLIvxtE1inR8ZMw6befJ1XIhcGqVvHKXzyU0SDBQwYEWbYZJICRLNYhf7OAuIqz
xzUohqrGRB7pQNUSx69rP9xX4v4GByhLylU6YOWMkV9AJOZGzAuKv90tpCiXtuXCmjayO3ZT
Q1hMbS7op8e/Vi13v8el2N1qV0MiQzXz7LACAZBDg6KyWvoDLsR5Px17i2x6jQtxE/FSBCq4
Z6N8YKbwotSzfUhhJjAubk5kA1pQbHKfc+w1KZIB5qmTBeD7q8gd4JUbVMIv8C/bmvMaYE21
wXSzpTue3qLK0WbO8NvSvI7F2/H4PBIy9v+oPD79OF9eLt9/di+ifb/q+uvo+I+Xa1FQqvQc
KMT0G69/9QNmy1GeCLz+uUebbn/Arb2jLde7bYhJfhPm+VS2ZXd+Ql+45fvxvz+P56efjbVd
39d6t8Uxq5ZFdIcOTWWRGfxH+jhYr1mtjPuzH7JiUDT7RckvhNoLfFtaluVUe9N4jM76Dn2I
Y6pEKVQxYBZdTytGTgDIFqb1ViNFxMu6VAwL9zxQ2a1A3cp33PsuaCFBVuUTy3DjriNc1LKG
bNo15m4g1qLcGGtjUH7d1oaii7Iqlpt4QNg1VGt/IJFTQzC8K0E7gjQfsDdZ3RKjub/1ZUCj
W0TqKnrq3ZBQGSixIFj6lTRTlxxYR+Ka7wZ6XrNNsBu0tdUoGNWs60EcpegvIuLUL6Gz8cBg
3cdbzK9YLVNrKh2vmK7kjm60usakf0Gy6UMww17u6xee6kKdUnew7q2oj8Kgi+PZhMWJeGK4
GBpINrU0pRmP2aqDMIimlsfjBJzIrCrIB76sntiHzpktFWuPWadq2QckN976XuTx1kwgreTr
y+Xpv0bi8vn+dOw/SMGHoj1ILDiJ6mflZLNIwhbaxUDk6tKEkB8ni4y7e1fX5HG21+4DFMzX
E3grUGcRJTuwOp6P76enkUSO8sfvR2niRoJq1O37ipR+pz5lmZ9v7lBlWviyiANim9WnSfxv
A2ZhhBTvzUs4WO1W3JtKTUt951G5VV0ZvE9vnhOUSdXx9XI9vr1fnpiXxwgj1Bi2Uy0M2JlG
YGGqUp94e/34ztRep1vrnlYRIA+/3KOqQpaFpgMq2FaYEO2BoGkaaYImyJr0mn1LiywY/UP8
/LgeX0fZeRT8OL39c/SBZrt/ArOE1HbVfwU9CcCYFE5/M27isjBoiV+8Xx6fny6vQwVZvIpG
cMh/65LO3V3e47uhSr4ilbR/fv7n6frxOVQHh1a2o/+eHoYK9XASGZ3l8kpO16PCLj5PL2hs
2g4uU9XfLyRL3X0+vsCwDY4ri9e5IjD8OGXhw+nldP5rqE4O2wZE+lvM1O6I8tYA9dlmkdY/
R6sLEJ4v+iqqUdUq2zdRYzNQrVN/S56QdbIc9H9M8LVlc6ISSrxdwTy82ru5hkb7cpH7wQAa
pVe8j8xO9Fyjuv4qhburLTqgfttUEP11fbqcm7gfvWoUMZzgg6r2r21736AOuTPj33hqiqXw
QTHgjDpqAtPGuga3+r47nnvDpUHvsMeT6ZSpAVCuO+ENGjsS057RJOlrCQa+3E7IDX8NL8rZ
fOr6TLtEOpkMPCLVFI074Rc0bU4sTp2FTUW3O5W548IlhlDQzQRi/aABP/DJcqk74XawKliw
YLVbsnB14GGx6NCUbdErzPjYZhkvJRUF1/bieMvLtFD9SZSIrkyPVH5V4KJtSRydRDRhrmhJ
AHc1duoFaVzveKs2s6en48vx/fJ6vJL15YeHxNXzL9UAMyWBBKvkXQNXbICf9PA6Vk+DUQNo
IHgJ1A13awClWqS+rRvYwO+x1ftttn+RBrBE+hdZjYTzHb3O0Hf1J0ngoyLUVXwFmBsAPY76
8pAIjDHvLzmY2brNQYRzdlw3h+D3jW3ZvN1iGrjOgJddmvrTcX9CCN7zBsvOxhPWOTFFpzTb
MFKpoSZA46pU1COqXXYHME2cOSJgPPJGJsoNHPocClj4dZqURh2jDK6Y/vwIOtroehk9n76f
ro8v6PEC+4u5BKbW3C4mlN2nzpw7EgLC0zlB/a5i9dBQZ+Ml6Lmeowk3K+uA2xmFzWYUFgQ2
HBxtCgz9uS2vZig02TqULtruoyTLIxAhZRQYvvvrw9Tmsw8po36siul3UgbOeEpmUIJm/OYm
cayVPu6Wrm7disd2z+CNIHfHDu8cG8Y+OsWitaVn0X6n0bb6ZptDufV3U2KlqrZTcxjv4MBd
7VHPME36JEbkaVzF/RISvh+AA1g3742DNTa9KO88a0LT44RSw0mzUHlXMj0vZXXWzNa+JGEC
pMOEwlJQOgwm2y892xiufZzjZS0mK1Bw7Y1IXi0cDFbo1tqtdTWw8tBgvfkbwI+KgKzHG/V/
WVr/6vL9cr7C6eKZ2PjiLllEIvCT6FantML1KfDtBRR6mpQgDcbOhEifjkp98/Ht8Qlaewad
9mvxQ5Q3+D0de+Sy5cvK1Dd/HF9lOAZld0xd18oEWD5f1y8snGCTFNG3rCbRN9TIoxsu/qab
chCIGV3DsX9nvnp0F6qpmFpsnA0RhK7V7C7d8pDQweReEqvCyPBVjvVERxjSvcDg0WKVuzTT
lo7i06bkgiS3xJ+95E0SONwc+EjkxwUGW8aUB9BZTTbtvzUpp5q5NyeVMjS1AhD8Q9P69NzY
okOZUQBn5MtZX288ga54pqL9hOquetQBYhGkMeG45mHGxKkLGJE3X+o3o48kum9pNIHH1byj
Dqe35U274CaWN9YX4MSdEcYAyHjMnQABMZk76BEsIlLBZO4WBODNPPp77tFuhHlWom2fBhHj
MTVITj3HZbMLwx460c3f8DfJ3gM76njq0G0CPjaZTG1zj1Bt6Mzmv5S6ONPPn6+vP+srElPo
1hcY4S5NH1jJ26tAeZdLH2XCUw1I4dvHPvHzfP1x/Dj9Hzrch6H4LU+S5hJPXVTL6+DH6+X9
t/D0cX0//fGJTgB61TfplLPSj8eP468JkB2fR8nl8jb6B3znn6M/23Z8aO3Q6/5XS7bdvd1D
wuLff75fPp4ub0cY2mYttvJ6ZXtEfuNvyn3Lgy8cUDl5GKVN851r6TtWDTAFYb0wVw9FVrn+
IR54vipXrmNZLGMMd07JtePjy/WHJnwa6Pt1VDxej6P0cj5dyVj4y2g81hOT4Q2NRSKc1RBH
XwRsnRpSb4ZqxOfr6fl0/dmfDT91XF1fC9elftRch6j5HwjAsfST5boUjr601W86RetyR3J3
xbDd0gxhAHH4Qe81vX6/hyWPwS1ej48fn+/H1yNoSZ8wFETNWKRxzVrc43ImgnW12GbK6a0r
pMGH901CZfBuJmZTy+pDKN0mPXjaoMTbfRUH6djx9KI6tMfQgANe92pe59lZMX0iUi8UB17c
DQ+lin9x+v7jqjEOfcP2E+4m0A9/DythHLH9cHewLTbvsp+4hKngN2Z1JKXzUMxdiy2NKJJY
zxdT19H5eLG2SdpB/K0rkUEK9DP6IpuiVyr3DAvnGT3aD/z2rAn97dGseqvc8XPL4mpTKOis
ZdFcso1yIRJnbg14DVAihyeSSNvh7jZ+F77t6FcZRV5YE8c4VxcTNms4IJaO7Wl3nckeZnEc
EFMpkF8g4th5q1EkzMA2820+JW6WlzD92pzm0HbHojAR27ZL00gCZMym2C03rktyDZbVbh8L
Z8KA6NItA+GObaILSRAbpKCZoxKmQbnNd4UQxLqnS8xc6xgCplPHKD2eDKRu3omJPXNY/6lg
m4xJHmUFcbVu76M08Sx6GlEwNgPvPvFsqqF+g8mCubFZgUMFivKDevx+Pl7VZRmzR21oGkz5
e6L/tuZzstrV7Wrqr7Ys0JSkAHPtAYuhNA3cicMev2rhKmuUGkXvFNB8zES3hoVpMJmN3UGE
kZm0RhapS1QECqdlHvzUX/vwn5i45IKSHXI1GZ8v19Pby/EvwytZHrxMk9SmNr1MvUM/vZzO
vSnVth0GLwmaYEujX0cf18fzM2j556NmbgjNWBcythL/niGND4tdXg4+TqA1cpJleUMwNLfS
4VevpG4738J6tzyDciYviB7P3z9f4O+3y8cJ9XZuFP4OOVGs3y5X2J9P3cOJfiq0WVdxQDhU
coToKTVwhQ9HtfFAJDw8tQ3tRIgzhFEjpvLE1F8HOsN2FAb4qsfdSvO5bVnWrepUEXVKej9+
oFLD6i+L3PKslPMRWaS5Q++Y8LdxQk7WIBDpA3gOOg8vRtY5e8EUB7ld6/vdUOaJbQ89XQES
RJUm/FIxMa+rJWSoPCD1fM21oJIBhJnTkgosPKRdlpMx26t17lieNlTfch9UKa8HaOVwczI1
Z6tTQM+YnIJdQCaynvfLX6dXPDaoq9oPdV3Z21qaC6t0s8jRMeMQpyr2GdWeBhSgOET7ybiM
qr2mQ6ULGqg+j7daaOdiiReq+gOAKJYkN/WByz18mA9xFqJYj1FEkAzNB+iHRb9LgnegIuDy
Cvo+mbiJdehP2M1hro2/Pi4vGLFw6OJZs+26Sak2h+PrG96J0DXdjHxymFue7qapIPpslCko
4p7xmxhLAMS2ubeiEjYEi+hk8NsJyc7ANK8h35bEKQp+oiEd8x3ExKFmoiIBaP1hlo9y3vsE
cSpaccnaQiAe2TLPdNZEaJllva+gLc9AJTIMH83xkt+n5EcbL627b79PB93KEaeMbQn5sFmH
rOw+oJ9Mcj2aQgOpQxH0oIyNMyJlUFP6oKg0m+Ju9PTj9Nb3hMBAKYVfqSASnaZj0mvCJfeD
TcV75IPkjcrG2SDRlRyFafOjEGgZ43gHJJBSgyhhe5rJyxwlI9cPI/H5x4c0Ges6UUexoFG+
ZVDxVUqB8KMK/K1iAgz/HRV63U3MUYxU2hoZvtUxlvQLwSCtNtnWl8HQ6y90EubrirRZgwbl
B79yZttUxkfn+EWnwS8a/YFZz2mMYwTLR1QVdZ2wCUUNfrAEPBy0LbOsMunCgY1S01lMG4Bu
lrTiaDZnpC1rdTEiaODnQC47xCR5+36SH99xRKUIf1X3iiQSRdOiG2Qtz/lknOBnFQwFVzej
148bA+jqvogHvHwUWerzwRH98/P75fSsnSC3YZHJxOboEWT6wVAs695qVNA4XP7yxwljmP7b
j/+t//if87P665eh6vHjbQyigZdf1XpNr/Q523UZvlKT3vjTDE6pgIUi7IS6IkWbABH6/RCY
6/vR9f3xSWpV/UgkouTs/xUrl1ou4wZiRoBp4QNO1i1+xdaWih1bWz6QCbklYCJDNXfM/f62
d7f5SrvgwgjoIOBznEXD6EiaE6aroqEJ9rmBXBRxqIdKqgmXRRR9i3rY2ughR2YLsl1OdgBZ
n3JHNoDhMulDqmVqtrSGYosHMG2D2pEk6L4ztEnlL3dM1ds4a7IlwOZXbV1yF9WSka1axkyA
ETh0G4x24cCG29+hwclqOnd8Tu7ttDjm/RuMzlq7kbVpleXadIo4O9BfuIf37HZFEqf83i6v
KALlVUfunDFx9kA87TRjE3nkEVFqIgzZlFMfHFOGNsdmauPcvHKC4ir3Gt3+O/CDdVTdY95v
FXWYHBt8PAihB5ZAkzPB3qcgLhMxzEqgMWh0QN2RaocNrFqg2xAMPDeAGFuuQjw5W0GhaBsU
D3mdorvjXFGBcmKESW5xKuIAOcj3gxC0Mycx0iydfMEfLHK3y0rylCEBGA1MpmlpfWW5ycVc
kjX9vV9sSW8VuElCQYAlyBQNtkzLam+bAMcoFeiuz5ibdSnGlb6ZKBgBLWEcCCDYCSIzaneg
gbAPGcxK4j8Y6Npk6emHHn4ZhmspuKDUNQLD8rGzK3mXMoNi516RHsXwjlG3TqlNH8fP5/8v
7UmaIjeavb9fQfhkR4wdwMAMvAgOaqm6W25tlCQauCh6oA2EhyVYPs98v/5lZqmkWrIEjnew
mc5M1V5ZmVW5PO78BVvH2znkw+RoPwhaBVJnEhIFeHMuCFhFGG6vLFLHgFJ5SS3TLJGCY8fq
Y8xBjXmPhxQM1tdVS6Zolt/TSsjCnFhHsAAl2e4WAcY9zt8XEc151DSsSSFhYYMlwrR/WbYL
2Ckzs/IeRGNiLE/s4DoqGgtPOclyjDeGQo8Vte49spGDThEGot5rri3yeQLqqwAG6TQVc1Bj
fIsCvVvtrqg/eq+Nkre/0ozzAaOmIV9Urr/cZoCtAjx8ZVIZoqKztfG3ySPot/V8pSDubJvI
g5N7h/yg4x+sKA9yEWATqmm0J4N4ZESZWGBUmKRgO98T4cIG4SMpnL7qLNdtUrFsZl5zdzUL
SZbWcLiUZoBOOJncnzgaVoWuYS9a4FWx+7tbwGlrjGIPDYc5jUW17PgYPekcizJ+KR5oxkZD
YJRlJWYdr0XcSj2qlpiCVC1oygH3eMKHtjkhvSxVIzQQ5GzAo+VW5Tl6O4QfaF+9Lt6lmVp0
dU7JAs9YcQeQ4wwbsxeXSRQ6DCOqkEUdV/yMFpm5iLNa86KTX+5eHo+ODo9/3/vFREP1gpjY
wWfrytPCff3Mu3/ZRF+5N3WL5OhwN1jH0SE/zQ7RB+r4ag/AiPkyUfsX7jrfIdkPFvw5iDkI
Yg6DmC8TzTx+r5nHZhQ1G2Oauzjf7AerPD54t8qjr04v07rEpdYdBUvd2w/kd3KpQtNCEYv5
Wvd4sNdFjeDeq0z8QejD0FrU+C98Q7x9phG8g5XVNf6J1iLhHn4sAmfhrcr0qJNumwjKefMj
Mgc1XZa5mQRUg2OB2ZI4OCg1rZmHeMDIMmpStqwLmWYZV9oiEgputZkwoOdwOSM0Po0xeWni
F5kWbdr4YOom27qmlSsnLjqi2mbOv4cnGZutvUhxuVsXngrUFegtnaWXUUMW/8wFYf8BaFNr
633B0tmVWfv26u0ZX+W8wOx4bJq142+Q/U9bzHzqnXVaSRCyTkFaBMka6EElXdiSv2wBmYSP
5F4nZ0jGVnTJEiRrIan7lqUMyCCguGOE7preMnTkC4fAh9j6yVBQLwQH7Ol6oipquGgYcxAK
Ufuvy1bGtk9IQ0Fq8Fogh+lciqwK3OMMddSwrt5pRlPm5QXv9DzQRFUVQZ3vVIZ2QO80J5rj
Q1HKp7EeyEiWLUF2yupA3J6BEnaeG/lFr2FgDwvpvrRrYFeniyJyk/COdIGeiDNuy2ntbFxI
plMDdOLkl++bh2u0t/+E/7t+/Ofh08/N/QZ+ba6f7h4+vWz+2kKBd9efMEbZDW6sT9+e/vpF
7bXV9vlh+33ndvN8vSU7BG/PLWJQ77J2kRYYtqUF1V5EqxMrbejO3cMd2uDe/XczeAIMo5I2
uLriFbCIgh8RtoZwZj6efHYhBffMO0GNmoI5gzzpGbr1sSmmLXoME6kGhi+vx08UN9I0Escr
x+9AUz/Z2921dmpPlQvkJcH4sT2VbAs0NtP6YeCNIUX9nzSnePpCQJPitb9BaahgMd0MXApZ
dqid4DwmeN1ucEUeOd5ls4tKfyxhX6rpoRVlDriBmrcBxcigCQT5GNoR3huDj5V7Ug2jgCdG
qXdJ/Pzz6fVxh6LqPT7v3G6/P5Fjj0UMo7+wojZZ4H0fLqx4zyPQJ61XcVotzRcYB+F/AnO4
ZIE+qTRvdUcYSzhoeF7Dgy2JQo1fVZVPvTIfOnQJoMgypGOyBRZuB81WKJcnsR8OVzEU3tkr
fjHf2z/K28xDFG3GA/2m0x9m9ttmCdIK0/CAMKaXQZpbZkD8elW3xW/fvt9d/f739ufOFVHd
PG+ebn96i1laIcoVLFkyLQPBSc7jr8d7xyAOly37XNKTijj2yhRx4q9TADLVi1hy4DpnxreV
Z2L/8HDv2Lq/DPRdxakil7eru6dbOxCc3pf+QgBY1zD7XaZ+I2dZue4TG/EI7zpO9yTCSNJM
iXGEIrNnqWdgOY3RQH/x51fUTFFz+jux+ISsrIhGw7wccDBt4OPhQCxmR6iHm33VocOsKVPG
mtuHm9fb35+eQWR6/g/y/B5NFoL3j9dbZm4TULmaNveHeAkaSWTm6NKImd/8eD7zYY3k5oZ9
KRoWuV/MEsphOKW4WMvI55aZXHuwkmlcxfXiXDXZATJcsFhWZXaBvjLmjHxk+JWJDJxzO79u
3l5v0WT6avO6vYYyaFei7fk/d6+3O5uXl8erO0Jdb143v01szkWK+e+4se6nUDd2YkvE/gJY
MLBanKZnHlRALSBanTFNwCS5fOKc/9cgKEuZzcvt9uUTmqtuX17hHzjMoNf5YzTLopXYZ5Zo
HvmrYMFLDxxpnvi7PE8OfVgKIyQy/OuvRJicsyhjxu79aZN5Yrnz6llaRnsccP/QZ3sAPtxj
hK5l9NkH5iwsyNRqfAqflb6AdcYN5ro63OPElnPYqvwrQY8/XzopyUbbouAKUZKtjF92fr36
eQUH487z9vrt4XqDLtZXt9urv19+85YR0H/eZ5gfgjlos7ebmOHNRsyXg06Cdl6X88YSXd5p
kGr14z2ymBelq7qH2DyzHjs1W7wsmZE9OmBdLPUn/toG2NLv/2Xd2AKY0UBlhQ7D/ni/8/B2
/237vHOjHOu55mNa8S6uOJk8kTOK6tPyGHZ7Kgy3mwnDcXtEeMA/U8wnLtAYuLrwsKtkfrS7
u7d7NJx42qQ+1G0alBYOiZcnjLk+RF83rx4MmR3D4Xb+Gg8Qaq3oQ8SyCLxjOnTErLkdxvWC
0bswG/qgUPbhuYitx6MoCks++n7zCBrp7b2yN8Ysnb/+OPryGzMwo5CLuRLCyxjl1CIdLPgD
8iemW/jir3ctf76Lh1owCdLZ+UjpC6Uu7X5PPDUDJMoaBb8j1dpN8ATcz51IRAjfi7JdXYv9
92gmqjFI9sOjgbKwO2hT42DRcwPHi82BNtro7vM6umDaqKk+1kLUfP5Vl7R09pGyexmvLx9n
KNz3UTglQqZjBgWO5lTNSnKqp/dYL8J0cZa3aGQ6Icu8O3Mou0C7a8GIGiTBhJEgPoSQIKRM
bk6S+Yb2K24xsdVIDvC9gkw05huE0iYXgJYQWFo7luG/YZZeRcs1b/NQX+TqGpYegTBfqW8J
iPEp/iLxXFXzcnfzoFysSCgBLWc8xZVZE64ZzDpUDy9W43x4FDTu+C/MVDtKEB+oVRc5S4tI
Xihrzbk+YrK7b8+b5587z49vr3cPptqL6XsjiRepC1vhR28gPmnZLAU5FhPwGHKVdtQBEbeI
q4tuLskRxbyQM0kyUQSwhWi6tklNW5K4lIkpTUPXctEVbT6z0m2q57oo88ukBK6lZW6nUQ6Y
bOHQMCvOq/N4qaylpJg7FHgnPscrl94YPDV7MpQBywkkuKJshndE8/74e3BKtHCZzryRGDHc
HRTCNYMK6SBIozjtB0h41ChpjCW4W8wmnJCqgS4JdGXgkVI9nOxN0Uw3hVMd2SZ/+IYAqVm9
skfsH9pxCgOTPn4cd3EMcrVZXmwlxgQKX4FyNCeDNm3azgZ9ds4+5MoTb/s9QZbGYnZxxHyq
MKGDmkgiuQ7lRlIUwEv4qt1jKQ7Ww3nHwiT4ymlspHNUSrJZBT4llfn0kFzi5ILobuuUl2oR
O1BQMfGWUjuzG1D0ofHhByw16Jc8nC0FNU/v7lgDOVqukPNLBLu/UVYwh6uHkudfIBlOT5JG
rHzTYyOZe1UBrFkCe/cQdQXM1YPmaSzL7NIMdN5jZvGfTJsDkzuORbe4TI1DwUDYtViIMgA3
pG196NDLbNSYgUTJ8QJlRttb4jySMrpQx4xxwtR1GadwqpyJjghGFJ5McKaZvngKhCbEnW1x
DnArOjy6MJaVacRJWdQUAk5sywWOcIhAq3M0OHEtyhEXJYnsGhAxZ6aBU71Oyyab2RXHdlYX
BFVCwiFPKE8OS7Z/bd6+v6JL/uvdzdvj28vOvXpo3jxvNzsYDvB/jRMVs9SgmXyO+Rvrk10P
UeNtpEKabMdEQ3PQlCxaBPiZVVTKp0mziVhPSiSJsnRR5PiOcmQPCd49hK2t9XTMRBEv80hy
1i71IlPrzxj+U1NmykrLYRd/T7HEIkPTaoPNZpeYU9EsIpWneABzCkReYfbe8Wt0TUVnPpAR
rUUNC11vnrOkLv0ttRANGkaU88TcDeY3HRlOmOZcgyhXoQeq9VoPANejcaBulddZN8/aeqkd
elyiuAQhOI8dDBlyrCMzfxeBElGV1sWnJ6/b5j1azyDo0/Pdw+vfKujF/faFMfohXWBFA2BJ
0QhEww3be4xa1JArwaxNMcMVn8W6qEvye1tkoAxkgy3A1yDFaZuK5uRgHOO6RlNbr4SDsS0z
9MToW5qILOJzSCUXRQSHwNTOMCm8SMCDMpbPShBqOiElkFtJXvAz+K+39zGnKjj89sfK08Mt
Ev1kBr3g8f7p7vv299e7+16tUw9lVwr+7M+rKqO/ShzOBlp/BeZHgwlogHHPnNew8TPPisun
SNaRnFMkDnrUMkw+uPKImpfUXCpeFjeopEjaWPAWgAaZPmrfp6xBUeMP/oFk1hjSdRUtcf3i
cNKnNtb+SsWnt08PBeo9WIgmrfOoifl760UywxTSacW7DkpYkOR2eXK0d7w/cg/4AOYcfe1N
/ykpooSsVgBlNmkpMCoIOrbBLmc5supWLWIy/dUtNviVg6E2dWWRXbhDMy/hvOzmbaE+oDMN
RQGD28/+7EO89ICzPEuL9tyWU8zS1mgEh5lhtFux8cTyob3zP2ayvJ6fJttvbzc3+D6dPry8
Pr9h0FEzkE+0SMkPkiKp+MDBcE4UOOQnuz/2jDVg0AXjt/Y9rP1NNThAhTyDBjI0UyLKHN22
JyrpC+yt7cwTlo6oFaxDsx34myltPA1ndVSAolekDco1kWn1RDizMEUMZwsXKaS3NVQ0M8xT
VztFBaC4+AKoepnOG78FSXpGZovskOqq3Ky6FlqAZDqBHgQ4zu6eG7HRgB2N34mE+dSYprg2
PQMIQTDih6lzpBOGvU790FagTVNsX/95fEbBY6Qy36Hw4i4RZ8B65nHRKKvXwKsbkhb1RyjV
oi3cBN060R/XJNOS2WzowNRB5BDnDeYzsI2lVF2IJ/mY8z0gl9t1YQ8uQSmNeAeyYMCKnoiq
MsVcuYE3xrH+zjF+dkhkmUSNH23G3ZmKeH3u93HN6R3DZWmDPo1WBwmiA+EEWQtwczgbGCbW
I6a0CJtwbunANo5ibU5UEnSnsMlk3NJh+G5bUOurWh0MI9QqxfoH4cg4AOolSK8rCtPDBxmj
rdvLiKB2uGbnNmaiZ8osv60d/VQ3A5Zm0tOIIlErldFbVFlneVctaEm7HQYMqHN1OfckobPc
bzZQw1GOxrMwo8GhBio5Yz+uFvMsWoSXHNdOtyupbNrIE7wDYJWXj+ziLWUQgRRTI4WZBPWg
lEDzpzB9f5SCp3y1a5gw0MPxlifrJRfHi19Pq081zfYjn+2PCLQjslX7/kxVWP++X2FxywBT
gg6Oh1KS2JeCRk1zUcS86JDr4942/Td4s71ilyo4XX+hA0Q75ePTy6cdTAfx9qQkuOXm4cZU
ZSPMNQ7iZGndVFlgDALTipM9G0nXA20z3v3g005bmYnA9F4p500QiRop5jLLTTKqwRwSmfQY
2mdUN+w9m60aVLoadqEjqltiIvkmqlfmilVi54AaunhwZLiYjA0eCam9TGXrUxDnQahPSssf
nmQS1VT2HJ6eO+UFCEL59RtK4syZrJiTEzxGAW3llmAUJsBcZlzZ9krDgVkJ0Qc/VS+iaC08
iju/vjzdPaAFMXTh/u11+wPN5LavV3/88Ydh90ZBgKjIBW6YMTKDXmmyPDNDAY1HKCFktFZF
FDCgITGACLCPQa6HF7ltI87NZ7N+R/X5zT22xpOv1wrT1aARoJehSyDXtRWWQ0GphQ6jIU88
UXkAfOCpT/YOXTBdJtQ99ouLVedUfwdFJMdTJPRorugOvIpSOOqzSHanrWh1afsuI+6pg0Me
NSVeH9WZEAwb7ydcmZv1Qg53aNHAwTZHb0LaVGY0hnEy2Hh8ww6YWyVwelSdqJrWUdoYwS30
1eK/WPi6SDXMwK3pOB4n2YZ3RZ76g6OxIR85KsP8jC4UyJ2sqIVI0KWMnuYmZJ+VksPepwDJ
GsSo2rfrUCzsb6UFoW31Dqo/V2hi4V24kXmGsycqDlgvXIiWIYwxJDESVFIU6eOSYsWzigkv
SDk8ONABuxGxhFEtmjTKBpsE2COssqTYVtwyvAwEaOwzM63OCu+h+AFlGGTgoT2BOHTtHL9j
qqMCpJWUG0HitPYXv91PTy867cUwSRdM3A6OQHGML5rS4HRkFGpcmnunQkHB/QFliBEkNUnR
LMvS4NYegMiGKzS2EH21PXfGgEF267RZOt6bQbIklbhh8H3gI+SRfK/UokRPdmD8lriueqgo
ctKyoIFo8eOQYBwyZApECYp00bjVzdEg2X016q8Y+6IdZNxXxSLp7YPejPpm1dakqrnANzx3
8am+xPY5jGZfXm5sSkdN9JZRGPyBc6Dpg2Z7s24U1d/l1WvzvrQCFpEDE5Gn/GB59WnN362o
J/QXtLvUUMSkkRqLHnaWs3jD/s1TBL3KOVkGiYs+gZ7SNWxdr4dlXZSYZ9LrOV4yWB+MF7p5
WhKUu6TvGYBaqu45CUyiiKp6WfqrSCP01bYzozM4AGEhAOOlUJOuo7SG97ZmmISdPhBseAug
ngm19KxrlNZEcFZ/1Xz8SrPNfoe7cKcOo4S+eoy1KNNE+IvNuvqvLwpgLW45SzSU7DOheMKI
2lODcj7qMMNWmHweNzfXQOeVA7VEGT2148Bzl2lxeTbMy7Bdxk3RL5QmgnOv8g628fwzWhMi
ZkiHIKgqVoDIGjsCtsEh6FE13ABjApBNhAnNZcVScnPnR16TZ2zpKHLAaunKZZzufT5W0bbx
koZvdITB6Lk1rE4SQus5UMece9gwJJ4RznjPRBGs0/5lRSRaqPpx9IUTqkQkswv9qG0Fd0dz
7P6FmXhqa2wF8yse2iWzReADCgl/nsws88heNc5mZMgQGq2B33FxCLHBaOyEocQn1Za07Ffa
7vkRH33LoBDcreyAb+mP2YoBFYxJ0r/fkzEBXoUEovVV0ZQJAZVBMsbUU0WeTt1zqwGjh7jK
8NyqWgzEgUqmewvSFmsVqb2U1uQNcPUwTIzNPRl7mddehqYhSbN9eUUdEO9q4sf/bJ83N5bP
1aot2Adz9ibUUVqqnCcLPQjh09G7H7gyhV+/pqCbMbZh8yjN1CtL6JnH+ZgE/Fh5utmlzFFf
ZzvkFqEfX6fea1ZwZnh3szUc5HCUqB1oBuS0qfGXfoTAB8BI4ktT7RDgq79sc/JGMt9pFRJO
g0gKZZ92svsD8/IZ14g68kyjrq7I9TDUGzR+B5ZI2pwpOikQu0inVqTSUN9eXg3Lp1Gjs+Be
sBcF/z8EtxWV7D0CAA==

--yjPt96/CA0uljPd2--
