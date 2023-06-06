Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06472379F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjFFG0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjFFGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:25:48 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A61738;
        Mon,  5 Jun 2023 23:24:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3566O1c9116622;
        Tue, 6 Jun 2023 01:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686032641;
        bh=1oF8jYUUOFXRvok3JCIbs1nq6NypvZAwnqD3d/2He+U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=g30x9dBF1zC36PjMPwA0ig95TppWAlatcYk4tDbenNbbuWS3jWW4jQ7KTMM7kEj9g
         V+l4yCgwT8rrQ5YV2dqJF/3ld+/ubIBJf2y+3kWIodN44kBfNYjrc34FvBJo8L7u8Q
         qdnOTPPspSzjNxvgUTM1U2V/4HoMf4v+nZPL23nU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3566O1ex060770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 01:24:01 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 01:24:01 -0500
Received: from DLEE105.ent.ti.com ([fe80::d8b7:9c27:242c:8236]) by
 DLEE105.ent.ti.com ([fe80::d8b7:9c27:242c:8236%17]) with mapi id
 15.01.2507.023; Tue, 6 Jun 2023 01:24:01 -0500
From:   "Raja, M Sinthu" <sinthu.raja@ti.com>
To:     "Menon, Nishanth" <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kumar, Udit" <u-kumar1@ti.com>, "Yadav, Nitin" <n-yadav@ti.com>,
        "Francis, Neha" <n-francis@ti.com>
Subject: Re: [PATCH 4/6] arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0
 and eeprom
Thread-Topic: [PATCH 4/6] arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0
 and eeprom
Thread-Index: AQHZlWftKL498kU7mk6eWjSIJ3iMGa99U6jD
Date:   Tue, 6 Jun 2023 06:24:01 +0000
Message-ID: <3eb70e7f2aed4d7893714c9f5ddc70c1@ti.com>
References: <20230602153554.1571128-1-nm@ti.com>,<20230602153554.1571128-5-nm@ti.com>
In-Reply-To: <20230602153554.1571128-5-nm@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.134.136]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,




From: Menon, Nishanth
Sent: Friday, June 2, 2023 9:05 PM
To: Conor Dooley; Krzysztof Kozlowski; Rob Herring; Tero Kristo; Raghavendr=
a, Vignesh
Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-ker=
nel@lists.infradead.org; Menon, Nishanth; Kumar, Udit; Yadav, Nitin; Franci=
s, Neha; Raja, M Sinthu
Subject: [PATCH 4/6] arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0 and=
 eeprom
=A0  =20
Enable wakeup_i2c. While at it, describe the board detection eeprom
present on the board.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
new patch

=A0arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 22 ++++++++++++++++++++++
=A01 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am68-sk-som.dtsi
index e92431250729..e2c80fff7478 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -27,3 +27,25 @@ secure_ddr: optee@9e800000 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
=A0=A0=A0=A0=A0=A0=A0=A0 };
=A0};
+
+&wkup_pmx2 {
+=A0=A0=A0=A0=A0=A0 wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-single,pins =3D <
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 J721S2_=
WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 J721S2_=
WKUP_IOPAD(0x09c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;
+=A0=A0=A0=A0=A0=A0 };
+};
+
+&wkup_i2c0 {
+=A0=A0=A0=A0=A0=A0 status =3D "okay";
+=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";
+=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&wkup_i2c0_pins_default>;
+=A0=A0=A0=A0=A0=A0 clock-frequency =3D <400000>;
+
+=A0=A0=A0=A0=A0=A0 eeprom@51 {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* AT24C512C-MAHM-T */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "atmel,24c512";
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x51>;
+=A0=A0=A0=A0=A0=A0 };
+};

LGTM

Reviewed-by: Sinthu Raja <sinthu.raja@ti.com>

--=20
2.40.0

    =
