Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B96E95F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjDTNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDTNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:38:28 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 06:38:19 PDT
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [IPv6:2001:41d0:1004:224b::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF065245
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:38:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tinyglitch.net;
        s=key1; t=1681997555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HYPasswPNjthbHxXzPBv9mP61cdgKG5LEiRivNJjVRE=;
        b=eKwD+AJhzVcAHvYj2LhRyrUZiTSixI4oin8FrxXXrGk0ItAiIJshOXQzdZ+Y23HJihlo/7
        ecw9FNuNA1DohnTsNJK4e0c15mb57Mg/aUwlovfSzIq2i/Yl6NNh00wcTThcPmxIo766hO
        dPWhMJdxQvmYFT3/EmYnVvGJ1MZ87Q8IJLaPBX8YAyFLSaRcQBXFV5uqtBxDOqq8L9fL9o
        M62GOw0I2kRBIRDhBqSfJQVEcAfAeVcBTjhZAy/a4g5UV8X10RccubpKed/uIH8fjUruLK
        K1vHoppMKF5HM6uTUx83lip+OFHnZOpUdu+iVoYZOovz4IGbXqaE9fcEnOjIKA==
From:   Stephan Snyman <rooiratel@tinyglitch.net>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, kamrankhadijadj@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stephan Snyman <rooiratel@tinyglitch.net>
Subject: [PATCH] staging: rtl8192e: add missing braces {}
Date:   Thu, 20 Apr 2023 15:32:09 +0200
Message-Id: <20230420133209.4661-1-rooiratel@tinyglitch.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing braces to if/else statements to adhere to the
Linux kernel coding-style guidelines.
These issues were reported by checkpatch.pl

"CHECK: braces {} should be used on all arms of this statement"

Signed-off-by: Stephan Snyman <rooiratel@tinyglitch.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index b649d02dc5c8..d44bf261de54 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -264,8 +264,9 @@ static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
 		   RTLLIB_FCTL_FROMDS &&
 		   memcmp(hdr->addr1, dev->dev_addr, ETH_ALEN) == 0) {
 		/* FromDS frame with own addr as DA */
-	} else
+	} else {
 		return 0;
+	}
 
 	if (skb->len < 24 + 8)
 		return 0;
@@ -433,8 +434,9 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 		if (*last_frag + 1 != frag)
 			/* out-of-order fragment */
 			goto drop;
-	} else
+	} else {
 		*last_seq = seq;
+	}
 
 	*last_frag = frag;
 	*last_time = jiffies;
@@ -2314,8 +2316,9 @@ static inline int rtllib_network_init(
 	if (stats->freq == RTLLIB_52GHZ_BAND) {
 		/* for A band (No DS info) */
 		network->channel = stats->received_channel;
-	} else
+	} else {
 		network->flags |= NETWORK_HAS_CCK;
+	}
 
 	network->wpa_ie_len = 0;
 	network->rsn_ie_len = 0;
@@ -2329,9 +2332,10 @@ static inline int rtllib_network_init(
 		return 1;
 
 	network->mode = 0;
-	if (stats->freq == RTLLIB_52GHZ_BAND)
+
+	if (stats->freq == RTLLIB_52GHZ_BAND) {
 		network->mode = IEEE_A;
-	else {
+	} else {
 		if (network->flags & NETWORK_HAS_OFDM)
 			network->mode |= IEEE_G;
 		if (network->flags & NETWORK_HAS_CCK)
-- 
2.40.0

