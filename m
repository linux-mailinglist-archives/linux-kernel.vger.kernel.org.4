Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F95F9716
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiJJCrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJJCrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9294B495
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 19:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665370030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lr0j2tNLXvd6BNxJ5zoGouLTJ1kTSAr+VuQ9MidGa58=;
        b=FTSEMpzerpP+UJICFzYAGNbuWG/kGnmzQptay62s54KZakpxyuTohPU37VPSfYK+98flva
        M+6AUSlDy0p+48OTKfYfrklrYgopwmoFh8qUGKbsf0kvBnxvJdso2ff7zk3gKPAg+K0zU2
        YBBIcLBQeozIK6qcl3DZ/e3Bo/Nef/I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-uHTLqp89OeSxqTeB27h5vw-1; Sun, 09 Oct 2022 22:47:07 -0400
X-MC-Unique: uHTLqp89OeSxqTeB27h5vw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84B6038012C0;
        Mon, 10 Oct 2022 02:47:06 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62CBF535D42;
        Mon, 10 Oct 2022 02:47:04 +0000 (UTC)
Date:   Mon, 10 Oct 2022 10:47:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v3 11/11] xtensa: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y0OHpY4f67dd+X0a@MiWiFi-R3L-srv>
References: <20221009103114.149036-12-bhe@redhat.com>
 <202210100028.jzgpRoTX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210100028.jzgpRoTX-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 at 12:12am, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on next-20221007]
> [cannot apply to akpm-mm/mm-everything openrisc/for-next deller-parisc/for-next s390/features v6.0]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a6afa4199d3d038fbfdff5511f7523b0e30cb774
> config: xtensa-nommu_kc705_defconfig
> compiler: xtensa-de212-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/1330d435c818ccf34bf24ceb36ef6acb1128cf6c
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
>         git checkout 1330d435c818ccf34bf24ceb36ef6acb1128cf6c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/io.h:13,
>                     from include/linux/irq.h:20,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:11,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:9,
>                     from include/linux/cgroup.h:26,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from arch/xtensa/kernel/asm-offsets.c:24:
>    arch/xtensa/include/asm/io.h: In function 'ioremap_cache':
> >> arch/xtensa/include/asm/io.h:56:55: error: 'XCHAL_KIO_CACHED_VADDR' undeclared (first use in this function); did you mean 'XCHAL_KIO_BYPASS_VADDR'?
>       56 |                 return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
>          |                                                       ^~~~~~~~~~~~~~~~~~~~~~
>          |                                                       XCHAL_KIO_BYPASS_VADDR
>    arch/xtensa/include/asm/io.h:56:55: note: each undeclared identifier is reported only once for each function it appears in
>    make[2]: *** [scripts/Makefile.build:118: arch/xtensa/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1276: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:231: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.

Thanks for reporting.

With the provided nommu config, I reproduced above compiling error and
fix it with below change. I will merge it to the xtensa patch in v4 post.
=====
In <asm/io.h>, the io memory mapping funcions should be wrapped inside
CONFIG_MMU ifdeffery scope. Otherwise it will cause compiling error
when nommu is enabled.
Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>

diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 126af8de5722..3331de4e692d 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -24,6 +24,7 @@
 #define IO_SPACE_LIMIT ~0
 #define PCI_IOBASE		((void __iomem *)XCHAL_KIO_BYPASS_VADDR)
 
+#ifdef CONFIG_MMU
 /*
  * I/O memory mapping functions.
  */
@@ -59,6 +60,7 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
 
 }
 #define ioremap_cache ioremap_cache
+#endif /* CONFIG_MMU */
 
 #include <asm-generic/io.h>
 

