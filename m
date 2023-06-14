Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4472F767
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbjFNIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbjFNIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:07:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E326A8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:07:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgygs5dfMzBQgnm
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:07:05 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686730025; x=1689322026; bh=zhK88B2whr8OskPG/+tMULNkTtK
        T+KMo00QbU4r8aaE=; b=uHtoAGNzyQ9dJgPRLXp0slTNil7WpUbes6Cl3MZxYur
        dT6GdPx3WeZFLRNoDE1YSGrfbPPzhOOaFhmKUUKdVGw7jsCNGJSmEn5AkEb7rTKS
        O2FUBq3Lwmfvqi7fhK7AcKk6cQgu5Y+IvNig70l3VE1LCKqQBs0ait1nFDF4JZ1J
        7Wkk4q3GEakDcZZR+EwgmfQIzeTRtFYTIrwMFaa276Yp/upIvD54io94WaO4+zoz
        RxHPIII1mcJJCZLjMbhAF3Sfv0vJEvl7RE3GLVhLyo172FzfA69r+DEpzoK6IHGq
        aZp927LuSzpDnRO3/sIPuQ/7B/yNojz5/dBxoIPJD+w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k3FHURk-Z8Rt for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:07:05 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgygs24nzzBQJYp;
        Wed, 14 Jun 2023 16:07:05 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:07:05 +0800
From:   baomingtong001@208suo.com
To:     jesper.nilsson@axis.com, lars.persson@axis.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: Remove unneeded semicolon
In-Reply-To: <20230614080509.5947-1-luojianhong@cdjrlc.com>
References: <20230614080509.5947-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9fa20192233fad1306a0eacce1aaf6aa@208suo.com>
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

./arch/arm/mach-artpec/board-artpec6.c:42:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  arch/arm/mach-artpec/board-artpec6.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-artpec/board-artpec6.c 
b/arch/arm/mach-artpec/board-artpec6.c
index d3cf3e8603e8..c27e7bbcd7bc 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
           */
          regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
                   ARTPEC6_DMACFG_UARTS_BURST);
-    };
+    }
  }

  static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
