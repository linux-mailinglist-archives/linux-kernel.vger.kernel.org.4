Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB560D513
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiJYT5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiJYT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:57:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149510EA02;
        Tue, 25 Oct 2022 12:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04BDDB81E88;
        Tue, 25 Oct 2022 19:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A48C433D6;
        Tue, 25 Oct 2022 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666727830;
        bh=7XhSIz9hT5MjQIm4thSq4MY9Q3mxA3PJBkbPvWcrm1o=;
        h=From:To:Cc:Subject:Date:From;
        b=UVGraJNMazoS29PboYYzQEVitDlCfJWRSf61bqUBDIUeVG/JsnGEKHD2GL7hSe8E4
         IW+mejsy9UnLpLMzAJjstzrBnDx1XJuRrU2UCwGURgpk3H14MlU/2Koh20wMBQkQ/u
         OlLO8H3WhNEgPP5/4jnyJQUqOV0IFlpr3/cEt5aheo+c37ZEzeVfBtjKVq6RB6DERR
         8q5Wy3DsT1g4fOZl9b8/0qUMyXUIADFCAnZDtp0jfVSrMcWNasQgcfvSfQyIHoGrze
         R6Xt/kW/cIBDShj3gLollHkBVlLkPCR9wK44lWaWxF9SooLh/brrUKK9Fhjm3iAX/L
         2r5rrfQ6ukE8Q==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: microchip: fix memory node unit address for icicle
Date:   Tue, 25 Oct 2022 20:56:44 +0100
Message-Id: <20221025195643.1215890-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Evidently I forgot to update the unit address for the 38-bit cached
memory node when I changed the address in the reg property..
Update it to match.

Fixes: 6c1193301791 ("riscv: dts: microchip: update memory configuration for v2022.10")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index ec7b7c2a3ce2..8ced67c3b00b 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -37,7 +37,7 @@ ddrc_cache_lo: memory@80000000 {
 		status = "okay";
 	};
 
-	ddrc_cache_hi: memory@1000000000 {
+	ddrc_cache_hi: memory@1040000000 {
 		device_type = "memory";
 		reg = <0x10 0x40000000 0x0 0x40000000>;
 		status = "okay";
-- 
2.38.0

