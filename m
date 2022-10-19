Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55936043BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJSLrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiJSLrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:47:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D135E122BCC;
        Wed, 19 Oct 2022 04:26:35 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8Bx3NiX3k9jf70AAA--.3927S3;
        Wed, 19 Oct 2022 19:25:11 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuKW3k9jnUkBAA--.5369S3;
        Wed, 19 Oct 2022 19:25:11 +0800 (CST)
Message-ID: <ceb6193f-8cd6-15c0-8965-f8496e7732cd@loongson.cn>
Date:   Wed, 19 Oct 2022 19:25:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] docs/zh_CN: Add staging/index Chinese translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>
References: <cover.1666067195.git.me@lirui.org>
 <4ef47cfc6c85ad9c778af1f13761e8dd8e410ee8.1666067195.git.me@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <4ef47cfc6c85ad9c778af1f13761e8dd8e410ee8.1666067195.git.me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuKW3k9jnUkBAA--.5369S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ur4ruF1DXry5Cry3Kw43Awb_yoW8tF15pF
        1kKr97KF1fXw43C34fWF17Wr1rCF4xGa18GF42qwnYqr1DJF40yrn8trZ8K34fWrWfZay8
        ZF4rKFWj9w4jy3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I
        6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/22 12:31, Rui Li wrote:
> Translate the following files into Chinese:
>
> - Documentation/staging/index.rst
>
> Add it into the menu of zh_CN/index. Also fix one translation
> in the zh_CN/index file.
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>   Documentation/translations/zh_CN/index.rst    |  8 +++---
>   .../translations/zh_CN/staging/index.rst      | 27 +++++++++++++++++++
>   2 files changed, 31 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/translations/zh_CN/staging/index.rst
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index ec99ef5fe990..3d07b3149afe 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -124,13 +124,13 @@ TODOList:
>   其他文档
>   --------
>   
> -有几份未排序的文档似乎不适合放在文档的其他部分，或者可能需要进行一些调整和/或
> +有几份未分类的文档似乎不适合放在文档的其他部分，或者可能需要进行一些调整和/或
>   转换为reStructureText格式，也有可能太旧。
>   
> -TODOList:
> -
> -* staging/index
> +.. toctree::
> +   :maxdepth: 2
>   
> +   staging/index
>   
>   索引和表格
>   ----------
> diff --git a/Documentation/translations/zh_CN/staging/index.rst b/Documentation/translations/zh_CN/staging/index.rst
> new file mode 100644
> index 000000000000..7d074b34ac97
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/staging/index.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/staging/index.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +未分类文档
> +======================
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   xz

The thing of adding xz to the index should be put to patch 1, one patch 
to do one thing.


Logically, this patch should be used as patch 1, otherwise xz will be 
homeless at some point.


Thanks,

Yanteng

> +
> +TODOList:
> +
> +* crc32
> +* lzo
> +* remoteproc
> +* rpmsg
> +* speculation
> +* static-keys
> +* tee
> +* xz

