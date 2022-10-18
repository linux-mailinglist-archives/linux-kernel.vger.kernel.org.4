Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF707602D81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiJRN4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiJRN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:56:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A671BA933;
        Tue, 18 Oct 2022 06:56:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4B148320025E;
        Tue, 18 Oct 2022 09:56:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 Oct 2022 09:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666101406; x=
        1666187806; bh=fsnfoSKA6PqpPiyf9tFOCgSo+ftNuL4oCbpkCc9Xvls=; b=O
        9J2QrtdWOwMskqlZIfsyAgC96ySS3/l4XDV1cugaa38mia1CNJ87c34hatIpZQa0
        F41QR5T6xqlWOv5HTWmba2WILGh6H525OXIt94kftmNJqmZ61l4jqm3isZFi124z
        jTZOMAWDcFX7fRK8bh1nFN9/PQm1evPhH2Jclc9aodpDRk9tT02Efiq6nzAVoaQY
        jeEip7W6ZA7Ah4mZDYXoAIZZHGxRIJR6XOfnTDEopBvg9CwJH6C+IktVY7BQTfLQ
        IwOyTIwiYadXkEtayJt26FN0cQSy4ga6l1f6ElBVnNJw8wRfMu9RrQqaW+RVXxtn
        c0Nh3l6KgJjIMHwyfHMew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666101406; x=
        1666187806; bh=fsnfoSKA6PqpPiyf9tFOCgSo+ftNuL4oCbpkCc9Xvls=; b=u
        Ki/F2UJPey+RA+T8e3PolgiTr45mSbX1/e6QtcQjnnJUEnv1z9R0eXj25/So1+aB
        FK5EBRkEpBk8skQt2GNvKJgTaVvV5fGz09b4Zzkh5BXm3jSqBbMiyHV8emCGMkvd
        fM3vygxDmnxqAc6WwxPT52kioud94AYy6IbQixd0WIMLy8ThrXjV63/QbHw76sTK
        w8g0AyQtWIX1UTjAOquSKf6N/CkhhneHvRQdmQE1BHM5l30vRwP/4DaT+CAFMuVO
        Cz8kk8s8yk6Oxt78cS9QU7hmHI1N3Fn5w1/yGcagCQrnMsBcfLKmvqSiOLrNmSRn
        XeCWJ+VBVhEaaxD0Ec1tQ==
X-ME-Sender: <xms:nrBOY4zAVEfJYJCYMsy4OIM2xae-zkgopCpTMLN7uUYyhfBCXQaszw>
    <xme:nrBOY8TfGbWUt-tai1WJVDemU0zlduyZRGzG7xGkAk4yUQT92dhxy0iD3fF9BzFXJ
    toJRn_ABWHtJnpzNY0>
X-ME-Received: <xmr:nrBOY6W2HpO8UsveEB_m25B1iBet63EN4ywE0ym0GdYWGstlRcaOpoCSruLP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:nrBOY2huK_cDe5l_rKeaJX5jBvsyUDVtRzqNe9bzi-BMh_-bo4SuzQ>
    <xmx:nrBOY6A203amK697PdZSbulkyo_uttVs6kouH7wsj-8ImRMFV5VP4Q>
    <xmx:nrBOY3KeaPfv3eP7YwPnNit7aMjavP-QOAhxhlQhyKmyXlOcZBKwbw>
    <xmx:nrBOYx4TXHmtX-9aGDTnkOdUSo8dXc1hDFTPuPt9jq27E3AT4ivcZw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:56:46 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:56:41 +0200
Subject: [PATCH 1/2] clk: Store clk_core for clk_rate_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-rate-request-tracing-v1-1-6f3aa0b0b9de@cerno.tech>
References: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
In-Reply-To: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=AYGQC7GGn2o5RgdrGzjQcgRH3xJ2WggTZl8TnSrp+Kw=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+G2ZJvAwpzE3dVtNl4B64Ie1qIG+ZzyxLj37+w3Ol9ve8
 a/XqKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwEQyUhgZ/maZFTRPD81Ivhd3xFdceb
 rXgpCvfbddN537mLRjl5lKESPD1TlqL055S7ZoJXd/ZtuROuFO3jbhPIee58ybDd0Lwg/zAQA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c            | 1 +
 include/linux/clk-provider.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 11c41d987ff4..bc6f964cb676 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1468,6 +1468,7 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 	if (!core)
 		return;
 
+	req->core = core;
 	req->rate = rate;
 	clk_core_get_boundaries(core, &req->min_rate, &req->max_rate);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 267cd06b54a0..842e72a5348f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -44,6 +44,7 @@ struct dentry;
  *
  * Should be initialized by calling clk_hw_init_rate_request().
  *
+ * @core: 		Pointer to the struct clk_core affected by this request
  * @rate:		Requested clock rate. This field will be adjusted by
  *			clock drivers according to hardware capabilities.
  * @min_rate:		Minimum rate imposed by clk users.
@@ -55,6 +56,7 @@ struct dentry;
  *
  */
 struct clk_rate_request {
+	struct clk_core *core;
 	unsigned long rate;
 	unsigned long min_rate;
 	unsigned long max_rate;

-- 
b4 0.11.0-dev-7da52
