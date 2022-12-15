Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672FB64DD09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiLOOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLOOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:43:38 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72551AF05
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:43:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id 0B87C7B81E3;
        Thu, 15 Dec 2022 14:43:33 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HZg095Sj7CRe; Thu, 15 Dec 2022 14:43:30 +0000 (UTC)
Received: from citadel.fritz.box (i59F4DEB3.versanet.de [89.244.222.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 54E317B807E;
        Thu, 15 Dec 2022 14:43:30 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/3, v3] feat: checkpatch: warn about dicouraged link tags and missing links
Date:   Thu, 15 Dec 2022 15:43:23 +0100
Message-Id: <cover.1671114724.git.kai@dev.carbon-project.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1670152844.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
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

Hey,
Thorsten Leemhuis suggested the following two changes to checkpatch, which
I hereby humbly submit for review. Please let me know if any changes
would be required for acceptance.

The third patch came out of the preview rounds and fixes an odd
behaviour noticed then.

The two main changes should help developers write commit messages in a way
that's preferred by Linus and will greatly help Thorsten's regression
tracking efforts.

Patches are against mm/mm-nonmm-stable (which apparently is the tree
checkpatch changes are merged through).

Cheers,
Kai


v2->v3:
- address review feedback from Joe (grammer fixes, use of $herecurr, use
of --no-merges in commit log quote) (Thorsten)
- warn when people try to add version information to the commit log
using code suggested by Joe (Thorsten)
- add a patch to make existing code in a nearby area use $herecurr where
it should, which Joe noticed during review

v1->v2:
- add commit messages explaining the reasoning (Thorsten)
- approach the usage of wrong tags with an allow list as suggested by
Joe (Thorsten)

Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Kai Wasserbäch (2):
  checkpatch: warn when unknown tags are used for links
  checkpatch: warn when Reported-by: is not followed by Link:

Thorsten Leemhuis (1):
  checkpatch: use proper way for show problematic line

 scripts/checkpatch.pl | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

-- 
2.35.1

