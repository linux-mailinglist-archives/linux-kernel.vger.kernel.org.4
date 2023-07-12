Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9990875092D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjGLNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjGLNDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:03:41 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4862120;
        Wed, 12 Jul 2023 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=790vlLqLiB3x2NU6DqRN3+6qxM5eKgpnm+ks3akQqcA=; b=jTJP0jCVx4P96X1g1ZTI8UWDzO
        Vi9b75gla4FlfdFeAk1oP5E/L9eCVSPXNTTqqutwpUbbQPSu3XKZmIVb+cocKfXXHN9OiXHoex9rl
        YapbCEQhSnZuvjYPLbdL0y+5HWSB/LrNYGEv69tz2vPYK7Y9FC/3Kw/qwPRuv23LO5+abYSh2eGcP
        KGBVqiHxVuN8xxc9XFBfGIwJ2OuSAh21GiszKxeJgIQSNaEIt6eUQPkla1wiWIUF20FaEXfuo95hU
        2LyCMKiOBq+11HvNil8iB4D9lHzbMYRyJkVfCJN0M6yeSW9KPzbj2cYpwgFQdCDbBS3URzafAUA8I
        A0PG0IAw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJZBi-000NMw-Ag; Wed, 12 Jul 2023 14:43:22 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJZBh-000L9W-LL; Wed, 12 Jul 2023 14:43:21 +0200
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
Subject: [PATCH v4 6/9] ARM: dts: stm32: lxa-tac: remove v3v3_hdmi override
Date:   Wed, 12 Jul 2023 14:42:44 +0200
Message-Id: <20230712124248.2400862-6-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712124248.2400862-1-sean@geanix.com>
References: <20230712124248.2400862-1-sean@geanix.com>
MIME-Version: 1.0
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

Patch "ARM: dts: stm32: osd32: fix ldo2 not required to be always-on"
is making this property delete obsolete.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index 184b8bb4ebbf..f09b7c384bd9 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -597,10 +597,6 @@ &usbphyc_port1 {
 	phy-supply = <&vdd_usb>;
 };
 
-&v3v3_hdmi {
-	/delete-property/regulator-always-on;
-};
-
 &vrefbuf {
 	regulator-min-microvolt = <2500000>;
 	regulator-max-microvolt = <2500000>;
-- 
2.40.0

