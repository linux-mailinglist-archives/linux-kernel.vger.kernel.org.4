Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4266047A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjAFQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjAFQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:38:36 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52D78A4F;
        Fri,  6 Jan 2023 08:38:35 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 8BD5310000C;
        Fri,  6 Jan 2023 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673023113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwu/1JwYIXUNItAZ+OMdvXbkTVLSSu6E75e+vsZix3c=;
        b=m6gcKoS++2sGnEQhfl2wOjkojZN7Z3KXQNimmEB8JszUjKLH8JIjD0GfX134lqMZNgb3Ec
        71yxYlyQAzLfan4RdJYnQvZ9WQ/F+HOHb5p1oadIe7NU/WTCmdDAyG3uop1tfdwMAMKuNr
        ysPJsfcgyZ7Hd+UvRvETUk2VwhUU/GHGDZqYZaL+Jo/AoRFBbw4TBz66+qm1q5bx7r1NTd
        N6Ly1MfFTNMayJCqRmPOwQk1mgv5vQ+4+lM1pzbczIrdcAcf3m4mW9HaeoXBHT0ODCOXlV
        dJ8qtW4opcp7gWc6GFt/YtAnzuglrph+pl23KUecdcJYPVC9D8dFeXgEMKSBeQ==
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
Subject: [PATCH v2 10/10] MAINTAINERS: add the Freescale QMC audio entry
Date:   Fri,  6 Jan 2023 17:37:46 +0100
Message-Id: <20230106163746.439717-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230106163746.439717-1-herve.codina@bootlin.com>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
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

After contributing the component, add myself as the maintainer
for the Freescale QMC audio ASoC component.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 480f90db699d..a15997c2cc05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8440,6 +8440,14 @@ F:	sound/soc/fsl/fsl*
 F:	sound/soc/fsl/imx*
 F:	sound/soc/fsl/mpc8610_hpcd.c
 
+FREESCALE SOC SOUND QMC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
+F:	sound/soc/fsl/fsl_qmc_audio.c
+
 FREESCALE USB PERIPHERAL DRIVERS
 M:	Li Yang <leoyang.li@nxp.com>
 L:	linux-usb@vger.kernel.org
-- 
2.38.1

