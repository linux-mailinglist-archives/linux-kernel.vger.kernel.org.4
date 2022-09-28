Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE775EDDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiI1NkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiI1Njq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:39:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48E5A2F9;
        Wed, 28 Sep 2022 06:39:44 -0700 (PDT)
Received: from ip4d147bae.dynamic.kabel-deutschland.de ([77.20.123.174] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1odXHp-0006WL-N5; Wed, 28 Sep 2022 15:39:41 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] docs: process/5.Posting.rst: clarify use of Reported-by: tag
Date:   Wed, 28 Sep 2022 15:39:40 +0200
Message-Id: <2fc7162dfb76e04da5ea903c9c170d913e735dad.1664372256.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664372384;24a868f7;
X-HE-SMSGID: 1odXHp-0006WL-N5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the description on when to use the Reported-by: tag found in
Documentation/process/5.Posting.rst more in line with the description in
Documentation/process/submitting-patches.rst: before this change the two
were contradicting each other, as the latter is way more permissive and
only states '[...] if the bug was reported in private, then ask for
permission first before using the Reported-by tag.'

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

---
Hi! I noticed some confusion in our development community on when to use
the Reported-by: tag. Some of this apparently is caused by the
inconsistency fixed in this patch. Ciao, Thorsten
---
 Documentation/process/5.Posting.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 906235c11c24..d87f1fee4cbc 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -256,8 +256,10 @@ The tags in common use are:
  - Cc: the named person received a copy of the patch and had the
    opportunity to comment on it.
 
-Be careful in the addition of tags to your patches: only Cc: is appropriate
-for addition without the explicit permission of the person named.
+Be careful in the addition of tags to your patches, as only Cc: is appropriate
+for addition without the explicit permission of the person named; using
+Reported-by: is fine most of the time as well, but ask for permission if
+the bug was reported in private.
 
 
 Sending the patch

base-commit: 3ef859a4f6c97253b75eb53d259b7789fb92d875
-- 
2.37.3

