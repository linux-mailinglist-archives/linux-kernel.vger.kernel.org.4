Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4285C639255
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKYXrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiKYXrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:06 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CA5A6FA;
        Fri, 25 Nov 2022 15:47:03 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A05E5C0102;
        Fri, 25 Nov 2022 18:47:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 25 Nov 2022 18:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669420023; x=1669506423; bh=oc
        0vqOxK1/ubxsXqJRc0i0XePMXd2FLoXsdGEJA3VdU=; b=cDOSrn7HJKWbmYj7r/
        9yI5ULM0q+StizVKU0Eq6TuZgOr038kWzW+LwnaREwNYbe0IqAKGYiVZ0Hzoxtuw
        LyfpyF2E9cDwqxcAVJrjnRv8Zfpitsi38QNyLhKhh5zwd3ZypU8XGS1npbrxAfg0
        TWFV7k9ZLIy/qADf88zj+84/J/MePN+ogfPYuvEIIlevFXbpCgb4iDv//FO1foYg
        JzXSLDU9DHduLBeAdE6M/LJg5LiMMwmAiI3Oo0TmCG3lWjWK+4NUCwkYFW7FhXKL
        1MDUIwJPOjdZvQDoS2RGcImJPh5P5pIlLd4bJdg5LC4mXPiDDbtYUOpFWnmaZjiV
        /DAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669420023; x=1669506423; bh=oc0vqOxK1/ubx
        sXqJRc0i0XePMXd2FLoXsdGEJA3VdU=; b=p0wuJvSCFfV8OqAkErXyz6sNTILUa
        Isyr6j1qXYU5XbxNbCrw105TVGMhovDkZJneWU3glcnV/15GYBJ5WbQru6uAksbS
        UZ0tIncqCEPzYDcEKwFFFPQFyKmMJSVv1/BtEi83WJov7o2gnURiX7yzPyvnAvYg
        0bBbw78Q1ux53e5FrZEefUXk7mHi29oJ6X7deAPhBYC5dZVBA8aVu3rD6KiJs4jM
        Lhq1mhFprenNOte4rRSlFzAxa4WZSkX0XzwLR7UqVlc1nu2hbcoWKrQqAWgAF50b
        D7vipOHt9N2++N3Sj/EB+zMED+CUjtN0vyHIFIh5IbnjcsMA8hJXmNUUQ==
X-ME-Sender: <xms:91OBY_lnoVcXCG2ckxn2_ffmkzT_dd7n_NMq1QN04KWQuIQ1cueuPQ>
    <xme:91OBYy0XpWJzNtTTSmcHPiTVI0mj7julC6p56LaahzLrC7SOalnkw2KLzKT_k4Y7K
    ulbDkfOM1L1YXeA_Q>
X-ME-Received: <xmr:91OBY1qk-a3rApzP1B2p88dd2MqyQjj3dCalGe8S8uuRY6MEiIF-jIt5oI8nBrlhA-As2_tx_453lwg170BAK51PA08KpYnd4NkNBDOSALHfKeAGpDB62c0HIdPN9WDZ52o2CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllh
    grnhgurdhorhhgqeenucggtffrrghtthgvrhhnpeelvedtvddvveeikeeiffejgffgueei
    teeileevlefhueekjedvvdfgieevkeelfeenucffohhmrghinheptghlohgtkhifohhrkh
    hpihdrtghomhdpmhgrnhhgohhpihdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:91OBY3lCzzB5ZtRN5gFkHsOwpJOTPbbGt0T7HWQMwQc5QxlxiPsf1Q>
    <xmx:91OBY93Hx2_F1fIClOG1ZYCndOe2mI7xOGmipAHBNmsUFBsn42MuZg>
    <xmx:91OBY2tDQ3yxaioSF5X9dxplY7LV0Tv0I7k-ZP3aww0GRDdjLIsHMw>
    <xmx:91OBY4G7255r_PrbDHaXUzNQKKvzrFvsVoR1v6tVz8dfYVDHrdLInQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:47:02 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/12] dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
Date:   Fri, 25 Nov 2022 17:46:46 -0600
Message-Id: <20221125234656.47306-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221125234656.47306-1-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards using the Allwinner D1 or D1s SoC are made by vendors not
previously documented.

Clockwork Tech LLC (https://www.clockworkpi.com/) manufactures the
ClockworkPi and DevTerm boards.

Beijing Widora Technology Co., Ltd. (https://mangopi.cc/) manufactures
the MangoPi family of boards.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 592e43911a07..f2c67b7418e4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -262,6 +262,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^clockwork,.*":
+    description: Clockwork Tech LLC
   "^cloudengines,.*":
     description: Cloud Engines, Inc.
   "^cnm,.*":
@@ -1430,6 +1432,8 @@ patternProperties:
     description: Shenzhen whwave Electronics, Inc.
   "^wi2wi,.*":
     description: Wi2Wi, Inc.
+  "^widora,.*":
+    description: Beijing Widora Technology Co., Ltd.
   "^wiligear,.*":
     description: Wiligear, Ltd.
   "^willsemi,.*":
-- 
2.37.4

