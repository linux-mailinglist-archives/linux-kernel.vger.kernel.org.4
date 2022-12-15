Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7623964D55D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLOCyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOCyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:54:09 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389862BB27
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:54:07 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C3B542C0667;
        Thu, 15 Dec 2022 15:54:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1671072843;
        bh=DoHn/PhVuIoHESIuz7WTLGoi+ekp+WLshGKkCOd3Ink=;
        h=From:To:Cc:Subject:Date:From;
        b=DpaP1kARhvelCGh6c3/uqxvNOc6MCJHI8uOAOFcyksJ2Q37zjBzDQHcEsJvcLltGV
         eKX8RpwoTrUUUd0fabdJqM+Pb/m1hcNEqE6EGoVDv5OFLoZcTlpCI6rX5AkN6czuhX
         xd+y2prG4uVpD24wVVOqlCm5d+/IhZAkx3vq4n/McM7sdBD1iDXiAOKrF6C3A1Z2Cp
         JcvPiSmV2Uhx0S1IW4LT5CujZq9m5G2JywsdVvCzX9ntz9xM7OegVy2ZUYwwgn10WZ
         ZlO0cw0tHhmRJl9sLLcWOlZJNHcxiLyhiPkWSELy7MlPtJMviLTZW3BGRxO/OzMr/l
         M0Muvydarm6Sg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B639a8c4b0000>; Thu, 15 Dec 2022 15:54:03 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 9CE4413EDDC;
        Thu, 15 Dec 2022 15:54:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9A7502A00E6; Thu, 15 Dec 2022 15:54:03 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     gregory.clement@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, pierre.gondois@arm.com,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] arm64: dts: marvell: AC5/AC5X: Fix address for UART1
Date:   Thu, 15 Dec 2022 15:54:02 +1300
Message-Id: <20221215025402.1733132-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=X/cs11be c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=sHyYjHe8cH0A:10 a=lrILwYswuLCipcVmd9MA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct address offset is 0x12100.

Fixes: 31be791e26cf ("arm64: dts: marvell: Add UART1-3 for AC5/AC5X")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Not sure how this happened. I only noticed when I had a conflict in some
local patches I was rebasing against upstream. So I obviously had it
right at one point but then managed to break it in the process of
cleaning things up for submission.

 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/b=
oot/dts/marvell/ac5-98dx25xx.dtsi
index 7308f7b6b22c..8bce64069138 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -98,7 +98,7 @@ uart0: serial@12000 {
=20
 			uart1: serial@12100 {
 				compatible =3D "snps,dw-apb-uart";
-				reg =3D <0x11000 0x100>;
+				reg =3D <0x12100 0x100>;
 				reg-shift =3D <2>;
 				interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width =3D <1>;
--=20
2.38.2

