Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE71D6E93FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjDTMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjDTMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:14:17 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E25585;
        Thu, 20 Apr 2023 05:13:59 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id AF311100005;
        Thu, 20 Apr 2023 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681992837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqkC2hlSfWIiijztGsfpugS5O+kwYH1qXwTL4AZW7ec=;
        b=oXL0ibKNLDEGrmD+/aNtdz/dvm9c/dy5iIknXxkngvXR+5OAoOQLbUlARTV7rA5VhYjpcP
        /HvQqVfcc/BqseN4aVkTaQ8LtiBS4W4Qoxe3+GkU4ey+1XlxK7jzECjuWbQGPk/Q6kPKI7
        FfIlRaqbalSyjCiu7mnMwG2gRHiQCmp3uSRwj1h/Cl7796bycJUPL8m+i/hLIeOU/yQGxs
        gS52jEpOYVqIRG2iiHRiL6xwsj28PZ/KdeFf5H5tTXUN3+Ho2srys4UW3S9V82nBWhUQlV
        HwjEMCICSglnh1nWxKVZK2zD+VyM0KZbpmSlTImme+gPf/H2CO5gV/cCVmj33A==
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
Subject: [PATCH 3/3] MAINTAINERS: add the Renesas X9250 driver entry
Date:   Thu, 20 Apr 2023 14:13:20 +0200
Message-Id: <20230420121320.252884-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420121320.252884-1-herve.codina@bootlin.com>
References: <20230420121320.252884-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

