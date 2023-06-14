Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656272F448
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbjFNFwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjFNFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:52:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730419B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:52:02 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgvh03wrXzBQJYH
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:52:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686721920; x=1689313921; bh=Nv20kQTwcZdEAsdjCJJB4K+xOfi
        bojtHceoQOd15qBI=; b=BhauDtUmLU5GFK77Yz/WrEVEVEN6ND6U/YYGX/is2aW
        mkhmEfZ9v1HvV0TNcDbzLfS86t1vlnjA8uKpBb6wG3Txpr0hvaHr7BWx9UBvRc2J
        Vn6OZ17lK22T9XhiuD23tSF7rKxXFEwh00nk6sTvvvAcuXgKly7CDmW5bjryFJ1x
        +y6AV/B5LBWbqWdsBYfH7kJc9m+dntLiyaMQ/N8nAG0qfNJj8uX9cx0Dd3NoepJz
        i5YfWbCXVSY5dCnkXH5ZuFUqWN+8Q/iLWfcGuUz2/0OYPmiM0XpOzB205xspSRpx
        jU2RM9noqDyEBnYz2UJZBT/UiRMHU2mr//autMfJ2qg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZLa3qs9REX8m for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 13:52:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgvh020JDzBJLB3;
        Wed, 14 Jun 2023 13:52:00 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 13:52:00 +0800
From:   wuyonggang001@208suo.com
To:     Larry.Finger@lwfinger.net, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] b43legacy: Remove unneeded variable
In-Reply-To: <e598894f5a32c00ff905b010bd8e286f@208suo.com>
References: <20230612044742.58785-1-zhanglibing@cdjrlc.com>
 <2caa7e16691b9cecab28aec323785a35@208suo.com>
 <e598894f5a32c00ff905b010bd8e286f@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <5e1b466986b2371f71f99d7123f1de6d@208suo.com>
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
  drivers/net/wireless/broadcom/b43legacy/debugfs.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c 
b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 6b0e8d117061..55a067eaa52d 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -73,7 +73,7 @@ static ssize_t tsf_read_file(struct b43legacy_wldev 
*dev, char *buf, size_t bufs
          (unsigned int)((tsf & 0xFFFFFFFF00000000ULL) >> 32),
          (unsigned int)(tsf & 0xFFFFFFFFULL));

-    return count;
+    return 0;
  }

  /* wl->irq_lock is locked */
@@ -99,7 +99,7 @@ static ssize_t ucode_regs_read_file(struct 
b43legacy_wldev *dev, char *buf, size
              b43legacy_shm_read16(dev, B43legacy_SHM_WIRELESS, i));
      }

-    return count;
+    return 0;
  }

  /* wl->irq_lock is locked */
@@ -166,7 +166,7 @@ static ssize_t txstat_read_file(struct 
b43legacy_wldev *dev, char *buf, size_t b
  out_unlock:
      spin_unlock_irqrestore(&log->lock, flags);

-    return count;
+    return 0;
  }

  /* wl->irq_lock is locked */
