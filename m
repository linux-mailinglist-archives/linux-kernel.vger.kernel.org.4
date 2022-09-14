Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605325B8226
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiINHmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:42:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CB72846;
        Wed, 14 Sep 2022 00:42:43 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r134so11575963iod.8;
        Wed, 14 Sep 2022 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eEJP1a06euOUkeamXUOBqTVk6cOzV4UikY8/ESrIyRY=;
        b=KOphLKJ3+hwlS6nZaQ4YEA0WaQfpIP4XVSCk1gIwY4I/17KYNBpXa7+Bk41lcTHsVS
         ZwjbzBd9qUJ0hBUquLvBoWFVly0FkaxNJptwExzGQx7KuMMT4yFwIbf1CoDjq+oit28I
         DnDSCWJnEQcluOwuex4ehfcZXqe3BerrYpWmMDzFeipmgtQiHV35iHipca/iIyeBIHfI
         mxkT8gmtayt+0VGLLwirfWMYdCVTFb31NodwgYyyWITSWqsySkQeqLjnhYbCwXFL2/9Z
         Aw3f5NIle1O72sULU1Xq2q4d0AiI74H+f+xNN4pkGwqCHKFHXeBmXWlFrqN6qnC6SbJB
         zudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eEJP1a06euOUkeamXUOBqTVk6cOzV4UikY8/ESrIyRY=;
        b=H1xftIt6vGlHVU0zPYqfsNKLToNKv7AIbH5IMrd38PJ7HIF+US8krgVe4CT+1jaaF8
         H6WoW8AVKe6Chj3yk1TXiJ/XUWhIJmTJRWyDkZFLjrs1s6vQgS4phXIhL4pSIntfN/hI
         kKFfwUmxzTpD065PPa9LqsOgcwg9H05oNRxLZMey8H0nys+u/tBae+jDKt9oUlmRUduM
         QtSZHvRMUSKymFdCgQpvviAZagpoGJCnDkQrswd5UUnLvlR0cqLPtXw3+DTt6dWLCSDK
         utun2z1GJZUB6qXeJa1KyxAQ3Bqsf8+LjdfX34LnGDpTRQt6Is92X+48TeVS+LqtN6El
         kIUg==
X-Gm-Message-State: ACgBeo3mfcnDMKg1H+ja8S9wcOxM3lPG1hyuhXK4qBdu8YQImGEHgiub
        5RixKlt5X5nWmWr6jKO/TGp8VzplawgaQHHv
X-Google-Smtp-Source: AA6agR5WbiUDfLzu/L1mNDFsxGgK5mjvbfR77vgsTVPDCICbJExWvVAPbmqL7WG9vyDLx7N3g6V3Ew==
X-Received: by 2002:a05:6638:2406:b0:349:ffed:2310 with SMTP id z6-20020a056638240600b00349ffed2310mr18412937jat.78.1663141363148;
        Wed, 14 Sep 2022 00:42:43 -0700 (PDT)
Received: from pxchen-personal.ics.uci.edu (dhcp-055171.ics.uci.edu. [128.195.55.171])
        by smtp.gmail.com with ESMTPSA id w18-20020a92db52000000b002f163ff9df2sm6261061ilq.19.2022.09.14.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:42:40 -0700 (PDT)
From:   Ping-Xiang Chen <p.x.chen.1005@gmail.com>
X-Google-Original-From: Ping-Xiang Chen <p.x.chen@uci.edu>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Xiang Chen <p.x.chen@uci.edu>
Subject: [PATCH] block: fix comment typo in submit_bio of block-core.c.
Date:   Wed, 14 Sep 2022 00:42:37 -0700
Message-Id: <20220914074237.31621-1-p.x.chen@uci.edu>
X-Mailer: git-send-email 2.34.1
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

This patch fix a comment typo in block-core.c.

Signed-off-by: Ping-Xiang Chen <p.x.chen@uci.edu>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104c5590..7a7e89453935 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -814,7 +814,7 @@ EXPORT_SYMBOL(submit_bio_noacct);
  *
  * The success/failure status of the request, along with notification of
  * completion, is delivered asynchronously through the ->bi_end_io() callback
- * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
+ * in @bio.  The bio must NOT be touched by the caller until ->bi_end_io() has
  * been called.
  */
 void submit_bio(struct bio *bio)
-- 
2.34.1

