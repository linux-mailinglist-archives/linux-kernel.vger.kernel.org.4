Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F0646B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLHJDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiLHJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:02:50 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812B6276;
        Thu,  8 Dec 2022 01:02:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C70ED32002E2;
        Thu,  8 Dec 2022 04:02:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Dec 2022 04:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490166; x=1670576566; bh=JG
        w0CLwJFa2mZr+m37NEpZYVUBjHBKI5WIz9XbIZnTk=; b=wvBIW0DvyIQbRAs30J
        jlkHHoMrwMIBsqzx6UX7BjDmqSMcun7h+lW3DEFvEW/F12vgHWuuW8Ah/NuydmBJ
        ekxL5bRyPsmAOo2M9TPmKT2aIl4uau2pyN5XlqrArpJy+U1stQmy0GBwMOeAp7lD
        NJYPP4W04qt6j7EugrSxpSSrfHLrbGOM2Kl+LsK1LQ/Mz1WN7ypqeRG1xaSLO9O3
        EP2+5DSCeigzO5Dh4LhrFr5CBdSiOgy3x5nNxhpbKhiUcPUITNnNrbTucEgy68Jj
        KSjjzLpX+Nd3RE4y2JvtlBT+Z2uOmBVXq2KLbqoKs12UF1LcQAabBLl3wxPUmxxJ
        Gbkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490166; x=1670576566; bh=JGw0CLwJFa2mZ
        r+m37NEpZYVUBjHBKI5WIz9XbIZnTk=; b=Ek7osepW+po1q9BnKMowh0x7B5GTx
        3bEUebCShPTf8KYHot+5kA7JlujyNGJElI2vkFNrsAoG8lAbIx3gAty73SB4n7PV
        GHjiYtIL8CCsgU8BR3xyFmCq9U6PjsoXSF7o+1VSWs41JT4WG+V+1FnDHlhfFAjC
        o8kq2eDoSwkOEuhevicnYFc+6gQ3PFJfYYs0rtP8unfooPDuW9ZqApMsE2GCCivE
        EYjgpmltJcsJLjkFEG6NnFFcTAyObw2sMhrDqk1ij0qzo5xxkqcoop+lZOas1mLa
        6j7wQ9hVNM+8W6TVKTRUXHwRCnZkhZFeY620+ZFDAIAv+1PhtwNmMTRhw==
X-ME-Sender: <xms:NqiRY-PyG6OXOk9_niGbbqOmwr7cFkhoMh_j51QoVcQ-bNYoBKphQw>
    <xme:NqiRY894WJog3CZsdIvwWaj6gNcrLrREmoAAaNxv2YXNpR8dNDaOuTlUL_fnoKMOT
    P3fFYZoYNANA5M_8g>
X-ME-Received: <xmr:NqiRY1TCaQx9XIxhZbLJvQbP-6xMSuoW2HMLqXVDrAdh-cl3-_M9J1b2HUP9Qng5P3IiPwAES3eddQrwzF7PKHL1RBRTcg8ATVcOMS8_t8AwBBcZpBMQkWtDcOoz3x4v6-qPeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholh
    hlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepleevtddvvdevieekieffjefggfeu
    ieetieelveelhfeukeejvddvgfeiveekleefnecuffhomhgrihhnpegtlhhotghkfihorh
    hkphhirdgtohhmpdhmrghnghhophhirdgttgenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:NqiRY-uh8o_-mttOnNxud2pWvNzGp3nKtQSVJWTroT6A0iC67iIo5Q>
    <xmx:NqiRY2fXr5ISFB1CvAWT5UpntxMFh4hMBPCi48UjrZV5LUilGhU-CQ>
    <xmx:NqiRYy3dP9ZBHKQSUoY5BMLGesIYyqwSYNL9TvxrldgrorxHJP7cgQ>
    <xmx:NqiRY5vxTt-SOckaDgEmOK3HvBOIESt_eHiWB0z_ofM4fFjnG-6Wjg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:02:45 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Guo Ren <guoren@kerenl.org>
Subject: [PATCH v3 02/12] dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
Date:   Thu,  8 Dec 2022 03:02:27 -0600
Message-Id: <20221208090237.20572-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208090237.20572-1-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
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
Reviewed-by: Guo Ren <guoren@kerenl.org>
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

