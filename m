Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA66365E14B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjAEAKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjAEAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3543A26;
        Wed,  4 Jan 2023 16:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F156B81988;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79707C433A4;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=lNPz8fsxYbYIrwgfENvy5JR5By4h6WSZrBDq8U/etz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiUoxGUwWUOcqSNhxX31YIaSXGdjqoMOHZ1LsmXkpn2F31w8zTU0CQ78aHtJW3VfX
         2P4+4lOB7oSwsSwazthyRznygJRYt0YumJLiCioyahJUu2+ADfLtnKvrWlv5B2ngKe
         WQhHpkDe6sU+yERVH/g3iA4T9Vqy/5HV+fHKsFXpR/UqCMHQpP8bkqjCW+cHtS8XOD
         +f3DCzMWtSGOE15SJiHvTBYBqb/b4W7po0AAilXlRSrL1R5+5vZ0caSqTlmd2tEDex
         8lqSfePl59A+edjLrGAbUZ84MZeumfCrEUDgyO5FP6+TAxASIyxjJuew50hP12ir4b
         d21RoF1Scm4Gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D45E65C03B9; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/15] doc: Update rcu.rst URL to RCU publications
Date:   Wed,  4 Jan 2023 16:09:50 -0800
Message-Id: <20230105000955.1767218-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add the more recent thicket of Google Documents.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 381cb86f657d8..bf6617b330a74 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -89,4 +89,5 @@ Frequently Asked Questions
 - Where can I find more information on RCU?
 
   See the Documentation/RCU/RTFP.txt file.
-  Or point your browser at (http://www.rdrop.com/users/paulmck/RCU/).
+  Or point your browser at (https://docs.google.com/document/d/1X0lThx8OK0ZgLMqVoXiR4ZrGURHrXK6NyLRbeXe3Xac/edit)
+  or (https://docs.google.com/document/d/1GCdQC8SDbb54W1shjEXqGZ0Rq8a6kIeYutdSIajfpLA/edit?usp=sharing).
-- 
2.31.1.189.g2e36527f23

