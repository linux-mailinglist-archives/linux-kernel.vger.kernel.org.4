Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E974DC01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGJRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGJRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:10:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83417128;
        Mon, 10 Jul 2023 10:10:19 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qIuOt-0006Iv-FN; Mon, 10 Jul 2023 19:10:15 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 1/3] docs: stable-kernel-rules: mention other usages for stable tag comments
Date:   Mon, 10 Jul 2023 19:10:11 +0200
Message-Id: <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689008220.git.linux@leemhuis.info>
References: <cover.1689008220.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689009019;f91080f1;
X-HE-SMSGID: 1qIuOt-0006Iv-FN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document how to delay backporting or send a note to the stable team
using shell-style inline comments attached to stable tags.

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 51df1197d5ab..6e4026dd6882 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -55,9 +55,10 @@ To have the patch automatically included in the stable tree, add the tag
 
      Cc: stable@vger.kernel.org
 
-in the sign-off area. Once the patch is merged it will be applied to
-the stable tree without anything else needing to be done by the author
-or subsystem maintainer.
+in the sign-off area; to accompany a note to the stable team, use a shell-style
+inline comment (see below for details). Once the patch is merged it will be
+applied to the stable tree without anything else needing to be done by the
+author or subsystem maintainer.
 
 .. _option_2:
 
@@ -139,6 +140,21 @@ The tag has the meaning of:
 
 For each "-stable" tree starting with the specified version.
 
+To delay pick up of patches submitted via :ref:`option_1`, use the following
+format:
+
+.. code-block:: none
+
+     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
+
+For any other requests related to patches submitted via :ref:`option_1`, just
+add a note to the stable tag. This for example can be used to point out known
+problems:
+
+.. code-block:: none
+
+     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
+
 Following the submission:
 
  - The sender will receive an ACK when the patch has been accepted into the
-- 
2.40.1

