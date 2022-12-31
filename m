Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798B265A79A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiLaW7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiLaW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:58:59 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2253F5F;
        Sat, 31 Dec 2022 14:58:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5861F5C006D;
        Sat, 31 Dec 2022 17:58:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 31 Dec 2022 17:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672527538; x=1672613938; bh=UI
        j208ZckqwwJnZo7QJM+OQgUAuj8zTVh+bX7armmjQ=; b=gXANbPZRG6uAzcVeNK
        li+SFPDzkM1vxp9C51jByxCghGN1kekf/DTHLRpErnP+5uFz4IRNMzP/B+EVKs5p
        xWrJ8bmpDxz6TolMmyQFAjSmUmhb0K4DUhXg5D4WOs8IyX0sNc6R2EQLArO+7yRL
        KzKpVMHia+7bnlrRVYYB9Jb/Qj2EP6N4OlaL7KaiJXa7+1a9QfaYFtFwwx8Ryuty
        BbN06sIwsQ33E+Ggcv/3DiAbsu/MP+8p7S52Fu5pQEh0KFk9ywLQ8Rxyul7DHuw2
        hihqRzVR/9n2KTnYvmmYt5D7hhPXdRg96QzL6MBVmboEgCVk0d3Qe4tpmLq6cXtp
        SGWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672527538; x=1672613938; bh=UIj208ZckqwwJ
        nZo7QJM+OQgUAuj8zTVh+bX7armmjQ=; b=mX8tVk2VmGkMCLfoacXMqYNalrSsb
        kTchPlKzk6ObhZQ4ZuAwQZiuqIXXsSVqqg3QVRoT8TvgwhvP7qMyWMWQVWHap2N2
        5OQHvQ/qHyA4NBSdjp39X7fGXo5EBI8b4ECymDfwwb0etJP2RSxjEhYSV7apt7tQ
        soIkO66BhuzdNPvGyEc1Sx05Y5zSRhrEr8AG3FAIgy5GCfJM6aNnNZ78GQh3YL+Q
        WlsFbk9zOd/lP/qrzJ0TwRksU0JY2VhhIASYXk9LT7Eivp19fD/1AQuC5VL7XECd
        qBzOI8YuBUh/LYNYVHI+1WYehKsUweSoPkDmJh7j/D/sip96vulCRJopQ==
X-ME-Sender: <xms:sb6wY4PFiucqcSFhtsTkjrOqTHEIvNtjl-9g0M2dyzhLm9kyWHQHkA>
    <xme:sb6wY-_mQzqTkmDfA68YxxZrDr8YuJ7LrFPTVJ7pnnrIk2EPMLYicMs3seXNuPuWd
    bqI9efeyDkxKzoNMQ>
X-ME-Received: <xmr:sb6wY_RlGO5IyOQx35Ng-1Ss-Y_8cY5eQ9B12bqd-2c2Vxr27ihg45--s5x9O9y0zjLPHSbO7UoObOmAio0O8oq77IzIddftnx9WNwHwFmAj9AcQX-pip4u9tuPtLLMu1SVvXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:sb6wYwsN0CWeA0a8Tw8yVRmMful9koxQmMx8xqPxlR4tOteM5fxXxA>
    <xmx:sb6wYwc0tdE2ZjkXXbLvW_EEMhw7fPSh5j_SMAup14OD4IQY81HrwA>
    <xmx:sb6wY00NQKDB22VHNe9S_1TtJCSfJhXhzImZUZb-KMp1hJ1npjzU4A>
    <xmx:sr6wYxXW_GyrRCXghzrs_3FoAayZ570t9PSvEtVFQP5Ti5J-ti4f0Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 17:58:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Karl Palsson <karlp@tweak.net.au>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 2/2] ARM: dts: sun8i: nanopi-duo2: Fix regulator GPIO reference
Date:   Sat, 31 Dec 2022 16:58:54 -0600
Message-Id: <20221231225854.16320-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231225854.16320-1-samuel@sholland.org>
References: <20221231225854.16320-1-samuel@sholland.org>
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

The property named in the schema is 'enable-gpios', not 'enable-gpio'.
This makes no difference at runtime, because the regulator is marked as
always-on, but it breaks validation.

Fixes: 4701fc6e5dd9 ("ARM: dts: sun8i: add FriendlyARM NanoPi Duo2")
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
index 43641cb82398..343b02b97155 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
@@ -57,7 +57,7 @@ reg_vdd_cpux: vdd-cpux-regulator {
 		regulator-ramp-delay = <50>; /* 4ms */
 
 		enable-active-high;
-		enable-gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		enable-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
 		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
 		gpios-states = <0x1>;
 		states = <1100000 0>, <1300000 1>;
-- 
2.37.4

