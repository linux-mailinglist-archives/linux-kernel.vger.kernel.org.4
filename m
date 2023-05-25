Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E77109E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbjEYKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbjEYKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BF10B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C76315C005E;
        Thu, 25 May 2023 06:16:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 May 2023 06:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009792; x=
        1685096192; bh=Scx2YERYya4XNfuQABUzrTu3FrRelGdDymkzNIze9SM=; b=t
        URz73QyTJeNYVfkWY4u8oGDpXhfvPRD4wmi9qORH7g4LETGWvIGVmPu8lfLUMIF9
        CXE/laTx96Xb0kHoUdWyQIktPXBxl5mn76XNr83bAdK7kaaGcZw7JvZTaoZrfS1V
        52mZh/Ckm5FGNHpUc3c+zK+4MWmtTLdVU1OvqOQlZekBI6acw5YioKUGt6souALf
        qS0AwQ/KKS7yE0Uhdlmqk9qV1Z2k67pH485EllcZfZqI6HU8r90xlAY0YEsBPMAR
        DNgLQGOhd3XTkq6OlOrlnQZRyHztzkjvJllC3kRxN44KwRZylP9lBYFho5RndlId
        GsyTOvk0k5UpP1JJ5TSvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009792; x=1685096192; bh=S
        cx2YERYya4XNfuQABUzrTu3FrRelGdDymkzNIze9SM=; b=RIlv5kRuoe2I7bagc
        HKNwjq7jiM+akJ66uEsfL1gqofg2EGh213DjhuXyWzx5nEQKwGbhageywJOWcnwI
        IFwOajenEdad7HrteyCmeJksvbL4lMZQOyZSHTxoxI/P1Q2e15WC9QQiT2FHuioc
        ZtkC74kzNlagxJpNKJDLBWifbQ2QeVu+HuaiS3mpDr8YJCkvaZt5KZ0+opY8AJ5S
        hNOgfjuDFwVtpfWOES7srSeHh5boR6fYbVXL0RdWyn0hrE4rH6CXaCoeiTvgApW1
        ZPy1frlDtIR02P68s9bBbqolfD6PjimAUzB6XGTTj1+YPHBF+QK+J4n41FzQ54My
        dXHVg==
X-ME-Sender: <xms:gDVvZCh_3NqZ013fxEGBR_d63gbcS3KSWg-oP7pgemUDRgZEhBmi4w>
    <xme:gDVvZDAw9noM_q1rnbPTvcldWIBRUR6Uq1KpsSIzAg3r-NMY6c-dz-u4c0LYxz6ok
    lslW4Fo7opFGaobIEI>
X-ME-Received: <xmr:gDVvZKH8vY2VBSh59QM7HSUFeOOZo_lQAcijxbEwarNu7K3jYHGdl4lylhUahWE_oDb1rz6LsOvyDcS5F5Csd9zsaNwRUtw-eiAoMJwY_bwQcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:gDVvZLSiLNLFdTSMIWQHATlMWLRFQXBMTF6VFvPbR11NaRZ0qgsdcg>
    <xmx:gDVvZPzCYungOf8hCxhdOTHM8yGVHaljGiLhvKD1mEabgFF-7LFANQ>
    <xmx:gDVvZJ4JcuOv-Q51mMTMevkFcZuiSbXlhuWS5jPepT29CMbd03A0ng>
    <xmx:gDVvZNas9--L-cd5E1z7b-Wz9BQGflMsOiG1nHZ2f-99PxS49kPTuA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:31 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction
Date:   Thu, 25 May 2023 19:16:15 +0900
Message-Id: <20230525101625.888906-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525101625.888906-1-o-takashi@sakamocchi.jp>
References: <20230525101625.888906-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds new version of ABI for future new events with time stamp
for request/response subaction of asynchronous transaction to user
space.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c       | 1 +
 include/uapi/linux/firewire-cdev.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 2c16ee8fd842..88c8b5fac5e5 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -43,6 +43,7 @@
 #define FW_CDEV_VERSION_EVENT_REQUEST2		4
 #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
 #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5
+#define FW_CDEV_VERSION_EVENT_ASYNC_TSTAMP	6
 
 struct client {
 	u32 version;
diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 92be3ea3c6e0..e3d463b2c288 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -457,6 +457,7 @@ union fw_cdev_event {
  *  5  (3.4)     - send %FW_CDEV_EVENT_ISO_INTERRUPT events when needed to
  *                 avoid dropping data
  *               - added %FW_CDEV_IOC_FLUSH_ISO
+ *  6  (6.4)     - added some event for subactions of asynchronous transaction with time stamp
  */
 
 /**
-- 
2.39.2

