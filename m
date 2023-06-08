Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796C4727EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjFHLkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbjFHLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:40:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DFC3580
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686224404; x=1717760404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MaLf+qHWHMdBUYCI61I1nmeoeH5HH31cXDOI9i4acqU=;
  b=g1P5GIulinH/jnGQQX2jAPRVmpvJU6QEAx5SWdt2mKMj8sTAm1cdbCpj
   rjCr5fjiGZMBOa+q4f4KsMyI/HakAjsqshHVDJyaJgtNmvuT0lsJIs0Do
   tbe/wJu6DOhXFSCNXF7pNvdsCucgmEEZ0K9rQWKp8BJ/igpGFzR39UWTN
   CX7qOuAepZPwIWrhhwMWhJtXzTGZH1g3pc6MoG39pd7FrqL4yGDWAhUZV
   e2+gGt8Lh24RRGssBOWUyU1AN2hYWqQaeJnqXn+hCFhwgr91PVyqwmGWA
   4/eyoBLVjGIuSm4QV+lMFVg6g9ieDELc9USZ3ioz0KtUUrC+JGGAeJqvq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423134341"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423134341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 04:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="822592350"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="822592350"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2023 04:40:02 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7Dzm-0007jE-0S;
        Thu, 08 Jun 2023 11:40:02 +0000
Date:   Thu, 8 Jun 2023 19:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230606 5/7]
 arch/x86/kvm/ioapic.c:214:33: error: array subscript 32 is above array
 bounds of 'union kvm_ioapic_redirect_entry[24]'
Message-ID: <202306081931.EoJfyobB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230606
head:   deff3c1ef49381ffa232906f49f03e8d712755b7
commit: e2af9c6b35f6c39c338b785312947759d0dcdba8 [5/7] Makefile: Enable -Warray-bounds
config: i386-randconfig-i004-20230608 (https://download.01.org/0day-ci/archive/20230608/202306081931.EoJfyobB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=e2af9c6b35f6c39c338b785312947759d0dcdba8
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fam01-next20230606
        git checkout e2af9c6b35f6c39c338b785312947759d0dcdba8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306081931.EoJfyobB-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/ioapic.c: In function 'ioapic_set_irq':
>> arch/x86/kvm/ioapic.c:214:33: error: array subscript 32 is above array bounds of 'union kvm_ioapic_redirect_entry[24]' [-Werror=array-bounds]
     214 |         entry = ioapic->redirtbl[irq];
         |                 ~~~~~~~~~~~~~~~~^~~~~
   In file included from arch/x86/kvm/ioapic.c:46:
   arch/x86/kvm/ioapic.h:80:41: note: while referencing 'redirtbl'
      80 |         union kvm_ioapic_redirect_entry redirtbl[IOAPIC_NUM_PINS];
         |                                         ^~~~~~~~
   cc1: all warnings being treated as errors


vim +214 arch/x86/kvm/ioapic.c

f458d039db7e85 arch/x86/kvm/ioapic.c Suravee Suthikulpanit 2019-11-14  205  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  206  static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  207  		int irq_level, bool line_status)
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  208  {
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  209  	union kvm_ioapic_redirect_entry entry;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  210  	u32 mask = 1 << irq;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  211  	u32 old_irr;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  212  	int edge, ret;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  213  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18 @214  	entry = ioapic->redirtbl[irq];
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  215  	edge = (entry.fields.trig_mode == IOAPIC_EDGE_TRIG);
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  216  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  217  	if (!irq_level) {
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  218  		ioapic->irr &= ~mask;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  219  		ret = 1;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  220  		goto out;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  221  	}
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  222  
f458d039db7e85 arch/x86/kvm/ioapic.c Suravee Suthikulpanit 2019-11-14  223  	/*
8be8f932e3db5f arch/x86/kvm/ioapic.c Paolo Bonzini         2020-05-04  224  	 * AMD SVM AVIC accelerate EOI write iff the interrupt is edge
8be8f932e3db5f arch/x86/kvm/ioapic.c Paolo Bonzini         2020-05-04  225  	 * triggered, in which case the in-kernel IOAPIC will not be able
8be8f932e3db5f arch/x86/kvm/ioapic.c Paolo Bonzini         2020-05-04  226  	 * to receive the EOI.  In this case, we do a lazy update of the
8be8f932e3db5f arch/x86/kvm/ioapic.c Paolo Bonzini         2020-05-04  227  	 * pending EOI when trying to set IOAPIC irq.
f458d039db7e85 arch/x86/kvm/ioapic.c Suravee Suthikulpanit 2019-11-14  228  	 */
8be8f932e3db5f arch/x86/kvm/ioapic.c Paolo Bonzini         2020-05-04  229  	if (edge && kvm_apicv_activated(ioapic->kvm))
f458d039db7e85 arch/x86/kvm/ioapic.c Suravee Suthikulpanit 2019-11-14  230  		ioapic_lazy_update_eoi(ioapic, irq);
f458d039db7e85 arch/x86/kvm/ioapic.c Suravee Suthikulpanit 2019-11-14  231  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  232  	/*
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  233  	 * Return 0 for coalesced interrupts; for edge-triggered interrupts,
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  234  	 * this only happens if a previous edge has not been delivered due
00116795aa87ca arch/x86/kvm/ioapic.c Miaohe Lin            2019-12-11  235  	 * to masking.  For level interrupts, the remote_irr field tells
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  236  	 * us if the interrupt is waiting for an EOI.
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  237  	 *
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  238  	 * RTC is special: it is edge-triggered, but userspace likes to know
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  239  	 * if it has been already ack-ed via EOI because coalesced RTC
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  240  	 * interrupts lead to time drift in Windows guests.  So we track
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  241  	 * EOI manually for the RTC interrupt.
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  242  	 */
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  243  	if (irq == RTC_GSI && line_status &&
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  244  		rtc_irq_check_coalesced(ioapic)) {
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  245  		ret = 0;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  246  		goto out;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  247  	}
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  248  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  249  	old_irr = ioapic->irr;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  250  	ioapic->irr |= mask;
7d2253684dd10e arch/x86/kvm/ioapic.c Nikita Leshenko       2017-11-05  251  	if (edge) {
5bda6eed2e3626 arch/x86/kvm/ioapic.c Wincy Van             2014-12-24  252  		ioapic->irr_delivered &= ~mask;
7d2253684dd10e arch/x86/kvm/ioapic.c Nikita Leshenko       2017-11-05  253  		if (old_irr == ioapic->irr) {
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  254  			ret = 0;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  255  			goto out;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  256  		}
7d2253684dd10e arch/x86/kvm/ioapic.c Nikita Leshenko       2017-11-05  257  	}
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  258  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  259  	ret = ioapic_service(ioapic, irq, line_status);
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  260  
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  261  out:
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  262  	trace_kvm_ioapic_set_irq(entry.bits, irq, ret == 0);
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  263  	return ret;
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  264  }
44847dea79751e virt/kvm/ioapic.c     Paolo Bonzini         2014-03-18  265  

:::::: The code at line 214 was first introduced by commit
:::::: 44847dea79751e95665a439f8c63a65e51da8e1f KVM: ioapic: extract body of kvm_ioapic_set_irq

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
