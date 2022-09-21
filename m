Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3895BFD58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIULwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIULwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:52:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F92DE7;
        Wed, 21 Sep 2022 04:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC82ECE1CEE;
        Wed, 21 Sep 2022 11:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23BFC433C1;
        Wed, 21 Sep 2022 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663761121;
        bh=QNZnfRmbWJUX7IFgFV/RTA5EV4Z8QO8u0O29s/Ed3G8=;
        h=From:To:Cc:Subject:Date:From;
        b=QTZUThzZFmyfncQ2CtZKjTI4zPXFPhe21Ctznq5sb0xxS9IPzCMNReEuSKQdztj9X
         K2TOOoq0pBtxH14GZ1Kv85mn7z9YGTFNVZ6pkEHwnlzcScqvXGFyR3znm8j2wBCAgX
         I6okkXfnmhitVc8ZFKHRpphoqqjB9XC8b4HlT14zvTNAD6HN553XtSp4zpVe6Yur7b
         yCVTv+YIU2tmL+DsDc2NgAPF2Xa//ZJ7jlvIu+ZPTqmIQdFu877GTB9geUN8SAzPnb
         5Gj8w5yzqBDVbPN1idkaHKndNtmjH+SJMHRTwci4v/2JbxE/2J+VS4/Hl/PkLWTd4k
         D6haHuN8tIdqg==
Received: by pali.im (Postfix)
        id 76A5F789; Wed, 21 Sep 2022 13:51:58 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: turris-omnia: Add label for wan port
Date:   Wed, 21 Sep 2022 13:50:37 +0200
Message-Id: <20220921115037.30246-1-pali@kernel.org>
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

Device tree label property should contain label from the box/stick.
Labels for other ports are already specified in DT but wan is missing.
So add missing label for wan port.

Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index 8215ffb6a795..c4bf3ca0784b 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -166,6 +166,7 @@
 	buffer-manager = <&bm>;
 	bm,pool-long = <2>;
 	bm,pool-short = <3>;
+	label = "wan";
 };
 
 &i2c0 {
-- 
2.20.1

