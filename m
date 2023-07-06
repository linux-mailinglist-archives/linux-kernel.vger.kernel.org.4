Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C974A0DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGFPYK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjGFPYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:24:06 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885191BFF;
        Thu,  6 Jul 2023 08:23:47 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHQpR-000tTL-Cg; Thu, 06 Jul 2023 17:23:33 +0200
Received: from p57bd990e.dip0.t-ipconnect.de ([87.189.153.14] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHQpR-000Yv1-51; Thu, 06 Jul 2023 17:23:33 +0200
Message-ID: <5c612d0b293082352df6640ac951918bfa458181.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sh updates for v6.5
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Jul 2023 17:23:32 +0200
In-Reply-To: <ZKba4SLzjjhHgOEs@infradead.org>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
         <ZKba4SLzjjhHgOEs@infradead.org>
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

Hi Christoph!

On Thu, 2023-07-06 at 08:16 -0700, Christoph Hellwig wrote:
> thanks for taking up the sh maintainership!

You're welcome.

> Any chance you could do an inventoy on which arch/sh/ platforms are
> currently working and maintained and which are just bitrot?
> 
> sh still has a lot of platform specific code that feels іt is rotting,
> but some of that might just have been due to the lack of active
> maintainance.

I am slowly working towards getting everything back into shape. In particular,
there is a patch set by Yoshinori Sato to convert arch/sh to device tree which
I would like to eventually get upstreamed.

However, since I am still new to kernel development, it will certainly take
me a little more time until we're there. However, there is some interest
in the community such as the J-Core people and Artur Rojek, so there are people
who are willing to help me.

> Once platform that I'm particulary interested in is dreamcast, which has
> a rather oddball block driver (gdrom) and some very odd interaction with
> the dma-mapping code.

OK, thanks for the heads-up. I cannot comment on this yet, but I have a Dreamcast
myself which I can use for testing in this case.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
