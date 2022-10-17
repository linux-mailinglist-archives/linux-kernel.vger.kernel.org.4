Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA038601B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJQVqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJQVqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:46:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C2537DB;
        Mon, 17 Oct 2022 14:45:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e18so9529047wmq.3;
        Mon, 17 Oct 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uDQuZwzo8ELXCtlKXNYuUjmw+3bm3im788MAm8jYBs=;
        b=Uk0tqnyb8+JwEIHf+RNdauBGjoxKVqRpH7RyAnm5PNtqwDr/3Lfy974v6M2TjJKA8n
         Zg25S7/LnWMPgGvtaDrGEawiYH3LYzvIq6TLNeX1eWxRoJAb9ZJsYysgZJ6pO27mI3/W
         09q971jtUU2mm6pw7RsMzS7fbIR6cul9O01Xstw0LVerNs1NmUjxS6tb/ZlxSI6FV4Pr
         YT1mqX6VZIkZGKbaIbrgF8VkOjb0fXfTzAjK43YRSwN8pMzfb9Ktbwjp8aqKvmrGjFLZ
         zCs5o8gJAY0oXHKPq8U4z7wSm/9xyOfIurI/9eHaOq06SlQwKovmslbMfxWZmXfvsuYu
         LgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uDQuZwzo8ELXCtlKXNYuUjmw+3bm3im788MAm8jYBs=;
        b=DizHCdMXbEY0aV2cNSA+dRRWWXaXXlsmG5QFp2h2ZcqGB3NQzVrgOpoZnBnzgdGe4f
         75GGCun9VcKz7uqgpd6b0ZwsrckHYEB68WZpDAS8zFUcRbJc25Jj6cmfoXJ/qNm7CfMc
         qA1qkpXwRQwy40LNY1ucvT/EYTyydHRim2ctPnvzHnHFYUvIXgmk0agtd10zQI/PrSLH
         lEjFtm2JlQQW7ENXSqcURQKzM1vWTUknPkrGNSitfJWE0PNEXlGMZvnuljHtqyXm8uEp
         OrNkPLT5F8O4Bd/XpS/jlbFffD04yAO46wVHIfzEM8K/erkkr4LIPz0dx1IRSnnub6fO
         GZJg==
X-Gm-Message-State: ACrzQf15jJjcsOJTV++lPo0Opk6diFy8pc2cPSZ4sufKcoWEW1bgjHgw
        C6ZVu/MGSfcIdX2pwBnsOw7fQwj2q8zWvA==
X-Google-Smtp-Source: AMsMyM7EpmP3njOFcpOxsSAZjeSBjRG0tjpmFIQweEHhLba5eIp+pCO3qAlygZIwsHWlUT/fK0pVbA==
X-Received: by 2002:a7b:c841:0:b0:3c6:ce2f:3438 with SMTP id c1-20020a7bc841000000b003c6ce2f3438mr8838231wml.51.1666043157943;
        Mon, 17 Oct 2022 14:45:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5603000000b0022aeba020casm9270841wrv.83.2022.10.17.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:45:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib: remove redundant assignment to variable num
Date:   Mon, 17 Oct 2022 22:45:56 +0100
Message-Id: <20221017214556.863357-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
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

The variable num is being assigned a value that is never read, it
is being re-assigned a new value in both paths if an if-statement.
The assignment is redundant and can be removed.

Cleans up clang scan build warning:
lib/oid_registry.c:149:3: warning: Value stored to 'num' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/oid_registry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index e592d48b1974..fe6705cfd780 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -146,7 +146,6 @@ int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
 	bufsize -= count;
 
 	while (v < end) {
-		num = 0;
 		n = *v++;
 		if (!(n & 0x80)) {
 			num = n;
-- 
2.37.3

