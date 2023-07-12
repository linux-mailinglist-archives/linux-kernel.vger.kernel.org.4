Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77E75037D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjGLJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjGLJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:45:06 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC8D10EF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:45:03 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1CWw456PzBR7b4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:45:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689155100; x=1691747101; bh=IaCpewkLQ0ZG/6p0J4gZVTIkck2
        SfVEL+4NQGXefsFU=; b=fSBWd3PTEYBRZaQ31oyYT9YsBB64Sg2x0T9hAhJetxE
        5bUEqWA6C2syBPOILXbzVtqb8LwhR6bGE7phXo4+W1MptxV+Inq14bkfMgeSKxeK
        8GilWISrS4OnqDkaCrl5VOU3hU0w0D9YpsiMDNPQOo41scMjklMQXodzTLnQ5B0s
        a7jjqzU2gX33qDOOiHrnVlGJyMQixGn6tXCVWPzWyD7LarXSnWct0lk5nB2+CVLd
        oRVDK1t2I/R7PGDbjr6n2/PCTNYEub80pN7mGz0jMMe3bTycFVLDPTXopr5X6avH
        tB10i6kh8S6IWqQDE9h7fzS2UqSFVuqoWL5HQ0QRTQw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e8sDI8-fX8dY for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 17:45:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1CWw243VzBR7b0;
        Wed, 12 Jul 2023 17:45:00 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:45:00 +0800
From:   pangzizhen001@208suo.com
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] s390/kernel: Fix comment typo
In-Reply-To: <20230712094239.16048-1-wangjianli@cdjrlc.com>
References: <20230712094239.16048-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <34bf6e8c9b846ad9fe716ff522b244be@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  arch/s390/kernel/sthyi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
      sctns->mac.infmval1 |= MAC_CNT_VLD;
  }

-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
  static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf 
*part_inf,
                           bool this_lpar,
                           void *diag224_buf,
