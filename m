Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B472F2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjFNCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFNCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:40:55 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C52C2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:40:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgqRJ3zXCzBJLB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:40:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686710444; x=1689302445; bh=wJPntn2KP3vFpRxmuRRSKniFJHD
        mT3nZqjhQqa1OpW4=; b=xlC1stASRlstXWrv9+GzfFIjOi/mLND7OGEpPvS6/gS
        SOqpE1tHtHG9wa4Hqpz8qnMwuqSjQnsRF5SBMqQwEifFLXvi0o7Rs7M+3Y3869wx
        zFEVSyvSkAy6Muv+prAeMq5W0OZ0xPt7bFvdfK/27WMCr4MNKJDj6cCD187KjttO
        NzRyaQlRGHaYMfRu6RcnH8leqnIJg2ceAlYrYZp38a/1Odv+/RUaZqIbiKaZ+ehh
        m2Rk9wKlIV+/5dSSDWUur05zkUT4SYwSm1v4soMtazZEtMVBdk2vMCllTYFPKpyz
        usBORqYi+fyT/L2x9D9OKdZZzkozsfw9srZRd9Oe2Ag==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JGEUPoyyJ8rZ for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 10:40:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgqRJ23WJzBJL98;
        Wed, 14 Jun 2023 10:40:44 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 10:40:44 +0800
From:   baomingtong001@208suo.com
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: remove unneeded variable
In-Reply-To: <20230614023829.23752-1-luojianhong@cdjrlc.com>
References: <20230614023829.23752-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ce48e2d625bdd4766496d44ae089e9de@208suo.com>
X-Sender: baomingtong001@208suo.com
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

fix the following coccicheck warning:

arch/mips/cavium-octeon/executive/cvmx-spi.c:152:5-8: Unneeded variable: 
"res".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  arch/mips/cavium-octeon/executive/cvmx-spi.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c 
b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index eb9333e84a6b..1f8b85473677 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -149,10 +149,9 @@ int cvmx_spi_start_interface(int interface, 
cvmx_spi_mode_t mode, int timeout,
   */
  int cvmx_spi_restart_interface(int interface, cvmx_spi_mode_t mode, int 
timeout)
  {
-    int res = -1;

      if (!(OCTEON_IS_MODEL(OCTEON_CN38XX) || 
OCTEON_IS_MODEL(OCTEON_CN58XX)))
-        return res;
+        return -1;

      cvmx_dprintf("SPI%d: Restart %s\n", interface, modes[mode]);

@@ -175,7 +174,7 @@ int cvmx_spi_restart_interface(int interface, 
cvmx_spi_mode_t mode, int timeout)
      /* Callback to handle interface coming up */
      INVOKE_CB(cvmx_spi_callbacks.interface_up_cb, interface, mode);

-    return res;
+    return -1;
  }
  EXPORT_SYMBOL_GPL(cvmx_spi_restart_interface);
