Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA9728AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjFHWG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjFHWGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:06:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB1A30D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:06:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb79a17b8so1596280276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686261982; x=1688853982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdKizssFsMQJzj8/wSt0vRuPFuTT8IrX+6c5/ZqQtUU=;
        b=pYi5twzK16pe/u6UpDUsq5/gZ7VstFYaQpSoVInd6hIj+oSGhYPXPylVFxcNSuyTfw
         wCt/PuskPgVKlLP4RTlX1/zs0+7HkXHCX4XS7if1kU6ECFkPaPA6XhFNVqu9JjsX2WO/
         6WqFpH3dBOcrzKhywdtBIapeXoWXFx6aay6wJ/Qn7Ov7MwhcjCvIcth7YseBLy8rA6Ov
         3DWI59xmNFppvf7woPF6SLT4FB7lfdwPzuUsRo9pwvg0hPnS8pOlnHx7+zVUdbb0FVld
         p5m22USbLg8gn8rqzTBnF1FE/reHbyRKFfM6g+eovhC7zK7inCcLfL8yF7dcAeB22C5F
         IZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686261982; x=1688853982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdKizssFsMQJzj8/wSt0vRuPFuTT8IrX+6c5/ZqQtUU=;
        b=WJK81RO4QJxEcIZ+MCCiWKHOKfvFq8WC2NY29gbb9w126XhNE6Q62TC+eVyQBRc6zD
         WL1EJJ7MrZSGQ4rKde3IDYbCrOyMXgPZ7N9b8RPh8uOVTTVi2KIpsBZjjHNqgtc+isjs
         HhCAJGqAwULgD6rwVAVBmxWDZEQO9yZ/3W3j+sXoDxp2aPGFE8HoxS63z1nOIVdIXJ66
         uIaTLA9rF8nRLcfW1BKF/Eudcha05ncl1zkMpxShfOFAiiP2NxmQ7y+L8QmiI2B82dJx
         Dyq9wSRn+RRfLPqCDTmyrA7M4xGvdPT4cPZhwxgoA+F6vwpkr8y4ZCCqT/G2P/MjPeP3
         EdHw==
X-Gm-Message-State: AC+VfDzfrAl3mI8oh0ilHccyRX2NXoNkUwKIq8S3aKDKYd08Fv7O58VK
        5ZtG142shCe63LjdeyqJxh5u9FBytlSsOO/4o8x4Sfv1b9UWi/LMxqcNoGg+737solIfSaDBqUX
        MpOmgdtJcHh9x5XzN7ZiwStYeqkMn3mubHi0WEvCb4pBebtCTjkEQUYsiyIll7+4LIE+Njw==
X-Google-Smtp-Source: ACHHUZ4KfiB8l1+dUoVGrkHr93Y38MLg1AxejqBfztTpsuysMtbSy6a+JxAixUHY2sVHAQ46IvK3wvSRaY8=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5cff])
 (user=ctshao job=sendgmr) by 2002:a05:6902:691:b0:ba8:1f20:ff4f with SMTP id
 i17-20020a056902069100b00ba81f20ff4fmr517992ybt.12.1686261982675; Thu, 08 Jun
 2023 15:06:22 -0700 (PDT)
Date:   Thu,  8 Jun 2023 15:05:39 -0700
In-Reply-To: <20230608220558.39094-1-ctshao@google.com>
Mime-Version: 1.0
References: <20230608220558.39094-1-ctshao@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230608220558.39094-2-ctshao@google.com>
Subject: [PATCH v1 2/3] KVM: arm64: Only initiate walk if page_count() > 1 in free_removed_table()
From:   Chun-Tse Shao <ctshao@google.com>
To:     linux-kernel@vger.kernel.org, yuzhao@google.com,
        oliver.upton@linux.dev
Cc:     Chun-Tse Shao <ctshao@google.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ben Gardon <bgardon@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page table walk is unnecessary in free_removed_table() being called from
the stage-2 unmap path while PTEs on the table is empty. It can be
fast-pathed by only initiating a walk if page_count() > 1

Original disussion can be found in:
https://lore.kernel.org/kvmarm/ZHfWzX04GlcNngdU@linux.dev/

Suggested-by: Yu Zhao <yuzhao@google.com>
Suggested-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index cc1af0286755..d8e570263388 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1319,5 +1319,6 @@ void kvm_pgtable_stage2_free_removed(struct kvm_pgtable_mm_ops *mm_ops, void *pg
 		.end	= kvm_granule_size(level),
 	};
 
-	WARN_ON(__kvm_pgtable_walk(&data, mm_ops, ptep, level + 1));
+	if (mm_ops->page_count(pgtable) > 1)
+		WARN_ON(__kvm_pgtable_walk(&data, mm_ops, ptep, level + 1));
 }
-- 
2.41.0.162.gfafddb0af9-goog

