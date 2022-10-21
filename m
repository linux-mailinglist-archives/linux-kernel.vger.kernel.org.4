Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B46070CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJUHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:16:58 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E3D41EEF2B;
        Fri, 21 Oct 2022 00:16:50 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8Dx_7eN91FjcUYBAA--.4058S3;
        Fri, 21 Oct 2022 09:36:13 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxj+CL91Fj1lYCAA--.9356S3;
        Fri, 21 Oct 2022 09:36:12 +0800 (CST)
Message-ID: <70e2eb50-a24b-5f5e-631f-85d86e58e1a1@loongson.cn>
Date:   Fri, 21 Oct 2022 09:36:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/2] docs/zh_CN: Add staging/index Chinese translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1666275798.git.me@lirui.org>
 <50ffa90ad6dacc321cedc194d30a029383a737a9.1666275798.git.me@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <50ffa90ad6dacc321cedc194d30a029383a737a9.1666275798.git.me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxj+CL91Fj1lYCAA--.9356S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uw4DCrW5GFWUGr4DCw1kAFb_yoW8KrW8pF
        ykKr93KF1fXw13CryxGF17WF1rCa1xGa18Gr12qwnYqr1DJF40yr1Dtr98Ka4fJrWfZFWr
        ZF4rKFWj93yjy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Gw-Check: b8d9fc5d79e760fb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/20/22 22:42, Rui Li wrote:
> Translate the following files into Chinese:
>
> - Documentation/staging/index.rst
>
> Add it into the menu of zh_CN/index. Also fix one translation
> in the zh_CN/index file.
>
> Signed-off-by: Rui Li <me@lirui.org>

Hi Rui,


My review tag label is missing.


Usually, b4 can help you do this.


git clone git://git.kernel.org/pub/scm/utils/b4/b4.git  (or pip install)

b4 am <message-id>

$: git am xxxxxx.mbx

$: git format-patch <sha>

modify your patch

$: git am *.patch

build test

...


Thanks,

Yanteng

> ---
> No change since v2
>
> Changes since v1:
> - Add xz into menu later
> ---
>   Documentation/translations/zh_CN/index.rst    |  8 +++----
>   .../translations/zh_CN/staging/index.rst      | 22 +++++++++++++++++++
>   2 files changed, 26 insertions(+), 4 deletions(-)
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
> index 000000000000..e26603892a6f
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/staging/index.rst
> @@ -0,0 +1,22 @@
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
> +==========
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

