Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680F265F554
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjAEUlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjAEUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:40:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867C1AA32
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672951250; x=1704487250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ltyfXASc82uc8vTyt/acxGyvJzHm1vyr7TbBl+51wy4=;
  b=nAG+EhX4e2DcpMFp57OLBOxsvVzRbd9oRtRun8yYNqpbIZMbIMt6hiVC
   zeK3LwMxMK8L3AF2Df7pMlVL4OFfkNtussDKoaqHdOphsHsQ86KD9poc4
   3cL0VXFAtWBUDjYGn99YytP4H71EUkBEUSxju6a62CoeYaaoJdYeH1EiJ
   QT5588sHsoXoc3wmPwD4t8LvHPrAU8ouNQnm/o8BJsB3b4ieQQgx35/27
   bpbBQ49bInrveTQSrACZS+/6+rUingTvfHgpSmw5paJJFS9ncoARJUZcg
   xdDB9ATbeO6TrE6PQ4QYb6ogmY46DzOLY9wZ3iQhp48C7m83N+WHlI2Yr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="349535039"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="349535039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 12:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="686252027"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="686252027"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2023 12:40:44 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDX2Z-0002TE-1X;
        Thu, 05 Jan 2023 20:40:43 +0000
Date:   Fri, 6 Jan 2023 04:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Tomas Henzl <thenzl@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: versioncheck: ./drivers/scsi/mpi3mr/mpi3mr.h: 32 linux/version.h not
 needed.
Message-ID: <202301060422.ncARjD8x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5e9af4b42660b2a8db067db8ff03db8a268d6a95
commit: 824a156633dfdb0e17979a0d0bb2c757d1bb949c scsi: mpi3mr: Base driver code
date:   1 year, 7 months ago
reproduce:
        make versioncheck

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make W=1 --keep-going HOSTCC=gcc-11 CC=gcc-11 -j16 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./arch/csky/include/asm/io.h: 8 linux/version.h not needed.
   ./arch/csky/kernel/process.c: 5 linux/version.h not needed.
   ./arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
   ./arch/s390/include/asm/setup.h: 177: need linux/version.h
   ./drivers/gpu/drm/pl111/pl111_display.c: 14 linux/version.h not needed.
   ./drivers/gpu/drm/pl111/pl111_drv.c: 47 linux/version.h not needed.
   ./drivers/media/platform/s3c-camif/camif-core.c: 26 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h: 16 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c: 31 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c: 14 linux/version.h not needed.
   ./drivers/media/usb/uvc/uvc_driver.c: 19 linux/version.h not needed.
   ./drivers/net/ethernet/mellanox/mlx5/core/main.c: 53 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
>> ./drivers/scsi/mpi3mr/mpi3mr.h: 32 linux/version.h not needed.
   ./drivers/scsi/qedi/qedi_dbg.h: 14 linux/version.h not needed.
   ./drivers/soc/tegra/powergate-bpmp.c: 10 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./drivers/usb/core/hcd.c: 14 linux/version.h not needed.
   ./drivers/usb/gadget/udc/aspeed-vhub/hub.c: 33 linux/version.h not needed.
   ./include/linux/usb/composite.h: 39 linux/version.h not needed.
   ./init/version.c: 17 linux/version.h not needed.
   ./kernel/sys.c: 42 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 161: need linux/version.h
   ./tools/perf/include/bpf/bpf.h: 70: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 49: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 47: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 25 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
