Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CAF6663DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjAKTlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjAKTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:17 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D739F81
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 69-20020a630148000000b00478118684c4so7166711pgb.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAwKXq7cYddg0U2Li5LgdX400am5U2qQ139d3hoxgps=;
        b=fcv4l67oQghu07W08EOfE2q55pi/AAElyGc/+YUBryrv1ZpXqqG3duinf/ZQdRRysl
         cIOUUzl+ZhbFPLzT6cN1pIG1vDRzqCYg6GlwujdoYpsheXOt0rF3htOpxRvVHNnPD3E+
         IlmsafzS0cmE06N0ye2e8x/gwqzELQn2lP743UKrm2jfglkG6u89tUHod5a21/9AacGz
         ub3LOFs706BupAiCg0qTBK5OqKRk1vteM3z5DlOUCbzJ1v14nimy6GuRqfz1jZeHWQmd
         BjsKrsD991JPcG9ydjWMOeWnX1ofU0KOtnESa0NwFSgmbOJNevovv4WnTFIPp9Cd7sd9
         C7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAwKXq7cYddg0U2Li5LgdX400am5U2qQ139d3hoxgps=;
        b=Ewe/Wcp1bmfec2VemG0xJdArsi9BxY3agEq0UcEmPn9gWx6q4BIP7mLTLS5XYHEPqW
         jJPgih6zzAygiUdl+rYuRHAO1KZe1rVr1vTk61CN7Dnqx4MuT4VB8RVfA11FcKA4op4p
         JqFei3FjXeDmp04bChZkNXBZiUDbeZVA1e9hQQAP+6SUxqmV2AXEqmnlO1S3BsSt3JGG
         rCGH7I3r0B/5SlmCnV7ux98YdUkZDpWyj6jOnNk1bqk6mRdchiHg0jXXbZotOHAEkV4L
         Gr0vd4bKIXGm0jMT0C+xB57qXlxnVp+3+xFm6IfRk/3ALFnMD/DTYa9Io6u1nvUahN4X
         QLmw==
X-Gm-Message-State: AFqh2koUOv1u7WuUdRMgtQ2F0YenbPy377Oz6JJrmCmpqPAbUXInYzgI
        Rl3KiCXklAMBTQ1SimZP2NHqBS5pqR5DNynISoYQHDf6BuTXxESYc1mPREHq/1kSUHoZh3g30zg
        bN2C76s7RMZc6WoxtOkSMq73aasfTpFC1lADKzM9N3geynLA4Zkkx/2JJdIXI1AHCMz2acbGGEl
        SBrYZx+/M=
X-Google-Smtp-Source: AMrXdXvNvpVzfSaRaNYlqeW5e6YuBS7ISmwdDLoeKAbkIi6xZcJk2BmbW2jmOFN5/JWEmPRA1c0QjO/79AxLHEgEKQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:d550:b0:192:94cc:e39e with
 SMTP id z16-20020a170902d55000b0019294cce39emr4809880plf.155.1673466011165;
 Wed, 11 Jan 2023 11:40:11 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:39:59 +0000
In-Reply-To: <20230111194001.1947849-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-6-dionnaglaze@google.com>
Subject: [PATCH v11 5/7] x86/sev: Change sev_guestreq_err_t to u64
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of changing the signature across modules, this step ensures the
new type will continue to compile before the typedef is removed.

Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b03ba18fee7..301e3b69f477 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -137,7 +137,7 @@ struct snp_secrets_page_layout {
  * Use a type alias temporarily to cleanly change the snp_issue_guest_request
  * signature cleanly over multiple patches.
  */
-typedef unsigned long sev_guestreq_err_t;
+typedef u64 sev_guestreq_err_t;
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
-- 
2.39.0.314.g84b9a713c41-goog

