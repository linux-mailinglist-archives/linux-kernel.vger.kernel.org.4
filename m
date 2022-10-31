Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F5614089
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJaWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaWQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:16:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21233213;
        Mon, 31 Oct 2022 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667254559; bh=k0wntXovT8y+3q2bW9xnG8ebvi9av0hnSUtJFwuAgWY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=E9iMdtBwLys9gdh+TVM/sArwhbKe1ZXb6z7AFA5BJvrnDxUZ02B1Rt8lhIQRSkPXj
         5y8c44dS8g2qo5bg89Uk3Xo/hHHI/2euzTXt2CPBX2gXKOJFuoJ/4JyIZck05Mlg+q
         sw1707yWHnKTYH5DEjsyZBWGnROtv4evBqVn/BLN1CUhfCxRwkDbVHiQUcJCG4IpS3
         E6mXn5mZsPGSOMUTGoNAJ+Zz49tau0G9vqolwwYNSYwSFew9gIGTkc3OEOeegbDOkF
         IZva3xaNySN2uzkmywdUU5G+bxuV9VrAl5ByBJwmbYuq6p4peVkU3UQMB49EitKA6l
         OagHTng6veuHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.189.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1oeJDM2Tax-00O2bT; Mon, 31
 Oct 2022 23:15:59 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        George Hung <ghung.quanta@gmail.com>,
        Fran Hsu <franhsutw@gmail.com>,
        Mohaimen alsmarai <Mohaimen.alsamarai@fii-na.com>,
        Vivekanand Veeracholan <vveerach@google.com>,
        Lancelot Kao <lancelot.kao@fii-usa.com>,
        Mustatfa Shehabi <Mustafa.Shehabi@fii-na.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: dts: nuvoton,npcm7xx: Remove bogus unit addresses from fixed-partition nodes
Date:   Mon, 31 Oct 2022 23:15:52 +0100
Message-Id: <20221031221553.163273-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lmzzG6ZGyQK+o9pIW2y06e7z7FNSxi4+h6BURLcimbjJjsCt3Qt
 LsklkNkr4QVQGtN8HjraIeCu/ySvKIDrhJ3HVPw9g+eL6aQ2hm2Bi9KpnH97J8ZXN3I86wo
 9MA0uc6UnA8Xjnl6PbQGOb5O0Q5cTyPqOIm+YCZrnMKTRs+aYp3C/WZ0+tQIohSqptwk+26
 Fb/o2/kPHKBWQBmqnbWDg==
UI-OutboundReport: notjunk:1;M01:P0:VeRaH5dMNV0=;3rSdmktspJtF1pJNNiSt7EC0bKi
 p7rG+xYa6hA6r4tqqa8iwEHebopjdJqo5dOIw8FbR7/Cqkx6EbCNLc1cIuiU1qtoLAgs19XGs
 G5tbYk7X8RMFYaB70n+w9RVRuSHznPbwLrftiSOZoe/S3NspdEAL9YUw8qI7Jx9MsX5UfaCIP
 mnVcSlOkOfO98u3V+1S9k7r7bqdyfM/8vR88calShlhy4Ez6LGKc1Egp1BBpBPYyBbXGuy0O5
 kK9aHWHjYeyezOC4gslsAfq/ep4q6nGqThJoWswYhE+/wRyPwK3yImvLRNG0bSB9nZhIFWJ7P
 NwMqmXlW5rA3ykHpbF4vKkb7GG6uFqcN7lJvvozRmo5H5uvpZ3vDtQy4CUE7x9Gi2IsTVfv6H
 L9kakK2aZZT3rxA9YUjxVUlAAYG1nQkMdyd1Ixk80hL3VPhF7roym8KoohDwHsRF6PRh271DB
 lRBvUhnMKC40y3a9FZpDSHUnvWWm+1a70TdN6kL/zLMmeQmxG6qj0DqnmL7iCvDDjwSk8l1RV
 9PsxaGrCZh6ciZqZ7weKXCZswGuJLNAp7RXuaybpvDNf3gMglwke51vEYmN3rJxJLV0ypSc+G
 3l5Ju4dobMpTrii+4rwOHpJXMWlaqrxfKE92JmBwYcnbstvCkNVequVWWXsgLH5xwD+GXhn5y
 lz1fWTiGprlozpo/C3Xe+PSy53Vm7WeU1PF44K6BC7i2K3aFdfehvOaH86g+SLZ9pXKP/O7Ta
 Nz19GzTuTNnuAeN/jKZpTKUwDrC8+rNr1kMij7Z7gfPJCP3o/ybbNQccSYtUJr+uRE9itkLHs
 tQF4YNQ/zHFfGkKfBXagEB1NGiCxlJK4n0jJH+RrY3ifVk4ofIEdXPUZNOuUWMG9PsTUXCYOb
 L14KCOwIAVkKLpk3yb2ty5VXUHYq8XezVgWwmWwTMSWS0x/qvG882GVgsev+q2w89lq8gJEn3
 ddw9SceHGdFS7jJ2HRnN2uY2EcQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit addresses do not correspond to the nodes' reg properties,
because they don't have any.

Fixes: e42b650f828d ("ARM: dts: nuvoton: Add new device nodes to NPCM750 E=
VB")
Fixes: ee33e2fb3d70 ("ARM: dts: nuvoton: Add Quanta GBS BMC Device Tree")
Fixes: 59f5abe09f0a ("ARM: dts: nuvoton: Add Quanta GSJ BMC")
Fixes: 14579c76f5ca ("ARM: dts: nuvoton: Add Fii Kudo system")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
=2D--

v3:
- rebased on 6.1-rc1

v2:
- Add R-b tag
- Add Fixes tags
=2D--
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts            | 2 +-
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts            | 2 +-
 arch/arm/boot/dts/nuvoton-npcm730-kudo.dts           | 6 +++---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts            | 4 ++--
 arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts=
/nuvoton-npcm730-gbs.dts
index d10669fcd527d..9e9eba8bad5e4 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
@@ -366,7 +366,7 @@ flash@0 {
 		spi-max-frequency =3D <20000000>;
 		spi-rx-bus-width =3D <2>;
 		label =3D "bmc";
-		partitions@80000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts=
/nuvoton-npcm730-gsj.dts
index 491606c4f044d..2a394cc15284c 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
@@ -142,7 +142,7 @@ flash@0 {
 		reg =3D <0>;
 		spi-rx-bus-width =3D <2>;

-		partitions@80000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dt=
s/nuvoton-npcm730-kudo.dts
index a0c2d76526258..f7b38bee039bc 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
@@ -388,7 +388,7 @@ flash@0 {
 		spi-max-frequency =3D <5000000>;
 		spi-rx-bus-width =3D <2>;
 		label =3D "bmc";
-		partitions@80000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -422,7 +422,7 @@ flash@1 {
 		reg =3D <1>;
 		spi-max-frequency =3D <5000000>;
 		spi-rx-bus-width =3D <2>;
-		partitions@88000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -447,7 +447,7 @@ flash@0 {
 		reg =3D <0>;
 		spi-max-frequency =3D <5000000>;
 		spi-rx-bus-width =3D <2>;
-		partitions@A0000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts=
/nuvoton-npcm750-evb.dts
index 3dad32834e5ea..f53d45fa1de87 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -74,7 +74,7 @@ flash@0 {
 		spi-rx-bus-width =3D <2>;
 		reg =3D <0>;
 		spi-max-frequency =3D <5000000>;
-		partitions@80000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -135,7 +135,7 @@ flash@0 {
 		spi-rx-bus-width =3D <2>;
 		reg =3D <0>;
 		spi-max-frequency =3D <5000000>;
-		partitions@A0000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts b/arch/a=
rm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
index 132e702281fc5..87359ab05db3e 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
@@ -107,7 +107,7 @@ flash@0 {
 		reg =3D <0>;
 		spi-rx-bus-width =3D <2>;

-		partitions@80000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -146,7 +146,7 @@ flash@1 {
 		reg =3D <1>;
 		npcm,fiu-rx-bus-width =3D <2>;

-		partitions@88000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -173,7 +173,7 @@ flash@0 {
 		reg =3D <0>;
 		spi-rx-bus-width =3D <2>;

-		partitions@A0000000 {
+		partitions {
 			compatible =3D "fixed-partitions";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
=2D-
2.35.1

