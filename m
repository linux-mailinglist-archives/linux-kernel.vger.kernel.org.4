Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C606A109D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBWTgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBWTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:36:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461058B7B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:36:38 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e24so5679765ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk+cDCcz2CVt0ThfX9BY25TGDL0RI1Xa6b4kLFjXY2o=;
        b=QoSM0+1dwluesL8imzF5TA/C1dlhofcJJ982B2XLpjkuJOjOIXop0NaPfao9JJa5Wj
         RJKQv1JU37jBGfMA3uCgwTUjjG0ko5NI6PV0gbGGmSy4DT6KTmpqvoFKW1bnArEqZnNh
         OlUVIT5fglfoBZzc0JQWvJUqm3ZyaWddaeKtAhIknvGKteHq7sdMoj7Zjx5BQ6M9NahU
         ynkrxpdlonGzBZAemFUsOcegS86ts7hSIRv9XXM4hbxxgi9MxcNngI/d9iEMB15yhvWm
         UKAb0bA4I8QcY1FjeouakSqMGNHKVvafa7G+9GqOZ5LcEiN16Eey3D0pJq0Mc2qOEI0+
         LtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk+cDCcz2CVt0ThfX9BY25TGDL0RI1Xa6b4kLFjXY2o=;
        b=5g197zABlMPO5NWnBecUYP859nAFIjEu53T23JgPqMFyvP/Ilrw6otu555IIKKaUN8
         CS2opAGrU/OnaU9a3MKMHc41q2IzmmKE5S0nBhulL6+dXME/EEgfaXx3YlHPGbwLa4CH
         bmbr9OGJrQg8IZF5J4sU16Fpq4BnJBGBV//z+iNIHOv63zxXpY6i8+eS0SsmQsnU32gO
         c2vWGsua5ejiiLUCIlx/sfKGlRhybTW9c60pemokVe7ILGz+paUEtU43+naDNLYjz/8X
         3jG31ilt+7qqWbtLnL3YDWymaMHB3XddMeimyiwFmKxNN6kfwriIPy0PSNuOIsQ79otJ
         S+CA==
X-Gm-Message-State: AO0yUKXN4hMU4gaxyDO75uNP40bJVEcHe0uQWT5SJrguBppPuwx4hkvl
        iNDcqPZwhlD1dUG7IeZ5sIT0ItWxLAYihvIL
X-Google-Smtp-Source: AK7set/c6lm9czTl0xw0+ysZMiL6iurd+kFscmhxC7LVZXslMR9fEAOxekMYiiObSDDdcfL0fJutWg==
X-Received: by 2002:a2e:b893:0:b0:293:4fda:22d1 with SMTP id r19-20020a2eb893000000b002934fda22d1mr6134008ljp.46.1677180996613;
        Thu, 23 Feb 2023 11:36:36 -0800 (PST)
Received: from localhost.localdomain ([2a00:1370:81ae:2572:38e9:e6ee:6827:29dd])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e3807000000b0029343fe58e3sm1422209lja.130.2023.02.23.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:36:36 -0800 (PST)
From:   Leonid Pershin <leonid.pershin@gmail.com>
Cc:     Leonid Pershin <leonid.pershin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192u: remove split in user-visible string
Date:   Thu, 23 Feb 2023 22:35:57 +0300
Message-Id: <20230223193559.157880-1-leonid.pershin@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to coding style, user-visible strings in printk()
function calls cannot be split across multiple lines.
Issue found with checkpatch.pl.

Signed-off-by: Leonid Pershin <leonid.pershin@gmail.com>
---
Changes in v2:
  - Replace printk(KERN_DEBUG...) with pr_debug()

 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 9bfd24ad46b6..c378bdff453b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -72,16 +72,14 @@ static void *ieee80211_tkip_init(int key_idx)
 
 	priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->tx_tfm_michael)) {
-		printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate "
-				"crypto API michael_mic\n");
+		pr_debug("ieee80211_crypt_tkip: could not allocate crypto API michael_mic\n");
 		priv->tx_tfm_michael = NULL;
 		goto fail;
 	}
 
 	priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->rx_tfm_michael)) {
-		printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate "
-				"crypto API michael_mic\n");
+		pr_debug("ieee80211_crypt_tkip: could not allocate crypto API michael_mic\n");
 		priv->rx_tfm_michael = NULL;
 		goto fail;
 	}
-- 
2.39.2

