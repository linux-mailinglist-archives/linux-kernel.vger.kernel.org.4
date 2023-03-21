Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97D6C263A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCUAMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCUAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:12:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA3B28E47
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679357525; x=1710893525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5a2YmyBZp3fw4mi/x3mK/rGgHuoUUvw3eQd2IAKZa4=;
  b=AbkS4wRHDMCrJaNBbKs5w/dTxfgBVlohAcAXhPEeAtO2qTjWrIfbdZKZ
   7gfD5YRgToqWtKmy7KlJ1xkJzw9d5NwA2tAggyFCAgUPFfTXIJzlx1Dpb
   GpMsEKknT1Ncm6TKFTfSRwusplloaPy1/sALvxooVnTtIuNv9Fb2mqgG8
   METpMUqkuwdXLE89pKcrjfivhyl9eA7IQ52VmM3m8lua/axM4swhD7gtF
   KJ1AQ8LxgNqm2TlzJrjN+3Q/dyUj/S4KGw/g8x4pUGZ0W9uDXYv3mV+2y
   5Wbdg2MpvQT0autG+e1jBfy8A5XfJtmLryArqJqO5ojjXAWj8b8DopV9q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337525198"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="337525198"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="631338457"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="631338457"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2023 17:12:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pePbd-000BQA-1Y;
        Tue, 21 Mar 2023 00:12:01 +0000
Date:   Tue, 21 Mar 2023 08:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viktor Prutyanov <viktor@daynix.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com, viktor@daynix.com
Subject: Re: [PATCH] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <202303210740.w7RIuIzb-lkp@intel.com>
References: <20230320115451.1232171-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320115451.1232171-1-viktor@daynix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: sparc64-randconfig-s031-20230319 (https://download.01.org/0day-ci/archive/20230321/202303210740.w7RIuIzb-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210740.w7RIuIzb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virtio/virtio_pci_common.c:54:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] data @@
   drivers/virtio/virtio_pci_common.c:54:19: sparse:     expected unsigned int [usertype] l
   drivers/virtio/virtio_pci_common.c:54:19: sparse:     got restricted __le32 [usertype] data

vim +54 drivers/virtio/virtio_pci_common.c

    49	
    50	bool vp_notify_with_data(struct virtqueue *vq)
    51	{
    52		__le32 data = vring_fill_notification_data(vq);
    53	
  > 54		iowrite32(data, (void __iomem *)vq->priv);
    55	
    56		return true;
    57	}
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
