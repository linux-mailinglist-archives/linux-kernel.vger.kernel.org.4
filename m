Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50706BD0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCPN0s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCPN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:26:46 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95C5D474;
        Thu, 16 Mar 2023 06:26:45 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pcncx-000mLF-8q; Thu, 16 Mar 2023 14:26:43 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pcncw-0045JV-PZ; Thu, 16 Mar 2023 14:26:43 +0100
Message-ID: <12d134ccf30123769dd2fd0ba6c69a9941a500d3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/7 v4] sh: various doc, build, init fixes
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Mar 2023 14:26:41 +0100
In-Reply-To: <20230306040037.20350-1-rdunlap@infradead.org>
References: <20230306040037.20350-1-rdunlap@infradead.org>
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
> All of these patches have been sent previously, anywhere from
> one to 3 times.  All patches are now called "v4".
> 
> This refresh/resend is to assist the new SH maintainer.
> 
>  [PATCH 1/7 v4] sh: SH2007: drop the bad URL info
>  [PATCH 2/7 v4] sh: nmi_debug: fix return value of __setup handler
>  [PATCH 3/7 v4] sh: init: use OF_EARLY_FLATTREE for early init
>  [PATCH 4/7 v4] sh: math-emu: fix macro redefined warning
>  [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
>  [PATCH 6/7 v4] sh: fix Kconfig entry for NUMA => SMP
>  [PATCH 7/7 v4] sh: mcount.S: fix build error when PRINTK is not enabled

I have successfully applied, built and booted all patches on my SH7785LCR evaluation
board except for patch #5.

I'll do the review next, then include them in my for-next tree for 6.4.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
