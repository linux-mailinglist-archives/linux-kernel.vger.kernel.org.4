Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB464DD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLOOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLOOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:43:39 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C62F01F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:43:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id 439627B81E1;
        Thu, 15 Dec 2022 14:43:37 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0AE-KkHq7Yzg; Thu, 15 Dec 2022 14:43:33 +0000 (UTC)
Received: from citadel.fritz.box (i59F4DEB3.versanet.de [89.244.222.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 022F57B8169;
        Thu, 15 Dec 2022 14:43:30 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/3] checkpatch: warn when Reported-by: is not followed by Link:
Date:   Thu, 15 Dec 2022 15:43:25 +0100
Message-Id: <26b72b039d4150418cd37598d50112719c684344.1671114724.git.kai@dev.carbon-project.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1671114724.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org> <cover.1671114724.git.kai@dev.carbon-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encourage patch authors to link to reports by issuing a warning, if
a Reported-by: is not accompanied by a link to the report. Those links
are often extremely useful for any code archaeologist that wants to know
more about the backstory of a change than the commit message provides.
That includes maintainers higher up in the patch-flow hierarchy, which
is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:

> Again, the commit has a link to the patch *submission*, which is
> almost entirely useless. There's no link to the actual problem the
> patch fixes.
>
> [...]
>
> Put another way: I can see that
>
> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>
> in the commit, but I don't have a clue what the actual report was, and
> there really isn't enough information in the commit itself, except for
> a fairly handwavy "Device drivers might, for instance, still need to
> flush operations.."
>
> I don't want to know what device drivers _might_ do. I would want to
> have an actual pointer to what they do and where.

Another reason why these links are wanted: the ongoing regression
tracking efforts can only scale with them, as they allow the regression
tracking bot 'regzbot' to automatically connect tracked reports with
patches that are posted or committed to fix tracked regressions.

Link: https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/ [3]
Co-developed-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d739ce0909..9434f94d2d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3155,6 +3155,20 @@ sub process {
 					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
 				}
 			}
+
+			# check if Reported-by: is followed by a Link:
+			if ($sign_off =~ /^reported-by:$/i) {
+				if (!defined $lines[$linenr]) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Link: following Reported-by: should contain a URL\n" . $herecurr . $rawlines[$linenr] . "\n");
+				}
+			}
 		}
 
 # Check Fixes: styles is correct
-- 
2.35.1

