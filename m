Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC5774544D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGCDvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGCDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:51:04 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E721BE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:51:02 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0CDBC2C04A2;
        Mon,  3 Jul 2023 15:50:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1688356249;
        bh=V/moquzw94k+RD/17vle2ubXDMwNpgVNQy7Yswy0IyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHO2p0ily3m712nHX8LWyPpjiQlm23Fam3ARpukZt087eBjBNucFeF3VU2roiZ/S+
         0q8+47P+il/rzpiG/f2DpU12GpN43stuU7PiMPYuZlN8yoBp9FK3ARVU8mRbkUHCdP
         7jKce2+WN2/C9pTUDarOwRO0ly58tJA17owHlxm4/IOASpPdrCYGRJD7RkgoK8dpPP
         Te6chOyVzujhqdlvJmjE199l1y4sp8UHj+9zsgAk7jcELpArJMOizOTVMzSOnub8eP
         I72ElAxREHBQGugA4YgAmCRfauO4ziZCdpJgVO0MbJlrp0GmDkVdpYobGFUxXcBF5T
         Kk65muAFzUS0g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64a245980001>; Mon, 03 Jul 2023 15:50:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A208413EE4C;
        Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A13A5280011; Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Date:   Mon,  3 Jul 2023 15:50:42 +1200
Message-ID: <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=ws7JD89P4LkA:10 a=XYAwZIGsAAAA:8 a=egi5vsMYxoiYnfbZUMcA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
mode 3 so a specific compatible value is needed.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Notes:
    Changes in v3:
    - Collect ack from Conor
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

