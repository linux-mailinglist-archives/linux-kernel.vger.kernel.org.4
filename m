Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E2274C3F8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 14:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGIMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIMFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 08:05:31 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C7F9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 05:05:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzQnH3DdfzBJBgH
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:05:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688904321; x=1691496322; bh=IM2g/7x/N3YXNCzwR3vmRZ6heJr
        nmiAxObbvD/+LyA4=; b=dvln0uEcEs/2bF8Mmn+mC4ejQUMsrQ7FziKRITIdMb3
        5crpMifjrphhuqnfniexP0KOMOsK1ySKsZIs7lPdTj8ZoxdQ2VMQRFKVvZ+Tx6IC
        qrlGHiXeV+LMP5auhfvNvRLPChWjme+Ohc/+hWps+qV4kegvA2ONb8TgOgFJILiQ
        Y8yq3ydCd/JmBXRdgSmKcAWIVcLM075DNAidaCZ8sq3ctITbYwY41Hakda/l55Zp
        LjQE04VfSUrQyCJGSsYcGb+pTRlqe1agb7NWtVMMThp1xxvDrNBfA2hqOJMqRqm7
        fOiTAI71Ts99CR5Vzn6nDC1QYFpZxhi5JlSOG4zs8yQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mOL_cfesmdFN for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 20:05:21 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzQnF34JFzBHBQ3;
        Sun,  9 Jul 2023 20:05:21 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 20:05:21 +0800
From:   xuanzhenggang001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, ryan.roberts@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <20230709115215.52448-1-denghuilong@cdjrlc.com>
References: <20230709115215.52448-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7b527a83b74ebb9eca3026e4b85eb9d8@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by checkpatch:

arch/arm64/mm/ptdump.c:207: WARNING: Prefer 'unsigned int' to bare use 
of 'unsigned'
arch/arm64/mm/ptdump.c:334: WARNING: Prefer 'unsigned int' to bare use 
of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/arm64/mm/ptdump.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index e305b6593c4e..0a755fddbcf2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -204,7 +204,7 @@ static struct pg_level pg_level[] = {
  static void dump_prot(struct pg_state *st, const struct prot_bits 
*bits,
              size_t num)
  {
-    unsigned i;
+    unsigned int i;

      for (i = 0; i < num; i++, bits++) {
          const char *s;
@@ -331,7 +331,7 @@ void ptdump_walk(struct seq_file *s, struct 
ptdump_info *info)

  static void __init ptdump_initialize(void)
  {
-    unsigned i, j;
+    unsigned int i, j;

      for (i = 0; i < ARRAY_SIZE(pg_level); i++)
          if (pg_level[i].bits)
