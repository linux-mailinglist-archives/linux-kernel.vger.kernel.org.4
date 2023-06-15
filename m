Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E77316D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbjFOLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjFOLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82354212C;
        Thu, 15 Jun 2023 04:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1151460FBB;
        Thu, 15 Jun 2023 11:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DB5C433CD;
        Thu, 15 Jun 2023 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829023;
        bh=5FCtmPR1WPvaKonQ5+eMTQzLrgA85GsmeSlUJHuAlIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7XwZm91mWQwjQypMWv4Sq2dAEhr57HaimbUfnC4eZXb5FQH/nW+XIDlN8kscZGE8
         FR8rVaF6MW2ohULNhp+FCeHCIu2LRwM5ZNDJjfHLPuyQHrhQIxnU3aJnZfhWHaeYNq
         02hbtEEp/jjBIW920TdAQbX7Zv2ys5iNKxqytVKn4XpoTDObTfRvq+Hykno/d1nQxQ
         j7l0tEP08myLl32Zg4CfemVepcCVusjm218V4YBYXNxa1cnwtBf2HEpdDWbLku0rtT
         gzb6rWno6528lVdcWlXykl2ZTCpONUSWt1cIMb4et2Kq4XB9l8YgAu2LXSCEE5kr2o
         KeY9g6sJSAPGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>, liviu.dudau@arm.com,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 05/37] arm64: dts: arm: add missing cache properties
Date:   Thu, 15 Jun 2023 07:36:22 -0400
Message-Id: <20230615113654.648702-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113654.648702-1-sashal@kernel.org>
References: <20230615113654.648702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 55b37d9c8ba23d28c584aef0801fb1e60e4a817c ]

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  foundation-v8.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230421223213.115639-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi           | 1 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts           | 1 +
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 029578072d8fb..7b41537731a6a 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -59,6 +59,7 @@ cpu3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index ef68f5aae7ddf..afdf954206f1d 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -72,6 +72,7 @@ cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 796cd7d02eb55..7bdeb965f0a96 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -58,6 +58,7 @@ cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.39.2

