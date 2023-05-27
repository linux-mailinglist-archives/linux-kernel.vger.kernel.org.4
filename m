Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203DE71348A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjE0LvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjE0LvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:51:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E88BB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:51:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1401429b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685188268; x=1687780268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M60H7z7OzZaor7WG8Tl37IOGxzGrsGYe7qShJ598B1U=;
        b=eLTkkEMv24hkGpArLFJoQSm2dRo2aZ6VF7iXm2+b7wV6soXO3wlvk4dACyXkuo5wzj
         vuxTGec3F8+p6kfXshI+Cmer0dheDH78ZaF4nbnsbJdQmhjUBGsRCGTKiVW1qAqJk/ce
         BgY1TScQx7Pcnp04VaQLX5p0gYxgpX00I4rUQB2f35Mq8hEVwvitmccsFniarnP6Tebt
         5jowgfa2FZmTHAfvtNhaFYi5/IuC7lLzFgD28c6KAAJR0gMqCRiwFV3YqiXa9fHUDU/G
         rlx9pIfLQ/adgoWtN9jbUuS/sfF1LlNEEjOsuXC6TfzolufnWOmobpd1KmgbK+EXucID
         2HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685188268; x=1687780268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M60H7z7OzZaor7WG8Tl37IOGxzGrsGYe7qShJ598B1U=;
        b=kSapwwVlXKLjqS89LMIHzUBBftgKRkhyEfd/BxoL1YE04zLTf8eCDngQKv6TebssOa
         jZJLoqf+5UTFLm8gfBGeSzyhthoeGgQgnBSOYdjPXOIh+xDDEXYMxDiR81lsndLacYmF
         el/vETkTZNt4/TFVoBT52u7pg9+qNddlpVTZhdKRg2zWR/J90Gxpa2fGDg+51P5avKcJ
         Wo9AFHWEjn9VYcWQYXyoZGOjVHtV1Xe4ty7w65m7YyJdpO7ap1/gyEe/GisHdOLvTRc9
         jesLYrYURoW0sOxnKCXXA1ocpnyw3rcXTFX4LomED14BJV2TpV7eFRfZcgvVPLBfO9Xz
         cBZQ==
X-Gm-Message-State: AC+VfDxYFK9Jysnmwg7cxPtVPnEyDUM0hLnDKNx4WKX3K3F/r6kYtQ5+
        aDhPysw584ygVPClFs/Y67s=
X-Google-Smtp-Source: ACHHUZ4QxAWCn3xuC6rLDt7vgW0oNL4lcvxTBwBD3SNf5vot9f+iW9ovjbAY4yk3I+5dfqUN5cCtQQ==
X-Received: by 2002:a05:6a00:cc5:b0:643:bb16:7ca6 with SMTP id b5-20020a056a000cc500b00643bb167ca6mr9083610pfv.21.1685188268122;
        Sat, 27 May 2023 04:51:08 -0700 (PDT)
Received: from redkillpc.. ([49.207.219.227])
        by smtp.gmail.com with ESMTPSA id x19-20020aa793b3000000b0064f97ff4506sm2988098pff.68.2023.05.27.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:51:07 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: [PATCH v4 1/3] axis-fifo: fix smatch warning for format specifier
Date:   Sat, 27 May 2023 17:20:58 +0530
Message-Id: <20230527115101.47569-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZHHE/H2p4Go/Igc/@redkillpc>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an old smatch warning reported by lkp introduced by commit
d2d7aa53891e. In the mentioned commit we had used "%pa" format specifier
for a void* type and hence smatch complained about its use instead of
"%p".

Fixes: d2d7aa53891e ("staging: axis-fifo: convert to use miscdevice")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305150358.nt1BkbXz-lkp@intel.com/
Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
V3 -> V4: Split into warning fixing and cleanup commits
V2 -> V3: Fix smatch warnings from kernel test robot
V1 -> V2: Split into logical commits and fix commit message

 drivers/staging/axis-fifo/axis-fifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7a21f2423204..271cab805cad 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -906,8 +906,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	if (rc < 0)
 		goto err_initial;
 
-	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i\n",
-		 &r_mem->start, &fifo->base_addr, fifo->irq);
+	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%p, irq=%i\n",
+		 &r_mem->start, fifo->base_addr, fifo->irq);
 
 	return 0;
 

base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
-- 
2.34.1

