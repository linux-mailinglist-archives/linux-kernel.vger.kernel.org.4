Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFA730DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbjFOEFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241513AbjFOEFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:05:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687932135
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:05:03 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EFC52C0384;
        Thu, 15 Jun 2023 16:04:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686801894;
        bh=brRwJmGWxsIgAeWWrc4opZFfZN44SwSxhn4XIF05bQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQtP0CQ4Xa8AK8PQ/xrCxznBnqIWdkngVt/cNi2Pd+x/Tly3Q1m0qjDKXcEeO0MNi
         sIgsvr4BHMuX6kh+v/cYjj/0xn1a9aptuBKKR8ZrwIEnDP6mHDeprQymDd1Jm4LZAp
         2DfVkhmI/cpXto+QRfURnzbQwhf8z81Yei36estZyFZ1hSppiqRS7SPS1G4BFBN6KB
         WDyoQBCCqIdeaiRa3WynwAHLA02M0L3JKAjan7CB26nMwGIp1aOGM39pOzikwZFrM7
         Cs3OuX8XbjSXo13oFTYX2a6f81coDQd1Q0R1Z3zbmp6c4NnIDJgmuXFyqFdJgvIVZa
         xGWyuw+2zCd4Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B648a8de60002>; Thu, 15 Jun 2023 16:04:54 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 4B1AB13ED5B;
        Thu, 15 Jun 2023 16:04:54 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 477EC2815D4; Thu, 15 Jun 2023 16:04:54 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 2/3] ARM: dts: mvebu: align MTD partition nodes to dtschema
Date:   Thu, 15 Jun 2023 16:04:46 +1200
Message-Id: <20230615040447.3484564-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=P-IC7800AAAA:8 a=nIxSuVNCFVl6EelTsckA:9 a=d3PnA9EDa4IxuAV0gXij:22
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

Update the node names for the SPI NOR and NAND partitions to conform to
the partition properties in the relevant dtschema.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Notes:
    Changes in v9:
    - None
    Changes in v8:
    - Add r-by from Miquel

 arch/arm/boot/dts/armada-385-atl-x530.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dt=
s/armada-385-atl-x530.dts
index 241f5d7c80e9..5a9ab8410b7b 100644
--- a/arch/arm/boot/dts/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
@@ -179,19 +179,19 @@ partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
-			partition@u-boot {
+			partition@0 {
 				reg =3D <0x00000000 0x00100000>;
 				label =3D "u-boot";
 			};
-			partition@u-boot-env {
+			partition@100000 {
 				reg =3D <0x00100000 0x00040000>;
 				label =3D "u-boot-env";
 			};
-			partition@unused {
+			partition@140000 {
 				reg =3D <0x00140000 0x00e80000>;
 				label =3D "unused";
 			};
-			partition@idprom {
+			partition@fc0000 {
 				reg =3D <0x00fc0000 0x00040000>;
 				label =3D "idprom";
 			};
@@ -216,16 +216,16 @@ partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
-			partition@user {
+			partition@0 {
 				reg =3D <0x00000000 0x0f000000>;
 				label =3D "user";
 			};
-			partition@errlog {
+			partition@f000000 {
 				/* Maximum mtdoops size is 8MB, so set to that. */
 				reg =3D <0x0f000000 0x00800000>;
 				label =3D "errlog";
 			};
-			partition@nand-bbt {
+			partition@f800000 {
 				reg =3D <0x0f800000 0x00800000>;
 				label =3D "nand-bbt";
 			};
--=20
2.40.1

