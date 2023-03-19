Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6538D6C048D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCSTuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSTuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 15:50:10 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6DEB2;
        Sun, 19 Mar 2023 12:50:09 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pdz2d-002G7P-EO; Sun, 19 Mar 2023 20:50:07 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pdz2d-002va9-7C; Sun, 19 Mar 2023 20:50:07 +0100
Message-ID: <27d711b9b3012d42fe9e6f11bc89a35920fe397e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Sun, 19 Mar 2023 20:50:06 +0100
In-Reply-To: <20230306040037.20350-6-rdunlap@infradead.org>
References: <20230306040037.20350-1-rdunlap@infradead.org>
         <20230306040037.20350-6-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.194
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-03-05 at 20:00 -0800, Randy Dunlap wrote:
> A previous patch removed most of the sh5 (sh64) support from the
> kernel tree. Now remove the last stragglers.
> 
> Fixes: 37744feebc08 ("sh: remove sh5 support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
> v2: update after adding the parisc64 alias to kbuild.rst
> v3: skipped
> v4: refresh & resend
> 
>  Documentation/kbuild/kbuild.rst                           |    1 -
>  Documentation/scheduler/sched-arch.rst                    |    2 --
>  Documentation/translations/zh_CN/scheduler/sched-arch.rst |    2 --
>  scripts/checkstack.pl                                     |    7 -------
>  tools/perf/arch/common.c                                  |    2 --
>  tools/scripts/Makefile.arch                               |    5 -----
>  tools/testing/selftests/mm/Makefile                       |    2 +-
>  tools/testing/selftests/mm/run_vmtests.sh                 |    2 +-
>  8 files changed, 2 insertions(+), 21 deletions(-)
> 
> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -161,7 +161,6 @@ But some architectures such as x86 and s
>  
>  - x86: i386 for 32 bit, x86_64 for 64 bit
>  - parisc: parisc64 for 64 bit
> -- sh: sh for 32 bit, sh64 for 64 bit
>  - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>  
>  CROSS_COMPILE
> diff -- a/Documentation/scheduler/sched-arch.rst b/Documentation/scheduler/sched-arch.rst
> --- a/Documentation/scheduler/sched-arch.rst
> +++ b/Documentation/scheduler/sched-arch.rst
> @@ -70,7 +70,5 @@ Possible arch problems I found (and eith
>  
>  ia64 - is safe_halt call racy vs interrupts? (does it sleep?) (See #4a)
>  
> -sh64 - Is sleeping racy vs interrupts? (See #4a)
> -
>  sparc - IRQs on at this point(?), change local_irq_save to _disable.
>        - TODO: needs secondary CPUs to disable preempt (See #1)
> diff -- a/Documentation/translations/zh_CN/scheduler/sched-arch.rst b/Documentation/translations/zh_CN/scheduler/sched-arch.rst
> --- a/Documentation/translations/zh_CN/scheduler/sched-arch.rst
> +++ b/Documentation/translations/zh_CN/scheduler/sched-arch.rst
> @@ -70,7 +70,5 @@ 我发现的可能的arch问题（并试
>  
>  ia64 - safe_halt的调用与中断相比，是否很荒谬？ (它睡眠了吗) (参考 #4a)
>  
> -sh64 - 睡眠与中断相比，是否很荒谬？ (参考 #4a)
> -
>  sparc - 在这一点上，IRQ是开着的（？），把local_irq_save改为_disable。
>        - 待办事项: 需要第二个CPU来禁用抢占 (参考 #1)
> diff -- a/scripts/checkstack.pl b/scripts/checkstack.pl
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -10,7 +10,6 @@
>  #	Mips port by Juan Quintela <quintela@mandrakesoft.com>
>  #	IA64 port via Andreas Dilger
>  #	Arm port by Holger Schurig
> -#	sh64 port by Paul Mundt
>  #	Random bits by Matt Mackall <mpm@selenic.com>
>  #	M68k port by Geert Uytterhoeven and Andreas Schwab
>  #	AArch64, PARISC ports by Kyle McMartin
> @@ -100,12 +99,6 @@ my (@stack, $re, $dre, $sub, $x, $xs, $f
>  		#  100092:	 e3 f0 ff c8 ff 71	 lay	 %r15,-56(%r15)
>  		$re = qr/.*(?:lay|ag?hi).*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})
>  		      (?:\(\%r15\))?$/ox;
> -	} elsif ($arch =~ /^sh64$/) {
> -		#XXX: we only check for the immediate case presently,
> -		#     though we will want to check for the movi/sub
> -		#     pair for larger users. -- PFM.
> -		#a00048e0:       d4fc40f0        addi.l  r15,-240,r15
> -		$re = qr/.*addi\.l.*r15,-(([0-9]{2}|[3-9])[0-9]{2}),r15/o;
>  	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
>  		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
>  		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
> diff -- a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -51,9 +51,7 @@ const char *const s390_triplets[] = {
>  
>  const char *const sh_triplets[] = {
>  	"sh-unknown-linux-gnu-",
> -	"sh64-unknown-linux-gnu-",
>  	"sh-linux-gnu-",
> -	"sh64-linux-gnu-",
>  	NULL
>  };
>  
> diff -- a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> --- a/tools/scripts/Makefile.arch
> +++ b/tools/scripts/Makefile.arch
> @@ -29,11 +29,6 @@ ifeq ($(ARCH),sparc64)
>         SRCARCH := sparc
>  endif
>  
> -# Additional ARCH settings for sh
> -ifeq ($(ARCH),sh64)
> -       SRCARCH := sh
> -endif
> -
>  # Additional ARCH settings for loongarch
>  ifeq ($(ARCH),loongarch32)
>         SRCARCH := loongarch
> diff -- a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -90,7 +90,7 @@ endif
>  
>  endif
>  
> -ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
> +ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
>  TEST_GEN_FILES += va_128TBswitch
>  TEST_GEN_FILES += virtual_address_range
>  TEST_GEN_FILES += write_to_hugetlbfs
> diff -- a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -132,7 +132,7 @@ else
>  fi
>  
>  # filter 64bit architectures
> -ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
> +ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sparc64 x86_64"
>  if [ -z "$ARCH" ]; then
>  	ARCH=$(uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/')
>  fi

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
