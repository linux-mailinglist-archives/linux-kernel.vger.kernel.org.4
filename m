Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A86057B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJTGzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJTGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:55:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 549476AA10;
        Wed, 19 Oct 2022 23:55:20 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8DxndrW8FBjtPYAAA--.5033S3;
        Thu, 20 Oct 2022 14:55:18 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxn+DU8FBjrMMBAA--.7434S3;
        Thu, 20 Oct 2022 14:55:16 +0800 (CST)
Message-ID: <4ed2ffe6-0bb8-0a9e-6144-7a72e4bcb6de@loongson.cn>
Date:   Thu, 20 Oct 2022 14:55:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/2] docs/zh_CN: Add userspace-api/index Chinese
 translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1666185911.git.me@lirui.org>
 <76b86e687034d5347e1e49c4acfc28e9c45abe47.1666185911.git.me@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <76b86e687034d5347e1e49c4acfc28e9c45abe47.1666185911.git.me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxn+DU8FBjrMMBAA--.7434S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCrWkuF4xZry5WFy3XF18Xwb_yoW5GF1rpr
        yvkr93K3WxJrW3CrZ3WFnrGF1xK3Wxua1UKw4Sqw1Fqas8AF1kAr1DKrW3KF9rGrWfZa48
        JFsYgFW09ry2y3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/22 21:30, Rui Li wrote:
> Translate userspace-api/index.rst into Chinese, add it into
> zh_CN/index.rst.
>
> Signed-off-by: Rui Li <me@lirui.org>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
> Changes since v2:
> - Change patch set order
>
> Changes since v1:
> - Align title
> - Change some translation
> ---
>   Documentation/translations/zh_CN/index.rst    |  2 +-
>   .../zh_CN/userspace-api/index.rst             | 46 +++++++++++++++++++
>   2 files changed, 47 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index ec99ef5fe990..272414971ce9 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -90,12 +90,12 @@ TODOList:
>   
>      admin-guide/index
>      admin-guide/reporting-issues.rst
> +   userspace-api/index
>   
>   TODOList:
>   
>   * 内核构建系统 <kbuild/index>
>   * 用户空间工具 <tools/index>
> -* userspace-api/index
>   
>   也可参考独立于内核文档的 `Linux 手册页 <https://www.kernel.org/doc/man-pages/>`_ 。
>   
> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
> new file mode 100644
> index 000000000000..3b834fe7e33b
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/index.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +=========================
> +Linux 内核用户空间API指南
> +=========================
> +
> +.. _man-pages: https://www.kernel.org/doc/man-pages/
> +
> +尽管许多用户空间API的文档被记录在别处（特别是在 man-pages_ 项目中），
> +在代码树中仍然可以找到有关用户空间的部分信息。这个手册意在成为这些信息
> +聚集的地方。
> +
> +.. class:: toc-title
> +
> +	   目录
> +
> +TODOList:
> +
> +* no_new_privs
> +* seccomp_filter
> +* landlock
> +* unshare
> +* spec_ctrl
> +* accelerators/ocxl
> +* ebpf/index
> +* ioctl/index
> +* iommu
> +* media/index
> +* netlink/index
> +* sysfs-platform_profile
> +* vduse
> +* futex2
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`

