Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C44B6979A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjBOKRW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 05:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBOKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:17:19 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF020D38;
        Wed, 15 Feb 2023 02:17:17 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pSEqe-003VIA-Kf; Wed, 15 Feb 2023 11:17:12 +0100
Received: from p5b13aa49.dip0.t-ipconnect.de ([91.19.170.73] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pSEqe-002su4-DJ; Wed, 15 Feb 2023 11:17:12 +0100
Message-ID: <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
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
Date:   Wed, 15 Feb 2023 11:17:11 +0100
In-Reply-To: <20230215100008.2565237-1-ardb@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
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

On Wed, 2023-02-15 at 11:00 +0100, Ard Biesheuvel wrote:
> The IA64 port of Linux has no maintainer, and according to a report from
> its only remaining user [0], it has been broken for a month and nobody
> cares.

It's not that I don't care. I just haven't been able to bisect the bug .yet

> Given that keeping a complex but unused architecture alive uses up
> valuable developer bandwidth, let's just get rid of it.
> 
> This supersedes my patch proposing to mark it as 'dead', which received
> no replies from anyone that wants to keep it alive. [1]

I'm actually fine with marking it as dead. I forgot to ack.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
