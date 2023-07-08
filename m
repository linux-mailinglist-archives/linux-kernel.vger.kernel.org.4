Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D16074BE4C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGHPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGHPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:51:51 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226031A8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 08:51:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qyvrv19GnzBHXkd
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 23:51:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688831500; x=1691423501; bh=6UNwiye9DK9kR1UF8tjATHdsO2e
        t5D1MCkBSWpcgjPk=; b=qVqwuhuy+AKKjx2m5T/SxpyTOUiz83/GjgpZu9+Z5JS
        NAIatOGPcbfddj8OmUXuxFB8rT/5J2O5bI8J/8YPcvBsIbFCkk1ht2Fv9sx+3x73
        zn2FYY0FFY+5WSLGCHbcDedvFWdcoyUS+FhUafE5XHjRUPS4hGJfYKQg06KRE/2v
        VlOPL0OqmolOm5Qtz4QogYIFJVcScrtZC0Vyqzm+BjZu9YPJ0AhP5XArxRXY+uv9
        owOwbwZTAcIVLM6vKjzYJ2ErGZsPo6pMkYbm9aaQ1fgajYtchcVdvzZ2cDG6ipe+
        GNBY9flVz7V8s2Tc02jPtzwOHNxOBcYlPL5jYt4Ud1w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9fKbQudeLmGi for <linux-kernel@vger.kernel.org>;
        Sat,  8 Jul 2023 23:51:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qyvrr66ltzBHXkZ;
        Sat,  8 Jul 2023 23:51:40 +0800 (CST)
MIME-Version: 1.0
Date:   Sat, 08 Jul 2023 23:51:40 +0800
From:   xuanzhenggang001@208suo.com
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: q40: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <tencent_7098E5576B2FD785B3A3B9CD6CE0643D4C07@qq.com>
References: <tencent_7098E5576B2FD785B3A3B9CD6CE0643D4C07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <4d862263222c7358840745c2cd0ce0fa@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by checkpatch:

./arch/m68k/q40/q40ints.c:172: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
./arch/m68k/q40/q40ints.c:211: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/m68k/q40/q40ints.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 127d7ecdbd49..9605d7b6cb30 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -169,7 +169,7 @@ void q40_sched_init (void)
   *
  */

-struct IRQ_TABLE{ unsigned mask; int irq ;};
+struct IRQ_TABLE { unsigned int mask ; int irq ; };
  #if 0
  static struct IRQ_TABLE iirqs[]={
    {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},
@@ -208,7 +208,7 @@ static int aliased_irq;        /* how many times 
inside handler ?*/
  /* got interrupt, dispatch to ISA or keyboard/timer IRQs */
  static void q40_irq_handler(unsigned int irq, struct pt_regs *fp)
  {
-    unsigned mir, mer;
+    unsigned int mir, mer;
      int i;

  //repeat:
