Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDB74D0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGJJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGJJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:06:03 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7149FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:06:00 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qzylm1CG0zBHXhF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:05:56 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688979956; x=1691571957; bh=Q7yjvxrMTbuX88XtUMgBQdXnOJS
        T6lyZeot0NWWwG5Q=; b=X6ZD9PxGa7YFna+NDYUNl2I+8C1D9MEnVNMtAwyJwEu
        UaGlzitKaMTG3Bpi67tJ1wEknhHHn3TIx40/kNnF46dVtoTBkOtFXR4yrR6/BicU
        hVeBpMD4p/82yCUJcyBscbn26M8JcrLYUKGZYYe6zTZxLTxQgUSW7pa7pejHLV0p
        LK1kfE9sKzx+gUQUvFrgstqQqDtUtLWwHMeR2QKB7rP6a1NqxupJUzOkPTC29eq/
        nnj3Xzf7WiCst4HEJCFeIRb5+l8IhCfarOlTCqVnGi7Cs4nw2SE/IBEFMqIbbaCH
        J9I4KejKDbORbqM6Ok/SSShViN8ByJ2FDhfHwLJW2jw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nt5unJPHsA-9 for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 17:05:56 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qzyll5nZLzBHXR1;
        Mon, 10 Jul 2023 17:05:55 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 17:05:55 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: that open brace { should be on the
 previous line
In-Reply-To: <20230710090421.61623-1-xujianghui@cdjrlc.com>
References: <20230710090421.61623-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <77876ef2908eda36cb7f843145ec8cec@208suo.com>
X-Sender: sunran001@208suo.com
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

Fix eleven occurrences of the checkpatch.pl error:
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/rv770.c | 22 +++++++++++-----------
  1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rv770.c 
b/drivers/gpu/drm/radeon/rv770.c
index a5ce59d4a485..9ce12fa3c356 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -136,7 +136,7 @@ int rv770_set_uvd_clocks(struct radeon_device *rdev, 
u32 vclk, u32 dclk)
      return 0;
  }

-static const u32 r7xx_golden_registers[] ={
+static const u32 r7xx_golden_registers[] = {
      0x8d00, 0xffffffff, 0x0e0e0074,
      0x8d04, 0xffffffff, 0x013a2b34,
      0x9508, 0xffffffff, 0x00000002,
@@ -151,7 +151,7 @@ static const u32 r7xx_golden_registers[] ={
      0x7300, 0xffffffff, 0x001000f0
  };

-static const u32 r7xx_golden_dyn_gpr_registers[] ={
+static const u32 r7xx_golden_dyn_gpr_registers[] = {
      0x8db0, 0xffffffff, 0x98989898,
      0x8db4, 0xffffffff, 0x98989898,
      0x8db8, 0xffffffff, 0x98989898,
@@ -163,7 +163,7 @@ static const u32 r7xx_golden_dyn_gpr_registers[] ={
      0x88c4, 0xffffffff, 0x00000082
  };

-static const u32 rv770_golden_registers[] ={
+static const u32 rv770_golden_registers[] = {
      0x562c, 0xffffffff, 0,
      0x3f90, 0xffffffff, 0,
      0x9148, 0xffffffff, 0,
@@ -172,7 +172,7 @@ static const u32 rv770_golden_registers[] ={
      0x9698, 0x18000000, 0x18000000
  };

-static const u32 rv770ce_golden_registers[] ={
+static const u32 rv770ce_golden_registers[] = {
      0x562c, 0xffffffff, 0,
      0x3f90, 0xffffffff, 0x00cc0000,
      0x9148, 0xffffffff, 0x00cc0000,
@@ -183,7 +183,7 @@ static const u32 rv770ce_golden_registers[] ={
      0x9698, 0x18000000, 0x18000000
  };

-static const u32 rv770_mgcg_init[] ={
+static const u32 rv770_mgcg_init[] = {
      0x8bcc, 0xffffffff, 0x130300f9,
      0x5448, 0xffffffff, 0x100,
      0x55e4, 0xffffffff, 0x100,
@@ -340,7 +340,7 @@ static const u32 rv770_mgcg_init[] ={
      0x92a4, 0xffffffff, 0x00080007
  };

-static const u32 rv710_golden_registers[] ={
+static const u32 rv710_golden_registers[] = {
      0x3f90, 0x00ff0000, 0x00fc0000,
      0x9148, 0x00ff0000, 0x00fc0000,
      0x3f94, 0x00ff0000, 0x00fc0000,
@@ -349,7 +349,7 @@ static const u32 rv710_golden_registers[] ={
      0xa180, 0xffffffff, 0x00003f3f
  };

-static const u32 rv710_mgcg_init[] ={
+static const u32 rv710_mgcg_init[] = {
      0x8bcc, 0xffffffff, 0x13030040,
      0x5448, 0xffffffff, 0x100,
      0x55e4, 0xffffffff, 0x100,
@@ -407,7 +407,7 @@ static const u32 rv710_mgcg_init[] ={
      0x9150, 0xffffffff, 0x4d940000
  };

-static const u32 rv730_golden_registers[] ={
+static const u32 rv730_golden_registers[] = {
      0x3f90, 0x00ff0000, 0x00f00000,
      0x9148, 0x00ff0000, 0x00f00000,
      0x3f94, 0x00ff0000, 0x00f00000,
@@ -417,7 +417,7 @@ static const u32 rv730_golden_registers[] ={
      0xa180, 0xffffffff, 0x00003f3f
  };

-static const u32 rv730_mgcg_init[] ={
+static const u32 rv730_mgcg_init[] = {
      0x8bcc, 0xffffffff, 0x130300f9,
      0x5448, 0xffffffff, 0x100,
      0x55e4, 0xffffffff, 0x100,
@@ -538,7 +538,7 @@ static const u32 rv730_mgcg_init[] ={
      0x92a4, 0xffffffff, 0x00000005
  };

-static const u32 rv740_golden_registers[] ={
+static const u32 rv740_golden_registers[] = {
      0x88c4, 0xffffffff, 0x00000082,
      0x28a50, 0xfffffffc, 0x00000004,
      0x2650, 0x00040000, 0,
@@ -574,7 +574,7 @@ static const u32 rv740_golden_registers[] ={
      0x9698, 0x18000000, 0x18000000
  };

-static const u32 rv740_mgcg_init[] ={
+static const u32 rv740_mgcg_init[] = {
      0x8bcc, 0xffffffff, 0x13030100,
      0x5448, 0xffffffff, 0x100,
      0x55e4, 0xffffffff, 0x100,
