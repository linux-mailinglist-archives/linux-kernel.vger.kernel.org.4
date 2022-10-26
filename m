Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF760E1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiJZNUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiJZNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:19:10 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A22101E20;
        Wed, 26 Oct 2022 06:19:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4F337580628;
        Wed, 26 Oct 2022 09:19:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Oct 2022 09:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666790348; x=
        1666797548; bh=TLywN80PBRSGp1V7EoHZWP5yAlnJT7LvlPlsl/LopeQ=; b=K
        vVDUGuAsJPAAANUw0L3cfSLaL0YauHgYtmYc0AS93jMRR0vR7LJK6ZLI7GRKZOI9
        fuItjjJjuN2nXfwcNRBj6LkLopSrSR4Vsgo5zNsW9Hg44Hbbg0e2CDGuL137jLOU
        in1TX3SqB19cvK8OemEI5L1jbpVzACsZ14Lsh/0k3PbuTkB95KB17d9n1fkrQjet
        cC6vNM4CFUINvoyCXRUWVCjjfnTJNleaDE6CTiMHAyaXGT1M6Q+f6fRv8+Sm1qQ2
        JZ6fprP670ZY+Hn0yfs//e60xOGVpoihlnyuXlPxXDeDJz1kcIvH8N8iX4tM2gFD
        cTums7LqLTRtPF0I8ga4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666790348; x=
        1666797548; bh=TLywN80PBRSGp1V7EoHZWP5yAlnJT7LvlPlsl/LopeQ=; b=g
        nqT2+3XrQg7c1oXRlXRozHMxTPHBtzzY48/WaveMrAqb+rf+NKkq6GXF99J4Z4d8
        NFH3a1H62sr3c66YKAllmytzEX5asgq4EJTYyr1HnNvIs6GYX9Eg1lvwcL6YlW4n
        fH4QHUZvLvY9JEqyRX7r3AKN0IgqEYbBi4ITvIlOuHG+/+aV96TTPg76zaYMQoD2
        qnWFLQm87K0HkFZUNTtzdXKRp09epdU7L0HfpxHJ5LhZQC5YFAZDWZdan97odszT
        cRt+iSYbmVeOtZ3z0YUK3fkO9MC3nJX2MXiM470AdjO1ClKDgVA2UmkXAV4Nzf2W
        K7tF29+Z3F59iMFqo2h4w==
X-ME-Sender: <xms:zDNZYwbB5KuZxyDwgCvn09QgKtpHKi7czyPmMqquerm3DsilwYqnrw>
    <xme:zDNZY7avTyMqOdQWiSeSR9lT_mxVRUzS7R--NTODVx3pOKD5nzZrs2FxXszrcVTIr
    WRb8AvwrIb_RAk61uI>
X-ME-Received: <xmr:zDNZY6-s82eYgbV9EzNTao8zBQO_HsocZfiPTamCkNU1nBAAJGCg8_0205RkSXvsUAa7MPkkuCnXmlHy42snQjN-FBfneMPh3aZG3_7r5t4KAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeelleejkeejgfekteduhe
    euteevleeukeekleeukefgfeeghfeguedvheeuudfhheenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zDNZY6osHWh7DAww5nzAO_5atbiIVTNYILrLKvpAVNMOJxA5I5KMoQ>
    <xmx:zDNZY7qEiF-cZybRD1F7IQUQUNmA8x5Ec8soH-_wVd0M_7srDxvyuA>
    <xmx:zDNZY4Q7vnxubaozxFFpyTOgqqlt-PKRLBMzwI79OBfmS3waekzcOg>
    <xmx:zDNZY2_NygNhVavNOzOSsAN3IzsOsqigd-LZfHn4chKInD_hgOn9CA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:19:07 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 15:17:39 +0200
Subject: [PATCH 2/2] ARM: dts: bcm2835-rpi: Use firmware clocks for display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221026-rpi-display-fw-clk-v1-2-5c29b7a3d8b0@cerno.tech>
References: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
In-Reply-To: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Dom Cobley <dom@raspberrypi.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=4odMoAG1abpvun5lAxsDv4lzD0ztevxrOrt8+5rnofY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmRxsWTjk13zmBZW8H69PDa7m1b02PbOSd69C1l72R/FlIi
 sehMRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACai7MPwz+DaYQMXi/+7X/f3b1cTYp
 zUd67cz/nhpzMR/msvxDVuvcnw3+uj/BL1phwl/b5EbqGu05xqe8MV4vdmfz+zZOGk7nWzGQE=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've experienced a number of issues around the cohabitation between the
"real" clock driver in Linux and the one backed by the firmware.

One solution around this is to follow what the RaspberryPi foundation
in its downstream clock, which is also what we've been doing on the
RaspberryPi4: to use the clocks exposed by the firmware.

Link: https://lore.kernel.org/linux-clk/20221021140505.kjmw5x4s6qhnrfif@houat/
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2835-rpi-common.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
index 8a55b6cded59..4e7b4a592da7 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
@@ -7,6 +7,23 @@
 
 #include <dt-bindings/power/raspberrypi-power.h>
 
+&firmware {
+	firmware_clocks: clocks {
+		compatible = "raspberrypi,firmware-clocks";
+		#clock-cells = <1>;
+	};
+};
+
+&hdmi {
+	clocks = <&firmware_clocks 9>,
+		 <&firmware_clocks 13>;
+	clock-names = "pixel", "hdmi";
+};
+
 &v3d {
 	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
 };
+
+&vec {
+	clocks = <&firmware_clocks 15>;
+};

-- 
b4 0.10.1
