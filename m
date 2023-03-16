Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CB6BD0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCPNXV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCPNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:23:19 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9A22A24;
        Thu, 16 Mar 2023 06:23:17 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pcnZZ-000lFD-E8; Thu, 16 Mar 2023 14:23:13 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pcnZZ-0044YO-6g; Thu, 16 Mar 2023 14:23:13 +0100
Message-ID: <c16434108aaf639782f905ae45e94ea9d58621f1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Thu, 16 Mar 2023 14:23:12 +0100
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

Hi Randy!

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

This hunk doesn't apply anymore since the parisc part has been dropped although I can't
find the commit for that. Could you rebase your patch, please?

Apologies that I didn't have the time earlier to start looking at this series!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
