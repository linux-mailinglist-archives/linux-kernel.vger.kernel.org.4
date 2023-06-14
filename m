Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6072F32D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjFNDmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjFNDmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:42:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663F1B2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:42:42 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgrXT1J7TzBL4jS
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:30:17 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686713417; x=1689305418; bh=z5hs7QQbBqwpD+KWPgppc054WtM
        v2RQuhhpTxrICano=; b=dED6LWw05tOhaz9hDYFLzSGCGSi9t3mVI+5Jpr/2P6E
        kO2BjomTQ/dT2A/QWvyLnKPa7M5M1qdKpjyoJTKG9B5VcE1V5TRvuKlOmVbEilqM
        z1sSXVywgqJ9Ut0YWnsKn/ezSUKiitsnxyHb8APKfTbOSarz/xMecfsoD0Pkn6jV
        BNNi6a2NE8uBplE2h7J6nJTQRVAu8bPLbvHKdFRtqo2Jb/sFgEf2eSG+/vMWe0MC
        KoyeAh2mJEyOepkGNw3Vm0pqJbzr89yLI0k8UrbdQGiY6T2gATmcPrrl5fQgQpIL
        q7fYqk5WLOoi38in+jQZazntWV+shnBN0bmXGpb1Uow==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kfyzxSgUNCnm for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 11:30:17 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgrXS4fWGzBJLB4;
        Wed, 14 Jun 2023 11:30:16 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 11:30:16 +0800
From:   baomingtong001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        ave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] KVM: x86: remove unneeded variable
In-Reply-To: <20230614032736.13264-1-luojianhong@cdjrlc.com>
References: <20230614032736.13264-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <a2510fb15553a294236646321cf1b3a4@208suo.com>
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

arch/x86/kvm/emulate.c:1315:5-7: Unneeded variable: "rc".Return 
"X86EMUL_CONTINUE".
arch/x86/kvm/emulate.c:4559:5-7: Unneeded variable: "rc".Return 
"X86EMUL_CONTINUE".
arch/x86/kvm/emulate.c:1180:5-7: Unneeded variable: "rc".Return 
"X86EMUL_CONTINUE".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  arch/x86/kvm/emulate.c | 15 ++++++---------
  1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 936a397a08cd..7a7e29e4e203 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1177,7 +1177,6 @@ static int decode_modrm(struct x86_emulate_ctxt 
*ctxt,
  {
      u8 sib;
      int index_reg, base_reg, scale;
-    int rc = X86EMUL_CONTINUE;
      ulong modrm_ea = 0;

      ctxt->modrm_reg = ((ctxt->rex_prefix << 1) & 8); /* REX.R */
@@ -1199,16 +1198,16 @@ static int decode_modrm(struct x86_emulate_ctxt 
*ctxt,
              op->bytes = 16;
              op->addr.xmm = ctxt->modrm_rm;
              kvm_read_sse_reg(ctxt->modrm_rm, &op->vec_val);
-            return rc;
+            return X86EMUL_CONTINUE;
          }
          if (ctxt->d & Mmx) {
              op->type = OP_MM;
              op->bytes = 8;
              op->addr.mm = ctxt->modrm_rm & 7;
-            return rc;
+            return X86EMUL_CONTINUE;
          }
          fetch_register_operand(op);
-        return rc;
+        return X86EMUL_CONTINUE;
      }

      op->type = OP_MEM;
@@ -1306,13 +1305,12 @@ static int decode_modrm(struct x86_emulate_ctxt 
*ctxt,
          ctxt->memop.addr.mem.ea = (u32)ctxt->memop.addr.mem.ea;

  done:
-    return rc;
+    return X86EMUL_CONTINUE;
  }

  static int decode_abs(struct x86_emulate_ctxt *ctxt,
                struct operand *op)
  {
-    int rc = X86EMUL_CONTINUE;

      op->type = OP_MEM;
      switch (ctxt->ad_bytes) {
@@ -1327,7 +1325,7 @@ static int decode_abs(struct x86_emulate_ctxt 
*ctxt,
          break;
      }
  done:
-    return rc;
+    return X86EMUL_CONTINUE;
  }

  static void fetch_bit_operand(struct x86_emulate_ctxt *ctxt)
@@ -4556,7 +4554,6 @@ static unsigned imm_size(struct x86_emulate_ctxt 
*ctxt)
  static int decode_imm(struct x86_emulate_ctxt *ctxt, struct operand 
*op,
                unsigned size, bool sign_extension)
  {
-    int rc = X86EMUL_CONTINUE;

      op->type = OP_IMM;
      op->bytes = size;
@@ -4590,7 +4587,7 @@ static int decode_imm(struct x86_emulate_ctxt 
*ctxt, struct operand *op,
          }
      }
  done:
-    return rc;
+    return X86EMUL_CONTINUE;
  }

  static int decode_operand(struct x86_emulate_ctxt *ctxt, struct operand 
*op,
