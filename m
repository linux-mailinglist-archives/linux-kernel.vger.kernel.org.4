Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57935E6D34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIVUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIVUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419902BE03;
        Thu, 22 Sep 2022 13:42:00 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 80493735;
        Thu, 22 Sep 2022 20:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 80493735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879319; bh=zC5DmfnmcyjofvsDiYdnGJiX2/WFvTpVfVyoJDzoBRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZPw2TKP4JRFemmvCM8ulF8zPezrAaKTfjc3y+lD75IosWwhT3CVqE4GfNPO6ljwB
         MK7c4YtnxWAegAZVs0eI2OGWILlRFscaYYLcbvaslN5yDoMRFlOWGkpnSL8M0kDpKG
         Fo6hix36a3+gkyoB7UgMg048B5iFXCC8f0+FM3WXVE04b8a0cD7VcaUHM/J7nETFNX
         /+SYre1Wbv1roQMmItTFnchBtG9ZqNSjWg225dXWMi7eFKORBWW/lqq7e647liTZqX
         jlYcPkpXnknRRQbuo+tRS1JTSMvqQVO0yjBD7ENal/mTf28HxnVhVvtXNVy+37iMek
         oQDC30UgdW9LQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 1/7] docs: promote the title of process/index.html
Date:   Thu, 22 Sep 2022 14:41:32 -0600
Message-Id: <20220922204138.153146-2-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922204138.153146-1-corbet@lwn.net>
References: <20220922204138.153146-1-corbet@lwn.net>
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

