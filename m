Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF06AE211
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjCGOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCGOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:21:51 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF9C6A7D;
        Tue,  7 Mar 2023 06:17:28 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1D0CB10001D;
        Tue,  7 Mar 2023 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678198526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TroEz27wSqUZ40T3hjcBwjx8v3Ktx9rBSE/61eZDZtI=;
        b=N8l72tsWCIEJS91MPLTyLmuiZYcZWigc7Rfx1cvouryTxhJusO3Jbv5HS6cmngwWTIZEbR
        QoR1VFWjY8jUsL9fB8o/Oh0g5b0NkRfjO3digjSKxH2YYU7ogl0I6zhLooz5mQEu2TBa+N
        6QT2p1FrxqMPUArCM5CH2488I5tn22EiYWviQho1zO6Edh08YNmqmaIsu5gligNl/M7H2Q
        5VtiC3uRkm5oYj+A0rLJUM5TDFtsUr3lNeCi8X+5LcQnDu49XntlbMEPWNd0eVRXyQQreJ
        8c8gE6fgZM19nfKZgjmJHpClYfae7c5AX/fUASmeH7UTmNiRMj8UcpBTC2eMag==
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
Subject: [PATCH 0/3] Fix the PowerQUICC audio support using the QMC
Date:   Tue,  7 Mar 2023 15:15:00 +0100
Message-Id: <20230307141503.159766-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous series added the PowerQUICC audio support using the QMC.
The v6 version of this previous series was applied but some feedbacks
lead to a v7 version.

The v6 can be found here:
 https://lore.kernel.org/linux-kernel/20230217145645.1768659-1-herve.codina@bootlin.com/
and the v7, here:
 https://lore.kernel.org/linux-kernel/20230306161754.89146-1-herve.codina@bootlin.com/

This 'fix' series is the incremental version of v6 -> v7 and can only be
applied on the Marc Brown's tree as the v6 patches it fixes are only
present on this tree.

Regards,
Herve Codina

Herve Codina (3):
  dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Remove unneeded property
  dt-bindings: soc: fsl: cpm_qe: cpm1-tsa: Remove unneeded property
  soc: fsl: cpm1: qmc: Fix assigned timeslot masks

 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 10 ----------
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml          | 10 ----------
 drivers/soc/fsl/qe/qmc.c                               | 10 +++++++---
 3 files changed, 7 insertions(+), 23 deletions(-)

-- 
2.39.2

