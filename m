Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE95E6D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiIVUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiIVUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:02 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2552BE01;
        Thu, 22 Sep 2022 13:42:01 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id BBA087F8;
        Thu, 22 Sep 2022 20:42:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BBA087F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879321; bh=pjEqGsC3o1cCyVpcxwjXhbptLW8M3DxLII6MXHLKxx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWbxNZ1XAipsse42nS+MNazVPJlCC7b34fZWJxBpwzReFOUFFM4i1f5/7aQZNXkTq
         6yXrURAPxiLLTti3nYhSEg3Nqxi3mycUcXKQuQzTgGYzfen4TgK4pyH85jkONumqIY
         wzXvv6Hy7pQFgLCAMxl3cWBDslrmUubZTt4ppSnDIhUGV2QdUCUceKm/9/U6y+Q26A
         +XeWD/x5RZnFc08kYTCbwBoZ6NrxUPgsxWlH4dBwnZCUL61I7JGrelXIYuY+tK+3Da
         Dmvezp+UkU4vLurABReZjxVMBiXkidy7jdOGApP8VXNbsxoBtuPZVmmmu/fSZl18Ac
         C9vRbxVkf/aCA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 3/7] docs: reconfigure the HTML left column
Date:   Thu, 22 Sep 2022 14:41:34 -0600
Message-Id: <20220922204138.153146-4-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922204138.153146-1-corbet@lwn.net>
References: <20220922204138.153146-1-corbet@lwn.net>
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

Use the html_sidebars directive to get a more useful set of links in the
left column.

Unfortunately, this is a no-op with the default RTD theme, but others
observe it.

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
+# Note that the RTD theme ignores this
+html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
 
 # Additional templates that should be rendered to pages, maps page names to
 # template names.
-- 
2.37.2

