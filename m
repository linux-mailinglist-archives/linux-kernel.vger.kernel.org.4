Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F322660143
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjAFNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjAFNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:30:24 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227807681E;
        Fri,  6 Jan 2023 05:30:22 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0B7FA40013;
        Fri,  6 Jan 2023 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673011821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eK6oGrS+FDqpNet/evYs5HPdbphuxm6/AcWmEWOiZU=;
        b=b0dHQa8bN2xD7KZzE+ZqmqXh8zGUDunlqyEPXYuvDiAoKKIQwe52yyzTH5mwv5zIKxpsou
        9arT+3e6kKoXMfpFT/yroH4nOba5iRrwJ7iTWF5Jg6OXoKHDAfUstnZ7x9uqTlrtDOBECI
        kSBXdMMyuH9Hv2zji/cWlIUDvtH7wU9ulegr1mImRg8wOLuFA4vRtNI7GjluL1aBkZSA2o
        4nFSvYVr37qZmzz2x+CuUw8hgHZ/pupyI66PIsf0m2Q9bgQpuBE1Ay4lV/8vHjAXccOzIE
        7bh58d9n5JnKPjZnUWxn73Csls0Q8dLg3gchxcLOLLueBJJ6lFomKeSXzbofBA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 07/10] MAINTAINERS: add the Freescale QMC controller entry
Date:   Fri,  6 Jan 2023 14:29:48 +0100
Message-Id: <20230106132951.392271-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230106132951.392271-1-herve.codina@bootlin.com>
References: <20230106132951.392271-1-herve.codina@bootlin.com>
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
for the Freescale QMC controller.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b4f5fe7ebad..480f90db699d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8372,6 +8372,14 @@ S:	Maintained
 F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/qe/
 
+FREESCALE QUICC ENGINE QMC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
+F:	drivers/soc/fsl/qe/qmc.c
+F:	include/soc/fsl/qe/qmc.h
+
 FREESCALE QUICC ENGINE TSA DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.38.1

