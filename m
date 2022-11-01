Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F8614F32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKAQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKAQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:29:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD771C900
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667320155; bh=hpyKnFMfRY+QUzSkXdnEo0r31KZTp9ZrAIAHMs9/vko=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TwfpfvlcbX/NGrufGPnMVzdfHxCc1ipIT76/hDpprpXXZYGOD8DRJDcGHzf6IzCjC
         UEN7w9VTDPRWpdLqlGQMPI6tYbZvdXRszABwyRSAYVbd3GD0AeaZe9ahLmbJd13c57
         QMiQwv17Z6gkpaJv2CrbOs+Lvt9zgJDEv0bPywpZOxpRtKRKD6ZtCOrYhRzZEdORKh
         alrsvtOOpxPmlP+nTyx7V+g1YYpg+/LRirMIWSTHqFRJVa/c3ovBVLW5GOp4MyptJx
         jmx8s6Y5KaEOiq3qk5eWSARdN1lBcrrOoxyPfJmddKW5gD0oQei2Dm38W/XMPYrvbi
         2F2D7m/B8AR4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1pSoOC1LgN-00dYwf; Tue, 01
 Nov 2022 17:29:15 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: Fix formatting in spi_nor_read_raw() kerneldoc comment
Date:   Tue,  1 Nov 2022 17:29:06 +0100
Message-Id: <20221101162906.990125-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:im/36SfJT8JE/0h9h9COAAR5cpMlNHDMDFoI5ouejQkwysdwYAU
 C+WEMsKg7YileVZYKf5oFqCSIt2A8JS0Nr61SQRkFCWV4iulXNgvN2E16Xw/VO+v0VVvZjI
 Y4+xCStrtF0MitTvIx71VD+bwK/25D70k5QRibPgoTxtdcMSj1gImcOVhquKcKFVZGlsJaE
 WfU/u/9ehekV+2ij3keIg==
UI-OutboundReport: notjunk:1;M01:P0:XKGDViQ55uY=;dNARUL20UtjzgjPPFkB79uGecoi
 qY92ZpKzo31oPHwJrOwRqYOC7CknyRZu9OP+Fa6bzaxofyParDofUaGr8IANzJYN8I2jUVGAe
 FEr+BQJiScLVfrqO2++laIMwndkkBJ3UI0/uHmIV/kT8hwnm+L6D8VsyPOlZm7nLC2xuTrgpT
 8/EmuFOfG37FSaaxtXQiCufrjoz4JSMLtHzHqIO29sEZuP8K8Et3lS7R/FMz1hVPhy9jEbCo7
 ScwbNaZ4fNpSRwimOGJlEFHznrQd/L5erUstbta/rHxa0ZAmj9GOwv/w3aiw184/ePR2bodZP
 HB/qmdwhpUIW+o/wlh0Q4p29s922AR6KBxLxN579HURBE68gzUZbWnG+wWO4xIyOm5xLgo/tc
 2p86WLGyxnpIhXbCqS/MILbqWdJ0FAhRqj3dN2fmDmmlg1wufHP0U3cPDYiNHKD9avcxnYlIB
 dnUBxpVK9qXdJ4evbLtdmHIwHUDKLgROz6MIz0vKWtP9ncnUPahUpEpCkei/jnCl1i9kWIGUY
 SniIvd78rCugTe1znKAyx6I9mnBiAPN1UoDn2Neao3xmlQPtQuvjJ3akERmhoBHsS4rpVBbII
 7+qfHQwjZsjBCVDRgLPpPaeztfdUWmWBwWIEoUl3S27Eo4w/gP/YnVZTfWlAYUY4asrJPHqJo
 YVlJjDXxOY/M5IaUF1WSb0sOkRo5TCXh7vpJfd8luz83gASOoBJOuKPVuMdgtURIdptQiH3Iv
 HcgdQ+uPv2+4wycNwmk7KKKvN/Xrt/f2C0v9ZNIs3UePsyudXVKHXEQ6KJUM8SzCGwcXOujJ7
 y0wgJdHt/g/9TZe9mA2naAPlkw4QzIdfu5Mfq7f6Iuk2/TukcKaMgBwc4fXb3QUD7J8XRxmOB
 tvIL+MS1g/Ay+y1UKaHgU9dLlVjz0KAFoMtefAb0xnur68cGVT1Xy96isbt2IH8VsEG3rKkOP
 IF6Fvg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to put "set" on its own line like that.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mtd/spi-nor/sfdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 2257f1b4c2e2d..3e0bb383ab8e2 100644
=2D-- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -135,8 +135,7 @@ struct sfdp_4bait {
 /**
  * spi_nor_read_raw() - raw read of serial flash memory. read_opcode,
  *			addr_nbytes and read_dummy members of the struct spi_nor
- *			should be previously
- * set.
+ *			should be previously set.
  * @nor:	pointer to a 'struct spi_nor'
  * @addr:	offset in the serial flash memory
  * @len:	number of bytes to read
=2D-
2.35.1

