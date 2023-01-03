Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6051665B8A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbjACBJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjACBJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:18 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2799FD9;
        Mon,  2 Jan 2023 17:09:13 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2FC683200921;
        Mon,  2 Jan 2023 20:09:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 02 Jan 2023 20:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672708151; x=1672794551; bh=4M
        /YXCFP6z1qeIXax4Ipe9C0Q4INtZD2QYn6boleEmw=; b=VcD1lLVKCld/+P9wLE
        KW3ZOldbUX1wubsUnP3aJLxPD5Blj+qfvTRWaQEYASDSdo3Uw80g7ipNC/nDFena
        3UCt7UHojnDPRb07tRCIbQmyCTqrC92R2rCHbXS5dUJjnEOszohdEq0QVX97xpJq
        wRajs6Pqd7x3tkttbkxV+v2rba81C0Z9XoNMiB46u+W3+4V1ggrAemKqan9wNZ7j
        y8le58BlPT8MPm5uwo8Gd6al8YKh2c8r0IETEV/RTSdkyLQpmYkujON8CLFuTAg4
        x2LpULr2AQbZ3gBSojOAa1ECwHuMrTQdaZrx3sfDxLcjHYcBS7wmZHIk1ezp7TJF
        GuRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672708151; x=1672794551; bh=4M/YXCFP6z1qe
        IXax4Ipe9C0Q4INtZD2QYn6boleEmw=; b=MfvkZe35is+AYz1KZfpm56KzHfUF3
        l2I/MQNEVuq+SVKg8uw/d15uLW2acIvx55iCE2rfs61u7a0AQNGjP/FSrRVbf+Sc
        fxcgacJCwJ3PYN+vLgXBUHQuW/SuwQeUUV5V0B1xfS4ExHSZfEqkzIXIhPpyptWC
        Dex+xkeB9L0cdh+3VoNJnemAjjic39s++1EgB1Ug5gpEEzwaufFPKmC/Cn9DGQ9Q
        HrpR6skSs0S4bJiPCz2CsjuT3UIIqCXlfYmT3SIuDzUhKv3dE2mf28gjutCIj3N0
        ZLMrV22aRi7Csi8emYMMat8XtNUFhzNRSUK4NvV+9f7rEf0aO6gyS6x5w==
X-ME-Sender: <xms:N4CzY2nTZ_MVPUwqTT3ArYbk15ZJViaxtufg8RjQP3K5W3nEXEs-Tw>
    <xme:N4CzY9115yVQgeKN-4ZrOjSsmO7pWYr0TiW4qefeUW_GAr_zOmQfHo35CDKum6jAL
    f3gRRPVjfhnV-QZWA>
X-ME-Received: <xmr:N4CzY0oVjlxr9BIfsVxIQwmTnFdPv4hmVztdGQfMbyWxIbgo1Rx-F8FxM8Kg6VlkeH9h-7eXTNf_IkT9bb7ns23CQcFXiKWWSS5ZzLtVsNq1RpCuCuF_GDYnxTWg61kP_eKe9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:N4CzY6n4uiDMTHGsXWyR5MBK3LO7xaQhURk1z4Q9kvCBT2abWPWO7w>
    <xmx:N4CzY016E_FN1x2CPPSBKRdaxqptDRM-QDg7rC_jelIZrxDK65tQ_A>
    <xmx:N4CzYxvdDiuFszQa1hmifHoLzaETiv7bonmP9gqN8p8diTeES_5LuA>
    <xmx:N4CzY6MDWqGWVfe1mSp7cM0p7GKsbJzxLMPizj85K7CHPMUGduWmGA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:10 -0500 (EST)
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
Subject: [PATCH v2 2/6] iommu/sun50i: Track masters attached to the domain
Date:   Mon,  2 Jan 2023 19:08:59 -0600
Message-Id: <20230103010903.11181-3-samuel@sholland.org>
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

The refcount logic here is broken. The refcount is initialized to 1 with
no devices attached, so it will be decremented back to 1 when the last
device is detached. However, refcount_dec_and_test() returns true only
when the refcount gets decremented to zero, so the domain will never be
cleaned up, and the hardware will never be disabled.

Replace the refcount with a mask of masters attached to the domain. The
domain can be cleaned up when the last master detaches. This mask is
also necessary to correctly set the bypass register.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch for v2

 drivers/iommu/sun50i-iommu.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 5b585eace3d4..3757d5a18318 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -114,8 +114,8 @@ struct sun50i_iommu {
 struct sun50i_iommu_domain {
 	struct iommu_domain domain;
 
-	/* Number of devices attached to the domain */
-	refcount_t refcnt;
+	/* Mask of masters attached to this domain */
+	atomic_t masters;
 
 	/* L1 Page Table */
 	u32 *dt;
@@ -684,8 +684,6 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
-	refcount_set(&sun50i_domain->refcnt, 1);
-
 	sun50i_domain->domain.geometry.aperture_start = 0;
 	sun50i_domain->domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	sun50i_domain->domain.geometry.force_aperture = true;
@@ -760,23 +758,27 @@ static void sun50i_iommu_detach_domain(struct sun50i_iommu *iommu,
 static void sun50i_iommu_detach_device(struct iommu_domain *domain,
 				       struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = dev_iommu_priv_get(dev);
+	int masters = 0;
 
 	dev_dbg(dev, "Detaching from IOMMU domain\n");
 
-	if (iommu->domain != domain)
-		return;
+	for (unsigned int i = 0; i < fwspec->num_ids; i++)
+		masters |= BIT(fwspec->ids[i]);
 
-	if (refcount_dec_and_test(&sun50i_domain->refcnt))
+	if (atomic_fetch_andnot(masters, &sun50i_domain->masters) == masters)
 		sun50i_iommu_detach_domain(iommu, sun50i_domain);
 }
 
 static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu;
+	int masters = 0;
 
 	iommu = sun50i_iommu_from_dev(dev);
 	if (!iommu)
@@ -784,15 +786,11 @@ static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 
 	dev_dbg(dev, "Attaching to IOMMU domain\n");
 
-	refcount_inc(&sun50i_domain->refcnt);
-
-	if (iommu->domain == domain)
-		return 0;
-
-	if (iommu->domain)
-		sun50i_iommu_detach_device(iommu->domain, dev);
+	for (unsigned int i = 0; i < fwspec->num_ids; i++)
+		masters |= BIT(fwspec->ids[i]);
 
-	sun50i_iommu_attach_domain(iommu, sun50i_domain);
+	if (atomic_fetch_or(masters, &sun50i_domain->masters) == 0)
+		sun50i_iommu_attach_domain(iommu, sun50i_domain);
 
 	return 0;
 }
-- 
2.37.4

