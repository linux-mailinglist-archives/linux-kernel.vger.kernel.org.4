Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5665B892
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjACBJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjACBJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:12 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929C6583;
        Mon,  2 Jan 2023 17:09:10 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6B3AA320091E;
        Mon,  2 Jan 2023 20:09:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 Jan 2023 20:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672708149; x=1672794549; bh=rS
        dD9Eyr/xiErPEA9MSXkTaUL862gDKe06QmYAccHDA=; b=bJ5mBVoE1Z3WMZTo+G
        W4RivL6losj1Yk3heM1b+vtHt1v7g7+gzFV9eBDACr4xqZFZ2sJAqvRYyCd16V0y
        bjqiJ2HwzctfOPdWeo+o5GpmSV9vEdN/z1OgHlrd/fzgFWDHO5mTOm1nbhG1bh+h
        RwQhbu1+MxHnuHBwWBVbyshF2EWzsNAHZdcaOSKsCiE+MteKZBS8Lts45RlqsFS7
        MXPyx8b8wivKv5g351huCEjoQARmd+V4LBFHuBBRWdQKwRW4emwpyWBwsuSkqOz/
        mhf4V8BGEM8h1ytspibokGxUVlaTtYZwKmvEfwIV0a/0921RXFe8ggPVNjgm00+w
        5Tsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672708149; x=1672794549; bh=rSdD9Eyr/xiEr
        PEA9MSXkTaUL862gDKe06QmYAccHDA=; b=Whxu3WgLF0P77rD14HLeM43ijeHqC
        pjfUh17lGRnn5tjzOiWgRmun8SMHWmt9cARqW8svO2yJ6O1ZHkG0R07zyTxWjHVq
        tB6ZXwWSBMdpP+MErqZy+qQmOZ4AK39vAm5xjFvI3p8HnjL4TlXnX0oNKagHpuQO
        i9agxF7aOC134tzqDMrd6eb6fHuDL01r2t7j/Sxlmz7PMGiqHGq1AnKA6tLz1NiC
        +fhAqO7qZahSUqTm02M+x5j2gVRPjGKV5sdxEiuoua4ar8yLM5TFnha50w9TEvIz
        DsQk1ZBEFYH9AbhY85yYujm0dx3FwzAIBK+QBGvBQCyOTj9u5ywMOUAaQ==
X-ME-Sender: <xms:NICzY14jMx27nHmvp5QXPZrFIV5SNQ4WQb5XFPS5-zr4TiOp3CkcMQ>
    <xme:NICzYy6fKsdnVIUWSNAdi3XKAEL9INEliksrYEGiL62UL4NqBX97S6z4avqqloUQN
    IVZyj7w5k47ensCDA>
X-ME-Received: <xmr:NICzY8dy8bH7Al714AUXWQlJ3-My-7GKOW4jlHXNqQiDooql249NZRQNxhy0ocTG6vC3aLm1ebpbT-htsfIbVzRXLULm1rinZZTFSj0tu-O3gabfTDgtNpvXe5atmgJdhp3Cwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:NICzY-IURFeAUznAaQ74JpkdpG2OHhjXNuwO7OU9SW6GeDVTNTBKDA>
    <xmx:NICzY5K0W8u5t6u2nOYyZuRv82iW6F7rpbfoLMQynWz2ejCMfbhFwA>
    <xmx:NICzY3yqxY1C2FQw3VGYOQRxsWr0w8FYZl1fjr7J2baw9mjxaugQsw>
    <xmx:NYCzYzBJ27ooWwpSqG1j8qEkdDVKPmQHt5-ipw4qMdEbkERfOkHxoA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:08 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/6] dt-bindings: iommu: sun50i: Add compatible for Allwinner D1
Date:   Mon,  2 Jan 2023 19:08:58 -0600
Message-Id: <20230103010903.11181-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230103010903.11181-1-samuel@sholland.org>
References: <20230103010903.11181-1-samuel@sholland.org>
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

D1 contains an IOMMU similar to the one in the H6 SoC, but the D1
variant has no external reset signal.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Disallow the 'resets' property for the D1 variant

 .../iommu/allwinner,sun50i-h6-iommu.yaml      | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
index e20016f12017..5aeea10cf899 100644
--- a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
@@ -17,7 +17,9 @@ properties:
       The content of the cell is the master ID.
 
   compatible:
-    const: allwinner,sun50i-h6-iommu
+    enum:
+      - allwinner,sun20i-d1-iommu
+      - allwinner,sun50i-h6-iommu
 
   reg:
     maxItems: 1
@@ -37,7 +39,21 @@ required:
   - reg
   - interrupts
   - clocks
-  - resets
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - allwinner,sun50i-h6-iommu
+
+then:
+  required:
+    - resets
+
+else:
+  properties:
+    resets: false
 
 additionalProperties: false
 
-- 
2.37.4

