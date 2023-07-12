Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300275036E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGLJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGLJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:41:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0010EF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:41:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1CJy1JC7zBR7b3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:35:30 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689154530; x=1691746531; bh=nA3GRmY9/RJ0ro40xfeW+19T8CU
        NNZdAf1PzP3UoOcI=; b=JepDYFrXq5vMce1FfsfDkm/Kv3bxJOyPeV2eK53cwrz
        oeMIgTb111LQiTPPJZBMOamFOc43HXYfkT3h4Gj1zSlf01NLPFC47SfjY6hF4jBw
        4YWU5HHNnVXM1aQt3GI6/SywjK2kHPftkdgFnaNctEsgj8g0GMrE9UmVhNQQZ0+L
        PaGwCeOMFcLZJ8Zz7tDlAaBt8cD0AA+xdeWTzVWAfvG2aVaNvCHHlhQokZrkZ/z9
        Fllvsj66CWKEjix1nZyG4kpz+PgBC5vWFRrnr4ByodZUB8nrkc/RjP+BN+T/rKsW
        MuYEAKkxddPr1ABSnUZ6HIhnNRb66q8Pt/u6Z49o8Wg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2cNHp8N_iX_v for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 17:35:30 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1CJx65SpzBR7b0;
        Wed, 12 Jul 2023 17:35:29 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:35:29 +0800
From:   pangzizhen001@208suo.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] include/asm: Fix comment typo
In-Reply-To: <20230712093011.17133-1-wangjianli@cdjrlc.com>
References: <20230712093011.17133-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <0538c3e01d0991bc6bbca1aecca18044@208suo.com>
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

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  arch/arm/include/asm/unwind.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unwind.h 
b/arch/arm/include/asm/unwind.h
index d60b09a5acfc..a75da9a01f91 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@

  #ifndef __ASSEMBLY__

-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
  enum unwind_reason_code {
      URC_OK = 0,            /* operation completed successfully */
      URC_CONTINUE_UNWIND = 8,
