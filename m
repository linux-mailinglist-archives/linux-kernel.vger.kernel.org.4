Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54B690254
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBIInj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:43:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1F2C666
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675932214; x=1707468214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3BT9ZLSf5+bsMF3a2FQRrZurcNe5Z1yC+Iur6k3YcMU=;
  b=WoUlcG0Vc5D3MNvZezihs8lQDvZkCrVSfpwlIkgjNymqwN9wW+YhPDCz
   /37h8C4n2md2dWpPcuCgWapdPpVzH7yTxG0SoqVkuEo88ZatWAQfJLmit
   UScu0MkpChHDmnPzT1LWV3dl6yla7nvmvFex5iCvbtxlVRfuEVXDTxkJc
   GfwVWaFLSxw3st7QabFqnHJaRVuZqUC/7LVEcNB6mIGEx+aM98zoFG9+2
   5pOyxa+J+EXUQgGMXRBPJwi9odkigjgju84Ja+3PWTQhKNxdoTRsqwILw
   HEV/l5kBa3RSEQxPDB59bf40rosWvRlgrxlP4z7f1hkap6JSKTOliFWCJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313686643"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="313686643"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 00:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776391387"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="776391387"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2023 00:43:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ2Wi-0004wk-0T;
        Thu, 09 Feb 2023 08:43:32 +0000
Date:   Thu, 9 Feb 2023 16:42:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: kernel/kexec_file.c:320:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202302091600.1oUii7PE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: b7133757da4c4c17d625970f6da3d76af12a8867 crypto: s390 - do not depend on CRYPTO_HW for SIMD implementations
date:   7 months ago
config: s390-randconfig-s053-20230209 (https://download.01.org/0day-ci/archive/20230209/202302091600.1oUii7PE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7133757da4c4c17d625970f6da3d76af12a8867
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7133757da4c4c17d625970f6da3d76af12a8867
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302091600.1oUii7PE-lkp@intel.com

sparse warnings: (new ones prefixed by >>)
>> kernel/kexec_file.c:320:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/kexec_file.c:320:1: sparse: sparse: Using plain integer as NULL pointer

vim +320 kernel/kexec_file.c

a43cac0d9dc207 Dave Young     2015-09-09  319  
a43cac0d9dc207 Dave Young     2015-09-09 @320  SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
a43cac0d9dc207 Dave Young     2015-09-09  321  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
a43cac0d9dc207 Dave Young     2015-09-09  322  		unsigned long, flags)
a43cac0d9dc207 Dave Young     2015-09-09  323  {
a43cac0d9dc207 Dave Young     2015-09-09  324  	int ret = 0, i;
a43cac0d9dc207 Dave Young     2015-09-09  325  	struct kimage **dest_image, *image;
a43cac0d9dc207 Dave Young     2015-09-09  326  
a43cac0d9dc207 Dave Young     2015-09-09  327  	/* We only trust the superuser with rebooting the system. */
a43cac0d9dc207 Dave Young     2015-09-09  328  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
a43cac0d9dc207 Dave Young     2015-09-09  329  		return -EPERM;
a43cac0d9dc207 Dave Young     2015-09-09  330  
a43cac0d9dc207 Dave Young     2015-09-09  331  	/* Make sure we have a legal set of flags */
a43cac0d9dc207 Dave Young     2015-09-09  332  	if (flags != (flags & KEXEC_FILE_FLAGS))
a43cac0d9dc207 Dave Young     2015-09-09  333  		return -EINVAL;
a43cac0d9dc207 Dave Young     2015-09-09  334  
a43cac0d9dc207 Dave Young     2015-09-09  335  	image = NULL;
a43cac0d9dc207 Dave Young     2015-09-09  336  
a43cac0d9dc207 Dave Young     2015-09-09  337  	if (!mutex_trylock(&kexec_mutex))
a43cac0d9dc207 Dave Young     2015-09-09  338  		return -EBUSY;
a43cac0d9dc207 Dave Young     2015-09-09  339  
a43cac0d9dc207 Dave Young     2015-09-09  340  	dest_image = &kexec_image;
9b492cf58077a0 Xunlei Pang    2016-05-23  341  	if (flags & KEXEC_FILE_ON_CRASH) {
a43cac0d9dc207 Dave Young     2015-09-09  342  		dest_image = &kexec_crash_image;
9b492cf58077a0 Xunlei Pang    2016-05-23  343  		if (kexec_crash_image)
9b492cf58077a0 Xunlei Pang    2016-05-23  344  			arch_kexec_unprotect_crashkres();
9b492cf58077a0 Xunlei Pang    2016-05-23  345  	}
a43cac0d9dc207 Dave Young     2015-09-09  346  
a43cac0d9dc207 Dave Young     2015-09-09  347  	if (flags & KEXEC_FILE_UNLOAD)
a43cac0d9dc207 Dave Young     2015-09-09  348  		goto exchange;
a43cac0d9dc207 Dave Young     2015-09-09  349  
a43cac0d9dc207 Dave Young     2015-09-09  350  	/*
a43cac0d9dc207 Dave Young     2015-09-09  351  	 * In case of crash, new kernel gets loaded in reserved region. It is
a43cac0d9dc207 Dave Young     2015-09-09  352  	 * same memory where old crash kernel might be loaded. Free any
a43cac0d9dc207 Dave Young     2015-09-09  353  	 * current crash dump kernel before we corrupt it.
a43cac0d9dc207 Dave Young     2015-09-09  354  	 */
a43cac0d9dc207 Dave Young     2015-09-09  355  	if (flags & KEXEC_FILE_ON_CRASH)
a43cac0d9dc207 Dave Young     2015-09-09  356  		kimage_free(xchg(&kexec_crash_image, NULL));
a43cac0d9dc207 Dave Young     2015-09-09  357  
a43cac0d9dc207 Dave Young     2015-09-09  358  	ret = kimage_file_alloc_init(&image, kernel_fd, initrd_fd, cmdline_ptr,
a43cac0d9dc207 Dave Young     2015-09-09  359  				     cmdline_len, flags);
a43cac0d9dc207 Dave Young     2015-09-09  360  	if (ret)
a43cac0d9dc207 Dave Young     2015-09-09  361  		goto out;
a43cac0d9dc207 Dave Young     2015-09-09  362  
a43cac0d9dc207 Dave Young     2015-09-09  363  	ret = machine_kexec_prepare(image);
a43cac0d9dc207 Dave Young     2015-09-09  364  	if (ret)
a43cac0d9dc207 Dave Young     2015-09-09  365  		goto out;
a43cac0d9dc207 Dave Young     2015-09-09  366  
1229384f5b856d Xunlei Pang    2017-07-12  367  	/*
1229384f5b856d Xunlei Pang    2017-07-12  368  	 * Some architecture(like S390) may touch the crash memory before
1229384f5b856d Xunlei Pang    2017-07-12  369  	 * machine_kexec_prepare(), we must copy vmcoreinfo data after it.
1229384f5b856d Xunlei Pang    2017-07-12  370  	 */
1229384f5b856d Xunlei Pang    2017-07-12  371  	ret = kimage_crash_copy_vmcoreinfo(image);
1229384f5b856d Xunlei Pang    2017-07-12  372  	if (ret)
1229384f5b856d Xunlei Pang    2017-07-12  373  		goto out;
1229384f5b856d Xunlei Pang    2017-07-12  374  
a43cac0d9dc207 Dave Young     2015-09-09  375  	ret = kexec_calculate_store_digests(image);
a43cac0d9dc207 Dave Young     2015-09-09  376  	if (ret)
a43cac0d9dc207 Dave Young     2015-09-09  377  		goto out;
a43cac0d9dc207 Dave Young     2015-09-09  378  
a43cac0d9dc207 Dave Young     2015-09-09  379  	for (i = 0; i < image->nr_segments; i++) {
a43cac0d9dc207 Dave Young     2015-09-09  380  		struct kexec_segment *ksegment;
a43cac0d9dc207 Dave Young     2015-09-09  381  
a43cac0d9dc207 Dave Young     2015-09-09  382  		ksegment = &image->segment[i];
a43cac0d9dc207 Dave Young     2015-09-09  383  		pr_debug("Loading segment %d: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
a43cac0d9dc207 Dave Young     2015-09-09  384  			 i, ksegment->buf, ksegment->bufsz, ksegment->mem,
a43cac0d9dc207 Dave Young     2015-09-09  385  			 ksegment->memsz);
a43cac0d9dc207 Dave Young     2015-09-09  386  
a43cac0d9dc207 Dave Young     2015-09-09  387  		ret = kimage_load_segment(image, &image->segment[i]);
a43cac0d9dc207 Dave Young     2015-09-09  388  		if (ret)
a43cac0d9dc207 Dave Young     2015-09-09  389  			goto out;
a43cac0d9dc207 Dave Young     2015-09-09  390  	}
a43cac0d9dc207 Dave Young     2015-09-09  391  
a43cac0d9dc207 Dave Young     2015-09-09  392  	kimage_terminate(image);
a43cac0d9dc207 Dave Young     2015-09-09  393  
de68e4daea9084 Pavel Tatashin 2019-12-04  394  	ret = machine_kexec_post_load(image);
de68e4daea9084 Pavel Tatashin 2019-12-04  395  	if (ret)
de68e4daea9084 Pavel Tatashin 2019-12-04  396  		goto out;
de68e4daea9084 Pavel Tatashin 2019-12-04  397  
a43cac0d9dc207 Dave Young     2015-09-09  398  	/*
a43cac0d9dc207 Dave Young     2015-09-09  399  	 * Free up any temporary buffers allocated which are not needed
a43cac0d9dc207 Dave Young     2015-09-09  400  	 * after image has been loaded
a43cac0d9dc207 Dave Young     2015-09-09  401  	 */
a43cac0d9dc207 Dave Young     2015-09-09  402  	kimage_file_post_load_cleanup(image);
a43cac0d9dc207 Dave Young     2015-09-09  403  exchange:
a43cac0d9dc207 Dave Young     2015-09-09  404  	image = xchg(dest_image, image);
a43cac0d9dc207 Dave Young     2015-09-09  405  out:
9b492cf58077a0 Xunlei Pang    2016-05-23  406  	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
9b492cf58077a0 Xunlei Pang    2016-05-23  407  		arch_kexec_protect_crashkres();
9b492cf58077a0 Xunlei Pang    2016-05-23  408  
a43cac0d9dc207 Dave Young     2015-09-09  409  	mutex_unlock(&kexec_mutex);
a43cac0d9dc207 Dave Young     2015-09-09  410  	kimage_free(image);
a43cac0d9dc207 Dave Young     2015-09-09  411  	return ret;
a43cac0d9dc207 Dave Young     2015-09-09  412  }
a43cac0d9dc207 Dave Young     2015-09-09  413  

:::::: The code at line 320 was first introduced by commit
:::::: a43cac0d9dc2073ff2245a171429ddbe1accece7 kexec: split kexec_file syscall code to kexec_file.c

:::::: TO: Dave Young <dyoung@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
