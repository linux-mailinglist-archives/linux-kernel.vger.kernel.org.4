Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C83681C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjA3VLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjA3VLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:11:15 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B75524900D;
        Mon, 30 Jan 2023 13:11:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id B751B7A056B;
        Mon, 30 Jan 2023 22:10:59 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport
Date:   Mon, 30 Jan 2023 22:10:50 +0100
Message-Id: <20230130211050.16753-2-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230130211050.16753-1-linux@zary.sk>
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <20230130211050.16753-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PARIDE protocol modules out of drivers/block and update CONFIG_
symbol names to PATA_PARPORT.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/Makefile                              |   2 +-
 drivers/ata/Kconfig                           |   2 +-
 drivers/ata/pata_parport/Kconfig              | 141 ++++++++++++
 drivers/ata/pata_parport/Makefile             |  17 ++
 .../{block/paride => ata/pata_parport}/aten.c |   0
 .../{block/paride => ata/pata_parport}/bpck.c |   0
 .../paride => ata/pata_parport}/bpck6.c       |   0
 .../{block/paride => ata/pata_parport}/comm.c |   0
 .../{block/paride => ata/pata_parport}/dstr.c |   0
 .../{block/paride => ata/pata_parport}/epat.c |   0
 .../{block/paride => ata/pata_parport}/epia.c |   0
 .../{block/paride => ata/pata_parport}/fit2.c |   0
 .../{block/paride => ata/pata_parport}/fit3.c |   0
 .../{block/paride => ata/pata_parport}/friq.c |   0
 .../{block/paride => ata/pata_parport}/frpw.c |   0
 .../{block/paride => ata/pata_parport}/kbic.c |   0
 .../{block/paride => ata/pata_parport}/ktti.c |   0
 .../{block/paride => ata/pata_parport}/on20.c |   0
 .../{block/paride => ata/pata_parport}/on26.c |   0
 .../paride => ata/pata_parport}/ppc6lnx.c     |   0
 drivers/block/Kconfig                         |   2 -
 drivers/block/paride/Kconfig                  | 213 ------------------
 drivers/block/paride/Makefile                 |  23 --
 23 files changed, 160 insertions(+), 240 deletions(-)
 create mode 100644 drivers/ata/pata_parport/Kconfig
 create mode 100644 drivers/ata/pata_parport/Makefile
 rename drivers/{block/paride => ata/pata_parport}/aten.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/bpck.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/bpck6.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/comm.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/dstr.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/epat.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/epia.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/fit2.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/fit3.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/friq.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/frpw.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/kbic.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/ktti.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/on20.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/on26.c (100%)
 rename drivers/{block/paride => ata/pata_parport}/ppc6lnx.c (100%)
 delete mode 100644 drivers/block/paride/Kconfig
 delete mode 100644 drivers/block/paride/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index f1365608bc8c..de8aa561c95c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
 obj-$(CONFIG_ZORRO)		+= zorro/
 obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
-obj-y		 		+= block/paride/
+obj-$(CONFIG_PATA_PARPORT)	+= ata/pata_parport/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a5a31ba34bd3..2fa9e66ba824 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1174,7 +1174,7 @@ config PATA_PARPORT
 	  Read <file:Documentation/admin-guide/blockdev/paride.rst> for more
 	  information.
 
-	  Use the old PARIDE protocol modules.
+source "drivers/ata/pata_parport/Kconfig"
 
 comment "Generic fallback / legacy drivers"
 
diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
new file mode 100644
index 000000000000..0893a13e7979
--- /dev/null
+++ b/drivers/ata/pata_parport/Kconfig
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0
+
+comment "Parallel IDE protocol modules"
+	depends on PATA_PARPORT
+
+config PATA_PARPORT_ATEN
+	tristate "ATEN EH-100 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the ATEN EH-100 parallel port IDE
+	  protocol. This protocol is used in some inexpensive low performance
+	  parallel port kits made in Hong Kong.
+
+config PATA_PARPORT_BPCK
+	tristate "MicroSolutions backpack (Series 5) protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the Micro Solutions BACKPACK
+	  parallel port Series 5 IDE protocol.  (Most BACKPACK drives made
+	  before 1999 were Series 5) Series 5 drives will NOT always have the
+	  Series noted on the bottom of the drive. Series 6 drivers will.
+
+	  In other words, if your BACKPACK drive doesn't say "Series 6" on the
+	  bottom, enable this option.
+
+config PATA_PARPORT_BPCK6
+	tristate "MicroSolutions backpack (Series 6) protocol"
+	depends on (PATA_PARPORT) && !64BIT
+	help
+	  This option enables support for the Micro Solutions BACKPACK
+	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
+	  after 1999 were Series 6) Series 6 drives will have the Series noted
+	  on the bottom of the drive.  Series 5 drivers don't always have it
+	  noted.
+
+	  In other words, if your BACKPACK drive says "Series 6" on the
+	  bottom, enable this option.
+
+config PATA_PARPORT_COMM
+	tristate "DataStor Commuter protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the Commuter parallel port IDE
+	  protocol from DataStor.
+
+config PATA_PARPORT_DSTR
+	tristate "DataStor EP-2000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the EP-2000 parallel port IDE
+	  protocol from DataStor
+
+config PATA_PARPORT_FIT2
+	tristate "FIT TD-2000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the TD-2000 parallel port IDE
+	  protocol from Fidelity International Technology. This is a simple
+	  (low speed) adapter that is used in some portable hard drives.
+
+config PATA_PARPORT_FIT3
+	tristate "FIT TD-3000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the TD-3000 parallel port IDE
+	  protocol from Fidelity International Technology. This protocol is
+	  used in newer models of their portable disk, CD-ROM and PD/CD
+	  devices.
+
+config PATA_PARPORT_EPAT
+	tristate "Shuttle EPAT/EPEZ protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the EPAT parallel port IDE protocol.
+	  EPAT is a parallel port IDE adapter manufactured by Shuttle
+	  Technology and widely used in devices from major vendors such as
+	  Hewlett-Packard, SyQuest, Imation and Avatar.
+
+config PATA_PARPORT_EPATC8
+	bool "Support c7/c8 chips"
+	depends on PATA_PARPORT_EPAT
+	help
+	  This option enables support for the newer Shuttle EP1284 (aka c7 and
+	  c8) chip. You need this if you are using any recent Imation SuperDisk
+	  (LS-120) drive.
+
+config PATA_PARPORT_EPIA
+	tristate "Shuttle EPIA protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the (obsolete) EPIA parallel port
+	  IDE protocol from Shuttle Technology. This adapter can still be
+	  found in some no-name kits.
+
+config PATA_PARPORT_FRIQ
+	tristate "Freecom IQ ASIC-2 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for version 2 of the Freecom IQ parallel
+	  port IDE adapter.  This adapter is used by the Maxell Superdisk
+	  drive.
+
+config PATA_PARPORT_FRPW
+	tristate "FreeCom power protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the Freecom power parallel port IDE
+	  protocol.
+
+config PATA_PARPORT_KBIC
+	tristate "KingByte KBIC-951A/971A protocols"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the KBIC-951A and KBIC-971A parallel
+	  port IDE protocols from KingByte Information Corp. KingByte's
+	  adapters appear in many no-name portable disk and CD-ROM products,
+	  especially in Europe.
+
+config PATA_PARPORT_KTTI
+	tristate "KT PHd protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the "PHd" parallel port IDE protocol
+	  from KT Technology. This is a simple (low speed) adapter that is
+	  used in some 2.5" portable hard drives.
+
+config PATA_PARPORT_ON20
+	tristate "OnSpec 90c20 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the (obsolete) 90c20 parallel port
+	  IDE protocol from OnSpec (often marketed under the ValuStore brand
+	  name).
+
+config PATA_PARPORT_ON26
+	tristate "OnSpec 90c26 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the 90c26 parallel port IDE protocol
+	  from OnSpec Electronics (often marketed under the ValuStore brand
+	  name).
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
new file mode 100644
index 000000000000..716727d4ff8b
--- /dev/null
+++ b/drivers/ata/pata_parport/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PATA_PARPORT_ATEN)	+= aten.o
+obj-$(CONFIG_PATA_PARPORT_BPCK)	+= bpck.o
+obj-$(CONFIG_PATA_PARPORT_COMM)	+= comm.o
+obj-$(CONFIG_PATA_PARPORT_DSTR)	+= dstr.o
+obj-$(CONFIG_PATA_PARPORT_KBIC)	+= kbic.o
+obj-$(CONFIG_PATA_PARPORT_EPAT)	+= epat.o
+obj-$(CONFIG_PATA_PARPORT_EPIA)	+= epia.o
+obj-$(CONFIG_PATA_PARPORT_FRPW)	+= frpw.o
+obj-$(CONFIG_PATA_PARPORT_FRIQ)	+= friq.o
+obj-$(CONFIG_PATA_PARPORT_FIT2)	+= fit2.o
+obj-$(CONFIG_PATA_PARPORT_FIT3)	+= fit3.o
+obj-$(CONFIG_PATA_PARPORT_ON20)	+= on20.o
+obj-$(CONFIG_PATA_PARPORT_ON26)	+= on26.o
+obj-$(CONFIG_PATA_PARPORT_KTTI)	+= ktti.o
+obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
diff --git a/drivers/block/paride/aten.c b/drivers/ata/pata_parport/aten.c
similarity index 100%
rename from drivers/block/paride/aten.c
rename to drivers/ata/pata_parport/aten.c
diff --git a/drivers/block/paride/bpck.c b/drivers/ata/pata_parport/bpck.c
similarity index 100%
rename from drivers/block/paride/bpck.c
rename to drivers/ata/pata_parport/bpck.c
diff --git a/drivers/block/paride/bpck6.c b/drivers/ata/pata_parport/bpck6.c
similarity index 100%
rename from drivers/block/paride/bpck6.c
rename to drivers/ata/pata_parport/bpck6.c
diff --git a/drivers/block/paride/comm.c b/drivers/ata/pata_parport/comm.c
similarity index 100%
rename from drivers/block/paride/comm.c
rename to drivers/ata/pata_parport/comm.c
diff --git a/drivers/block/paride/dstr.c b/drivers/ata/pata_parport/dstr.c
similarity index 100%
rename from drivers/block/paride/dstr.c
rename to drivers/ata/pata_parport/dstr.c
diff --git a/drivers/block/paride/epat.c b/drivers/ata/pata_parport/epat.c
similarity index 100%
rename from drivers/block/paride/epat.c
rename to drivers/ata/pata_parport/epat.c
diff --git a/drivers/block/paride/epia.c b/drivers/ata/pata_parport/epia.c
similarity index 100%
rename from drivers/block/paride/epia.c
rename to drivers/ata/pata_parport/epia.c
diff --git a/drivers/block/paride/fit2.c b/drivers/ata/pata_parport/fit2.c
similarity index 100%
rename from drivers/block/paride/fit2.c
rename to drivers/ata/pata_parport/fit2.c
diff --git a/drivers/block/paride/fit3.c b/drivers/ata/pata_parport/fit3.c
similarity index 100%
rename from drivers/block/paride/fit3.c
rename to drivers/ata/pata_parport/fit3.c
diff --git a/drivers/block/paride/friq.c b/drivers/ata/pata_parport/friq.c
similarity index 100%
rename from drivers/block/paride/friq.c
rename to drivers/ata/pata_parport/friq.c
diff --git a/drivers/block/paride/frpw.c b/drivers/ata/pata_parport/frpw.c
similarity index 100%
rename from drivers/block/paride/frpw.c
rename to drivers/ata/pata_parport/frpw.c
diff --git a/drivers/block/paride/kbic.c b/drivers/ata/pata_parport/kbic.c
similarity index 100%
rename from drivers/block/paride/kbic.c
rename to drivers/ata/pata_parport/kbic.c
diff --git a/drivers/block/paride/ktti.c b/drivers/ata/pata_parport/ktti.c
similarity index 100%
rename from drivers/block/paride/ktti.c
rename to drivers/ata/pata_parport/ktti.c
diff --git a/drivers/block/paride/on20.c b/drivers/ata/pata_parport/on20.c
similarity index 100%
rename from drivers/block/paride/on20.c
rename to drivers/ata/pata_parport/on20.c
diff --git a/drivers/block/paride/on26.c b/drivers/ata/pata_parport/on26.c
similarity index 100%
rename from drivers/block/paride/on26.c
rename to drivers/ata/pata_parport/on26.c
diff --git a/drivers/block/paride/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
similarity index 100%
rename from drivers/block/paride/ppc6lnx.c
rename to drivers/ata/pata_parport/ppc6lnx.c
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 71c9c6e3c07a..89d5cca82f00 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -103,8 +103,6 @@ config GDROM
 	  Most users will want to say "Y" here.
 	  You can also build this as a module which will be called gdrom.
 
-source "drivers/block/paride/Kconfig"
-
 source "drivers/block/mtip32xx/Kconfig"
 
 source "drivers/block/zram/Kconfig"
diff --git a/drivers/block/paride/Kconfig b/drivers/block/paride/Kconfig
deleted file mode 100644
index 19310be860b2..000000000000
--- a/drivers/block/paride/Kconfig
+++ /dev/null
@@ -1,213 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# PARIDE configuration
-
-comment "Parallel IDE protocol modules"
-	depends on PATA_PARPORT
-
-config PARIDE_ATEN
-	tristate "ATEN EH-100 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the ATEN EH-100 parallel port IDE
-	  protocol. This protocol is used in some inexpensive low performance
-	  parallel port kits made in Hong Kong. If you chose to build PARIDE
-	  support into your kernel, you may answer Y here to build in the
-	  protocol driver, otherwise you should answer M to build it as a
-	  loadable module. The module will be called aten. You must also
-	  have a high-level driver for the type of device that you want to
-	  support.
-
-config PARIDE_BPCK
-	tristate "MicroSolutions backpack (Series 5) protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the Micro Solutions BACKPACK
-	  parallel port Series 5 IDE protocol.  (Most BACKPACK drives made
-	  before 1999 were Series 5) Series 5 drives will NOT always have the
-	  Series noted on the bottom of the drive. Series 6 drivers will.
-
-	  In other words, if your BACKPACK drive doesn't say "Series 6" on the
-	  bottom, enable this option.
-
-	  If you chose to build PARIDE support into your kernel, you may
-	  answer Y here to build in the protocol driver, otherwise you should
-	  answer M to build it as a loadable module.  The module will be
-	  called bpck.  You must also have a high-level driver for the type
-	  of device that you want to support.
-
-config PARIDE_BPCK6
-	tristate "MicroSolutions backpack (Series 6) protocol"
-	depends on (PATA_PARPORT) && !64BIT
-	help
-	  This option enables support for the Micro Solutions BACKPACK
-	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
-	  after 1999 were Series 6) Series 6 drives will have the Series noted
-	  on the bottom of the drive.  Series 5 drivers don't always have it
-	  noted.
-
-	  In other words, if your BACKPACK drive says "Series 6" on the
-	  bottom, enable this option.
-
-	  If you chose to build PARIDE support into your kernel, you may
-	  answer Y here to build in the protocol driver, otherwise you should
-	  answer M to build it as a loadable module.  The module will be
-	  called bpck6.  You must also have a high-level driver for the type
-	  of device that you want to support.
-
-config PARIDE_COMM
-	tristate "DataStor Commuter protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the Commuter parallel port IDE
-	  protocol from DataStor. If you chose to build PARIDE support
-	  into your kernel, you may answer Y here to build in the protocol
-	  driver, otherwise you should answer M to build it as a loadable
-	  module. The module will be called comm. You must also have
-	  a high-level driver for the type of device that you want to support.
-
-config PARIDE_DSTR
-	tristate "DataStor EP-2000 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the EP-2000 parallel port IDE
-	  protocol from DataStor. If you chose to build PARIDE support
-	  into your kernel, you may answer Y here to build in the protocol
-	  driver, otherwise you should answer M to build it as a loadable
-	  module. The module will be called dstr. You must also have
-	  a high-level driver for the type of device that you want to support.
-
-config PARIDE_FIT2
-	tristate "FIT TD-2000 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the TD-2000 parallel port IDE
-	  protocol from Fidelity International Technology. This is a simple
-	  (low speed) adapter that is used in some portable hard drives. If
-	  you chose to build PARIDE support into your kernel, you may answer Y
-	  here to build in the protocol driver, otherwise you should answer M
-	  to build it as a loadable module. The module will be called ktti.
-	  You must also have a high-level driver for the type of device that
-	  you want to support.
-
-config PARIDE_FIT3
-	tristate "FIT TD-3000 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the TD-3000 parallel port IDE
-	  protocol from Fidelity International Technology. This protocol is
-	  used in newer models of their portable disk, CD-ROM and PD/CD
-	  devices. If you chose to build PARIDE support into your kernel, you
-	  may answer Y here to build in the protocol driver, otherwise you
-	  should answer M to build it as a loadable module. The module will be
-	  called fit3. You must also have a high-level driver for the type
-	  of device that you want to support.
-
-config PARIDE_EPAT
-	tristate "Shuttle EPAT/EPEZ protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the EPAT parallel port IDE protocol.
-	  EPAT is a parallel port IDE adapter manufactured by Shuttle
-	  Technology and widely used in devices from major vendors such as
-	  Hewlett-Packard, SyQuest, Imation and Avatar. If you chose to build
-	  PARIDE support into your kernel, you may answer Y here to build in
-	  the protocol driver, otherwise you should answer M to build it as a
-	  loadable module. The module will be called epat. You must also
-	  have a high-level driver for the type of device that you want to
-	  support.
-
-config PARIDE_EPATC8
-	bool "Support c7/c8 chips"
-	depends on PARIDE_EPAT
-	help
-	  This option enables support for the newer Shuttle EP1284 (aka c7 and
-	  c8) chip. You need this if you are using any recent Imation SuperDisk
-	  (LS-120) drive.
-
-config PARIDE_EPIA
-	tristate "Shuttle EPIA protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the (obsolete) EPIA parallel port
-	  IDE protocol from Shuttle Technology. This adapter can still be
-	  found in some no-name kits. If you chose to build PARIDE support
-	  into your kernel, you may answer Y here to build in the protocol
-	  driver, otherwise you should answer M to build it as a loadable
-	  module. The module will be called epia. You must also have a
-	  high-level driver for the type of device that you want to support.
-
-config PARIDE_FRIQ
-	tristate "Freecom IQ ASIC-2 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for version 2 of the Freecom IQ parallel
-	  port IDE adapter.  This adapter is used by the Maxell Superdisk
-	  drive.  If you chose to build PARIDE support into your kernel, you
-	  may answer Y here to build in the protocol driver, otherwise you
-	  should answer M to build it as a loadable module. The module will be
-	  called friq. You must also have a high-level driver for the type
-	  of device that you want to support.
-
-config PARIDE_FRPW
-	tristate "FreeCom power protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the Freecom power parallel port IDE
-	  protocol. If you chose to build PARIDE support into your kernel, you
-	  may answer Y here to build in the protocol driver, otherwise you
-	  should answer M to build it as a loadable module. The module will be
-	  called frpw. You must also have a high-level driver for the type
-	  of device that you want to support.
-
-config PARIDE_KBIC
-	tristate "KingByte KBIC-951A/971A protocols"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the KBIC-951A and KBIC-971A parallel
-	  port IDE protocols from KingByte Information Corp. KingByte's
-	  adapters appear in many no-name portable disk and CD-ROM products,
-	  especially in Europe. If you chose to build PARIDE support into your
-	  kernel, you may answer Y here to build in the protocol driver,
-	  otherwise you should answer M to build it as a loadable module. The
-	  module will be called kbic. You must also have a high-level driver
-	  for the type of device that you want to support.
-
-config PARIDE_KTTI
-	tristate "KT PHd protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the "PHd" parallel port IDE protocol
-	  from KT Technology. This is a simple (low speed) adapter that is
-	  used in some 2.5" portable hard drives. If you chose to build PARIDE
-	  support into your kernel, you may answer Y here to build in the
-	  protocol driver, otherwise you should answer M to build it as a
-	  loadable module. The module will be called ktti. You must also
-	  have a high-level driver for the type of device that you want to
-	  support.
-
-config PARIDE_ON20
-	tristate "OnSpec 90c20 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the (obsolete) 90c20 parallel port
-	  IDE protocol from OnSpec (often marketed under the ValuStore brand
-	  name). If you chose to build PARIDE support into your kernel, you
-	  may answer Y here to build in the protocol driver, otherwise you
-	  should answer M to build it as a loadable module. The module will
-	  be called on20. You must also have a high-level driver for the
-	  type of device that you want to support.
-
-config PARIDE_ON26
-	tristate "OnSpec 90c26 protocol"
-	depends on PATA_PARPORT
-	help
-	  This option enables support for the 90c26 parallel port IDE protocol
-	  from OnSpec Electronics (often marketed under the ValuStore brand
-	  name). If you chose to build PARIDE support into your kernel, you
-	  may answer Y here to build in the protocol driver, otherwise you
-	  should answer M to build it as a loadable module. The module will be
-	  called on26. You must also have a high-level driver for the type
-	  of device that you want to support.
-
-#
diff --git a/drivers/block/paride/Makefile b/drivers/block/paride/Makefile
deleted file mode 100644
index cdf54a27b0e7..000000000000
--- a/drivers/block/paride/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for Parallel port IDE device drivers.
-#
-# 7 October 2000, Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
-# Rewritten to use lists instead of if-statements.
-#
-
-obj-$(CONFIG_PARIDE_ATEN)	+= aten.o
-obj-$(CONFIG_PARIDE_BPCK)	+= bpck.o
-obj-$(CONFIG_PARIDE_COMM)	+= comm.o
-obj-$(CONFIG_PARIDE_DSTR)	+= dstr.o
-obj-$(CONFIG_PARIDE_KBIC)	+= kbic.o
-obj-$(CONFIG_PARIDE_EPAT)	+= epat.o
-obj-$(CONFIG_PARIDE_EPIA)	+= epia.o
-obj-$(CONFIG_PARIDE_FRPW)	+= frpw.o
-obj-$(CONFIG_PARIDE_FRIQ)	+= friq.o
-obj-$(CONFIG_PARIDE_FIT2)	+= fit2.o
-obj-$(CONFIG_PARIDE_FIT3)	+= fit3.o
-obj-$(CONFIG_PARIDE_ON20)	+= on20.o
-obj-$(CONFIG_PARIDE_ON26)	+= on26.o
-obj-$(CONFIG_PARIDE_KTTI)	+= ktti.o
-obj-$(CONFIG_PARIDE_BPCK6)	+= bpck6.o
-- 
Ondrej Zary

