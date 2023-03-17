Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239816BE18E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCQGu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCQGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:50:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F7BD4D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so16664459edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679035848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVUZy9GLOTi6aHPZwsHc62dMvLgMytvSk8FMI0v4FVc=;
        b=YRz7uLreoI4ccx7dGlfy6il3ilTF4CT0w8jUu2k61nNB2LLKfikZVw2khfATBKszwJ
         N5YM0OoeF+plNiXzoQVxnmxWkjSKDDfNgZ7cBMfk+KLcoMY/8jxHo0DjxAShm/X6lL8x
         GlYBe4UYpnhtqkmLuOM07XyLfyfJ4MYzbYyfqDNsMErc/TU5dP6GNSyRaAEoGAnZmQDJ
         ZvdcmXBUGXkSbFeTX82RQi9XVPCrNLRPNzDhupTrDM/ypvXlIL1MMou8bZ3dOb2VCVdo
         igm9P4GBCiJi22oonKVoW11cS6K8DlUGat4bIukuozN7nIAPNU2e5oq7LCjs+YF+5Y0w
         rNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679035848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVUZy9GLOTi6aHPZwsHc62dMvLgMytvSk8FMI0v4FVc=;
        b=gDaHfo3df8CD7Y6vqA+vuju/EZQv1Jzd6YeihbVUUB36EEeKjjhhz+oVPuYCfA3YuF
         xYxIOL/xGQii58SdNAcsxY6ZzflwO9NhSniK7mOYI76EMgCuC4jGSI9uPFJPXNPtFfFE
         BkNLAdn1iBl+4DtdgwShxzS2wTwuFUdQYZSCVzGnqNXO0+SfastvXYP9ZzXuuGetavZg
         ZiDJ33bJ0tfraBTfI6qJ57KtRDalzF1kpeIqHgBGiIw5E+Rjabi3teKzdW5R75UApxWN
         XEpFmx3KWRAhW2MZcowBfTcVRDxeFnBLdoRDzal7QNXe5XBqqI7o172aLEeB+Z07VMzx
         FLdw==
X-Gm-Message-State: AO0yUKUcjKkp2uO014pqS2jYypjpH0s1GJy4yHELOCR6koHBVjhLsZRR
        memuxDz3n4OlBnNcZC9YGXI=
X-Google-Smtp-Source: AK7set9N9ip30JoVnUaaM0uRvuAW+EhNVUsVcGPdKWaVrqcCWAmUqiiyGEwZcWpseVjkltdYy7juLw==
X-Received: by 2002:a05:6402:455:b0:4fd:1fe1:838f with SMTP id p21-20020a056402045500b004fd1fe1838fmr2318136edw.14.1679035848524;
        Thu, 16 Mar 2023 23:50:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbef.dynamic.kabel-deutschland.de. [95.90.187.239])
        by smtp.gmail.com with ESMTPSA id z24-20020a17090674d800b009289de993e2sm577438ejl.216.2023.03.16.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 23:50:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: vt6655: remove unused bb_power_save_mode_on() function
Date:   Fri, 17 Mar 2023 07:50:40 +0100
Message-Id: <20230317065041.16635-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317065041.16635-1-straube.linux@gmail.com>
References: <20230317065041.16635-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function bb_power_save_mode_on() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 22 ----------------------
 drivers/staging/vt6655/baseband.h |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 6ce41983dcf4..d7c3e4bec560 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2171,28 +2171,6 @@ bb_software_reset(struct vnt_private *priv)
 	bb_write_embedded(priv, 0x9C, 0);
 }
 
-/*
- * Description: Baseband Power Save Mode ON
- *
- * Parameters:
- *  In:
- *      iobase      - I/O base address
- *  Out:
- *      none
- *
- * Return Value: none
- *
- */
-void
-bb_power_save_mode_on(struct vnt_private *priv)
-{
-	unsigned char by_org_data;
-
-	bb_read_embedded(priv, 0x0D, &by_org_data);
-	by_org_data |= BIT(0);
-	bb_write_embedded(priv, 0x0D, by_org_data);
-}
-
 /*
  * Description: Baseband Power Save Mode OFF
  *
diff --git a/drivers/staging/vt6655/baseband.h b/drivers/staging/vt6655/baseband.h
index 15b2802ed727..d1128d050ac5 100644
--- a/drivers/staging/vt6655/baseband.h
+++ b/drivers/staging/vt6655/baseband.h
@@ -63,7 +63,6 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data);
 /* VT3253 Baseband */
 bool bb_vt3253_init(struct vnt_private *priv);
 void bb_software_reset(struct vnt_private *priv);
-void bb_power_save_mode_on(struct vnt_private *priv);
 void bb_power_save_mode_off(struct vnt_private *priv);
 void bb_set_tx_antenna_mode(struct vnt_private *priv,
 			    unsigned char by_antenna_mode);
-- 
2.40.0

