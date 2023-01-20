Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2067501B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjATJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjATJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:03:56 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D338EF84
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:03:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 056745C0153;
        Fri, 20 Jan 2023 04:03:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 20 Jan 2023 04:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674205435; x=
        1674291835; bh=2GbfxkdYITK9cgpb8Yh7Mhw+V5G40/636EJmCJMDeaE=; b=r
        lEW288yUhUJxwNj2Dyd+rr1T9I2cIY4uxnXjBIDz/UQ6/ruHGlvms7Ga7E0wmgb6
        Bf6DXNI4ZwnwXOCTTz/LvCbCJdIaFWz1sTePysRXD165WYm3ll5WxIizkLc1b71J
        3a8yBhyzNOY0bWYh4bMXbQKDSAUDEP0hV9iVQiRwtFUg/Tt3ZuEC5vprICncQTKr
        WOdYyrr3Lbz2aIgHDDt5C2nTEE8iqYMxLFkjmLz04FwbQjcHdmFlyIswU/M5/XWW
        NzY1P0dPcooAlKpPPCmi4ap50jq6wBB7IHpxce32I/RzaPjAvGDozXbFfnkqZst2
        H4MTwMSoNv3j/39OV+Hbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674205435; x=1674291835; bh=2GbfxkdYITK9c
        gpb8Yh7Mhw+V5G40/636EJmCJMDeaE=; b=FO/dK82RiG4h7+gyFZbaq37tqY0b0
        lNZw+NatQY74p4do6MdHsjNUBCjgKycRA6ULtOY97yC243uabZ5JiAiLFIgEuHjA
        NIscmVF7ibI6WkHPZFEeFIkVRdq2ag2NWpfel5R5uHjSAqfENBgFXAmeYOQffMjD
        db/FFpAKm8tR/iAsVV7mW+yF7EZPK2GkmKVa2uf8YmJC0n0Fp2UuKtXGQHYjt2G5
        R8kkNlzFWJzY3jvO4r7PIcK5iqQSN6R80NwpPU3ij2tnB6s3yJXXi5nqE5LJo02i
        /FemlBPPkID3qNZVCGzEW49GKRjbhb4dd4PSytZU340njD5luDUKp3iag==
X-ME-Sender: <xms:-ljKYxVLVrSZMGlLkrAia9EeewWAxMDf62jgDRDYUi11lIA22pzIug>
    <xme:-ljKYxnyhAX2hyAu9LtUJ9uP_8nDqKQrcweCh8iAO03IWtHt4-6m-gZX-UY-4VOqN
    6V8HU2_nT1v1SRno9Y>
X-ME-Received: <xmr:-ljKY9biiZ-y97SlY_ZSNXVK-XJc4urnbTEsIlKOY-JDQK5S5D_3ZddUxPhpFIF2QldI8ayJSGfojEHYCl2hNsxONMkfUgSsbL5mLaKhuMKC1xcs79OP0OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgr
    khgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgf
    ejuedvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhih
    esshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:-ljKY0VFrcWs9A0LuGiYoH-bYnVYHFFm8r28uTCMaDeP1stY1iK4Ow>
    <xmx:-ljKY7lA4sQiGtOBv9RWbky16OA6pBcVxY-WIIOg6JbTlNRfcM9e5w>
    <xmx:-ljKYxdh7rNXMx97CJ426idCe2cuExPcIO3Brei_nSbJBOiRSOFSig>
    <xmx:-1jKY5gyA3dCVuuM0PIszIaR7BrIlZX_q_DnmYMfmd2xZAMy3chcIQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 04:03:53 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     tiwai@suse.de, stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 3/3] firewire: cdev: use single object to dispatch event for request to IEC 61883-1 FCP region
Date:   Fri, 20 Jan 2023 18:03:44 +0900
Message-Id: <20230120090344.296451-4-o-takashi@sakamocchi.jp>
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

The core function always passes the data of request to the callback of
listener in any case. Additionally, the listener can maintain the lifetime
of data by reference count. In character device, no need to duplicate the
payload of request anymore to copy it to user space.

This commit extends the lifetime of data to obsolete duplication of
payload for request in character device.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 7fa49e51bae8..2c16ee8fd842 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -651,7 +651,7 @@ static void release_request(struct client *client,
 			struct inbound_transaction_resource, resource);
 
 	if (r->is_fcp)
-		kfree(r->data);
+		fw_request_put(r->request);
 	else
 		fw_send_response(r->card, r->request, RCODE_CONFLICT_ERROR);
 
@@ -669,12 +669,16 @@ static void handle_request(struct fw_card *card, struct fw_request *request,
 	struct inbound_transaction_resource *r;
 	struct inbound_transaction_event *e;
 	size_t event_size0;
-	void *fcp_frame = NULL;
 	int ret;
 
 	/* card may be different from handler->client->device->card */
 	fw_card_get(card);
 
+	// Extend the lifetime of data for request so that its payload is safely accessible in
+	// the process context for the client.
+	if (is_fcp)
+		fw_request_get(request);
+
 	r = kmalloc(sizeof(*r), GFP_ATOMIC);
 	e = kmalloc(sizeof(*e), GFP_ATOMIC);
 	if (r == NULL || e == NULL)
@@ -686,18 +690,6 @@ static void handle_request(struct fw_card *card, struct fw_request *request,
 	r->data    = payload;
 	r->length  = length;
 
-	if (is_fcp) {
-		/*
-		 * FIXME: Let core-transaction.c manage a
-		 * single reference-counted copy?
-		 */
-		fcp_frame = kmemdup(payload, length, GFP_ATOMIC);
-		if (fcp_frame == NULL)
-			goto failed;
-
-		r->data = fcp_frame;
-	}
-
 	r->resource.release = release_request;
 	ret = add_client_resource(handler->client, &r->resource, GFP_ATOMIC);
 	if (ret < 0)
@@ -739,10 +731,11 @@ static void handle_request(struct fw_card *card, struct fw_request *request,
  failed:
 	kfree(r);
 	kfree(e);
-	kfree(fcp_frame);
 
 	if (!is_fcp)
 		fw_send_response(card, request, RCODE_CONFLICT_ERROR);
+	else
+		fw_request_put(request);
 
 	fw_card_put(card);
 }
@@ -818,7 +811,7 @@ static int ioctl_send_response(struct client *client, union ioctl_arg *arg)
 	r = container_of(resource, struct inbound_transaction_resource,
 			 resource);
 	if (r->is_fcp) {
-		kfree(r->data);
+		fw_request_put(r->request);
 		goto out;
 	}
 
-- 
2.37.2

