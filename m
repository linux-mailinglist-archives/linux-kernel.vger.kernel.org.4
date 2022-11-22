Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B372F633F25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiKVOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiKVOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:41:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195286B21D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:41:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B95F21F85D;
        Tue, 22 Nov 2022 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669128095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LmN1hwBs4+4uTRkpp4eNPSMHGUAlw5RApBOUSqclOpE=;
        b=cJv41sKF6Vg9wsPD41beCiNeYxTaW11IO3hDU5UrYISuaUr42uKJqjZxNlmWnnSrdyMrhz
        jrpQGqM1U7GifY2v4h69cgGWfx08c4i9DfpmDe/8vicjzpAsIPdUTURgICFEIBggBPLXvm
        5wD/a6iaEm4MJ5gr1jOeK0kAFWYr9cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669128095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LmN1hwBs4+4uTRkpp4eNPSMHGUAlw5RApBOUSqclOpE=;
        b=J5Zo1Tta+a6RkSwZizIk9ZqKU3vBjVfZkGzOmoALJBGsReW2wnfy87ABaGYhPWLKRaSwJW
        x9TfPawEZ+9KN3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 708B213AA1;
        Tue, 22 Nov 2022 14:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iknKGZ/ffGMFegAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 22 Nov 2022 14:41:35 +0000
Date:   Tue, 22 Nov 2022 15:41:34 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        "Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?=" <j.neuschaefer@gmx.net>
Subject: [PATCH] mfd: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221122154134.58a7a18b@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

As a minor optimization, this also lets us drop of_match_ptr(), as we
now know what it will resolve to, we might as well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Lee Jones <lee@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Jonathan Neusch=C3=A4fer" <j.neuschaefer@gmx.net>
---
 drivers/mfd/Kconfig          |   16 ++++++++--------
 drivers/mfd/motorola-cpcap.c |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-6.0.orig/drivers/mfd/Kconfig
+++ linux-6.0/drivers/mfd/Kconfig
@@ -794,7 +794,7 @@ config MFD_MAX14577
 config MFD_MAX77620
 	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
 	depends on I2C=3Dy
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
@@ -809,7 +809,7 @@ config MFD_MAX77620
 config MFD_MAX77650
 	tristate "Maxim MAX77650/77651 PMIC Support"
 	depends on I2C
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
@@ -824,7 +824,7 @@ config MFD_MAX77650
 config MFD_MAX77686
 	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
 	depends on I2C
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
@@ -853,7 +853,7 @@ config MFD_MAX77693
 config MFD_MAX77714
 	tristate "Maxim Semiconductor MAX77714 PMIC Support"
 	depends on I2C
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
 	help
@@ -973,7 +973,7 @@ config EZX_PCAP
 config MFD_CPCAP
 	tristate "Support for Motorola CPCAP"
 	depends on SPI
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_SPI
 	select REGMAP_IRQ
@@ -998,7 +998,7 @@ config MFD_VIPERBOARD
=20
 config MFD_NTXEC
 	tristate "Netronix embedded controller (EC)"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on I2C
 	select REGMAP_I2C
 	select MFD_CORE
@@ -1172,7 +1172,7 @@ config MFD_RN5T618
 config MFD_SEC_CORE
 	tristate "Samsung Electronics PMIC Series Support"
 	depends on I2C=3Dy
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
@@ -2018,7 +2018,7 @@ config MFD_STPMIC1
 config MFD_STMFX
 	tristate "Support for STMicroelectronics Multi-Function eXpander (STMFX)"
 	depends on I2C
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
 	help
--- linux-6.0.orig/drivers/mfd/motorola-cpcap.c
+++ linux-6.0/drivers/mfd/motorola-cpcap.c
@@ -296,7 +296,7 @@ static int cpcap_probe(struct spi_device
 	struct cpcap_ddata *cpcap;
 	int ret;
=20
-	match =3D of_match_device(of_match_ptr(cpcap_of_match), &spi->dev);
+	match =3D of_match_device(cpcap_of_match, &spi->dev);
 	if (!match)
 		return -ENODEV;
=20

--=20
Jean Delvare
SUSE L3 Support
