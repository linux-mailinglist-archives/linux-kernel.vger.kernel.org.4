Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026B262E3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbiKQSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiKQSKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:10:24 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA0CD7A356
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:10:18 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vjL5ohRGp6OFPvjL7oOWDC; Thu, 17 Nov 2022 19:10:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668708618; bh=Q1SqYvBrNnUgR2sXc9/h51g3EEMVjt/rfSR0IKOWq/8=;
        h=From:To:Subject:Date:MIME-Version;
        b=NCSrR7BGXlfeIZ9AqzR6hflynn/Yp2GJqjL6HmhVi90YkjYRLjKfGEeJ0/450r4/y
         sjGkJ6SnoihSCEy+Mg/9NlIpU+xt2k/NpOD90qhjKpj4NtHWgwWniHAE8PW1YM/Vgi
         EjeUVz4AYJddT8RDFx0evAD7ZMUaL1cbbCXHWohdRHxsEQAsAqUFUYAFK6twxG1HfO
         uEI7zYNPEtl+I/HDtM/MUcSzRoGq6/jtMBvV0RoSn+i29BOapS2UO5ws87ykkABlHI
         IyLKlg8Txmi3NJurEI6eUvxavOSXyP7HI4P5ke15oD2+ZZ6+/OhkyVsFwhTUhO5Szc
         9B9pBVgun3bXw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Bough Chen <haibo.chen@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 4/4] ARM: dts: imx: prepend a 0 in the memory address to make it clear it's 32MB
Date:   Thu, 17 Nov 2022 19:10:14 +0100
Message-Id: <20221117181014.851505-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
References: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEGoKFYJtsS+LxJMJuhIQhyE88lRdTsRxYFjI0JhWP78wchn8e7HG5ipF2Hfc7wTDIwMtdFtZWWRBc5xIQ+7z/AtoVlAOdbN3dFILJzyaLbNIrL4sBeJ
 zB23vOv1Rf7t0zLZmTjGCc40kbBhhlJvFL+atvVyl7by6Pid98w0hYsomY6bvfgNBRacszwPELMbojgC/3fN++fqIYeZmZtQsAf7B4qwbopwQQLqix8/nA9/
 OWSQO782tjaI2dACIiwleOX73IAIdrxl9vz91vdPnqNI//52Jc4J5EsSiiDPVn4ZcirKrVfhFKsrbFU1auBfO4iF2zxdupUbHlk6ZErfN/VyPcNtfYsJO9q1
 YB9oQ2nSPRlRBsKMZUZLSc7WxvUszR1izRV2gKqobB/7U12jpuTPcapWyk6i4LNwRxAiz6rfW/owTO3LmSb3ZcAUDs4hhoBENbyospdecLZCVX1pCUUrUkYM
 CFvc56enH9FixN3NjVXGfDfqhvysZyJzpd+yyNriS3T6+bqF5eg1dlZHWwDjQ5Lo6SuyWe+ELbjS6GtY8uAmzm6+bBec9ovLQSeBgjmJIvRb8iL2w3Iw3vdR
 Hs/qf1OupC21bWsTyVzm2v0KycEE9oIxXV/SZomDOoWi3SMS4jtsFsjkcay/WX/Pc6bFHmIxPmI0+0hva3cYYROFf5ctttDcf6hzPHuOGW2ENGTiy6ZGvY3h
 j6OmRj2QK+gLR5HBabOJaSEAtHqm4qNb0Vj4DfHBWsp+zZA1Xkfwes1HDqOBgpWt9u/7Mv1frgwMUWGecHWwUNq3KHvg3JxZCNVwHcjUFRHYSugu2SFqFg==
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
V3->V4:
* nothing done
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

