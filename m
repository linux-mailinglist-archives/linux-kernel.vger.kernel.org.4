Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64A867B22A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjAYMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjAYMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:11 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D78568A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CB9305C007C;
        Wed, 25 Jan 2023 07:03:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 07:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648189; x=
        1674734589; bh=mhbmLZ5ifTaOHOF/yXnONpnLZPjUXL3DFTwSnnNSvwY=; b=S
        B+BYx1yjRqCI0WXovu2K9Q4Zcude4clN/OK82O70XCgjubM4ng9IAcRWy6RbqqZZ
        6AWYpsH7QEURWCbTUcIAT0UR3fNqA9R8rBA8Hzr1IT0ZUBYPjVnmkpI2Du8tC65Z
        F7bchCAAK+hMOyiHUlKPgDSZqXBeXBbtf1eX2ta9+jopIFxa0Jh7erB1VCW602XZ
        WuThmoMPUJ+M19V42fVWU00h9fZC1UsV0+hu+3L4/Bz99I//vOEnQvoUKVLdiWzA
        8M7PP0ZL6CpOP0M7W2ub88qpNeLfY3jnLvNcPbBdMj+cHvW4few8RSXDcPnERvoc
        XVQufy0VLJbyyFyONPr4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648189; x=1674734589; bh=mhbmLZ5ifTaOH
        OF/yXnONpnLZPjUXL3DFTwSnnNSvwY=; b=hJUJI5SIP7KEQIwmNhPfPdyhu24dY
        D06VYrJgQ34jNuaxMteQi5pQx8265GVlSknkSCAIg77ou3w8wtdr2VvAtGAVeSTD
        xSV5/bVfwEmwnLAS0PQhuTdW3vBWkEuv+wm02VqqK6UO0ed+WgIahZDY1nTyo9yY
        5rkQ91IHwlDxjv6FyNYqYsjM2i3jcK6m1vIfDi3HY90l/iCEcqmoTboJ5i5BfHFN
        VqbPS2WapYD4b/1UknJd9eftDR9ib8Y0Umb8WFZXyy/g9EZpf0ta/MuzYAualS3V
        8PCRqOF4WrW31LlEOOGByH91TtjHmSe6onl+S4Z1up0ZdQJTfDEQtLbVA==
X-ME-Sender: <xms:fRrRY6rLlA55Ib8doLEW-6XCUoLMsHOLLgyjYXPGfeq9WOcpD6uHqg>
    <xme:fRrRY4qPA1mCvqpPM7f-uU8844fNY1i4NV8hSuM5NDAM8d3WH7t75Rk3Bx434Dmd6
    IZK_SiGEqVo2SlQyAQ>
X-ME-Received: <xmr:fRrRY_NxEhBtnowuXuAWamC158aINjW4Co3jaOq0krS3O5HiX0SaTFCdZpbELDRlToqEl8Yhgcf_S2k1XM491167X13D_4BtG6p3NlX7X4RI8JuscDJRfP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:fRrRY55CInUNtNXnSPhFyXWrf36LFm3uGsvL4RQPaeW03azyHFVmxQ>
    <xmx:fRrRY54VXFGWrWOlP61PI8NrizBvFjJFSLE_xnZtMW4GChshExw-nw>
    <xmx:fRrRY5jEL9L6PtCeiI3VJ6sBR3L5H3bXDTZcfOY9pTgJPUQnH2uDTQ>
    <xmx:fRrRY5H47KxV3nLdrexxa_lsYQQdYN5fA3aAFsJHQAGb07HCKdZ-nA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:08 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 02/11] firewire: cdev: add new event to notify request subaction with time stamp
Date:   Wed, 25 Jan 2023 21:02:52 +0900
Message-Id: <20230125120301.51585-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
References: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/linux/firewire-cdev.h | 53 ++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 621ee56d11b5..827b226eabb1 100644
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
  *  6  (6.3)     - added some event for subactions of asynchronous transaction with time stamp
+ *                   - %FW_CDEV_EVENT_REQUEST3
  */
 
 /**
-- 
2.37.2

