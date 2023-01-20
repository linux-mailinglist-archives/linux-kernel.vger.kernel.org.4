Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465767501A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjATJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjATJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:03:55 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ABF8014B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:03:52 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 84D955C00C3;
        Fri, 20 Jan 2023 04:03:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Jan 2023 04:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674205431; x=
        1674291831; bh=jE/Ddp/JVuzNFe//kFpLgM6MgxEg2yp0BYW9xvltuqQ=; b=f
        Un1G3AhebUpk57b5I1enrSIHTceCdDYT9pf1wB9L5ioMqtS//jpUrGYuHciPU1NK
        gxtrHwyICGbzfge/blYuWBfvrlMnCMoSRiCoDqSnDWqQ7Oz5NpiayePcZLVr81OH
        YJURQg7dmaUFSHIdOo5AbsmjCauuR3q1QX7GQJGnfDmfwbvetvW8C3c0BGYN5ife
        Uc/vkIUDND4mvYFSqG47uH2YovGvNcOfVFnWx1oWJZR6hvbaCtd32CWb737KusGD
        ZSfcdL7JbXfcUU9YeRqjbvB7ISnOPpC1/r/3pHTEvcyPXijD4+/UzeOdo6k43OZI
        kwX/0WoHqFzBQfgKh2MjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674205431; x=1674291831; bh=jE/Ddp/JVuzNF
        e//kFpLgM6MgxEg2yp0BYW9xvltuqQ=; b=J6W8fLT77ClbrQXoJWX7mEnDANUZu
        b5unNcaow6bD9oAjBrIYp5V29GadliH1jF5XKo0vc9yjPh7rK29dV3OgnE6efHsU
        TlN4NAye2VpC9f5daVcflvSddR0xlFAW0cMb1dtcECCCJmNQhFH/A6HdmDW7+6Ns
        MeEpJY2GvyGv4IxofAW23QI5x/0PSnuM1e771zbJlNLFCiFndk7XMPbA3G9gWWjC
        b1GXcV/S08UR18Poq2qZeKksNLqQCNmKRv7K5c/SuJXbGVHZphxlGY4Z+2EXxKSs
        uM4cfUPQaLdN1G3pIJ6jZ6kDbehVxmxvJn2Revaetk2Emziq3p5LeNx+Q==
X-ME-Sender: <xms:91jKY-Qd91Ga0fqkxN2u2ramrhM1XubH3xjSi-gzPA-2sPUNNv0Lbg>
    <xme:91jKYzyuOHnUES7IS2zhZ7JN0xZL3yMbYIb5hyYd9pRaYMBdPHcpJVMATV0TGSIDi
    lTmQ27HYPkGipyak5k>
X-ME-Received: <xmr:91jKY71vXCgdkDaB1KbqxTi19XUGcKpemGcGbbuFEIjaB8BIqPwV9KseRS3tztM0AFl1p2z92oSbyV3EMu37Wg9bXwuks9KOMzKkIFdiEPKtobKLXW4a-f8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgr
    khgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgf
    ejuedvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhih
    esshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:91jKY6DN3mjUePCAba7m872AwQCythWHm5dQdXIXzrvW6nIKS8F05w>
    <xmx:91jKY3gRX1-6HklQ_ak1DyvA8L3XoEusyhcsGe03-_mXA67-a-oGAA>
    <xmx:91jKY2rcsrA-Al3WRan-W_8jc4r51hZUOQOdKXZquWkIDZxIJwAc0Q>
    <xmx:91jKY0ul7nTjFIR7y18ZxtQm0q-KjuNGWsTZ_tNt3yZMyU63NnLOXg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 04:03:49 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     tiwai@suse.de, stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 1/3] firewire: core: use kref structure to maintain lifetime of data for fw_request structure
Date:   Fri, 20 Jan 2023 18:03:42 +0900
Message-Id: <20230120090344.296451-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120090344.296451-1-o-takashi@sakamocchi.jp>
References: <20230120090344.296451-1-o-takashi@sakamocchi.jp>
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

Developers have acknowledged that maintenance of lifetime for
fw_transaction structure is effective when handling asynchronous
transaction to IEC 61883-1 FCP region, since the core function allows
multiples listeners to the region. Some of them needs to access to the
payload of request in process context after the callback to listener,
while the core function releases the object for the structure just after
completing the callbacks to listeners.

One of the listeners is character device. Current implementation of the
character device duplicates the object for the payload of transaction,
while it's a cost in kernel memory consumption. The lifetime management
can reduce it.

The typical way to maintain the lifetime is reference count. This commit
uses kref structure as a first step for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c        |  4 ++--
 drivers/firewire/core-transaction.c | 33 +++++++++++++++++++++++++----
 drivers/firewire/core.h             |  3 +++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 958aa4662ccb..93dd80d8d4e1 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -826,12 +826,12 @@ static int ioctl_send_response(struct client *client, union ioctl_arg *arg)
 
 	if (a->length != fw_get_response_length(r->request)) {
 		ret = -EINVAL;
-		kfree(r->request);
+		fw_request_put(r->request);
 		goto out;
 	}
 	if (copy_from_user(r->data, u64_to_uptr(a->data), a->length)) {
 		ret = -EFAULT;
-		kfree(r->request);
+		fw_request_put(r->request);
 		goto out;
 	}
 	fw_send_response(r->card, r->request, a->rcode);
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index af498d767702..83f61cf1aa8f 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -617,6 +617,7 @@ void fw_core_remove_address_handler(struct fw_address_handler *handler)
 EXPORT_SYMBOL(fw_core_remove_address_handler);
 
 struct fw_request {
+	struct kref kref;
 	struct fw_packet response;
 	u32 request_header[4];
 	int ack;
@@ -625,13 +626,33 @@ struct fw_request {
 	u32 data[];
 };
 
+void fw_request_get(struct fw_request *request)
+{
+	kref_get(&request->kref);
+}
+
+static void release_request(struct kref *kref)
+{
+	struct fw_request *request = container_of(kref, struct fw_request, kref);
+
+	kfree(request);
+}
+
+void fw_request_put(struct fw_request *request)
+{
+	kref_put(&request->kref, release_request);
+}
+
 static void free_response_callback(struct fw_packet *packet,
 				   struct fw_card *card, int status)
 {
-	struct fw_request *request;
+	struct fw_request *request = container_of(packet, struct fw_request, response);
 
-	request = container_of(packet, struct fw_request, response);
-	kfree(request);
+	// Decrease the reference count since not at in-flight.
+	fw_request_put(request);
+
+	// Decrease the reference count to release the object.
+	fw_request_put(request);
 }
 
 int fw_get_response_length(struct fw_request *r)
@@ -782,6 +803,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 	request = kmalloc(sizeof(*request) + length, GFP_ATOMIC);
 	if (request == NULL)
 		return NULL;
+	kref_init(&request->kref);
 
 	request->response.speed = p->speed;
 	request->response.timestamp =
@@ -809,7 +831,7 @@ void fw_send_response(struct fw_card *card,
 	/* unified transaction or broadcast transaction: don't respond */
 	if (request->ack != ACK_PENDING ||
 	    HEADER_DESTINATION_IS_BROADCAST(request->request_header[0])) {
-		kfree(request);
+		fw_request_put(request);
 		return;
 	}
 
@@ -821,6 +843,9 @@ void fw_send_response(struct fw_card *card,
 		fw_fill_response(&request->response, request->request_header,
 				 rcode, NULL, 0);
 
+	// Increase the reference count so that the object is kept during in-flight.
+	fw_request_get(request);
+
 	card->driver->send_response(card, &request->response);
 }
 EXPORT_SYMBOL(fw_send_response);
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 71d5f16f311c..78c99f1d27fa 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -244,6 +244,9 @@ int fw_get_response_length(struct fw_request *request);
 void fw_fill_response(struct fw_packet *response, u32 *request_header,
 		      int rcode, void *payload, size_t length);
 
+void fw_request_get(struct fw_request *request);
+void fw_request_put(struct fw_request *request);
+
 #define FW_PHY_CONFIG_NO_NODE_ID	-1
 #define FW_PHY_CONFIG_CURRENT_GAP_COUNT	-1
 void fw_send_phy_config(struct fw_card *card,
-- 
2.37.2

