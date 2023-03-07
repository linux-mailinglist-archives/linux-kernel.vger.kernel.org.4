Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C32F6AE21D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCGOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjCGOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:22:16 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020185B09;
        Tue,  7 Mar 2023 06:17:44 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 820AE100005;
        Tue,  7 Mar 2023 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678198541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ET/UXHmrkXcf+pOcInV5MX9zXz5Mj7BURNrQo+ZfWCw=;
        b=XzLez+du8FeeI4DCR/KP8lwA8qxzFOA4ok+n/RuX3h+qB2lEPfiX2sGMOyIrkNIzk3GyaD
        KkZxE7y/5BdrSylfbnyfCc4muyAG7l0Kt8FIjz4M9C9YCULSHp6PomxvwaQIQ6BsedOdyu
        6p5OVW4kQ8ze5QVdabdLqXTN1tx2cmTnd3IDz7HddXHQFINgv0Y6Dbw0oVUhwgyHd9kUu6
        CURjWqBXzB58NDILtyDd9rCw/0K+M5BteW8VLd6KtkAjV7HGEhx6AQg58RvLiy+OhY6ShP
        DTPmMVRZQXxtVdq9tURvWFDA7xauDcqG9HJIA//oHchGEceqy+glbKnd2pZ+Pg==
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
Subject: [PATCH 2/3] dt-bindings: soc: fsl: cpm_qe: cpm1-tsa: Remove unneeded property
Date:   Tue,  7 Mar 2023 15:15:02 +0100
Message-Id: <20230307141503.159766-3-herve.codina@bootlin.com>
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

Remove the unneeded and unused #fsl,serial-cells property.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml          | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
index 332e902bcc21..7e51c639a79a 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
@@ -38,14 +38,6 @@ properties:
   '#size-cells':
     const: 0
 
-  '#fsl,serial-cells':
-    $ref: /schemas/types.yaml#/definitions/uint32
-    const: 1
-    description:
-      TSA consumers that use a phandle to TSA need to pass the serial identifier
-      with this phandle (defined in dt-bindings/soc/fsl,tsa.h).
-      For instance "fsl,tsa-serial = <&tsa FSL_CPM_TSA_SCC4>;".
-
 patternProperties:
   '^tdm@[0-1]$':
     description:
@@ -174,7 +166,6 @@ required:
   - reg-names
   - '#address-cells'
   - '#size-cells'
-  - '#fsl,serial-cells'
 
 additionalProperties: false
 
@@ -190,7 +181,6 @@ examples:
 
         #address-cells = <1>;
         #size-cells = <0>;
-        #fsl,serial-cells = <1>;
 
         tdm@0 {
             /* TDMa */
-- 
2.39.2

