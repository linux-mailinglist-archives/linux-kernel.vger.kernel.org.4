Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B1749E87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjGFOFE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGFOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:05:02 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D681BC2;
        Thu,  6 Jul 2023 07:05:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHPbC-000PKz-9U; Thu, 06 Jul 2023 16:04:46 +0200
Received: from p57bd990e.dip0.t-ipconnect.de ([87.189.153.14] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHPbC-000JuG-1s; Thu, 06 Jul 2023 16:04:46 +0200
Message-ID: <ab09d99c78bd378f23580427323c6418cd0888af.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sh updates for v6.5
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Jul 2023 16:04:45 +0200
In-Reply-To: <9bc72d0c-fe33-5759-799c-f54e325ba38d@roeck-us.net>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
         <9bc72d0c-fe33-5759-799c-f54e325ba38d@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.14
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-06 at 07:01 -0700, Guenter Roeck wrote:
> Perfect example why it is a bad idea to let build failures linger around.
> The build failure fixed by this patch ...

How was that lingered around? Your patch was merged within less than a week.

> > John Paul Adrian Glaubitz (1):
> >        sh: j2: Use ioremap() to translate device tree address into kernel memory
> > 
> > Masahiro Yamada (4):
> >        sh: Fix -Wmissing-include-dirs warnings for various platforms
> >        sh: Move build rule for cchips/hd6446x/ to arch/sh/Kbuild
> >        sh: Refactor header include path addition
> >        sh: Remove compiler flag duplication
> > 
> > Sergey Shtylyov (1):
> >        sh: Avoid using IRQ0 on SH3 and SH4
> > 
> ... was hiding boot failures with all my qemu emulations caused by
> this patch.

But Sergey's patch had been in my for-next tree since June 11 [1].

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git/log/?h=for-next

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
