Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C967F7CF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjA1M33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjA1M32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:29:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFCC23C51;
        Sat, 28 Jan 2023 04:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 649F4B808D5;
        Sat, 28 Jan 2023 12:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB7CC433D2;
        Sat, 28 Jan 2023 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674908964;
        bh=/MjwOIZ7AHnVIx/U++rLxc4ZtiAEs3nBEd9N/z5OlZo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZapXZYkH7h69AzmJO6Agn0+62d6uKHR9tNmiQkqwgBjB2xMeULggvJlKHOi3VTn+v
         FItOU3ig9pK+/+kbheDsuKN50Lqc4WcQBzQ8O0estDGQGU3qYuLPAgnMrrsxiDYYOE
         3MIOZBgqm7nu7E5Drs37IiaMxkQ1P1+JWV/lwAmbKWs6PHFV9X89AeIL7iu78KRP9k
         gmsNCNR6AuNSNBBy/bimjvdjApzEdGdvHS1Wwzyyuj9tLNvUGtm4hJqlxkAqBg5bJx
         oOBvcqKMqdrmaXT59MbBKeyb3jfzy8hP8LY55nPfzCwpUCjkbE+/QHjyb0AdtTXZ5C
         SByxacYI4W+Uw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: [RFC PATCH] MAINTAINERS: Mark Itanium/IA64 as 'dead'
Date:   Sat, 28 Jan 2023 13:29:04 +0100
Message-Id: <20230128122904.1345120-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633; i=ardb@kernel.org; h=from:subject; bh=/MjwOIZ7AHnVIx/U++rLxc4ZtiAEs3nBEd9N/z5OlZo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj1RUQXu7GDRm716q0YhFxKPrZ1FjCoRphxk4HkO4J 38PCh4aJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9UVEAAKCRDDTyI5ktmPJJSzC/ 9QSkCE13/MHnhFgdRJVuL/ZWL0Z71yylWHYWUX1yPPt3ZofLsZvP4L6swmbZBSLBoHL+D7FcQLaZAy FFGaYTcxDKMfUXqNGGGhnM8ocd2awGUB9xyeaLCPcQfxarrgZUTE3ceFlxaMqUSUGqREkekOvZqhki q8OYeFJRMsypPY7zOvJX8XiWgh7TMsINGMxDS71ymm6zxp4iuHdR5azYM/YsLqmWO/bgV2HnQJcGlJ /On7lkZ/xCBLO1OLpIhKRsUT3zO5GkRzZamM8A1CnTY8AIUnDwNtXBEDgjQeJf2+3ABiuvTiy/S0OQ 3FpA/kUM27uZiSy194U4hyVQ92tpY0wl1ZajR5uAL7Hy6my9IUXmzfrr7hISqygQxJ9RA7LBpMG+iO tyfacpPNb3P+415H5LaF1vLD5OOJWcv7D8RkEazbhXqlSXgVi3DdvO2Yoj+bpg4z4aIXgC3SoLUeVT Gaat18DplDCHoVS5Li6bRnNWATmA3tVVd+3G5nSBsIBik=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new status 'dead' which conveys that a subsystem is
unmaintained and scheduled for removal, and developers are free to
behave as if it's already gone. Also, automated build tests should
ignore such subsystems, or at least notify only those who are known to
have an interest in the subsystem in particular.

Given that Itanium/IA64 has no maintainer, is no longer supported in
QEMU (for boot testing under emulation) and does not seem to have a user
base beyond a couple of machines used by distros to churn out packages,
let's mark it as dead. This shall mean that any treewide changes (such
as changes to the EFI subsystem, which I maintain) can be made even if
they might cause build or boot time regressions on IA64 machines. Also,
mark the port as scheduled for removal after the next LTS release.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org
Link: https://lore.kernel.org/all/CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b74014994f5c1cc..5481967c2112e8ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -94,6 +94,14 @@ Descriptions of section entries and preferred order
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
+	   Dead:	Code has no maintainer and no significant user base,
+			and is scheduled for removal. Developers are free to
+			ignore it when it comes to testing bug fixes or other
+			code changes, and automated build test systems must not
+			report any detected issues, except possibly to mailing
+			lists or other recipients that have opted in
+			specifically to receiving reports about the state of
+			this code.
 	W: *Web-page* with status/info
 	Q: *Patchwork* web based patch tracking system site
 	B: URI for where to file *bugs*. A web-page with detailed bug
@@ -9833,7 +9841,7 @@ F:	include/linux/i3c/
 
 IA64 (Itanium) PLATFORM
 L:	linux-ia64@vger.kernel.org
-S:	Orphan
+S:	Dead # to be removed after the 2023 LTS release
 F:	Documentation/ia64/
 F:	arch/ia64/
 
-- 
2.39.0

