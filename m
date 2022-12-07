Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410CD645EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiLGQZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLGQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:25:26 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A86721F;
        Wed,  7 Dec 2022 08:25:09 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id ED7324000A;
        Wed,  7 Dec 2022 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670430308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVVPGGJ5wD/Pxteagqvg58bV2zwW32bCcfFwOUVXpsY=;
        b=InaD6Obosh7+P5c7PmHRZXVJ/tICh/b190U+1Cz1Th3q970arZlVnX0Q05skh4RU5L3vXj
        270vVj8yxI/OJg0CrjVu+medqAIrKDRnJmOoy+zQckqWW0lO4EVCRKeUWlKjOL+ARqsIZz
        oeBjFghpSJ7vsV3g9GtwEOytDP/BtGHrJy78rgD0rcMWLoRq3fs6dEYCnt/aEqMacA/K3r
        A4B+IiIDge5oFBFmAVmPXCjbU83QMJvg8yEzFfzOvfcPZyv0w3rFL2GCb1Yqh3Pdy4VaQ9
        0ahsix94J6YNsgpXwv2VJ4SNk/3sai6KnAMNF5jy/TeUK9ujKrnoHc5lNgw36A==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 9/9] MAINTAINERS: add the Renesas RZ/N1 USBF controller entry
Date:   Wed,  7 Dec 2022 17:24:35 +0100
Message-Id: <20221207162435.1001782-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207162435.1001782-1-herve.codina@bootlin.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After contributing the driver, add myself as the maintainer
for Renesas RZ/N1 USBF controller.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1daadaa4d48b..5bf800b4e166 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17632,6 +17632,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
 F:	drivers/rtc/rtc-rzn1.c
 
+RENESAS RZ/N1 USBF CONTROLLER DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linux-renesas-soc@vger.kernel.org
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
+F:	drivers/usb/gadget/udc/renesas_usbf.c
+
 RENESAS R-CAR GEN3 & RZ/N1 NAND CONTROLLER DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.38.1

