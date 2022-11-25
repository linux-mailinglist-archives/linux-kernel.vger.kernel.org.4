Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6C639254
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKYXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:04 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4095A6C7;
        Fri, 25 Nov 2022 15:47:03 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C9D8E5C00F4;
        Fri, 25 Nov 2022 18:47:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 18:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669420021; x=1669506421; bh=Z3
        8TTIzAyr5NC9EmbM6dhKADA/gpNLtWkistuTXZh1s=; b=JgpJRyE1gx/MMR3yJs
        I+z2xpmnThqZy+bdpVcd6A2Fg6x1wVJkCRSptC4Hb/7Gyl8Or0111EL1E7jGcmz9
        0uEkWVeILUlkCWf/bYo3mHHGV0HBvmuQAak4KkbvxhDR6jPc8VOZopV5eee8AAT1
        gcq86+iPaZi27gRXaDYCDGYf9j/ddWejKbSl8b0P4fs7c4ItRlXlIeSC4j7nLZID
        N5QRjzRgJvp24qzZHUS4CQBvVHf8NeaOSEZjHVrNxUJidxxr3GCp4tajqP2R4rWi
        4qgdqEJsqzh/63bML/C1d5tIY+5LPaobceLhFdCIy1WPsgyLh0dr69oXFKZg2baR
        FwlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669420021; x=1669506421; bh=Z38TTIzAyr5NC
        9EmbM6dhKADA/gpNLtWkistuTXZh1s=; b=F9xkG2rsXhZETwaLKCoI6xVCy35mT
        Z89KSUoaNF2lsuq5XrjASPzDm/ZpttJIxlch7egjSHAllJAvQwAROL8ODXHpPZpn
        NJwdms+SZbQug+yM54fJYA6wPBurY0MxOv32Pi9oVV/XA9zLrkwkunR6ILKEJyT+
        u12Hf6gpV6PVX5T/DfoRPisvGHHs+d/Omapsi8CPEZGHRwiRgIpcieGETtL400Zl
        g1bbbENM10WV3tPbOxNxNPgboVL+HIfu0PL5id86gU/imtvoPaUhZ87+gZeymdZl
        SM1vn1/vO/85SseQU6L2T7TNesS9UwaEb88NqGgFphvl0xB14D8rLrhbw==
X-ME-Sender: <xms:9VOBY2RTU5OkOOYhRzuXiN2RbG3ePUrjh7YcMMh6jRYjaMhC8GIciA>
    <xme:9VOBY7x1jHfDYngleoAaS6J6v7zi34FpENszlz2XU8bzEQrWqDl5wDxwXtH8Sd8NF
    jorixj2VNfjcSS5fQ>
X-ME-Received: <xmr:9VOBYz1hRaHNY-zsInDfCXUch6IgFqzFYdIFDjrDyCKQZ0FkR88VPNkin4MjI9pjujp_KVi3XX-sQsAd4KzfU5fOERyQsoq9394KvKNsqSgLV9N0BmgrGjY-79I7EwjK7XxwcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9VOBYyChBs8jI5AT1nx8QJ4JKSPuiyQ51fS-_k5MfKlSl2qu823J2A>
    <xmx:9VOBY_geWaC4fxY6s_GAYS4V72TdZEE5K1DvIzAqzrHxTLv36l6R-A>
    <xmx:9VOBY-qbS3V9AQimybV5EzzBwPcCuVF2SyXY3s4Tqc6-SewyZB3Kpg>
    <xmx:9VOBY7TzypKd3xOcm74yW0C5V_g4wFXg0qi9CNPzVCAQsmj4Fbjx3g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:47:00 -0500 (EST)
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
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: [PATCH v2 01/12] MAINTAINERS: Match the sun20i family of Allwinner SoCs
Date:   Fri, 25 Nov 2022 17:46:45 -0600
Message-Id: <20221125234656.47306-2-samuel@sholland.org>
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

Allwinner sunxi SoCs with a RISC-V CPU use the sun20i designator. Match
that pattern in addition to the designators for 32 and 64-bit ARM SoCs.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd2cbb940f11..6a79f736fe35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1828,7 +1828,7 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/soc/sunxi/
 N:	allwinner
 N:	sun[x456789]i
-N:	sun50i
+N:	sun[25]0i
 
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-- 
2.37.4

