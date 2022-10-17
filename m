Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72686023D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJRFjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJRFjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:39:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA4219E0E4;
        Mon, 17 Oct 2022 22:39:04 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8DxPdmCV01j_hEAAA--.503S3;
        Mon, 17 Oct 2022 21:24:18 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTuCBV01jCCEAAA--.545S3;
        Mon, 17 Oct 2022 21:24:17 +0800 (CST)
Message-ID: <9784c586-4853-d4f8-c589-bec7037badc9@loongson.cn>
Date:   Mon, 17 Oct 2022 21:24:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] docs/zh_CN: Add userspace-api/index Chinese
 translation
Content-Language: en-US
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <166592153626.7.4500669936128595360.69288105@lirui.org>
 <166592154155.8.13781703774239604072.69288121@lirui.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <166592154155.8.13781703774239604072.69288121@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTuCBV01jCCEAAA--.545S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr1UJw1rJr15Gr1kKrW7Jwb_yoW5GFWkpr
        yvkryfK3W7JrW3CrWfWF1UGF1xK3WxZa1UKw4xWw1Fqa4DAF1kArnrKrZxKrnrGrWfAa48
        JFsYqFW8ury2y3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bIAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8w
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42
        IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzKZXUUUUU
X-Gw-Check: b8d9fc5d79e760fb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/22 19:58, Rui Li wrote:
> Translate userspace-api/index.rst into Chinese, add it into
> zh_CN/index.rst.
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>   Documentation/translations/zh_CN/index.rst    |  2 +-
>   .../zh_CN/userspace-api/index.rst             | 50 +++++++++++++++++++
>   2 files changed, 51 insertions(+), 1 deletion(-)
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
> index 000000000000..4f5bc5530ebd
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/index.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +=====================================
> +Linux 内核用户空间API指南
> +=====================================
Alignment required.
> +
> +.. _man-pages: https://www.kernel.org/doc/man-pages/
> +
> +尽管许多用户空间API的文档被记录在别处（特别是在 man-pages_ 项目中），有关用户
> +空间的部分信息仍然可以在代码树中被找到。这个手册意在成为这些信息聚集的地方。

在代码树中仍然可以找到有关用户空间的部分信息


Thanks,
Yanteng

> +
> +.. class:: toc-title
> +
> +	   目录
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   ebpf/index
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
> \ No newline at end of file

