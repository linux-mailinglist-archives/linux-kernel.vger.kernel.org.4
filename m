Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8A65A835
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiLaXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiLaXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:38:58 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263E65A5;
        Sat, 31 Dec 2022 15:38:56 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A0C55C0086;
        Sat, 31 Dec 2022 18:38:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529936; x=1672616336; bh=wq
        SQ4eWO6wTVB/5k5mQwEiKQFq8qPE3bzEg36ush5R8=; b=LGnfHkhSOtuBXjNEC9
        C7sxR+alGpG0FGDFToo8Jg7YZZAYxNKe5qRbo6ni/USe8uIt5KWoTFsWczojQydz
        uPPY4lEXbRcDvU2GShmhXk8CT0S8b1pp9RHFZOufoU3yGxwYKq59qzmgQBH5Q8D7
        IabeIuNMxqWl6sN39ZqD5sk5WVdcQ1jQTRd3/bpaV2Gx+wMukg/4FPDH85py4OXC
        z95IvLWGgKh6in3NPpwWlFO2e6KL5sAmj4KSUoYGo37JCa8gseXpeoJ6P+S8BUcy
        mhdcFEkyFh9FbWbOvfADN4Tao8qhGTu9KWY5Nm8+/L141EEYW4epazb5sHMfPihy
        Y1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529936; x=1672616336; bh=wqSQ4eWO6wTVB
        /5k5mQwEiKQFq8qPE3bzEg36ush5R8=; b=Dj1OtC59q4ygCBO4VxHwPMNKNoslP
        L8xgc0ZBF8NJuyRd8VV9dDgvv7vaoy0H3F8CVUZdTZ4TU83wFsdLa2gXujlkLz/N
        L97kxi3xtSYs9dsYNiSvRqVbd3WHL6kadCkO4YVfgvnEeAMnuOCRtp7cp9ctGnaV
        mNjVZzM8zohlD2Z/HR/+hA0Azqs5vBggW2VsDt/0r2frXPcozQyeslGr5Zna0HVK
        fd+SzaEg0sLOVO3YoCeRPJHYNsOFraD0bQy4QMaHgYfGuUVwBDb13ZUO7mlYqj5F
        778jarnZL9U8789fSmeqx4Vq2q+5OIaIaA48uBSX+YZ9tRsg7lgMBpIhA==
X-ME-Sender: <xms:EMiwY_sYLnwgu7U0Bllv5k6GkHdz4C091XAN7qtweo7oEatrhAxKnQ>
    <xme:EMiwYwdBbEOlBTR4cBl5xeQfDX_29BkGdLJMwIMD3WCvmpL4ijw4ijYNGW8EYqR8w
    zWbUbCQtABgDN0XkQ>
X-ME-Received: <xmr:EMiwYyxSWPN-zx-QoCUVKVzf5ymENJbzS8V7-P1pRS3Qpj-vrAn5m5yy3InBiVnBOwTEbZQORSmrKqey9dL2Jpk-h3IzsXIqcXeVHZwrhHVNmCTqZlUDgOGHA0G-MnAO6KTqFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllh
    grnhgurdhorhhgqeenucggtffrrghtthgvrhhnpeelvedtvddvveeikeeiffejgffgueei
    teeileevlefhueekjedvvdfgieevkeelfeenucffohhmrghinheptghlohgtkhifohhrkh
    hpihdrtghomhdpmhgrnhhgohhpihdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EMiwY-Pw4SOHGSqH-g5csz1T9v_qwooUDWxYMy9y94oV8djhgJYapA>
    <xmx:EMiwY_9GJ21hOh4eXb7B45-S-dAiXAaxQpXBw-y188XACn8K4WEPWA>
    <xmx:EMiwY-XwfNlL1MQUCsbQhp-CaBy4dnBZ6LGGd2d6SRNG4nlIRgrf8g>
    <xmx:EMiwY3MK0f7mTb5l7n6EP66BACIlwsK8WX4JuRVZPspOHOD3vPSYJA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:38:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 02/12] dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
Date:   Sat, 31 Dec 2022 17:38:41 -0600
Message-Id: <20221231233851.24923-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
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

Some boards using the Allwinner D1 or D1s SoC are made by vendors not
previously documented.

Clockwork Tech LLC (https://www.clockworkpi.com/) manufactures the
ClockworkPi and DevTerm boards.

Beijing Widora Technology Co., Ltd. (https://mangopi.cc/) manufactures
the MangoPi family of boards.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Rebase on v6.2-rc1 + soc2arch-immutable

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a9fa8f5c6c02..3f5f7b067bcd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -264,6 +264,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^clockwork,.*":
+    description: Clockwork Tech LLC
   "^cloos,.*":
     description: Carl Cloos Schweisstechnik GmbH.
   "^cloudengines,.*":
@@ -1446,6 +1448,8 @@ patternProperties:
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

