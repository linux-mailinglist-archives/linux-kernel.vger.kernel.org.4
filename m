Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12006493A5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLKKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 05:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLKKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:39:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281032DE9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:38:59 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 142so6373308pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bv6OgzylBOAhKXtI4uy5qdo7KwiUSn86LPOJTHzmP/8=;
        b=JD+35A7u7FxdJRKAxAN5Aw5H5/NKwyXQcmjUbCRGK3yL2fZuX+9suWKrq7QeC/a7Cy
         aYFEySHmz2Kp8ezy2y+A3ilO0gx26J1zWCT0egW5+DeHQ5UAK3kCygflcum1lOYO74jE
         jfSFgLHJT3S4dEwMB88L70DDRMP2O7cDhuD11llWH181mafxy1JvREZrWcIMW9FLAqN5
         2gdqfMci5C0pQA6MeFGRTuZeSRDRJXe/jVaDDPKnYkn9Au0djsKlXYbv1CPA0nUJ8CKg
         AYBoJkRmJ3hYJDCqexGK1ZgNSnUpoHMCCwOjcIYfj4GyW4jQ3Uo1e8J4U4n8ZqI6QS7/
         t6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bv6OgzylBOAhKXtI4uy5qdo7KwiUSn86LPOJTHzmP/8=;
        b=HZt8mMeyUNQNz20iITzRn+s5M8xHgi6J3wr3jR+yu+kQRBTejfdyZdlmYNteEmHSNB
         qjZ+GlMDnpRdaUB49HY3KV+vXXOZBKhNLJ07dH9XGYmuWA9cF4Sy+5gnakIhYSYN/M/k
         CzI4H9BZ+nm14rG7xRy1eS3GabknwziiFlGyNmYsF0RPcRQNKTKbp6+veNUOG3JG4lkD
         efU7mnlSuoAKhHUoLfYyCURkzTsuTOAFPaSmRiMg4vNwD0/42ENxMnzYTUsFTN5sFUwd
         lt9Mno2sfU4qyR/jgdAYpNAM4LBjlIqs1ZmBySPMkOWOk0JVKjX2Gabm1yu8MXI52XHq
         sOeg==
X-Gm-Message-State: ANoB5plxda/OrFN3FUHFdNr+pXm+fGFQbZ841TI8T09K7eAOuwI9Rhhm
        eQGdhyF4CdtHoHgsPfg55dI=
X-Google-Smtp-Source: AA0mqf5PpBO8XrOgDA5cY2ceL3VDkxA4jnaJfXRWLvEbBAeOCk8BjlHWzmrwsja6D3EoMcybHKd3Qg==
X-Received: by 2002:a05:6a00:13a4:b0:56b:ada5:db92 with SMTP id t36-20020a056a0013a400b0056bada5db92mr15683974pfg.9.1670755138640;
        Sun, 11 Dec 2022 02:38:58 -0800 (PST)
Received: from localhost.localdomain ([185.216.119.110])
        by smtp.googlemail.com with ESMTPSA id 23-20020a621917000000b005748029bab8sm3826815pfz.156.2022.12.11.02.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 02:38:57 -0800 (PST)
From:   Wang Yong <yongw.kernel@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Yong <yongw.kernel@gmail.com>
Subject: [PATCH] x86/boot/e820: fix typo in e820.c comment
Date:   Sun, 11 Dec 2022 10:38:49 +0000
Message-Id: <20221211103849.173870-1-yongw.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

change "itsmain" to "its main".

Fixes: 544a0f47e780 ("x86/boot/e820: Rename e820_table_saved to e820_table_firmware and improve the description")
Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
---
 arch/x86/kernel/e820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9dac24680ff8..0614a79c4619 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -53,7 +53,7 @@
  *
  * Once the E820 map has been converted to the standard Linux memory layout
  * information its role stops - modifying it has no effect and does not get
- * re-propagated. So itsmain role is a temporary bootstrap storage of firmware
+ * re-propagated. So its main role is a temporary bootstrap storage of firmware
  * specific memory layout data during early bootup.
  */
 static struct e820_table e820_table_init		__initdata;
-- 
2.25.1

