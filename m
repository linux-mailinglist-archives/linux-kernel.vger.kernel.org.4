Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC26BE223
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCQHvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCQHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:51:32 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB008F71C;
        Fri, 17 Mar 2023 00:51:30 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pd4s0-000c8p-Tf; Fri, 17 Mar 2023 08:51:24 +0100
Received: from dynamic-078-055-143-011.78.55.pool.telefonica.de ([78.55.143.11] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pd4s0-002izB-N2; Fri, 17 Mar 2023 08:51:24 +0100
Message-ID: <2749830124ec9d6990c95bf2ce4ea4de56b2967a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Fri, 17 Mar 2023 08:51:23 +0100
In-Reply-To: <CAMuHMdXaZEWxB9Opgt2wcD2xAqF9Jv4r4KY9RGaR7vVVFXs5NQ@mail.gmail.com>
References: <ef8fbda8-cace-1db3-9161-abd2e75dcf13@infradead.org>
         <A8D501D3-68ED-4112-BDA7-EE67357A2E28@physik.fu-berlin.de>
         <ca94954e-88ea-6707-d2a5-722e589d0c87@infradead.org>
         <50863bc8642d52f1533ad5809ae2dcd690e2493b.camel@physik.fu-berlin.de>
         <CAMuHMdXaZEWxB9Opgt2wcD2xAqF9Jv4r4KY9RGaR7vVVFXs5NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.55.143.11
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Fri, 2023-03-17 at 08:31 +0100, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Thu, Mar 16, 2023 at 9:46 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Thu, 2023-03-16 at 13:43 -0700, Randy Dunlap wrote:
> > > > Oops, sorry. My bad. I will use the proper tree.
> > > 
> > > Just let me know if you want me to resend it.
> > > Thanks.
> > 
> > No, that's fine. I will rebase my for-next tree.
> 
> Rebase on top of what? Commit 49deed336ef9a409 ("parisc:
> update kbuild doc. aliases for parisc64") is in the parisc tree.
> You must not base the SH tree on the parisc tree.

Oh, I wasn't aware of that.

> Don't care about the simple conflict, Stephen and Linus can
> handle that fine.
> 
> FTR, if the conflict was more complex, an immutable branch to be
> merged by all parties would be appropriate.  But that's overkill and
> thus not needed for simple conflicts like this.

I'll resolve the conflict manually then. Thanks.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
