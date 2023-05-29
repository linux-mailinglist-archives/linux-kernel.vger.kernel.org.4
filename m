Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273C971488B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjE2LeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjE2LeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8615BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C752F320091F;
        Mon, 29 May 2023 07:34:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 May 2023 07:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360054; x=
        1685446454; bh=JW0p8/eDaYU/cW3GeziZHaBybYl27FrC9hzeWZqxqbk=; b=v
        FnlkzXvIaoeUJG2V7A6I+SlEcQjMThQZZv35UNB4qNEfjcE6kKzEzA5WSyEiompo
        m1N3baGcPJBpbQVSr4wfFbSSO8aUPJq8MuW2Zskr4s8qKNSyNBYcqQeT0NZ/fteH
        wDteuuAmrjCU5vpVbTLIMTnMF0VqKpJpgKGJGtlDhYvlUHeoWL4hGnghbaa2kPNx
        BiqZ5RADuv+pPdrCN2Lf5BPLcZusYZqDQsAcYHZQXi3SwFAxJvir6eKNLtiKp9na
        3rV9Qa+SA10kTiYyTMfefurN7PYxN/5CK9K4zidYqaw7EPAOqRGRP1NE7nEEDB97
        xfmrt2a7rjlHuO7CAvbZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685360054; x=
        1685446454; bh=JW0p8/eDaYU/cW3GeziZHaBybYl27FrC9hzeWZqxqbk=; b=A
        Ycer1p4RYkzYrb9aRjz1THEgwEW8CYs4RzwzAAcnBR/nI05NRjBDOO6yYcaIpjle
        wIN3Ivh9q4/CGZS+Nr25+TN+ZX2cs5N+LlhN9dBHWVFFSDTte4Gtkauca0IO7Nsj
        gwi7HCsmGtX6AeVcbmmRumvOyO46TQYMqMU2Z2hWYjLpd6e6zHKFocrjvB1mebtU
        ewDmTE2ckKn1BHN7DLZQ0pVfatuMLJ5bROAwi/LYyvTzBXgVnh/8QLyPS7k0CIgD
        2yQUONsydfsUfvQT6gAVxQcJJ6E0H8EtKz41YgmA0JHHHhBJwOMheankksxJBxWZ
        QKUy7vlNgwPLq02/kXzRg==
X-ME-Sender: <xms:to10ZFdMFmTh1O3abW-DhLlBuMKFNSb_8YaCxpcov1SGwP3GdatwoQ>
    <xme:to10ZDPHPsAqj1ZMxDWI2ZfNp8lqWFcr2aItYwzw8RWOTtGDTI1xFKS0nI1taFFye
    iqo5VEOrjIk07NxCyc>
X-ME-Received: <xmr:to10ZOj6FhYh4j3W3az96YLvDadrOvJHfraPp6K_CJ5BSiCY8Ht9p9h-kR7T1YKBp8xIPvcjdai7v9b_gcHeO4b-60_h0HFQVhbFlRJ7wcnZ4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeduuddttd
    euueduledvleethfetleeuledvvddvjeeiueekkeektdegudekffdvveenucffohhmrghi
    nhepvdejrdhithdpthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgr
    mhhotggthhhirdhjph
X-ME-Proxy: <xmx:to10ZO-w-M9ZA5k9UHbS1x89v1yI-CVccbdZ-pOpUTjSutb6bzdsvA>
    <xmx:to10ZBvUcZbnY89JXHQGfirh71l81KDpLk5ks-S_gRS8-KKk02kU9w>
    <xmx:to10ZNEt0sZLoFXuApfQYTjvOAtkRVvJCnfgffMy_Nrqa1bgdwZVcg>
    <xmx:to10ZCVL1WOdQZRbF2v0vLODXYeZR6xOzVMag28ko_sXbsOkRjQpfQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:13 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: [PATCH v3 01/12] firewire: add KUnit test to check layout of UAPI structures
Date:   Mon, 29 May 2023 20:33:55 +0900
Message-Id: <20230529113406.986289-2-o-takashi@sakamocchi.jp>
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

