Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB466456C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLGJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLGJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:45:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75415A0F;
        Wed,  7 Dec 2022 01:45:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so625912wmb.2;
        Wed, 07 Dec 2022 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhPsMqZpZxSN/BwbeQUCeG26h3GFjHPuzh8scMwphDI=;
        b=eAU1K6LSpOLHvC0r3qoqG9e/NJZgJZD7e2cMzgDIlpSESzjvwDFVuuRDWwUxCF7P0C
         oJKVSp/EYncgL725eZmapyJB2fyG6KkkDbbbccPZV7upUopmbPqOSZ9BYAE2uWTUwVTn
         IMQ3tc4F3VKqW/Spev3zABaEvvCWyxE3/NAC2KWF6mickj+IZ7EHKQESfgE8GTdHA8ut
         44WRgA+w650jVgaWBxv1ZZLAqmfKuKS1RZ4tOrA2s62nHeBJ0szofby7Og6EVQS1LC4E
         CeBS7/wymP26FRSW6JIeWVh8w4qbkgYe4Iy1+tcFatykZkB1OzrEC26y3cmWakelfzoL
         8Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhPsMqZpZxSN/BwbeQUCeG26h3GFjHPuzh8scMwphDI=;
        b=Flknt4+OGJfybUAJSFuhINk/UIV7rAFHAQrBKAIeHcCWnhSDn8E08GBeHkvGsfoRhe
         BSzzueG+OOHbkE0D8NquiBu0ko3Hn/HB0fQ1xFeirrDT3wzvxheBU6sslolAYVKzuG81
         aZtD8jqp26nD2ImRG+WtaHEhbtQ1AnBYZ315QEmXNViATBbs2ME+yhBsQcjzeosqBHDH
         /0jp+6ICSWcu/IqaZZWWA1SEmp3pBpEcyctocymObjQZj4HFFWQvGbknT+EXp+nvUOkF
         p8bRMHl6t1GxeF/IYCvfNve9W1Vk8fNjhMdhUZP3XoRGZSLpXo5CYQ8HswETPZtiH1IC
         /MuA==
X-Gm-Message-State: ANoB5pm2nTYk3rClvK77tEQbD1BXLMqf8vW8rAD/aBDSOCgFsLtUjOoA
        MQoBkigdrrcyqCQyXQMSexo=
X-Google-Smtp-Source: AA0mqf5qAxMIKRUoubYZeX4bdYOYmEnjU7tK3LlnDtWfv5fQZI8kahnbNZjgvI8OgV50bGbE8yFhpQ==
X-Received: by 2002:a05:600c:295:b0:3d1:bc4f:7d44 with SMTP id 21-20020a05600c029500b003d1bc4f7d44mr10246644wmk.127.1670406313408;
        Wed, 07 Dec 2022 01:45:13 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b002421888a011sm18979019wrn.69.2022.12.07.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 01:45:12 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Fix spelling mistake "teh" -> "the"
Date:   Wed,  7 Dec 2022 09:45:12 +0000
Message-Id: <20221207094512.2281808-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a WARN_FUNC message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be739f4f..71d6e9b85217 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3859,7 +3859,7 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
 		}
 
 		if (!next) {
-			WARN_FUNC("teh end!", insn->sec, insn->offset);
+			WARN_FUNC("the end!", insn->sec, insn->offset);
 			return -1;
 		}
 		insn = next;
-- 
2.38.1

