Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AFF7148A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjE2Le6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjE2Les (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE75109
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 637303200932;
        Mon, 29 May 2023 07:34:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 May 2023 07:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360069; x=
        1685446469; bh=y2dyz0bs0I2fbKhF3IYp4zE0pAAIp0ALOv0TsADA8wU=; b=j
        ftBtRqwCCirR4laF+AGrG5xCtXrjSKHUBQJZ0UHCyP36yN9HTvj9urvd1pqJHXXf
        txBQvKju8kzbfRcMjjUCWPNA1+Cf2QGTgtSSRmrbQMbz0SJTv+kVR2JLTU8ij9eG
        CRAtr39snEixduSZvuZlGPGzBeGb6WJQtef3c3OD74bLhaoiZOmod35T1FLRYZpX
        Qml+Dret2Jh9xGB/+b5C5FH/7eX3LDTWo7G7WXTmF2xP+v7qu9uTSKTn1ajY8CId
        Izo03Q92Z6lhzyEaCVWPXYFMhc0kgJB7osAPRGgQyYFWxwxIVSEVk941lxV6c++I
        Js0bpAoMgf5++EHSdS5yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685360069; x=
        1685446469; bh=y2dyz0bs0I2fbKhF3IYp4zE0pAAIp0ALOv0TsADA8wU=; b=o
        p+yUw+p7cpeSwkR2Bpc3/CvxBLdbdV4ny22j+kLXWtUPvN56s8aGEVy7J8NjZMUh
        JO6Rq+PnG7D2dNGcTKxpzLVi+HBXJ6FN86nVMFtSCoxI3vZq5Ba/BILmA+wBiXfW
        KuZfwSfw3sGtnO30aEWH7yaxwW0uFWNbx5EOBazgbyemHnDg25gjQ7/pc2nGFCXo
        UjrsdQ1RBAjw9BiajtrxWowAuNZbzd5yImfXLY5qio1A7xF0iyiHgIl2QbQe6g6M
        hRH9uFfXen4CsOMm4supocrQlrIqpPINHVaU8U/Mnsdo86acgtwdQoSMZPX2P5Iq
        54O5vA+mBBbRcFXuk6koQ==
X-ME-Sender: <xms:xI10ZC70qH4ThZgGgDuZdfYUOr6JlP7Dred8SyhZ9-iPEgH8D-t1iQ>
    <xme:xI10ZL5nr_-Y49xK0b7k1De-pkyHKi_0FH9h256j6R6Ce2EcMsV8piEc4N1BYHiEn
    1RGlsmz_eaTwyT8sSs>
X-ME-Received: <xmr:xI10ZBc4bNNbAxHU7mzclw7_-h1STPlokaC8pt0JpZpAJUm8D7jVu_vYvERe50gOzSHi6QIb0sf4gDCFZ-7Fdm62hSjKLLfvxs9O49AWnnJ_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xI10ZPL3jyuP2twXZlsjxO_I4cTcF4BBajfGLBAOF4_BJDGcWYMQnA>
    <xmx:xI10ZGLCa5CQLcgeWTPPlCvyL_5M56Clgcr0ZJvicUVZDhxVmoOD4g>
    <xmx:xI10ZAxsxP3a8eSfq4zMpI5YH4S68Wj3jwWLjBYH0a80B6DaYgb_cg>
    <xmx:xY10ZIhP30cJcDwVnX2yz1Xep08Wc3gaJe-zb1k4HHWJVTyqFgTlBA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:27 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: [PATCH v3 08/12] firewire: cdev: add new event to notify response subaction with time stamp
Date:   Mon, 29 May 2023 20:34:02 +0900
Message-Id: <20230529113406.986289-9-o-takashi@sakamocchi.jp>
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

This commit adds new event to notify event of response subaction with
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
 drivers/firewire/uapi-test.c       | 15 ++++++++
 include/uapi/linux/firewire-cdev.h | 59 +++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/uapi-test.c b/drivers/firewire/uapi-test.c
index dd95899de316..640e5c05415a 100644
--- a/drivers/firewire/uapi-test.c
+++ b/drivers/firewire/uapi-test.c
@@ -45,9 +45,24 @@ static void structure_layout_event_request3(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 56, offsetof(struct fw_cdev_event_request3, data));
 }
 
+// Added at v6.5.
+static void structure_layout_event_response2(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 32, sizeof(struct fw_cdev_event_response2));
+
+	KUNIT_EXPECT_EQ(test, 0, offsetof(struct fw_cdev_event_response2, closure));
+	KUNIT_EXPECT_EQ(test, 8, offsetof(struct fw_cdev_event_response2, type));
+	KUNIT_EXPECT_EQ(test, 12, offsetof(struct fw_cdev_event_response2, rcode));
+	KUNIT_EXPECT_EQ(test, 16, offsetof(struct fw_cdev_event_response2, length));
+	KUNIT_EXPECT_EQ(test, 20, offsetof(struct fw_cdev_event_response2, request_tstamp));
+	KUNIT_EXPECT_EQ(test, 24, offsetof(struct fw_cdev_event_response2, response_tstamp));
+	KUNIT_EXPECT_EQ(test, 32, offsetof(struct fw_cdev_event_response2, data));
+}
+
 static struct kunit_case structure_layout_test_cases[] = {
 	KUNIT_CASE(structure_layout_event_response),
 	KUNIT_CASE(structure_layout_event_request3),
+	KUNIT_CASE(structure_layout_event_response2),
 	{}
 };
 
diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 7767cd53a013..13892016c266 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -48,6 +48,7 @@
 
 /* available since kernel version 6.5 */
 #define FW_CDEV_EVENT_REQUEST3				0x0a
+#define FW_CDEV_EVENT_RESPONSE2				0x0b
 
 /**
  * struct fw_cdev_event_common - Common part of all fw_cdev_event_* types
@@ -106,6 +107,29 @@ struct fw_cdev_event_bus_reset {
  * @length:	Data length, i.e. the response's payload size in bytes
  * @data:	Payload data, if any
  *
+ * This event is sent instead of &fw_cdev_event_response if the kernel or the client implements
+ * ABI version <= 5. It has the lack of time stamp field comparing to &fw_cdev_event_response2.
+ */
+struct fw_cdev_event_response {
+	__u64 closure;
+	__u32 type;
+	__u32 rcode;
+	__u32 length;
+	__u32 data[];
+};
+
+/**
+ * struct fw_cdev_event_response2 - Sent when a response packet was received
+ * @closure:	See &fw_cdev_event_common; set by %FW_CDEV_IOC_SEND_REQUEST
+ *		or %FW_CDEV_IOC_SEND_BROADCAST_REQUEST
+ *		or %FW_CDEV_IOC_SEND_STREAM_PACKET ioctl
+ * @type:	See &fw_cdev_event_common; always %FW_CDEV_EVENT_RESPONSE
+ * @rcode:	Response code returned by the remote node
+ * @length:	Data length, i.e. the response's payload size in bytes
+ * @request_tstamp:	The time stamp of isochronous cycle at which the request was sent.
+ * @request_tstamp:	The time stamp of isochronous cycle at which the response was sent.
+ * @data:	Payload data, if any
+ *
  * This event is sent when the stack receives a response to an outgoing request
  * sent by %FW_CDEV_IOC_SEND_REQUEST ioctl.  The payload data for responses
  * carrying data (read and lock responses) follows immediately and can be
@@ -115,12 +139,25 @@ struct fw_cdev_event_bus_reset {
  * involve response packets.  This includes unified write transactions,
  * broadcast write transactions, and transmission of asynchronous stream
  * packets.  @rcode indicates success or failure of such transmissions.
+ *
+ * The value of @request_tstamp expresses the isochronous cycle at which the request was sent to
+ * initiate the transaction. The value of @response_tstamp expresses the isochronous cycle at which
+ * the response arrived to complete the transaction. Each value is unsigned 16 bit integer
+ * containing three low order bits of second field and all 13 bits of cycle field in format of
+ * CYCLE_TIMER register.
  */
-struct fw_cdev_event_response {
+struct fw_cdev_event_response2 {
 	__u64 closure;
 	__u32 type;
 	__u32 rcode;
 	__u32 length;
+	__u32 request_tstamp;
+	__u32 response_tstamp;
+	/*
+	 * Padding to keep the size of structure as multiples of 8 in various architectures since
+	 * 4 byte alignment is used for 8 byte of object type in System V ABI for i386 architecture.
+	 */
+	__u32 padding;
 	__u32 data[];
 };
 
@@ -421,6 +458,7 @@ struct fw_cdev_event_phy_packet {
  *				%FW_CDEV_EVENT_PHY_PACKET_RECEIVED
  *
  * @request3:		Valid if @common.type == %FW_CDEV_EVENT_REQUEST3
+ * @response2:		Valid if @common.type == %FW_CDEV_EVENT_RESPONSE2
  *
  * Convenience union for userspace use.  Events could be read(2) into an
  * appropriately aligned char buffer and then cast to this union for further
@@ -441,6 +479,7 @@ union fw_cdev_event {
 	struct fw_cdev_event_iso_resource	iso_resource;		/* added in 2.6.30 */
 	struct fw_cdev_event_phy_packet		phy_packet;		/* added in 2.6.36 */
 	struct fw_cdev_event_request3		request3;		/* added in 6.5 */
+	struct fw_cdev_event_response2		response2;		/* added in 6.5 */
 };
 
 /* available since kernel version 2.6.22 */
@@ -507,6 +546,7 @@ union fw_cdev_event {
  *               - added %FW_CDEV_IOC_FLUSH_ISO
  *  6  (6.5)     - added some event for subactions of asynchronous transaction with time stamp
  *                   - %FW_CDEV_EVENT_REQUEST3
+ *                   - %FW_CDEV_EVENT_RESPONSE2
  */
 
 /**
@@ -552,11 +592,11 @@ struct fw_cdev_get_info {
  * @data:	Userspace pointer to payload
  * @generation:	The bus generation where packet is valid
  *
- * Send a request to the device.  This ioctl implements all outgoing requests.
- * Both quadlet and block request specify the payload as a pointer to the data
- * in the @data field.  Once the transaction completes, the kernel writes an
- * &fw_cdev_event_response event back.  The @closure field is passed back to
- * user space in the response event.
+ * Send a request to the device.  This ioctl implements all outgoing requests. Both quadlet and
+ * block request specify the payload as a pointer to the data in the @data field. Once the
+ * transaction completes, the kernel writes either &fw_cdev_event_response event or
+ * &fw_cdev_event_response event back. The @closure field is passed back to user space in the
+ * response event.
  */
 struct fw_cdev_send_request {
 	__u32 tcode;
@@ -1039,10 +1079,9 @@ struct fw_cdev_allocate_iso_resource {
  * @generation:	The bus generation where packet is valid
  * @speed:	Speed to transmit at
  *
- * The %FW_CDEV_IOC_SEND_STREAM_PACKET ioctl sends an asynchronous stream packet
- * to every device which is listening to the specified channel.  The kernel
- * writes an &fw_cdev_event_response event which indicates success or failure of
- * the transmission.
+ * The %FW_CDEV_IOC_SEND_STREAM_PACKET ioctl sends an asynchronous stream packet to every device
+ * which is listening to the specified channel. The kernel writes either &fw_cdev_event_response
+ * event or &fw_cdev_event_response2 event which indicates success or failure of the transmission.
  */
 struct fw_cdev_send_stream_packet {
 	__u32 length;
-- 
2.39.2

