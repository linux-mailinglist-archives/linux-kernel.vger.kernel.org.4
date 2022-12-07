Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB6645913
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLGLdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiLGLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:33:02 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44661AF32;
        Wed,  7 Dec 2022 03:32:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 426913200488;
        Wed,  7 Dec 2022 06:32:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Dec 2022 06:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1670412775; x=1670499175; bh=CndWv91ai/XOQYpVh5b+BeS2Z
        BrDaMbdKpng8qtdwuU=; b=KCWVvlna4+Kb/EdluMoXPN+WtKMPd2F0iC/h6qFzV
        5ekt6iS6PAnrlui8yC5eUwTswNKpZGNwy+ZgqJPAMjljhCRIhLJ9AVHEErV1FgYr
        /d11+gKvO9tfCRMarMNr6bCKSBfbIEmLNJTIqsEHaPCMVn63de5i5pemxWSNGxnH
        23MFkYwwPgcSK+gPcnf7DzA6k/E3O98aSlwKAcDDsfyTCrE1Y6/UKdw+ZHFGuMWe
        mMoEohagvvRKGYN9qPu8xMmx2Av8fdgqBh3PqAcW7GQvHf3hcMVNe5R4YJcjdki7
        Zc4P8E0A2lWbiBhg/Jn85ilNUEfAWR41crlTdaazC2SDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1670412775; x=1670499175; bh=CndWv91ai/XOQYpVh5b+BeS2ZBrDaMbdKpn
        g8qtdwuU=; b=dcNfwfUVrYO0aBWmUSrvu2CLE2bZBGW9WFnw6bwpotVvBmNplAy
        Qd0R08POgiSxoVtRaL5KCqHbZ42LZ+0FjoVxN26gBif4NTpnLLbGLkbh4vugPlH0
        V/wEOVP/xFGqYuZHyBwbIj50XcvW/9QqP9VMe2kQEFmoc576MApYNbahomtQYkbq
        fuxzahzGuGQXcU8R/ZYlmRvSMEMiCb7mjNQLskxMKBvxhlSt+MPmGJxACrnzUEqw
        3oToofMgqV6WXdE+7dRdtmCejTGhK9IuDqs5J2VcrtPdwDyjQD35lBNwV9v07pMi
        TQCX7ODUi1KIZnRUmsINba/NhXQxBEXZ0vQ==
X-ME-Sender: <xms:53mQY38AQkAzdS2O3vK_pXw6NLH__WbWYtiZmP1uI0p7D6F09MWJIQ>
    <xme:53mQYztslocxRwNro-fKw0cb5LXTH4E_OUMoGmnrDaL6ocLHhs-KpBw5sU9RYnwkn
    k-H_t_uLatQsIJdDbg>
X-ME-Received: <xmr:53mQY1BvDcjZ0dNrqI_d0YnuX6Y77QEmq7p0YOHNBzYiRKOlDVgOvyQpejc4sRfRkothykNF_7seoC3bdRZSqkB8DXQZ376N6k1sdSkxl7Dmc8wU-fA4X7Y2Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghrrhgrhhcu
    ifhoshgsvghllhcuoehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsheqnecuggftrfgrth
    htvghrnhepjeeuvefgjeefgefhhfefhedvffelteehkeekvdefheeiteeutdehveeghfeg
    kefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkh
    gvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:53mQYzexXYKWueBPc4KR5tXbNJPInfd1OVDxLFIE4PzLKZgRhZtkiw>
    <xmx:53mQY8OiE_xs8SO3x-tTjU0M79r684Q-N1zCWSPc318qtXO5sVio3g>
    <xmx:53mQY1kbQp9ElL_8W7O_V84_DfsC8hWXfyQatuSSkoCxfFmQNYCZFw>
    <xmx:53mQYzd7L7crYHjTTHdrtpeozG1CEtp68ORQ3mMg2D1_1crx7VKLIg>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Dec 2022 06:32:52 -0500 (EST)
From:   Jarrah Gosbell <kernel@undef.tools>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH] arm64: dts: rk3399-pinephone-pro: reduce thermal limits
Date:   Wed,  7 Dec 2022 11:32:13 +0000
Message-Id: <20221207113212.8216-1-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
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

While this device uses the rk3399 it is also enclosed in a tight package
and cooled through the screen and back case. The default rk3399 thermal
limits can result in a burnt screen.

These lower limits have resulted in the existing burn not expanding and
will hopefully result in future devices not experiencing the issue.

Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 2e058c315025..fccc2b2f327d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -83,6 +83,13 @@ vcc1v8_codec: vcc1v8-codec-regulator {
 	};
 };
 
+&cpu_alert0 {
+	temperature = <65000>;
+};
+&cpu_alert1 {
+	temperature = <68000>;
+};
+
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_l>;
 };
-- 
2.35.1

