Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0665F004
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjAEPX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjAEPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:23:33 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448FE288;
        Thu,  5 Jan 2023 07:23:32 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 26F85E0006;
        Thu,  5 Jan 2023 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672932210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GoDYEKK8Y9YZdjSvUSOyQ3kYOxIaR/Idlu49Gec+8k=;
        b=Z8aB/DXDeLWCisL6QMEpoc7sT8Ib+w/cNxoA2pO7lc3KenzFuIvGDk2qlEE6rCEEPmCLAH
        5UaA9VHBdsNvlSTLYT3YeL1FpNe8vpGFLyDJ4tuLSfS0F9PI+qecL5DoIZ5UM98/tGObZ5
        Dr97806OT25ZpN6oyVh+FG0FAaRz+PA8OysaDicHytLu1Z20T1YBJSmcfBe7DLc7diYCSO
        0h7yidYzMPYVYPsv3TovB+Mjkz2gJ7CBRPe5FBEeALNIhc41LGTaCXP/yI9g87Kv11kuZf
        27tpz5Sxb7FBPytTdZ5zNBNrtkXmEMnvHy8KvbTyT9LbSD4LTiqI7SZCzagKjw==
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
Subject: [PATCH v5 5/5] MAINTAINERS: add the Renesas RZ/N1 USBF controller entry
Date:   Thu,  5 Jan 2023 16:22:57 +0100
Message-Id: <20230105152257.310642-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230105152257.310642-1-herve.codina@bootlin.com>
References: <20230105152257.310642-1-herve.codina@bootlin.com>
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
index 7f86d02cb427..ed8afef5386f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17859,6 +17859,14 @@ S:	Maintained
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

