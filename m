Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848126988A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBOXOD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 18:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:14:01 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733C3BD94;
        Wed, 15 Feb 2023 15:14:01 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pSQyA-003Vpv-Do; Thu, 16 Feb 2023 00:13:46 +0100
Received: from p5b13aa49.dip0.t-ipconnect.de ([91.19.170.73] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pSQyA-000ex6-58; Thu, 16 Feb 2023 00:13:46 +0100
Message-ID: <77ff2776d99286eac6eefecb1903b96899d0ff62.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Date:   Thu, 16 Feb 2023 00:13:44 +0100
In-Reply-To: <CAHk-=wj9RkLN+GpYcFmsd8tze6zYL7MMkNpvdKbETQnqYm+Hwg@mail.gmail.com>
References: <20230215100008.2565237-1-ardb@kernel.org>
         <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
         <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
         <SJ1PR11MB6083F7F30FE9ED8F39FA1F85FCA39@SJ1PR11MB6083.namprd11.prod.outlook.com>
         <CAHk-=wj9RkLN+GpYcFmsd8tze6zYL7MMkNpvdKbETQnqYm+Hwg@mail.gmail.com>
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

On Wed, 2023-02-15 at 12:08 -0800, Linus Torvalds wrote:
> But when it's actively known to be broken and nobody has time or
> interest to look at it, at that point the "it doesn't look any more
> painful than other architectures" becomes kind of moot.

Let me look after it in the weekend and let's see whether we can unbreak
it. I don't think there is really a big issue. The last time we had a
similar issue was the regression introduced by 974b9b2c68f3 which got fixed
with the simple fix in bd05220c7be3.

It's probably similarly trivial to fix the current regression.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
