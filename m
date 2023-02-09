Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB479690DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjBIQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBIQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:04:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726160B9F;
        Thu,  9 Feb 2023 08:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0370D6195F;
        Thu,  9 Feb 2023 16:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E74C4339B;
        Thu,  9 Feb 2023 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958653;
        bh=W6/zxyE3r9vkvCVzWlsyZFdzMy4bAnzeK8VqgkMPGPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwICIkquvfIOsjgN+LNY5EitG/nGzm0LKvAmP9lLt9g8Y4oWULma/OvCxAXpqxmSC
         PwIEqFEvm1OymCUdI006/v1utrFxZ943TSRm0qBlXCzZGqyk+cQnSRoSeB2uD84KVF
         Fo6RQxWLXzj+gg3GGtz8Ne3djKlPcgI37KTCs/RWggCaFbWZykZo90qf1NgAg3I1fv
         u4Pgk4tV4WzpB7EG3FHiYoZeD4Nklz1ZMilooCL0R44C/LkggwpfXe1mpexd7ZGLlo
         4MugJEVBEydIMjVTTpibUWlxu+5Vs0Jp2FYshpD2xN7YaoCUh0yY0jepUZSm52Mskr
         phSxxY+7NiNtQ==
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v1 3/4] arm64: dts: mt8195: Align vppsys node to dtschema
Date:   Thu,  9 Feb 2023 17:03:56 +0100
Message-Id: <20230209160357.19307-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209160357.19307-1-matthias.bgg@kernel.org>
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
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

As the node is a syscon, this has to be reflected in the compatible and
the node name.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8f1264d5290bf..5261367031426 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1795,8 +1795,8 @@ mfgcfg: clock-controller@13fbf000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys0: clock-controller@14000000 {
-			compatible = "mediatek,mt8195-vppsys0";
+		vppsys0: syscon@14000000 {
+			compatible = "mediatek,mt8195-vppsys0", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
@@ -1900,8 +1900,8 @@ larb8: larb@14e05000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_WPESYS>;
 		};
 
-		vppsys1: clock-controller@14f00000 {
-			compatible = "mediatek,mt8195-vppsys1";
+		vppsys1: syscon@14f00000 {
+			compatible = "mediatek,mt8195-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.39.0

