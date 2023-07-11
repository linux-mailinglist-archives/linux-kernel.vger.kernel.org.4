Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D358174E374
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGKBc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjGKBcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:32:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16427E1;
        Mon, 10 Jul 2023 18:32:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-682a5465e9eso783651b3a.1;
        Mon, 10 Jul 2023 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689039171; x=1691631171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mZl1Y9YHRHZRxB2AgpQIwspSSAT36JhGWtaQr0C5zk=;
        b=ORPjCFvSenYCY96eSBT3Lb+fHoeLz5RxH+MrnS5b8QRje+4nlRZJYHVnyXnae8CNTn
         ytX+J7gdtvUwRzHAfgLtAgAA9Drdzn5PCjgbtIF96v8QZs5a4xHoYYx8WpBWQ34ZUHTc
         OQa0W0ppiu7SXiKx7fchmi8v5W9Ms17wO5pHt43/NgIgUDgaJgl+xuRLMTXJwpaz0DfS
         Q+cO7UYMYDr5Q4kfu9UqRRHGxSJq14lFmFej1RQquZWaeNseOD5PpZYvaqTJ0ka5A0eZ
         lSGgC+w68RbLlJrMDOMPoQIY8bmG/u08+Zkzq+5v3F8up7d2RSVcrqGMv1ZhW4ZImXus
         odyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689039171; x=1691631171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mZl1Y9YHRHZRxB2AgpQIwspSSAT36JhGWtaQr0C5zk=;
        b=byAj2HN6pNdRSDZ5U4tVYPZEznXoMiMu9myAr4OY6Xba4qMkRoe6skcCwPoirjmlVs
         JN0ixj43WQkEkuyK1t2AF1kMGk0Oh8bu2CROuuTsTZ9tFQByPDngXqGwsdafM2h2VfBV
         1fAs7i7oy0DQQftA/aIjh6+pYhgMIDtqMHppuprIgkRlu+xQZGHxlT03GUy60rb8W6w5
         gH/o2ubjeZZ2iwf0RDcGOdiUy5+Xg80sUrYTITvu2hUWEYtGapQ9KenuCoFcKdIoTZCv
         nW13FKjucWlhcA9R7a7qmojQQcpJd7ZsGLf/6wwmUhmVxZyNQgTVKYpGsUMTphIXXHcP
         qOuw==
X-Gm-Message-State: ABy/qLbbR3o3uXI8pYt96hU0Mkvp2v0a3PPuZG4nS9MQe1OI6RL3za9a
        rEIU/TZolmkiFEmfI33LMcI=
X-Google-Smtp-Source: APBJJlEGaYXJ5KHiZsA8LKfZ2cmcSR5WIWjv2TGSMfH74oHT48AWQyVZa6UpAh9EZCWTtRzQUvvYZw==
X-Received: by 2002:aa7:911a:0:b0:67f:ff0a:1bbb with SMTP id 26-20020aa7911a000000b0067fff0a1bbbmr14347641pfh.1.1689039171267;
        Mon, 10 Jul 2023 18:32:51 -0700 (PDT)
Received: from localhost.localdomain (sfosm0151r356001-v22.wiline.com. [67.207.106.98])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b005533b6cb3a6sm341815pga.16.2023.07.10.18.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:32:50 -0700 (PDT)
From:   Suhrid Subramaniam <suhridsubramaniam@gmail.com>
X-Google-Original-From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
To:     mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     suhrid.subramaniam@mediatek.com, suhridsubramaniam@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2: Fix documentation for 12-bit packed Bayer
Date:   Mon, 10 Jul 2023 18:31:40 -0700
Message-ID: <20230711013140.54080-1-suhrid.subramaniam@mediatek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix documentation for R13 and R33 low bits.

Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
index b6e79e2f8ce4..7c3810ff783c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
@@ -60,7 +60,7 @@ Each cell is one byte.
           G\ :sub:`10low`\ (bits 3--0)
        -  G\ :sub:`12high`
        -  R\ :sub:`13high`
-       -  R\ :sub:`13low`\ (bits 3--2)
+       -  R\ :sub:`13low`\ (bits 7--4)
 
           G\ :sub:`12low`\ (bits 3--0)
     -  -  start + 12:
@@ -82,6 +82,6 @@ Each cell is one byte.
           G\ :sub:`30low`\ (bits 3--0)
        -  G\ :sub:`32high`
        -  R\ :sub:`33high`
-       -  R\ :sub:`33low`\ (bits 3--2)
+       -  R\ :sub:`33low`\ (bits 7--4)
 
           G\ :sub:`32low`\ (bits 3--0)
-- 
2.41.0

