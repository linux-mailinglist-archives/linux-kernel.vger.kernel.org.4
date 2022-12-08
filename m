Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5653C646B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLHJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLHJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:02:53 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23BD1F2C7;
        Thu,  8 Dec 2022 01:02:52 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B1EB13200201;
        Thu,  8 Dec 2022 04:02:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Dec 2022 04:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490170; x=1670576570; bh=+D
        3H6ZZlXvxWkF84FpeHXaqAt9NC1A4IUpFvvi4MHzA=; b=O/lPBWPlCRCVSHqvLI
        WE9EZQRBBmdd/M426G6gnYJTsID6IR1tBCT1Zdg10iPLceeG7W6rqqB07P3123VD
        23Z5+ruywsxALjL7MeKNuMiQJSxrG8NXFiT+iG/diZ23qWlDc2y24cl5XH1agaR5
        hKSbq40vMymYE0l0XoMZSyW7l3+xwrNGyLqQq7Cn7GsILCkpGJVZTLyRncLPKfj+
        b0j5+Z3p0wv5MAnvXbS9B32UDv3D1BvbkXiveYZ5zK8WOITYZuzMvjH1MB7gJWbi
        ewZ84q/6ubY7KfCB2MR+XXMHHF9seB6ajs2xJjnuJuiaqXsNNmKG916OF56aMaRg
        tsmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490170; x=1670576570; bh=+D3H6ZZlXvxWk
        F84FpeHXaqAt9NC1A4IUpFvvi4MHzA=; b=qkMeVt1iZNFgCcHFkysPxL9s1kV6J
        PdBwKZYYS9yhlAq0fjS8Nmi89KVL9V1HGX6OjaRG92iwDtNRtm9bZ/vjMcAXADHT
        /GV3wylsKMX/UHtfoqocsjofCFgiUhCsq7c2hUeN9siIVGbQrJ01rIOzTewV7r70
        Dyi81R6tUtiZwQx6aHS03YLd7BBz0qZhhLglgCZoAd9MtSdOnh3RPtxQPOfya752
        o79SH6Hbh2mKiW044Nt2e1TT/eYRwRqMhOEayTeyflp3ptYrpAA57cSxvIzo1Mh9
        8WcemfQanQQn1bZbF9PBe2XXeN+YGp6om9vBMzzwT4IHPp4Owei+ggBsA==
X-ME-Sender: <xms:OaiRY99RIbWD_g4ujfSl3as_uExYvrZFMTKXZj4Vm4I4sVln4g9dhQ>
    <xme:OaiRYxtSSDLa2OzZI2A5ZX-_OoUIHZ_sbpibCzlnZ6n_dzB-Wg9o9FG441Hz4R3fd
    TcXLxutgi6AwHRXeQ>
X-ME-Received: <xmr:OaiRY7CP03T2lfEjOt9pj-mx9Vp_kK8hCao6T23zMww8fIXDmciXs6Zz5A3SxGI-fUeIFpOkYk0sL__YX1iPrIVbABtXglKGRz1FqEKKUKxz27eOVezVakUJvQbezuqKBoqoNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepgffhvefhgfehjeehgfekheeuffegheffjeegheeuudeufeffhffhueeihfeu
    fffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:OaiRYxe6TyznHTf78d60vzRT6c58SznULoQYAGiIpBoJpupctn-w0A>
    <xmx:OaiRYyOqmjrFatkyveSu3ERPiiJgcoJcHtbAMXZZT-4c90h6qBBfjw>
    <xmx:OaiRYzl_4JsnVHU7xO09eVbgdMUdTwth8SOdAp3LcB0sI4MNzX_3kg>
    <xmx:OqiRY9HRKtPFaG9g-VTTsNsW9Z5D_VXnOifDG0oat1C07l1WB9v_Yw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:02:48 -0500 (EST)
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
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kerenl.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v3 03/12] dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
Date:   Thu,  8 Dec 2022 03:02:28 -0600
Message-Id: <20221208090237.20572-4-samuel@sholland.org>
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

Several SoMs and boards are available that feature the Allwinner D1 or
D1s SoC. Document their compatible strings.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kerenl.org>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - Add MangoPi MQ (non-Pro) board

 .../devicetree/bindings/riscv/sunxi.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
new file mode 100644
index 000000000000..9edb5e5992b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sunxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner RISC-V SoC-based boards
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  Allwinner RISC-V SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Dongshan Nezha STU SoM
+        items:
+          - const: 100ask,dongshan-nezha-stu
+          - const: allwinner,sun20i-d1
+
+      - description: D1 Nezha board
+        items:
+          - const: allwinner,d1-nezha
+          - const: allwinner,sun20i-d1
+
+      - description: ClockworkPi R-01 SoM and v3.14 board
+        items:
+          - const: clockwork,r-01-clockworkpi-v3.14
+          - const: allwinner,sun20i-d1
+
+      - description: ClockworkPi R-01 SoM, v3.14 board, and DevTerm expansion
+        items:
+          - const: clockwork,r-01-devterm-v3.14
+          - const: clockwork,r-01-clockworkpi-v3.14
+          - const: allwinner,sun20i-d1
+
+      - description: Lichee RV SoM
+        items:
+          - const: sipeed,lichee-rv
+          - const: allwinner,sun20i-d1
+
+      - description: Carrier boards for the Lichee RV SoM
+        items:
+          - enum:
+              - sipeed,lichee-rv-86-panel-480p
+              - sipeed,lichee-rv-86-panel-720p
+              - sipeed,lichee-rv-dock
+          - const: sipeed,lichee-rv
+          - const: allwinner,sun20i-d1
+
+      - description: MangoPi MQ board
+        items:
+          - const: widora,mangopi-mq
+          - const: allwinner,sun20i-d1s
+
+      - description: MangoPi MQ Pro board
+        items:
+          - const: widora,mangopi-mq-pro
+          - const: allwinner,sun20i-d1
+
+additionalProperties: true
+
+...
-- 
2.37.4

