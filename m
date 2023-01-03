Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5785565B8AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjACBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjACBJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:24 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4009596;
        Mon,  2 Jan 2023 17:09:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CC9773200919;
        Mon,  2 Jan 2023 20:09:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 20:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672708160; x=1672794560; bh=kH
        E08T4gTPodlZPGVapmZ0HQSfgCMhmZCAbX+vErrtM=; b=UyYQ7IlwpwAkOuo1HN
        QDKkchKl0wnktPq2cNwHZDz/BhriE4CQUKnW4f9locHk+hPipNeJieJhsnxP57be
        ZmQgMnnGleRgrVMPSkYDeLqrSdwV99GA3KD0A9ASuCnXHEkE/Hnds9WqfZv+d4hz
        cq/lCK28mpL8wesFvohvkC7I1F9rw77Ttt0pxN2yz154eZjAC77+V88d5Vx8wcJX
        kVtmIXQO6wx9DKmGn15Yg/WHkv+2SeImCsrq5lJV+iruBh6AasrFRCM2vLsq6QHZ
        PGvC/3W/7ZsxfZQ3q+LrKMBH0KIx5+69LSTRPOzB2MUPwbI1ujNAxuW3vAPUjXaH
        YA4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672708160; x=1672794560; bh=kHE08T4gTPodl
        ZPGVapmZ0HQSfgCMhmZCAbX+vErrtM=; b=EdxZN0apqAanSNtdkixjNQzRPslC8
        IveKKh2SOhsJmhEnCcah95XZf55+fEphZb101Yf09BDfRB0Noqssfgcwl0tmDcHW
        /LO2op7yyEoHIlRWs8b9wdc5ceSH1qCkZzs9eyF5DEO51lBJPn0y371QVkQYeeQN
        eiMY91EpgtcWLUX9sz2aqzNQ7AokNAHlEmudb+M+KQbxFSchLsuQU7IdSCjGRM6z
        ATx5o4ccxIJocWWP4MQGusuzbKwoB8zkmReHw03AyYoVd1qtbKCV28jVmS9R1RFt
        g9GQ0y/BhlUffGtWYKlEhSg+8fCAsRLQDT666sm/wnoTRIgCU2iRwGLGQ==
X-ME-Sender: <xms:QICzYzTbQWKSQQKOr94mF8h8uKxTDYbJH2pfsGIB-GRaC_24vI1Ibg>
    <xme:QICzY0wp4XRrlY6aexa-3Q3_TbJ8k8iOfOrs_Uv1NGctxjmfH_NYhLcRWbsNbsdGz
    5Ouq4sEVHkCMlGjqw>
X-ME-Received: <xmr:QICzY401aQB-EU6JJCKMxx5xWyNx_nQMWaxO4Fi6tHJudnIFICALNpBw4lQKOQw2np8-YVaymZjZ4tbM5ms59uHtddGIMgIshHGiZadZ4VosH9JZt-DFIyiKLjVYvaZ8LCqsJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:QICzYzDnx5skr5UVktOMzM4bthyD31Teq6Z31mZ3KrVM8T9u8HdYJQ>
    <xmx:QICzY8hTVuoTw760WSsWuZNDAcBoZ_8VpX1KMiIITcxz9zOetZC6Ag>
    <xmx:QICzY3r4TYNwAF4NjGTNwlggg4G2w7P3ToVddCrjsuVgzCGxm8u8ig>
    <xmx:QICzY9ZHAyPyKwp_JJBQaomuVA_fgopT4p4euj3Zml9kni3DiB2low>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:19 -0500 (EST)
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
Subject: [PATCH v2 5/6] iommu/sun50i: Add support for the D1 variant
Date:   Mon,  2 Jan 2023 19:09:02 -0600
Message-Id: <20230103010903.11181-6-samuel@sholland.org>
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
variant has no external reset signal. It also has some register
definition changes, but none that affect the current driver.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/iommu/sun50i-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index d19f6ce25f76..8652559a2ca3 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -1085,11 +1085,15 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct sun50i_iommu_variant sun20i_d1_iommu = {
+};
+
 static const struct sun50i_iommu_variant sun50i_h6_iommu = {
 	.has_reset = true,
 };
 
 static const struct of_device_id sun50i_iommu_dt[] = {
+	{ .compatible = "allwinner,sun20i-d1-iommu", .data = &sun20i_d1_iommu },
 	{ .compatible = "allwinner,sun50i-h6-iommu", .data = &sun50i_h6_iommu },
 	{ /* sentinel */ },
 };
-- 
2.37.4

