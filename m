Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115346D3873
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjDBOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDBOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:32:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48ABDA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:32:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so107524552edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680445975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lNLxgv/KOG23ypMmeKBWcQbi18NmEa6zz29IZ1WhUc=;
        b=HuxIK+VBPzhv5W0m/zcMz59LHQ01rcrj7Js6RPwQ7AgzmwoEGQvh5RGFwGXBtUHF+F
         ATfW6T3zc8iAkII5oNuSkdiZzvTWygNJ5obLK3ADRIOHnP8Tpj4Xxh36KXJDxJSJe2TG
         o4B3abL5TbBt31HgUdHk3gx5/lrmvSW6dE9oO5oOYFSoVDBSRiTumXdE3cWrTo7RwslI
         u38yNgnqa6c702QzrCjr24uWZbkdq1mWYMIWupnX3juPHK9sfStHgwY6Eio0CcgfNSd0
         s9/M01VUt+1ojPOPWqxT74y6cLBwdm6qgVIVLMJjvs9tgde0Qyo7bd6V746PGigj+YcM
         oW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680445975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lNLxgv/KOG23ypMmeKBWcQbi18NmEa6zz29IZ1WhUc=;
        b=msF0Q6b0XmI64SdGS9uC81vWfMcK7yR9EP8awiZTCONkGDfxCxkugx96Tg25XzbIGQ
         FKRezbg4mX4p3zYLqg0arxTAzIM9FVA6KASCrG6FqtrFfLRF1YvgRLQpnLIDE0vtvFL0
         /rh3ZybYnVk8rOa0VQOIqoqeWlVekwn2k7as5cCqeuBsl7s7EzC8HrGL3/RdfEnUJa1F
         wQe4qp88V7cqhb8/osLCvvXQWPGRmUSpmEyjUBhP4O2UYPMjKUFNDbSw/QmvDzDsIiyA
         uLnQ5y/8TY8CiNBBESAjg9qXmgTgeAzgfDkElKeefV5RYiGZQfhBK6b44Tv20Ka25U6k
         03ig==
X-Gm-Message-State: AAQBX9ePGgQMTn+Iz5TZN+Ezy7S0UlAu95AwR04LfMYk/haohzmgYqEv
        h3gl/hAJmX7FRLYxvlFoP5Q=
X-Google-Smtp-Source: AKy350YuQIS5zi91f2yrQQSNGpzQ3ahqrQshBnd7iEXQsnACnBOhpn9QRJJq9azomFDXhJpmeuNHpg==
X-Received: by 2002:a17:906:fc0b:b0:87b:e105:5d9a with SMTP id ov11-20020a170906fc0b00b0087be1055d9amr34224412ejb.67.1680445974644;
        Sun, 02 Apr 2023 07:32:54 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b009476dafa705sm3273292ejx.193.2023.04.02.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:32:54 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPFormatErrors>
Date:   Sun,  2 Apr 2023 19:32:44 +0500
Message-Id: <ebfd9c40400eac872b9af2a5120b0829ff71e077.1680445545.git.kamrankhadijadj@gmail.com>
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
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 8d3067a6ccca..d37ca72678c8 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -34,7 +34,7 @@ struct rtllib_ccmp_data {
 	u8 tx_pn[CCMP_PN_LEN];
 	u8 rx_pn[CCMP_PN_LEN];
 
-	u32 dot11RSNAStatsCCMPFormatErrors;
+	u32 dot11rsna_stats_ccmp_format_errors;
 	u32 dot11RSNAStatsCCMPReplays;
 	u32 dot11RSNAStatsCCMPDecryptErrors;
 
@@ -226,7 +226,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	u8 pn[6];
 
 	if (skb->len < hdr_len + CCMP_HDR_LEN + CCMP_MIC_LEN) {
-		key->dot11RSNAStatsCCMPFormatErrors++;
+		key->dot11rsna_stats_ccmp_format_errors++;
 		return -1;
 	}
 
@@ -238,7 +238,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 			pr_debug("CCMP: received packet without ExtIV flag from %pM\n",
 				 hdr->addr2);
 		}
-		key->dot11RSNAStatsCCMPFormatErrors++;
+		key->dot11rsna_stats_ccmp_format_errors++;
 		return -2;
 	}
 	keyidx >>= 6;
@@ -374,7 +374,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   "key[%d] alg=CCMP key_set=%d tx_pn=%pM rx_pn=%pM format_errors=%d replays=%d decrypt_errors=%d\n",
 		   ccmp->key_idx, ccmp->key_set,
 		   ccmp->tx_pn, ccmp->rx_pn,
-		   ccmp->dot11RSNAStatsCCMPFormatErrors,
+		   ccmp->dot11rsna_stats_ccmp_format_errors,
 		   ccmp->dot11RSNAStatsCCMPReplays,
 		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
 }
-- 
2.34.1

