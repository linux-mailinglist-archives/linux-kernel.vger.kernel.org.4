Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C136D94F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjDFLSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjDFLS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:29 -0400
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C08A75;
        Thu,  6 Apr 2023 04:18:21 -0700 (PDT)
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3369uhLE020839;
        Thu, 6 Apr 2023 11:22:38 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2169.outbound.protection.outlook.com [104.47.74.169])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3pp9xuk2dn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:22:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STOJVdhA2zOMtWqNROV0Fp+TenT8e0n072e12b72XAel8gNEgPOSfdQQAUnP8Yb10gRt9Ag6l1WjayE1i8uxQjldFNedBs0FttxpiKVvUGiQ9e4jkR3+SA4u5chaSVhz9wRcuyZk8lrO2AGsDNHm3oTDt4pQjio8FXVJ7+DvWALlJVgDZhQhT3S/6y7zN78VGC+nufeM6fsJmY3KMHjGYBf05P8qDlOUZNA3DGiFwnCFrvGYgHHNABei7+RvLgZ08wSMkUR8zmRCHWCRN7hr2a9zdYCSCIRfVGKpq2N41llLD2YDx5/z0+Pcu02fiK7OuvPIzQJE0P+QsiAXdewVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D1H8Qxb9kU8w68M0cIprRNNrtcAH6mfASgSxe7PezU=;
 b=VeVAiC391B12Eyw1N+mP9oPhy3aVZkz+nWSUoOh1n6UjLAzVLdYjuu/eYNNwoWMw/Wyc3hTIiLJwtm+cAWfCqpCrkxvx4F9OqxwkEgxVWI11usRh2u3GLGpAOS21l9klsCRnF1ebK0W62tJicq9CSkcDj8Q1SdpvmP1txrURcUmo/hlBMTXZJEepiX9r4qIUGFk9T0CbMbqHFABLj2C2MPdXUCo88MoTTPQXJ90L0Wx70jt1GyI1CtPys6LItCFqKSBEnAa3dl0pbMy4scX+HxQ2j9jA2jrYbMGd4Sx5IeV0dhPwg9NgVMYtQhNgpHaccWCUIi6SGH1O0cE3NnDCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D1H8Qxb9kU8w68M0cIprRNNrtcAH6mfASgSxe7PezU=;
 b=L7w4QkfM9sg8RfcpjN/wQb24MLywJidVXdvAL3OqWntFO5GntXrLss2S63k4AwjOsbw1XVSkPZk7Gd8Om6pKaVYro565okUBTu98VRtwkSqHGXO3xvW9VuEkexCQ0f7QxbXAkWlQpwSHGN3XWdRree/qaejxuquhEtbXh/EeKKk=
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:37::10)
 by PN3PR01MB7647.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:22:32 +0000
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23]) by MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 10:22:32 +0000
From:   Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
Subject: [PATCH 5/5] arm64: Add initial support for Blaize BLZP1600 CB2
Thread-Topic: [PATCH 5/5] arm64: Add initial support for Blaize BLZP1600 CB2
Thread-Index: AQHZaHGyPI3QxU+btkS8yJugeth0pg==
Date:   Thu, 6 Apr 2023 10:22:32 +0000
Message-ID: <20230406102149.729726-6-nikolaos.pasaloukos@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6906:EE_|PN3PR01MB7647:EE_
x-ms-office365-filtering-correlation-id: 89d3cb96-611f-42b6-b7b6-08db3688d553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDUV4Sd+NOjYGLhe+LNq+VoZFHEVwZCCRtSpB4I3L1PY0noUF2Q3Asrj0lAQzfHoPkqII9kdO4gJMuFcjzm010jPiBuQPqSiXVP0G7oc2e2jiKx3MI6QaHrVDBXjzb3UFM9TVSCdNHsXfXUKar3VEcVanr3t3kjC03PTJWU7ksdItrCU+/MWiJwqUw0NO5FSo37DC9BT+2o9eIIBfdDQiGeW21q7jtoXafKlxaQem6d9jo/APTVIVI/dOdIFnwT0jmqJJ16mMY+CW/lsLMlSq1PdES0zOz2b9Fz+fxqdYATn588kR9mqNKA7+fR06l31bSSWIamueOs6YRz7M/gLvUBp24kmy7JW70aprxdzLs19j5WDTgiZXO2aWmL0CSMUM5+f6Smg/Qfqbn7h9yvshVv0wNTOOTDSPv0dVTB9vCNyQT8RkPSUUZqpyTg0fZs8IuW2qNO5eo1tIP9Pzviy0RWAIYmdR7tXUpkPBFjpD61RKiod5qtoByNXPSGqOsVBXdMjCdyxG50V5J5S41HoEGGDsK8yu8Uyta1yNBgfKr8FiXDJA9BzoCarAZcsp7UEu8GPgcJqvQIeUkLziMeSlNEq0C88UZWHZYY/0Xq9V5wB3bSd0XPnw5vRRZ0Xu/fr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39840400004)(366004)(451199021)(6486002)(4326008)(91956017)(110136005)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(36756003)(66476007)(122000001)(6506007)(83380400001)(6512007)(107886003)(2616005)(186003)(26005)(1076003)(38100700002)(5660300002)(41300700001)(71200400001)(478600001)(8936002)(38070700005)(86362001)(30864003)(2906002)(7416002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vCpVgL7kObt81DocEMAuZRIXRCKitrnBI9yFDJP76j629UodOZI9a7nDjV?=
 =?iso-8859-1?Q?3A2CuFwS/GAtpC2/X5oOeKJzlnw2CSoEjQ5wu/VTeGiMFY1GWoJoNEEMhV?=
 =?iso-8859-1?Q?UFie7MUbBDzAAqMC+J+bUh/LaO5+muyytcTq4Sk+mospWkRPvjsgWgVbeP?=
 =?iso-8859-1?Q?p8qfK0BApKNvy+5KnjJJRIT3huHWCnlOun1UgDs0HRTcsFxh99iVnziVkL?=
 =?iso-8859-1?Q?N6YFYTycKRLG0miPnfyWcx+sIIWkb13Jz4hG5pDBRwquVrWK4KkOzwMS8G?=
 =?iso-8859-1?Q?dDgablOncvK/KnCsaQMOa13PjolqeRsnwqqX9D3908NtDdGbKdBtZi5o5l?=
 =?iso-8859-1?Q?lBePSmGHYYHMMMROkJMlIIP6N+XLLgclQlaEJyQuVzG1aZdPh6D73Wqy4X?=
 =?iso-8859-1?Q?ihZPaB2TJi/wQvto8atqfB0HY6gTvZHYIox2PcYmhd1hmI/186CYZOvrW2?=
 =?iso-8859-1?Q?5VYb1ijeps3G8iuMwmi4uwXLEAIc7EITpca1poIvOx2PVaKcfVNhcpwPXT?=
 =?iso-8859-1?Q?XKem2bV7R42EojPWcXfIRbaSV7hDK5/16HluTIOAAILRKiczo3RNoE9cII?=
 =?iso-8859-1?Q?w59b11HlcT2GS9VJR0MAi2qLUerA2tSmKSp1f8GYL8IHX5oWn7hWeApGT3?=
 =?iso-8859-1?Q?jCDcbgYKHwMCrci9OEiyMdpMUiVpZeUADbwdBU4FKj+xTGNmo97kica/mR?=
 =?iso-8859-1?Q?kGwgTq3oUOhwFzAyJhWMCzO4uZ0ZfQpvp5NMyMSfaLZ3906OYqvGTcNf+l?=
 =?iso-8859-1?Q?lG0cR0oMydyewrdKl0V1FdTMc+0RZDRz5sGihod9PPb/DrdP2Xn8gYNRoR?=
 =?iso-8859-1?Q?zSn4l6mkMI5TDwtB6G9B/SopWMeO97a3sxR4BXIX0c5VjYnoOKf6e0KDub?=
 =?iso-8859-1?Q?8VzYtEHufGI0kAjIMjiLl5OcY0/4XE1oZZTMbn7nPR3wy1xRaY/YHxHEFa?=
 =?iso-8859-1?Q?NR1oT9v3UQxBawuerD1BGBzFXXGdWHOLweiFZyTzBlsr87GDgMfhal6RoQ?=
 =?iso-8859-1?Q?2vyBhXqRChdW/tpp7ZIUjiFbjy5i8fQkbRzt7ZMv4OuamQywy0K3ngKCFm?=
 =?iso-8859-1?Q?JSoIgLF3NiJ/UcvrpHzNTD5uZ33xz4lCoypM1TuCGSrD42OxLA7W842Mmq?=
 =?iso-8859-1?Q?xnQ5vKNsndJo9H64xckfw7zbYTnTuRZhYWR9kQiaij5gDAhHYs5Z501NlB?=
 =?iso-8859-1?Q?c9/ILgYitn3CZIKP+QpLhzh6OpqbawyHOCoAKgNQC31tN0DQheMghL+jpe?=
 =?iso-8859-1?Q?3FBOa6sOZ182aYYmXMZixSihnyXZC2RTY7u654XL1hRNof0Kt2x5x8o35h?=
 =?iso-8859-1?Q?7RqcuLvVKd+Jk3Pmcr+wV4Z/G03PF1B5/Tg34i2DPtv5Xl2O96rm/K4T0M?=
 =?iso-8859-1?Q?Y3Kw5yBiBuLG4gd7N4+iAez0LFPZ6fvFonLsSbnV3BpXgZVRkrcRQdi0Iq?=
 =?iso-8859-1?Q?vChfsAzVZBK3hZpRady/swpKIOZggXOkhbg4fhpJRoLa4+2o687XUFkJvU?=
 =?iso-8859-1?Q?4UEZO/QqhHKuDXVx4HsCWthUoQbCpDJwFtlbJ9egKOIQFfn6ZJmi5GyMZV?=
 =?iso-8859-1?Q?M8xYNqyTmf9OKPFqoGsjSzrCuSXBuc+CyTonq2OSp05fduNbyLd2jxtwkS?=
 =?iso-8859-1?Q?p4cKM1zeyTZ8pY826S/PcRE/H3W0ITNQavRYT61I9phlcLSDd73oPSsA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d3cb96-611f-42b6-b7b6-08db3688d553
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:22:32.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAuzs4VeGW1ebzY+1YUwWBiMrGoO8LXRa1COfYg16CnNN5y44ifJ95ulXmW3fEcsZv8ILPqITunNrY2Phif+LLkcKLfb24KsDIwzkqqtnu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7647
X-Proofpoint-GUID: XgTZiYVG_cU_Gz6hBAL5N3u9TQjM_1wa
X-Proofpoint-ORIG-GUID: XgTZiYVG_cU_Gz6hBAL5N3u9TQjM_1wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060090
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the Blaize CB2 development board based on
BLZP1600 SoC. This consists of a Carrier-Board and a SoM.

The blaize-blzp1600.dtsi is the common part for the SoC,
blaize-blzp1600-som.dtsi is the common part for the SoM and
blaize-blzp1600-som-cb2.dts is the board specific file.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../dts/blaize/blaize-blzp1600-som-cb.dtsi    | 217 +++++
 .../dts/blaize/blaize-blzp1600-som-cb2.dts    | 103 ++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  | 104 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 894 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 1327 insertions(+)
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 333d0af650d2..ab89cb7e557f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -94,6 +94,11 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
=20
+config ARCH_BLAIZE_BLZP1600
+	bool "Blaize BLZP1600 SoC Platforms"
+	help
+	  This enables support for the Blaize BLZP1600 SoC family
+
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 7b107fa7414b..d2fd6ab437ac 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y +=3D apm
 subdir-y +=3D apple
 subdir-y +=3D arm
 subdir-y +=3D bitmain
+subdir-y +=3D blaize
 subdir-y +=3D broadcom
 subdir-y +=3D cavium
 subdir-y +=3D exynos
diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/blai=
ze/Makefile
new file mode 100644
index 000000000000..968c0d687897
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) +=3D blaize-blzp1600-som-cb2.dtb
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi b/arch/=
arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
new file mode 100644
index 000000000000..be09759f48f9
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include "blaize-blzp1600-som.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	aliases {
+		ethernet =3D &gmac;
+	};
+
+	sound: sound {
+		compatible =3D "simple-audio-card";
+		simple-audio-card,name =3D "BLZP1600-TLV320AIC3100";
+		simple-audio-card,widgets =3D
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =3D
+			"MIC1LP", "Microphone Jack",
+			"MIC1RP", "Microphone Jack",
+			"MIC1LP", "MICBIAS",
+			"MIC1RP", "MICBIAS",
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR";
+
+		simple-audio-card,format =3D "i2s";
+		simple-audio-card,bitclock-master =3D <&sound0_master>;
+		simple-audio-card,frame-master =3D <&sound0_master>;
+
+		simple-audio-card,cpu {
+			sound-dai =3D <&i2s_slave>;
+		};
+
+		sound0_master: simple-audio-card,codec {
+			sound-dai =3D <&audio_codec>;
+			clocks =3D <&scmi_clk BLZP1600_I2S_CODEC_CLK>;
+			system-clock-frequency =3D <12500000>;
+			/* board specific crystal/oscillator */
+			assigned-clocks =3D <&scmi_clk BLZP1600_SRC_I2S_CLK>;
+			assigned-clock-rates =3D <24576000>;
+		};
+	};
+
+	regulators {
+		vmmc_sd: regulator-sdio0-en {
+			compatible =3D "regulator-fixed";
+			regulator-name =3D "mmc-reg-en";
+			regulator-min-microvolt =3D <3300000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpio =3D <&gpio0 23 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			startup-delay-us =3D <100000>;
+		};
+
+		vmmc_io: regulator-sdio0-io {
+			compatible =3D "regulator-gpio";
+			regulator-name =3D "mmc-reg-io";
+			regulator-ramp-delay =3D <10000>;
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpios =3D <&gpio0 22 GPIO_ACTIVE_HIGH>;
+			states =3D <1800000 0x0 3300000 0x1>;
+		};
+	};
+};
+
+&canfd0 {
+	status =3D "okay";
+};
+
+&dsi_panel_0 {
+	reset-gpio =3D <&gpio0 9 GPIO_ACTIVE_LOW>;
+};
+
+&gmac {
+	status =3D "okay";
+	snps,reset-delays-us =3D <0 10000 50000>;
+	snps,reset-gpio =3D <&gpio0 12 GPIO_ACTIVE_LOW>;
+	phy-handle =3D <&phy0>;
+	phy-mode =3D "rgmii-id";
+
+	mdio {
+		compatible =3D "snps,dwmac-mdio";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		phy0: ethernet-phy@0 {
+			compatible =3D "ethernet-phy-ieee802.3-c22";
+			reg =3D <0>;
+			ti,rx-internal-delay =3D <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,tx-internal-delay =3D <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,fifo-depth =3D <DP83867_PHYCR_FIFO_DEPTH_6_B_NIB>;
+		};
+	};
+};
+
+&gpio0 {
+	status =3D "okay";
+	gpio-line-names =3D "PERST_N",		/* GPIO_0 */
+			  "LM96063_ALERT_N",	/* GPIO_1 */
+			  "INA3221_PV",		/* GPIO_2 */
+			  "INA3221_CRIT",	/* GPIO_3 */
+			  "INA3221_WARN",	/* GPIO_4 */
+			  "INA3221_TC",		/* GPIO_5 */
+			  "QSPI0_RST_N",	/* GPIO_6 */
+			  "LM96063_TCRIT_N",	/* GPIO_7 */
+			  "DSI_TCH_INT",	/* GPIO_8 */
+			  "DSI_RST",		/* GPIO_9 */
+			  "DSI_BL",		/* GPIO_10 */
+			  "DSI_INT",		/* GPIO_11 */
+			  "ETH_RST",		/* GPIO_12 */
+			  "CSI0_RST",		/* GPIO_13 */
+			  "CSI0_PWDN",		/* GPIO_14 */
+			  "CSI1_RST",		/* GPIO_15 */
+			  "CSI1_PWDN",		/* GPIO_16 */
+			  "CSI2_RST",		/* GPIO_17 */
+			  "CSI2_PWDN",		/* GPIO_18 */
+			  "CSI3_RST",		/* GPIO_19 */
+			  "CSI3_PWDN",		/* GPIO_20 */
+			  "ADAC_RST",		/* GPIO_21 */
+			  "SD_SW_VDD",		/* GPIO_22 */
+			  "SD_PON_VDD",		/* GPIO_23 */
+			  "GPIO_EXP_INT",	/* GPIO_24 */
+			  "BOARD_ID_0",		/* GPIO_25 */
+			  "SDIO1_SW_VDD",	/* GPIO_26 */
+			  "SDIO1_PON_VDD",	/* GPIO_27 */
+			  "SDIO2_SW_VDD",	/* GPIO_28 */
+			  "SDIO2_PON_VDD",	/* GPIO_29 */
+			  "BOARD_ID_1",		/* GPIO_30 */
+			  "BOARD_ID_2";		/* GPIO_31 */
+};
+
+&i2c0 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c1 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c2 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	audio_codec: audio-codec@18 {
+		compatible =3D "ti,tlv320aic3100";
+		reg =3D <0x18>;
+		#sound-dai-cells =3D <0>;
+		ai3x-micbias-vg =3D <1>;          /* 2.0V */
+		reset-gpios =3D <&gpio0 21 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&i2c3 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	gpio_expander: gpio@74 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x74>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+	};
+};
+
+&i2s_master {
+	status =3D "okay";
+};
+
+&i2s_slave {
+	status =3D "okay";
+};
+
+&sd {
+	wp-inverted;
+	no-sdio;
+	no-mmc;
+	card-detect-delay =3D <200>;
+	vmmc-supply =3D <&vmmc_sd>;
+	vqmmc-supply =3D <&vmmc_io>;
+	status =3D "okay";
+};
+
+&sdio0 {
+	no-sd;
+	no-sdio;
+	non-removable;
+	wp-inverted;
+	status =3D "okay";
+	no-3-3-v;
+};
+
+&spim {
+	//spidev@2 {
+	//	compatible =3D "spidev";
+	//	spi-max-frequency =3D <100>;
+	//	reg =3D <2>;
+	//};
+};
+
+&spis {
+	//status =3D "okay";
+	//
+	//slave {
+	//	compatible =3D "spidev";
+	//	status =3D "okay";
+	//	spi-max-frequency =3D <100>;
+	//};
+};
+
+&usb3 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts b/arch/=
arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
new file mode 100644
index 000000000000..09925db3c58a
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "blaize-blzp1600-som-cb.dtsi"
+
+/ {
+	model =3D "Blaize BLZP1600 SoM1600P CB2 Development Board";
+
+	compatible =3D "blaize,blzp1600-som-cb2", "blaize,blzp1600";
+
+	regulators {
+		vmmc_sdio1: regulator-sdio1-en {
+			compatible =3D "regulator-fixed";
+			regulator-name =3D "mmc-sdio1-en";
+			regulator-min-microvolt =3D <3300000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpio =3D <&gpio0 27 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			startup-delay-us =3D <100000>;
+		};
+
+		vmmc_sdio1_io: regulator-sdio1-io {
+			compatible =3D "regulator-gpio";
+			regulator-name =3D "mmc-sdio1-io";
+			regulator-ramp-delay =3D <10000>;
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpios =3D <&gpio0 26 GPIO_ACTIVE_HIGH>;
+			states =3D <1800000 0x0 3300000 0x1>;
+		};
+	};
+};
+
+&gpio_expander {
+	gpio-line-names =3D "RSP_PIN_7",	/* GPIO_0 */
+			  "RSP_PIN_11",	/* GPIO_1 */
+			  "RSP_PIN_13",	/* GPIO_2 */
+			  "RSP_PIN_15",	/* GPIO_3 */
+			  "RSP_PIN_27",	/* GPIO_4 */
+			  "RSP_PIN_29",	/* GPIO_5 */
+			  "RSP_PIN_31",	/* GPIO_6 */
+			  "RSP_PIN_33",	/* GPIO_7 */
+			  "RSP_PIN_37",	/* GPIO_8 */
+			  "RSP_PIN_16",	/* GPIO_9 */
+			  "RSP_PIN_18",	/* GPIO_10 */
+			  "RSP_PIN_22",	/* GPIO_11 */
+			  "RSP_PIN_28",	/* GPIO_12 */
+			  "RSP_PIN_32",	/* GPIO_13 */
+			  "RSP_PIN_36",	/* GPIO_14 */
+			  "TP31";	/* GPIO_15 */
+};
+
+&i2c3 {
+	gpio_expander_m2: gpio@75 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x75>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "M2_W_DIS1_N",	/* GPIO_0 */
+				  "M2_W_DIS2_N",	/* GPIO_1 */
+				  "M2_UART_WAKE_N",	/* GPIO_2 */
+				  "M2_COEX3",		/* GPIO_3 */
+				  "M2_COEX_RXD",	/* GPIO_4 */
+				  "M2_COEX_TXD",	/* GPIO_5 */
+				  "M2_VENDOR_PIN40",	/* GPIO_6 */
+				  "M2_VENDOR_PIN42",	/* GPIO_7 */
+				  "M2_VENDOR_PIN38",	/* GPIO_8 */
+				  "M2_SDIO_RST_N",	/* GPIO_9 */
+				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
+				  "M2_PETN1",		/* GPIO_11 */
+				  "M2_PERP1",		/* GPIO_12 */
+				  "M2_PERN1",		/* GPIO_13 */
+				  "UIM_SWP",		/* GPIO_14 */
+				  "UART1_TO_RSP";	/* GPIO_15 */
+	};
+};
+
+&sdio1 {
+	no-mmc;
+	no-sd;
+	non-removable;
+	vmmc-supply =3D <&vmmc_sdio1>;
+	vqmmc-supply =3D <&vmmc_sdio1_io>;
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+	//status =3D "okay";
+	keep-power-in-suspend;
+	no-3-3-v;
+	// Override bits 0-SDR50, 1-SDR104, 2-DDR50 to respect the dtb properties
+	sdhci-caps-mask =3D <0x7 0x0>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+
+	mwifiex: wifi@1 {
+		compatible =3D "brcm,bcm4329-fmac";
+		reg =3D <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/arm=
64/boot/dts/blaize/blaize-blzp1600-som.dtsi
new file mode 100644
index 000000000000..39790ae19a2c
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include "blaize-blzp1600.dtsi"
+
+/ {
+	memory@1000 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x00001000 0xfffff000>;
+	};
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		bootargs =3D "earlycon";
+		stdout-path =3D "serial0:115200";
+	};
+};
+
+&gsp {
+	blaize,power-limit-peak =3D <27001>;	/* Power in mW */
+};
+
+&i2c4 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	hwmon-ina3221@40 {
+		compatible =3D "ti,ina3221";
+		reg =3D <0x40>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		input@0 {
+			reg =3D <0x0>;
+			label =3D "dual-rail1-1v1-1v8";
+			shunt-resistor-micro-ohms =3D <1000>;
+		};
+		input@1 {
+			reg =3D <0x1>;
+			label =3D "single-rail1-0v8";
+			shunt-resistor-micro-ohms =3D <25000>;
+		};
+		input@2 {
+			reg =3D <0x2>;
+			label =3D "dual-rail2-1v1-1v8";
+			shunt-resistor-micro-ohms =3D <1000>;
+		};
+	};
+
+	hwmon-lm96063@4c {
+		compatible =3D "national,lm96163";
+		reg =3D <0x4c>;
+	};
+};
+
+&spim {
+	status =3D "okay";
+
+	flash@0 {
+		compatible =3D "jedec,spi-nor";
+		spi-max-frequency =3D <1000000>;
+		reg =3D <0>;
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+
+			fip@0 {
+				label =3D "fip";
+				reg =3D <0x0000000 0xe0000>;
+				read-only;
+			};
+
+			uboot-env@e0000 {
+				label =3D "u-boot-env";
+				reg =3D <0xe0000 0x10000>;
+			};
+
+			dtb@f0000 {
+				label =3D "dtb";
+				reg =3D <0xf0000 0x10000>;
+			};
+
+			image@100000 {
+				label =3D "linux";
+				reg =3D <0x100000 0x800000>;
+			};
+
+			rfs@900000 {
+				label =3D "rfs";
+				reg =3D <0x900000 0x3700000>;
+			};
+		};
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64/b=
oot/dts/blaize/blaize-blzp1600.dtsi
new file mode 100644
index 000000000000..5641a95795dc
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
@@ -0,0 +1,894 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/blaize,blzp1600-reset.h>
+#include <dt-bindings/clock/blaize,blzp1600-clk.h>
+
+/ {
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			compatible =3D "arm,cortex-a53";
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			reg =3D <0x0 0x0>;
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible =3D "arm,cortex-a53";
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			reg =3D <0x0 0x1>;
+			next-level-cache =3D <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-level =3D <2>;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D /* Physical Secure PPI */
+			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Physical Non-Secure PPI */
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Hypervisor PPI */
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Virtual PPI */
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	hwmon {
+		compatible =3D "blaize,blzp1600-hwmon";
+		clocks =3D <&scmi_clk BLZP1600_TSENSOR_CLK>;
+		resets =3D <&scmi_rst BLZP1600_TSENSOR_RST>;
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a53-pmu";
+		interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity =3D <&cpu0>, <&cpu1>;
+	};
+
+	sram@0 {
+		/*
+		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
+		 * A small DDR memory space has been reserved for general use.
+		 */
+		compatible =3D "mmio-sram";
+		reg =3D <0x0 0x00000000 0x00001000>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges =3D <0 0x0 0x00000000 0x1000>;
+
+		/* SCMI reserved buffer space on DDR space */
+		scmi0_shm: scmi-sram@800 {
+			compatible =3D "arm,scmi-shmem";
+			reg =3D <0x800 0x80>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible =3D "arm,scmi-smc";
+			arm,smc-id =3D <0x82002000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			status =3D "okay";
+			shmem =3D <&scmi0_shm>;
+
+			scmi_clk: protocol@14 {
+				reg =3D <0x14>;
+				#clock-cells =3D <1>;
+			};
+			scmi_rst: protocol@16 {
+				reg =3D <0x16>;
+				#reset-cells =3D <1>;
+			};
+		};
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <1>;
+		ranges;
+
+		spim: spi@200300000 {
+			compatible =3D "snps,dw-apb-ssi";
+			reg =3D <0x2 0x00300000 0x10000>;
+			clocks =3D  <&scmi_clk BLZP1600_QSPI_CLK>,
+				  <&scmi_clk BLZP1600_QSPI_PCLK>;
+			clock-names =3D "ssi_clk", "pclk";
+			resets =3D <&scmi_rst BLZP1600_QSPI_RST>,
+				 <&scmi_rst BLZP1600_QSPI_PRST>;
+			reset-names =3D "spi", "pspi";
+			interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width =3D <4>;
+			num-cs =3D <3>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		gic: interrupt-controller@200410000 {
+			compatible =3D "arm,gic-400";
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			reg =3D <0x2 0x00410000 0x20000>,
+			      <0x2 0x00420000 0x20000>,
+			      <0x2 0x00440000 0x20000>,
+			      <0x2 0x00460000 0x20000>;
+			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
+						 IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		public_soc_registers: syscon@200490000 {
+			compatible =3D "blaize,blzp1600-sys", "syscon";
+			reg =3D <0x2 0x00490000 0x5000>;
+		};
+
+		csitx0_dphy: csitx0-dphy@200492000 {
+			compatible =3D "samsung,ln14lpp-mipi-dphy";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>,
+				 <&scmi_clk BLZP1600_SRC_CSID_CLK>;
+			clock-names =3D "pclk", "byte_clk";
+			samsung,syscon =3D <&public_soc_registers 0x2000>;
+			samsung,phy-master;
+			#phy-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		dsi0_dphy: dsi0-dphy@200492030 {
+			compatible =3D "samsung,ln14lpp-mipi-dphy";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>,
+				 <&scmi_clk BLZP1600_SRC_DSI_CLK>;
+			clock-names =3D "pclk", "byte_clk";
+			samsung,syscon =3D <&public_soc_registers 0x2030>;
+			samsung,phy-master;
+			#phy-cells =3D <0>;
+			resets =3D <&dsi 0>;
+			reset-names =3D "dphy-reset";
+			status =3D "disabled";
+		};
+
+		csirx0_dphy: csirx0-dphy@200492060 {
+			compatible =3D "samsung,ln14lpp-mipi-dphy";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>;
+			clock-names =3D "pclk";
+			samsung,syscon =3D <&public_soc_registers 0x2060>;
+			samsung,phy-slave;
+			#phy-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		csirx1_dphy: csirx1-dphy@200492070 {
+			compatible =3D "samsung,ln14lpp-mipi-dphy";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>;
+			clock-names =3D "pclk";
+			samsung,syscon =3D <&public_soc_registers 0x2070>;
+			samsung,phy-slave;
+			#phy-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		csirx2_dphy: csirx2-dphy@200492080 {
+			compatible =3D "samsung,ln14lpp-mipi-dphy";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>;
+			clock-names =3D "pclk";
+			samsung,syscon =3D <&public_soc_registers 0x2080>;
+			samsung,phy-slave;
+			#phy-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		csirx3_dphy: csirx3-dphy@200492090 {
+			compatible =3D "samsung,ln14lpp-mipi-dphy";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>;
+			clock-names =3D "pclk";
+			samsung,syscon =3D <&public_soc_registers 0x2090>;
+			samsung,phy-slave;
+			#phy-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		watchdog0: watchdog@2004b0000 {
+			compatible =3D "vsi,wdt";
+			reg =3D <0x2 0x004b0000 0x1000>;
+			clocks =3D <&scmi_clk BLZP1600_NIC_HALF_CLK>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec =3D <10>;
+		};
+
+		gpio0: gpio@2004c0000 {
+			compatible =3D "vsi,apb-gpio-0.2";
+			reg =3D <0x2 0x004c0000 0x1000>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			ngpios =3D <32>;
+			interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+			status =3D "disabled";
+		};
+
+		uart0: serial@2004d0000 {
+			compatible =3D "ns16550a";
+			device_type =3D "serial";
+			reg =3D <0x2 0x004d0000 0x1000>;
+			clocks =3D <&scmi_clk BLZP1600_UART0_CLK>;
+			resets =3D <&scmi_rst BLZP1600_UART0_RST>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@2004e0000 {
+			compatible =3D "ns16550a";
+			device_type =3D "serial";
+			reg =3D <0x2 0x004e0000 0x1000>;
+			clocks =3D <&scmi_clk BLZP1600_UART1_CLK>;
+			resets =3D <&scmi_rst BLZP1600_UART1_RST>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c0: i2c@2004f0000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x004f0000 0x1000>;
+			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C0_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C0_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			dmas =3D <&axi_dmac 5>, <&axi_dmac 0>;
+			dma-names =3D "tx", "rx";
+			snps,dma-mask =3D <64>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@200500000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00500000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C1_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C1_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			dmas =3D <&axi_dmac 6>, <&axi_dmac 1>;
+			dma-names =3D "tx", "rx";
+			snps,dma-mask =3D <64>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@200510000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00510000 0x1000>;
+			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C2_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C2_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			dmas =3D <&axi_dmac 7>, <&axi_dmac 2>;
+			dma-names =3D "tx", "rx";
+			snps,dma-mask =3D <64>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@200520000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00520000 0x1000>;
+			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C3_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C3_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			dmas =3D <&axi_dmac 8>, <&axi_dmac 3>;
+			dma-names =3D "tx", "rx";
+			snps,dma-mask =3D <64>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@200530000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00530000 0x1000>;
+			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C4_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C4_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			dmas =3D <&axi_dmac 9>, <&axi_dmac 4>;
+			dma-names =3D "tx", "rx";
+			snps,dma-mask =3D <64>;
+			status =3D "disabled";
+		};
+
+		arm_cc712: crypto@200550000 {
+			compatible =3D "arm,cryptocell-712-ree";
+			reg =3D <0x2 0x00550000 0x1000>;
+			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 7>;
+		};
+
+		gsp: gsp@2005b0000 {
+			compatible =3D "blaize,blzp1600-gsp";
+			reg =3D <0x2 0x005b0000 0x1000>;
+			interrupts =3D <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>;
+			clocks =3D <&scmi_clk BLZP1600_GSP_CLK>;
+			clock-names =3D "gsp_ref_clk";
+			resets =3D <&scmi_rst BLZP1600_GSP_RST>;
+			reset-names =3D "gsp_rst";
+		};
+
+		gmac: ethernet@200640000 {
+			compatible =3D "snps,dwmac";
+			reg =3D <0x2 0x640000 0x8000>;
+			interrupts =3D <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "macirq";
+			rx-fifo-depth =3D <4096>;
+			tx-fifo-depth =3D <4096>;
+			max-frame-size =3D <2030>;
+			clocks =3D <&scmi_clk BLZP1600_ETH_MAC_CLK>,
+				 <&scmi_clk BLZP1600_ETH_MAC_M_CLK>;
+			clock-names =3D "stmmaceth", "pclk";
+			resets =3D <&scmi_rst BLZP1600_ETH_MAC_RST>;
+			reset-names =3D "stmmaceth";
+			snps,pbl =3D <2>; // Maximum Burst Length 16.
+			snps,axi-config =3D <&stmmac_axi_setup>;
+			status =3D "disabled";
+		};
+
+		video_encoder: video-encoder@200650000 {
+			compatible =3D "blaize,blzp1600-encoder", "vsi,vc8000e";
+			reg =3D <0x2 0x650000 0x1000>;
+			interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "encoder";
+			clocks =3D <&scmi_clk BLZP1600_VIDEO_E_CLK>,
+				 <&scmi_clk BLZP1600_NIC_CLK>,
+				 <&scmi_clk BLZP1600_NIC_HALF_CLK>;
+			clock-names =3D "core", "axi", "apb";
+			resets =3D <&scmi_rst BLZP1600_VIDEO_E_RST>,
+				 <&scmi_rst BLZP1600_VIDEO_E_REORDER_RST>;
+		};
+
+		video_decoder: video-decoder@200660000 {
+			compatible =3D "blaize,blzp1600-decoder", "vsi,vc8000d";
+			reg =3D <0x2 0x00660000 0x800>;
+			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "decoder", "decoder_l2";
+			clocks =3D <&scmi_clk BLZP1600_VIDEO_D_CLK>,
+				 <&scmi_clk BLZP1600_NIC_CLK>,
+				 <&scmi_clk BLZP1600_NIC_HALF_CLK>;
+			clock-names =3D "core", "axi", "apb";
+			resets =3D <&scmi_rst BLZP1600_VIDEO_D_RST>,
+				 <&scmi_rst BLZP1600_VIDEO_D_REORDER_RST>,
+				 <&scmi_rst BLZP1600_VIDEO_D_L2_RST>;
+		};
+
+		dpi_dma: dpi-dma@200670000 {
+			compatible =3D "blaize,blzp1600-drm-dma";
+			reg =3D <0x2 0x00670000 0x1000>;
+			interrupts =3D <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>;
+			resets =3D <&scmi_rst BLZP1600_DSI_VDMA_RST>;
+			reset-names =3D "dpi_dma_rst";
+			clocks =3D <&scmi_clk BLZP1600_DSI_VDMA_CLK>;
+			clock-names =3D "dpi_dma_clk";
+			status =3D "disabled";
+
+			port {
+				dpi_out: endpoint {
+					remote-endpoint =3D <&dsi_in>;
+				};
+			};
+		};
+
+		csirx0_vdma: csi-rx-vdma@200680000 {
+			compatible =3D "blaize,csirx-vdma-blzp1600";
+			reg =3D <0x2 0x00680000 0x1000>;
+			interrupts =3D <GIC_SPI 42 IRQ_TYPE_EDGE_RISING>;
+			clocks =3D <&scmi_clk BLZP1600_CSI0_VDMA_CLK>;
+			clock-names =3D "dma_clk";
+			resets =3D <&scmi_rst BLZP1600_CSI0_VDMA_RST>;
+
+			status =3D "disabled";
+			port@0 {
+				csi0_rx_in: endpoint {
+					remote-endpoint =3D <&csi0_out>;
+				};
+			};
+		};
+
+		csirx1_vdma: csi-rx-vdma@200690000 {
+			compatible =3D "blaize,csirx-vdma-blzp1600";
+			reg =3D <0x2 0x00690000 0x1000>;
+			interrupts =3D <GIC_SPI 43 IRQ_TYPE_EDGE_RISING>;
+			clocks =3D <&scmi_clk BLZP1600_CSI1_VDMA_CLK>;
+			clock-names =3D "dma_clk";
+			resets =3D <&scmi_rst BLZP1600_CSI1_VDMA_RST>;
+
+			status =3D "disabled";
+			port@0 {
+				csi1_rx_in: endpoint {
+					remote-endpoint =3D <&csi1_out>;
+				};
+			};
+		};
+
+		csirx2_vdma: csi-rx-vdma@2006a0000 {
+			compatible =3D "blaize,csirx-vdma-blzp1600";
+			reg =3D <0x2 0x006a0000 0x1000>;
+			interrupts =3D <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>;
+			clocks =3D <&scmi_clk BLZP1600_CSI2_VDMA_CLK>;
+			clock-names =3D "dma_clk";
+			resets =3D <&scmi_rst BLZP1600_CSI2_VDMA_RST>;
+
+			status =3D "disabled";
+			port@0 {
+				csi2_rx_in: endpoint {
+					remote-endpoint =3D <&csi2_out>;
+				};
+			};
+		};
+
+		csirx3_vdma: csi-rx-vdma@2006b0000 {
+			compatible =3D "blaize,csirx-vdma-blzp1600";
+			reg =3D <0x2 0x006b0000 0x1000>;
+			interrupts =3D <GIC_SPI 45 IRQ_TYPE_EDGE_RISING>;
+			clocks =3D <&scmi_clk BLZP1600_CSI3_VDMA_CLK>;
+			clock-names =3D "dma_clk";
+			resets =3D <&scmi_rst BLZP1600_CSI3_VDMA_RST>;
+
+			status =3D "disabled";
+			port@0 {
+				csi3_rx_in: endpoint {
+					remote-endpoint =3D <&csi3_out>;
+				};
+			};
+		};
+
+		csitx0_vdma: csi-tx-vdma@2006c0000 {
+			compatible =3D "blaize,csitx-vdma-blzp1600";
+			reg =3D <0x2 0x006c0000 0x1000>;
+			interrupts =3D <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
+			clocks =3D <&scmi_clk BLZP1600_CSID_VDMA_CLK>;
+			clock-names =3D "dma_clk";
+			resets =3D <&scmi_rst BLZP1600_CSID_VDMA_RST>;
+
+			status =3D "disabled";
+			port {
+				csid_tx_out: endpoint {
+					remote-endpoint =3D <&csid_in>;
+				};
+			};
+		};
+
+		csirx0: csi-rx@2006e0000 {
+			compatible =3D "snps,mipi-csi2h";
+			reg =3D <0x2 0x006e0000 0x1000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_CSI0_CTRL_CLK>,
+				 <&scmi_clk BLZP1600_CSI0_VDMA_CLK>;
+			clock-names =3D "csi2", "pix";
+			resets =3D <&scmi_rst BLZP1600_CSI0_CTRL_RST>;
+			snps,cut-through-mode;
+			phys =3D <&csirx0_dphy>;
+			phy-names =3D "dphy";
+
+			status =3D "disabled";
+
+			port@0 {
+				reg =3D <0>;
+				csi0_in: endpoint {
+					// board specific
+				};
+			};
+
+			port@1 {
+				reg =3D <1>;
+				csi0_out: endpoint {
+					remote-endpoint =3D <&csi0_rx_in>;
+				};
+			};
+		};
+
+		csirx1: csi-rx@2006f0000 {
+			compatible =3D "snps,mipi-csi2h";
+			reg =3D <0x2 0x006f0000 0x1000>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_CSI1_CTRL_CLK>,
+				 <&scmi_clk BLZP1600_CSI1_VDMA_CLK>;
+			clock-names =3D "csi2", "pix";
+			resets =3D <&scmi_rst BLZP1600_CSI1_CTRL_RST>;
+			snps,cut-through-mode;
+			phys =3D <&csirx1_dphy>;
+			phy-names =3D "dphy";
+
+			status =3D "disabled";
+
+			port@0 {
+				reg =3D <0>;
+				csi1_in: endpoint {
+					// board specific
+				};
+			};
+
+			port@1 {
+				reg =3D <1>;
+				csi1_out: endpoint {
+					remote-endpoint =3D <&csi1_rx_in>;
+				};
+			};
+		};
+
+		csirx2: csi-rx@200700000 {
+			compatible =3D "snps,mipi-csi2h";
+			reg =3D <0x2 0x00700000 0x1000>;
+			interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_CSI2_CTRL_CLK>,
+				 <&scmi_clk BLZP1600_CSI2_VDMA_CLK>;
+			clock-names =3D "csi2", "pix";
+			resets =3D <&scmi_rst BLZP1600_CSI2_CTRL_RST>;
+			snps,cut-through-mode;
+			phys =3D <&csirx2_dphy>;
+			phy-names =3D "dphy";
+
+			status =3D "disabled";
+
+			port@0 {
+				reg =3D <0>;
+				csi2_in: endpoint {
+					// board specific
+				};
+			};
+
+			port@1 {
+				reg =3D <1>;
+				csi2_out: endpoint {
+					remote-endpoint =3D <&csi2_rx_in>;
+				};
+			};
+		};
+
+		csirx3: csi-rx@200710000 {
+			compatible =3D "snps,mipi-csi2h";
+			reg =3D <0x2 0x00710000 0x1000>;
+			interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_CSI3_CTRL_CLK>,
+				 <&scmi_clk BLZP1600_CSI3_VDMA_CLK>;
+			clock-names =3D "csi2", "pix";
+			resets =3D <&scmi_rst BLZP1600_CSI3_CTRL_RST>;
+			snps,cut-through-mode;
+			phys =3D <&csirx3_dphy>;
+			phy-names =3D "dphy";
+
+			status =3D "disabled";
+
+			port@0 {
+				reg =3D <0>;
+				csi3_in: endpoint {
+					// board specific
+				};
+			};
+
+			port@1 {
+				reg =3D <1>;
+				csi3_out: endpoint {
+					remote-endpoint =3D <&csi3_rx_in>;
+				};
+			};
+		};
+
+		dsi: dsi@2006d0000 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "blaize,blzp1600-drm-dsi";
+			reg =3D <0x2 0x006d0000 0x1000>;
+			clocks =3D <&scmi_clk BLZP1600_DSI_CTRL_CLK>,
+				 <&scmi_clk BLZP1600_SRC_XTAL_CLK>,
+				 <&scmi_clk BLZP1600_DSI_VDMA_CLK>;
+			clock-names =3D "pclk", "ref", "dpipclk";
+			resets =3D <&scmi_rst BLZP1600_DSI_CTRL_RST>;
+			reset-names =3D "dsi";
+			interrupts =3D <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+			phys =3D <&dsi0_dphy>;
+			phy-names =3D "dphy";
+			#reset-cells =3D <1>;
+
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				/* 0 for input port */
+				port@0 {
+					reg =3D <0>;
+					dsi_in: endpoint {
+						remote-endpoint =3D <&dpi_out>;
+					};
+				};
+				/* 1 for output port */
+				port@1 {
+					reg =3D <1>;
+					dsi_out: endpoint {
+						//remote-endpoint =3D <&dsi_display_in>;
+					};
+				};
+			};
+
+			dsi_panel_0: dsi-panel@0 {
+				reg =3D <0>; /* dsi virtual channel (0..3) */
+				status =3D "disabled";
+			};
+		};
+
+		csitx0: csi-tx@200720000 {
+			compatible =3D "snps,mipi-csi2d";
+			reg =3D <0x2 0x00720000 0x1000>;
+			interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_CSID_CTRL_CLK>,
+				 <&scmi_clk BLZP1600_CSID_VDMA_CLK>;
+			clock-names =3D "pclk", "pix";
+			resets =3D <&scmi_rst BLZP1600_CSID_CTRL_RST>;
+			snps,cut-through-mode;
+			snps,master;
+			phys =3D <&csitx0_dphy>;
+			phy-names =3D "dphy";
+
+			status =3D "disabled";
+
+			port@0 {
+				reg =3D <0>;
+				csid_in: endpoint {
+					remote-endpoint =3D <&csid_tx_out>;
+				};
+			};
+
+			port@1 {
+				reg =3D <1>;
+				csid_out: endpoint {
+					/* Board must set data-lanes */
+					bus-type =3D <0>;
+				};
+			};
+		};
+
+		i2s_master: i2s@200730000 {
+			compatible =3D "snps,designware-i2s";
+			reg =3D <0x2 0x00730000 0x1000>;
+			#sound-dai-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_I2S_MASTER_CLK>,
+				 <&scmi_clk BLZP1600_I2S_TX_CLK>;
+			clock-names =3D "i2sclk", "i2s_pclk";
+			resets =3D <&scmi_rst BLZP1600_I2S_TX_RST>;
+			dmas =3D <&axi_dmac 13>;
+			dma-names =3D "tx";
+			status =3D "disabled";
+		};
+
+		i2s_slave: i2s@200740000 {
+			compatible =3D "snps,designware-i2s";
+			reg =3D <0x2 0x00740000 0x1000>;
+			#sound-dai-cells =3D <0>;
+			clocks =3D <&scmi_clk BLZP1600_I2S_RX_CLK>;
+			clock-names =3D "i2s_pclk";
+			resets =3D <&scmi_rst BLZP1600_I2S_RX_RST>;
+			dmas =3D <&axi_dmac 12>;
+			dma-names =3D "rx";
+			status =3D "disabled";
+		};
+
+		axi_dmac: dma-controller@200750000 {
+			compatible =3D "snps,axi-dma-1.02a";
+			reg =3D <0x2 0x00750000 0x10000>;
+			clocks =3D <&scmi_clk BLZP1600_DMA_CLK>,
+				 <&scmi_clk BLZP1600_NIC_HALF_CLK>;
+			clock-names =3D "core-clk", "cfgr-clk";
+			resets =3D <&scmi_rst BLZP1600_DMA_RST>;
+			interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =3D <16>;
+			snps,dma-masters =3D <1>;
+			snps,data-width =3D <4>;
+			snps,block-size =3D <8192 8192 8192 8192
+					   8192 8192 8192 8192
+					   8192 8192 8192 8192
+					   8192 8192 8192 8192>;
+			snps,priority =3D <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>;
+			snps,axi-max-burst-len =3D <16>;
+			snps,no-mem-to-mem-trans;
+			snps,dev-to-mem-trans;
+			snps,dma-cyclic;
+			snps,max-supported-channels =3D <16>;
+			#dma-cells =3D <1>;
+		};
+
+		sd: sdhci@200760000 {
+			compatible =3D "blaize,blzp1600-sdhci";
+			reg =3D <0x2 0x00760000 0x1000>;
+			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_NIC_HALF_CLK>,
+				 <&scmi_clk BLZP1600_SD_CARD_CLK>;
+			clock-names =3D "core", "bus";
+			resets =3D <&scmi_rst BLZP1600_SD_CARD_RST>;
+			fifo-depth =3D <8>;
+			bus-width =3D <4>;
+			blaize,syscon =3D <&public_soc_registers 0x4000>;
+			status =3D "disabled";
+		};
+
+		canfd0: canfd@200770000 {
+			compatible =3D "fraunhofer,canfd";
+			reg =3D <0x2 0x00770000 0x10000>;
+			interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_CAN0_CLK>;
+			clock-names =3D "can";
+			resets =3D <&scmi_rst BLZP1600_CAN0_RST>;
+			reset-names =3D "can";
+			status =3D "disabled";
+		};
+
+		canfd1: canfd@200780000 {
+			compatible =3D "fraunhofer,canfd";
+			reg =3D <0x2 0x00780000 0x10000>;
+			interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_CAN1_CLK>;
+			clock-names =3D "can";
+			resets =3D <&scmi_rst BLZP1600_CAN1_RST>;
+			reset-names =3D "can";
+			status =3D "disabled";
+		};
+
+		canfd2: canfd@200790000 {
+			compatible =3D "fraunhofer,canfd";
+			reg =3D <0x2 0x00790000 0x10000>;
+			interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_CAN2_CLK>;
+			clock-names =3D "can";
+			resets =3D <&scmi_rst BLZP1600_CAN2_RST>;
+			reset-names =3D "can";
+			status =3D "disabled";
+		};
+
+		sdio0: sdhci@2007a0000 {
+			compatible =3D "blaize,blzp1600-sdhci";
+			reg =3D <0x2 0x007a0000 0x1000>;
+			interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_NIC_HALF_CLK>,
+				 <&scmi_clk BLZP1600_SDIO0_CLK>;
+			clock-names =3D "core", "bus";
+			resets =3D <&scmi_rst BLZP1600_SDIO0_RST>;
+			fifo-depth =3D <8>;
+			bus-width =3D <4>;
+			blaize,syscon =3D <&public_soc_registers 0x4100>;
+			status =3D "disabled";
+		};
+
+		sdio1: sdhci@2007b0000 {
+			compatible =3D "blaize,blzp1600-sdhci";
+			reg =3D <0x2 0x007b0000 0x1000>;
+			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_NIC_HALF_CLK>,
+				 <&scmi_clk BLZP1600_SDIO1_CLK>;
+			clock-names =3D "core", "bus";
+			resets =3D <&scmi_rst BLZP1600_SDIO1_RST>;
+			fifo-depth =3D <8>;
+			bus-width =3D <4>;
+			blaize,syscon =3D <&public_soc_registers 0x4200>;
+			status =3D "disabled";
+		};
+
+		sdio2: sdhci@2007c0000 {
+			compatible =3D "blaize,blzp1600-sdhci";
+			reg =3D <0x2 0x007c0000 0x1000>;
+			interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_NIC_HALF_CLK>,
+				 <&scmi_clk BLZP1600_SDIO2_CLK>;
+			clock-names =3D "core", "bus";
+			resets =3D <&scmi_rst BLZP1600_SDIO2_RST>;
+			fifo-depth =3D <8>;
+			bus-width =3D <4>;
+			blaize,syscon =3D <&public_soc_registers 0x4300>;
+			status =3D "disabled";
+		};
+
+		spis: spi@2007d0000 {
+			compatible =3D "snps,dw-apb-ssi";
+			reg =3D <0x2 0x007d0000 0x10000>;
+			clocks =3D <&scmi_clk BLZP1600_SPIS_CLK>,
+				 <&scmi_clk BLZP1600_SPIS_PCLK>;
+			clock-names =3D  "ssi_clk", "pclk";
+			resets =3D <&scmi_rst BLZP1600_SPIS_RST>,
+				 <&scmi_rst BLZP1600_SPIS_PRST>;
+			reset-names =3D "spi", "pspi";
+			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width =3D <4>;
+			spi-slave;
+			#address-cells =3D <0>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		usb3: usb3@200840000 {
+			compatible =3D "blaize,blzp1600-dwc3";
+			reg =3D <0x2 0x00840000 0x10000>;
+			#address-cells =3D <2>;
+			#size-cells =3D <1>;
+			ranges;
+			clocks =3D <&scmi_clk BLZP1600_USB_PHY_CLK>;
+			clock-names =3D "phy_clk";
+			resets =3D <&scmi_rst BLZP1600_USB_PHY_RST>;
+			reset-names =3D "phy_rst";
+			status =3D "disabled";
+
+			dwc3: usb@200840000 {
+				compatible =3D "snps,dwc3";
+				reg =3D <0x2 0x00840000 0x10000>;
+				interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&scmi_clk BLZP1600_SRC_XTAL_CLK>,
+					 <&scmi_clk BLZP1600_USB_CLK>,
+					 <&scmi_clk BLZP1600_SRC_XTAL_CLK>;
+				clock-names =3D "ref", "bus_early", "suspend";
+				resets =3D <&scmi_rst BLZP1600_USB_RST>;
+				dr_mode =3D "host";
+				snps,dis-ref-clk-sof-quirk;
+				phy_type =3D "utmi_wide";
+			};
+		};
+	};
+
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,wr_osr_lmt =3D <0xf>;
+		snps,rd_osr_lmt =3D <0xf>;
+		snps,blen =3D <0 0 0 0 16 8 4>;
+	};
+};
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..6eab5c65476e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -39,6 +39,7 @@ CONFIG_ARCH_BCM2835=3Dy
 CONFIG_ARCH_BCMBCA=3Dy
 CONFIG_ARCH_BCM_IPROC=3Dy
 CONFIG_ARCH_BERLIN=3Dy
+CONFIG_ARCH_BLAIZE_BLZP1600=3Dy
 CONFIG_ARCH_BRCMSTB=3Dy
 CONFIG_ARCH_EXYNOS=3Dy
 CONFIG_ARCH_K3=3Dy
--=20
2.25.1

