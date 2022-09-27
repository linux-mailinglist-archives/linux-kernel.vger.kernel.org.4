Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9C5EC910
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiI0QIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiI0QHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:07:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF913CF0;
        Tue, 27 Sep 2022 09:06:15 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id EC06F7DA;
        Tue, 27 Sep 2022 16:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC06F7DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664294775; bh=cuGw4du26WfBnI3n9GP89PwXgPcoYV+BdrHL5FFQfyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJx/eGZPyZW7i4fLlp1toR1Ehf9Et1PGq3+KOvixc0GOew/FGgTEUk0BqydNq1yM5
         DzWljfkfKDOWuPXGC/R+KpFjpvol4sOMNfH0wUpb+btD+mkkED/fXSN3blSdAGZmG3
         p779PNzgGrnnvxS7QyRHT+ANOJO/Ay2P8FDf9gdGpOCXczLvvuhAdup7FZhD1j91Ud
         NskBx/vKt/Eoxj3rw3WBzHV1Ato3ipH+g7uq0+MqpM8iVItABMllzC4oTYzNFKpQjR
         iH/ClnY9MI2mhIrfDOnuzDyXwPOkpO1htjXpnv84XhMGHq9O72cblJsRRVSJAHkAbS
         mlsIzfZyi8bKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 3/7] docs: reconfigure the HTML left column
Date:   Tue, 27 Sep 2022 10:05:55 -0600
Message-Id: <20220927160559.97154-4-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927160559.97154-1-corbet@lwn.net>
References: <20220927160559.97154-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the html_sidebars directive to get a more useful set of links in the
left column.

Unfortunately, this is a no-op with the default RTD theme, but others
observe it.

Reviewed-by: David Vernet <void@manifault.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 78dd6d1e7b88..22c9d4df1967 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -370,7 +370,8 @@ html_static_path = ['sphinx-static']
 html_use_smartypants = False
 
 # Custom sidebar templates, maps document names to template names.
-#html_sidebars = {}
+# Note that the RTD theme ignores this.
+html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
 
 # Additional templates that should be rendered to pages, maps page names to
 # template names.
-- 
2.37.2

