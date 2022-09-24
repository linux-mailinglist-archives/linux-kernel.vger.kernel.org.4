Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ABE5E8C02
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiIXL6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiIXL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:58:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4411C144;
        Sat, 24 Sep 2022 04:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7765CB80B8C;
        Sat, 24 Sep 2022 11:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13235C433C1;
        Sat, 24 Sep 2022 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664020722;
        bh=EAlWMKwU3vcCHYrd5JLGwnGPLzs0GMkI8dKC2SVnfIc=;
        h=From:To:Cc:Subject:Date:From;
        b=qcrr2QDTvo8YXU+EbUTcMro4eZ+XwmE7O9qt29IjUbgz0NA1pO2x2w4F4c0FCDkc6
         X/Htx/OcVfLL9SxM6WlFGkNH6/pgOpMgemB5HRTmOfd6b/TK0MPJwQusJI6lwV13Ql
         IYvcrtyR5mYQidBsvOvQOkZsXHn1e7hhTJWQ0GIttfIoQKoMoyn5GONju+CkUBSzfP
         EI3qsjw15kFGlsfs/jg7WUIFMs6eMvr3QUUb0eu1p/NbZXjTB+orv8XKrWM5l9xFyG
         234hRVy7+OSn8hO4GCHvUG+QfVBXyp0ydK9W8KgkzThUrDzMLGGMZI3OA5ylncwFrY
         1LdhaWqtmsPfA==
Received: by pali.im (Postfix)
        id EE4F38A2; Sat, 24 Sep 2022 13:58:38 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: armada-3720-turris-mox: Add missing interrupt for RTC
Date:   Sat, 24 Sep 2022 13:58:26 +0200
Message-Id: <20220924115826.7891-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

MCP7940MT-I/MNY RTC has connected interrupt line to GPIO2_5.

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 5840ed129309..802862fe2060 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -125,9 +125,12 @@
 	/delete-property/ mrvl,i2c-fast-mode;
 	status = "okay";
 
+	/* MCP7940MT-I/MNY RTC */
 	rtc@6f {
 		compatible = "microchip,mcp7940x";
 		reg = <0x6f>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 0>; /* GPIO2_5 */
 	};
 };
 
-- 
2.20.1

