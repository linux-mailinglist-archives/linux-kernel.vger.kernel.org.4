Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77766BEDA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjCQQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCQQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:04:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F1E6FCE;
        Fri, 17 Mar 2023 09:03:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so4895440wrt.8;
        Fri, 17 Mar 2023 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679069028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PHX/D9zvMUuUDZPk6M5cJdE4VBkXlkPO0Tq8Iw4uEY=;
        b=bnHr15HqmtE+HDOM4QlDsPZeI9M2oUruac2ILzNvyNQxB6CaHkk7vDqTSBKouq1cGJ
         a7RkWHALslHDZ4KcH8Pt17hXIvhMjcmdHgDK47qYavdJobf1KFoyThdNIm9s1MrrCYYJ
         fTDS8DSJtbgcJv8V74cLt/aFYt/Xv5xlgUJRmIPIS9TsNoa/mk4JzAuksMBEBs6kYAWB
         1rZuQlCJ78Z9zaxb1aLOEMpaFv8/bvTctK1HjvQV9/8jE9diysBeSwFvTn89YJt9uJgw
         veFI7BbG/aVoEmMvvmbK3FtEUSrkw/+VWiHJ6YowKG/8gGaerng+kFZ2e8CRHJQVXSMu
         3oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PHX/D9zvMUuUDZPk6M5cJdE4VBkXlkPO0Tq8Iw4uEY=;
        b=XKrKO2N5WsrnPo1hsGvXlF7aP8qbUMDgeeTaW3MiEh8fGTJMsmWxxxIKTr+QquusSH
         JUnVF/w93rqZFHh1uiAjMQME00gcrFrnBR+cnIUUIzTfFDdAmrAC1xMDWgwjygmNwGjP
         C7Mfjri+Dale1N+0jf5EyV1TETAgBJi81aqvgqls2I2MZS6z85xGOGkTPKl8e3pmpmcA
         +C8RHoyxB92RHxZ+hJX8RfPHHhb2Rjk7P0xcpfopWbv51djeijDrLeS0AwhezphHxD2P
         TD9qokjJxVJIfJoADBK/XU5dUx98duGKgFTGYsQISwrp8DkZFlSI8h+qQjLOLRXl5itu
         YO2A==
X-Gm-Message-State: AO0yUKXO6xwwz2Gt0rVHCbweGGmZoeWZyVJDb+Q+Zw1dVefVHY7m6RgE
        oBhqt1F0gpa0uKDb6P4yMq00AWy40rk=
X-Google-Smtp-Source: AK7set/UszkhlSzys5oh35JLT03OfbPlDigTObehwUGKc9KQXjjSggaC0kYeaf4P71dz4oKz8u4Eog==
X-Received: by 2002:a5d:4382:0:b0:2cd:ddd6:c215 with SMTP id i2-20020a5d4382000000b002cdddd6c215mr7932186wrq.52.1679069028458;
        Fri, 17 Mar 2023 09:03:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y1-20020a5d4ac1000000b002ceaeb24c0asm2291002wrs.58.2023.03.17.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:03:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     coda@cs.cmu.edu, codalist@coda.cs.cmu.edu
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] coda: Remove redundant assignments to variable s
Date:   Fri, 17 Mar 2023 16:03:45 +0000
Message-Id: <20230317160345.421230-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Variable s is being assigned values and it is not being read afterwards.
The assignments are redundant and can be removed.

Cleans up 2 clang-scan warnings:
fs/coda/upcall.c:259:9: warning: Value stored to 's' is never read [deadcode.DeadStores]
        s = ( new_length & ~0x3) +4; /* round up to word boundary */
fs/coda/upcall.c:430:9: warning: Value stored to 's' is never read [deadcode.DeadStores]
        s = (len & ~0x3) + 4;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/coda/upcall.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index cd6a3721f6f6..1870a91eae86 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -256,7 +256,6 @@ int venus_rename(struct super_block *sb, struct CodaFid *old_fid,
         /* another null terminated string for Venus */
         offset += s;
         inp->coda_rename.destname = offset;
-        s = ( new_length & ~0x3) +4; /* round up to word boundary */
         memcpy((char *)(inp) + offset, new_name, new_length);
         *((char *)inp + offset + new_length) = '\0';
 
@@ -427,7 +426,6 @@ int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 	/* Round up to word boundary and null terminate */
         offset += s;
         inp->coda_symlink.tname = offset;
-        s = (len & ~0x3) + 4;
         memcpy((char *)(inp) + offset, name, len);
         *((char *)inp + offset + len) = '\0';
 
-- 
2.30.2

