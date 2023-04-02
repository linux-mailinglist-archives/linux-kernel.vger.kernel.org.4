Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291E26D3874
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDBOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDBOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:33:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D82682
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:32:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so107712098ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680445978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81yzIuoBJY31RIgCNtPXI4MH4MI0Ymz/ovjpa7G5Au8=;
        b=mz8q8tlTRahr4dUJqiWpfSFk/N5vv6BLwE3qVuiCsEYdc/9lsa0OL2zlXz9KCo/NQQ
         DiPa3GFA4WkUWpNMJdWWumgcd8swVdzafrOhHnOBNi8qZ3XGv5Na+jxcwGDSDrMvbtC9
         OzlmQwlz36Gp/gSfyaOFoHgWIX4CfNHJT9T8h6xAjwCTojXywY0/hEfXP1WzmKo1YbCX
         aIbC1Knr8I+lpuC4YrKpYu+T4YsLIIS9nq8PoYwKi+QnnB9oWlPFmAqqvH8obAWYf2vu
         lWo8uab5iTo+IFTmSXBygZh4UTRSIF7jNMv2ba7Zh4pcwi1vvc8Uw4vWpCUrZVrF9H54
         sjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680445978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81yzIuoBJY31RIgCNtPXI4MH4MI0Ymz/ovjpa7G5Au8=;
        b=pxaPYHF2ZpxU18vVXC3xzXAGjRCSO4TqbDoROBZ/MClyf5wty1VfKHW6K/S4QfPEQP
         St8NqZPVXdGn4/ADQ1kiqIEDp6Hi/nKuTfSZvTLmFxVNJUWCjjuKdkDmB8VgHm4UK6f0
         +miMLty8RTj38Fkw0zFdI+E9pzhrT/1YIkeOMXpzUJNR+h3nMuiuCBfFEj7dwgr2mY0F
         WYZu3GkCNIbgamddZOZtRExE88orcEmENMC5eCKPO5Lm1N6QzM3/pa7DRhyKh+ezwJ1y
         xHDgAKvMdaL75pOA7QprkEmUO+XlP7WV2myLYd3TLSVKZ/DN+hwHqmCsAKrr1VpKKeVi
         4A6w==
X-Gm-Message-State: AAQBX9fv15LOTBbRntZfYzdNxYAO5CjfR/gw53vlYXI5UFovCLcFRe4G
        PINjdVwRlkqClp14RPbJOYU=
X-Google-Smtp-Source: AKy350ZcqOubIDVdPJe9vMrgbtScXlEby33eShAZQfT065MfI3J9DCmnbKS86v+TQomKpq6WDtswyA==
X-Received: by 2002:a17:906:5d03:b0:92f:495b:bc7c with SMTP id g3-20020a1709065d0300b0092f495bbc7cmr17158572ejt.23.1680445978075;
        Sun, 02 Apr 2023 07:32:58 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b009476dafa705sm3273292ejx.193.2023.04.02.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:32:57 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPDecryptErrors>
Date:   Sun,  2 Apr 2023 19:32:46 +0500
Message-Id: <d29ff5db6f19d79ee762a835db88155bee2aefba.1680445545.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680445545.git.kamrankhadijadj@gmail.com>
References: <cover.1680445545.git.kamrankhadijadj@gmail.com>
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

Linux kernel coding-style suggests to not use mixed-case names. Fix
checkpatch issue by changing the variable name from camel case to snake
case.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 448c0a931c78..f88096bcb181 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -36,7 +36,7 @@ struct rtllib_ccmp_data {
 
 	u32 dot11rsna_stats_ccmp_format_errors;
 	u32 dot11rsna_stats_ccmp_replays;
-	u32 dot11RSNAStatsCCMPDecryptErrors;
+	u32 dot11rsna_stats_ccmp_decrypt_errors;
 
 	int key_idx;
 
@@ -296,7 +296,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 				pr_debug("CCMP: decrypt failed: STA= %pM\n",
 					 hdr->addr2);
 			}
-			key->dot11RSNAStatsCCMPDecryptErrors++;
+			key->dot11rsna_stats_ccmp_decrypt_errors++;
 			return -5;
 		}
 
@@ -376,7 +376,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->tx_pn, ccmp->rx_pn,
 		   ccmp->dot11rsna_stats_ccmp_format_errors,
 		   ccmp->dot11rsna_stats_ccmp_replays,
-		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
+		   ccmp->dot11rsna_stats_ccmp_decrypt_errors);
 }
 
 static struct lib80211_crypto_ops rtllib_crypt_ccmp = {
-- 
2.34.1

