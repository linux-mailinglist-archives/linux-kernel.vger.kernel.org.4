Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51695743469
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjF3Fge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjF3Fga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:30 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C213583;
        Thu, 29 Jun 2023 22:36:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 67DF5320098A;
        Fri, 30 Jun 2023 01:36:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 01:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103386; x=
        1688189786; bh=WjHn4wz/GuX8KDH05sd8J20E91CWXekfUEtps2Qbx48=; b=J
        WcUCCIS5J1t+gZGsr2ijLzP0SE/Exlm/L9hnHVeD+lpMJjIDpMP36/ELGeAImXYY
        8Xy/MAm4lSa+NXn2k57vrGiwj7I+Z8EXPfHJhSsOVZ6NtcDjxQSq+pjxQQ2Sitaj
        EcNVp0t2jETclke54KJyoBTLLF0sfrol5fBznisK4j1Pw6DVxRMzYknSYu9QOhOZ
        k1lfdXQlTbsrqHiZt/c2VVWlhCiOK6SbRCuWwAQ4F5ipFDHH2DJ1YbtMfhnlt9Bg
        J965T3RR+MGQMj8F3QtrgTMIwjtumXeaCdX0SW8cfeMSm1rc2RdiGtBu3jFVBFqv
        aNgoMJh1zmqMeg90SFohA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103386; x=
        1688189786; bh=WjHn4wz/GuX8KDH05sd8J20E91CWXekfUEtps2Qbx48=; b=T
        /9pJ2v0xHan1XGn0MGoCVzFYRYv/6RoZH5atx2uJaXx0HI1vFYqTZI7pwf9a5fQF
        rciaZc/j5OqoTXK+OalOF1f5CEmzuiJkBOiNTH9NfIKOjL4sUaJDrooiBHD0iJIX
        JTRP28R8trl/69ZjrlOA1wI69afU8tipxVlduexTpWi6mP6z89ufMGcC5hD4tlP2
        83Vk9mhYaxov/SMVdWR4wjhm5mLv2O8/HRYV6/qacM0rn0+M627fvfYk/7aNOSy2
        5Kpjlf975vVSAB+JB5iOELsA59iuLl/ypxZywuJVOw/HNYSIsn2DBapd8Tw/LdTm
        +KvQZd1Oquh/t/QyEmCmw==
X-ME-Sender: <xms:2mmeZNdVtKJt5mdl8E_ehNbX80AXL48YCHOEK7m81T0vJo4R_7ffRw>
    <xme:2mmeZLPSESiryARhSikoX151B7IGaWf1e-hgqRJBED9_c6ROaAyWqfdAyKdqFZudP
    Ox1boU-G880LdVnxhM>
X-ME-Received: <xmr:2mmeZGjgR4GFbuU8SKg7a_P8jOC27Fotxn75Nua8MngP_pQxYVcRiW2rsPSG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2mmeZG9o-_PedS8WzKcYYF2hPl0361FrtV9fzGQFyHNz3SuYb6T8yg>
    <xmx:2mmeZJv1doaW89utdZA6U8eVs29ULzs9DvWGkyxiyn3hXH-eKhIwWQ>
    <xmx:2mmeZFFxGndGRCo77I0UDLp5VerepOD7NGIy50uoWKmnTC2yuFH6wA>
    <xmx:2mmeZK9vsdu6afrQ-EGGewqwQkivxoWC56hT9HkecbEB-CM2Qevotw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:23 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 5/8] platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected
Date:   Fri, 30 Jun 2023 17:35:49 +1200
Message-ID: <20230630053552.976579-6-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630053552.976579-1-luke@ljones.dev>
References: <20230630053552.976579-1-luke@ljones.dev>
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
2.41.0

