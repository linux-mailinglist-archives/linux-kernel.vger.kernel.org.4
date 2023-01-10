Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6D664BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbjAJS7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjAJS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:58:35 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4D3896
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:58:28 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b196-20020a621bcd000000b0058a63dc105eso1785667pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aZj5nkPmUZ/+3WFmXIOMi6myvBqiEyZ2i8jBeyd2yO4=;
        b=kNaE2hOuqT1CeKskGFJKoOqj1OzySQvfQXderb/BCwvvYx5sqali1h75XgPDEKkhUn
         VIT5fTYFceymj4MKly4dsmGYvDWMP8DpxCmir5/1KFrjl5S/fR0WTxv9jfUF+acTIsNv
         ui49EcL2pMQodBk+nFC4Q3oGR//qesADTZKOUHNq5sKuEFL55iNAMpbVIj25BCy+XAr+
         HoVRJR/O1nOBZhHQZbbL9+Cz0f52tZQIgSqWtmjeT4AavJb7pCjzOUo8bUIOktA2HDpu
         9SAcCVSZBoVGOcHUMOwpS8hmbKGUgVjMNMFOg2O/zaSSiUG1MbimdKOOqUyOlHXCRVhJ
         5hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZj5nkPmUZ/+3WFmXIOMi6myvBqiEyZ2i8jBeyd2yO4=;
        b=Mnzw/7yhtXB6qoaETtgNaHTfgRHTGkcnixZLLmbbFFG5Dfjs8N6BcujgO2KCP4tw23
         fWtyu9T/pDM2bZAr0WVhr7XX+TJbS9MUK1Es94iNSKWYtcy/P/AZVTb5W+3HJv34rTzJ
         DvyduZZR6ecIR1YW4K13If+4q+/uY1CkBKf7jDzr8SH4vpRjmK1Ly8RFtfuDRKxtyHdP
         fAMk0IMN1KBzNZ3IeRje1kOieynOJXHNqMwYqcheDEV/BAgyWdrVwfWPj5Z46g5Fr6mt
         z8zBkrwIrNczKOyW9K3CNSSaFaGxUM6lrwuww/cUaOOej+9h7RgoXJKgf8xi7ZCkvwLo
         NAWQ==
X-Gm-Message-State: AFqh2kr260ZHu1bIQdbgOmUb53jgb5zn60wzQRzWLz0VFZwXIjwKdpSQ
        ovP7RdLdsUelc8radVmJwSLMozfyjpnQ
X-Google-Smtp-Source: AMrXdXvyoUSwXlUO5pXnq5Ua+mF8JjUX4N0DGfLpaVZ4To5sCi/zqM0lnsKKgUwndriaRWcXrSpxR4UeBkn8
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:e045:b0:193:1c8f:1835 with SMTP id
 x5-20020a170902e04500b001931c8f1835mr899892plx.62.1673377108205; Tue, 10 Jan
 2023 10:58:28 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 10 Jan 2023 18:58:20 +0000
In-Reply-To: <20230110185823.1856951-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230110185823.1856951-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110185823.1856951-2-mizhang@google.com>
Subject: [PATCH 1/4] KVM: selftests: x86: Fix an error in comment of amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>
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

After the execution of __tilerelease(), AMX component will be in INIT
state. Therefore, execution of xsavec saving the AMX state into memory will
cause the XSTATE_BV[18] cleared in xheader. However, the XCOMP_BV[18] will
remain set. Fix the error in comment.

Cc: Jim Mattson <jmattson@google.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index bd72c6eb3b67..16533949a189 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -204,7 +204,7 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_SYNC(4);
 	__tilerelease();
 	GUEST_SYNC(5);
-	/* bit 18 not in the XCOMP_BV after xsavec() */
+	/* bit 18 not in the XSTATE_BV after xsavec() */
 	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
 	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
-- 
2.39.0.314.g84b9a713c41-goog

