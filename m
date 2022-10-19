Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E97C604576
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiJSMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJSMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:37:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC47E171CE3;
        Wed, 19 Oct 2022 05:17:32 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8AxDdnR6E9j2b8AAA--.3892S3;
        Wed, 19 Oct 2022 20:08:49 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDuLN6E9j7E0BAA--.5393S3;
        Wed, 19 Oct 2022 20:08:46 +0800 (CST)
Message-ID: <14a49844-8ac3-630b-bee2-fa9ea422cb52@loongson.cn>
Date:   Wed, 19 Oct 2022 20:08:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] docs/zh_CN: Add userspace-api/ebpf Chinese
 translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>
References: <cover.1666093699.git.me@lirui.org>
 <8d032bf9a69ac6703260ac91408562c562c03f2d.1666093699.git.me@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <8d032bf9a69ac6703260ac91408562c562c03f2d.1666093699.git.me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDuLN6E9j7E0BAA--.5393S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF17XrykGrWDAr1fGr18AFb_yoW5CFy5pF
        nakr1fGayfArW3Crn7Wr1xCFn7CF48WayUCw17J34Syr95tF9Yyr17tFWxGw43JryI9FWv
        qrsYqFyj934xZaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8CksDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/22 19:54, Rui Li wrote:
> Translate the following documents into Chinese:
>
> - userspace-api/ebpf/index.rst
> - userspace-api/ebpf/syscall.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
> Changes since v1:
> - Translate bpf subcommand title
> - Align title
> - Add space after doc path
> ---
>   .../zh_CN/userspace-api/ebpf/index.rst        | 22 +++++++++++++
>   .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 +++++++++++++++++++
>   2 files changed, 53 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
>
> diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
> new file mode 100644
> index 000000000000..d52c7052f101
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
> @@ -0,0 +1,22 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/ebpf/index.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +eBPF 用户空间API
> +================
> +
> +eBPF是一种在Linux内核中提供沙箱化运行环境的机制，它可以在不改变内核源码或加载
> +内核模块的情况下扩展运行时和编写工具。eBPF程序能够被附加到各种内核子系统中，包
> +括网络，跟踪和Linux安全模块(LSM)等。
> +
> +关于eBPF的内部内核文档，请查看 Documentation/bpf/index.rst 。
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   syscall
> diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
> new file mode 100644
> index 000000000000..17515728f544
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
> @@ -0,0 +1,31 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/ebpf/syscall.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +eBPF Syscall
> +------------
> +
> +:作者:
> +    - Alexei Starovoitov <ast@kernel.org>
> +    - Joe Stringer <joe@wand.net.nz>
> +    - Michael Kerrisk <mtk.manpages@gmail.com>
> +
> +bpf syscall的主要信息可以在 `man-pages`_ 中的 `bpf(2)`_ 找到。
> +
> +bpf() 子命令参考
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: include/uapi/linux/bpf.h
> +   :doc: eBPF Syscall Preamble
> +
> +.. kernel-doc:: include/uapi/linux/bpf.h
> +   :doc: eBPF Syscall Commands

This generates a lot of documentation in English.


See Documentation/translations/zh_CN/core-api/kernel-api.rst


Thanks,

Yanteng

> +
> +.. Links:
> +.. _man-pages: https://www.kernel.org/doc/man-pages/
> +.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html

