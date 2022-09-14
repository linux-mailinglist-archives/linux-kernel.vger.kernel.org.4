Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBDE5B8FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiINVNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:13:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636282F97
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663189985; x=1694725985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Isuir53OGXwtIL8Q6XzxcUMn/E06vo4froLngBvPoqs=;
  b=GgX98ZjLnDaLeEZJN4MpWhjPlcSTwXGTSwvVDRZHkTWUJ4HIbyUz4XYH
   BmZNsK9J+y5IDDiHwuWVly23RQRkT14TegLNJbcscHtoySp8mO4G8l+t+
   vTLbbZXdO20FjZLivy5A3ZWmDAgLEK31Fl5SfSvWbpYH7A/m3hOclGPtL
   ol/tqihNebs2rr9piBvsZGw1r4G4XRS7XFAqON3kdSmfdYI2sowsIHl1B
   oiA2SygWz9xTkNtiVpF7g2/nvG4wPPWcf4LkNcl0Xxan4w7SVsGGpGkkr
   QN+iLrIrBDNW4TxiMQjlzzf9+De0X/SeazFVYdKlOEvKBoGkJfsgBUQGl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278930322"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278930322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 14:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="647554239"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2022 14:13:03 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYZgs-0000Zr-0j;
        Wed, 14 Sep 2022 21:13:02 +0000
Date:   Thu, 15 Sep 2022 05:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/bpf-tc-links 1/10] dev.c:undefined reference to
 `dev_sch_uninstall'
Message-ID: <202209150500.kkNzJ85t-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/bpf-tc-links
head:   f9ab02443a6bd720c616b575437a851435c80c49
commit: f182834c964343d39688f653f16bfee1f3ff39c2 [1/10] bpf: Add initial fd-based API to attach tc BPF programs
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220915/202209150500.kkNzJ85t-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/cilium/linux/commit/f182834c964343d39688f653f16bfee1f3ff39c2
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/bpf-tc-links
        git checkout f182834c964343d39688f653f16bfee1f3ff39c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: warning: arch/x86/lib/retpoline.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   ld: net/core/dev.o: in function `unregister_netdevice_many':
>> dev.c:(.text+0x9368): undefined reference to `dev_sch_uninstall'
   ld: net/sched/sch_ingress.o: in function `ingress_destroy':
>> sch_ingress.c:(.text+0x166): undefined reference to `sch_prog_detach_kern'
   ld: net/sched/sch_ingress.o: in function `clsact_destroy':
   sch_ingress.c:(.text+0x1b7): undefined reference to `sch_prog_detach_kern'
>> ld: sch_ingress.c:(.text+0x1c1): undefined reference to `sch_prog_detach_kern'
   ld: net/sched/sch_ingress.o: in function `clsact_init':
>> sch_ingress.c:(.text+0x4ba): undefined reference to `sch_prog_attach_kern'
>> ld: sch_ingress.c:(.text+0x55d): undefined reference to `sch_prog_attach_kern'
   ld: net/sched/sch_ingress.o: in function `ingress_init':
   sch_ingress.c:(.text+0x629): undefined reference to `sch_prog_attach_kern'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
