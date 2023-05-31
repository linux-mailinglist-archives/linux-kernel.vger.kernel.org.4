Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF79718F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjEaXtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:49:35 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A68136
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:49:33 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 188882C0343;
        Thu,  1 Jun 2023 11:49:30 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685576970;
        bh=J8M93mkz4vrLKdNA3BnSi6fRCGqPpXnlnyQMlwSvJpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFPXYmfaF+ODlRXtYXClW/Z+oga0nyEn4UbSP65ZNWtQmYR9jjSBG/plDbkQiqV/I
         FDL/LD96E1VSwi/59B/8CE+fO49Jf9oadheK7nznanlKDHigBzkGtwBN4JKhX5DF8e
         qIQb3JdaS3pL7R2PST+52kRwejPBENMAcZwiqgI7H3+jar4NZJdf2Hy77Ax6KpfHyh
         Lm0lVWtf0NbQbTcVmYC8ipmDnIFGc2ulBzBKgpKpWKXdweROwN0zZAgDRCf11Z7uWR
         mVV/N5lVhXkM3sMwZx2bzokZpEtLed1Q/+b0CnYtWVcJzrhnFQYdY/5Sk6Of/8paZU
         ADAwOqxwT1piQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6477dd090002>; Thu, 01 Jun 2023 11:49:29 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id E1B9A13ED2D;
        Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E299A285285; Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, conor@kernel.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 2/3] ARM: dts: mvebu: align MTD partition nodes to dtschema
Date:   Thu,  1 Jun 2023 11:49:22 +1200
Message-Id: <20230531234923.2307013-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Score: -1
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

