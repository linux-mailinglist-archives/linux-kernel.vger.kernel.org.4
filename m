Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5467B240
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjAYMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjAYMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:37 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF02E56ED4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DED85C01B1;
        Wed, 25 Jan 2023 07:03:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 07:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648202; x=
        1674734602; bh=t0nvS0Pz00hKfcsEBgTOMv0+ZOgK+W8dh2NdTtPTXB0=; b=m
        oZ1IFzVDCL4HK7DjPsCxAMIhSxHdes6gZ9tHLNmJnOl6zY037nDF+EOtXhu0ZEEI
        RhZLnmmmEh/yMM93qA6PMmNBWXbEsXYfJduwuv/my+J3oco49ZrekckCN9/6GfCq
        aywCT806M3hHiXmWAxsyMgeoXdMS6j8DK94QX0N4FflgL07tgSa63mYWgMrhWEUC
        kQfSbRaYFR/GVIlSwjVVsgxLosx90XsWpCnmL3TBCEGgPYjjJxApeYwhvdbYOwzv
        FpC69V//e9oJj1hCzPakyV914EAV6FuetyFaZyY47BvHwQSjSr8QNyD1G4WZyWLu
        P5ACwsSHgxhkExOrfd7Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648202; x=1674734602; bh=t0nvS0Pz00hKf
        csEBgTOMv0+ZOgK+W8dh2NdTtPTXB0=; b=SGUeqcVJL8ScKQedUqawJ36VwOSzh
        xUiKIvzQtd7ShDMAIfsKaKWYWvi+LYHB+G0xP4u08ANBhajFx5wLKhVO5vpkSAdR
        qTsDPbkoEkqucssN6Iu+NWWYyngzOCSX1ZO2/2mIVTA8f73pIr+chlzEViyIPe7W
        Foes1guDkWGn3Yl0m1b9+fuTIeDCU0ElrkfXOU+MpG631GnUdFaDTlRw2vO8I7I8
        SH7fWaPljn7NvNTMry8krnb5A9scvWwE9uYWMCZbrvbECb6TWFDYV+uQU91jZpgx
        IUSjud0FpPIFzJIcDq99T1mXSqZJrOhDM4Ijb3Mj0d2YM3RBhtqaQOv6g==
X-ME-Sender: <xms:iRrRYy0FR019fsOjMTAWeRtdGY4rF8ncYZtrgl6CzlQ3QRd3YvgJag>
    <xme:iRrRY1G-Vclbrt5ZiTGQhh0qqBxBbd3zcyeLKcxWdUkq5VViMUMGQGUK6TaDiAj7E
    ntTVhC0zjSBPXnz9VM>
X-ME-Received: <xmr:iRrRY64mi2r1vK-gX_CQIC4UNs4XnEFEPEOLY9_5_AmAPYvEOJez_0kZUjL-rFfIvbQ0ZOVK6P6t5FcJcl-gLk7fF33LpEEuFACNTXdrQKRsEvUAI8SCazc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:iRrRYz04SzNe5wHyqF7ZB242PZhn0NBc56sXZAtHkx-O1umiYD0AHw>
    <xmx:iRrRY1GEDWYM6ntTWhfuueDAmJ1ws0M7unKMOiTAdsj67EYUAyT8rA>
    <xmx:iRrRY8-4NFImub934TelCVerUctlauuivTh1yfSmTgG6JiG8TOq_5A>
    <xmx:ihrRY6RqbLhmQizBHLtFBXh05h14pU1N7QFgSW0G5CPgVWjrF54YtA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:20 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 10/11] firewire: cdev: add new event to notify phy packet with time stamp
Date:   Wed, 25 Jan 2023 21:03:00 +0900
Message-Id: <20230125120301.51585-11-o-takashi@sakamocchi.jp>
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

This commit adds new event to notify event of phy packet with time stamp
field.

Unlike the fw_cdev_event_request3 and fw_cdev_event_response2, the size
of new structure, fw_cdev_event_phy_packet2, is multiples of 8, thus
padding is not required to keep the same size between System V ABI for
different architectures.

It is noticeable that for the case of ping request 1394 OHCI controller
does not record the isochronous cycle at which the packet was sent for
the request subaction. Instead, it records round-trip count measured by
hardware at 42.195 MHz resolution.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/linux/firewire-cdev.h | 67 +++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 2bd6ab023fc4..dede13813c1d 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -49,6 +49,8 @@
 /* available since kernel version 6.3 */
 #define FW_CDEV_EVENT_REQUEST3				0x0a
 #define FW_CDEV_EVENT_RESPONSE2				0x0b
+#define FW_CDEV_EVENT_PHY_PACKET_SENT2			0x0c
+#define FW_CDEV_EVENT_PHY_PACKET_RECEIVED2		0x0d
 
 /**
  * struct fw_cdev_event_common - Common part of all fw_cdev_event_* types
@@ -423,20 +425,59 @@ struct fw_cdev_event_iso_resource {
  * @type:	%FW_CDEV_EVENT_PHY_PACKET_SENT or %..._RECEIVED
  * @rcode:	%RCODE_..., indicates success or failure of transmission
  * @length:	Data length in bytes
+ * @data:	Incoming data for %FW_CDEV_IOC_RECEIVE_PHY_PACKETS. For %FW_CDEV_IOC_SEND_PHY_PACKET
+ *		the field has the same data in the request, thus the length of 8 bytes.
+ *
+ * This event is sent instead of &fw_cdev_event_phy_packet2 if the kernel or
+ * the client implements ABI version <= 5. It has the lack of time stamp field comparing to
+ * &fw_cdev_event_phy_packet2.
+ */
+struct fw_cdev_event_phy_packet {
+	__u64 closure;
+	__u32 type;
+	__u32 rcode;
+	__u32 length;
+	__u32 data[];
+};
+
+/**
+ * struct fw_cdev_event_phy_packet2 - A PHY packet was transmitted or received with time stamp.
+ * @closure:	See &fw_cdev_event_common; set by %FW_CDEV_IOC_SEND_PHY_PACKET
+ *		or %FW_CDEV_IOC_RECEIVE_PHY_PACKETS ioctl
+ * @type:	%FW_CDEV_EVENT_PHY_PACKET_SENT2 or %FW_CDEV_EVENT_PHY_PACKET_RECEIVED2
+ * @rcode:	%RCODE_..., indicates success or failure of transmission
+ * @length:	Data length in bytes
+ * @tstamp:	For %FW_CDEV_EVENT_PHY_PACKET_RECEIVED2, the time stamp of isochronous cycle at
+ *		which the packet arrived. For %FW_CDEV_EVENT_PHY_PACKET_SENT2 and non-ping packet,
+ *		the time stamp of isochronous cycle at which the packet was sent. For ping packet,
+ *		the tick count for round-trip time measured by 1394 OHCI controller.
+ * The time stamp of isochronous cycle at which either the response was sent for
+ *		%FW_CDEV_EVENT_PHY_PACKET_SENT2 or the request arrived for
+ *		%FW_CDEV_EVENT_PHY_PACKET_RECEIVED2.
  * @data:	Incoming data
  *
- * If @type is %FW_CDEV_EVENT_PHY_PACKET_SENT, @length is 0 and @data empty,
- * except in case of a ping packet:  Then, @length is 4, and @data[0] is the
- * ping time in 49.152MHz clocks if @rcode is %RCODE_COMPLETE.
+ * If @type is %FW_CDEV_EVENT_PHY_PACKET_SENT2, @length is 8 and @data consists of the two PHY
+ * packet quadlets to be sent, in host byte order,
  *
- * If @type is %FW_CDEV_EVENT_PHY_PACKET_RECEIVED, @length is 8 and @data
- * consists of the two PHY packet quadlets, in host byte order.
+ * If @type is %FW_CDEV_EVENT_PHY_PACKET_RECEIVED2, @length is 8 and @data consists of the two PHY
+ * packet quadlets, in host byte order.
+ *
+ * For %FW_CDEV_EVENT_PHY_PACKET_RECEIVED2, the @tstamp is the isochronous cycle at which the
+ * packet arrived. It is 16 bit integer value and the higher 3 bits expresses three low order bits
+ * of second field and the rest 13 bits expresses cycle field in the format of CYCLE_TIME register.
+ *
+ * For %FW_CDEV_EVENT_PHY_PACKET_SENT2, the @tstamp has different meanings whether to sent the
+ * packet for ping or not. If it's not for ping, the @tstamp is the isochronous cycle at which the
+ * packet was sent, and use the same format as the case of %FW_CDEV_EVENT_PHY_PACKET_SENT2. If it's
+ * for ping, the @tstamp is for round-trip time measured by 1394 OHCI controller with 42.195 MHz
+ * resolution.
  */
-struct fw_cdev_event_phy_packet {
+struct fw_cdev_event_phy_packet2 {
 	__u64 closure;
 	__u32 type;
 	__u32 rcode;
 	__u32 length;
+	__u32 tstamp;
 	__u32 data[];
 };
 
@@ -459,6 +500,8 @@ struct fw_cdev_event_phy_packet {
  *
  * @request3:		Valid if @common.type == %FW_CDEV_EVENT_REQUEST3
  * @response2:		Valid if @common.type == %FW_CDEV_EVENT_RESPONSE2
+ * @phy_packet2:	Valid if @common.type == %FW_CDEV_EVENT_PHY_PACKET_SENT2 or
+ *				%FW_CDEV_EVENT_PHY_PACKET_RECEIVED2
  *
  * Convenience union for userspace use.  Events could be read(2) into an
  * appropriately aligned char buffer and then cast to this union for further
@@ -480,6 +523,7 @@ union fw_cdev_event {
 	struct fw_cdev_event_phy_packet		phy_packet;		/* added in 2.6.36 */
 	struct fw_cdev_event_request3		request3;		/* added in 6.3 */
 	struct fw_cdev_event_response2		response2;		/* added in 6.3 */
+	struct fw_cdev_event_phy_packet2	phy_packet2;		/* added in 6.3 */
 };
 
 /* available since kernel version 2.6.22 */
@@ -547,6 +591,8 @@ union fw_cdev_event {
  *  6  (6.3)     - added some event for subactions of asynchronous transaction with time stamp
  *                   - %FW_CDEV_EVENT_REQUEST3
  *                   - %FW_CDEV_EVENT_RESPONSE2
+ *                   - %FW_CDEV_EVENT_PHY_PACKET_SENT2
+ *                   - %FW_CDEV_EVENT_PHY_PACKET_RECEIVED2
  */
 
 /**
@@ -1100,8 +1146,8 @@ struct fw_cdev_send_stream_packet {
  * @data:	First and second quadlet of the PHY packet
  * @generation:	The bus generation where packet is valid
  *
- * The %FW_CDEV_IOC_SEND_PHY_PACKET ioctl sends a PHY packet to all nodes
- * on the same card as this device.  After transmission, an
+ * The %FW_CDEV_IOC_SEND_PHY_PACKET ioctl sends a PHY packet to all nodes on the same card as this
+ * device.  After transmission, either %FW_CDEV_EVENT_PHY_PACKET_SENT event or
  * %FW_CDEV_EVENT_PHY_PACKET_SENT event is generated.
  *
  * The payload @data\[\] shall be specified in host byte order.  Usually,
@@ -1120,8 +1166,9 @@ struct fw_cdev_send_phy_packet {
  * struct fw_cdev_receive_phy_packets - start reception of PHY packets
  * @closure: Passed back to userspace in phy packet events
  *
- * This ioctl activates issuing of %FW_CDEV_EVENT_PHY_PACKET_RECEIVED due to
- * incoming PHY packets from any node on the same bus as the device.
+ * This ioctl activates issuing of either %FW_CDEV_EVENT_PHY_PACKET_RECEIVED or
+ * %FW_CDEV_EVENT_PHY_PACKET_RECEIVED2 due to incoming PHY packets from any node on the same bus
+ * as the device.
  *
  * The ioctl is only permitted on device files which represent a local node.
  */
-- 
2.37.2

