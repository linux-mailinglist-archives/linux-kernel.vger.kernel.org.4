Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CAD7183ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbjEaNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbjEaNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559035A6;
        Wed, 31 May 2023 06:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF48636E2;
        Wed, 31 May 2023 13:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DCFC4331E;
        Wed, 31 May 2023 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540772;
        bh=1th7K4benKDf8xLe4i3xE+g776zmGvOg2YGEAoAVoxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vN1H8wscmUCaXYqp2+POBM+2RxE2PrGK78Ljz8tEStVqkyBYIb+aHQQl/cK6YSKpF
         uz4gGIW3EWKrszL62mC3QRKT0EC56MdRusENXehdsZTtemetQw7fBj/Y4VXZgGAM4v
         /1kaHBsFHFBSHtO8mVA0aWq6xOjfRL2vQ6quTjlfXyS7GHvc3H42eU6N4GJl9KapoB
         vH+NsMCX1la+JELcp7ail1xrZs2wORF6jPPLNSb99G4m4NE2TPOfdc5R4IB6K9z0vp
         qeEPQJ4ENt22SXzX0NkeqojmoCxRLnQsmnhcjge3Y9RY7zxCSDxRDZ5+hifh8INe+p
         SdrzB2P0frNwQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>, liviu.dudau@arm.com,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/10] ARM: dts: vexpress: add missing cache properties
Date:   Wed, 31 May 2023 09:45:59 -0400
Message-Id: <20230531134606.3385210-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134606.3385210-1-sashal@kernel.org>
References: <20230531134606.3385210-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 32f1906ffecfe..994edbc615cb0 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -117,6 +117,7 @@ L2: cache-controller@2c0f0000 {
 		reg = <0x2c0f0000 0x1000>;
 		interrupts = <0 84 4>;
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	pmu {
-- 
2.39.2

