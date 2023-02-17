Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5441F69AEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBQO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBQO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:57:51 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DE6F7D7;
        Fri, 17 Feb 2023 06:57:28 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D4AE31BF210;
        Fri, 17 Feb 2023 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676645821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeJZjqKMo5SsRic4MTk2gtRIeqiw1QrtK/miER8ISu8=;
        b=M5Qt2ZWaClgXW7oeSEdTWhKz9zm0QDoLPYzerXs6jjnufix1h6rMIvG5m8Rm8Eu2EH2V0n
        /zQQL+uAF9EPi6bahw+8kMwjaSU4MFXo1ST6aTMU+seJKXKUMyuz1OaGKBwxeofoVXCox/
        aweLeH9c2jYzz6j6wnogflTvkr4oXAVM3u38xajoQqOHTakzXlOR67P+FuRN3OmZVSOAfy
        A7s8ixLoHEufIHsDSPysYc1xSL3Fu+wapk74x3ri6aX0U05PkdmHWgEgAKYM/+fL7cAiFa
        bqHhyRmtc0arJmYntYsokQjDhpj8d/Nf5shY/QqXQLsm5dH6hXS7k5HJoW8iVQ==
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
Subject: [PATCH v6 03/10] MAINTAINERS: add the Freescale TSA controller entry
Date:   Fri, 17 Feb 2023 15:56:38 +0100
Message-Id: <20230217145645.1768659-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217145645.1768659-1-herve.codina@bootlin.com>
References: <20230217145645.1768659-1-herve.codina@bootlin.com>
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
for the Freescale TSA controller.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..097a80d6623b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8372,6 +8372,15 @@ S:	Maintained
 F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/qe/
 
+FREESCALE QUICC ENGINE TSA DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
+F:	drivers/soc/fsl/qe/tsa.c
+F:	drivers/soc/fsl/qe/tsa.h
+F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
+
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 M:	Li Yang <leoyang.li@nxp.com>
 L:	netdev@vger.kernel.org
-- 
2.39.1

