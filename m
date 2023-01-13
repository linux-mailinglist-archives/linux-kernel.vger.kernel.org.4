Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D06697DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbjAMM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbjAMM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:58:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23D5B16D;
        Fri, 13 Jan 2023 04:45:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so52100634ejc.4;
        Fri, 13 Jan 2023 04:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcHErRJ45q81GGjXiRiribjr5Anofis06MFnaHfQP8A=;
        b=gE5v/WSVjrSut5xsLiOn7g1on0KaAbtIMutebQ2onxicQ+j4sdTSHu3jnH4FTYJg3t
         nVOsvPPcRVfY7T9THsEk7GLAWyEiRl4sB/zr6HnxnKXeuvJIZf1MEfDbFrIbgJIeu9Zn
         PQANGv90Y4oC10zujvSBzrdUCcKJ4wKBhaM3n2Qd4/7zV8F3cAbyJh6E+wISja3jxksG
         Ge3YjllyPU8HEU1EA/p41Aui0ZEsV/oHxR+e3f1Vnr8p04eDk/ODfvG5GUHhvi2N+3qf
         ephPmCC2NUBjWVYtAqrHWSeFobLjAjUtK/PtwiTK1wUmA5PQqDAvJ1/0P0INym8ELFTp
         jfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcHErRJ45q81GGjXiRiribjr5Anofis06MFnaHfQP8A=;
        b=33BLRoGY9s0zX/y/ftwHQYWOZoCb5Q5/mAPa+Vok8C0RRaKUWHeiAjLDYI+PNYUKhL
         bEhv+519IjZ96uH6cs9pTiCwAgCLkL6Iz3r1EJS1r1HFvLuJLqZyLfU4Lzaspe24KCIV
         Zs7RMYbnOT0SZAxBmAX53gNA0uDoOKYLRiqC0PwkEKARWUVRj91zjm5RdmIvOereHH4g
         f67pobrNO3ewEMg0sTEMWBe21QHRlvglK8Y7rjUEqPEw1uBBRM0Dxl9Pt6kg9YkrI3If
         Sp82NHvwNsl/1w4llFEzohMTZeCdgyu+tzo0WaowTqzoV5Geo8SsutZ84FN1ONSefvdz
         4KYQ==
X-Gm-Message-State: AFqh2kozShmX0rTEdFgWcv5m+XnVbSBNGV89YkkjogPoNpyXB/O0nqrn
        5ye6gCkahyIRj2oETFLJyic=
X-Google-Smtp-Source: AMrXdXvVr/9yNhQpjOFOJXlU0GdHaAOCYq+3W9OAzkBY/ShZ3eCuqjVnT1dNuTlNluFaFeVqoKIulQ==
X-Received: by 2002:a17:906:5a71:b0:84d:4a2b:73b9 with SMTP id my49-20020a1709065a7100b0084d4a2b73b9mr14662505ejc.59.1673613957932;
        Fri, 13 Jan 2023 04:45:57 -0800 (PST)
Received: from gmail.com ([31.46.242.235])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007c0b28b85c5sm8462298ejt.138.2023.01.13.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:45:57 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Jan 2023 13:45:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xin Li <xin3.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] x86/gsseg: Add the new <asm/gsseg.h> header to
 <asm/asm-prototypes.h>
Message-ID: <Y8FSgX0fDs5/SqSl@gmail.com>
References: <20230113125321.4c60d02f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113125321.4c60d02f@canb.auug.org.au>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> WARNING: modpost: EXPORT symbol "asm_load_gs_index" [vmlinux] version generation failed, symbol will not be versioned.
> Is "asm_load_gs_index" prototyped in <asm/asm-prototypes.h>?
> 
> Introduced by commit
> 
>   ae53fa187030 ("x86/gsseg: Move load_gs_index() to its own new header file")

Yeah - the new header moved the asm_load_gs_index() prototype out of the 
list of includes in <asm/asm-prototypes.h> - needs to be added explicitly. 
Patch below should solve this.

Thanks,

	Ingo

===========>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 13 Jan 2023 13:43:20 +0100
Subject: [PATCH] x86/gsseg: Add the new <asm/gsseg.h> header to <asm/asm-prototypes.h>

Module build needs to be able to pick up the C prototype:

  WARNING: modpost: EXPORT symbol "asm_load_gs_index" [vmlinux] version generation failed, symbol will not be versioned.
  Is "asm_load_gs_index" prototyped in <asm/asm-prototypes.h>?

Fixes: ae53fa187030 ("x86/gsseg: Move load_gs_index() to its own new header file")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8f80de627c60..b1a98fa38828 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/gsseg.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);


