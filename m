Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C966E9947
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjDTQLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjDTQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:11:09 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5677F4EC4;
        Thu, 20 Apr 2023 09:11:06 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0EDB91C000C;
        Thu, 20 Apr 2023 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682007064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqkC2hlSfWIiijztGsfpugS5O+kwYH1qXwTL4AZW7ec=;
        b=pQWcz+biiQ8I4p1fgCoUVjbVNbb9vh4RtsLIXhPebNMyOegMBiSTc8+Id0JOsa2j1vwI9e
        snWYeVnBXwUe47ijtsdMQMFon7DnE+bi+hwagdvPArHU+guV2PZfmaLLhu5XYcMiCxB0O+
        HEAyKw6PNxROAbLUBgmwY8k9e0huWpqMkZU1Q2FelLDodwwrdE0PQ3+8c67Lc16rAWQRza
        Ps74bBL6nsoHisL63e7MrArAfm7GNAJKBcj4/SGLuzq2vJd2otssgoiGs6KQd458RxgCXZ
        rmbtYUF22AdHLKMb5LP1AlHDydhetmnmi8oCUQ4qGhd4vH6cHuCmC7KJEw8ZYg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add the Renesas X9250 driver entry
Date:   Thu, 20 Apr 2023 18:10:52 +0200
Message-Id: <20230420161052.270366-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420161052.270366-1-herve.codina@bootlin.com>
References: <20230420161052.270366-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After contributing the driver, add myself as the maintainer for the
Renesas X9250 IIO driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ec7ccba9848..0027af3e14cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17926,6 +17926,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
 F:	drivers/clk/clk-versaclock7.c
 
+RENESAS X9250 DIGITAL POTENTIOMETERS DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
+F:	drivers/iio/potentiometer/x9250.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
-- 
2.39.2

