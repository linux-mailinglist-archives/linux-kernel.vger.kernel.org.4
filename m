Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD86FD411
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjEJDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEJDMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:12:14 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221435B3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:12:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2E7BE3200681;
        Tue,  9 May 2023 23:12:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 May 2023 23:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683688329; x=1683774729; bh=FW
        q0bO+HBMIGxKbDQUC/QIXBRYZ2XFe4HmtHpRUs/II=; b=Bh59Hc2K8PysbgyxI0
        EvRTNZFIlWk0w2oN/TclV1IvNDcaPy92XeTSPgAdezs/Tvj89eKSRH/lML4eZzct
        t2lo+YPy82NVF2xz29ihjPpfYeb9kdEdtReFTluWTQ91fVTO05cRi61FT49XhlGc
        lqvgyXUTUHQtO01JuPk+4Q48sZiclo5hicCEaMQ2Fn9fZNzRD4o52jpAcR1l5h1v
        gMcroEKzXk3NJyS96X3G2s9nrg2QRKzHW3F9hNWaM0Xdfzs2fut4XkIKuh12IBkF
        bh8bJiTLAERbzAZI5bNrFR3SP+9zviOvTS83J0QKvDKMQWaOrvVOpKGoLDt7Fzwh
        CY/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683688329; x=1683774729; bh=FWq0bO+HBMIGx
        KbDQUC/QIXBRYZ2XFe4HmtHpRUs/II=; b=GGDUaaceGUMTD8NLXmAy7ETWPcAat
        GZyorV3TjVQ1LNRsZhfHxmg+l+1/EJ082WgGBYKlCvweaJRA+TkC1bx2DIWtE0xT
        aeqRc7PLUh0Beh6yHwuFXVJ2bOWzcR+WMkW+ja16La1fJsTd/WhXPMiK3+U9Pajy
        KWQuVM6zVD4bczknLUDwLD2MNCbHNwKBuVhfJYHq9AAkh14URaWVeFKe9S4YNDIW
        sb0g5sspjVIuE6xP9DbpMOgYJCxw0zPtfthKea4YYTaIntTDeW+P4dqY6oxy7WnZ
        NAzdtDpO9vrv9ZZUP2GSa0XTcAbfqiO6ZTm/zT/y3KjUK3ukm7r6gB1Hw==
X-ME-Sender: <xms:iQtbZF485CbWby7MxS4AdtcSXrs7l09bpatA-inX2cGiq1u0Tc7xIQ>
    <xme:iQtbZC5ECBDpZqD0O5UEDSsgujVBNne0eVgfaoyTNkH5iJrBfI9hnlU3YhShMPEZx
    QmD2pnHNzWlOaDJb0A>
X-ME-Received: <xmr:iQtbZMezjvbDC9KhkmZmaLQWULHnh3KVKTphPlEgOS45k_eBSkn9pbcZC9JhxZeu9SMvuxM-SburY8JfjcNkCa1RprBHpHFnS3PSJTAfdxd3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:iQtbZOLBnsJC_5YWjDxOgj7w4kcxugo_hPanmenvYKyfUAJbn0_eeQ>
    <xmx:iQtbZJJdZXQrryqVpAYzfOPSmCGAHWkjxzf_7Rw8palr4k_IJqswZA>
    <xmx:iQtbZHyfuADd7_x5WNhmtY2eXDV5IWqkNiziCVg00th616XsbsWEHA>
    <xmx:iQtbZHhn4y8v8-c5JCAfc85BLe-prDb7cLUdrOhp9zBR9VlX0FWXvw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 23:12:08 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>
Subject: [PATCH] firewire: net: fix unexpected release of object for asynchronous request packet
Date:   Wed, 10 May 2023 12:12:05 +0900
Message-Id: <20230510031205.782032-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lifetime of object for asynchronous request packet is now maintained
by reference counting, while current implementation of firewire-net
releases the passed object in the handler.

This commit fixes the bug.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/lkml/Y%2Fymx6WZIAlrtjLc@workstation/
Fixes: 13a55d6bb15f ("firewire: core: use kref structure to maintain lifetime of data for fw_request structure")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/net.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index af22be84034b..538bd677c254 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -706,21 +706,22 @@ static void fwnet_receive_packet(struct fw_card *card, struct fw_request *r,
 	int rcode;
 
 	if (destination == IEEE1394_ALL_NODES) {
-		kfree(r);
-
-		return;
-	}
-
-	if (offset != dev->handler.offset)
+		// Although the response to the broadcast packet is not necessarily required, the
+		// fw_send_response() function should still be called to maintain the reference
+		// counting of the object. In the case, the call of function just releases the
+		// object as a result to decrease the reference counting.
+		rcode = RCODE_COMPLETE;
+	} else if (offset != dev->handler.offset) {
 		rcode = RCODE_ADDRESS_ERROR;
-	else if (tcode != TCODE_WRITE_BLOCK_REQUEST)
+	} else if (tcode != TCODE_WRITE_BLOCK_REQUEST) {
 		rcode = RCODE_TYPE_ERROR;
-	else if (fwnet_incoming_packet(dev, payload, length,
-				       source, generation, false) != 0) {
+	} else if (fwnet_incoming_packet(dev, payload, length,
+					 source, generation, false) != 0) {
 		dev_err(&dev->netdev->dev, "incoming packet failure\n");
 		rcode = RCODE_CONFLICT_ERROR;
-	} else
+	} else {
 		rcode = RCODE_COMPLETE;
+	}
 
 	fw_send_response(card, r, rcode);
 }
-- 
2.37.2

