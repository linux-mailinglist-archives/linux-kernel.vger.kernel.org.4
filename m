Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F974544F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGCDvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGCDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:51:04 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309F91B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:51:02 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EC60B2C03B6;
        Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1688356248;
        bh=fFPDvwsEHFCxrfnhOHQlIvQXqw4Sj7FMlVCBiiLdjZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4VMwn/4y7NAsbIZGk/TQzUjJy2Y6mMHh5qgHDzrvavmATvL0GNM4FciqO6fc6qZz
         VhH/oFDwxyDIc9kmhjd7KPMvjAmZc0IdnaikZSfj9XkBYaoCYIBpAU4PqmVJcXU+sx
         KKQ0fIbQ4sO2S8BwREZrrDV+Jj6IR35Fq0QzcrHjSnftqh1Jt7tafStyaoh3Dj3d9r
         r6ke93IGsnoxNHEMtbMYuKxM10okXg3kUcTq2V7Q9Nvz2sAOUoyEVfi9m055vj5/15
         MXjq8Y+EiF7xkenTWme+HWVlaX5fubjaUQk0PTFX+YxvCfr6cXlbPK9wMIMX4Pt0VZ
         yedFmj+IL4k9Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64a245980002>; Mon, 03 Jul 2023 15:50:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A30BA13EE63;
        Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A2361283B14; Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/3] arm64: dts: marvell: Add NAND flash controller to AC5
Date:   Mon,  3 Jul 2023 15:50:43 +1200
Message-ID: <20230703035044.2063303-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=ws7JD89P4LkA:10 a=AWclJRrDGzD0f9BZm7oA:9
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
    Changes in v3:
    - Use correct clock for NFC
    Changes in v2:
    - New.

 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/b=
oot/dts/marvell/ac5-98dx25xx.dtsi
index c9ce1010c415..c64aaf51deb8 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -297,6 +297,16 @@ spi1: spi@805a8000 {
 			status =3D "disabled";
 		};
=20
+		nand: nand-controller@805b0000 {
+			compatible =3D "marvell,ac5-nand-controller";
+			reg =3D  <0x0 0x805b0000 0x0 0x00000054>;
+			#address-cells =3D <0x1>;
+			#size-cells =3D <0x0>;
+			interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&nand_clock>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@80600000 {
 			compatible =3D "arm,gic-v3";
 			#interrupt-cells =3D <3>;
@@ -319,5 +329,11 @@ spi_clock: spi-clock {
 			#clock-cells =3D <0>;
 			clock-frequency =3D <200000000>;
 		};
+
+		nand_clock: nand-clock {
+			compatible =3D "fixed-clock";
+			#clock-cells =3D <0>;
+			clock-frequency =3D <400000000>;
+		};
 	};
 };
--=20
2.41.0

