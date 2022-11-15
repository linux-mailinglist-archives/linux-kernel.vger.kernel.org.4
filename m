Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4562A1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKOTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKOTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:32:52 -0500
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FEB2E9D2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:32:49 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id v1fpoedd9ae4mv1froaGWH; Tue, 15 Nov 2022 20:32:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668540768; bh=qy7c5fbIv4zB0MIuwQtV1SMZAvnjWVmZ+hu6ajDxWao=;
        h=From:To:Subject:Date:MIME-Version;
        b=A1l+JharJJko9ZMED9Cgy2yPojkz1q1xyJNZQhl5E0xRccxEpnmjIxv76ANKLjNJb
         kuKJkCu0czaQCi48wrNguwLnnT8CTLV5btJHnv1c0VAHji2mb1PedbbIiJ9uy8Ddei
         B7/kbx+JWGVF1wBImzC4FbylvnPvXcfNR7cO0vxJwC9WJxiMnplkAlFuN5lEpQVLo4
         qSQJAAatpNszz8egphSu/yBXgRtQ4A79E2S08nxdEBSiWNNYbafi1E9C0FF09DtHVd
         /6PmP8+Y6fwMrsmpFA6yxX8pIRMWcIR/jfnI5r37Qjz18pkpNw1MASDQM8YUDD9Mdc
         Z9aN1aiWM2JSw==
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
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2 4/4] ARM: dts: imx: prepend a 0 in the memory address to make it clear it's 32MB
Date:   Tue, 15 Nov 2022 20:32:44 +0100
Message-Id: <20221115193244.10484-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCmPAKxzR37XnP7zG1mqyFHHa4U6F59QvDwTVpnVhB2EqApG3ZAw0lWg0WiQIPVRNvcnGdywCajkRDj54EBChWNDRnEMJ9q5zUiUTSA4aLyTqfb17hVZ
 UNVvEPPpKvhoZER0V6LLTG/DHqgX6KLuNCzZd9Bo5D851Gpsm3Pl16RSSWOLtmee0CNuJFNG+/Qgdtoo6WFcJ5K2B+QcwIwrNIHaH6mr0ccVAKqymzjUSvp8
 Cu0f6zhLL4g3cM+oLGcnwzVKzf2/9AO2UWtNOg43pgaJxasvASOm7s629172R3l/0s02kN+CpLZEPTMeJk5qoaM9RrdEgUa+7quGY6xOC5Vlz7ZT6d+ys84q
 +YGGep9JNAHhCSdIDPQE2O4DX9cpHkC7q8joydniM9KjRWeSeFVH/A5URAdP1rs48uQfKH+bdGS5UTJUlf44EbXYoq8M3yBrRdo3Su94M1fXx/lpph2L5iOq
 zP7n9T8xPL77zaJt+BdrW1YoN2kcQHH+ShC6xPEKVWVM2InYJB7VtcOeaa2a1BK7RyOtbefIEe6PUfr/WxekLmQteVWoKeHyZj25OEIjSvfkRQkuzdDm/0RW
 SjQ8kkAOvsy5QY0ocEkW7B2Y+TyQrsxFcjntBxObtX9WJnk826eyktl7RRloPQ7XNdS4pdFK5Ju+f069pkZBjrO5tNiXAcm4tnFGvWy5JHUkSXPVh42tonnF
 6bMvBn58vqz9LbipoO3chbioVtiVxqLbxdR8eJBHPLlu1RBuiTcBFQskLI3dti8/EEZ07gCTKPyN4R5h6gSHExGmNcuyHSOV7IB36KRwrs/j05Un9IGCqw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
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

