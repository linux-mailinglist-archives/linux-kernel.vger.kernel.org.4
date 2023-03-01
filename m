Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4066A6956
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCAJDG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Mar 2023 04:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCAJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:03:02 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848B7D8D;
        Wed,  1 Mar 2023 01:03:01 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pXIMR-000R73-38; Wed, 01 Mar 2023 10:02:55 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pXIMQ-003rAU-SH; Wed, 01 Mar 2023 10:02:55 +0100
Message-ID: <43b34b98415a56fa5808837ae0d16003c80910b9.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.3
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Mar 2023 10:02:54 +0100
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

Hi Linus!

This is my first pull request as a SuperH maintainer, so the list of changes
is very short and contains just two fixes.

One patch by Geert Uytterhoeven fixes a regression in connection with the rtl8169
driver on SuperH boards that was introduced when the driver was switched to use
devm_clk_get_optional_enabled() to simplify the code.

The second patch by Michael Karcher fixes a build warning and allows the kernel
to be built with CONFIG_WERROR enabled on SuperH.

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

 Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.3-tag1

for you to fetch changes up to ff30bd6a6618e979b16977617371c0f28a95036e:

 sh: clk: Fix clk_enable() to return 0 on NULL clk (2023-02-27 10:50:48 +0100)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.3

- sh: clk: Fix clk_enable() to return 0 on NULL clk
- sh: intc: Avoid spurious sizeof-pointer-div warning

----------------------------------------------------------------
Geert Uytterhoeven (1):
 sh: clk: Fix clk_enable() to return 0 on NULL clk

Michael Karcher (1):
 sh: intc: Avoid spurious sizeof-pointer-div warning

 drivers/sh/clk/core.c | 2 +-
 include/linux/sh_intc.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
