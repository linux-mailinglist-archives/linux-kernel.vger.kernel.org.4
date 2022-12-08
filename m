Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D774647543
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLHSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLHSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:03:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDB5BD60
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:03:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5459620pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=riLhoP57eVPqwj4BrvS8Vazxssa2eImOkYsWKI1T0t8=;
        b=iViaYugsyY36Co7pKi2yW3+3twUOGGTtNqIFgF0+7MBH5JAuAvr7KaDfROp3l9GO1t
         Srqh6rR1dXZMZbpBUXgZqXAo4mtoHxV4pakZa2i/mghgx0d8YgDWCqTQH6v3TePUuhHI
         yX3yaekIseUtoERJq9NEzxrgtTJrfI8d5Cp1R6AWvyBnz6vV1oUAR2djd1j/hMSt2k+Z
         4+LL5CGtnmGv/5ZLisC4P7VAVLqe/cweXpWm3xgkYbR/b+jTCHWNVTBP/iMbpt1jht3L
         panlWfFI7BbV1LS54KzTKj/isn6g3pxCZzMObb0FaAMwDqDUsIUTZlII4ARmHeQIrm9x
         GrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riLhoP57eVPqwj4BrvS8Vazxssa2eImOkYsWKI1T0t8=;
        b=pZ5OcCK2yfOwutj/74jiOeQGySPltPyOqYae79+vY8acZPkJckWCwOy0Rk59bTPWTj
         TkHQTtZsShnQNRk+DBMJJGg1DMvf+EByNGveXo/RbAW6uCkJaotmWQUIQqba5OiTjGlG
         dhGciw9QFdJI14tkoRNdmROiealM2Jg4818niQXVUtdxKieoVnQP+eXGIyuVAnH5Byl+
         S/DZoIiarcUBSeqr8UnojihQcz3p8ilZr01Uw/NalWowd2mXb7a7ZBAapDeCTbksGFQo
         JjSeLy5NKzkzs/fwrg00AvM4ZF1ycuZRwzFxglvuX6H+T9QtwALeytvGHDcFODRysYtA
         fqsg==
X-Gm-Message-State: ANoB5pk8VJG+qq9uyx/y2e1rq/AGGLiO7HVaJbW3P1KOfAscVK5UWQUv
        602ll6c1fdu1viR9492O4iU=
X-Google-Smtp-Source: AA0mqf6+g/Oq8lkThW8oF445SVxUDWkraBM2XVzF2FkZ356SyOkPQrUSg1X2tifk5oVpQEdOJ+/wig==
X-Received: by 2002:a17:90a:8c82:b0:213:1e29:c8dd with SMTP id b2-20020a17090a8c8200b002131e29c8ddmr2896254pjo.7.1670522601220;
        Thu, 08 Dec 2022 10:03:21 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id x23-20020a63db57000000b004785e505bcdsm13377909pgi.51.2022.12.08.10.03.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 10:03:20 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/5] swap: avoid a redundant pte map if ra window is 1
Date:   Fri,  9 Dec 2022 02:02:06 +0800
Message-Id: <20221208180209.50845-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221208180209.50845-1-ryncsn@gmail.com>
References: <20221208180209.50845-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

Avoid a redundant pte map/unmap when swap readahead window is 1.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 438d0676c5be..60136bda78e3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -730,8 +730,6 @@ static void swap_ra_info(struct vm_fault *vmf,
 	}
 
 	faddr = vmf->address;
-	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
-
 	fpfn = PFN_DOWN(faddr);
 	ra_val = GET_SWAP_RA_VAL(vma);
 	pfn = PFN_DOWN(SWAP_RA_ADDR(ra_val));
@@ -742,12 +740,11 @@ static void swap_ra_info(struct vm_fault *vmf,
 	atomic_long_set(&vma->swap_readahead_info,
 			SWAP_RA_VAL(faddr, win, 0));
 
-	if (win == 1) {
-		pte_unmap(orig_pte);
+	if (win == 1)
 		return;
-	}
 
 	/* Copy the PTEs because the page table may be unmapped */
+	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
 	if (fpfn == pfn + 1)
 		swap_ra_clamp_pfn(vma, faddr, fpfn, fpfn + win, &start, &end);
 	else if (pfn == fpfn + 1)
-- 
2.35.2

