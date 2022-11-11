Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDE6251DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKKDrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKKDrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:47:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321982737
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:47:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6686099pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4qYrPj6Zkm6DmuccolhgQ2CcE3F70l4J/DB2qAJtIo=;
        b=kwtuU59z2n/pCrM+oxNIFrNYt41MpTzlcjeDzydBtLmiZGnJoSXtwcPkZEOVtG+YAC
         iClxrH2fjvH/dYPMYt2rDwj5O/eAKVZ8jEF73PHnO3x/v7vCEC6B4jVpr4TO+vA6n4uQ
         vnbdOUIU2NadtutqnoEBgZyYip1AhcQz2uFI2xscEdNMwaYu9t1ofyF/17Sk5weDMAld
         4+Q0dzoc+rkdUN73bGNvT/DpFXm9ZOcsfzuRHQCdRD7r72GjI7mmtCH8EU/Yw+EbFF1j
         QIsD8ao8ToSsYXqf2apx0wqLym/b0Iw8rFR/ZTmVV7IfB/9DwHWdN5dpJW8+ghNF4qeN
         4Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4qYrPj6Zkm6DmuccolhgQ2CcE3F70l4J/DB2qAJtIo=;
        b=fpb5ESrS22dTPwHVXP3XkSz3oNg8hvvqLxx0A7G84QANXyJlTqLp3QYcomKNsFXGyl
         fCzTBY2GyPXUSwuWg/4qwTLtOh8os+HqgiejB+AceuJ63n0fHOb2ps5FiESswHc3kQXy
         +0JnqpVQENOSdIuM+z/1U+6ffDO06BadOaBUptBGX8phchYJbMi4Il01+o4q7bJeBsJd
         kBIjKueEgUSSCFZDIfJ74bkqP32qq8CC3XX2Er+eq/earMk6AbA9gzUO6W54qabOVjpc
         sPpB0nDj5VqJh9Gph8ryD4iru78EAFQmPSWWlHA//C6RK9QxZ/014j+uE84dNAosCAiW
         WYOw==
X-Gm-Message-State: ANoB5pna20xfStuA5+MBPzxevpnOq5aM/NUwVWr4zWym47jpq69hTUtX
        NFJm0GnA/5hVS7vwT9TOLHF/4CIYAVGv6w==
X-Google-Smtp-Source: AA0mqf6eF6Azkz/o//9ZFHeEQmCeM8IPegjT7Dv6/dti7ru3yDFTxXQJ15MEpRP5IuCctz/S5tWERQ==
X-Received: by 2002:a17:903:446:b0:17f:74f8:c0ca with SMTP id iw6-20020a170903044600b0017f74f8c0camr579297plb.169.1668138461555;
        Thu, 10 Nov 2022 19:47:41 -0800 (PST)
Received: from mi.mioffice.cn ([43.224.245.253])
        by smtp.gmail.com with ESMTPSA id gd15-20020a17090b0fcf00b002036006d65bsm543221pjb.39.2022.11.10.19.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 19:47:41 -0800 (PST)
From:   Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jian Wen <wenjian1@xiaomi.com>, akpm@linux-foundation.org,
        wenjianhn@gmail.com
Subject: [PATCH] docs: admin-guide: cgroup-v1: update description of inactive_file
Date:   Fri, 11 Nov 2022 11:46:39 +0800
Message-Id: <20221111034639.3593380-1-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.25.1
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

MADV_FREE pages have been moved into the LRU_INACTIVE_FILE list by
commit f7ad2a6cb9f7 ("mm: move MADV_FREE pages into LRU_INACTIVE_FILE list").

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 5b86245450bd..60370f2c67b9 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -543,7 +543,8 @@ inactive_anon	# of bytes of anonymous and swap cache memory on inactive
 		LRU list.
 active_anon	# of bytes of anonymous and swap cache memory on active
 		LRU list.
-inactive_file	# of bytes of file-backed memory on inactive LRU list.
+inactive_file	# of bytes of file-backed memory and MADV_FREE anonymous memory(
+                LazyFree pages) on inactive LRU list.
 active_file	# of bytes of file-backed memory on active LRU list.
 unevictable	# of bytes of memory that cannot be reclaimed (mlocked etc).
 =============== ===============================================================
-- 
2.25.1

