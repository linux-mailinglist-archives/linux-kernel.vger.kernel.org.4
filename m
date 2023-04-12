Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1006DFDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDLSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDLSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:40:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E42213F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681324719; i=j.neuschaefer@gmx.net;
        bh=XeBl/5t7UZ4TzAdwmZ2UA9/ZarMbW1PhJCcszk78i7Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IpRg05YIvJHeh07PN8Avj8t7QEq2MU3GKGBCw3nuz6n6L8Ievk/mG5ut5CqQBY+gw
         Zvck9S6R9tihKQpI/CD38CEeidH1JjEXRHD5CguKMAXnu+iNQZDw9rg4L7nAtydOFt
         DzJzHShf44rSyG9sC4reMFN6D7IN+CYWAYLQqX3xvQB4VC6NWozHU4W5OVRkScRlaP
         XfnGe/mNPboC7xOGOHD+IhXtNyLTueJ8xi5NOAi0YV/eTrn0Gs9gvRMLtrbivyNpOA
         gpgWwyQJPkarNCL9egWFlP+r/ReTSbZuYJrIavGySetP9Ryvz+5fAVw5jApEf8+NWa
         AOvkERRmtWwhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1pfTHg3b2o-00BbAY; Wed, 12
 Apr 2023 20:38:38 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
Date:   Wed, 12 Apr 2023 20:38:32 +0200
Message-Id: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0euLrYO+TWx5yPIpbwwSG/oxIf0i/WtN/pDJPApWgfXg7uSArUC
 viSBsOw/okp8bGMeD3UBPwh5K1fsreKnKbLM2mcadU8mCXpg0j51ze2RTmXf5N/6rZphiap
 KwXCZSM9GGM9cCyzZUGR6zaEcvyfsVOFtNk6p2WGHeADyyZxCtewnD2usYA3HFQBLvpwAcq
 2Is66ujuiCaww7S3ek9MQ==
UI-OutboundReport: notjunk:1;M01:P0:DR9xuAogX4I=;e8gm7IicEqO7J0c70S24MaL03FZ
 G4JTn+Ge3KjUvL5LdrBWsvpAJ3mlUzXD2Qr5CuKj2/8gcudZmRNh6YkzhWhJz37jG7ZBdWfSM
 yVo2/7GthY9CrbbVV0hvAXuoslBUEVF0BfEsuWCiooFyJRQsSrUeJ8C51cV0DUx+uiOwVbo25
 j+kZUk9wxsnQPx7BvkpmFP5awHoZZw7b4ca5mhLsPw/gOiaPdK4AsEGaVJktk42yCQJbwbu1i
 tAL3g8AzKRRjmBXIcsKkfdsp4iK3llDaFjJslUWdytnJWsl9yy8qXEQkcz7S8WOz5BxJuDcEQ
 rartVO1eKj4t2fvu16rZ2SKiWQ2ICVG9bz0nQNnQIDYUChhID3ag1A/SvEm4dgj4tfl0Plj+x
 dVT5rDxdrcfYVGcTPWfVrTrsTDk/f91MU9NScK+GScAJx2+mEr3EuvNV18oNiwbhocf3x69Q5
 mBHv/kFOw3QoeM4BaoMkf9aM9IyGeMFkx8MLAzxL8X5I48+OTUIkSZt9kcCPuv0O67leIKtSI
 h0lNcSBdo0jrtD+ar960+dO+MBd5S/5bf3JOuJBES2eBbjSI7AlL3pyNMWxFYOddCsjJC0Yce
 old31B3cr2SMGrpcE8sbv5FTDsgIeRBi+0rb4OG0VtydrVvw7Z7u3M5UtxVycyF9jz03aSpuw
 pAqTWsmfgRtfD65mZh5TAmbkomQUHEv41tazCBfw109pLGopo5zFiXpmUjlsWZkfIOhGh/sz1
 gvLPY3KIs5naGXKb8Br+K/UKm+NIArzZcPdLBZtlHjHYgOZlLJx4ym4bAEQSAGUO2oDHMEAsO
 W6viRJWAX2n4TDOJOeuKlyeZ+Lb+w557lmxOMcbG4Kyq3U8CKAghwpd+K/h2cPMojrtNUP4y6
 5Iwyu4IpybGd1pSUS8R9UndvrnWacn50UP0DCi+lHlj3jfkYvTOzq4GdLravBOm83mF/KBTBy
 4SPfjXViDFICbfcR/bpSFGOoEAs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
driver when configuring a kernel without support for Nuvoton SoCs.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ=
5u+4Q8c7-wYQ@mail.gmail.com/
Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v3:
- Split the commit into two
- Reword the commit messages a bit

v2:
- https://lore.kernel.org/lkml/20230212215234.2608565-1-j.neuschaefer@gmx.=
net/
- Commit message improvements, as suggested by Geert Uytterhoeven.
- Add Link after Reviewed-by, as checkpatch.pl now suggests
=2D--
 drivers/soc/nuvoton/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index df46182088ec2..853392c8a9151 100644
=2D-- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig WPCM450_SOC
+menu "Nuvoton SoC drivers"
+	depends on ARCH_NPCM || COMPILE_TEST
+
+config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
@@ -9,3 +12,5 @@ menuconfig WPCM450_SOC

 	  This driver provides information such as the SoC model and
 	  revision.
+
+endmenu
=2D-
2.39.2

