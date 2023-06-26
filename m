Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9D73D631
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjFZDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjFZDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:12:27 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459B1AA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:12:24 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C24362C0124;
        Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1687749140;
        bh=eMOEgUa0E7z5p8qfBp+CWlp5a+uQqNd4H4SB3Ukp/sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIUNGZmGgGMYtCfI7k9W+Tkqud2W9P9ld6G9+cL2sKP5ipW3oVSGHltSOg51f24gc
         xm0j9dZueRrYl7qzbompeuTj/ugt+EU3kTjR1XOliLsejmwF8lSrqEb2xI6p1xxUHi
         EtRGCXXCnxyrBHHFCzlG/E3iw6Rj76SO29KuNJqtzpujmHPxbmId970OhZJalSt4GW
         4EFAmZjTbD9TFXS1bWfjUJWD6+31xPJ/dRqpKwMIDc/GFXuAGoOBw1FkXY8HvQOXfv
         6tQvCdgG5Gt05a3yqghMzDXkYdUjJ51g+k5flW5S2kLyFqLEHocUnp2e2zB6yvr57C
         tVADcqSF0AH1Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B649902140001>; Mon, 26 Jun 2023 15:12:20 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A0D8B13EE52;
        Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9F556281AA0; Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        pierre.gondois@arm.com, arnd@arndb.de, f.fainelli@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/3] dt-bindings: mtd: Add AC5 specific binding
Date:   Mon, 26 Jun 2023 15:12:15 +1200
Message-ID: <20230626031217.870938-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
References: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=uX4zeqIseCYJFCGchTMA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
mode 3 so a specific compatible value is needed.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Keep compatibles in alphabetical order
    - Explain AC5 limitations in commit message

 .../devicetree/bindings/mtd/marvell,nand-controller.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
index a10729bb1840..1ecea848e8b9 100644
--- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -16,6 +16,7 @@ properties:
           - const: marvell,armada-8k-nand-controller
           - const: marvell,armada370-nand-controller
       - enum:
+          - marvell,ac5-nand-controller
           - marvell,armada370-nand-controller
           - marvell,pxa3xx-nand-controller
       - description: legacy bindings
--=20
2.41.0

