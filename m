Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7366777E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjALOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjALOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:43:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694763192;
        Thu, 12 Jan 2023 06:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673533955; x=1705069955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ib3vyisFDI6K4betGWmHI2M4r3YZdqPwbAKOST8VhdY=;
  b=G2uGCVNmmQ+D4sR3M84UvgEn6CiT6XDhV1BOn0rrAPteRguX95ncAXhM
   WebUIzG85+NwBXY6Tt1RmdY8YKeR/dAtAr5V7CeYqAq1ZAe9EBy3Pr0k3
   c+56dM++sxUxZJ7QcnUEx35QHIoiMq87QpbmZ01su8dVU0BaTOYcH7s9X
   SZ7wH8WQZxsxsy8cc98Vd8wEnWKwdBF0Vs/OOf4jCVKM7yZnvqG8Gp2W+
   ju503yEVZw78NciCwgOJxQgtfW3LNZwK5HDqCBU2SBYoEdBWL4UnNvolg
   KTZPTKRZBjt6Jip63Pbv7uPrufD+33WI9phDVVp8z6wD9e/NtVSR+6Mij
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388188525"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388188525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="765632315"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="765632315"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2023 06:15:16 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFyMN-000AAE-1j;
        Thu, 12 Jan 2023 14:15:15 +0000
Date:   Thu, 12 Jan 2023 22:14:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@amd.com>,
        Martin =?utf-8?B?VMWvbWE=?= <martin.tuma@digiteqautomotive.com>
Subject: Re: [RESEND PATCH v4 1/1] Added Digiteq Automotive MGB4 driver
Message-ID: <202301122241.aanYtERe-lkp@intel.com>
References: <20230112130458.2836-2-tumic@gpxsee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112130458.2836-2-tumic@gpxsee.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.2-rc3 next-20230112]
[cannot apply to sailus-media-tree/streams]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/tumic-gpxsee-org/Added-Digiteq-Automotive-MGB4-driver/20230112-191715
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230112130458.2836-2-tumic%40gpxsee.org
patch subject: [RESEND PATCH v4 1/1] Added Digiteq Automotive MGB4 driver
reproduce:
        make versioncheck

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make W=1 --keep-going HOSTCC=gcc-11 CC=gcc-11 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>> ./drivers/media/pci/mgb4/mgb4_core.c: 21 linux/version.h not needed.
>> ./drivers/media/pci/mgb4/mgb4_i2c.c: 11 linux/version.h not needed.
>> ./drivers/media/pci/mgb4/mgb4_trigger.c: 13 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
   ./drivers/scsi/mpi3mr/mpi3mr.h: 32 linux/version.h not needed.
   ./drivers/scsi/qedi/qedi_dbg.h: 14 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra-cbb.c: 19 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra194-cbb.c: 26 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra234-cbb.c: 27 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./init/version-timestamp.c: 5 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 289: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 60: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 47: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
