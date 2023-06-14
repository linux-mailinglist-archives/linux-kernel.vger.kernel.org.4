Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0472F2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbjFNCwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbjFNCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:52:11 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CCA1FFC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:51:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgqgq3cgTzBJL9q
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:51:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686711095; x=1689303096; bh=CCN25bbIwKKA08BngAtwGiU6p+B
        /XQqOhcZ2yRbFbnE=; b=PXy+aBSnLznMym4e+raVReiyDr2JJVJiTArdY6oM3Bu
        7PpcOxZghE43gEUCD48EZLpBYpbLTRflqBgZl3ic+eQIzQ1z7dZwT2W/x2It79zL
        q4Lf1rRm187JMiTysaqCyA/7rwHxQQhe82Ovw9w62NJq5LjTaQ4PzMOWNxgSR/jQ
        c/DuaPN/OmnsqjPQSEoz79HMTStQ4cOLGCgjRrc4vlTTqVhDP6Nrh66otnEkzoDL
        PhqeupLwCs3ZtHt9t+CKFspkqpcd+rtJo2agUNgEEp6XDuWVfW7cW3WBk8dcEGgp
        bx1148OfMG7kQXU73bcBUxrLFM9xha84I86GJV835Sg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K_Lo57TK0DLS for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 10:51:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgqgq1zgQzBJ9pH;
        Wed, 14 Jun 2023 10:51:35 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 10:51:35 +0800
From:   baomingtong001@208suo.com
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: remove unneeded variable
In-Reply-To: <20230614024408.46240-1-luojianhong@cdjrlc.com>
References: <20230614024408.46240-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <998d4901de43fa640b3c383bfb6c923b@208suo.com>
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

arch/mips/cavium-octeon/executive/cvmx-spi.c:108:5-8: Unneeded variable: 
"res".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  arch/mips/cavium-octeon/executive/cvmx-spi.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c 
b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index 1f8b85473677..5906cc551f75 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -105,10 +105,9 @@ void cvmx_spi_set_callbacks(cvmx_spi_callbacks_t 
*new_callbacks)
  int cvmx_spi_start_interface(int interface, cvmx_spi_mode_t mode, int 
timeout,
                   int num_ports)
  {
-    int res = -1;

      if (!(OCTEON_IS_MODEL(OCTEON_CN38XX) || 
OCTEON_IS_MODEL(OCTEON_CN58XX)))
-        return res;
+        return -1;

      /* Callback to perform SPI4 reset */
      INVOKE_CB(cvmx_spi_callbacks.reset_cb, interface, mode);
@@ -130,7 +129,7 @@ int cvmx_spi_start_interface(int interface, 
cvmx_spi_mode_t mode, int timeout,
      /* Callback to handle interface coming up */
      INVOKE_CB(cvmx_spi_callbacks.interface_up_cb, interface, mode);

-    return res;
+    return -1;
  }

  /*
