Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8374FF71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGLGeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjGLGdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:33:38 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82E2127;
        Tue, 11 Jul 2023 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ay+qmBA/PXjKC6poUaYsFfPqOZlKKsgO2YKtMPT1Imo=; b=v3aXJsY5GSvzOGdiMLiz6NEz44
        aLxF3WAcHHqtdr6jjoyMI1S1KU/+CCdNT5BCKoPFc29p5mQIsxm2XFLyhw245cPeNso8kLdzVG0Vf
        aNXGju4l5iRmn1jRZI81qcZL7nP6ixC0npuSszuAERBYLQX5FHUhVll6qX/6pjJ2KWdLNbCQmMSjW
        3BzfEFbrR+uBkh+JiUmATLOrvkU06AsE94jPGLJSVLklxymWdRQjoZwm6hrIK7l++U6K0GQ59sVXF
        q7Hiu9AVwyGlXYSwOANPRRXfni6MiahcEwdSLsR2/nyXzFsLGqlFX2afuxeGhazhjbP0Z69NWuFp7
        MhWazgdQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJTN3-000AND-Gw; Wed, 12 Jul 2023 08:30:41 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJTN2-00020e-TQ; Wed, 12 Jul 2023 08:30:40 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     a.fatoum@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] ARM: dts: stm32: osd32: fix ldo2 not required to be always-on
Date:   Wed, 12 Jul 2023 08:29:50 +0200
Message-Id: <20230712062954.2194505-5-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712062954.2194505-1-sean@geanix.com>
References: <20230712062954.2194505-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
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
requirement for the ldo2 to be always-on.

[1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/stm32mp15xx-osd32.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
index eb43a1e3a0c9..902ca6c23533 100644
--- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
@@ -124,9 +124,7 @@ v3v3_hdmi: ldo2 {
 				regulator-name = "v3v3_hdmi";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
 				interrupts = <IT_CURLIM_LDO2 0>;
-
 			};
 
 			vtt_ddr: ldo3 {
-- 
2.40.0

