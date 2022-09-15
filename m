Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A75B9E02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIOPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIOPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:04:44 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E013E26
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:04:42 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so12871479edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=H32LKJ4QtRE8PW83scu/rnCN+O5l16ld3Egd+3MOYzM=;
        b=Z7D99KP/7kWnl5znToFpIf1yzLMq5Rl3cXYi/b07RUB4TDuaBOLLDYgebb40CGKG1L
         1zCtTBptLWIIE71BCILie+2r2YL30vZTv1M14oRjoZ84j37Qthbws8lENFDUTapFncHJ
         GMI/2NU3SzeX/kyx6KcZupV7AUQ3Ko6hrXIbFcW2S2DctuOcOUUhJU0Oim0IOCNK3Slv
         Et5wtGOTIMIY7gHgozwd25lD6l/zq9vpBHfdJEacezGicwlEFZgMQl9USowxIbe0UN9j
         WdCBEXFJTDUn1l0slw3ikke8yuPA7OPiHXDy0H4dUNtcUVd45sUoy/2pJE+/EkYb0XKl
         u/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=H32LKJ4QtRE8PW83scu/rnCN+O5l16ld3Egd+3MOYzM=;
        b=CFQnMTrUAOeOdkWoaaIOvPwTbtMHy9BsE6+7a33EfDDTZ0jIeebmWvuHH0vkCuVbDF
         Rv0r8j32jDw5ILGyPaBRc55pF5cj1dAOH+G4AgqaE202+8tjdXdVfFzEnoXagVHBwXpn
         wGW2RFTmOnV66JhZhGa7EAGFej98qM0CL8Za4ILbbg7iJip7QxVPQ1DhXRQRY4ixUN7e
         VpEoULGV7Mar5w6naf6Ku43cdQt7mIyH9ke3OtVpEcvHQsScj+H2RRhRDHv0giMXoYDG
         Nvt7O1u61ILyHQtUTNIRxY5jinuvx2ZLa9xH0Bm3SZlvTRgnmJGYRNhRhRh57ZXXpIQJ
         Mg0A==
X-Gm-Message-State: ACrzQf1VsC73ZAeaHLMMbGuCW0tRVEIgsDQkjzBOFQ9RR0+Ajdya/0yg
        B9Ip2aOENG/WyiY9DLSFOIFZ3Ga0eGA=
X-Google-Smtp-Source: AMsMyM5VSJ+y4oAY1cflJUKFEYKa2sNeJCpwHsdxCsIQ76K48TJwXnK+HBA3EP0jw8zgl0gp6zWhdtm0Ih0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr246547edb.333.1663254280120; Thu, 15
 Sep 2022 08:04:40 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:35 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-2-glider@google.com>
Subject: [PATCH v7 01/43] x86: add missing include to sparsemem.h
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

Including sparsemem.h from other files (e.g. transitively via
asm/pgtable_64_types.h) results in compilation errors due to unknown
types:

sparsemem.h:34:32: error: unknown type name 'phys_addr_t'
extern int phys_to_target_node(phys_addr_t start);
                               ^
sparsemem.h:36:39: error: unknown type name 'u64'
extern int memory_add_physaddr_to_nid(u64 start);
                                      ^

Fix these errors by including linux/types.h from sparsemem.h
This is required for the upcoming KMSAN patches.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ifae221ce85d870d8f8d17173bd44d5cf9be2950f
---
 arch/x86/include/asm/sparsemem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 6a9ccc1b2be5d..64df897c0ee30 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SPARSEMEM_H
 #define _ASM_X86_SPARSEMEM_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_SPARSEMEM
 /*
  * generic non-linear memory support:
-- 
2.37.2.789.g6183377224-goog

