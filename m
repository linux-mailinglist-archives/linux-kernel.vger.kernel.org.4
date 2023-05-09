Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063EF6FCACF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjEIQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjEIQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:09:21 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2046B5;
        Tue,  9 May 2023 09:09:19 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id ABB76FF802;
        Tue,  9 May 2023 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683648558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMT/NRMGkvesRao22DI/CnATsgCB4x0ohxacGPVBFig=;
        b=DNwEcu3RL6mBBxwzjx2zv1J3gagktt8if0saz4r/gGoQPfx4Ig4ER6xU7frrOy5DXjbQfG
        MHwGoXiyUijMfVoVxTLDIRRfCkx4LMzvfF1MerzQSCX2rU/iVj07cM/43IthEadMMrzWh4
        kN13T4BWHXnQBQ70naWAUzvRDedYgNl6OAvVkHZ3PHrnwlisEk1BS4A29zD414dEX3XMHH
        Ulw0EcFLw+d5G+fICU5/krijqSZSb6EJMfJtjlI4dYp6/QaF3dlKoagW0bdrjXQmw9eC4A
        iKPfoBRxuyff09j+w7in4nmkfnU+2UNv6xcCTeKJkbzF3QDrVScf0Obqj8QEhQ==
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
Subject: [PATCH v4 3/3] MAINTAINERS: add the Renesas X9250 driver entry
Date:   Tue,  9 May 2023 18:08:52 +0200
Message-Id: <20230509160852.158101-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509160852.158101-1-herve.codina@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7517002b7735..159b3e7ce566 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18046,6 +18046,13 @@ S:	Maintained
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
2.40.1

