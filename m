Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8D6DB8C6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDHEUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDHEUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:20:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A0D339;
        Fri,  7 Apr 2023 21:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680927632; x=1712463632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DmpCSj8SP1ZVtC2HmfIxZ2NLHp5pIODh4po/Vmc5e54=;
  b=liddjKIUbyX3caRlT3buB7tL/ISdJO5W4mCRM0JyyqhDJUucK3wSqMfm
   BS3DnPE8x2XfVbdlrA/Rvc6i3sACUetIOdh8MzcKrRaFlnAf5ZPgywIvl
   un0kQSEYQzqHvp7vFEy6skKYakVk96FsdhcvjCv0EiTxyFXf8JBRLPqXu
   HQ2UI2gd3p1ENpJWdTvCGgN3Vd0XQrIqd5/6DtrbEjZ6fB+K2GuEOQ4Uw
   O+7MdGHO2eEjuAOF9bBSTENSfUxVlfz+0O6JKws2qH5DWVTF+Bb9ffMuu
   V68XWHE5+cg8dnWhqZD9ZY5NtG06SfBmT8GGEWAT2j50Mi85/fj6CNUYj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="323481967"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="323481967"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 21:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="665095719"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="665095719"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2023 21:20:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl03v-000TIr-2m;
        Sat, 08 Apr 2023 04:20:27 +0000
Date:   Sat, 8 Apr 2023 12:19:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        srinivas.pandruvada@linux.intel.com, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        rjw@rjwysocki.net
Cc:     oe-kbuild-all@lists.linux.dev, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
Message-ID: <202304081211.S3RRROve-lkp@intel.com>
References: <20230408022629.727721-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408022629.727721-1-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4f59630a5ed0a4e7d275bd7e5d253a8f5a425c5a]

url:    https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-intel-pmc-mtl-Put-GNA-IPU-VPU-devices-in-D3/20230408-102651
base:   4f59630a5ed0a4e7d275bd7e5d253a8f5a425c5a
patch link:    https://lore.kernel.org/r/20230408022629.727721-1-david.e.box%40linux.intel.com
patch subject: [PATCH] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230408/202304081211.S3RRROve-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/04453d42ee1b0c97f9fa68644c6234f7b9e2d14a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-E-Box/platform-x86-intel-pmc-mtl-Put-GNA-IPU-VPU-devices-in-D3/20230408-102651
        git checkout 04453d42ee1b0c97f9fa68644c6234f7b9e2d14a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081211.S3RRROve-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/intel/pmc/mtl.c:52:6: warning: no previous prototype for 'mtl_set_device_d3' [-Wmissing-prototypes]
      52 | void mtl_set_device_d3(unsigned int device)
         |      ^~~~~~~~~~~~~~~~~


vim +/mtl_set_device_d3 +52 drivers/platform/x86/intel/pmc/mtl.c

    48	
    49	#define MTL_GNA_PCI_DEV	0x7e4c
    50	#define MTL_IPU_PCI_DEV	0x7d19
    51	#define MTL_VPU_PCI_DEV	0x7d1d
  > 52	void mtl_set_device_d3(unsigned int device)
    53	{
    54		struct pci_dev *pcidev;
    55	
    56		pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
    57		if (pcidev) {
    58			if (!device_trylock(&pcidev->dev)) {
    59				pci_dev_put(pcidev);
    60				return;
    61			}
    62			if (!pcidev->dev.driver) {
    63				dev_info(&pcidev->dev, "Setting to D3hot\n");
    64				pci_set_power_state(pcidev, PCI_D3hot);
    65			}
    66			device_unlock(&pcidev->dev);
    67			pci_dev_put(pcidev);
    68		}
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
