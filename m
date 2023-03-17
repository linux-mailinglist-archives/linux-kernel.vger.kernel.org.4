Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909536BE182
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjCQGsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCQGsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:48:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73031524D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:48:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so16493906edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679035691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTh0F21TwbjU88Bbz1hq5ZE+hy838Tvfzn8yCnXFty4=;
        b=pSj+KwElbb+2jzq501JA/pCh4CkyH4uILIM30gt0mkNF1CHnLVHVUFh5KvHOQzUB44
         B2qE44/QUblHAppjMP1lXcbQFFAmvkDY+P5uPB2UvJuF408n7UYzV07JThP0FIEAGFB2
         EfyIE4vlmzuE4ywRBmBKI/ttNnnre9MulnxynTd6z/EfMPhMzCj2uz0W3sIPif/ewoT/
         svrrxDMsJyE6qU3oDKXPhgXtG8PhX729DBpRrJ0kHcNOrmJiDs7DgFnifynSXvMuhNe5
         I8miJcmowHWZHlVbAi00+t66Z7sNPLKhppI0jtOQvYkdqSHDNNdR4f7C3U+32VmxNCFi
         LzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679035691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTh0F21TwbjU88Bbz1hq5ZE+hy838Tvfzn8yCnXFty4=;
        b=LnNSCrFV5UNsNSbyS0RDj5b+ZW0JcLAvj7/6e46tkLrkwXF8Ij+VCSyD/mNOOQKl3L
         ZWtJRTgTsZ34L+xD0F/9k6A3H2ftQZNOyRjueK8RGHAP4ndEZ+jT1JyNGgZMhu2vvgt1
         2LVxztOckLqOktdiCPe34NQRXcTxjZNZoKZ7y9zzmCoHKMuwFC8uwDeLcoExRxvibXJv
         uoVTCmv4yOZkTZmw3+/EHm4gRnh4XYkKxhW/RqsZt/2qT0G+/ux4q0oubBY2TJZcs3c3
         RibUOm7wjPnnolB3832GgAv3TLqBmtEx9AxKA1smUDCiY1qP3wGLCkRageEhXqtF+kMk
         f7Vw==
X-Gm-Message-State: AO0yUKUjSc3WdfNrq37u2yRMLnYKeJs8FehezmqSRlBZzaNoGH+qVtct
        7JbwnvJF2tuHqcKO8rpAgRE=
X-Google-Smtp-Source: AK7set/4N1GHVyF2fZkorcLa7fn9Z9JiQJjZIJuc6IJOPPpzB1sUKnTvLjiZaHYFRjeE+yD/X0IAKw==
X-Received: by 2002:aa7:cc15:0:b0:500:47ed:9784 with SMTP id q21-20020aa7cc15000000b0050047ed9784mr231767edt.14.1679035690850;
        Thu, 16 Mar 2023 23:48:10 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbef.dynamic.kabel-deutschland.de. [95.90.187.239])
        by smtp.gmail.com with ESMTPSA id y43-20020a50bb2e000000b004f9ca99cf5csm601963ede.92.2023.03.16.23.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 23:48:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: vt6656: remove unused vnt_get_current_tsf() function
Date:   Fri, 17 Mar 2023 07:48:00 +0100
Message-Id: <20230317064800.12276-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vnt_get_current_tsf() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/vt6656/card.c | 21 ---------------------
 drivers/staging/vt6656/card.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 7827e579ef3d..b9dc0d13c00c 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -11,7 +11,6 @@
  *      vnt_add_basic_rate - Add to BasicRateSet
  *      vnt_ofdm_min_rate - Check if any OFDM rate is in BasicRateSet
  *      vnt_get_tsf_offset - Calculate TSFOffset
- *      vnt_get_current_tsf - Read Current NIC TSF counter
  *      vnt_get_next_tbtt - Calculate Next Beacon TSF counter
  *      vnt_reset_next_tbtt - Set NIC Beacon time
  *      vnt_update_next_tbtt - Sync. NIC Beacon time
@@ -230,26 +229,6 @@ int vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
 			       MESSAGE_REQUEST_TSF, 0, 8, data);
 }
 
-/*
- * Description: Read NIC TSF counter
- *              Get local TSF counter
- *
- * Parameters:
- *  In:
- *	priv		- The adapter to be read
- *  Out:
- *	current_tsf	- Current TSF counter
- *
- * Return Value: true if success; otherwise false
- *
- */
-bool vnt_get_current_tsf(struct vnt_private *priv, u64 *current_tsf)
-{
-	*current_tsf = priv->current_tsf;
-
-	return true;
-}
-
 /*
  * Description: Clear NIC TSF counter
  *              Clear local TSF counter
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index be32c25c95de..eb01f7cc871f 100644
--- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -30,7 +30,6 @@ void vnt_update_top_rates(struct vnt_private *priv);
 bool vnt_ofdm_min_rate(struct vnt_private *priv);
 int vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
 		   u64 time_stamp, u64 local_tsf);
-bool vnt_get_current_tsf(struct vnt_private *priv, u64 *current_tsf);
 bool vnt_clear_current_tsf(struct vnt_private *priv);
 int vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval);
 int vnt_update_next_tbtt(struct vnt_private *priv, u64 tsf,
-- 
2.40.0

