Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5625EC90D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiI0QHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiI0QHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:07:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C3D88DD0;
        Tue, 27 Sep 2022 09:06:14 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id BBD3B7C0;
        Tue, 27 Sep 2022 16:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BBD3B7C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664294774; bh=NQmxtQEpC+9DH6q+r1zxViObPFBeWowpPclmQS6mOUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFcQHzC6h+PT9jsWWqF/vEd5hGVbKEmKfGObf6ggYUu0yqH/3TeMZ0fSgS4QsvwD/
         7RDStbIVUKbZu8NZJH2jF/F00rKUBDWVR3NudJiuwLT5PezLtWuBTfRproZWHqv6Ju
         T4665ZeT+KHsSocQCsKn1y9AYPvq+MZnuG93eAz4CfIky+DcEnIMlVHDbrqEne9IjV
         TGzwhnRE7qLl24QY14iwmkGCdcb1V52EW8CRggrzjbBFSnSTb2VEIb0nEKmJIcYYVn
         R5wPCQlrCAPbXH96k48GfuWrlQlkr1kJ2+hF5/g2WpOYca6XgiFUmGZRF4kD8ZthTW
         wOBMmSJwZ6bfQ==
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
Subject: [PATCH v3 1/7] docs: promote the title of process/index.rst
Date:   Tue, 27 Sep 2022 10:05:53 -0600
Message-Id: <20220927160559.97154-2-corbet@lwn.net>
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

...otherwise Sphinx won't cooperate when trying to list it explicitly in
the top-level index.rst file

Reviewed-by: David Vernet <void@manifault.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/process/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 2ba2a1582bbe..d4b6217472b0 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -5,6 +5,7 @@
 
 .. _process_index:
 
+=============================================
 Working with the kernel development community
 =============================================
 
-- 
2.37.2

