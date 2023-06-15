Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B507311EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbjFOISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:18:29 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A591FE2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:18:25 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q9iBT-00FHiC-FN; Thu, 15 Jun 2023 09:18:23 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q9iBT-000KgE-0O;
        Thu, 15 Jun 2023 09:18:23 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Dooks <ben.dooks@sifive.com>, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] mailmap: add entries for Ben Dooks
Date:   Thu, 15 Jun 2023 09:18:20 +0100
Message-Id: <20230615081820.79485-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

I am going to be losing my sifive.com address soon and I also realised
my old Simtec address (from >10 years ago) is also not been updates so
update .mailmap for both.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index bf076bbc36b1..25c976ce963e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -70,6 +70,8 @@ Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@unisoc.com>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang7@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
+Ben Dooks <ben-linux@fluff.org> <ben.dooks@simtec.co.uk>
+Ben Dooks <ben-linux@fluff.org> <ben.dooks@sifive.com>
 Ben Gardner <bgardner@wabtec.com>
 Ben M Cahill <ben.m.cahill@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
-- 
2.39.2

