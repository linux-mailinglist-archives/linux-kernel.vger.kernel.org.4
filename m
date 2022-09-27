Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EB5EC919
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiI0QIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiI0QHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:07:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5031BF0DD;
        Tue, 27 Sep 2022 09:06:17 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 64394844;
        Tue, 27 Sep 2022 16:06:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 64394844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664294777; bh=mYEI8X3YQvLK/RUu/d22/5zHkkKnMAgHHDcj2TDiJVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb/pw2FS39AP+Af+44V0wdrH25DDwQiNiPhe5hGjVq7MeCtyiRR0kdx3rexffJXL8
         ZWZ/EuFJWJOtW1Pm6ibk+COonfqqu6XQQwr8A77AgkhzeIBPVkByjUYNZPV8nxMbBW
         Z4g62f3NwcIfEgmY6+2eRWbq1B9Cfdqa43IHxJj8f6uNDQUQZV2ysoxiClY73cpG32
         NfDprW83mv9xhENMHMHNyhn3AIxvYDTl6oL0YA7L8/M1F52hMsbuYUa4ibevJutw/n
         FDufSlH3enHKjLMN7n6+FvNTIPm4CJZ6GAVeHGH5QzOsKM+Im6VLkZw2r9CXMc5xQm
         vwBqYO+kHmoQw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 7/7] docs: add a man-pages link to the front page
Date:   Tue, 27 Sep 2022 10:05:59 -0600
Message-Id: <20220927160559.97154-8-corbet@lwn.net>
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

Readers looking for user-oriented information may benefit from it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 5a700548ae82..85eab6e990ab 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -76,6 +76,8 @@ developers seeking information on the kernel's user-space APIs.
    User-space tools <tools/index>
    userspace-api/index
 
+See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
+which are kept separately from the kernel's own documentation.
 
 Firmware-related documentation
 ------------------------------
-- 
2.37.2

