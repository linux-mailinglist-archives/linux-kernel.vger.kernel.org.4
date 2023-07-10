Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76E74CFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGJIVF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjGJIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:20:56 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83D1BE;
        Mon, 10 Jul 2023 01:20:54 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qIm8M-002h2N-CB; Mon, 10 Jul 2023 10:20:38 +0200
Received: from dynamic-089-014-157-058.89.14.pool.telefonica.de ([89.14.157.58] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qIm8M-000iFO-5A; Mon, 10 Jul 2023 10:20:38 +0200
Message-ID: <63a34d66698065724d8ff3455192a8f2814cf034.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL
 demux
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Jul 2023 10:20:27 +0200
In-Reply-To: <CAMuHMdUOOPvVM-evLptCnbNGpDtAxktY7QDuKQo7WmZ7RhrAFg@mail.gmail.com>
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
         <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net>
         <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
         <f27872c8f374a42fb7ea313314c47cdba2473b06.camel@physik.fu-berlin.de>
         <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com>
         <e44bc98f41e0497a3f125a32a6e78fe14313c634.camel@physik.fu-berlin.de>
         <CAMuHMdUOOPvVM-evLptCnbNGpDtAxktY7QDuKQo7WmZ7RhrAFg@mail.gmail.com>
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

On Mon, 2023-07-10 at 10:18 +0200, Geert Uytterhoeven wrote:
> > OK, so we're talking about two different regressions here?
> 
> Yes.
> 
> https://lore.kernel.org/r/CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com

Link doesn't work for me, unfortunately.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
