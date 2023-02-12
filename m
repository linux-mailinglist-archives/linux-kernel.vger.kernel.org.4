Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F8693A50
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBLVxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBLVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:53:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB5EFB0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 13:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1676238768; bh=KhlXxGweVh+Ir5PG88PTEmiZLUcrwXaCiezH0mbqr0U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FjHfJmu9HRghHNWByh31Rn7pdpolVWQKRyjNfKuZK0FzuM2QVj4z1FUcvPyrbdOCv
         ijTJx2cHJbBbYxedycnGYMstpQgQ3vuvwe7bFQGwPhdRRnZalRsK0GZAjqdm3z1usW
         xzlmEUPf0A/Ga5MzrX8xEe0+pfpY4tGU4N2q7vG1aoJMHAZthtdjShqNoV9NUGZNtt
         l9d2WgunVdWxIJm5n4UXhh9Nm6kU0bZpKVQ68VsC5R75tPq8JtwAXJx7LZQWoVpipm
         P+bh5s+8HOBv+RkKfUc5O3zS8MPdPsCapBlIPjgLZKu7tHR8VGLvf2r1OjMLVLH08T
         80KqZFyIimwpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1oyI7V3Qog-00fWHx; Sun, 12
 Feb 2023 22:52:47 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: nuvoton: Fix Kconfig
Date:   Sun, 12 Feb 2023 22:52:31 +0100
Message-Id: <20230212215234.2608565-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e4yzc1meWECvQDbL1MGCjl5SLxQELkgTkQl50KXSTujchjAMPGE
 K1/3TWYIEA3V4Gt3xrdLB1LMTbeiGlVWvimEeOWRQBztopsq3P57N93DHnnRRNPDECQhvWd
 dOAIIWZSp22EBRavrovtdDuq2GrA6fTlUUIzE83I+qkFZCbfNKVhqqBf4JD8PuV453sTuDe
 OKVrz2tTCTkt4Gb2jOaOQ==
UI-OutboundReport: notjunk:1;M01:P0:tzuN0GfOMi0=;GHXMDF8kjktfW+NYRAfeP2e+aMT
 fKcgjj/hr3ATI5rQwt0zzh9eW5ffuaV6LzgJOXyrr+U783H7W9gjt0CyVHhV/NOjYJrauSQuV
 zFh+3JgQ+i7s7ZY8Smvs5THXQRt6btkolTRz9orkEnscwmcFaDtwZxp1e5IY2xhl96gzBcYuX
 /KGeOjXOWeQ9U4BBnJaTPIJsn3JA2k/zUi0f68VQiGHv27qecXjAXCeEPQQ0EjN43Yj0TTtHk
 t8F8rwuXV7CQHzZGp3q6G7eM76f9QQ35SLC3187Tu31mME+/3v8OD2tVS+MW+Idseb2ZPOCJz
 AY0uz3DYAHvauuk8JrzTXyQKFwgYGPt4ipCqTaTh44CJ7Fjhj8eN23hwNpN5R2eYCU/R6SvaH
 dzXNJZUGcMkxXw+/wPAaM36g/bruNhkAM4JoQi/pEpJ89OXv16niahC87iKFrFPWZL+rsr08y
 jbrEZhg58gAktW9HQloZq/qyQEZkRFKnyNpaLiunuEcbNg8s55X2TBt5J+dAC76uJ3T5+VqXV
 xIlSnFkkVe9mw5LsxPTuaBvzbHQr9bsUagiYsH9gE4J2BxhuXJUAMAvrEKcY9hM+b4DM1JkL3
 kEhvTq3WIrOZcHfPkWm+KZp109ZkM5dndmIS4Uz6iOX7s5VsxkzSHwggnAQuRMShaEJDedoNY
 W9MS92f1Lwv0/gtGDo5gxaNfz1EDGQSjStXMYWI8dF6H5HUUA2dLlY6X1FCPRkZfkCiMtZcmH
 vTp6SVABiovUDaQMHfUNpMOcOuoj5sNdIVlmWHL0iTX4lRHWpZQvSMfdSkL5zO8yVxJ4dJ3Sg
 aTQynOm9+UHD5NCHrIDnATljFtHmwGJQc6hF370Rjc4tZfLRO1QhiCrYP6ErdWxsYbr4xGEGT
 TavntpTT5DsdBRBZcOBYSgs6UThRLCTBn7p8Bu5jY/H8jGr91jbiuqaC9DAAYLF0OOSDdbxgk
 Pypjtnn3C8K4nULlFmmu2cMEEi0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, version 5 of the Nuvoton WPCM450 SoC driver was applied
to bmc.git, which misses a few fixes that were in version 6.

This patch adds the missing fixes:

 - Add a menu "Nuvoton SoC drivers" to make it easier to add other
   Nuvoton SoC drivers later on and to prevent asking about the Nuvoton
   WPCM450 SoC driver when configuring a kernel without support for
   Nuvoton SoCs.
 - Select CONFIG_REGMAP from CONFIG_WPCM450_SOC, because the driver
   relies on regmap to work.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ=
5u+4Q8c7-wYQ@mail.gmail.com/
Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Commit message improvements, as suggested by Geert Uytterhoeven.
- Add Link after Reviewed-by, as checkpatch.pl now suggests
=2D--
 drivers/soc/nuvoton/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index df46182088ec2..2167d3d739d84 100644
=2D-- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -1,11 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig WPCM450_SOC
+menu "Nuvoton SoC drivers"
+	depends on ARCH_NPCM || COMPILE_TEST
+
+config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
+	select REGMAP
 	help
 	  Say Y here to compile the SoC information driver for Nuvoton
 	  WPCM450 SoCs.

 	  This driver provides information such as the SoC model and
 	  revision.
+
+endmenu
=2D-
2.39.1

