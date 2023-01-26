Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2E67C40B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjAZE5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAZE5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:57:42 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A888561B2;
        Wed, 25 Jan 2023 20:57:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7001D5C0568;
        Wed, 25 Jan 2023 23:57:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 23:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674709060; x=1674795460; bh=f3
        oasT/IpT0I6FIdvaYChRtQISkb5cTVuFVOSELrKsg=; b=Fi2x6BtbpdsY9nDuwz
        eC3X/KHKds3VnAHYxcGGlNHeSd9HxQsKIu0gzDD26pnMKHdZ/LWJjZO1lDyZ1MNT
        T5T3TZNQCEuZfO4GAVXPw77ARCREyWQWQOPlGeiSjTjUsKNibULBZgrVsxB7g4Wj
        dAHfqIrNJIFOXr8jM6eaA00XECAGOTEAiWLtrvDmb67f7GqixbwcqE1YGCOkxbg2
        6tnmvLnDcOSz6MeywPh30TyxoXg9GvDv+f3XmlmDg8CfSyzMr4hqpISAKXGQdJ6b
        XdG7wyirB/yVa0ZWcFpZo/GsnKv+wrdSbB+cDQ+YuC3eqWKoJIV/tHYyxgo48GXq
        Odew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674709060; x=1674795460; bh=f3oasT/IpT0I6
        FIdvaYChRtQISkb5cTVuFVOSELrKsg=; b=HD1684ckEAu5yS6v8C+GdqwVY0fQr
        LLADtxp4U28bqw9nVuqfN+fZRQ5Ev/pkOwfTfacBXGsjEXv4flzI/3iGoIVlRRj1
        WvztxU7sONa0LIY1rKBFuijVEB+UfRqVOXw7CGrQq6j2R+sQ3RIKceFGq27Thx3S
        AWFQhzetSygtk4y+g/CXOCqAJAp7opFJB2A/rbG194UXw/LBSGITQlqWes7zJCIm
        iua2iO1bnju8GZUMPULdyzfLgGYmWDUp060C3eg5aQ4BDYyhyiGfFGjzO2fblYBT
        P4GXXXKJx8eGo4gLfatywBv3sJgz/ukP1Ug3t1Z93AQZXYaCJzQp/Kskg==
X-ME-Sender: <xms:RAjSY9vcpsYDHHXWG3n2GccwCpDzyDRJUD7_BTz3a0rgaibrdCoshg>
    <xme:RAjSY2fnUktqbFiHu_Eg-oRpNYc2PUkN-naoeKXX_pHx1-Er37hDzb_vRFkIx3igo
    3HapDlGGj3gOILsvA>
X-ME-Received: <xmr:RAjSYwxphyrsq3q0zQ8F5a60bJ9-u219ACrFVUchCgo-ma68Netn5OuAR_ZkqYOlcdCskKeO_Ltr7ClZ6Yp4C602MppY4fgBsIYmlOde2rZwAHjtHKZihPf8iVYGE-gFXHrsxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholh
    hlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepleevtddvvdevieekieffjefggfeu
    ieetieelveelhfeukeejvddvgfeiveekleefnecuffhomhgrihhnpegtlhhotghkfihorh
    hkphhirdgtohhmpdhmrghnghhophhirdgttgenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:RAjSY0Pu-0c-C6_u7B9ZtxTDkAU2_qWLEPfRftHR9_BfR15YopeeKA>
    <xmx:RAjSY99oXPqe-Srkq8l2Iwdiyt6JaOD53zOAMjaQXDYSmtTqiIIrww>
    <xmx:RAjSY0WdCzDnCjvaLZZ8ElEsqVPPcC_Ka5HTK1wAXgg3zZK1nHXfxg>
    <xmx:RAjSY1OV4k7JS-mCLO1rEhSDeQBuo2uYPZHMSulWddCV3HyR3YE16w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 23:57:39 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     linux-riscv@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 02/11] dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
Date:   Wed, 25 Jan 2023 22:57:29 -0600
Message-Id: <20230126045738.47903-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126045738.47903-1-samuel@sholland.org>
References: <20230126045738.47903-1-samuel@sholland.org>
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

(no changes since v4)

Changes in v4:
 - Rebase on v6.2-rc1 + soc2arch-immutable

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index eac00f1c770e..b7055a43c6c4 100644
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
@@ -1448,6 +1450,8 @@ patternProperties:
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

