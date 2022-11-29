Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE563BCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiK2JZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2JZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:25:52 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39534384B;
        Tue, 29 Nov 2022 01:25:50 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y4so12833409plb.2;
        Tue, 29 Nov 2022 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3baCgaNs5Hj1HOYdkfTTsua0OK2W4DrazIX6jc/oXc=;
        b=OKdIuatpQSH+J6N9dvK1dnxe2GwOc6+6BVUXmZLAjdOYDHUBT76QKzX1/yOykZWFCU
         89SagE3TL1c2y3y8e1aj9jkwFlqNx9BXvAWtgW1ZmcIU/x29q+8DvAlhmiGnpBz8J2DJ
         jdgWwfyaVIRKUPwIjhFmNjGDZMXNg4wHBi31hf2ckK6LvDZ1fwoMymeClpVXDaP5VOMA
         PQSsFhZsjyFO2ltsA+Iyasf7GVWs/TM7ix+gKubJmDE2HoiTcv57dDwFhqce6lNUSf87
         zGiAftQVkjVD6wTMoVplT5krqtLEbUkajezjY/dKgvDcmSFuq/ulRgDTVf1Ne0rpelg/
         pW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3baCgaNs5Hj1HOYdkfTTsua0OK2W4DrazIX6jc/oXc=;
        b=zvvbJ3aqIlKEs692iWA1NpePIdnmuoEfpm+BJv9aLg5Vcjf1G/YGuBGcqrB2AQJGv5
         +vXZQyAA3uHn4bcQ6QHiFNXodkm1rZg241Y5+/FxWkhfb1qT2wX25wy73m72rE/Fld+h
         oudSKiST41226ZUDVUFqAzGQn/v6Rpcyns2AQ0Lwf1IG1wHyx2TdMx3PtKCSW/bnhvj2
         a7kECT2aynVmWdIJHVJpU3Z7fh6vIELBEMW0NX1t7bQFotj9mGHCXoCZj4n+0KJsnyRv
         gzm+wzqVt/bXurMrCe7G9nqSOyQcahZQo0d+XKIS0mlf/07tz2Mua0kzyDCDJrojH+LK
         3WvQ==
X-Gm-Message-State: ANoB5pmKchw51LpzAu37njYhu3BpVXwKuCu5KSQxTohq50b10fVGpFuL
        ecnKAamAzCBIuHK7U1llWDc=
X-Google-Smtp-Source: AA0mqf7YBuo0x764FtOodU/l2wB5AijmXuJH+08X4SJ0PENC459pBtGSpxzwmzbWTUbXIE59uVG8rQ==
X-Received: by 2002:a17:902:ec04:b0:189:8c37:6f17 with SMTP id l4-20020a170902ec0400b001898c376f17mr9041980pld.67.1669713950116;
        Tue, 29 Nov 2022 01:25:50 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.45])
        by smtp.gmail.com with ESMTPSA id v190-20020a6261c7000000b00574ee8cfdabsm6006813pfb.148.2022.11.29.01.25.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Nov 2022 01:25:49 -0800 (PST)
From:   korantwork@gmail.com
To:     dave.hansen@intel.com, luto@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Subject: [PATCH] x86/mm: fix the code style issue about "foo* bar"
Date:   Tue, 29 Nov 2022 17:25:46 +0800
Message-Id: <20221129092546.62895-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.38.1
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

From: Xinghui Li <korantli@tencent.com>

Fix the error:

'ERROR: "(foo*)" should be "(foo *)"
688: FILE: arch/x86/mm/fault.c:688:
+		call_on_stack(__this_cpu_ist_top_va(DF) - sizeof(void*),'
reported by checkpatch.pl.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7b0d4ab894c8..3f014cdd85f1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -685,7 +685,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 * and then double-fault, though, because we're likely to
 		 * break the console driver and lose most of the stack dump.
 		 */
-		call_on_stack(__this_cpu_ist_top_va(DF) - sizeof(void*),
+		call_on_stack(__this_cpu_ist_top_va(DF) - sizeof(void *),
 			      handle_stack_overflow,
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
-- 
2.38.1

