Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA45274CF45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGJH6U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 03:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGJH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:57:42 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E010FB;
        Mon, 10 Jul 2023 00:57:41 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qIllt-002WfI-Rl; Mon, 10 Jul 2023 09:57:25 +0200
Received: from dynamic-089-014-157-058.89.14.pool.telefonica.de ([89.14.157.58] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qIllt-000dU2-Ki; Mon, 10 Jul 2023 09:57:25 +0200
Message-ID: <e44bc98f41e0497a3f125a32a6e78fe14313c634.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL
 demux
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Jul 2023 09:57:16 +0200
In-Reply-To: <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com>
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
         <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net>
         <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
         <f27872c8f374a42fb7ea313314c47cdba2473b06.camel@physik.fu-berlin.de>
         <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.157.58
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Mon, 2023-07-10 at 09:54 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Mon, Jul 10, 2023 at 9:44 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Mon, 2023-07-10 at 09:03 +0200, Geert Uytterhoeven wrote:
> > > Indeed, I hadn't tested that.
> > > My current tree isn't based on linux-next, but did have a build
> > > failure in the cdrom code, for which I had found your fix (thanks!) in
> > > linux-next...
> > 
> > So, there is a patch for this already? Is it going to be included for 6.5?
> 
> The cdrom fix is commit a587b046ce921cc1 ("cdrom/gdrom: Fix build
> error") in v6.5-rc1, which builds dreamcast_defconfig fine.
> 
> That config is still broken in linux-next, but the breakage hasn't\
> entered v6.5-rc1 (yet?).

OK, so we're talking about two different regressions here?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
