Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFF6168E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKBQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKBQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D861AD98;
        Wed,  2 Nov 2022 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667406376; bh=rJgbLL+FBceI4uWxw9o8fqzyiU5e5oNjbPi2SaLVtdk=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=nmN4oUtR+81ZhLCPh/c1t8RkUz+5MMHinX9EfWqgu8Un1E+5LwqoJjPVRwCo7cUZq
         36fWxq+DB5WxVYMkQWbKIukkwnaqYorPSu+l3IuFQjgpuwl3lK0+fqWwEkSuz6/71d
         iE4UuN1RCYZI078jYKLtsNk9z8yytdRXsydD+5LPGXPL1zvb6256hnn1P17ppVRQdP
         xzKuZIZHHxb4t82zqMF7IJHfFyicrIwJWsBek6VUUzerqHocPqOZs0e37HjeWE9fVY
         tmqw6Fu7xmXxjDXCPkaoMnzdu9mIgVuguzjIOM+Xe8F0n10ovMGwWdZbu0Wq+LymuF
         B5s9XhqheQuCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([92.116.147.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1oruC20Nyc-002oEe; Wed, 02
 Nov 2022 17:26:16 +0100
Date:   Wed, 2 Nov 2022 17:26:13 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.1-rc4
Message-ID: <Y2KaFoe7n4lkr25c@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:xHbuEPnV5UQKfq1zLYVpnAvTryrB5+ElqFEDJ3HzOPkPDNMUQWn
 sRERA0xrMomSyGNxnlM9MEB1tHRQ4r0rywmKVMNT5AYtZyzroRs3JAlwn2RnydopAgkhLuf
 9X9Rt33ZxoLSl+03AlgZlWjukNteFrWFeYtVs8bDkdVPoTlBNFYj7B0lxFfKS82exwwo4t3
 A1JjcpObgFh13w+QArLiw==
UI-OutboundReport: notjunk:1;M01:P0:qJ9MS02Cxrk=;PSb2fFkwTQlJh/G3lCdnleb3ebP
 4spYwm014E5mtDPSfcQi2fM33E3ySSlXiE1BTtSGNP3mshrMH5mqKm+oVimZ0CHI0DULbGNtm
 7E+Es4w3cReofjTwWzWy+JrjEZs9mQh23O0VMAd3YPI49AkQq5797J+B3mk+spLVnyuT0dFX+
 Yq2wEAP0Y7unJ7y49xEgRAJVOgdNYxwpiid3r5/dPN0qMFNsh1t63lYJD2o9DGCztIhB+Rqd/
 0nZLGKzOglkXXix/05rP8mM7ldzvfxt6OLLgzz6LhZMAoDX7bdDpXTOdqvGie5T2D2+U9U+8p
 UDC0toDa065xetkgGQOOXG/gsKd9y1dzqncW73j27wM4wxlD0fIaez2vznR/KN/0F1N3y3KsC
 gMocExGInbA0IkbXp2h0bBwMwTivHLrlytYRnbfdHVwWoXmC+zX0ZO3PWbqNnSibB7qZ5/q7+
 rpDP3DGr+7YG7rWpOuWeNO+6d9Xlgf8gxeIhzpCZUCtk+z6jGsskbTeMLnXvUFtvFsC81fVLX
 6JanIZCxpFm3+MoH2SH689xp+eEEmFTSOPC8z9rpbKXiw3l4fajUJ+PxukdKRkLz1LfGhdKc8
 KAjfPphjbBb1YM8+YcAtR1jBX1PECMVnF2DWYkW9vERbAn0w+AJ5H1beaTitlfoohYE5pM0r2
 IdPefkb0BLe9Zx4K+9/zt1NuJ/pLgR4IlblKzFw12s/m0dRsgbMvKlKm1Yr1bqexOTx1Es6tc
 ZCRqGbpO3cIfVtZpVRQOe1++uUsjLIObpdbE7FH+IgdDfKxS8Ydz5SzolvfWwu+oI3pXEbYuw
 MrTQqcZU3/fApnDFVk2AbViYQXucauZg/ucOFkHq/LjXdDzBhX5m6JfiyhCFr4MxM5DEmo7yM
 kOCOE79mIWayorFpHC/5nrz8ikdohU07/c22QdFeECeG9CRtQCx/65QRT7cAyW9O2br2UlGX/
 eL6Vpi/+sRqcbB/WA4u8Dj6KmXE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some fixes for the parisc architecture for 6.1-rc4.

This patchset handles mostly oddities with the serial port 8250_gsc.c driver.
Although the name suggests it's just for serial ports on the GSC bus (e.g. in
older PA-RISC machines), it handles serial ports on PA-RISC PCI devices (e.g.
on the SuperIO chip) as well.
Thus this patchset renames the driver to 8250_parisc and fixes the config
dependencies.
The other change is a cleanup on how the device IDs of devices in a PA-RISC
machine are shown at startup.

Thanks,
Helge

-----

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.1-2

for you to fetch changes up to 2b6ae0962b421103feb41a80406732944b0665b3:

  parisc: Avoid printing the hardware path twice (2022-10-31 15:37:14 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.1-rc4:

Rename the serial port 8250_gsc.c driver to 8250_parisc.c and cleanup
how the device IDs of devices in a PA-RISC machine are shown at startup.

----------------------------------------------------------------
Helge Deller (5):
      parisc: Make 8250_gsc driver dependend on CONFIG_PARISC
      parisc/serial: Rename 8250_gsc.c to 8250_parisc.c
      parisc: Use signed char for hardware path in pdc.h
      parisc: Export iosapic_serial_irq() symbol for serial port driver
      parisc: Avoid printing the hardware path twice

Lukas Bulwahn (1):
      MAINTAINERS: adjust entry after renaming parisc serial driver

 MAINTAINERS                                        |  2 +-
 arch/parisc/include/asm/hardware.h                 | 12 ++++----
 arch/parisc/include/uapi/asm/pdc.h                 | 36 ++++++++--------------
 arch/parisc/kernel/drivers.c                       | 14 ++++-----
 drivers/parisc/iosapic.c                           |  1 +
 drivers/parisc/pdc_stable.c                        | 34 ++++++++++----------
 .../tty/serial/8250/{8250_gsc.c => 8250_parisc.c}  |  0
 drivers/tty/serial/8250/Kconfig                    |  4 +--
 drivers/tty/serial/8250/Makefile                   |  2 +-
 9 files changed, 47 insertions(+), 58 deletions(-)
 rename drivers/tty/serial/8250/{8250_gsc.c => 8250_parisc.c} (100%)
