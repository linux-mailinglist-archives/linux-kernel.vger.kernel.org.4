Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A6875090D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjGLNCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjGLNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:02:12 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49AD1BF6;
        Wed, 12 Jul 2023 06:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=PNXY7AK9+1KCjIZmt16vPWCVc4fo9JVBMW55Z+fzIf8=; b=SGNDr4WZL48qkQ5RQh9B3tHZoh
        0TImBsBvFpTUa5IHxnViC1gYSpx3Zjx/WLcNEG3w4Q6xw6n8qQnBqJ4f3AYkzU8nK/XLDTMUUothx
        mIMrUgOU2h2i5pwi7dJSdRq8tJDC/SddJ/GsKw9et75J7uLHGRTCFvdxyvNx2B6gV1+p3qNcNA33D
        f5IEiZbfR0atJaBNmB6xLjIu8Hfuvt8BWDwI20g5UB7fR1TfxEfWczIlzUQkkKliswOhKT8dZP0m3
        jXgILVY88WGUcWEQj6Fk3hk5oqA/kpqEREUsA5BmeCFqM7p/wntDscyk/FhMVgWRXeNG4x3KXwnly
        r4Qy7xRA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJZBg-000NMR-Ir; Wed, 12 Jul 2023 14:43:20 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJZBg-000L9W-0D; Wed, 12 Jul 2023 14:43:20 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] ARM: dts: stm32: osd32: fix ldo1 not required to be always-on
Date:   Wed, 12 Jul 2023 14:42:42 +0200
Message-Id: <20230712124248.2400862-4-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712124248.2400862-1-sean@geanix.com>
References: <20230712124248.2400862-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the OSD32MP1 Power System overview[1] there is no hard
requirement for the ldo1 to be always-on.

[1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
index a43965c86fe8..eb43a1e3a0c9 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
@@ -117,9 +117,7 @@ v1v8_audio: ldo1 {
 				regulator-name = "v1v8_audio";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				interrupts = <IT_CURLIM_LDO1 0>;
-
 			};
 
 			v3v3_hdmi: ldo2 {
-- 
2.40.0

