Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195736CF99A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjC3Ddq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3Ddn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:33:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 099B74ED5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:33:40 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJAwTAyVkNDIUAA--.30811S3;
        Thu, 30 Mar 2023 11:33:39 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axmr0SAyVks_MQAA--.11425S3;
        Thu, 30 Mar 2023 11:33:39 +0800 (CST)
Subject: Re: loongarch wakeup build error
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <11215033-fa3c-ecb1-2fc0-e9aeba47be9b@infradead.org>
Cc:     loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <af6281f5-9c6c-d2d7-5978-b637b8d18473@loongson.cn>
Date:   Thu, 30 Mar 2023 11:33:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <11215033-fa3c-ecb1-2fc0-e9aeba47be9b@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axmr0SAyVks_MQAA--.11425S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFyfCFykur45Cr18GF4Uurg_yoW8Aw17p3
        9Fvryrtw4Fkr95X3yDJ3s8WF98Jrn8G34IgFWay348CF47Ww15Zrn2k34kWF1jg3s5GFW0
        9rWxJan09F4UJa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2023 06:55 AM, Randy Dunlap wrote:
> Hi,
>
> I don't know if this has been reported previously, so here goes.
>
> When CONFIG_SUSPEND is not set:
>
> loongarch64-linux-ld: drivers/acpi/sleep.o: in function `acpi_pm_prepare':
> sleep.c:(.text+0x278): undefined reference to `loongarch_wakeup_start'
> loongarch64-linux-ld: sleep.c:(.text+0x27c): undefined reference to `loongarch_wakeup_start'
> loongarch64-linux-ld: sleep.c:(.text+0x27c): undefined reference to `loongarch_wakeup_start'
>
> A complete randconfig file is attached.
>

I can reproduce this build error on LoongArch.

Here is the call trace:

acpi_pm_prepare()
   __acpi_pm_prepare()
     acpi_sleep_prepare()
       acpi_get_wakeup_address()
         loongarch_wakeup_start()


loongarch_wakeup_start() is defined in arch/loongarch/power/suspend_asm.S
which is built under CONFIG_SUSPEND. In order to fix the build error, just
define a empty loongarch_wakeup_start() if CONFIG_SUSPEND is not set.

diff --git a/arch/loongarch/include/asm/acpi.h 
b/arch/loongarch/include/asm/acpi.h
index 4198753aa1d0..7b812a836a5a 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -39,9 +39,14 @@ extern int loongarch_acpi_suspend(void);
  extern int (*acpi_suspend_lowlevel)(void);
  extern void loongarch_suspend_enter(void);

+#ifdef CONFIG_SUSPEND
+extern void loongarch_wakeup_start(void);
+#else
+static inline void loongarch_wakeup_start(void) {}
+#endif
+
  static inline unsigned long acpi_get_wakeup_address(void)
  {
-	extern void loongarch_wakeup_start(void);
  	return (unsigned long)loongarch_wakeup_start;
  }

If the above change makes sense, I will send a formal patch later.

Thanks,
Tiezhu

