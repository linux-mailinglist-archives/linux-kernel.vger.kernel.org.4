Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9465B4D97
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIKKqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIKKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:45:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EF27FEE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1086129wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=SX58nvHa5MmAWCyfWE/eOeXOe3udXQO3AxsT+e0r78A=;
        b=Bh6oav9fyTcnDsQlNO5fxtvtQdNeLsWxHgzF6LtGi63CzykttX+KDK2e4H4VjYPPRt
         rw2hr/IgjV78oSb5L+CFXiDE3spEA1Bw40lfRA07/Fx5MyBJVcOoY/3XTst9Hr6sgbq4
         0BkvICNJXys+jYlZvhJDcQi4I6/dlv4ma+ZFowqbpZxbaxbcFfFvtx5UJmh5+g5ZLe7V
         4uPOkCYuBdYpWmsvb6r8IuNIe8QMMnVCO2LRSM5+igsoR2WeCLxJunMkIWtD4M1g4XoL
         ecwqxQ86Ame6Hc2FtgdqUVkg+fPFhEQfCgdjk94e0LYQ6P9zN2Yy9D3jEJDCIpbctMhi
         6ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SX58nvHa5MmAWCyfWE/eOeXOe3udXQO3AxsT+e0r78A=;
        b=R3/djD+MaHuVqbDHBqACfN4bv08uMHMcbqwgdocxhNoJE4AYh0z/DTN3V/6PNy7saD
         souLLujpO5MYgplDPjpKsOKzdv8ASRhAN/0sU51XAnp83qOq3VngHDJ0tPFks7SIiMIg
         CNMscMg38GTH1AzGFeH7QtWhyoAPYtF8wMzUU/JuN9cOwu8VCrYzNF+GwTQKm2CZaBvG
         9I1binPvKNLoF7ZPJeIB/C6SCETV6bK2JWxCV3QZCXCaDd9wIRW+grX/xqqrmzd022S/
         ZwCspzKQEppbQPWyx1+SoF9PvFJ6GKmjjNPI889cvK3tpREBruBnJtLm0vAM62ftRX04
         WgmA==
X-Gm-Message-State: ACgBeo31v9EDE0WCysQqzZWhgwaCdVDuNP7C1KMHJOk7nqkzl8WDmoC6
        HagqBZ6HIxaQLb0jGvuOj9A=
X-Google-Smtp-Source: AA6agR75XWQpI3Gher5EAOaqqS02uNIJRaFlFnwVdDzDVSGryK9IwIBdgffwOrn1TNkIp8fpHzJEXQ==
X-Received: by 2002:a05:600c:1c84:b0:3b3:ef37:afd3 with SMTP id k4-20020a05600c1c8400b003b3ef37afd3mr6954238wms.155.1662893155699;
        Sun, 11 Sep 2022 03:45:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id q127-20020a1c4385000000b003a5f54e3bbbsm6325332wma.38.2022.09.11.03.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:45:55 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:45:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] staging: vt6655: Cleanup and rename function
 MACvRestoreContext
Message-ID: <3d215bbf1675fd093c9b31fbf3b29ce09432ab27.1662890990.git.philipp.g.hortmann@gmail.com>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function MACvRestoreContext to vt6655_mac_restore_context to avoid
CamelCase which is not accepted by checkpatch.pl. Remove unnecessary
declaration of function and make function static. Change declaration of
cxt_buf to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 6 +++---
 drivers/staging/vt6655/mac.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 092b1fffcfa1..b1aa5fbe4430 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -15,7 +15,7 @@
  *      MACvSetLongRetryLimit - Set 802.11 Long Retry limit
  *      vt6655_mac_set_loopback_mode - Set MAC Loopback Mode
  *      vt6655_mac_save_context - Save Context of MAC Registers
- *      MACvRestoreContext - Restore Context of MAC Registers
+ *      vt6655_mac_restore_context - Restore Context of MAC Registers
  *      MACbSoftwareReset - Software Reset MAC
  *      MACbSafeRxOff - Turn Off MAC Rx
  *      MACbSafeTxOff - Turn Off MAC Tx
@@ -211,7 +211,7 @@ static void vt6655_mac_save_context(struct vnt_private *priv, u8 *cxt_buf)
  * Return Value: none
  *
  */
-void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf)
+static void vt6655_mac_restore_context(struct vnt_private *priv, u8 *cxt_buf)
 {
 	void __iomem *io_base = priv->port_offset;
 
@@ -307,7 +307,7 @@ bool MACbSafeSoftwareReset(struct vnt_private *priv)
 	/* do reset */
 	bRetVal = MACbSoftwareReset(priv);
 	/* restore MAC context, except CR0 */
-	MACvRestoreContext(priv, abyTmpRegData);
+	vt6655_mac_restore_context(priv, abyTmpRegData);
 
 	return bRetVal;
 }
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 1752905d7df0..25247b0bf039 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -553,8 +553,6 @@ void vt6655_mac_set_short_retry_limit(struct vnt_private *priv, unsigned char re
 
 void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit);
 
-void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf);
-
 bool MACbSoftwareReset(struct vnt_private *priv);
 bool MACbSafeSoftwareReset(struct vnt_private *priv);
 bool MACbSafeRxOff(struct vnt_private *priv);
-- 
2.37.3

