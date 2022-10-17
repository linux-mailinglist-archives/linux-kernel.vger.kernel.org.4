Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B393B6023DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJRFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJRFjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:39:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CADE7A027A;
        Mon, 17 Oct 2022 22:39:04 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8DxPdnQVk1j0xEAAA--.494S3;
        Mon, 17 Oct 2022 21:21:20 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxj+DMVk1jyiAAAA--.559S3;
        Mon, 17 Oct 2022 21:21:17 +0800 (CST)
Message-ID: <3a553a28-45fb-bbab-80ad-2b2b0f45b3a1@loongson.cn>
Date:   Mon, 17 Oct 2022 21:21:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] docs/zh_CN: Add userspace-api/ebpf Chinese
 translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <166592153626.7.4500669936128595360.69288105@lirui.org>
 <166592153928.7.17506607549803320212.69288112@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>
In-Reply-To: <166592153928.7.17506607549803320212.69288112@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxj+DMVk1jyiAAAA--.559S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw4ktFy5ZFyxtrWxKFWxZwb_yoW5Cr45pF
        n3CF1fGayfArW3Crn7CF18CFn7CF18XayUAw47Xw1fAr95tF9Yyr17tFW7Kw43Jr1I9FWv
        qwsYqFWY934xZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bIkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8w
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
        vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUSdgUUUUU=
X-Gw-Check: b8d9fc5d79e760fb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC  wu.xiangcheng@linux.dev

On 10/16/22 19:58, Rui Li wrote:
> Translate the following documents into Chinese:
>
> - userspace-api/ebpf/index.rst
> - userspace-api/ebpf/syscall.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>   .../zh_CN/userspace-api/ebpf/index.rst        | 22 +++++++++++++
>   .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 +++++++++++++++++++
>   2 files changed, 53 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
>
> diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
> new file mode 100644
> index 000000000000..9f0af275eb69
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
> +==================
Alignment is required here, please remove some "=" .
> +
> +eBPF是一种在Linux内核中提供沙箱化运行环境的机制，它可以在不改变内核源码或加载
> +内核模块的情况下扩展运行时和编写工具。eBPF程序能够被附加到各种内核子系统中，包
> +括网络，跟踪和Linux安全模块(LSM)等。
> +
> +关于eBPF的内部内核文档，请查看 Documentation/bpf/index.rst。

.../index.rst。 -> .../index.rst 。

> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   syscall
> diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
> new file mode 100644
> index 000000000000..56bfa9bc7887
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
> +bpf() subcommand reference

Translate it into Chinese.


Thanks,

Yanteng

> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: include/uapi/linux/bpf.h
> +   :doc: eBPF Syscall Preamble
> +
> +.. kernel-doc:: include/uapi/linux/bpf.h
> +   :doc: eBPF Syscall Commands
> +
> +.. Links:
> +.. _man-pages: https://www.kernel.org/doc/man-pages/
> +.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html

