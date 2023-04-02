Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C756D3870
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjDBOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjDBOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:32:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621D86AF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:32:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn12so107736188edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680445971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4O3XZtJ4K7opusRPJDG2obDOo5CziuFWNMf3s6wXVg=;
        b=NEZ9LvN/mLZqMYlZ9L97ckgrRkCra4szM2G/LmlReGnOgGbBbef0SywgS4v/MorZA5
         vpnrDojGnEoS35dcoYWOup6RUSnCjG4WLkeS2dy1vLcnmPN1iXPOX0385h2+hFeqkUEE
         TPzQQgqE0XzgFTDtMnPzKmBLjPhNZhmAlziVLSEybCsriR2YGd7sZkcfXxiwN6UrnFtT
         h2LsUEwUN6WoC5mf5BovXQ8PWhH8NwX6MiHh+hNb8tvHvG3MZOyuUCmKbxzx1gkyy+Lx
         8FjrRuW8IWLlwoQ7T9OdPyFnMxizP0A45rgOZWubPQ7IPhtrKVY4B+TmSxI120+XdPp5
         M0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680445971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4O3XZtJ4K7opusRPJDG2obDOo5CziuFWNMf3s6wXVg=;
        b=LhnVfA+BjTy9/9SSPUHeF3xpW+Jwq+Gvnerms5fqxjh3TWlAMk9iGfIBwAml16fqRU
         arM4bMvUptsQi5kkxWVH3VTyMc35Ji/wr+SqHDiBP1kBLQp0iYsSaMz6QZrjBFrPQObX
         tybQZx7z/t5gLBoSMjxTNoyAJN67CcumBA/iEiIDMUs+8rgeo9JcsUs7MKfVXZgJTIbz
         /5fe8hsG4XI02bz6NY0kj9VjCbe2inLwGiV3JdPXjTE0B+cbnn4u+QGktR3XE7306pcW
         DVpoPe3difwTS3o96zZy+Hicu0E9rRxQEYPKzX67Ito0UJ19UNEOR9XUXz+BrBML1FGG
         ZnWA==
X-Gm-Message-State: AAQBX9dkoE68spU/2XzubpyiVkYmX90H/CawwN5rICa2FwtQjdpwL4aP
        uQ0twjMUnY+NvF2eDJi+RYc9H+4zeSbOsQ==
X-Google-Smtp-Source: AKy350Z+eGdsDHytrStVjlEP6NI/g26MKcJtEiZg3BQ2pkBC19vUWrXi2ZyL5He6BWREvl4IwSHnCQ==
X-Received: by 2002:a17:906:85c2:b0:88d:ba89:1837 with SMTP id i2-20020a17090685c200b0088dba891837mr15072836ejy.8.1680445971564;
        Sun, 02 Apr 2023 07:32:51 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b009476dafa705sm3273292ejx.193.2023.04.02.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:32:51 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] staging: rtl8192e: remove extra blank lines in rtllib_crypt_ccmp.c
Date:   Sun,  2 Apr 2023 19:32:42 +0500
Message-Id: <283265f6a5ff938f8425e14af86cee9e2da36318.1680445545.git.kamrankhadijadj@gmail.com>
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

Remove extra blank lines as suggested by the Linux kernel coding-style.
These issues were reported by checkpatch.

"CHECK: Please don't use multiple blank lines"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index a8d22da8bc9a..eb7b6deb2ca7 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -74,7 +74,6 @@ static void *rtllib_ccmp_init(int key_idx)
 	return NULL;
 }
 
-
 static void rtllib_ccmp_deinit(void *priv)
 {
 	struct rtllib_ccmp_data *_priv = priv;
@@ -84,7 +83,6 @@ static void rtllib_ccmp_deinit(void *priv)
 	kfree(priv);
 }
 
-
 static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
 				u8 *pn, u8 *iv, u8 *aad)
 {
@@ -150,8 +148,6 @@ static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
 	return aad_len;
 }
 
-
-
 static int rtllib_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct rtllib_ccmp_data *key = priv;
@@ -220,7 +216,6 @@ static int rtllib_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return 0;
 }
 
-
 static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct rtllib_ccmp_data *key = priv;
@@ -315,7 +310,6 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-
 static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct rtllib_ccmp_data *data = priv;
@@ -349,7 +343,6 @@ static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 	return 0;
 }
 
-
 static int rtllib_ccmp_get_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct rtllib_ccmp_data *data = priv;
@@ -373,7 +366,6 @@ static int rtllib_ccmp_get_key(void *key, int len, u8 *seq, void *priv)
 	return CCMP_TK_LEN;
 }
 
-
 static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 {
 	struct rtllib_ccmp_data *ccmp = priv;
@@ -403,13 +395,11 @@ static struct lib80211_crypto_ops rtllib_crypt_ccmp = {
 	.owner			= THIS_MODULE,
 };
 
-
 static int __init rtllib_crypto_ccmp_init(void)
 {
 	return lib80211_register_crypto_ops(&rtllib_crypt_ccmp);
 }
 
-
 static void __exit rtllib_crypto_ccmp_exit(void)
 {
 	lib80211_unregister_crypto_ops(&rtllib_crypt_ccmp);
-- 
2.34.1

