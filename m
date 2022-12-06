Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8D643D60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiLFHAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:00:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947D23173;
        Mon,  5 Dec 2022 23:00:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v7so10496005wmn.0;
        Mon, 05 Dec 2022 23:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P97r2c1GXauiwyVZKp573X9iPgDxxANKiNnZxGB6wLk=;
        b=Nids9vLDVijoiPSTlFco9YxkZu3SKe7mqXwVtqGmQ8yHv+WTeIiNOV+wET1qQApI8I
         KMDEHMlGUdXHc/qzwVkulOzz/nKXtIrxaY8uWArAGbtknTkrzfngG+JlMrOe5h7xlUwd
         9My9CIHJ0G/eEpBCVUKIBCapnTkjItqqpLpkUPqo1w9auNEjqUSbbL8tSGCyYl57SQHg
         LNkB+fdh5agzZbTB9Xf82SxNbCQkjV8HjRGXC3meh9x+7CWCK9fziWd8/mRsSsfD0W6X
         fRQfnufqmVjgT43KHc/I9EU4hTmj/FMwcdRP3GZzbQDTAzwFJpJ7ZosnlsRq6XUXkTnV
         1ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P97r2c1GXauiwyVZKp573X9iPgDxxANKiNnZxGB6wLk=;
        b=oND0+BNrard5NdSI3nlKbw4H5sd7CM6YhDQah1lnc+0HLSGt6r4qdZCl+vAjgskl+V
         EohlGy/jk4qBteo7jYpZdVtdIVTBZ0wYh3sY4HAHYXuUhco4p84bByTDP6xr2ZCD5JoP
         S12+maC/saowkEryOBEMSTW988pufnTaKOlk9in/Mmps49aXtPNXf8g9tZ6hcNxcHXYa
         Uj1s2zoDae2QKwDSLMvGsc73GKb6+M8QIk9qgm20pRzVeRUc9dXYjZIEZuZnAR0jIHTk
         hGVbk8Nnu6hM20FLdeilm1DStYYiqygtpZzJdQf8j+z0srk7rOBpon4q0NrH8UfGT5BT
         hGSw==
X-Gm-Message-State: ANoB5pkzmNb6Gan/32Gvd9FraeCwtk3WuRWSndYBJAl9gPjkbfkFwysB
        wnwAgxhxXkV0uLdytqT8+jQ=
X-Google-Smtp-Source: AA0mqf64aVgwp5sLzqSzrK9c82ZHdcWBsO3RqlhcVJYg5F0+G5CQTZORCmC0ln/wMy7xhJxyTPzmcw==
X-Received: by 2002:a05:600c:4f51:b0:3b4:a6c4:70fb with SMTP id m17-20020a05600c4f5100b003b4a6c470fbmr49115209wmq.79.1670310034579;
        Mon, 05 Dec 2022 23:00:34 -0800 (PST)
Received: from localhost.localdomain (host-79-26-108-238.retail.telecomitalia.it. [79.26.108.238])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d6910000000b0024217e7aaa7sm15652605wru.50.2022.12.05.23.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 23:00:33 -0800 (PST)
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
Subject: [PATCH] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Tue,  6 Dec 2022 08:00:29 +0100
Message-Id: <20221206070029.7342-1-fmdefrancesco@gmail.com>
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
 Documentation/mm/highmem.rst | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index 0f731d9196b0..9523e92299f6 100644
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
+  restrictions imposed on kmap_local_page(). Furthermore, code between the
+  map/unmap operations may implicitly depended on the side effects of
+  kmap_atomic(), such as disabling pagefaults, migration, and/or preemption.
+  Such conversions should be changed to make explicit calls for those
+  requirements.
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

