Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05727495A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjGFGeQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 02:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjGFGeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:34:13 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F510F2;
        Wed,  5 Jul 2023 23:34:11 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHIZ2-001Mec-CB; Thu, 06 Jul 2023 08:34:04 +0200
Received: from p57bd990e.dip0.t-ipconnect.de ([87.189.153.14] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHIZ2-003DEm-4j; Thu, 06 Jul 2023 08:34:04 +0200
Message-ID: <7da62314e5bd2fc1b0f2c95ff0a0f6a39d9ae447.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] SH7709 DMA fixes
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 08:34:03 +0200
In-Reply-To: <20230506141703.65605-1-contact@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
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

Hi Artur!

On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
> this series provides fixes to the SH7709 DMA controller, allowing the HP
> Jornada 680 palmtop to boot Linux again. To my knowledge, this is the
> first time in ~14 years someone tests upstream Linux on this device. And
> with the included patches applied, I'm happy to announce that it still
> works like a charm.

Your first batch of patches has been merged into Linus' tree now:

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c17414a273b81fe4e34e11d69fc30cc8b1431614

> PS. What might be of interest to the sh-linux community, there's further
> work towards this platform in my pipeline. E.g. I've added support for
> the HD6446x PCMCIA controller, allowing Jornada 680 to use Ethernet and
> Wi-Fi cards. However, what prevents proper upstream of such a driver is
> the crude and antiquated code of the underlying platform base. For
> example, the HD6446x bridge (`cchips/hd6446x/hd64461.c`) lacks the
> concept of clocks, preventing the PCMCIA driver from hardware agnostic
> clock gating. So what I'm looking into next is the cleanup of existing
> platform code base, bringing it up-to-date with modern kernel APIs.
> Hopefully it's not trying to bite more than I can chew, but eventually
> ending up with Device Tree support would be really nice :)

Feel free to start sending in more patches addressing the issues mentioned above.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
