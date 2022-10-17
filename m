Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD43601595
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJQRmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJQRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:42:41 -0400
X-Greylist: delayed 1506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 10:42:39 PDT
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E2F59E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:42:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 834729C073E;
        Mon, 17 Oct 2022 13:17:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zYB__H4skXMQ; Mon, 17 Oct 2022 13:17:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id C6C549C0792;
        Mon, 17 Oct 2022 13:17:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C6C549C0792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1666027051; bh=+Luzp+iknKkqQ49XgkNP2jOmFoImMb0zKegv/sjKa54=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=HSoeX+FeokVumyCHYEkqYIkkcveLB7hluGAi65nWqARnw2TtTnckcaz13J4ibiDsP
         2jLNaXf485QQaRPmNQUvGUa/InT0UGuGNzY7bXfb7YQT5vLONvmzWEji5DsYfJxkG9
         Hyjtk8QtOEhe32SS5GpaH4wQrtp/uF4Tw/Vp/wTf525HwscLNKGdpIZYgb5SlW5yLm
         7eOIiV56jpDDLzRM89dxRejMdJCey4178b7CASSQW3BLttXnxM+zDsqzd2AhtebPD1
         EViRBjiZ7RR7JwVBDIA8hn+pqyKz76POb7ikz6qtggYiD+7W2AiL43nQI0l+9VrY1f
         6HZKfpnQEcBgA==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vMY64oYDEsFt; Mon, 17 Oct 2022 13:17:31 -0400 (EDT)
Received: from barbarian.mtl.sfl (unknown [192.168.51.254])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 975FC9C073E;
        Mon, 17 Oct 2022 13:17:31 -0400 (EDT)
From:   Firas Ashkar <firas.ashkar@savoirfairelinux.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        alex@digriz.org.uk,
        Firas Ashkar <firas.ashkar@savoirfairelinux.com>
Subject: [PATCH] ARM: orion5x: add new FPGA ID
Date:   Mon, 17 Oct 2022 13:17:23 -0400
Message-Id: <20221017171723.1639558-1-firas.ashkar@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add new EmbeddedTS FPGA revision id, suppressing related boot time warnin=
g
message.

$ dmesg
Booting Linux on physical CPU 0x0
Linux version 6.1.0-rc1 (fashkar@barbarian) \
 (arm-buildroot-linux-gnueabi-gcc.br_real 10.3.0, \
 GNU ld (GNU Binutils) 2.36.1) #2 PREEMPT Mon Oct 17 12:04:27 EDT 2022
CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=3Db005317f
CPU: VIVT data cache, VIVT instruction cache
Machine: Technologic Systems TS-78xx SBC

...

DMA: preallocated 256 KiB pool for atomic coherent allocations
Orion ID: MV88F5182-A2. TCLK=3D166666667.
initial MPP regs:
 00000000
 00000000
 03ff0000

  final MPP regs:
 00000003
 00000000
 03ff0000

ts78xx_setup: FPGA magic=3D0x00b480, rev=3D0x0b

...
$

Signed-off-by: Firas Ashkar <firas.ashkar@savoirfairelinux.com>
---
:100644 100644 2f4fe3ca5c1a 466e2a4cd6f7 M	arch/arm/mach-orion5x/ts78xx-f=
pga.h
:100644 100644 af810e7ccd79 0f619b1bbc52 M	arch/arm/mach-orion5x/ts78xx-s=
etup.c
 arch/arm/mach-orion5x/ts78xx-fpga.h  | 1 +
 arch/arm/mach-orion5x/ts78xx-setup.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/=
ts78xx-fpga.h
index 2f4fe3ca5c1a..466e2a4cd6f7 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -17,6 +17,7 @@ enum fpga_ids {
 	TS7800_REV_7	=3D FPGAID(TS7800_FPGA_MAGIC, 0x07),
 	TS7800_REV_8	=3D FPGAID(TS7800_FPGA_MAGIC, 0x08),
 	TS7800_REV_9	=3D FPGAID(TS7800_FPGA_MAGIC, 0x09),
+	TS7800_REV_11	=3D FPGAID(TS7800_FPGA_MAGIC, 0x0b),
=20
 	/* Unaffordable & Expensive */
 	UAE_DUMMY	=3D FPGAID(0xffffff, 0x01),
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x=
/ts78xx-setup.c
index af810e7ccd79..0f619b1bbc52 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -345,6 +345,7 @@ static void ts78xx_fpga_supports(void)
 	case TS7800_REV_7:
 	case TS7800_REV_8:
 	case TS7800_REV_9:
+	case TS7800_REV_11:
 		ts78xx_fpga.supports.ts_rtc.present =3D 1;
 		ts78xx_fpga.supports.ts_nand.present =3D 1;
 		ts78xx_fpga.supports.ts_rng.present =3D 1;
--=20
2.34.1

