Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A1F6D3871
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjDBOc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDBOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:32:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8AA5D6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:32:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so107760608edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680445973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0EbqnaKdSiijP5AMHVuBOUgkUfHYyGlvbGYlKLav6c=;
        b=fxPZuh0uJQhe82KpCnaxLqcWweaM7VRVfxJNvpKtiVclnj/SXwE+HdnKx4fLcPEE9x
         SoJGqi3nbaWpfxGHIbaUZZc1u3FZARth9Dfz8AixcFoOReKECB0GpFOYMwFn3ssw/k5y
         q142iY3YVJKC4wI72scS6Nba/pcAvv0K3fbrrDr7Uyjxe9xl6GwcmoGV34YI4KbcMbP+
         E70eRTnbICOq7e1rwQRRx5Jb+zaNUWuQIocp7NZ7gk6GC6g2RnqwQSeeEd7jwj9dHhwm
         B3Xt5URhADdQSIdB8nbEwELfcNQBDbdHhi9AV5jZX3OwP/C/yu9/4eyuF5/QeLA6Zrc7
         L8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680445973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0EbqnaKdSiijP5AMHVuBOUgkUfHYyGlvbGYlKLav6c=;
        b=SmIWiXoy/UKzBaf3efdunEOVyXrLb/ergGdk01At9ghxp4uKSqitbFAFXkLvB8cXgr
         axuDEEDdaQysfPHW/RfyHOuZQeuk43WgWkMFdbRcXhOKntuOkmFZsW0jBy5h7LDjW94X
         W21Gv/sbvj24ANhd9dvn1LKNs/snrdNUpzL62GfUnjSOQyc7ErTrxS6nWaDCgMf/UULm
         /oNB6h7M5xN05bwwVPJILGi2v9DdUsJC+EruXVsTRCxGv5z8jHGW4kRO1cKGXzTmL5rE
         gyDo4YSLCUKYQurGrz7F2ZlXbhUlgR8QpUqs+KFFooQiO1unC9Je8QXggEyJe2TISyG5
         PZ7g==
X-Gm-Message-State: AAQBX9eLvhia9Wh2BCxuskqGhI3iYWNt90Q2AX/zN7EBKhgoNeJeTxFY
        fQ+JHTxJZY6XE/h8qb6GO5n+2W0GqUwNBA==
X-Google-Smtp-Source: AKy350ZXjjFMXrLcYZ/YZ3o327TMJILni8gdgD6bYM8TDo4r4Za9IJQi5IHub9U9f8+b/7aFDgb3zg==
X-Received: by 2002:a17:907:7d89:b0:947:c8d5:bfab with SMTP id oz9-20020a1709077d8900b00947c8d5bfabmr7852387ejc.35.1680445973100;
        Sun, 02 Apr 2023 07:32:53 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b009476dafa705sm3273292ejx.193.2023.04.02.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:32:52 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] staging: rtl8192e: fix alignment to match open parenthesis
Date:   Sun,  2 Apr 2023 19:32:43 +0500
Message-Id: <76814f7a2a026ef195334b0c42ecd2aeb8e8ea40.1680445545.git.kamrankhadijadj@gmail.com>
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

Fix alignemnt to match opening parenthesis as suggested by Linux kernel
coding-style. This issue is reported by checkpatch.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index eb7b6deb2ca7..8d3067a6ccca 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -332,7 +332,7 @@ static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 			data->rx_pn[5] = seq[0];
 		}
 		if (crypto_aead_setauthsize(data->tfm, CCMP_MIC_LEN) ||
-			crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
+		    crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
 			return -1;
 	} else if (len == 0) {
 		data->key_set = 0;
-- 
2.34.1

