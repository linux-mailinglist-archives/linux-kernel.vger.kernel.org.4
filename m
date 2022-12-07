Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A0646454
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLGWxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLGWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:53:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076763DD;
        Wed,  7 Dec 2022 14:53:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2209932wmb.2;
        Wed, 07 Dec 2022 14:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpiEQsJqjPxsOEBWR03lhLs9G9Tun7tgT+BbU2JVnqM=;
        b=KXjL2cfIKBIgvx/ytT7JhyrRXAqi7DV7bxrCXM+sOdrDcD2GOwOv5ycP1DizwVgXBF
         qBNeH7o27ARFQQi31x9qziF33+wuYXEow8qjNuuGvdx6s+QvV6EDRIsAx1R/ZZK+9+6E
         f+eZAcPASZaFH7pT4EDUl+ya4wAhQS2jikI9LnKZuUSEFC/waE2+pkNAYGbuUIaH80AT
         z2dRCPE1x6RNvrXRDcQACbEHKuUALwlLegyQToyDuWef1ZXYdVh5l/eVoV4csoMK7+RF
         TlGuDixcoqD3EDJNTUTRzF0LhSyRKKhhcDj6O9g9J8U381q/zt5TO9kTW//oByM7OmyV
         R1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpiEQsJqjPxsOEBWR03lhLs9G9Tun7tgT+BbU2JVnqM=;
        b=YjMmfGv0WZq8XIMcAoEUQfznXsEAwvGw1Mf9GJZ+f93u5YtjeM5yDN+zqgobetFxTo
         SMHiXVevqt/1VIgIjBd57nZr4PLCOT3vsg/AhEPEmcNzHznPa4s5rZyOIWA8HlMZNz5O
         Fk5wJYAlRnzgbczQ2lqrxxJHCEwd1YuCUCseVCpVuAd+bMDdzyJGLgmunW/aw1NAqKfS
         Z4G5r7it4k0guiA1H+my5O6zfkz8GosNU+GBr4uiXvfKyT45GcwnMmTT2cTQTk22imLo
         /LB3mkZFcPROH/qvmNmsvdz3nhaUNET1a7yojYcEtaRAVZQd8SYpXlkfz0R1wC9LkK9o
         WgYA==
X-Gm-Message-State: ANoB5pnljXhek4fs38SGJc4JlrPK/ZDQAh0zzfyKIV4jJxjxYV6D/uB9
        2lkR673s8Zd5UqCps8exTRk=
X-Google-Smtp-Source: AA0mqf4tnmjf1HliNyoRRGtVseloKTRhEfEpPkT57aJot8dbKjBP3UEhygy7Vvu6dtPjkOj5W4521A==
X-Received: by 2002:a05:600c:3647:b0:3cf:5014:c773 with SMTP id y7-20020a05600c364700b003cf5014c773mr1041611wmq.40.1670453595741;
        Wed, 07 Dec 2022 14:53:15 -0800 (PST)
Received: from localhost.localdomain (host-79-26-108-238.retail.telecomitalia.it. [79.26.108.238])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b003c6c4639ac6sm3338273wms.34.2022.12.07.14.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:53:14 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Wed,  7 Dec 2022 23:53:08 +0100
Message-Id: <20221207225308.8290-1-fmdefrancesco@gmail.com>
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

kmap() and kmap_atomic() have been deprecated. kmap_local_page() should
always be used in new code and the call sites of the two deprecated
functions should be converted. This latter task can lead to errors if it
is not carried out with the necessary attention to the context around
and between the maps and unmaps.

Therefore, add further information to the Highmem's documentation for the
purpose to make it clearer that (1) kmap() and kmap_atomic() must not
any longer be called in new code and (2) developers doing conversions from
kmap() amd kmap_atomic() are expected to take care of the context around
and between the maps and unmaps, in order to not break the code.

Relevant parts of this patch have been taken from messages exchanged
privately with Ira Weiny (thanks!).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Reworked part of the "Notes" paragraph in the kmap_atomic() section
in order to leave less room for misinterpretation. I've made these changes
by merging some suggestions from Sebastian (thanks!), although I'm not yet
entirely sure I've achieved crystal clear exposition.

 Documentation/mm/highmem.rst | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index 0f731d9196b0..59d1078f53df 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -57,7 +57,8 @@ list shows them in order of preference of use.
   It can be invoked from any context (including interrupts) but the mappings
   can only be used in the context which acquired them.
 
-  This function should be preferred, where feasible, over all the others.
+  This function should always be used. kmap_atomic() and kmap() have been
+  deprecated.
 
   These mappings are thread-local and CPU-local, meaning that the mapping
   can only be accessed from within this thread and the thread is bound to the
@@ -100,10 +101,21 @@ list shows them in order of preference of use.
   (included in the "Functions" section) for details on how to manage nested
   mappings.
 
-* kmap_atomic().  This permits a very short duration mapping of a single
-  page.  Since the mapping is restricted to the CPU that issued it, it
-  performs well, but the issuing task is therefore required to stay on that
-  CPU until it has finished, lest some other task displace its mappings.
+* kmap_atomic(). This function has been deprecated; use kmap_local_page().
+
+  NOTE: Conversions to kmap_local_page() must take care to follow the mapping
+  restrictions imposed on kmap_local_page(). Furthermore, the code between
+  calls to kmap_atomic() and kunmap_atomic() may implicitly depend on the side
+  effects of atomic mappings, i.e. disabling page faults or preemption, or both.
+  In that case, explicit calls to pagefault_disable() or preempt_disable() or
+  both must be made in conjunction with the use of kmap_local_page().
+
+  [Legacy documentation]
+
+  This permits a very short duration mapping of a single page.  Since the
+  mapping is restricted to the CPU that issued it, it performs well, but
+  the issuing task is therefore required to stay on that CPU until it has
+  finished, lest some other task displace its mappings.
 
   kmap_atomic() may also be used by interrupt contexts, since it does not
   sleep and the callers too may not sleep until after kunmap_atomic() is
@@ -115,11 +127,20 @@ list shows them in order of preference of use.
 
   It is assumed that k[un]map_atomic() won't fail.
 
-* kmap().  This should be used to make short duration mapping of a single
-  page with no restrictions on preemption or migration. It comes with an
-  overhead as mapping space is restricted and protected by a global lock
-  for synchronization. When mapping is no longer needed, the address that
-  the page was mapped to must be released with kunmap().
+* kmap(). This function has been deprecated; use kmap_local_page().
+
+  NOTE: Conversions to kmap_local_page() must take care to follow the mapping
+  restrictions imposed on kmap_local_page(). In particular, it is necessary to
+  make sure that the kernel virtual memory pointer is only valid in the thread
+  that obtained it.
+
+  [Legacy documentation]
+
+  This should be used to make short duration mapping of a single page with no
+  restrictions on preemption or migration. It comes with an overhead as mapping
+  space is restricted and protected by a global lock for synchronization. When
+  mapping is no longer needed, the address that the page was mapped to must be
+  released with kunmap().
 
   Mapping changes must be propagated across all the CPUs. kmap() also
   requires global TLB invalidation when the kmap's pool wraps and it might
-- 
2.38.1

