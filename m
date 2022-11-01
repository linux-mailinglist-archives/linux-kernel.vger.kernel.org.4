Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F66147B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKAK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:29:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FDF19022;
        Tue,  1 Nov 2022 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667298568; bh=llVHE5GLaohYprJdz/Wwa2hAREpdRRrX0D42e625sXg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kxfAziLxH9jY+uvFYguQT8bTyevy1B7N/nvWp1213fySxSnfWXaAScGRAVmhQiRUs
         4UFflRdhWz1veWantwUenFxZIe0QiysD9M2It6HzTCTENR/d+EayeuGJcdu1qnDkNQ
         fwAnlF2DqtSjVUP18hiko72NIOtSwneCq9ZXDqYULOLYpwl1l9EgtDXpA1QsYfu2tC
         WfXGpRtW2QLIHFyPrheBi9Q/a+l8sC1wpKTQbmMXZpn9X8QSSKBFTy+Gf3v09+9PXP
         ldnYl+34DL2ryW2DchPgzve42nb8l8PxoVXbut3U+BHdPDEa7FE9ZZggHzOprIJYL+
         VeOFfhWGJZQHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1ov1SN2twx-005MKc; Tue, 01
 Nov 2022 11:29:28 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add GPIO line names
Date:   Tue,  1 Nov 2022 11:29:16 +0100
Message-Id: <20221101102916.440526-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUE/KizgL9d9cQnhr7IpsrDX/mCGPfE/BdLnY3pG7aED8M8rCbT
 JL0ZTn3+gSbB9ypsqvR75mGyfq3XpfN1GU/JMK1fTMDHAIKKbk0/gq9YNObUsk2odPOT2tx
 IpssYqTkBxVO+4yggXqrFLZK03nQzRf5YV0Xcusg/SheiaBQe/OxvQKn+dC36i4KR25K6j4
 Itre+bb4C3f0rQ77qNbUg==
UI-OutboundReport: notjunk:1;M01:P0:/Tv77Y5Rs5k=;Dn3sWwI3bi+sanQVb4PzkD0REVH
 D6Pdg4T2BtnfJeFg3JxXLmV7aVQsHCN5OjBdh9R9oNmrQrkn/NEEhQzTmefuirc9SyD62HuuS
 6nlcz0AlIB+T4GjnJmcG32lklfBUw0cZSVr/oLptkk+9NtNACH08G85aBdFceSx5ns7KkJ4FN
 l02DPmrNFMeCiI9TjPKo3Q2vjjE+LuH0+GVXkF3KFN6mJjk6DYNSXze4VNRSgmJY3fGz4pGSU
 Do5kOBRb1zj3gkflXaJJbjAWapClDzdOxEBLzm5oyN1CgpWUnpJSMieJxFDrFp5RiTeeDjUy1
 owybtIcmDEfivAatf2DbkCy3la/aJEwrithKcTHsUOhsEdVs1cpsHAMGaBqAar7A5gfQ+WpXg
 Ej3Jmjb/2nWFOxzhKXEmf6g0iDmvMXJ+zrR9Mnl7lT6KFXU26baAx0Fxf/bsnNob9q0Hq9RHO
 GlAGnJ9jeMtYvUFEFT/4IElv23Fgp4BJPkrOzWbLxQ4fCgdidAickI2vweDjJKxHTOyU3hjYi
 /FNg4G1eZnZVhOxTDI+CWHemAduglmvzQg18doaQXbBldt/HPbSzdmvPcjZKkFUNUo8g5MFPF
 7WeWPnDIc31nhAb+ZEEPeT+Rax14MJ2EdRuDXUL2SgKQoPocgrQSZpqS8hoohsBnlfrcNBJxJ
 hAKmLWQ/GwmW83JghPmOhV9ckb6ysWNplobbFPmAmGlgj4UHn5mNqNUd/eiaixBENmWomUnhA
 BTALrNKrPlUymFFuCuo/kGs8D9XrV6G+QYsdfIrwV/+Qoiq3z68FhDpB2OBjTUr+YCsTm40S/
 vkjH4Eqpl5jb19hzEEuh3RgrXJ56oGjlHg93j7u7V1GTD5w1Am7dszRy09qfZ+vCfuysraWWL
 mwThlmjBUyEjP4qrCbg7VzfsX+vsPlKAd9gfLfuBkqxexRk4jyXaz1U6fSzMy6JkMHWiZHI2T
 G+AthDT6mAmKXF/9GMCFxDdUh6I=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make gpioinfo output more useful and enable gpiofind usage, add line
names for GPIOs where the function is known.

This patch follows the naming convention defined for OpenBMC, as much as
possible:

  https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-nam=
ing.md

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts b=
/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
index 26fed97f8ff4a..d4472ffdac928 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
+++ b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
@@ -58,6 +58,24 @@ heartbeat {
 	};
 };

+&gpio0 {
+	gpio-line-names =3D
+		/* 0 */ "", "host-reset-control-n", "", "", "", "", "", "",
+		/* 8 */ "", "", "", "", "power-chassis-control-n", "", "uid-button", ""=
;
+};
+
+&gpio1 {
+	gpio-line-names =3D
+		/* 0 */ "", "", "", "", "led-heartbeat", "", "", "led-uid",
+		/* 8 */ "", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =3D
+		/* 0 */ "", "", "", "", "", "", "", "",
+		/* 8 */ "", "", "", "", "", "", "", "power-chassis-good";
+};
+
 &pinctrl {
 	key_pins: mux-keys {
 		groups =3D "gspi", "sspi";
=2D-
2.35.1

