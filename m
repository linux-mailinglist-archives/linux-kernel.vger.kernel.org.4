Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85C72F713
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFNH4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjFNHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:55:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7A19A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:55:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgyQT6N9gzBQJZ2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:55:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686729329; x=1689321330; bh=dS8vnxgH8gji4XEQkFCndZks/HB
        FYJuzJrwrDwTtmrM=; b=M5/nEMjpHsBJXwdr954RZPBFmxqyoQgG1vDUjkZrqg9
        1Woh99laCh/B2o5W8oACSMJ/3DdcZ2Q1j9YcAt4fK3nW4ImrC6Mr27Bj+L86Njt5
        IXsmop9e6d8DX+wDNGPCBVPomEr1ihr/tlk7wkTtZDzv+d37dccr8RZN4vneEmLc
        sEdvYlEfx6vD09Hag3MCiGH7Ph7yRvQzsVISvIeJ9swXV3jpf+CmDXMXu4u+lkRO
        fY9uxdHw2TqLp02X8ylE11VUvwJ9Zw4nCG/SwGH4fBQLEx3ZL0tpalJ97PzSFuCU
        J0jzlUhh/KX6oRNpZ5ckggYETN1MFMAoWpaXCdGrwhQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kdxaCsDrVWTv for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 15:55:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgyQT3m39zBQJYq;
        Wed, 14 Jun 2023 15:55:29 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:55:29 +0800
From:   wuyonggang001@208suo.com
To:     Larry.Finger@lwfinger.net, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] b43legacy: Remove unneeded variable
In-Reply-To: <20230614075250.29097-1-zhanglibing@cdjrlc.com>
References: <20230614075250.29097-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <194e8e87fda5f02664fcfac3717458f2@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/net/wireless/broadcom/b43legacy/debugfs.c:68:9-14: Unneeded 
variable: "count".

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/net/wireless/broadcom/b43legacy/debugfs.c | 9 +++------
  1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c 
b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 6b0e8d117061..184b0b4bdd94 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -65,7 +65,6 @@ struct b43legacy_dfs_file * fops_to_dfs_file(struct 
b43legacy_wldev *dev,
  /* wl->irq_lock is locked */
  static ssize_t tsf_read_file(struct b43legacy_wldev *dev, char *buf, 
size_t bufsize)
  {
-    ssize_t count = 0;
      u64 tsf;

      b43legacy_tsf_read(dev, &tsf);
@@ -73,7 +72,7 @@ static ssize_t tsf_read_file(struct b43legacy_wldev 
*dev, char *buf, size_t bufs
          (unsigned int)((tsf & 0xFFFFFFFF00000000ULL) >> 32),
          (unsigned int)(tsf & 0xFFFFFFFFULL));

-    return count;
+    return 0;
  }

  /* wl->irq_lock is locked */
@@ -91,7 +90,6 @@ static int tsf_write_file(struct b43legacy_wldev *dev, 
const char *buf, size_t c
  /* wl->irq_lock is locked */
  static ssize_t ucode_regs_read_file(struct b43legacy_wldev *dev, char 
*buf, size_t bufsize)
  {
-    ssize_t count = 0;
      int i;

      for (i = 0; i < 64; i++) {
@@ -99,7 +97,7 @@ static ssize_t ucode_regs_read_file(struct 
b43legacy_wldev *dev, char *buf, size
              b43legacy_shm_read16(dev, B43legacy_SHM_WIRELESS, i));
      }

-    return count;
+    return 0;
  }

  /* wl->irq_lock is locked */
@@ -125,7 +123,6 @@ static ssize_t shm_read_file(struct b43legacy_wldev 
*dev, char *buf, size_t bufs
  static ssize_t txstat_read_file(struct b43legacy_wldev *dev, char *buf, 
size_t bufsize)
  {
      struct b43legacy_txstatus_log *log = &dev->dfsentry->txstatlog;
-    ssize_t count = 0;
      unsigned long flags;
      int i, idx;
      struct b43legacy_txstatus *stat;
@@ -166,7 +163,7 @@ static ssize_t txstat_read_file(struct 
b43legacy_wldev *dev, char *buf, size_t b
  out_unlock:
      spin_unlock_irqrestore(&log->lock, flags);

-    return count;
+    return 0;
  }

  /* wl->irq_lock is locked */
