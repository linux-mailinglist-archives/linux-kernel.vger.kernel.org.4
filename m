Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499B6FE9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEKCCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKCCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC20E7A;
        Wed, 10 May 2023 19:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA6463F65;
        Thu, 11 May 2023 02:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE05DC433D2;
        Thu, 11 May 2023 02:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683770526;
        bh=8kVvNTf+SIgWcuslTbMYwVXYnOSgaLXA0Yfwmxi6Yho=;
        h=From:To:Cc:Subject:Date:From;
        b=hwrvHBzn4f4aLRx4Rf7teQtUSM+k4glGOd7ddiLGBZxh9yVAEudQYS5+4CA3cY7hH
         ECumTP5vaAXYz67ehGZLdtpr5rGG4mDZVD63g72qymZO0WqJLAVjApMOvm6JmKncUk
         F+Ash32VsNAtr6FE2nZ1jOlGGGP5Zif+4t3BX4QN1MPdAJe5w9Kx+Sqgonik0iRY6Z
         irsJfCmYsoZIdwL2KieDr/PBV4k6Ks4nc4M2jb3SAAFXd5WHJj7rm8P0XE91DezvV9
         yxDypvoGMT1/i5nRD7z4EOm4ZObMMSDawCNl/3zUnln3xYfwE+jwI3Cor5GVk4Smob
         07Mp+bcUOac5Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     corbet@lwn.net
Cc:     torvalds@linux-foundation.org, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC] MAINTAINERS: direct process doc changes to a dedicated ML
Date:   Wed, 10 May 2023 19:02:04 -0700
Message-Id: <20230511020204.910178-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to keep track of changes to the process docs.
Subsystem maintainers should probably know what's going on,
to ensure reasonably uniform developer experience across
trees.

We also need a place where process discussions can be held
(i.e. designated mailing list which can be CCed on naturally
arising discussions). I'm using workflows@ in this RFC,
but a new list may be better.

No change to the patch flow intended.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I've been pondering the lack of cross-maintainer communication
as the kernel grows, and I hope this could help bring us together
a little. Plus twice over the last 2 weeks someone popped up on
netdev with what I personally considered incorrect interpretation
of the process docs, so it'd be nice to CC a list on my replies
so I can be corrected, in case I'm wrong.

Opinions more than welcome!
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c78e61a3387..58239fbc7007 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6223,6 +6223,12 @@ X:	Documentation/power/
 X:	Documentation/spi/
 X:	Documentation/userspace-api/media/
 
+DOCUMENTATION PROCESS
+M:	Jonathan Corbet <corbet@lwn.net>
+S:	Maintained
+F:	Documentation/process/
+L:	workflows@vger.kernel.org
+
 DOCUMENTATION REPORTING ISSUES
 M:	Thorsten Leemhuis <linux@leemhuis.info>
 L:	linux-doc@vger.kernel.org
-- 
2.40.1

