Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241BA6E31D4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDOO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDOO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:28:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99F4C22
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 07:28:31 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B56061EC056B;
        Sat, 15 Apr 2023 16:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681568908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mwISPKZyF6KmI+FUueGtvVaik+GhQkOgxGymbD8rgcw=;
        b=qtknd9+6JOJD+uzSQRTZ1Vws6IjvWgoE7YG1od5IfV1s1lYYnlKvBu9OIURXWd9nh0qWvi
        zcy80vcTelgS6GRBrX9tQsOxEgH2fz/kUQpptUIlSO7A5XpXzLTnQFdceeOikoUEiZL2dP
        nscAVBB3OpHlpufOVTpzvQLRqyqRHTs=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/microcode/AMD: Document which patches are not released for late loading
Date:   Sat, 15 Apr 2023 16:28:21 +0200
Message-Id: <20230415142821.24725-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

PeterZ wanted this spelled out explicitly. Add it to the documentation
so that everyone's on the same page wrt to which microcode patches are
not allowed to be late loaded.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/x86/microcode.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index 15b52e2b181d..d5ef9184030c 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -218,6 +218,10 @@ a fault happens, the whole core will see it either before the microcode
 patch has been applied or after. In either case, T0 and T1 will have the
 same microcode revision and nothing intermediate.
 
+In addition, microcode patches which modify software-visible features
+like CPUID bits, MSRs, chicken bits, etc are not released for late
+loading.
+
 Builtin microcode
 =================
 
-- 
2.35.1

