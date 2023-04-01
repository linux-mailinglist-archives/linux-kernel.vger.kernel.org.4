Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B006D334A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDAS7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDAS6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:58:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B926593
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:58:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m8so3885150wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45/uUH+GA+g3TzzPmCYcmE2gkkTwmaIuQw5taJgSmzw=;
        b=oFnSc0BInMmk+K4wobRGty9HhtMLWMo6hhByjwS8VBUnMZdRqwqrHKKa5i3jloNeCA
         nOMueRUXendCJ505jW0KmBe/ZFyJUvPMOOe4n3e4Uci32nW6IgvaAyp6/o+6rl9/rBou
         qnPfX+N9vZHmzSJftLrzcruk5pTgQy4N+QjLq7YKkkTpIuT5SoH6rToNUw9DND2yk+Jc
         jq8CIGXUFVqbN57WlxkrmQouatgMxLYptm9BUifJdxIUrBGXS0CzlLDlUkWmIsZglxsq
         u+WNErbektNfgAU6vinyzwpnu4hlUZpuo+u0XGQiSqOSMAyiGNY9FesfhrdahgQ9wELg
         H81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45/uUH+GA+g3TzzPmCYcmE2gkkTwmaIuQw5taJgSmzw=;
        b=IJq7P8awq6pTgYnIECdYht6ekSKE57TXnQrv2UtCSxxKjuqBpsf0jI9+a/NP8YUcZb
         LlOoy2xguN5hZw4qB85xgA2S9dsKjhOkmTwTDumTJ7O7PPnqo3uRef2xyAP5a1vmAXLm
         krzyzn+ux+MPDpq5anp1VDgF1Hza2aHVQNNYDlnLK0jXaxCpVmmh2FdgJ3faEnvMm71s
         SBBZx1KtyyYWaegzKkdwLy/CsLjpXLwHEq3s3rzzqY2RHQFzpIJQ+MmBhwQ0tCECUiib
         7ggaU6wJ+OY9NLPhtASFfBa9LDptbqxakO5WcB3v6N9bd4wQ6s+FVoBpL7B9jbnP2U/7
         rqfw==
X-Gm-Message-State: AO0yUKWbW/Jslpg6/RfZVGkWBT/hazPZb3m8MsyyfqVgTNZfuF4HOIpg
        qMuPA33w2wd835/oLl/bfd0=
X-Google-Smtp-Source: AK7set9s8UXrjEJdWqyo51fhyCBtOYvvguTSAgcapsnQFwa09yojzoProaVglsGQFSL+qmUYNk+FQA==
X-Received: by 2002:a7b:ce16:0:b0:3ed:2709:2edf with SMTP id m22-20020a7bce16000000b003ed27092edfmr24775939wmc.13.1680375532974;
        Sat, 01 Apr 2023 11:58:52 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm14017463wmo.26.2023.04.01.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 11:58:52 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
Subject: [PATCH 3/5] staging: rtl8192e: avoid camel-case <dot11RSNAStatsCCMPFormatErrors>
Date:   Sat,  1 Apr 2023 23:58:42 +0500
Message-Id: <7ed9ed4df19b1ab818fc4b3ec43083e1a051c38e.1680375200.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680375200.git.kamrankhadijadj@gmail.com>
References: <cover.1680375200.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding-style does not suggest mixed-case names. This issue
is reported by checkpatch.

Fix variable name by changing it from camel-case to lower-case. In order
to describe the variable name better, add a comment above it.

Suggested-by: Deepak R Varma <drv@mailo.com>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 8d3067a6ccca..e8a3bc94efdc 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -34,7 +34,8 @@ struct rtllib_ccmp_data {
 	u8 tx_pn[CCMP_PN_LEN];
 	u8 rx_pn[CCMP_PN_LEN];
 
-	u32 dot11RSNAStatsCCMPFormatErrors;
+	/* .11 RSNA stats for CCMP */
+	u32 ccmp_format_errors;
 	u32 dot11RSNAStatsCCMPReplays;
 	u32 dot11RSNAStatsCCMPDecryptErrors;
 
@@ -226,7 +227,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	u8 pn[6];
 
 	if (skb->len < hdr_len + CCMP_HDR_LEN + CCMP_MIC_LEN) {
-		key->dot11RSNAStatsCCMPFormatErrors++;
+		key->ccmp_format_errors++;
 		return -1;
 	}
 
@@ -238,7 +239,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 			pr_debug("CCMP: received packet without ExtIV flag from %pM\n",
 				 hdr->addr2);
 		}
-		key->dot11RSNAStatsCCMPFormatErrors++;
+		key->ccmp_format_errors++;
 		return -2;
 	}
 	keyidx >>= 6;
@@ -374,7 +375,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   "key[%d] alg=CCMP key_set=%d tx_pn=%pM rx_pn=%pM format_errors=%d replays=%d decrypt_errors=%d\n",
 		   ccmp->key_idx, ccmp->key_set,
 		   ccmp->tx_pn, ccmp->rx_pn,
-		   ccmp->dot11RSNAStatsCCMPFormatErrors,
+		   ccmp->ccmp_format_errors,
 		   ccmp->dot11RSNAStatsCCMPReplays,
 		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
 }
-- 
2.34.1

