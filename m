Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71C690DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjBIQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjBIQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:04:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5660B91;
        Thu,  9 Feb 2023 08:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A1761B0F;
        Thu,  9 Feb 2023 16:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA9DC4339B;
        Thu,  9 Feb 2023 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958648;
        bh=uGWGuY+pmiRv/F2JmrrPyILmZOGSnM3BIAkj+vJKlL4=;
        h=From:To:Cc:Subject:Date:From;
        b=bVjPyodjAw/enyukcdGaAowwPIKj15AZ84URDOR9Az8NqH6qrJzbqlohMweQxxEUv
         mxH7rlb7wdcxFVQK2onSAo946XoOEKHZfaV6esemsltxZTdpeUOuEMo77l3tUNcNA4
         Kz0WBnrYAbs+7wOUiVwHm3GxKof5i394GS5Us+XliZk4buVqzsI+Qsa/iypQIo6MSk
         4gYI+zgrjsxZs3dv1QuSBuq6JrN1uqyrvZL87FZCji1YGTpbM1YG0BtUgcjCcPPnWg
         d2SPjeqELRvv/DWt3w1Mu3ZUy1n0gArjQk82ASP1Nfl/egiME8qsh9dc2E9eetFclc
         9YaCeolm19rmA==
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v1 1/4] arm64: dts: mt8195: Update vdosys compatible
Date:   Thu,  9 Feb 2023 17:03:54 +0100
Message-Id: <20230209160357.19307-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

In an effort to fix the vdosys implementation, the compatible has
changes. Fix the device tree to adhere the binding definition.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 00891bfa564e9..8f1264d5290bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2369,7 +2369,7 @@ vencsys_core1: clock-controller@1b000000 {
 		};
 
 		vdosys0: syscon@1c01a000 {
-			compatible = "mediatek,mt8195-mmsys", "syscon";
+			compatible = "mediatek,mt8195-vdosys0", "mediatek,mt8195-mmsys", "syscon";
 			reg = <0 0x1c01a000 0 0x1000>;
 			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
 			#clock-cells = <1>;
@@ -2555,7 +2555,7 @@ larb1: larb@1c019000 {
 		};
 
 		vdosys1: syscon@1c100000 {
-			compatible = "mediatek,mt8195-mmsys", "syscon";
+			compatible = "mediatek,mt8195-vdosys1", "syscon";
 			reg = <0 0x1c100000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.39.0

