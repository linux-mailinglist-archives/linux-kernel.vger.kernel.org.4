Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E88750285
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjGLJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjGLJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:07:03 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31C10EF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:06:36 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1BgX59m1zBR5lR
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:06:32 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689152792; x=1691744793; bh=TIXOAi2D/V9YUoSzSJYpAgnKBT0
        W5l3abSG9/ysYwPA=; b=PqDQapT+iPYoYi3Vw9/oRg9tJOTF1CarUqAt6Bki3z2
        ESWE/fCpkrcTt//F9HHA9ei3l/jThrleBlxaZJfp8leodxk6QajqL2fn4BJdespQ
        y4J6CiVarNsmrUQVbuFVucNQHPYYgQyRNI3pzFcI4jvLgg3bvxpRy/ME+bVSjmsL
        r0ujoT2xE7BpaZggz3llR+W1n604+31OOWP1MJKYGqldgNo7XbNBo1yquvrTIXQz
        EoiQk4O+EOmwLO3DhpqdPqufaV50/qc1Gk9jWXvlNyIe537493bgT3QmFA/rt0eN
        2O/zXCrfz3YrA1qBIKga8eTECYw0fGBuT782wgQJVdg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DuXCfbINQLrn for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 17:06:32 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1BgX2jxczBR5CB;
        Wed, 12 Jul 2023 17:06:32 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:06:32 +0800
From:   shijie001@208suo.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mm: Fix warnings in context.c
In-Reply-To: <tencent_B7B25B0AACAECB0523A2B09F270CF97BFF07@qq.com>
References: <tencent_B7B25B0AACAECB0523A2B09F270CF97BFF07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <60fb2068b0ee6ce2a67333c81ccd2f6b@208suo.com>
X-Sender: shijie001@208suo.com
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

The following checkpatch warning is removed:
WARNING: Use #include <linux/mmu_context.h> instead of 
<asm/mmu_context.h>

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  arch/arm/mm/context.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 4204ffa2d104..c84ad6c786e7 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -13,7 +13,7 @@
  #include <linux/smp.h>
  #include <linux/percpu.h>

-#include <asm/mmu_context.h>
+#include <linux/mmu_context.h>
  #include <asm/smp_plat.h>
  #include <asm/thread_notify.h>
  #include <asm/tlbflush.h>
