Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85AC68ADBF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBEBEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEBE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:04:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89F623C6F;
        Sat,  4 Feb 2023 17:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=p/X12mhEonmgqFvC/p6xV+/a6TCrqGOjh0it/f2ls9w=; b=mDnvP88AwbXfl5h0DDgqhjWERO
        ButqRF5o3LUP0rEmf8o9bbms6DHqxjIU/yl18Ef8BtCQIAmxUWlrgLP5PmZ3vAytKC3FBIq4iyutf
        QVeIRG2dXqPWlDRPDncOLULTB5hDXl7TZ50xnQkO8kESQ7cl3T3aSo7J7HwEAFPI5rGLThIgaQ8QP
        M1bbMgZpsz9p7Se7Ayf5/OjbCIwF9GstvQIgiaDdrUKnMudrZSGJ9LBEmSeNCVHLQWngWi40aYIDx
        q34iaeH1zU3EaSDLKYLJrofEA30/DVecfgyGJMBPyWpzW1iZ7+d/XB9jD0nRGRZa2DOUPu8XOetxz
        q7jbq4+A==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOTSE-005njc-C5; Sun, 05 Feb 2023 01:04:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] parisc: update kbuild doc. aliases for parisc64
Date:   Sat,  4 Feb 2023 17:04:25 -0800
Message-Id: <20230205010425.11932-1-rdunlap@infradead.org>
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
 Documentation/kbuild/kbuild.rst |    1 +
 1 file changed, 1 insertion(+)

diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -160,6 +160,7 @@ directory name found in the arch/ direct
 But some architectures such as x86 and sparc have aliases.
 
 - x86: i386 for 32 bit, x86_64 for 64 bit
+- parisc: parisc for 32 bit, parisc64 for 64 bit
 - sh: sh for 32 bit, sh64 for 64 bit
 - sparc: sparc32 for 32 bit, sparc64 for 64 bit
 
