Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5996C7109E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbjEYKR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjEYKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA61A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9BF0C5C0185;
        Thu, 25 May 2023 06:16:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 May 2023 06:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009791; x=
        1685096191; bh=JW0p8/eDaYU/cW3GeziZHaBybYl27FrC9hzeWZqxqbk=; b=M
        38HuQLBfosmKb8msy8QXeWAgz9AL5eSQIhTGBE0JIvDunZ5bcc1Db3Qc5nX8Lzfd
        vNBZ2wnjUX3p78KO/oSUksA0Xgz5OE6jpFZcRJoW1IsFoSAfntWB8RHUvyuXHRLq
        pdbQ6Jxig5+Bz6yHo2fD3S8Ty09mNRVtPCdKbCibhIGemUTHL8+HtLCWRiemotp0
        er5DPfFwpdy5dGV0jJs+BUtF+y3qFnojUmQbIqFMPWQXpdRk1KNm6vWjiAcJ4gQW
        FaUBSotqY+kwXZnWYhbzds+3REGi7ohTcpypi1E3mqMnEmIqv1tl4hLAHRfPgsCh
        GD81EAOx9RpKe2y396M7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685009791; x=
        1685096191; bh=JW0p8/eDaYU/cW3GeziZHaBybYl27FrC9hzeWZqxqbk=; b=r
        wlAKzTuDanT/5QAAVyo+XdEGMUNsmC0L7csDWOLf9mZYcoL/G1bFzQX+Hzgn3hrS
        S6gLkVvVxDgi0i2AXOZFA19oLsG+GLJYeshqmMBetHyITTXQxI1Oe1SFtMu9xktx
        qCcF6iWKwnNweBlGKB0ZFhInqRk/4bTUPh5lES66HIkqgSN+urIDJRJQjICESCT/
        TEmxskSLEVCC2CRTVTy+gVvFPN7Su7nYfommglqFY3ARPyu5YK7gidRkyVNJRLV2
        ycNgiJ9+rvcpDFDelGX+oVq8IB6fPNPn16LA4oO6KJ920TG9IJj/Bh0wK9/DD5/t
        VSrNMR72oK1Wmj1XBWftg==
X-ME-Sender: <xms:fzVvZJg3uO8fh4FLIJGZ9TaZSG0r6a1YYi-3eDwnkpnvw6B3pf8EYw>
    <xme:fzVvZOBXeOuGAgxWayDtizDa1mbZExhu4MH8QLz3cU-hXxjs0ZQpg78XmZmfwC09U
    nrluDNaGeyFDO9Y_-c>
X-ME-Received: <xmr:fzVvZJECEZsSgQVkr1zdYnZU2i1GA1Rs6It9kcg7pzAjSpmF-My_DMJgOoorbJ-xcZv5Yg5e7h-d1aPsGD8FRU2L9h_aylenyNARpM9PYcXSog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeduuddttd
    euueduledvleethfetleeuledvvddvjeeiueekkeektdegudekffdvveenucffohhmrghi
    nhepvdejrdhithdpthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgr
    mhhotggthhhirdhjph
X-ME-Proxy: <xmx:fzVvZOTJG69B7Tiac3-vk04TxssSdrcK441xMlkYMVsGIzn5bkhz6w>
    <xmx:fzVvZGySq5ivACiwHT0KFSxGAf26H_UqL-xHTfV8GrG8E3XeKpy0xQ>
    <xmx:fzVvZE78EEtK7gvXdDxMYXBRDUUIvdRa2Xv2X6ejo9brg6LgYv-4wQ>
    <xmx:fzVvZLqtRLp5fdF4h3NIw2qq8uE_x0brURdkHZAkNXvxIqYH2ecwlQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:30 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: [PATCH v2 01/12] firewire: add KUnit test to check layout of UAPI structures
Date:   Thu, 25 May 2023 19:16:14 +0900
Message-Id: <20230525101625.888906-2-o-takashi@sakamocchi.jp>
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

In future commits, some new structure will be added to express new type
of event. They are exposed to user space as the part of UAPI. It is likely
to get trouble in ioctl compatibility layer for 32 bit binaries in 64 bit
host machine since the layout of structure could differ depending on
System V ABI for these architectures. Actually the subsystem already got
such trouble at v2.6.27. It is preferable to decide the layout of
structure carefully so that the layer is free from such trouble.

This commit utilizes KUnit framework to check the layout of structure for
the purpose. A test is added for the existent issue.

Cc: kunit-dev@googlegroups.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/.kunitconfig |  4 ++++
 drivers/firewire/Kconfig      | 16 +++++++++++++++
 drivers/firewire/Makefile     |  3 +++
 drivers/firewire/uapi-test.c  | 38 +++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/firewire/.kunitconfig
 create mode 100644 drivers/firewire/uapi-test.c

diff --git a/drivers/firewire/.kunitconfig b/drivers/firewire/.kunitconfig
new file mode 100644
index 000000000000..1599e069395f
--- /dev/null
+++ b/drivers/firewire/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_FIREWIRE=y
+CONFIG_FIREWIRE_KUNIT_UAPI_TEST=y
diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index ec00a6f70da8..0a6596b027db 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -18,6 +18,22 @@ config FIREWIRE
 	  To compile this driver as a module, say M here: the module will be
 	  called firewire-core.
 
+config FIREWIRE_KUNIT_UAPI_TEST
+	tristate "KUnit tests for layout of structure in UAPI" if !KUNIT_ALL_TESTS
+	depends on FIREWIRE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests whether structures exposed to user
+	  space have expected layout.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 config FIREWIRE_OHCI
 	tristate "OHCI-1394 controllers"
 	depends on PCI && FIREWIRE && MMU
diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index e58c8c794778..b24b2879ac34 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -15,3 +15,6 @@ obj-$(CONFIG_FIREWIRE_SBP2) += firewire-sbp2.o
 obj-$(CONFIG_FIREWIRE_NET)  += firewire-net.o
 obj-$(CONFIG_FIREWIRE_NOSY) += nosy.o
 obj-$(CONFIG_PROVIDE_OHCI1394_DMA_INIT) += init_ohci1394_dma.o
+
+firewire-uapi-test-objs += uapi-test.o
+obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += firewire-uapi-test.o
diff --git a/drivers/firewire/uapi-test.c b/drivers/firewire/uapi-test.c
new file mode 100644
index 000000000000..4dc633b91336
--- /dev/null
+++ b/drivers/firewire/uapi-test.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// uapi_test.c - An application of Kunit to check layout of structures exposed to user space for
+//		 FireWire subsystem.
+//
+// Copyright (c) 2023 Takashi Sakamoto
+
+#include <kunit/test.h>
+#include <linux/firewire-cdev.h>
+
+// Known issue added at v2.6.27 kernel.
+static void structure_layout_event_response(struct kunit *test)
+{
+#if defined(CONFIG_X86_32)
+	// 4 bytes alignment for aggregate type including 8 bytes storage types.
+	KUNIT_EXPECT_EQ(test, 20, sizeof(struct fw_cdev_event_response));
+#else
+	// 8 bytes alignment for aggregate type including 8 bytes storage types.
+	KUNIT_EXPECT_EQ(test, 24, sizeof(struct fw_cdev_event_response));
+#endif
+
+	KUNIT_EXPECT_EQ(test, 0, offsetof(struct fw_cdev_event_response, closure));
+	KUNIT_EXPECT_EQ(test, 8, offsetof(struct fw_cdev_event_response, type));
+	KUNIT_EXPECT_EQ(test, 12, offsetof(struct fw_cdev_event_response, rcode));
+	KUNIT_EXPECT_EQ(test, 16, offsetof(struct fw_cdev_event_response, length));
+	KUNIT_EXPECT_EQ(test, 20, offsetof(struct fw_cdev_event_response, data));
+}
+
+static struct kunit_case structure_layout_test_cases[] = {
+	KUNIT_CASE(structure_layout_event_response),
+	{}
+};
+
+static struct kunit_suite structure_layout_test_suite = {
+	.name = "firewire-uapi-structure-layout",
+	.test_cases = structure_layout_test_cases,
+};
+kunit_test_suite(structure_layout_test_suite);
-- 
2.39.2

