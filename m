Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87A627482
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiKNCVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiKNCVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:20 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A8F5A2;
        Sun, 13 Nov 2022 18:21:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 02C6632007F0;
        Sun, 13 Nov 2022 21:21:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 21:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668392477; x=1668478877; bh=8d
        GrluyziuRFhWRkKBXbsD9qADCfDkyrmE8KHFwP3gA=; b=eIjuzMBfwoTXzDRlEv
        4tpkzlPpyVUMvi7Bgj4grlg88EXkPbd1wfPLuGI7iClTEoxcTbB48BRTsiSbr0cL
        6TLrfNVqhqCSWwONN9EUZZfz3N3Qel0IMhMAr5UfPCBkX6rPlUNmDpnxeWXi+qam
        ra6O/9D6TPuM71e42E0KGKyYLfvEbr2AnxuJpBX0IqJ3ssj033josoLc/nUNfKnZ
        k1UGqlQj7gP6lTdLitnji2GZn+qOiXz8oguDj0IaZbssGr+8PJD5em5s6AkeW68B
        C9wQFPX/qW50ulUKGEr01BRrPab0lG7NVqXGdS0seku4uuuqoZnC5JEyzPof+DPW
        irqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668392477; x=1668478877; bh=8dGrluyziuRFh
        WRkKBXbsD9qADCfDkyrmE8KHFwP3gA=; b=HLDoThWVgYInc0MDAvNrF03X9Y4WW
        MERCuwxx8u4+QVT07jfKM+EUeqwKdv+eixnrDRkkc7WQGaJQAce7Y+7bA4Luhypz
        LbyO0eaJDE7wWgFyxzdQ+smeayC1PC54lO762tFod8X/rUTBYNzDTuWV1bW+ELnL
        fnFVLurjvNveG41wEVpFeJjb5tUCT7N4e3iF2TJsYQSSezWWoRy2qQu19V2uWaVw
        +c56d6Dcvxx+tfvGazQH/FqA1A/XtQTgAcW1p5yICsO9/jmQPH/27afag4HbQSDQ
        lUS51bpDG1otaLgZUwMnhxUv4VbbKoeTPjBfGAOSpj6OmBBxbUQDRpVNw==
X-ME-Sender: <xms:HaZxY0-bLbbf6ZCywSyoWY74VDAAIOeN-4a7rjIHqPibFOMn2JAqoA>
    <xme:HaZxY8s2voEQ27IYHvphjrjeZLbaoNoDQkOPaIQykzF1YxuHrEIooaO5CQPsW8M1m
    WiVooh9y0qbZpl2PQ>
X-ME-Received: <xmr:HaZxY6AOvKdMGU9fCiU4npySnzNk-N4axgTeUn4CQHRW-DbBZAGCm4_qdHXp37qrl8geiAikcKjZimS-k6gXLUD7NSzt02N1cB--OcIAQksX3nSW4hX3twMNASGwZvk-DHWc4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HaZxY0dmmeBtFN7OyIWvg5_FaShTS8rbHflNyrM5PJhvewjAp2SJng>
    <xmx:HaZxY5Ma7IpoHdFIef7drhzgAt5KXdIZg-FvVVu69gwRF17dwU--rg>
    <xmx:HaZxY-n-0cDlOpUosdLSuwJwAT91r0dTdpczG9csYGLg3yj9IruW6g>
    <xmx:HaZxY9kVPsbHoBtcCaIMIpA8F1Sf5RSAyWczyQrtDTDJG7IdGYTv-Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts property
Date:   Sun, 13 Nov 2022 20:21:06 -0600
Message-Id: <20221114022113.31694-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114022113.31694-1-samuel@sholland.org>
References: <20221114022113.31694-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun6i DPHY can generate several interrupts, mostly for reporting
error conditions, but also for detecting BTA and UPLS sequences.
Document this capability in order to accurately describe the hardware.

The DPHY has no interrupt number provided in the vendor documentation
because its interrupt line is shared with the DSI controller.

A trivial interrupt handler was used to verify that interrupts were in
fact generated by the DPHY and not the DSI controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Add the interrupts property to the binding example
 - Drop the inappropriate Fixes tags

 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index dfb6a8993535..4c45d7fcc853 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -24,6 +24,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   clocks:
     items:
       - description: Bus Clock
@@ -53,6 +56,7 @@ required:
   - "#phy-cells"
   - compatible
   - reg
+  - interrupts
   - clocks
   - clock-names
   - resets
@@ -61,9 +65,12 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     dphy0: d-phy@1ca1000 {
         compatible = "allwinner,sun6i-a31-mipi-dphy";
         reg = <0x01ca1000 0x1000>;
+        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&ccu 23>, <&ccu 97>;
         clock-names = "bus", "mod";
         resets = <&ccu 4>;
-- 
2.37.3

