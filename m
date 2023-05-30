Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C75717222
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjE3XzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjE3XzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:55:15 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA8133
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:55:06 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BE6F22C05CC;
        Wed, 31 May 2023 11:55:04 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685490904;
        bh=MZ7YBEWJ2Mhd+Qk1GxIEC4t0MfhKhq1id7+zT7JKrCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2Zo0jV4tOky/MGHPI3d/5FZG55ngXns3VNPIjYxIoQ3gIIaiiq6+BFguUwX7bS0t
         ca078Fze3/P0cAWftMm9Ps3x96xofjYr85gmoPiE96cgVsskq8o7ZJPjim2FtGANdZ
         X4XLH77BZ138xyo7WW35KlGeZpnLO9XpKyR/Iu6Zogme7xmKvk/JfQzdt4/J01Y5mb
         oIpzFvZuYOXJDGA81wUUbWoLlcCIe0lTfb+iE0XnLPLKkV9vztAJHDHCchQ/aC9atc
         YNEAMLMLe+nPnq9wDQ33uIIVW1K4viancTF9Memg2QlCEakQhrQkZ5I/ojs5T8NCmY
         Fcia4/nxqBREQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64768cd80002>; Wed, 31 May 2023 11:55:04 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 8B04313EDD5;
        Wed, 31 May 2023 11:55:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 89E06280AFE; Wed, 31 May 2023 11:55:04 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 2/4] ARM: dts: mvebu: align MTD partition nodes to dtschema
Date:   Wed, 31 May 2023 11:54:54 +1200
Message-Id: <20230530235456.1009082-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=nIxSuVNCFVl6EelTsckA:9
X-SEG-SpamProfiler-Score: 0
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
---
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

