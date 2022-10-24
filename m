Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2E609843
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJXCgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJXCgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:36:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A1D5D713;
        Sun, 23 Oct 2022 19:36:11 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8CxbbcY+lVj7PIBAA--.2975S3;
        Mon, 24 Oct 2022 10:36:08 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuAX+lVjrA4EAA--.15509S3;
        Mon, 24 Oct 2022 10:36:08 +0800 (CST)
Message-ID: <c1e392fe-ea42-0677-bff2-4d13f8170933@loongson.cn>
Date:   Mon, 24 Oct 2022 10:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] docs/zh_CN: Update the translation of page_owner
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, alexs@kernel.org
Cc:     corbet@lwn.net, bobwxc@email.cn, rppt@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022170033.27123-1-caoyixuan2019@email.szu.edu.cn>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20221022170033.27123-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuAX+lVjrA4EAA--.15509S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF1fury7Xr1rJFWfAF1UJrb_yoW8tFWUpF
        ZIv34xWF1fAr15u34xC39Fyr18CF4fJF48KF4UJ3s7uw1DA395A39rKa409ay7XryvvrZr
        JF4SyFyvywn2v37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/23/22 01:00, Yixuan Cao wrote:
> Update to commit 0719fdba5483 ("Documentation/mm/page_owner.rst:
> delete frequently changing experimental data").
>
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   .../translations/zh_CN/mm/page_owner.rst        | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
> index 21a6a0837d42..2c4c02aab120 100644
> --- a/Documentation/translations/zh_CN/mm/page_owner.rst
> +++ b/Documentation/translations/zh_CN/mm/page_owner.rst
> @@ -34,20 +34,9 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>   一样进行。这两个不可能的分支应该不会影响到分配的性能，特别是在静态键跳转标签修补
>   功能可用的情况下。以下是由于这个功能而导致的内核代码大小的变化。
>   
> -- 没有page owner::
> -
> -   text    data     bss     dec     hex filename
> -   48392   2333     644   51369    c8a9 mm/page_alloc.o
> -
> -- 有page owner::
> -
> -   text    data     bss     dec     hex filename
> -   48800   2445     644   51889    cab1 mm/page_alloc.o
> -   6662     108      29    6799    1a8f mm/page_owner.o
> -   1025       8       8    1041     411 mm/page_ext.o
> -
> -虽然总共增加了8KB的代码，但page_alloc.o增加了520字节，其中不到一半是在hotpath
> -中。构建带有page owner的内核，并在需要时打开它，将是调试内核内存问题的最佳选择。
> +尽管启用page owner增加了几千字节的代码，但是这些代码的大部分都不在页分配器和它
> +的热路径中。构建带有page owner的内核，并在需要时打开它，将是调试内核内存问题的
> +最佳选择。
>   
>   有一个问题是由实现细节引起的。页所有者将信息存储到struct page扩展的内存中。这
>   个内存的初始化时间比稀疏内存系统中的页面分配器启动的时间要晚一些，所以，在初始化

