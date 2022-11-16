Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE462CB18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiKPUgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiKPUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:35:45 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 152D6248F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:35:43 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vP8FomxyItoIqvP8Ioagyz; Wed, 16 Nov 2022 21:35:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668630942; bh=gYjn9E7ahqLvKmvoIroV9fIVp8TGi3+51e+8beUV2vg=;
        h=From:To:Subject:Date:MIME-Version;
        b=OHf4oX3tD/RSVe/iep+lSNaAEk5TPp0t9n0+lpvgGNOb2EHQsXF4vbsnW8ugFVPQx
         1XmCvMY/Nr7ppNSHAYtdqHYOVG06hxuWMhgKnj+jU7Jt/S1sLufMX163/tuDGF11rW
         86weQcpt0bFoAb4gIzwSOTc4WW32pNzSR3H3+EylIJGQWE0y42hcWehS6CVElVH6ln
         5PwCX1PJplb+mORZAKK9O9nVKVSmYAhtaAOyYCarGSMz7QD4M3fPL6Fhgaj7D60DZ7
         rvOTw7s85rtDCiwtyleGDie8OvTpY9qo8RFrAftbiiDZhwHKVrGXCNyw8/VZNqgub5
         BfTIKBrMHFybA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v3 4/4] ARM: dts: imx: prepend a 0 in the memory address to make it clear it's 32MB
Date:   Wed, 16 Nov 2022 21:35:20 +0100
Message-Id: <20221116203520.8300-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
References: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPLxc4+Xt2t8YgBb40JmyUT3VUGyCD1EDKDMqrUTdVrLUcjhQyqNnH+9UHkIQL1SAbjdwLoK9DYqs4h6qX9klT7BVTUaLrnUUUbqvTSjwJH2tnqD1GA3
 3N1Gw+9QufgLCJ/LFG9HKomNLjluTT3E63bW51AhOdZnsu/sDayd22/BQO0IqnBxwnZg44zzq6HI9SFlPJkfmiz7G9xZw4rzTb9vHdWeILuJSevRAp1YzMjF
 IWf4QFCAKn3xCHgciAlyqyYNZ++oDTIyzV93VqSvsO6iOE8NKvbpMbj2sIdOtFhWmBWzPOEkI0BeyziuU6RNjHUW3JJEoIn42sGswpDlKqYYUZJtxxFYlmbO
 oICI67+p5/0vUWHuY/hlWxKTGcgF0h1Ar3rxaBdI5utvKoOb88fgZFpguU5mhblpAkCqUl/IFvDDoGEasNdvXGQm4GK1q9d5VDIj+KkrdA0KN7S1XRcKwCoF
 m+jqkEpd17QVGADOEChJbuJrBWwfHpygNNqroRU8237q+bFrbU9mzcnPSlJUY/Ri4078mXueya1s2UqRlbd9nW5TseC4EsvcI9xTghKYMw7dHb/yqu0NrMHZ
 Argohgbegnx0TPOLJJUMuj3X4Dzmx8ug1iCCjDTgRZkaLoZ2noV+ewFdsLktIS3LMxOjugrtemqg+K9JOCeQfwGDW60rj2Xxt1yMEGg6m8qS87coCMD0yTop
 ZrFjzR4khqRNMKX1rhSMkEUTpz223+CmLbj6JxZQCOmeT62wZZOnl0hP+KH6K5RchD4ZSeEFQJVL1HdR6suxm1AF77O5ifBKW0+H+gIZSUHlX/AlnKOxVA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepend a 0 in the memory address to make it clear it's 32MB

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Jesse Taube <mr.bossman075@gmail.com>
---
V1->V2:
* nothing done
V2->V3:
* added commit log and not only subject as suggested by Jesse Taube
* added Jesse Taube's Acked-by:
---
 arch/arm/boot/dts/imxrt1050-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050-evk.dts b/arch/arm/boot/dts/imxrt1050-evk.dts
index 1d339f48899f..3de392d014fe 100644
--- a/arch/arm/boot/dts/imxrt1050-evk.dts
+++ b/arch/arm/boot/dts/imxrt1050-evk.dts
@@ -28,7 +28,7 @@ aliases {
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x2000000>;
+		reg = <0x80000000 0x02000000>;
 	};
 
 	panel {
-- 
2.34.1

