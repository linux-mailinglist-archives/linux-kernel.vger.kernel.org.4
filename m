Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A46057BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJTG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJTG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:57:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA7B127428;
        Wed, 19 Oct 2022 23:57:09 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8DxTttD8VBj0_YAAA--.4967S3;
        Thu, 20 Oct 2022 14:57:07 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuJB8VBj0MMBAA--.7361S3;
        Thu, 20 Oct 2022 14:57:05 +0800 (CST)
Message-ID: <6826d42e-d4c9-0675-8150-2d65111d2016@loongson.cn>
Date:   Thu, 20 Oct 2022 14:57:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/2] docs/zh_CN: Add userspace-api/ebpf Chinese
 translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1666185911.git.me@lirui.org>
 <cdd100d92752f76827fa7abfcd9903b857d71044.1666185911.git.me@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <cdd100d92752f76827fa7abfcd9903b857d71044.1666185911.git.me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuJB8VBj0MMBAA--.7361S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF17Xry3GFy3Gr13Ww43GFg_yoWrJFyfpr
        nakryfK3WfArW3Cr97GFnrGFn7C3W8WayUCw47Jw1Fv3s5GF9Yyr17trWxKw13JrWIvay0
        qws5tFyUu342y3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
        JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/22 21:30, Rui Li wrote:
> Translate the following documents into Chinese:
>
> - userspace-api/ebpf/index.rst
> - userspace-api/ebpf/syscall.rst
>
> Signed-off-by: Rui Li <me@lirui.org>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
> Changes since v2:
> - Remove long English reference
> - Remove ebpf from TODO
>
> Changes since v1:
> - Translate bpf subcommand title
> - Align title
> - Add space after doc path
> ---
>   .../zh_CN/userspace-api/ebpf/index.rst        | 22 ++++++++++++++
>   .../zh_CN/userspace-api/ebpf/syscall.rst      | 29 +++++++++++++++++++
>   .../zh_CN/userspace-api/index.rst             |  6 +++-
>   3 files changed, 56 insertions(+), 1 deletion(-)
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
> index 000000000000..47e2a59ae45d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
> @@ -0,0 +1,29 @@
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
> +~~~~~~~~~~~~~~~~
> +
> +子命令在以下内核代码中：
> +
> +include/uapi/linux/bpf.h
> +
> +.. Links:
> +.. _man-pages: https://www.kernel.org/doc/man-pages/
> +.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
> index 3b834fe7e33b..12c63d81c663 100644
> --- a/Documentation/translations/zh_CN/userspace-api/index.rst
> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
> @@ -21,6 +21,11 @@ Linux 内核用户空间API指南
>   
>   	   目录
>   
> +.. toctree::
> +   :maxdepth: 2
> +
> +   ebpf/index
> +
>   TODOList:
>   
>   * no_new_privs
> @@ -29,7 +34,6 @@ TODOList:
>   * unshare
>   * spec_ctrl
>   * accelerators/ocxl
> -* ebpf/index
>   * ioctl/index
>   * iommu
>   * media/index

