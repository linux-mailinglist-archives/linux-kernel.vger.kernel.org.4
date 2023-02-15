Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B5698895
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBOXJV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 18:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBOXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:09:18 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0F437541;
        Wed, 15 Feb 2023 15:09:17 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pSQtk-003UZK-63; Thu, 16 Feb 2023 00:09:12 +0100
Received: from p5b13aa49.dip0.t-ipconnect.de ([91.19.170.73] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pSQtj-000eZ4-Un; Thu, 16 Feb 2023 00:09:12 +0100
Message-ID: <f896bde517ac65e1933bba4f2ceb9f4a9717e7bd.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-ia64@vger.kernel.org
Date:   Thu, 16 Feb 2023 00:09:10 +0100
In-Reply-To: <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
References: <20230215100008.2565237-1-ardb@kernel.org>
         <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
         <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
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

Hi Linus!

On Wed, 2023-02-15 at 11:30 -0800, Linus Torvalds wrote:
> On Wed, Feb 15, 2023 at 2:17 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > 
> > It's not that I don't care. I just haven't been able to bisect the bug .yet
> 
> I'm not a fan of ia64 as an architecture, but it's a bit sad to remove
> it entirely. It's not like it's been a huge maintenance burden in
> general.

I agree. It would be sad to see it go.

> That said, if it doesn't work, and nobody has the time and/or
> inclination to figure out why, I don't really see any alternative.

That's not really what I meant though. I definitely have the time to look
after the architecture as I am also maintaining it in Debian.

What I meant here is that I simply hadn't had the time yet to fully debug
this particular regression that was introduced with 6.1. I did actually
start a bisect and got close to the problematic commit as I got distracted
with my day job.

My plan was definitely to continue debugging the problem in the coming weekend
and at least find the commit that introduced the regression. I always have an
Itanium server ready for testing kernels that I can power on and control remotely
via its built-in management system.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
