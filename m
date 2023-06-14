Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4C72F45E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbjFNGCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjFNGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:02:19 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB01AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:02:18 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgvvr0Kb8zBQJYT
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:02:16 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686722535; x=1689314536; bh=XqnriwnpXs7hfIX4toWtqwxUQ6H
        FLpo5W2Vp/C8l23g=; b=O0LvyOV/c9cDjESFbj7lLcJqijtT5/lo9FFgsYijr1d
        dlj1kvij8GuLCNA+NUfHdkbSRMKL2NF7zZMbsUdLcVwkXvtDrNk1JlAvpREPLASA
        VOIbhm9xY5SKWsj+pA91AP+d3ZqWGjQXdMsM/8AG92tvpVRSSoX+Cs6V+PNmz6SG
        ObQryjyeYq1jIo2Nln0pbznJyqgE8qKvc+f4zObIPmkvi3tNvnq+/IqiFU0pROOX
        W6BxMkuRXZU0CplxMmLjysEwRGIgXsUQC7fjO/oY9mNK7S3kuG+ufARbsjsM9FmC
        +SJMco7P7ZaQm9I28YN/x4EJj4bKmcFRMO8O5TpEFMA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yJMOgCm904qx for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:02:15 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgvvq5brxzBJLB3;
        Wed, 14 Jun 2023 14:02:15 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:02:15 +0800
From:   wuyonggang001@208suo.com
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/q40: Fix syntax error
In-Reply-To: <4c81c6406707cf2e26b43bd4c5caca3a@208suo.com>
References: <20230614032446.8391-1-zhanglibing@cdjrlc.com>
 <4c81c6406707cf2e26b43bd4c5caca3a@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <74ed374c5d5ec504d3bbecef656c1b37@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  arch/m68k/q40/config.c | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index c78ee709b458..79670d670ffb 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -148,12 +148,12 @@ static void q40_get_model(char *model)

  static unsigned int serports[] =
  {
-    0x3f8,0x2f8,0x3e8,0x2e8,0
+    0x3f8, 0x2f8, 0x3e8, 0x2e8, 0
  };

  static void __init q40_disable_irqs(void)
  {
-    unsigned i, j;
+    unsigned int i, j;

      j = 0;
      while ((i = serports[j++]))
@@ -227,12 +227,12 @@ static int q40_hwclk(int op, struct rtc_time *t)
          /* Read....  */
          Q40_RTC_CTRL |= Q40_RTC_READ;

-        t->tm_year = bcd2bin (Q40_RTC_YEAR);
-        t->tm_mon  = bcd2bin (Q40_RTC_MNTH)-1;
-        t->tm_mday = bcd2bin (Q40_RTC_DATE);
-        t->tm_hour = bcd2bin (Q40_RTC_HOUR);
-        t->tm_min  = bcd2bin (Q40_RTC_MINS);
-        t->tm_sec  = bcd2bin (Q40_RTC_SECS);
+        t->tm_year = bcd2bin(Q40_RTC_YEAR);
+        t->tm_mon  = bcd2bin(Q40_RTC_MNTH)-1;
+        t->tm_mday = bcd2bin(Q40_RTC_DATE);
+        t->tm_hour = bcd2bin(Q40_RTC_HOUR);
+        t->tm_min  = bcd2bin(Q40_RTC_MINS);
+        t->tm_sec  = bcd2bin(Q40_RTC_SECS);

          Q40_RTC_CTRL &= ~(Q40_RTC_READ);

@@ -270,7 +270,7 @@ static int q40_set_rtc_pll(struct rtc_pll_info *pll)
      if (!pll->pll_ctrl) {
          /* the docs are a bit unclear so I am doublesetting */
          /* RTC_WRITE here ... */
-        int tmp = (pll->pll_value & 31) | (pll->pll_value<0 ? 32 : 0) |
+        int tmp = (pll->pll_value & 31) | (pll->pll_value < 0 ? 32 : 0) 
|
                Q40_RTC_WRITE;
          Q40_RTC_CTRL |= Q40_RTC_WRITE;
          Q40_RTC_CTRL = tmp;
