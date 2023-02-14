Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E226696D34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjBNSq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjBNSqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:46:23 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E92F78C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:46:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id bg13-20020a17090b0d8d00b00233ee678ea6so2708892pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5nUSaAHTCtcISA3mdIgge3B10pS6vcmVmT5MYhffil4=;
        b=ZTtGmMonLp63QLXd3+qi7ZNjcLN08BBqVEFbE3+QZzT8r/Pvq6CIEIGkJohT90B8R6
         Bjpx1TI25787jVCqUdpEHMgeHJvFIM+nIpyq8XN3inXL4spBTFSwqXwQZnhoZiBQzJO6
         TN+GES4KnuSQWeoAnQ4EAPgfIVhNAudXijByl3hE8hl2j4fi1LWLZYCYu9CdvXUxaZ+u
         whraXb0fPSbe/bqB67ELNCxCUtB7C5sm77ANXkef5sRLCRoQqMBaN9IQ5ZVI5yJYOoTD
         LYXZbCC5CA9silAM3ISnSO2mnYZASaUQMaJVmym+J7JMADsXMw8yOX1wcizMa5EDG6+W
         muJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nUSaAHTCtcISA3mdIgge3B10pS6vcmVmT5MYhffil4=;
        b=gT8/xrO/yuIYbCzvX5zbUbYGZoDN5hlGZdAe2VjAZJezUEMo9P4NN2WHkEb4J9YbK5
         VU6jfXAXeXp4ypi7O9jyf/FzwwQ/FIz3n8hnJSt0yL3sifBwHAOTX3muaFDF491GOqkd
         nTXojGxpOdq71PeOGGnTM5oOczakv/VXeFFU8q1EsJTeLd5SAm4e0f1uK4lNWFGkp4N5
         qXLHDYcQ2tuvr21CGT7bleFj6MgYgVZuqcJ/56pkYZUc9fZS6lzK/YKI8dcnCxGt9ZX9
         oBE7hNvFPzYpS/6MF9+3erAoO3Bz6lZ9UMmTzSAZONh2k2ekCb25D44GQePcr6DDBYpv
         ecAg==
X-Gm-Message-State: AO0yUKV5AD0cSMK3OXBn3d01iSZj7+rjk2YHM5wzVBuJp0h3P8fDO6lh
        X2q+QOCy/sFAJt34doqyHenXu1TtK7Yb
X-Google-Smtp-Source: AK7set+TikdqMEeRUvVc4ODDzinFrSvu9UtzSrnUkSE7ruTqGTaliOA/CLOW87EdIftH6vdxa9RhB7caRSYZ
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:6dc7:0:b0:4fb:ba81:7143 with SMTP id
 i190-20020a636dc7000000b004fbba817143mr63323pgc.0.1676400382093; Tue, 14 Feb
 2023 10:46:22 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 14 Feb 2023 18:46:01 +0000
In-Reply-To: <20230214184606.510551-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214184606.510551-3-mizhang@google.com>
Subject: [PATCH v2 2/7] KVM: selftests: x86: Fix an error in comment of amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
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
state. Therefore, execution of XSAVEC saving the AMX state into memory will
cause the xstate_bv[18] cleared in xheader. However, the xcomp_bv[18] will
remain set. Fix the error in comment. Also, update xsavec() to XSAVEC
because xcomp_bv[18] is set due to the instruction, not the function.
Finally, use XTILEDATA instead 'bit 18' in comments.

Cc: Jim Mattson <jmattson@google.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index d506821a5a26..aac727ff7cf8 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -190,7 +190,10 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_SYNC(4);
 	__tilerelease();
 	GUEST_SYNC(5);
-	/* bit 18 not in the XCOMP_BV after xsavec() */
+	/*
+	 * After XSAVEC, XTILEDATA is cleared in the xstate_bv but is set in
+	 * the xcomp_bv.
+	 */
 	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
 	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
-- 
2.39.1.581.gbfd45094c4-goog

