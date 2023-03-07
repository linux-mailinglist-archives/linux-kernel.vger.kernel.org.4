Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780596AE214
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCGOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCGOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:21:52 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD88A47;
        Tue,  7 Mar 2023 06:17:31 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id C4DA110000B;
        Tue,  7 Mar 2023 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678198535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4eCyez3rsGHNa1ju/xOVLqn68UTPKLtsV9g1+e7lV8=;
        b=UHIZFpu3lCBgJz7KKwZ7aQJ26GxIT+OSAWI8vPgBnPNulHrt8VJ4UIyOzBqWnx0f3BVIFp
        LYb4QZrf0hIN4+9ETpJUqTdN5Ancw9VyEdilqozSw09qvJdU3dAhKWiStt7S8KQxNKZ5kM
        ruGZj8f6MkD/sHKo7HZwEySUSwedo0mi+gCT37vHKu07UTYfp4SLRKWN6/mrmquZdN6tXN
        rcHK0uBqYHzYLbKP77ra4TPTTubUM7fa/XHTq5MLOu2QwtS2ai2fmLIeAIx7CdIq3lyKXI
        RLtPUykdE9fkbu4sDdAB5n9Bj4Qgt8TklE47MiQAwGVj7zk8fe+0m9eJ9nTq1A==
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
Subject: [PATCH 1/3] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Remove unneeded property
Date:   Tue,  7 Mar 2023 15:15:01 +0100
Message-Id: <20230307141503.159766-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307141503.159766-1-herve.codina@bootlin.com>
References: <20230307141503.159766-1-herve.codina@bootlin.com>
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

Remove the unneeded and unused #fsl,chan-cells property.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
index 4ebbc7d52981..ec888f48cac8 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
@@ -59,14 +59,6 @@ properties:
   '#size-cells':
     const: 0
 
-  '#fsl,chan-cells':
-    $ref: /schemas/types.yaml#/definitions/uint32
-    const: 1
-    description:
-      QMC consumers that use a phandle to QMC need to pass the channel number
-      with this phandle.
-      For instance "fsl,qmc-chan = <&qmc 16>;".
-
 patternProperties:
   '^channel@([0-9]|[1-5][0-9]|6[0-3])$':
     description:
@@ -121,7 +113,6 @@ required:
   - fsl,tsa-serial
   - '#address-cells'
   - '#size-cells'
-  - '#fsl,chan-cells'
 
 additionalProperties: false
 
@@ -140,7 +131,6 @@ examples:
 
         #address-cells = <1>;
         #size-cells = <0>;
-        #fsl,chan-cells = <1>;
 
         fsl,tsa-serial = <&tsa FSL_CPM_TSA_SCC4>;
 
-- 
2.39.2

