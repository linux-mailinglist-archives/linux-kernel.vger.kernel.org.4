Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133F7459BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGCKKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGCKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3437E51;
        Mon,  3 Jul 2023 03:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297C760E75;
        Mon,  3 Jul 2023 10:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFEEC433C7;
        Mon,  3 Jul 2023 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688379001;
        bh=Syu0ECzT/iRJ3OhIsVKQiGFN/cajP09lPCPst4dtp7M=;
        h=Date:From:To:Cc:Subject:From;
        b=2QDkNkzBZalrAsR/aYBREU2EVZVBoeUDuUdE/mneSlIE6oovo4gCA4Nze7usmsi1Q
         4yT4p5kgVb6fZzAqKDeEGwKn6L9M0veLefdJrh5OwrOzEeojw8oOXvvyoyutH76lGP
         k2eY8tFEjtx2ccnlbOWSxL+EHNBetJwv0+QDw38o=
Date:   Mon, 3 Jul 2023 12:09:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 6.5-rc1
Message-ID: <ZKKedy5AEsA58TWd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc1

for you to fetch changes up to e534755c9412be07f579acd2947401a9f87a33c8:

  tty_audit: make data of tty_audit_log() const (2023-06-21 17:57:29 +0200)

----------------------------------------------------------------
TTY/Serial driver updates for 6.5-rc1.

Here is the big set of tty/serial driver updates for 6.5-rc1.

Included in here are:
  - tty_audit code cleanups from Jiri
  - more 8250 cleanups from Ilpo
  - samsung_tty driver bugfixes
  - 8250 lock port updates
  - usual fsl_lpuart driver updates and fixes
  - other small serial driver fixes and updates, full details in the
    shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      serial: 8250: omap: convert to modern PM ops

Chen-Yu Tsai (1):
      serial: 8250_mtk: Simplify clock sequencing and runtime PM

Christophe JAILLET (3):
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
      tty: serial: samsung_tty: Use abs() to simplify some code

Dan Carpenter (3):
      serial: core: don't kfree device managed data
      serial: core: fix -EPROBE_DEFER handling in init
      serial: atmel: don't enable IRQs prematurely

Geert Uytterhoeven (1):
      serial: 8250: omap: Move uart_write() inside PM section

Greg Kroah-Hartman (2):
      Merge 6.4-rc3 into tty-next
      Merge 6.4-rc5 into tty-next

Hongyu Xie (1):
      serial: pl011: set UART011_CR_RXE in pl011_set_termios after port shutdown

Hui Li (1):
      tty: fix hang on tty device with no_room set

Ilpo Järvinen (6):
      serial: 8250: Change dl_read/write to handle value as u32
      serial: 8250: Document uart_8250_port's ->dl_read/write()
      serial: 8250: Add dl_read/write, bugs and mapsize into plat_serial8250_port
      serial: 8250: RT288x/Au1xxx code away from core
      serial: 8250_rt288x: Name non-standard divisor latch reg
      serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED

Jacky Huang (1):
      tty: serial: Add Nuvoton ma35d1 serial driver support

James Hilliard (1):
      serial: Indicate fintek option may also be required for RS232 support

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiri Slaby (6):
      tty_audit: use TASK_COMM_LEN for task comm
      tty_audit: use kzalloc() in tty_audit_buf_alloc()
      tty_audit: invert the condition in tty_audit_log()
      tty_audit: make icanon a bool
      tty_audit: make tty pointers in exposed functions const
      tty_audit: make data of tty_audit_log() const

John Ogness (8):
      serial: 8250: lock port in startup() callbacks
      serial: core: lock port for stop_rx() in uart_suspend_port()
      serial: 8250: lock port for stop_rx() in omap8250_irq()
      serial: core: lock port for start_rx() in uart_resume_port()
      serial: 8250: lock port for rx_dma() callback
      serial: 8250: lock port for omap8250_restore_regs()
      serial: 8250: lock port for UART_IER access in omap8250_irq()
      serial: 8250: synchronize and annotate UART_IER access

Martin Fuzzey (1):
      tty: serial: imx: fix rs485 rx after tx

Michal Sekletar (2):
      tty: tty_io: update timestamps on all device nodes
      selftests: tty: add selftest for tty timestamp updates

Raphael Gallais-Pou (1):
      serial: st-asc: fix typo in property name

Shenwei Wang (1):
      tty: serial: fsl_lpuart: optimize the timer based EOP logic

Sherry Sun (2):
      tty: serial: fsl_lpuart: Check the return value of dmaengine_tx_status
      tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Steven Price (1):
      serial: core: Don't drop port_mutex in serial_core_remove_one_port

Tony Lindgren (9):
      serial: 8250: omap: Fix freeing of resources on failed register
      serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()
      serial: 8250: omap: Fix life cycle issues for interrupt handlers
      serial: 8250: omap: Shut down on remove for console uart
      serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS
      serial: core: Start managing serial controllers to enable runtime PM
      serial: core: Fix probing serial_base_bus devices
      serial: core: Fix error handling for serial_core_ctrl_device_add()
      serial: 8250_omap: Use force_suspend and resume for system suspend

Uwe Kleine-König (7):
      serial: stm32: Ignore return value of uart_remove_one_port() in .remove()
      serial: Make uart_remove_one_port() return void
      serial: Switch i2c drivers back to use .probe()
      serial: 8250-fsl: Expand description of the MPC83xx UART's misbehaviour
      powerpc/legacy_serial: Warn about 8250 devices operated without active FSL workarounds
      powerpc/legacy_serial: Handle SERIAL_8250_FSL=n build failures
      serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE

 arch/mips/alchemy/common/platform.c             |  10 +-
 arch/powerpc/kernel/legacy_serial.c             |  14 +-
 drivers/tty/n_tty.c                             |  25 +-
 drivers/tty/serial/8250/8250.h                  |  11 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c     |   3 +
 drivers/tty/serial/8250/8250_bcm7271.c          |   4 +
 drivers/tty/serial/8250/8250_core.c             |  91 ++-
 drivers/tty/serial/8250/8250_early.c            |  21 -
 drivers/tty/serial/8250/8250_em.c               |   4 +-
 drivers/tty/serial/8250/8250_exar.c             |   4 +
 drivers/tty/serial/8250/8250_fsl.c              |  17 +-
 drivers/tty/serial/8250/8250_mtk.c              |  59 +-
 drivers/tty/serial/8250/8250_of.c               |   6 +-
 drivers/tty/serial/8250/8250_omap.c             | 215 ++++---
 drivers/tty/serial/8250/8250_pci.c              |  19 -
 drivers/tty/serial/8250/8250_port.c             | 167 +++--
 drivers/tty/serial/8250/8250_pxa.c              |   2 +-
 drivers/tty/serial/8250/8250_rt288x.c           | 136 ++++
 drivers/tty/serial/8250/8250_uniphier.c         |   4 +-
 drivers/tty/serial/8250/Kconfig                 |  16 +-
 drivers/tty/serial/8250/Makefile                |   1 +
 drivers/tty/serial/Kconfig                      |  23 +
 drivers/tty/serial/Makefile                     |   6 +-
 drivers/tty/serial/amba-pl011.c                 |   7 +
 drivers/tty/serial/atmel_serial.c               |   9 +-
 drivers/tty/serial/clps711x.c                   |   4 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c     |   5 +-
 drivers/tty/serial/fsl_lpuart.c                 |  57 +-
 drivers/tty/serial/imx.c                        |  22 +-
 drivers/tty/serial/lantiq.c                     |   4 +-
 drivers/tty/serial/ma35d1_serial.c              | 821 ++++++++++++++++++++++++
 drivers/tty/serial/max310x.c                    |   2 +-
 drivers/tty/serial/samsung_tty.c                |  19 +-
 drivers/tty/serial/sc16is7xx.c                  |   2 +-
 drivers/tty/serial/serial_base.h                |  46 ++
 drivers/tty/serial/serial_base_bus.c            | 205 ++++++
 drivers/tty/serial/serial_core.c                | 210 +++++-
 drivers/tty/serial/serial_ctrl.c                |  68 ++
 drivers/tty/serial/serial_port.c                | 105 +++
 drivers/tty/serial/st-asc.c                     |   6 +-
 drivers/tty/serial/stm32-usart.c                |   5 +-
 drivers/tty/serial/uartlite.c                   |  12 +-
 drivers/tty/serial/xilinx_uartps.c              |   5 +-
 drivers/tty/tty.h                               |  11 +-
 drivers/tty/tty_audit.c                         |  43 +-
 drivers/tty/tty_io.c                            |  31 +-
 include/linux/serial_8250.h                     |  45 +-
 include/linux/serial_core.h                     |   7 +-
 tools/testing/selftests/Makefile                |   1 +
 tools/testing/selftests/tty/.gitignore          |   2 +
 tools/testing/selftests/tty/Makefile            |   5 +
 tools/testing/selftests/tty/tty_tstamp_update.c |  88 +++
 52 files changed, 2280 insertions(+), 425 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_rt288x.c
 create mode 100644 drivers/tty/serial/ma35d1_serial.c
 create mode 100644 drivers/tty/serial/serial_base.h
 create mode 100644 drivers/tty/serial/serial_base_bus.c
 create mode 100644 drivers/tty/serial/serial_ctrl.c
 create mode 100644 drivers/tty/serial/serial_port.c
 create mode 100644 tools/testing/selftests/tty/.gitignore
 create mode 100644 tools/testing/selftests/tty/Makefile
 create mode 100644 tools/testing/selftests/tty/tty_tstamp_update.c
