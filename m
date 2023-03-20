Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFE6C25A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCTXbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTXbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:31:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4E31E1B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679355076; x=1710891076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKwYTZ1GIQpElxUt8onE9LFkf77DgwVeNYSSKwaIXgQ=;
  b=cMsdjI18VTAZoS4xSAzUOoF9Lppk/JQ9ioBIjJUA1ha2dIPdPUT1O0Am
   0M8yDln/2P9mTw0FuK1rLo45Lds6VaWhvsrM+nlo46LRt7jBLJxHayBJY
   /TxWjxH3DkVXUDLrYmbyiUxR5tR50tG3CrEeLwFBt3cduAtXKw12VKswA
   hw/LQEwIwgVGlM3ekNrdYb2hfaJa8fv/ZcP5VKaC9JMpNhxyhFEZUfhaY
   Jl9nECq3kQYDdJizfBhJucx1aEcndDVUKmpLjuU29+jFJyuusyewhrdJ/
   EwhkOFg0VOB/uv+vF1FnPwGuvNardTQBl8fMsritQbqH5kO1RENQYui+Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="327176927"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="327176927"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 16:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="631323235"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="631323235"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2023 16:31:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peOxw-000BPB-34;
        Mon, 20 Mar 2023 23:31:00 +0000
Date:   Tue, 21 Mar 2023 07:30:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viktor Prutyanov <viktor@daynix.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com, viktor@daynix.com
Subject: Re: [PATCH] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <202303210759.kRnNnZb4-lkp@intel.com>
References: <20230320115451.1232171-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320115451.1232171-1-viktor@daynix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viktor,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viktor-Prutyanov/virtio-add-VIRTIO_F_NOTIFICATION_DATA-feature-support/20230320-195725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20230320115451.1232171-1-viktor%40daynix.com
patch subject: [PATCH] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
config: alpha-randconfig-s043-20230319 (https://download.01.org/0day-ci/archive/20230321/202303210759.kRnNnZb4-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/b6212a12ca1691dc346e5de046ec46bd3ce11247
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viktor-Prutyanov/virtio-add-VIRTIO_F_NOTIFICATION_DATA-feature-support/20230320-195725
        git checkout b6212a12ca1691dc346e5de046ec46bd3ce11247
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210759.kRnNnZb4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virtio/virtio_mmio.c:293:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __le32 [usertype] data @@
   drivers/virtio/virtio_mmio.c:293:16: sparse:     expected unsigned int [usertype] b
   drivers/virtio/virtio_mmio.c:293:16: sparse:     got restricted __le32 [usertype] data

vim +293 drivers/virtio/virtio_mmio.c

   287	
   288	static bool vm_notify_with_data(struct virtqueue *vq)
   289	{
   290		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
   291		__le32 data = vring_fill_notification_data(vq);
   292	
 > 293		writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
   294	
   295		return true;
   296	}
   297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
