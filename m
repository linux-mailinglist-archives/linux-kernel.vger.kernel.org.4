Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943667361C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFTC5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFTC51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD0910C8;
        Mon, 19 Jun 2023 19:57:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 578885C01F9;
        Mon, 19 Jun 2023 22:57:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 22:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229843; x=
        1687316243; bh=bX+yoIucZ9XFfpbnNsMb71SaXrBmiqcLLOezSaDu8sg=; b=Y
        PD2oF1wMxdvxaubUCi8j+10DdV/cmm3W9Hq5nJ+OMnRX2l9gb78DBeTQyQWbZIxv
        GHDmS0I68q93uae/F5yK5EtGCy2z9Q4ictMcpJ89GAe9mFt2sdCMW01bb4OuFKwE
        /K5Urku03Whz/DmBhBxLy7Zu8u2JOg54IEGCVYAXyCjQ3gBo9c905v8pdiayUTtn
        yoOa6PVcdkavmk+X2+dtRBvkiDrXsSbN+ik7DbWInZFc1ZC/UnoqJzuFE2L4qCR/
        TaT3TcMTfRJdtvHnmYjAaTgj0bVctu9kVUR/rSn9bSmEu0pAYd0PODg6bqx3BYws
        qz+esZT5IAOe3IsXyHTpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229843; x=
        1687316243; bh=bX+yoIucZ9XFfpbnNsMb71SaXrBmiqcLLOezSaDu8sg=; b=V
        rrogAgtPW3tlj4PUB7AH6VJ6yt7wJOUOUrupj2Wf+ZY4F+GJ4+xPgLw/x/9a1yX7
        3x4OShyleERO8Ygtltsq85CYZyKio5L7AjcqFTJXqspVJnGaAQuCXX/5cv2tphBS
        zBRKmjGBlASOrargf8ZhEBsr7RBFujU6FGWfEoWvHO4jiHSaRK99aVC8GgqTxC+p
        UhGXcLKplFQmj+l8lbtH7BK79O5STZALyEc3ExwWOB1zPzY/trHVilzReUiJ9lXG
        p9qXKcJDgFUKtHxflV0DpzM8CzJ1afS1RzExhJ/Gz1kiFFQNTAvbo38hg/DzcYz6
        p94L6GZTR6860QxYN1O/w==
X-ME-Sender: <xms:kxWRZKQNNnwN4t6SAs8ou0n9uxyo8qUFcTIadar5a7t_qNMs21ZhDQ>
    <xme:kxWRZPxCa4YAR4sFycCN7BQis6N9ZgNmKWbHRRc1rar2bCAVqnwATtPvqrgaXOapv
    kH7oKrHkalr5Khhhpc>
X-ME-Received: <xmr:kxWRZH1FitnxxtvInSfLgJQi8rvTtgO94eN-5dZX8pYUTTT-y3zuDJzIi3xe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:kxWRZGBQbZRmk-C6ngAUsN0ZwaDYfxvfamc4Sx1G7g1-zH5YAOcg-A>
    <xmx:kxWRZDg9hf2StnmCn5wqq6h2KnoXUj4hyaMfa5QIWwN9LAHmaar0uw>
    <xmx:kxWRZCr9QSdMJjAWns7eFspNlSfhm9HhFg0vQityEe830OS9ZQWzLg>
    <xmx:kxWRZDiEW8QjMT_-ccsna_PqmvMrxNIjMYZCLlo3MU-yHxxHHHZx4Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:20 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 5/8] platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected
Date:   Tue, 20 Jun 2023 14:56:38 +1200
Message-Id: <20230620025641.53197-6-luke@ljones.dev>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620025641.53197-1-luke@ljones.dev>
References: <20230620025641.53197-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the ASUS_WMI_DEVID_EGPU_CONNECTED method for eGPU connection
before allowing the ASUS_WMI_DEVID_EGPU method to run.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0c8a4a46b121..821addb284d7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -693,6 +693,15 @@ static ssize_t egpu_enable_store(struct device *dev,
 	if (enable > 1)
 		return -EINVAL;
 
+	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
+	if (err < 0)
+		return err;
+	if (err < 1) {
+		err = -ENODEV;
+		pr_warn("Failed to set egpu disable: %d\n", err);
+		return err;
+	}
+
 	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
 	if (err) {
 		pr_warn("Failed to set egpu disable: %d\n", err);
-- 
2.40.1

