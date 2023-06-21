Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15E737B73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjFUGeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFUGd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:33:57 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C331A3;
        Tue, 20 Jun 2023 23:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=89sBX6BFnrx7cYuFn2HT+ikMXvzTI/DIlvCjU6nTMwM=; b=TmV1hWoqE7As63kJDx/ALZjgyu
        FS/iIWq0zJ9199h6hvFOcpAfLIWz/v5y7btlHiAsPv3VLKUQAvQSoGAFT+WfKyX2rZCLo/GfDft/o
        LjrYfZ86fvdQ8niTBKwXW3t9DDlEQ3OkFaI2mKTMw2eZws6BL07ddk0Ixvr5TgFIDQBMPIxb4Pps+
        VPHH8DQAZ2Awf+D6dHyGDokI1naIhSO31EZVu61h9RBvff8QpAJ5KVPjJjyq5oV/GgGM+K0ZU66bI
        vBIMJZEWhpHA+R0s3lWrSzv4GALTIApGjP1ZHCk1q24EU6z+YYdtKZdry0x7c0zMwRePM8kbPhKT2
        kjLE7a/w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qBrPe-000MdU-Gt; Wed, 21 Jun 2023 08:33:54 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qBrPd-0008i1-MM; Wed, 21 Jun 2023 08:33:53 +0200
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
Subject: [PATCH v2 6/8] ARM: dts: stm32: osd32: fix ldo6 not required to be always-on
Date:   Wed, 21 Jun 2023 08:33:36 +0200
Message-Id: <20230621063339.1361073-6-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621063339.1361073-1-sean@geanix.com>
References: <20230621063339.1361073-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the OSD32MP1 Power System overview[1] there is no hard
requirement for the ldo6 to be always-on.

[1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/stm32mp15xx-osd32.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
index 902ca6c23533..aeb71c41a734 100644
--- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
@@ -152,9 +152,7 @@ v1v2_hdmi: ldo6 {
 				regulator-name = "v1v2_hdmi";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
 				interrupts = <IT_CURLIM_LDO6 0>;
-
 			};
 
 			vref_ddr: vref_ddr {
-- 
2.40.0

