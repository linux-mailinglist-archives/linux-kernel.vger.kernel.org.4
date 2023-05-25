Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DF7109E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjEYKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbjEYKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055C97
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C0525C0073;
        Thu, 25 May 2023 06:16:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 May 2023 06:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009794; x=
        1685096194; bh=r495ZagNUl310AfgMMzJgvZvJuQiL4XuaB6fjhkP/AM=; b=i
        qgF/nnYKwfppxuAEfHdL6pIOQPgJlZpK+d6Va+j4q1EagO9KBToJpvoVcYlwxFMI
        JJVV0kx/WJun0FOD6uQKFTTncaIadoFdtsiW63NLrYOd5eTdBPmLxCCOrCwP42Ha
        KN+XfWstVXN+DNErclkBGqV49reGUsvfynww4gq9Zymcc/wNKYOcG5Ux+bZlQjjV
        c9822Bn5bE/7AYBDvwjj7Igl0J7qKD/tw2gI8Dd+Y8ivtEm2pRWd+1imK8Iprwv4
        rzyECmoTBqRuBtNpqHFf8RTAqwcA3I/zRXxBpKp+nI+KHFNrhcXIS+oFepXICDKV
        mdnNUoO2U/PlWf5hujgTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685009794; x=
        1685096194; bh=r495ZagNUl310AfgMMzJgvZvJuQiL4XuaB6fjhkP/AM=; b=w
        EFYEc6uOvXpXWYdYkuJ9i6bxI3y5bj/DI1btRroDa/F/gEYG0vSrFZzOdt1vgcVy
        Uh6khPeQ/Qnzwx0orXFDqB5nkRWm96xmOD4QcotHhayVuIeTNjnlfLmn/S/Abyca
        7PDFd4vLXiqvdJdvHiVdATINP0hc5/l4sX7sIYdr0KejmzrAYLts46xtcwbvqoLj
        q7Nuf0/XyPpKfRUyXi+sI+cvHKKR3jqJdgBjDkJ6xfeRbflOSpmAvDPl0vfCA9wE
        ezw0F1zFHZ1YnomV/MKXDrZe7TgiGGI7XXXSL+fZSm+spnWXY9ePfb9XMAyFJN32
        FhfoRnOJ7M2vi/9KH9q6w==
X-ME-Sender: <xms:gjVvZG2u9ZNsjdQtRMxuiNo7INNeWABZmdfgO00dCk9iK1n8CTMYag>
    <xme:gjVvZJFOw1S5DbeEsOZHqGtcom_DV_rk2B_z_YGI-VX1lJP8rz4NBNaxL7x3y-OUP
    kD8J8RQ9J2lEX5mZVo>
X-ME-Received: <xmr:gjVvZO4Ry7LsUJGrm14_XiMT5G6CgUMJfYfLthVqTB_qvtE1E7rkaTJ1KqXgXiJtP77qY8XN78FrnLDruwWRsBQGoO9Byx0c0iEMZ4U2mkx83w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:gjVvZH3i3cIyshvqqtDDkb9tgooN7oS7Yx0CfWCnh74bBjxWWQFIPA>
    <xmx:gjVvZJGBdb-gX1Z3ccHpl6C04hCyCDRSY0ZnXi9_CiNBJWrvnzX5Ww>
    <xmx:gjVvZA8NA8ghVbX36uPU1aU0NV0z3Mzs6rxNx1IumexrxGkzi5Kjow>
    <xmx:gjVvZHPgrWg9o--bddCTCCrp0I3WbNhMh0XyE1N8TIS2u58ZWUNfFg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:32 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: [PATCH v2 03/12] firewire: cdev: add new event to notify request subaction with time stamp
Date:   Thu, 25 May 2023 19:16:16 +0900
Message-Id: <20230525101625.888906-4-o-takashi@sakamocchi.jp>
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

This commit adds new event to notify event of request subaction with
time stamp field.

Current compiler implementation of System V ABI selects one of structure
members which has the maximum alignment size in the structure to decide
the size of structure. In the case of fw_cdev_event_request3 structure,
it is closure member which has 8 byte storage. The size of alignment for
the type of 8 byte storage differs depending on architectures; 4 byte for
i386 architecture and 8 byte for the others including x32 architecture.
It is inconvenient to device driver developer to use structure layout
which varies between architectures since the developer takes care of ioctl
compat layer. This commit adds 32 bit member for padding to keep the
size of structure as multiples of 8.

Cc: kunit-dev@googlegroups.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/uapi-test.c       | 20 +++++++++++
 include/uapi/linux/firewire-cdev.h | 53 ++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/uapi-test.c b/drivers/firewire/uapi-test.c
index 4dc633b91336..c7c713babaa0 100644
--- a/drivers/firewire/uapi-test.c
+++ b/drivers/firewire/uapi-test.c
@@ -26,8 +26,28 @@ static void structure_layout_event_response(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 20, offsetof(struct fw_cdev_event_response, data));
 }
 
+// Added at v6.4.
+static void structure_layout_event_request3(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 56, sizeof(struct fw_cdev_event_request3));
+
+	KUNIT_EXPECT_EQ(test, 0, offsetof(struct fw_cdev_event_request3, closure));
+	KUNIT_EXPECT_EQ(test, 8, offsetof(struct fw_cdev_event_request3, type));
+	KUNIT_EXPECT_EQ(test, 12, offsetof(struct fw_cdev_event_request3, tcode));
+	KUNIT_EXPECT_EQ(test, 16, offsetof(struct fw_cdev_event_request3, offset));
+	KUNIT_EXPECT_EQ(test, 24, offsetof(struct fw_cdev_event_request3, source_node_id));
+	KUNIT_EXPECT_EQ(test, 28, offsetof(struct fw_cdev_event_request3, destination_node_id));
+	KUNIT_EXPECT_EQ(test, 32, offsetof(struct fw_cdev_event_request3, card));
+	KUNIT_EXPECT_EQ(test, 36, offsetof(struct fw_cdev_event_request3, generation));
+	KUNIT_EXPECT_EQ(test, 40, offsetof(struct fw_cdev_event_request3, handle));
+	KUNIT_EXPECT_EQ(test, 44, offsetof(struct fw_cdev_event_request3, length));
+	KUNIT_EXPECT_EQ(test, 48, offsetof(struct fw_cdev_event_request3, tstamp));
+	KUNIT_EXPECT_EQ(test, 56, offsetof(struct fw_cdev_event_request3, data));
+}
+
 static struct kunit_case structure_layout_test_cases[] = {
 	KUNIT_CASE(structure_layout_event_response),
+	KUNIT_CASE(structure_layout_event_request3),
 	{}
 };
 
diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index e3d463b2c288..cc9b03244a62 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -46,6 +46,9 @@
 #define FW_CDEV_EVENT_PHY_PACKET_RECEIVED		0x08
 #define FW_CDEV_EVENT_ISO_INTERRUPT_MULTICHANNEL	0x09
 
+/* available since kernel version 6.3 */
+#define FW_CDEV_EVENT_REQUEST3				0x0a
+
 /**
  * struct fw_cdev_event_common - Common part of all fw_cdev_event_* types
  * @closure:	For arbitrary use by userspace
@@ -159,6 +162,38 @@ struct fw_cdev_event_request {
  * @length:	Data length, i.e. the request's payload size in bytes
  * @data:	Incoming data, if any
  *
+ * This event is sent instead of &fw_cdev_event_request3 if the kernel or the client implements
+ * ABI version <= 5. It has the lack of time stamp field comparing to &fw_cdev_event_request3.
+ */
+struct fw_cdev_event_request2 {
+	__u64 closure;
+	__u32 type;
+	__u32 tcode;
+	__u64 offset;
+	__u32 source_node_id;
+	__u32 destination_node_id;
+	__u32 card;
+	__u32 generation;
+	__u32 handle;
+	__u32 length;
+	__u32 data[];
+};
+
+/**
+ * struct fw_cdev_event_request3 - Sent on incoming request to an address region
+ * @closure:	See &fw_cdev_event_common; set by %FW_CDEV_IOC_ALLOCATE ioctl
+ * @type:	See &fw_cdev_event_common; always %FW_CDEV_EVENT_REQUEST2
+ * @tcode:	Transaction code of the incoming request
+ * @offset:	The offset into the 48-bit per-node address space
+ * @source_node_id: Sender node ID
+ * @destination_node_id: Destination node ID
+ * @card:	The index of the card from which the request came
+ * @generation:	Bus generation in which the request is valid
+ * @handle:	Reference to the kernel-side pending request
+ * @length:	Data length, i.e. the request's payload size in bytes
+ * @tstamp:	The time stamp of isochronous cycle at which the request arrived.
+ * @data:	Incoming data, if any
+ *
  * This event is sent when the stack receives an incoming request to an address
  * region registered using the %FW_CDEV_IOC_ALLOCATE ioctl.  The request is
  * guaranteed to be completely contained in the specified region.  Userspace is
@@ -191,10 +226,14 @@ struct fw_cdev_event_request {
  * sent.
  *
  * If the client subsequently needs to initiate requests to the sender node of
- * an &fw_cdev_event_request2, it needs to use a device file with matching
+ * an &fw_cdev_event_request3, it needs to use a device file with matching
  * card index, node ID, and generation for outbound requests.
+ *
+ * @tstamp is isochronous cycle at which the request arrived. It is 16 bit integer value and the
+ * higher 3 bits expresses three low order bits of second field in the format of CYCLE_TIME
+ * register and the rest 13 bits expresses cycle field.
  */
-struct fw_cdev_event_request2 {
+struct fw_cdev_event_request3 {
 	__u64 closure;
 	__u32 type;
 	__u32 tcode;
@@ -205,6 +244,12 @@ struct fw_cdev_event_request2 {
 	__u32 generation;
 	__u32 handle;
 	__u32 length;
+	__u32 tstamp;
+	/*
+	 * Padding to keep the size of structure as multiples of 8 in various architectures since
+	 * 4 byte alignment is used for 8 byte of object type in System V ABI for i386 architecture.
+	 */
+	__u32 padding;
 	__u32 data[];
 };
 
@@ -375,6 +420,8 @@ struct fw_cdev_event_phy_packet {
  *				%FW_CDEV_EVENT_PHY_PACKET_SENT or
  *				%FW_CDEV_EVENT_PHY_PACKET_RECEIVED
  *
+ * @request3:		Valid if @common.type == %FW_CDEV_EVENT_REQUEST3
+ *
  * Convenience union for userspace use.  Events could be read(2) into an
  * appropriately aligned char buffer and then cast to this union for further
  * processing.  Note that for a request, response or iso_interrupt event,
@@ -393,6 +440,7 @@ union fw_cdev_event {
 	struct fw_cdev_event_iso_interrupt_mc	iso_interrupt_mc;	/* added in 2.6.36 */
 	struct fw_cdev_event_iso_resource	iso_resource;		/* added in 2.6.30 */
 	struct fw_cdev_event_phy_packet		phy_packet;		/* added in 2.6.36 */
+	struct fw_cdev_event_request3		request3;		/* added in 6.3 */
 };
 
 /* available since kernel version 2.6.22 */
@@ -458,6 +506,7 @@ union fw_cdev_event {
  *                 avoid dropping data
  *               - added %FW_CDEV_IOC_FLUSH_ISO
  *  6  (6.4)     - added some event for subactions of asynchronous transaction with time stamp
+ *                   - %FW_CDEV_EVENT_REQUEST3
  */
 
 /**
-- 
2.39.2

