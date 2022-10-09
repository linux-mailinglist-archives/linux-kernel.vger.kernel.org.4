Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6415F895A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 06:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJIEeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 00:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIEeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 00:34:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44F222AE23
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 21:34:04 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2s1T0JjdhUpAA--.16714S3;
        Sun, 09 Oct 2022 12:33:58 +0800 (CST)
Subject: Re: [PATCH v3] checksyscalls: Ignore fstat to silence build warning
 on LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>
References: <1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f794e452-eb04-88df-afa8-991bd40eb3d6@loongson.cn>
Date:   Sun, 9 Oct 2022 12:33:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx_2s1T0JjdhUpAA--.16714S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8XF17JFW8Xw1rZryfCrg_yoW8Aw1kp3
        WSka40vrWkGF18u3ZF93W8tryxZw13CFn7KFn8urZ8AF90ga1ktrySva98GFnFq3ySga4U
        Wr4kXa47WF1jkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xUyHKuUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/30/2022 11:27 AM, Tiezhu Yang wrote:
> fstat is replaced by statx on the new architecture, so an exception
> is added to the checksyscalls script to silence the following build
> warning on LoongArch:
>
>   CALL    scripts/checksyscalls.sh
> <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]

Hi all,

The above warning still exists when build the latest loongarch-next.

Do you know which tree this patch will go through?

Could you please pick it up via your tree in this merge window?

https://lore.kernel.org/lkml/1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn/

Thanks,
Tiezhu

>
> Suggested-by: WANG Xuerui <kernel@xen0n.name>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> Hi Xuerui and Arnd,
>
> Thank you for your reviews and suggestions.
>
> v3:
>   -- Move the definition to its own block with some explanation
>
> v2:
>   -- Change scripts/checksyscalls.sh
>   -- Modify patch subject and commit message
>
>  scripts/checksyscalls.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index f33e61a..1e5d2ee 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -114,7 +114,6 @@ cat << EOF
>  #define __IGNORE_truncate
>  #define __IGNORE_stat
>  #define __IGNORE_lstat
> -#define __IGNORE_fstat
>  #define __IGNORE_fcntl
>  #define __IGNORE_fadvise64
>  #define __IGNORE_newfstatat
> @@ -255,6 +254,9 @@ cat << EOF
>  /* 64-bit ports never needed these, and new 32-bit ports can use statx */
>  #define __IGNORE_fstat64
>  #define __IGNORE_fstatat64
> +
> +/* Newer ports are not required to provide fstat in favor of statx */
> +#define __IGNORE_fstat
>  EOF
>  }
>
>

