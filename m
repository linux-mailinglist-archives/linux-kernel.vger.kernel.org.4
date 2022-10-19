Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693CF604818
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiJSNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiJSNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:48:14 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134EF367AB;
        Wed, 19 Oct 2022 06:32:45 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F0121E0004;
        Wed, 19 Oct 2022 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666186335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhiCYLQFvv0VNmNRXtrzuQS+x+dk0THDr97Yf1PzbkM=;
        b=RTbIUUpviy3RBFy4C92Nl+g/4+7ZKXbm5bkEC2seFprdfYb8gvVvUp21ePX1ic6naKZaDf
        fLKiEUvJjZSqF8t1HbIeRqksG4CzSecbjvOhSTWYNM/IKa43kVateKGuDPT59pOvGrkqe9
        Z5Skfi8erhZpefeK2gHMRs6qSBuVRPQYP2kOapMbZKTJY4Y44dZ2qaPe247uvhRHmIFo5W
        XGEpbvorPY4gbgx2hbt4h6NY/KF8or3XbZg5Sb923YC69L7JIJnI1LZG86mlUzEb41OHkC
        EcYUO73S2e+07lxcopUDLwFalB6AHWljl7OEc+TuKsXLw4dZ6lgWN448ZNYawg==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Bhavna Yadav <bhavna.yadav@st.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Deepak Sikri <deepak.sikri@st.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com,
        Kory Maincent <kory.maincent@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vipin Kumar <vipin.kumar@st.com>,
        Vipul Kumar Samar <vipulkumar.samar@st.com>
Subject: [PATCH 2/6] arm: dts: spear600: Fix clcd interrupt
Date:   Wed, 19 Oct 2022 15:32:04 +0200
Message-Id: <20221019133208.319626-3-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019133208.319626-1-kory.maincent@bootlin.com>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Interrupt 12 of the Interrupt controller belongs to the SMI controller,
the right one for the display controller is the interrupt 13.

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/boot/dts/spear600.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index fd41243a0b2c..9d5a04a46b14 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -47,7 +47,7 @@ clcd: clcd@fc200000 {
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0xfc200000 0x1000>;
 			interrupt-parent = <&vic1>;
-			interrupts = <12>;
+			interrupts = <13>;
 			status = "disabled";
 		};
 
-- 
2.25.1

