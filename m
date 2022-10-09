Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9615F8B1C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJIMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJIMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:10:45 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 05:10:44 PDT
Received: from mail.galaxycrow.de (mail.galaxycrow.de [162.55.242.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08422B27
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:10:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57C95620F9;
        Sun,  9 Oct 2022 14:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galaxycrow.de;
        s=dkim; t=1665317049; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=47nDLmeP9CCnVKPlIg8SFdJ7QMltUB4o3PzBaMbLha8=;
        b=jkvtLgg01cJDalSjU3eysx98IJA7tNSjXX/rvdGJhC6cLHLhxQ5XR3r1dvkdETm1MSG99F
        25/daH6WlTxfU3eFnt6hPv0uIk387avE3OnHuI3+8DPSpzEngtZJcsw85KZxKHMe3vMDt9
        GTQpJ6msb6UwJklUccxkBMWTSUsh9dQYjtLadr85xCqcv/2bWQUT/SgRi1z/6tbYOf/weV
        4RHzUTXriiFNrPB7Y34dD1yOylF2E3kfZGbPDznJzQgNbM+miAOykXCEYttupMabWOpoax
        Xqh0r2p1FJbM/71UhQnzLLjeqrUpql9nITpmjKv8nvp+YZdpL+h1EMzYoAlDnQ==
Date:   Sun, 9 Oct 2022 14:03:40 +0200
From:   Cleo John <waterdev@galaxycrow.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed styling in riscv ucontext header
Message-ID: <20221009120340.GA41243@watet-ms7b87>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the two comments in ucontext.h by getting them up to the cody style proposed by torwalds. 
In my opinion this also improves the readability so I think this is a useful change to do.
Please also tell me if you have a different opinion.

Signed-off-by: Cleo John <waterdev@galaxycrow.de>
---
 arch/riscv/include/uapi/asm/ucontext.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
index 44eb993950e5..0cd6f8616985 100644
--- a/arch/riscv/include/uapi/asm/ucontext.h
+++ b/arch/riscv/include/uapi/asm/ucontext.h
@@ -18,7 +18,8 @@ struct ucontext {
 	/* There's some padding here to allow sigset_t to be expanded in the
 	 * future.  Though this is unlikely, other architectures put uc_sigmask
 	 * at the end of this structure and explicitly state it can be
-	 * expanded, so we didn't want to box ourselves in here. */
+	 * expanded, so we didn't want to box ourselves in here.
+	 */
 	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
 	/* We can't put uc_sigmask at the end of this structure because we need
 	 * to be able to expand sigcontext in the future.  For example, the
@@ -27,7 +28,8 @@ struct ucontext {
 	 * ucontext, so we're putting this at the end in order to allow for
 	 * infinite extensibility.  Since we know this will be extended and we
 	 * assume sigset_t won't be extended an extreme amount, we're
-	 * prioritizing this. */
+	 * prioritizing this.
+	 */
 	struct sigcontext uc_mcontext;
 };
 
-- 
2.25.1

