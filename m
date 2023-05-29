Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5F71488D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjE2LeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjE2LeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:18 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E8BD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D20013200392;
        Mon, 29 May 2023 07:34:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 May 2023 07:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360056; x=
        1685446456; bh=hPICvvJyN01FeQX1myCxTwggQ3ABUCLi/5+DEUBxRZk=; b=M
        7YJ7oLHvqaZh2l/KtuCvFNsjAflw42UxQe0JDywXvV79TmwQBfiPuR0VFJNp9KIi
        8B44QjseZ5Lcd1GPPd1IX3UIz+dc3TPSVkS+nLbZkaVOXBoOOBwA4L7JU85eR2CO
        zo2D2jEYAYoNzblrbJBBTu0ZxewEfgxyhQBPDQgYKQ4Qs7mlfPeye43dhBksvips
        W08+nyn6Hlmbsg035ss2DnfS7KFyKz3ScNM9CkGTvPmFsfRxf6NfvMaYE4xU8sVO
        M+s1YrLccC6E2YI4htfyBR7twa6DY9qEAT++9pRoY/La29V1BPHk9fBQ5KPA8c+9
        6gqg9xJhN89e9+ms4Tq0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685360056; x=1685446456; bh=h
        PICvvJyN01FeQX1myCxTwggQ3ABUCLi/5+DEUBxRZk=; b=VCVUebQVMWUe61t4N
        rEU0nlN/S9Yeu6b4Dm5s09fGKLui8fh8sNl3jjmCFVIvzAbz7MnlTyRwUCdgJQxG
        TdRP2kzv921AQ356W4Bp5vPgQhIXf2mZM37bD2KFq/ViO/bEwDSOSO+ojltaSYxc
        JbWsAP46zgdrehWISNOeP56H7IzDWmUV1TNaibbYHAqvfPze1YKuMQ48Zcyd2Y3h
        9+QsS1Cj1eVbaCC6usaVUPNJhZy2rfuOtPLJJZOrTJSrH3WbQGnhDglTTx5rrLo+
        A8OBqw3Djrl5n7lWOIqlxGj9hB3dC6ZyyQEa7m+3YB+qPr0pIoFDhsLxQc7UDOFP
        wq0CQ==
X-ME-Sender: <xms:uI10ZC7rdJMlNr0zyywJ9oQH95asVwSuBdiGTOpQg79jJYCypuvXBA>
    <xme:uI10ZL6Scc5k2-2YoNUOUWu3aQtukx2ZjvAnDx3D7GGEoemNjvP_jQwrZltu8oOQz
    ipXoizovbibY6eaCbQ>
X-ME-Received: <xmr:uI10ZBeHuvJAGDS9PXfYxrp-mZKybqGzSMxceztK0vE8pzAGuoPEIYGcRBXYm7_s1Z1B0aOntRcdkSCTumpAJEqTsMNYlkrsLq_tXo8EL-E_pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:uI10ZPKa4a4N0GbegrGHx25MC2t6WCd_bUtVlNrAxOAai7LTHi9EyA>
    <xmx:uI10ZGIpoBYwP1Hl-Iob0mEFz57hZLcTTgsQ-xQ2v48m--cuJ1dDtA>
    <xmx:uI10ZAxHnirLD1Xl7x5x4dQyMovm5rW4TmtNpMN_P56-5XffJeV1-Q>
    <xmx:uI10ZAzQkhstIRkLzdVtq8ihA8pqHAKDPkNgSCKb3NxHtE96oVEh-A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:15 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction
Date:   Mon, 29 May 2023 20:33:56 +0900
Message-Id: <20230529113406.986289-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
References: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index 92be3ea3c6e0..76441eb551e5 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -457,6 +457,7 @@ union fw_cdev_event {
  *  5  (3.4)     - send %FW_CDEV_EVENT_ISO_INTERRUPT events when needed to
  *                 avoid dropping data
  *               - added %FW_CDEV_IOC_FLUSH_ISO
+ *  6  (6.5)     - added some event for subactions of asynchronous transaction with time stamp
  */
 
 /**
-- 
2.39.2

