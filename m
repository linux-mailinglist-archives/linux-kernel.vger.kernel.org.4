Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9568B0FB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBEQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBEQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:37:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E49761;
        Sun,  5 Feb 2023 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Yo+Urvm0rLhJa9/3W2rPd0P2fF2XsXMjt2+zqWRanrg=; b=i4Cedtf6ZLST1rbXf+b4xMBXqA
        kAQ6Rv7ukeU+KrF5ygkHmz09lfxdboNfdRZ6i9YxvN20YStbkBkfkuG1504+TxrsEyDf6WNZ+/tJY
        yya+ZRuupWF9bvdDByGcJQX0UOuMY3uawVTIrsSAZwjkeMeuXtily8RrwqKalrwrt4wRs6DVx4Lzs
        AoZRdLZWnMHNmhnwiTqx/fhMGLNbJn1zXAPkr0cksLSGLI/k+rKkf7GHcoowOx1DDrYah1Z2HLjkx
        CAqMZkEAGX9vAb3tzfTuHjVDfg4oMsiG6FcGsjw6wEEu8AvnuP+xDpLe+uEdDGBcGaFrtd+xtM882
        YcCewJBg==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOi1Y-006ZDo-TU; Sun, 05 Feb 2023 16:37:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] parisc: update kbuild doc. aliases for parisc64
Date:   Sun,  5 Feb 2023 08:37:52 -0800
Message-Id: <20230205163752.2535-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH=parisc64 is now supported for 64-bit parisc builds, so add
this alias to the kbuild.rst documentation.

Fixes: 3dcfb729b5f4 ("parisc: Make CONFIG_64BIT available for ARCH=parisc64 only")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: drop "parisc for 32 bit" part since "parisc" is not an alias

 Documentation/kbuild/kbuild.rst |    1 +
 1 file changed, 1 insertion(+)

diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -160,6 +160,7 @@ directory name found in the arch/ direct
 But some architectures such as x86 and sparc have aliases.
 
 - x86: i386 for 32 bit, x86_64 for 64 bit
+- parisc: parisc64 for 64 bit
 - sh: sh for 32 bit, sh64 for 64 bit
 - sparc: sparc32 for 32 bit, sparc64 for 64 bit
 
