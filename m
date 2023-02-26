Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD06A2FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBZNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:34:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D632113FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:34:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i5so2418478pla.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z78SjOk/k03WYB7CJ5uRFHoK2AySrR3qvUt493wtnY=;
        b=k1wLDiepy9Cc0cSjgunHysVh4L8B7sk1mLB2epfI5aU+TiQ2lo1e+LTALzdt/kabAa
         nawkWR1DGaoA6aXGZkp0x5YaxfL/hGNtNODS6mOX4kDSASG7WaiWgGVU5oFnYtBaiKfy
         Aa4LdIUlROsdJRF6Af7KG91ufCLll7R1HkaSTZabFbDLLFdzKb9qBIEMgUBuz0OmD3Wu
         RVEpK3DrWhmfmmsIqVOllGY6kmYse2aMC2rLdq3G46kr7jztLo5e+M13UgPRBuMKdAvu
         b1ApJAiDaQAUGaVDn0ky+c7Lt/9v2XPH+56iweUIZBoJY3jNVwpKJhEeW/SijL+bwMeg
         THRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z78SjOk/k03WYB7CJ5uRFHoK2AySrR3qvUt493wtnY=;
        b=kVtpOhybR+/rcqQUtX9GsnBNORr5L/B2YEUQAnSgLJ2M/jzW/Ny7nuHi/sIWxZp3SZ
         nCzB95hRvJUye64XcgY/C70RBhLLHsjTkRU3fQBYj1cSXLwVwPCLvjyvYGmJlHHkQoP6
         nwucEixOXBNKaJ9OK8pKKbSl35/fc8ujX1ku1UnvSZybsuA5dbOaZC35uV5zy+A4lAtk
         8/gq2aiIr2rD3+BZcXupsgeQ48bIQupaY6+SZkyu/sSJGDXMhv0mi52k8zDRKTgQkZ2d
         ZAib46wyLFvQTJ7jWcIhZ1EaEbdhwtUCisuiaHs7myeBF+bqUscOUE+Gw2kHjls8PEPt
         /ihw==
X-Gm-Message-State: AO0yUKUaVghnXZZCTqqPrQxMxuDbkzGi5T+WP7T4N4dual7GviwXvMHj
        0GsJ20CUF27fI1R9iSiy+Bs=
X-Google-Smtp-Source: AK7set908GPWLSLvg8NNt2V9uR0HJjhY7jxq9d3VJxmFsFO/mETCnwtdTKW286228P2YCkHxItkcgw==
X-Received: by 2002:a17:903:41cd:b0:199:1b8a:42a8 with SMTP id u13-20020a17090341cd00b001991b8a42a8mr26128915ple.6.1677418447827;
        Sun, 26 Feb 2023 05:34:07 -0800 (PST)
Received: from localhost.localdomain ([199.101.192.172])
        by smtp.gmail.com with ESMTPSA id jb21-20020a170903259500b0019abd4ddbf2sm2668787plb.179.2023.02.26.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 05:34:07 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: pcmcia: fix a typo in pcmcia_request_irq
Date:   Sun, 26 Feb 2023 21:31:20 +0800
Message-Id: <20230226133123.3180376-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.39.1
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

There is a typo in the comment of pcmcia_request_irq - themselfves.

Fix it by changing themselves to themselves.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: change the title and modify my email.
 drivers/pcmcia/pcmcia_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index d78091e79a0f..e9e31c638a67 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -684,7 +684,7 @@ EXPORT_SYMBOL(pcmcia_request_io);
  * pcmcia_request_irq() is a wrapper around request_irq() which allows
  * the PCMCIA core to clean up the registration in pcmcia_disable_device().
  * Drivers are free to use request_irq() directly, but then they need to
- * call free_irq() themselfves, too. Also, only %IRQF_SHARED capable IRQ
+ * call free_irq() themselves, too. Also, only %IRQF_SHARED capable IRQ
  * handlers are allowed.
  */
 int __must_check pcmcia_request_irq(struct pcmcia_device *p_dev,
-- 
2.39.1

