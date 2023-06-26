Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D873D630
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjFZDMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFZDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:12:27 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7CE56
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:12:24 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 039782C055E;
        Mon, 26 Jun 2023 15:12:21 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1687749141;
        bh=qyuUI+GTbigVnLlHtbXT9nNOWssZWdbxI7Bqwiieak8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY67yQ5BxL4sg46haJEXGpozSvX91Y9otoDTdYdGTAgQK9k7JKEi0shHHL1nD0QBL
         lRpxpsXG4qUu/NhcZi2ZZUWUX+wIDDwc7duAFdNAqpxYokrq8Erf0u2VP4FFkIk5GT
         pnjMPpOv+Fwsqv+1XOA3QYQwDh1DM9GmUBWA82ejx04A0+7MDrx6qZmNppfaUJj0YC
         0B5A+1nBwo/NFTK4U9lAuG1zac9mvZ8uWa8etqpX5a/CnimYlEERbuFq5IM/g6ygtr
         EffuJplMzPQZu48Q/K38rVjS7ecvNpGfKCKONNCzu+AqCQhx3laxdXtnWAjBvxJKHs
         bB3VYsojSPXRw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B649902140002>; Mon, 26 Jun 2023 15:12:20 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A24D013EE63;
        Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A2BC6283B3E; Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        pierre.gondois@arm.com, arnd@arndb.de, f.fainelli@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/3] arm64: dts: marvell: Add NAND flash controller to AC5
Date:   Mon, 26 Jun 2023 15:12:16 +1200
Message-ID: <20230626031217.870938-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
References: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=AWclJRrDGzD0f9BZm7oA:9
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

The AC5/AC5X SoC has a NAND flash controller (NFC). Add this to
the base SoC dtsi file as a disabled node. The NFC integration
on the AC5/AC5X only supports SDR timing modes up to 3 so requires a
dedicated compatible property so this limitation can be enforced.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - New.

 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/b=
oot/dts/marvell/ac5-98dx25xx.dtsi
index 8bce64069138..74d644e0c29e 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -296,6 +296,16 @@ spi1: spi@805a8000 {
 			status =3D "disabled";
 		};
=20
+		nand: nand-controller@805b0000 {
+			compatible =3D "marvell,ac5-nand-controller";
+			reg =3D  <0x0 0x805b0000 0x0 0x00000054>;
+			#address-cells =3D <0x1>;
+			#size-cells =3D <0x0>;
+			interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cnm_clock>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@80600000 {
 			compatible =3D "arm,gic-v3";
 			#interrupt-cells =3D <3>;
--=20
2.41.0

