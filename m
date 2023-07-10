Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3160D74DD6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGJSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGJSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:36:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623201AA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so59167137b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689014157; x=1691606157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aa5lQRof/F8cmDC3HRDbQ84WnKxCQ1duxxw+zC9cpn4=;
        b=23a/BYJOg6q/fOh8fzxml3B4m2aOP1zFQvS2kQGJ08o95ldNeS0IPbiHDbR9gH9Fp6
         kR6Sl8+BgYjzrFsG6yb+Rkk6MNGZW8hEsapNMPKNtCJKuk6nYjCRdQQ+uQb3B9UfB++f
         utBahDQJYg1o4JuRkSh968uQqvT98b9OmdJjbsrIk3o42Fk2d/ok29nfEUL7UUhqzHJv
         prPYLaV/c2enA8e2PLnR/POxy31CGGLrstg7H7frJDcw+SCozmYUGTbmwg1dBvxg2NPq
         3w+buPLo/MfK/E/uNGpXJFH28p0Ada1smGQG/jSaDr/sxTRRhtnyAA/kKPGymQX7nGfJ
         8FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014157; x=1691606157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa5lQRof/F8cmDC3HRDbQ84WnKxCQ1duxxw+zC9cpn4=;
        b=Um+XivWGUvCkIlS2e+sMFe/KLvl/SEE2Df1oDUSEqpZr7z0bDqCTl/PGsLXfQtm7FJ
         y1fCOIPzU2L6ZwUdmntficWywIfkft36mp3RCvyf1swmMgY15PuFml5OGnIA2SokCfCC
         GGK6KJnyWcmwnDYEXz+2dtil2gu2kO6Mo6CF9ibI0UaIrSG1+hd1QLZNTbcwimwjV550
         niC1bqNiBO8AMRPXVj2oRBzVZLgFWfOV872qqr7mtqgC2IKRlip64RE+jf86HYWwjugq
         qhSrq31ZU/ISBE5uzTwDLij45GDnfHLkGyk4qrMFXuOSeOuYFcNUrNt5QmYiO7R0VWIp
         F5kw==
X-Gm-Message-State: ABy/qLaVVlZhPEfkKcJRmuddTil/wHmm4/INPKHJPjUrVwUlOke8iCsa
        ynLGsAyoI2K8qxFQGkyZzrrWhXKD/hnLPQs1uLY=
X-Google-Smtp-Source: APBJJlF1HS/nqxQGVVm7Sw+Lyqck7QIthyrJFOTZrHwkstg/4ASzhXm/9W1XHOsTeD182p89+d7OuhX8FazlF9+8Pwg=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:b3c3:0:b0:569:e04a:239d with SMTP
 id r186-20020a81b3c3000000b00569e04a239dmr97416ywh.0.1689014157245; Mon, 10
 Jul 2023 11:35:57 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:35:50 +0000
In-Reply-To: <20230710183544.999540-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230710183544.999540-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=samitolvanen@google.com;
 h=from:subject; bh=kymeq10zoWFqiY+GAwwmAwqNZBv1fmNg5qliMfkaSfY=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBkrE+BqQqqxzq7jHsOZNuj+FFSkh4kaftmf8PyY
 jDkFEmsHKSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZKxPgQAKCRBMtfaEi7xW
 7hR1DACL7wNpbhOW9RbbJ6wgRvYcoTTSZDHUgsClXupLaaeipyUO9QC9zsPf4Q1iemCy/NFGNyC
 JF7AS7FxhKhD5Cc5XVhwyColrHi1xcvd6H9jUoiE6UhKSdLbDa11uc/dH6nMQk1B7K8bUV8dq7y
 BTGqNZBzFvNBEXKspIzcxH+1qhZUKR5L+PcoVhaM1MPO22DQXRL7bBhknQ68Q4DNRNN/fEhIFd/
 x1VO+WAhzdrmbt0UsBsYs8Iins8w4y3rr5takR5uFJjejP9YWDAusk8aDsuvoWfbYgMEh5xbCxa
 1Fj/kfCx+v2CLL5VbmgP5kseMz5eTtbE1oxt4oMWlYHEMHcUwrS7+8W2qXt0k99dOtQnHVRZRuP
 8luFpa8IutHZkKTVnPrLhUyCkK1TJjo4EjU8L589pXW39fW/up+mozwX985Km0FeB3Z220FUTGL zfFr01PoMwotR0AcrDE2aotdqMYL1mWrkB1IF3Umg3PtPxFoKaU+zURdOn13bxn/CxtbI=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710183544.999540-13-samitolvanen@google.com>
Subject: [PATCH v2 5/6] riscv/purgatory: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter out CC_FLAGS_CFI when CONFIG_CFI_CLANG.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dc20e166983e..9e6476719abb 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -77,6 +77,10 @@ ifdef CONFIG_STACKPROTECTOR_STRONG
 PURGATORY_CFLAGS_REMOVE		+= -fstack-protector-strong
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.41.0.255.g8b1d071c50-goog

