Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E65BE711
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiITN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiITN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D7926ACE;
        Tue, 20 Sep 2022 06:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FF1BB82940;
        Tue, 20 Sep 2022 13:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B35C43143;
        Tue, 20 Sep 2022 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680452;
        bh=duF10gD9sbZA+Bm4zPNQqJO6kJ7WkRZ4TTW0Qx0ckj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXKncDma0pSYX1etnuN2SPD0MgPfZQL51GSltE/BThnJglBHGeZ+mD21FaQ0MO8Kc
         8mP6299DTIVsLYdW5Crx+K82zavm8vw1PpboiX0r0Oh4MmAtHhbHdzwWBk82EyKKxq
         iO6LivBbTwCPIeI5QFBtNPohnbN6CRjWtSgT4lvfd2xKcdSn4BXltW6XeHUBBdLIF6
         QFI6d0IYZ/iv3wq1ZZmkOAI+5nLkbJ8TG4h5Ffs3Ame2lR2r4qfT9syQ4BmmfKbSRO
         TvkynXwxLvJHgcsQ0QSf6JpGgSA511DXe2kYD/y4I8zK8074af2pS6yfOGKGdHlMqQ
         SBd/Fir4R6I4w==
Received: by pali.im (Postfix)
        id 70D882E0F; Tue, 20 Sep 2022 15:27:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] ARM: mvebu: Add spdif-pins mpp pins for Armada 38x
Date:   Tue, 20 Sep 2022 15:26:47 +0200
Message-Id: <20220920132648.2008-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S/PDIF function on Armada 38x uses only mpp51 pin. So add spdif-pins mpp
pins section for it. It is needed for boards without i2s.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 11e0e4286ec2..b09a48de9906 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -296,6 +296,11 @@
 						       "mpp52", "mpp53";
 					marvell,function = "audio";
 				};
+
+				spdif_pins: spdif-pins {
+					marvell,pins = "mpp51";
+					marvell,function = "audio";
+				};
 			};
 
 			gpio0: gpio@18100 {
-- 
2.20.1

