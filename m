Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC7163BDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiK2KXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiK2KWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:22:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBDDF74;
        Tue, 29 Nov 2022 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669717359; bh=tCgpIcwmalgSx5qX5kzqlXYpLcTzbL9VQxyupLXaw8A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DM9DMtIkSyUhCSHewXFjGasoKBNheLeR3gikogX87cgw0WOXFLpUU3JFxrrit9n5u
         zrqmT4Hg/N5H/rwOcc045NWfjpgjx//7fsDTrbwC8qnus03qE1+1iuD9fyw93SBp6b
         9iR2DlUbDMyVoND6kAvolsCuLv9/M1W48VGRC+aN6LfK0v9u8QkXki1blEAK6m7cCv
         x/22XvWrMlLrDcfDRww0wA5eRB7TAkb1/v7PQyVyrYZYAZLP05ooE7z4P30jX6ZnwI
         NOcY7mzgYcaQYcwuhTWYP7jD1kHGuRLIZLHWqKShksg8Mf2nU6E2qOfrDDnQdgryr6
         v6PLroQVF4w1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9uU-1pI2qD19k2-00IG2C; Tue, 29
 Nov 2022 11:22:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing reg property)
Date:   Tue, 29 Nov 2022 11:22:25 +0100
Message-Id: <20221129102225.3598044-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129102225.3598044-1-j.neuschaefer@gmx.net>
References: <20221129102225.3598044-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37RMk8+HGcGRs4RthaIi7B02O6Es4HvsaRkekBdN3uGdbb9W+h6
 w/TxBKwJUAn/LIWYvS+ALmbCWH/uqNsUdER8fKxgK5kukwOO/IQRgChvKdKPVbxNLmthtxX
 FOUdvZJbpCE3E5Ax0xsTyYeqfAFkLy9bpHSzeMIGD/eFXPUAJjieo2KzwXMpDJl7JK9XTyJ
 a6MlPvtaZyJ5DcmQ2uBig==
UI-OutboundReport: notjunk:1;M01:P0:2kBgosZeI0g=;XxUd51KEo56pe33H/BWqf23JDVK
 t8LuwgMI6PcxP2WBKUKe3dhsR5/U9xLlgSuDRym3omKVXs4NElGix+3OgMzQ4nQHeC6/FvPTz
 PFBN3SWRRMF4bcHQqyUObvHB9l7KmivlphRgHoeTUJrWn6oAkK0srxToLNQJLaY85ZAVzv3k7
 DZwLp1JUQ7+1+DdScK0Df7Rhbuc49zSa+lcSAufouZ4gpVIPsCSF2PK4/LnHLD9WuaAZmod21
 HAD18Z8jbluOrds3n8OFeEYoWUFYO3J0SIUPgMbQanqS/11E4tf5H2xKtVrIXLzYnhxYk83vS
 PTHvAGxZ2/5hVAAHC19S/FvOGQ5krYuHTIGKgVSLY5FKkNFl9todDj4t8rSwTjuoiYjGS4b/J
 EAa431Ld3MtoWfMYHyNfisfFZdouDXq8ALl/0rzwjRX3SquEcbgxT/rEIgGHaKQCqexudRNIb
 aYDIFhnKiIsotgqncmKAmHFtJB/IMR56w06yeYrb3RBq0V2XczgtfEyJIA4b4zUQjpXQ8hTIE
 nK8pPhkr53PGg7rT+qtu3tryPF2VAvph5AKQmmgYPdtFBmpYH94EapyCi7d96RnYrWbJKz+SS
 SV1Eptuh8KbSHolJaKBF9wGXsQAeAQ68Qr33c0wqsMEQhaXlFuuClT2LZJej/HhAeM8Jn08l9
 JBrFQee7vyqsVjZcKlSjUNAfzhlnVX3zzPQsbB+c2cKCNbh994K6jFpg7MT1Yi0GUav+An3+S
 +B9LM2Mz+JsvoyjBqOSZGLe4Z2hbZHXAQZbGC3Qe30+ZkGPYgoqNrdgm7VdGIQtExSyi5o1/g
 JcxgM5kBNu0teaM5pkmmYho6O6vrIheMrS3gBGOJbKNZloVgauC0pRJEp31cXWbBOimf4zwLv
 qcfhH83spSbBISRGUoYoVLssMaBW/iTm/bFu3YKh540hbGMKu21UEKssu3C8WdmxJF/anXXgI
 ckY8yj4MITBBIwXr78LqgZNV2W0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing "reg =3D <0>;" property to the flash@0 node in the example.

Fixes: dd71cd4dd6c9b ("spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)=
 bindings")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
=2D--

v2:
- depersonalize commit message
- Add Krzysztof's R-b
=2D--
 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yam=
l b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
index e4162845fcc1d..4e0d391e1d697 100644
=2D-- a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
@@ -56,6 +56,7 @@ examples:

       flash@0 {
         compatible =3D "jedec,spi-nor";
+        reg =3D <0>;
       };
     };

=2D-
2.35.1

