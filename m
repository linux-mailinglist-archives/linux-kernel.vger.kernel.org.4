Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBA62C5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiKPRD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiKPRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:03:45 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3515A1E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:44 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id s15-20020a056402520f00b0046321fff42dso12723463edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZfWEaD62D9o2yY+d8fPCV/TvX2mmnJ/lA4TWGZpU/Y=;
        b=owF7hcDYc7ARmaK3i4us45Buk3Hh4AaTv5/+cKPRjHVZDIsgAhyaaD8kUAeUCfxSO2
         i34X8FsVMm6muOHaIq3236zRzgJxUIIVryWbc2zaClYOFG+cg2kubcLxii5YzeBJ/Wrb
         6XN+W6iPnAXY4mwrIR2eERMKLpuNuF2/WSzaFKJUP5zVeqebPik7UrCEc8nmyl9o+/QX
         rVi4S1f2Bl6lq9gEqZHRpokRv9qHjUua4dbVaLgePsKR8mzYVbxv/j24DM6IAAtCetIJ
         e+axcpBqUiKKMYaoUZeUmyYLnvJmFgcHinFuYHvL3lHYSGhSKFyJRdi9y+aYHde6hcCU
         BTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZfWEaD62D9o2yY+d8fPCV/TvX2mmnJ/lA4TWGZpU/Y=;
        b=RHZNQQuYWl1xqduzxPV9ivDuhQTyVc48jP18uLN8jkJ1wmVAAF6WcLmjQXZL4w8Rth
         tcuJ9GSIBsMZ13YOQew7YNHj59xAjgo8xOkSh2K57eqDp5V7DdZjOjKQYl+C7p7gyfwp
         I567HIHIwky0xJvc0Di0gztPzNn+xcJj3Ko79UWMXBjuu5oIwgcIBxrPA9ZvVBfSEPoO
         Z3KcnOTIDYwtw38Cfes0ypiSnbUiEZ4+g4eqA3pjEwo+r2bJ0LPF3xkIAMYH7KpKbS8e
         zl9+k97HF5if7xqRxTQnjB4VE9vmuzKRxHWANdREn2ZUTSCwVl0ueiGW4YWMR/15fCQN
         ClCA==
X-Gm-Message-State: ANoB5pkrJE/LkQ/EQK73ulIl5Fvdeg2m+5R68FwCKmFHgTliAPuaK1/W
        hAp4pV2ET+dRw9/cipr9LpINlTCOyLBA
X-Google-Smtp-Source: AA0mqf6QO3MDsO7JzLptdiGQKZSsnQfuLfYcQHIY4zJIFRNqovseLoflW/BcyRmShwPFqqN6vg48qiCIOxkh
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:907:8c15:b0:78d:9e04:d8c2 with SMTP id
 ta21-20020a1709078c1500b0078d9e04d8c2mr17680562ejc.614.1668618223040; Wed, 16
 Nov 2022 09:03:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:25 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-3-qperret@google.com>
Subject: [PATCH 02/12] firmware: arm_ffa: Move comment before the field it is documenting
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com
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

From: Will Deacon <will@kernel.org>

This is consistent with the other comments in the struct.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/arm_ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index daff44d777fa..c87aeecaa9b2 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -244,11 +244,11 @@ struct ffa_mem_region_attributes {
 	 */
 #define FFA_MEM_RETRIEVE_SELF_BORROWER	BIT(0)
 	u8 flag;
-	u32 composite_off;
 	/*
 	 * Offset in bytes from the start of the outer `ffa_memory_region` to
 	 * an `struct ffa_mem_region_addr_range`.
 	 */
+	u32 composite_off;
 	u64 reserved;
 };
 
-- 
2.38.1.431.g37b22c650d-goog

