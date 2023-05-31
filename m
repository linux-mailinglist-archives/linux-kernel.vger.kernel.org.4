Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054CB718347
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjEaNtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjEaNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0881AE;
        Wed, 31 May 2023 06:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8DC0628FE;
        Wed, 31 May 2023 13:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A79FC4339B;
        Wed, 31 May 2023 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540607;
        bh=mqL994jDilpj3DORbkHAMlSuexwDHjFi8s1HMFeV82w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubcU0tlFZ4ppwzzb9kWdI1fpyvhR38nkFKwijnm2OjXVzYfhYV826879Lclf8zyQ4
         +CrrVXOqxWhzv2LXQ78Oosu/O7LmB3vRm99Z3EG0rWK6tLKehSMWkL24C8Bm0AQqRo
         Jk0d77ul+xnnu75rgAAFMakNAzg8jQyAf901Xl89MQl/VyRuL9nGcwxYTL1XKZaV/l
         T5Ly9zgLnIvZgoyofjGTjfo10xHf+V3vQqsdW1TCGLx3RHV+Z/rZ3Wwv2kDOy6jJc+
         012PF7/p8AYTlp7l9El6lM49S8GgA/jEIaEl8m7oZM4O9URNw/QMDxB9BN+dr6rwhW
         uog0aoNZpNjPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>, liviu.dudau@arm.com,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/24] ARM: dts: vexpress: add missing cache properties
Date:   Wed, 31 May 2023 09:43:00 -0400
Message-Id: <20230531134320.3384102-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 328acc5657c6197753238d7ce0a6924ead829347 ]

As all level 2 and level 3 caches are unified, add required
cache-unified property to fix warnings like:

  vexpress-v2p-ca5s.dtb: cache-controller@2c0f0000: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230423150837.118466-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 3b88209bacea2..ff1f9a1bcfcfc 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -132,6 +132,7 @@ L2: cache-controller@2c0f0000 {
 		reg = <0x2c0f0000 0x1000>;
 		interrupts = <0 84 4>;
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	pmu {
-- 
2.39.2

