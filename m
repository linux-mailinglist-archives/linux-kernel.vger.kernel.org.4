Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7871A0EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjFAOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjFAOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:49:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096C186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:49:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1B79F32004CE;
        Thu,  1 Jun 2023 10:49:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 10:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685630981; x=1685717381; bh=Cq
        tOqnMtfLTl17jHaTNX0NBBuC9GEzqPFAtZkKhT4aQ=; b=FIO86q7ngSkYiI1pra
        hezdwZjk9KnSAiGxYi02eyU7t1HD6eIPKFWEd7HJh/jxbK3WmEmuXNAlJ/YgeIBu
        luoKtjCFQmq11NIpB5z5lDD7BDIGiztNJGLz+A/DBwa4LvmLsn3fas3Rl70aCR4j
        QQwvydBf+Lgdc/iBe2wJvYJ6ebqw7pJkS4Vv0O2LMiJXO3Fc2u+rtlVvzPjk/Nze
        m5GepDmUOZVk4/dZOxNczHQ248KmjLTksx07q76H1YIrMDEOXeVG7yImWDHYuVDS
        L3C6VglZYzwQVF0YcqXnROiz+x6BKS3Dtol5WBy/XkzAj87eHS4L3qKbPV9hJENQ
        gOhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685630981; x=1685717381; bh=CqtOqnMtfLTl1
        7jHaTNX0NBBuC9GEzqPFAtZkKhT4aQ=; b=pzW9xq2p49aFzYxbwsnmSHK38zg0t
        xDUOWaJvD7RJd1pT6M3deQtrLj4x/CqfKx/XUp4QUbb0P43PO8XBqU1P4+Px8Tqu
        rk+uYbd/SypkomJPBVTjY7GQHNWLhwroINkQsHfXxZ4nA276WVugJGzPSdmw68Fd
        oBoHcmfiEoCGJs77lMFjNrUmo9Na7RMmL/SsHVpRKXA7vXa9OUAyuT06RaNCI9Bd
        RymMbSbdezNq1PTkWSfjxLxfBigNCK+5Fw0nw7PX9E88zu0KMQFOep7l7KbbUgJS
        8KqD8HpAcPXynkV6a7urIZyP5whFWwMH9SfIqvZwm999/YE+jMqoPGLKQ==
X-ME-Sender: <xms:BbB4ZKWmuhoNzYzokYPTJ986IzCyIH9pKuQTKvNVHgg_9hNt-nHe_A>
    <xme:BbB4ZGlOQxGTTjXcyb2NGNeaFHDVs1rw8URZVvAa9zaMkNgX1yRKiiWuK3IKJuCqv
    pJ_T6Os8WEJkybjr5o>
X-ME-Received: <xmr:BbB4ZOYQRyA4gSqshvJVhv4omiju_hbz8z7ZSscv9v6xjvtpsKVs2Q4MHHeAyQIs1Og3uiwbqKTe4xl3QsYgBNIXN9cuEBOQy9_ruVS2ygVKig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:BbB4ZBVCXOQAHtzWbw5s9sw9N-rvl-QZpwN5eVuikRCp_fekcjOo_Q>
    <xmx:BbB4ZEnFRnz3-Gxnut2dCnIPZtWc3QJsBJn_IUErcUB8BsKa3fqx-Q>
    <xmx:BbB4ZGcylC1yM77Rce-gmHQg4U8r_f58ntoW6zeagDZLU5EYIuVHGA>
    <xmx:BbB4ZAubT3Dya7q5PwKJn2_E1u1EXk4LDNcCU46-32lmhDkwtdCD2Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 10:49:40 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] firewire: fix warnings to generate UAPI documentation
Date:   Thu,  1 Jun 2023 23:49:37 +0900
Message-Id: <20230601144937.121179-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
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

Any target to generate UAPI documentation reports warnings to missing
annotation for padding member in structures added recently.

This commit suppresses the warnings.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20230531135306.43613a59@canb.auug.org.au/
Fixes: 7c22d4a92bb2 ("firewire: cdev: add new event to notify request subaction with time stamp")
Fixes: fc2b52cf2e0e ("firewire: cdev: add new event to notify response subaction with time stamp")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/linux/firewire-cdev.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 99e823935427..1f2c9469f921 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -130,6 +130,9 @@ struct fw_cdev_event_response {
  * @length:	Data length, i.e. the response's payload size in bytes
  * @request_tstamp:	The time stamp of isochronous cycle at which the request was sent.
  * @response_tstamp:	The time stamp of isochronous cycle at which the response was sent.
+ * @padding:	Padding to keep the size of structure as multiples of 8 in various architectures
+ *		since 4 byte alignment is used for 8 byte of object type in System V ABI for i386
+ *		architecture.
  * @data:	Payload data, if any
  *
  * This event is sent when the stack receives a response to an outgoing request
@@ -155,10 +158,6 @@ struct fw_cdev_event_response2 {
 	__u32 length;
 	__u32 request_tstamp;
 	__u32 response_tstamp;
-	/*
-	 * Padding to keep the size of structure as multiples of 8 in various architectures since
-	 * 4 byte alignment is used for 8 byte of object type in System V ABI for i386 architecture.
-	 */
 	__u32 padding;
 	__u32 data[];
 };
@@ -231,6 +230,9 @@ struct fw_cdev_event_request2 {
  * @handle:	Reference to the kernel-side pending request
  * @length:	Data length, i.e. the request's payload size in bytes
  * @tstamp:	The time stamp of isochronous cycle at which the request arrived.
+ * @padding:	Padding to keep the size of structure as multiples of 8 in various architectures
+ *		since 4 byte alignment is used for 8 byte of object type in System V ABI for i386
+ *		architecture.
  * @data:	Incoming data, if any
  *
  * This event is sent when the stack receives an incoming request to an address
@@ -284,10 +286,6 @@ struct fw_cdev_event_request3 {
 	__u32 handle;
 	__u32 length;
 	__u32 tstamp;
-	/*
-	 * Padding to keep the size of structure as multiples of 8 in various architectures since
-	 * 4 byte alignment is used for 8 byte of object type in System V ABI for i386 architecture.
-	 */
 	__u32 padding;
 	__u32 data[];
 };
-- 
2.39.2

