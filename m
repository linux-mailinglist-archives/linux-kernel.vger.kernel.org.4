Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B8701906
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbjEMSKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjEMSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:10:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82815FE7
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f252a86ca7so1414042e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684001372; x=1686593372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ecItjrrmoNNrjpM5Xnudv7ep0+/pzn0LcIKgPQDDuqk=;
        b=A0+z9p3ZrgaZ8l0LG4OXmMb2UrwdHc/U/PWf2oto37mlzUAeqZ/dpU9mDbQADBXg05
         8QbtkVFA8FJWxv7XnltNK8xZG9v8swoCTm8SpOHqIrdKTedym2xBNslnCQ7qFOlKmjYs
         5f/gUSURsDIJHfwFHV+iDh8SsGVPHW6W1pAn5nc28TXT55rbWpSuC6RJ60H56obgnALz
         ahEBnGIzGBzLRLtvxHlhPLkL2o6rdJA1CV5CZlWyZE3lc1CGtqjIx5KUlfVKD/e7YTNM
         trDjjtfqBE+MrX6OZM7LezX6rySBNjxqOwSUGUelzbsKlMtg+VxPfXM9LviPUht1q32D
         D/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001372; x=1686593372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecItjrrmoNNrjpM5Xnudv7ep0+/pzn0LcIKgPQDDuqk=;
        b=fvynY/WXotjaaeSr1bweM8CteSjF4/1q041iPNtvPVryMEGy7R9FqQucnGnin6Txhu
         nyybkeY5fl1D2PBh8WRlloMNBSZU3QgdHfvsFlPZ7tEatldOYzLnmCXdzv9JMK6duz5v
         aDXn+owBEuWJPOUqDa1x8rTa55VK/lFbhjpjSWJdsHrnpUNe/1Buq5ePW60MJ6Xg4q+/
         GR9EZ308RAoPZUrGVMV2u/JFX1ayDGSU8NsY8PlLZO1rCrL74Z7YMSFXyhI15Fr7kZ82
         OxuD/rYKTiwesgAhF5uF5yFhWCupPjA1k/Rl83gX8V69jg/qKZ2qNnsh6vobCWDBeLag
         nmYg==
X-Gm-Message-State: AC+VfDyyMEhzbHuPInnw41ZH5CDByrWoTymwlmxD53IK3+pOrtyeTBtV
        7egDHIOlr8i6qiofmGmy7ERFIb67Xu8=
X-Google-Smtp-Source: ACHHUZ4nfwDHku7aKvlbwj61Ico7w84ukD4Dneu3ddMfP2G+h5jX0bdNZ6yHEZC3yNpZkiL3T+glLA==
X-Received: by 2002:a17:906:5349:b0:953:2918:71e7 with SMTP id j9-20020a170906534900b00953291871e7mr2464704ejo.5.1684001352023;
        Sat, 13 May 2023 11:09:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id jy11-20020a170907762b00b0094f3b18044bsm7040634ejc.218.2023.05.13.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:09:11 -0700 (PDT)
Date:   Sat, 13 May 2023 20:09:09 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: rtl8192e: Remove undefined function
 hard_start_xmit
Message-ID: <603a143ba506ca031d7bd70a844b9f080872d601.1683960684.git.philipp.g.hortmann@gmail.com>
References: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function hard_start_xmit as it is not defined. Equation
!ieee->hard_start_xmit always evaluates to true. When
(*ieee->hard_start_xmit)(txb, dev) == 0 is called the my computer is
freezing.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    | 7 -------
 drivers/staging/rtl8192e/rtllib_tx.c | 8 +-------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cc4247ebea6b..7be02cfe56fe 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1654,13 +1654,6 @@ struct rtllib_device {
 	void (*set_security)(struct net_device *dev,
 			     struct rtllib_security *sec);
 
-	/* Used to TX data frame by using txb structs.
-	 * this is not used if in the softmac_features
-	 * is set the flag IEEE_SOFTMAC_TX_QUEUE
-	 */
-	int (*hard_start_xmit)(struct rtllib_txb *txb,
-			       struct net_device *dev);
-
 	/* Softmac-generated frames (management) are TXed via this
 	 * callback if the flag IEEE_SOFTMAC_SINGLE_QUEUE is
 	 * not set. As some cards may have different HW queues that
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 54119fba8a57..c3f1910d9f58 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -572,8 +572,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	/* If there is no driver handler to take the TXB, don't bother
 	 * creating it...
 	 */
-	if ((!ieee->hard_start_xmit && !(ieee->softmac_features &
-	   IEEE_SOFTMAC_TX_QUEUE)) ||
+	if (!(ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE) ||
 	   ((!ieee->softmac_data_hard_start_xmit &&
 	   (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)))) {
 		netdev_warn(ieee->dev, "No xmit handler.\n");
@@ -938,11 +937,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			dev->stats.tx_bytes += le16_to_cpu(txb->payload_size);
 			rtllib_softmac_xmit(txb, ieee);
 		} else {
-			if ((*ieee->hard_start_xmit)(txb, dev) == 0) {
-				stats->tx_packets++;
-				stats->tx_bytes += le16_to_cpu(txb->payload_size);
-				return 0;
-			}
 			rtllib_txb_free(txb);
 		}
 	}
-- 
2.40.1

