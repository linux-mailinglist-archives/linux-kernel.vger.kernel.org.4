Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F1C6C242B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCTV7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:59:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C213D5F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679349542; x=1710885542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tmt/tQ5tXzsAkLZkD8VuKuRonbA1TUxiFvDRv3tD0G0=;
  b=DPh1PIeU44oqpN8OjCwshqsAVyTvP8njqUTmtrGBGRo2COL0USENek68
   2QIQJ7se66RG1O27FWsz1cMNuSJUsrPljw2BhQMQH+so8tJYqHlB+qFRt
   aqgnmAEbgzKpzLDfg6xntAA0KrN3/sBC5pXjua4CKylFyIUsohB2Cy5ju
   pw+eB0LctP8yqhSb2T5R5hy82bFpV48YYYtyJ0fT19ov8elEnUvFg5CnO
   /0XtyHnDJioiaYcSJR2SlsFd1pE2s+/4kWBrWlPfTYSjopYOVNbn/xvZ7
   89S0fupuSj1A3HEbLMyyEYJlyJCmfuArF8IRfwmMA8+l0GNAoWyneYhIS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341148165"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="341148165"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="855418135"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="855418135"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2023 14:58:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peNWs-000BLi-0v;
        Mon, 20 Mar 2023 21:58:58 +0000
Date:   Tue, 21 Mar 2023 05:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viktor Prutyanov <viktor@daynix.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com, viktor@daynix.com
Subject: Re: [PATCH] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <202303210515.ZhhE1NmC-lkp@intel.com>
References: <20230320115451.1232171-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320115451.1232171-1-viktor@daynix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20230321/202303210515.ZhhE1NmC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/b6212a12ca1691dc346e5de046ec46bd3ce11247
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viktor-Prutyanov/virtio-add-VIRTIO_F_NOTIFICATION_DATA-feature-support/20230320-195725
        git checkout b6212a12ca1691dc346e5de046ec46bd3ce11247
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/virtio/ net/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210515.ZhhE1NmC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virtio/virtio_pci_common.c:54:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] data @@
   drivers/virtio/virtio_pci_common.c:54:19: sparse:     expected unsigned int [usertype]
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
