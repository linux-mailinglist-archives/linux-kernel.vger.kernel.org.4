Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DE6C06D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCTAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCTAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:32:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E116AD3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:32:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A45C5C0072;
        Sun, 19 Mar 2023 20:32:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 19 Mar 2023 20:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679272353; x=1679358753; bh=jG60LqVl3ygGxpbLQr7OMm+KfrWuJT68jTJ
        tYViPpXc=; b=EDipKsBXVfwTCTShST/pxWDRzzDBEMg8pqhAbcOBfujaqExt2Oi
        US9/5fD4/N9bCdxYGVlxo6aQ/qlTNbS3cjd2kbQncNxce4kUUQQ9kgKI61wE10FI
        CcSWl7WtbIngYhUhSIE3xf8NUQreCaVpn/tSgXMlIwwhAv7KLjjs0nmUJRKDDIjh
        HfgKE8Sal+pkr9MDb5T7RmnDftvpjSYWid259aVv3oYyrMGwUcazm3wKlhn3/s/+
        1CzLxbnsgLYJJpTKDYZeLq863whkUA32YzPOzuGv5tTAA17shck9LJhQIiJoZaWP
        w61rTRsZjCD0+vXFIhPyKgfja7sw5EE59wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679272353; x=1679358753; bh=jG60LqVl3ygGxpbLQr7OMm+KfrWuJT68jTJ
        tYViPpXc=; b=hV6VsYaDJkiSLN8iqSkY8VCnPhxGch64tIWrKoZxdrQuWAxXbIt
        t5Ina0036fXkCHBjpOpPWRcExN6iMyMimkjc/ZCZLaWY+sEf5zdEzwyqeDR5OAK+
        njAJAEJ3h5HjTRlTw0UBKIAHJpD+p5Ydc/2IQ+BhdHPRxDe9ufOyghxC6i8pUIwN
        6YD0P0IE/5j0GdrNx1QMezAKmH0HHAGiZLkynqgTd8up54fovXovh13sLRUt/t1m
        e9zCOcMZisry2DudXE8idvS29R+SOYYaVs+kHEUvHQ53FXY2porYV3n1CH8ox9rT
        iOy+U8LrK7RDoOk4sWpbSdBIsVRzflPdebQ==
X-ME-Sender: <xms:oKkXZHUgamRT6J941SpQ0zPJDdQz9c6r0YD4KDTN-Lll5pBPW2PaWw>
    <xme:oKkXZPkLK8Td5wDUrYq7hCy1suCGYFBfernJ-mSqJ213-PNeAin1GlHBgm4jRcTBN
    Kyf4FkmPisx3HsJhNA>
X-ME-Received: <xmr:oKkXZDYnAiL1jHxe2vfd0KQ8YmkK2pZRoDmizzm1vN-GEsjwnHK8F1tVNajhSLe50vZr-Kq5xUudc8gRKT-KA6g8twIpRYZZd5--qyDS51jKf6_mYzk_kOGH5GaCCUtR9goo5YkrbU54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeffffefudeuueduueduhfefkeeiueeihfdukeeuffekfffhheeigfeh
    veekhefhhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:oKkXZCWi0Kjs-7hxrqLjTbY7_TUFiUldO6nWtMH7QQfp_lTiF9gT8w>
    <xmx:oKkXZBkM4h6CoYjxze0saNtY1RrJ3_jAPA3TLYP17daELONxiAb-og>
    <xmx:oKkXZPc4EJNU9f4z3l3UDNDo3ndQ421uaBhWIpJewRr-drVCis0TNg>
    <xmx:oakXZPaMpJPu_MZRyq-D0JvgPyf1LjoIHT58tRFUeST1rO7tLUpz7Q>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 20:32:32 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, markpearson@lenovo.com,
        thomas@t-8ch.de, pobrn@protonmail.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 2/4] platform/x86: think-lmi: use correct possible_values delimiters
Date:   Sun, 19 Mar 2023 20:32:19 -0400
Message-Id: <20230320003221.561750-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

firmware-attributes class requires that possible values are delimited
using ';' but the Lenovo firmware uses ',' instead.
Parse string and replace where appropriate.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4
 - Moved earlier in the series as recommended
 - used strreplace function as recommended
Changes in v3: 
 - New patch added to the series. No v1 & v2.

 drivers/platform/x86/think-lmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index a765bf8c27d8..53f34b1adb8c 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -954,7 +954,7 @@ static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	if (setting->possible_values) {
 		/* Figure out what setting type is as BIOS does not return this */
-		if (strchr(setting->possible_values, ','))
+		if (strchr(setting->possible_values, ';'))
 			return sysfs_emit(buf, "enumeration\n");
 	}
 	/* Anything else is going to be a string */
@@ -1413,6 +1413,13 @@ static int tlmi_analyze(void)
 				pr_info("Error retrieving possible values for %d : %s\n",
 						i, setting->display_name);
 		}
+		/*
+		 * firmware-attributes requires that possible_values are separated by ';' but
+		 * Lenovo FW uses ','. Replace appropriately.
+		 */
+		if (setting->possible_values)
+			strreplace(setting->possible_values, ',', ';');
+
 		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
 		tlmi_priv.setting[i] = setting;
 		kfree(item);
-- 
2.39.2

