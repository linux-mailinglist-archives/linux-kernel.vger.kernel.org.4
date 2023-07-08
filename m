Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405674BF5D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 23:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGHVuL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 Jul 2023 17:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 17:50:10 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1ABFD;
        Sat,  8 Jul 2023 14:50:09 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qIFo6-003Svz-ME; Sat, 08 Jul 2023 23:49:34 +0200
Received: from dynamic-077-191-176-013.77.191.pool.telefonica.de ([77.191.176.13] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qIFo6-003I7c-Es; Sat, 08 Jul 2023 23:49:34 +0200
Message-ID: <62d9d61e7d085840161c06f08b7aebfd734663fa.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sh updates for v6.5
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 08 Jul 2023 23:49:25 +0200
In-Reply-To: <45f9efa9-9341-e7e4-fbe4-ec7689c714aa@omp.ru>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
         <ZKba4SLzjjhHgOEs@infradead.org>
         <5c612d0b293082352df6640ac951918bfa458181.camel@physik.fu-berlin.de>
         <45f9efa9-9341-e7e4-fbe4-ec7689c714aa@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.176.13
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

Hi!

On Sun, 2023-07-09 at 00:25 +0300, Sergey Shtylyov wrote:
> > However, since I am still new to kernel development, it will certainly take
> > me a little more time until we're there. However, there is some interest
> > in the community such as the J-Core people and Artur Rojek, so there are people
> > who are willing to help me.
> 
>    Maybe we could start using the #linux-sh channel (again?) -- it's there, on
> Libera.chat, with couple persons hanging around... :-)

Most SuperH/J-Core people meet in #jcore on libera these days.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
