Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C246D690DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBIQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjBIQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:04:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2625365644;
        Thu,  9 Feb 2023 08:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B588361B16;
        Thu,  9 Feb 2023 16:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63305C4339E;
        Thu,  9 Feb 2023 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958651;
        bh=V8wDSsgg1djz0HK45I77IjKQpKzm88Y/L4dXpGGAku8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwyX0IbopI3qVx+wdskdzGDIQ1UXlXQqdjKRmVQEpUlq0CslBpp8BpBRcsi1h5CSU
         YR2IN5EibgubpNfn3FWOESlHAcuS3h0VNmWNEtW3mpgHc2oEtjgO+MTIPa4Wq5bhhw
         o3l/3ZNDx62iSFqmaI8NTHpKmRLogfV3PKLnDOEu4UI8CcljnzFqPJH+10BtA4B3Xc
         j+r/RRBoHIunS+EJcBK+Umujvw8vR0hkd3uCB9kVOalctYssLsBynXvvf2pwQCk3OL
         jA3MZRJNCzHz2C6SZfEyLPnC/J1GrK1z0aopX8dBYbbsBP/7wbsHQFA+JcB4pM8y05
         j8ebBr9ZF5IJg==
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v1 2/4] arm64: dts: mt8167: Align mmsys node name with dtschema
Date:   Thu,  9 Feb 2023 17:03:55 +0100
Message-Id: <20230209160357.19307-2-matthias.bgg@kernel.org>
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

The node name should be generic and mmsys expcets 'syscon'

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 6a54315cf6502..2374c09530575 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -124,7 +124,7 @@ pio: pinctrl@1000b000 {
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		mmsys: mmsys@14000000 {
+		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8167-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
-- 
2.39.0

