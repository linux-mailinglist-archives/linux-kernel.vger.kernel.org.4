Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8066FC041
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjEIHNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjEIHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:13:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5956E6E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:13:28 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.100.1])
        by gateway (Coremail) with SMTP id _____8BxZ+mX8llk8d8GAA--.11335S3;
        Tue, 09 May 2023 15:13:27 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.100.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axmr2W8llkNUBSAA--.16210S3;
        Tue, 09 May 2023 15:13:27 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Select HAVE_DEBUG_KMEMLEAK to support kmemleak
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <1683614971-10744-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <68984bbb-4ccc-51f8-7d4b-b1ae08a43c52@loongson.cn>
Date:   Tue, 9 May 2023 15:13:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1683614971-10744-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axmr2W8llkNUBSAA--.16210S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF1rXw47Wr4kCFyftryrWFg_yoW5Zryrpa
        9ruanxJr4fJr1Yy3yqqFy7XF47JFZ7Gay2gF1FyFy8GFyDAF95Zr1fKFZ5WFn8C3yrXFW8
        WF40g345Zr47C3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5WrAUUUUU=
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu

On 05/09/2023 02:49 PM, Tiezhu Yang wrote:
> We can see that DEBUG_KMEMLEAK depends on HAVE_DEBUG_KMEMLEAK after
> commit b69ec42b1b19 ("Kconfig: clean up the long arch list for the
> DEBUG_KMEMLEAK config option"), just select HAVE_DEBUG_KMEMLEAK to
> support kmemleak on LoongArch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> This is based on 6.4-rc1
>
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066..1e64edd 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -90,6 +90,7 @@ config LOONGARCH
>  	select HAVE_ASM_MODVERSIONS
>  	select HAVE_CONTEXT_TRACKING_USER
>  	select HAVE_C_RECORDMCOUNT
> +	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>

At the same time, you need to modify the loongarch in arch-support.txt
to ok.

BTW, we can submit a separate patch to modify the features already
supported by LoongArch.

The following features are already supported in LoongArch.

diff --git 
a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt 
b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index bcc29d3aba9a..38a0a54b79f5 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -13,7 +13,7 @@
      |        csky: |  ok  |
      |     hexagon: | TODO |
      |        ia64: | TODO |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
      |        m68k: | TODO |
      |  microblaze: | TODO |
      |        mips: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt 
b/Documentation/features/debug/kprobes/arch-support.txt
index 8a77d62a42c5..aad83b57587a 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -13,7 +13,7 @@
      |        csky: |  ok  |
      |     hexagon: | TODO |
      |        ia64: |  ok  |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
      |        m68k: | TODO |
      |  microblaze: | TODO |
      |        mips: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt 
b/Documentation/features/debug/kretprobes/arch-support.txt
index cf4723c5ac55..61380010a4a7 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -13,7 +13,7 @@
      |        csky: |  ok  |
      |     hexagon: | TODO |
      |        ia64: |  ok  |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
      |        m68k: | TODO |
      |  microblaze: | TODO |
      |        mips: |  ok  |
diff --git 
a/Documentation/features/debug/stackprotector/arch-support.txt 
b/Documentation/features/debug/stackprotector/arch-support.txt
index 71cd4ba18f7d..4c64c5d596f7 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -13,7 +13,7 @@
      |        csky: |  ok  |
      |     hexagon: | TODO |
      |        ia64: | TODO |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
      |        m68k: | TODO |
      |  microblaze: | TODO |
      |        mips: |  ok  |

Thanks,
Youling.

