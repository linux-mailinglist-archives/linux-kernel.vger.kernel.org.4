Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06866057B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJTGx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTGx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:53:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1594115425;
        Wed, 19 Oct 2022 23:53:23 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8Cx7Nhi8FBjmPYAAA--.5042S3;
        Thu, 20 Oct 2022 14:53:22 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuNf8FBjZ8MBAA--.7461S3;
        Thu, 20 Oct 2022 14:53:20 +0800 (CST)
Message-ID: <7a425884-a387-5521-341a-1c32c3151b8c@loongson.cn>
Date:   Thu, 20 Oct 2022 14:53:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] docs/zh_CN: Add staging/xz Chinese translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1666181295.git.me@lirui.org>
 <52f8c1c138d0c2d799c57bba1b7c4cac4c0bf899.1666181295.git.me@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <52f8c1c138d0c2d799c57bba1b7c4cac4c0bf899.1666181295.git.me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxtuNf8FBjZ8MBAA--.7461S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4DKFWftryfCw48JFyxZrb_yoW3Xr1xpF
        n2gr97K3WxCry5AFy7KF1jgw18AFs3CF4xCFyxJ34rJwn5JFZFgw47ta45G3y3GryfZFyD
        ZFZrGry293y2y3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/22 20:11, Rui Li wrote:
> Translate the following files into Chinese:
>
> - Documentation/staging/xz.rst
>
> Signed-off-by: Rui Li <me@lirui.org>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
> Changes since v1:
> - Align title
> - Adjust patch set order
> - Add xz into index here
> ---
>   .../translations/zh_CN/staging/index.rst      |  6 +-
>   .../translations/zh_CN/staging/xz.rst         | 99 +++++++++++++++++++
>   2 files changed, 104 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/staging/xz.rst
>
> diff --git a/Documentation/translations/zh_CN/staging/index.rst b/Documentation/translations/zh_CN/staging/index.rst
> index e26603892a6f..bb55c81c84a3 100644
> --- a/Documentation/translations/zh_CN/staging/index.rst
> +++ b/Documentation/translations/zh_CN/staging/index.rst
> @@ -10,6 +10,11 @@
>   未分类文档
>   ==========
>   
> +.. toctree::
> +   :maxdepth: 2
> +
> +   xz
> +
>   TODOList:
>   
>   * crc32
> @@ -19,4 +24,3 @@ TODOList:
>   * speculation
>   * static-keys
>   * tee
> -* xz
> diff --git a/Documentation/translations/zh_CN/staging/xz.rst b/Documentation/translations/zh_CN/staging/xz.rst
> new file mode 100644
> index 000000000000..652c5c2a33d2
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/staging/xz.rst
> @@ -0,0 +1,99 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/staging/xz.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +===================
> +Linux中的XZ数据压缩
> +===================
> +
> +介绍
> +====
> +
> +XZ是一种通用的数据压缩格式，其具有高压缩率和相对快的解压速度。主要的压缩算法（
> +过滤器）是LZMA2。额外的过滤器可以被用来进一步提高压缩率，比如用来提高可执行数据
> +压缩率的Branch/Call/Jump (BCJ)过滤器。
> +
> +XZ解压器在Linux中被称作XZ Embedded。它支持LZMA2过滤器和可选的BCJ过滤器，并支持
> +CRC32完整性校验。你可以在XZ Embedded的主页<https://tukaani.org/xz/embedded.html>
> +中找到最新版本和关于在Linux内核之外使用源码的信息。
> +
> +对于用户空间来说，XZ Utils提供了类似于zlib的压缩库和类似于gzip的命令行工具。
> +XZ Utils可以从<https://tukaani.org/xz/>下载。
> +
> +内核中的XZ相关组件
> +==================
> +
> +xz_dec模块为XZ解压器提供了单次调用（缓冲区到缓冲区）和多次调用（有状态）的
> +API。xz_dec模块的用法记录在include/linux/xz.h中。
> +
> +xz_dec_test模块用于测试xz_dec。除非你想魔改XZ解压器，否则xz_dec_test是
> +没有用的。xz_dec_test会动态分配一个字符设备主设备号，你可以从用户空间向它
> +写入.xz文件，解压的输出会被丢弃。关注dmesg可以找到xz_dec_test输出的诊断信息。
> +详细内容请查看xz_dec_test的源码。
> +
> +为了解压内核镜像、初始ram文件系统和初始ram磁盘，lib/decompress_unxz.c实现
> +了一个包装函数。它的API与其他 decompress_*.c 文件相同，那些API定义在
> +include/linux/decompress/generic.h中。
> +
> +scripts/xz_wrap.sh是一个XZ Utils中的xz命令行工具包装器。这个包装器会
> +设置合适的压缩选项来压缩内核镜像。
> +
> +在内核的makefiles中，提供了使用$(call if_needed)的两个命令。内核镜像应该
> +使用$(call if_needed,xzkern)来压缩，它会使用BCJ过滤器和一个大LZMA2字典。
> +它还会附加一个四字节的包含源文件大小的预告，这会在启动代码中被用到。其他文件
> +应该使用$(call if_needed,xzmisc)来压缩，它会使用1 MiB的LZMA2字典并禁用
> +BCJ过滤器。
> +
> +关于压缩选项的说明
> +==================
> +
> +因为XZ Embedded只支持没有完整性校验的数据流或者CRC32，请确保你在编码未来将被
> +内核解码的文件时没有使用其他完整性校验方式。使用liblzma时，你需要使用LZMA_CHECK_NONE
> +或LZMA_CHECK_CRC32。使用xz命令行工具时，使用--check=none或--check=crc32。
> +
> +除非有其他环节会验证解压数据的完整性，否则强烈使用CRC32。双重验证可能会浪费
> +CPU周期。请注意头部总是会包含用于解压器验证的CRC32，你只能修改或禁用解压后数据
> +的完整性校验方式。
> +
> +在用户中间中，LZMA2通常使用几兆字节大小的字典。解码器需要在RAM中放置字典，
> +因此大字典不能被用于那些意在被内核解码的文件。1 MiB在内核中大概是可接受的最大
> +字典大小（可能对初始ram文件系统也适用）。XZ Utils中的预设值可能并不适合创建
> +内核文件，所以请别犹豫使用自定义设置。比如::
> +
> +	xz --check=crc32 --lzma2=dict=512KiB inputfile
> +
> +使用上面字典大小的一个例外是在单一调用模式下使用解码器。解压内核自身就是一个例
> +子。在单一调用模式下，内存用量并不和字典大小有关，这种情况就是使用大字典的好地
> +方：为了最大化压缩，字典至少应该和解压后的数据一样大。
> +
> +未来计划
> +========
> +
> +如果有人认为有用的话，可能会考虑创建一个受限的XZ编码器。LZMA2的压缩速率比Deflate
> +或LZO等要慢，即使在最快的配置选项下。所以并不清楚LZMA2编码器是否需要并入内核。
> +
> +有计划在解压代码中支持有限的随机访问读数据。不知道这能否在内核中有任何用，但是我
> +知道这会在一些Linux内核以外的嵌入式项目中有用。
> +
> +.xz文件格式规范的一致性
> +=======================
> +
> +在一些边缘情况下，为了简化事情牺牲了尽早地检测错误。因为并不会导致安全问题，实际
> +上是没有关系的。但在测试代码的时候知道这一点很好，比如测试来自XZ Utils的文件。
> +
> +报告错误
> +========
> +
> +请在报告错误前确认是否已经在上游修复。可以从<https://tukaani.org/xz/embedded.html>
> +获取最新的源码。
> +
> +可以通过联系<lasse.collin@tukaani.org>或者访问Freenode上的#tukaani
> +联系Larhzu。我并不经常阅读LKML或者其他内核相关的邮件列表，所以如果要告知我什么事情
> +，你应该通过我的私人邮箱或者IRC联系我。
> +
> +请不要因为内核中XZ的实现或关于XZ Utils的问题打扰Igor Pavlov。虽然这两种实现
> +包含了建立在Igor Pavlov的代码上的重要源码，但并不由他维护和提供支持。

