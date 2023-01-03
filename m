Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8465B8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjACBJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjACBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:20 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7FAE72;
        Mon,  2 Jan 2023 17:09:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 07CFF3200919;
        Mon,  2 Jan 2023 20:09:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Jan 2023 20:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672708154; x=1672794554; bh=l3
        3byjN96tAFT91WzVSv7uBqAlUyhhwrwVPAOp/DxlI=; b=cUBLPZjztaJPEF/tEF
        eXnYxSk3QYC4X9Z7BNWWtKNjLeMXIICX3Z0F8srYK52u98ILXKIAd8ey6+qiX+2/
        CCjS38MZ8Oe+mD2bKi4MAGhwnVkT3B9toQo1K9iJowu5tTZG2k97iHSKAnbB5/Jr
        ke2GtIwXCgCdTv3mcZAC5/B0XRLjz3OJvSCueGp7HtFYI5nJzW1M+rEgNePKjwt+
        1JpAKKyNSlpHCfgUifkjt+vrUsCE8D9ExCMld5D4SiccVrOLbsjmmIlCmYP/1n/a
        oJkSowd45RKHw7EOYQcZgaLe7UgxoBTS6CEczexSaGjrIbnpgcpS3XgRVgeskRTc
        ZPFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672708154; x=1672794554; bh=l33byjN96tAFT
        91WzVSv7uBqAlUyhhwrwVPAOp/DxlI=; b=o4pb0s46K9RCUY30Fk6zVEKZDK0lT
        JnqzFQvbGCV95Q4cwbpolMY8oC7geSKBCkCT/zx1IY5on+go50zWThlMBK6iUhha
        mo850IGtZegHv5RvI74j/eHf38uCTQRfnU3wJy6Bcl/BTiLoZBmzmGnLFFdm1zTn
        Ogx4W7OaNakzafipaZcj0y2ttLazg6HwIFGJioYA75B3ywDWBepeEQWH6PqAXjyJ
        2SDLMjvaa6rw7jliJ3nJsUraewPELG4b6UnNIKLYaeKIC4pXj4jNpSsiEOqdi8mM
        73ZnvyMUw7evkNB+jW1rsWE3mlVf7C8suf7LVlBRcHw6jvdfF2zuJG7bw==
X-ME-Sender: <xms:OoCzY40XwAL7Mw2qfW8R7yZtSXnkTobP58eAxsWnVsjHT3L97Dnjmw>
    <xme:OoCzYzHR5ATTmvCuW0oDQmDii67QGh5rV8bTrLI0UJas1y9sDl3JJJhfLDJt7VXCi
    mp3YSZ_8g3GI93twQ>
X-ME-Received: <xmr:OoCzYw5w6_foboC11EytP4uHHf7K75hsh7KEwTOe8OXLi512oZjF_6B6UzaYNzJI1ePgQ4k675xNVGUAuk00XBKaC7BS9-j-pkEWhaOV2piQJUkyLYx-pdWbVJlRKsC-Uggjmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:OoCzYx22tssr2N_jjw1IDDP1HktzUEyAq6_ZmAcbxjp_oiFcDm8Zkg>
    <xmx:OoCzY7FcaSnWQYLRNYsiyc26yuAbA8jY8eh_vJDOaBwUsnwH_qiqcw>
    <xmx:OoCzY68ZNr3X_rlHBINkSxzu6lyII9TiB36pUYrEIPhOZCsDMsg6Mg>
    <xmx:OoCzY6ePsjL84G5bb2BTz9wkGzE2_6JrqKiBPnyTkQBEA18PuV-cqQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:13 -0500 (EST)
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
Subject: [PATCH v2 3/6] iommu/sun50i: Keep the bypass register up to date
Date:   Mon,  2 Jan 2023 19:09:00 -0600
Message-Id: <20230103010903.11181-4-samuel@sholland.org>
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

Currently, the IOMMU driver leaves the bypass register at its default
value. The H6 variant of the hardware disables bypass by default. So
once the first device is attached to the IOMMU, translation is enabled
for all masters, even those not attached to an IOMMU group/domain.

On the other hand, the D1 hardware variant enables bypass by default, so
keeping the default value prevents the IOMMU from functioning entirely.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Set bypass based on attached devices instead of using a fixed value

 drivers/iommu/sun50i-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 3757d5a18318..a3a462933c62 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -441,6 +441,9 @@ static int sun50i_iommu_enable(struct sun50i_iommu *iommu)
 
 	spin_lock_irqsave(&iommu->iommu_lock, flags);
 
+	iommu_write(iommu, IOMMU_BYPASS_REG,
+		    ~atomic_read(&sun50i_domain->masters));
+
 	iommu_write(iommu, IOMMU_TTB_REG, sun50i_domain->dt_dma);
 	iommu_write(iommu, IOMMU_TLB_PREFETCH_REG,
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(0) |
@@ -755,6 +758,17 @@ static void sun50i_iommu_detach_domain(struct sun50i_iommu *iommu,
 	iommu->domain = NULL;
 }
 
+static void sun50i_iommu_update_masters(struct sun50i_iommu *iommu,
+					struct sun50i_iommu_domain *sun50i_domain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+	iommu_write(iommu, IOMMU_BYPASS_REG,
+		    ~atomic_read(&sun50i_domain->masters));
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
 static void sun50i_iommu_detach_device(struct iommu_domain *domain,
 				       struct device *dev)
 {
@@ -770,6 +784,8 @@ static void sun50i_iommu_detach_device(struct iommu_domain *domain,
 
 	if (atomic_fetch_andnot(masters, &sun50i_domain->masters) == masters)
 		sun50i_iommu_detach_domain(iommu, sun50i_domain);
+	else
+		sun50i_iommu_update_masters(iommu, sun50i_domain);
 }
 
 static int sun50i_iommu_attach_device(struct iommu_domain *domain,
@@ -791,6 +807,8 @@ static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 
 	if (atomic_fetch_or(masters, &sun50i_domain->masters) == 0)
 		sun50i_iommu_attach_domain(iommu, sun50i_domain);
+	else
+		sun50i_iommu_update_masters(iommu, sun50i_domain);
 
 	return 0;
 }
-- 
2.37.4

