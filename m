Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7E6979B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjBOKTd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 05:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBOKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:19:31 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C4E32CF3;
        Wed, 15 Feb 2023 02:19:30 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pSEsr-003W3w-7F; Wed, 15 Feb 2023 11:19:29 +0100
Received: from p5b13aa49.dip0.t-ipconnect.de ([91.19.170.73] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pSEsq-002tFk-WE; Wed, 15 Feb 2023 11:19:29 +0100
Message-ID: <6021a9ac7a57de5422a2070beb21b921195bdd96.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH] MAINTAINERS: Mark Itanium/IA64 as 'dead'
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Date:   Wed, 15 Feb 2023 11:19:28 +0100
In-Reply-To: <20230128122904.1345120-1-ardb@kernel.org>
References: <20230128122904.1345120-1-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.73
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard!

On Sat, 2023-01-28 at 13:29 +0100, Ard Biesheuvel wrote:
> Create a new status 'dead' which conveys that a subsystem is
> unmaintained and scheduled for removal, and developers are free to
> behave as if it's already gone. Also, automated build tests should
> ignore such subsystems, or at least notify only those who are known to
> have an interest in the subsystem in particular.
> 
> Given that Itanium/IA64 has no maintainer, is no longer supported in
> QEMU (for boot testing under emulation) and does not seem to have a user
> base beyond a couple of machines used by distros to churn out packages,
> let's mark it as dead. This shall mean that any treewide changes (such
> as changes to the EFI subsystem, which I maintain) can be made even if
> they might cause build or boot time regressions on IA64 machines. Also,
> mark the port as scheduled for removal after the next LTS release.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-ia64@vger.kernel.org
> Link: https://lore.kernel.org/all/CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  MAINTAINERS | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b74014994f5c1cc..5481967c2112e8ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -94,6 +94,14 @@ Descriptions of section entries and preferred order
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	   Dead:	Code has no maintainer and no significant user base,
> +			and is scheduled for removal. Developers are free to
> +			ignore it when it comes to testing bug fixes or other
> +			code changes, and automated build test systems must not
> +			report any detected issues, except possibly to mailing
> +			lists or other recipients that have opted in
> +			specifically to receiving reports about the state of
> +			this code.
>  	W: *Web-page* with status/info
>  	Q: *Patchwork* web based patch tracking system site
>  	B: URI for where to file *bugs*. A web-page with detailed bug
> @@ -9833,7 +9841,7 @@ F:	include/linux/i3c/
>  
>  IA64 (Itanium) PLATFORM
>  L:	linux-ia64@vger.kernel.org
> -S:	Orphan
> +S:	Dead # to be removed after the 2023 LTS release
>  F:	Documentation/ia64/
>  F:	arch/ia64/

Sounds reasonable to me.

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
