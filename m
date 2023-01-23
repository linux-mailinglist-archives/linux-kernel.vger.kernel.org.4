Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB967828C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjAWRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjAWRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:23 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD72CFF0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:17 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v17so10909953oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIxaYzXG+vaQkdBzDvgzY0uG6gWijIiHh8BJL3SYw7o=;
        b=Rngullo9FIQWmYiF+ZxTZkXPONEiae8rLiI21tPQuQM7sel0wQrIaqKGTfGlyJBYHi
         BZloPHvNsYpAB8Gjfq+/MLy+JFG1bzk9t4DEAy5bahBhWPSMcKlhIaQDxnWkS4E2ZfMh
         wZxkcA3BZUUaKrNCRvUanXkMY/EQKELh7+/g1BPznjojLSKoZdicMlmspziUhSnqotUK
         4gf7K+AEVEXHRBuH95fye+Pn26CWzGSzOf0MgsD7nrYkVs73JTz+/9vjgUZZkV5BCZEJ
         pKn+T9w2ueZQx9kRjRDuaeK0hP1PuZupTr0opup9/ZBIs7pDl5ZdZ4dC2rzu8Dko5QBl
         yiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIxaYzXG+vaQkdBzDvgzY0uG6gWijIiHh8BJL3SYw7o=;
        b=Zibnmg+YKECytdB+XXbYqBkbcROq0KNMGRYEu2s5Dv/e0kV2TUYVnDg1c6QX6DaMwp
         dmZCKzTy8GkHpFUbwnUCAUdQtnJ+LN+GsS2fVYt/a/2fI74IH+mwqYdGfsvGs1XPE0/5
         VtQxCGBihDLuybGy23J5wktdsG7mtRBxogLSesY5nipHxRav0ItIkkTDCElOpVdP+HMt
         2Jw+RWiMImjsUdODMiJFAHOT18oLUw88UOXvcSOCxEt2O5GHmPqgzxskvxHF8sfkF6lI
         33AYOef1p0mz39J51WPtoglHF25eFZikSzJbJi60ENTR42FGcEcX9rXGdzw9W3XecqyQ
         6A2Q==
X-Gm-Message-State: AFqh2kqdvAoSNJqdw2U4vAW5RwOP3uKlt0NX48wgs4RjAY+B0Cuvm2ry
        PYbPdqrP3GOjQ2wWW7Eteln41NF39rZRv+ogpzU71Z3Mr8r7DXvxPtDkuIgdhA6guTCc/KNeI0V
        x7yLPS2fjBqU1/UgFaBhgoXuioi6rZBAWtSP6yFs0B+Wlvb2GQmn5jd0fNaCSgpbzOMH6lNPc7C
        v78H3AjEipAJ5Z
X-Google-Smtp-Source: AMrXdXtmQsBbX7TxTVWro+5YzIyFVsPhCNiCtKLjq/clS6dNMO6H0Okkpr01ZFCld64pV0RG/sUUQA==
X-Received: by 2002:aca:ea56:0:b0:364:458a:a719 with SMTP id i83-20020acaea56000000b00364458aa719mr12645525oih.23.1674493516311;
        Mon, 23 Jan 2023 09:05:16 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:15 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 5/9] mm: kmemleak: do not scan sparsemap_buf
Date:   Mon, 23 Jan 2023 11:04:15 -0600
Message-Id: <20230123170419.7292-6-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparsemap_buf is used for vmemmap and vmemmap contains an array of
struct page. kmemleak scans the pages separately. If it scans them
twice, then it will duplicate the number of found references and will
cause missed leaks.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/sparse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 2779b419ef2a..49df7a052037 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -14,6 +14,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
+#include <linux/kmemleak.h>
 
 #include "internal.h"
 #include <asm/dma.h>
@@ -466,6 +467,8 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
+	/* sparsemap_buf has been registered with its physical address in kmemleak */
+	kmemleak_no_scan_phys(virt_to_phys(sparsemap_buf));
 }
 
 static void __init sparse_buffer_fini(void)
-- 
2.37.1

