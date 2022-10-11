Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE64B5FB26B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJKM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJKM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:27:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5EED237D9;
        Tue, 11 Oct 2022 05:27:33 -0700 (PDT)
Received: from [192.168.100.127] (unknown [223.106.24.89])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axy2ovYUVjpu8qAA--.19939S3;
        Tue, 11 Oct 2022 20:27:28 +0800 (CST)
Message-ID: <4e53e48a-eb2e-2cdf-bb76-39097d6913b8@loongson.cn>
Date:   Tue, 11 Oct 2022 20:27:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/4] docs/zh_CN: Rewrite the Chinese translation front
 page
Content-Language: en-US
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>,
        Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1665467392.git.bobwxc@email.cn>
 <440d7cb3c9f1526ed7c2996aa88ba2bc7fdc018c.1665467392.git.bobwxc@email.cn>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <440d7cb3c9f1526ed7c2996aa88ba2bc7fdc018c.1665467392.git.bobwxc@email.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axy2ovYUVjpu8qAA--.19939S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWxZFy7Wr1ktryUtFWkWFg_yoWxXr18pr
        13tryfKr48XF12kr9xKFnrGry8G3WIkF18t3y5Gr1rKr1kAFy7tr1aqw1fJryDJrZ8AryD
        J3W5KF4kZw17trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUywvKUUUUU
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/22 14:02, Wu XiangCheng wrote:
> From: Wu XiangCheng <bobwxc@email.cn>
>
> update to commit 0c7b4366f1ab ("docs: Rewrite the front page")
>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>   Documentation/translations/zh_CN/index.rst | 169 +++++++--------------
>   1 file changed, 51 insertions(+), 118 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index 2fc60e60feb4..7be728bed46d 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -26,165 +26,98 @@
>   顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
>   的字符标点占用两个英文字符宽度， 所以，当英文要求不要超过每行100个字符时，
>   中文就不要超过50个字符。另外，也要注意'-'，'=' 等符号与相关标题的对齐。在将
> -补丁提交到社区之前，一定要进行必要的checkpatch.pl检查和编译测试。
> +补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试。
>   
> -许可证文档
> -----------
> -
> -下面的文档介绍了Linux内核源代码的许可证（GPLv2）、如何在源代码树中正确标记
> -单个文件的许可证、以及指向完整许可证文本的链接。
> +与Linux 内核社区一起工作
> +------------------------
>   
> -* Documentation/translations/zh_CN/process/license-rules.rst
> -
> -用户文档
> ---------
> -
> -下面的手册是为内核用户编写的——即那些试图让它在给定系统上以最佳方式工作的
> -用户。
> +与内核开发社区进行协作并将工作推向上游的基本指南。
>   
>   .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>   
> -   admin-guide/index
> -
> -TODOList:
> -
> -* kbuild/index
> +   process/development-process
> +   process/submitting-patches
> +   行为准则 <process/code-of-conduct>
> +   maintainer/index
> +   完整开发流程文档 <process/index>
>   
> -固件相关文档
> -------------
> +内部API文档
> +-----------
>   
> -下列文档描述了内核需要的平台固件相关信息。
> +开发人员使用的内核内部交互接口手册。
>   
>   .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>   
> -   devicetree/index
> +   core-api/index
> +   driver-api/index
> +   内核中的锁 <locking/index>
>   
>   TODOList:
>   
> -* firmware-guide/index
> -
> -应用程序开发人员文档
> ---------------------
> -
> -用户空间API手册涵盖了描述应用程序开发人员可见内核接口方面的文档。
> -
> -TODOlist:
> -
> -* userspace-api/index
> +* subsystem-apis
>   
> -内核开发简介
> -------------
> +开发工具和流程
> +--------------
>   
> -这些手册包含有关如何开发内核的整体信息。内核社区非常庞大，一年下来有数千名
> -开发人员做出贡献。与任何大型社区一样，知道如何完成任务将使得更改合并的过程
> -变得更加容易。
> +为所有内核开发人员提供有用信息的各种其他手册。
>   
>   .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>   
> -   process/index
> -   dev-tools/index
> +   process/license-rules
>      doc-guide/index
> +   dev-tools/index
> +   dev-tools/testing-overview
>      kernel-hacking/index
> -   maintainer/index
>   
>   TODOList:
>   
>   * trace/index
>   * fault-injection/index
>   * livepatch/index
> -* rust/index
>   
> -内核API文档
> ------------
> +面向用户的文档
> +--------------
>   
> -以下手册从内核开发人员的角度详细介绍了特定的内核子系统是如何工作的。这里的
> -大部分信息都是直接从内核源代码获取的，并根据需要添加补充材料（或者至少是在
> -我们设法添加的时候——可能不是所有的都是有需要的）。
> +下列手册针对
> +希望内核在给定系统上以最佳方式工作的*用户*，
> +和查找内核用户空间API信息的程序开发人员。
>   
>   .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>   
> -   core-api/index
> -   driver-api/index
> -   locking/index
> -   accounting/index
> -   cpu-freq/index
> -   iio/index
> -   infiniband/index
> -   power/index
> -   virt/index
> -   sound/index
> -   filesystems/index
> -   scheduler/index
> -   mm/index
> -   peci/index
> -   PCI/index
> +   admin-guide/index
> +   admin-guide/reporting-issues.rst
>   
>   TODOList:
>   
> -* block/index
> -* cdrom/index
> -* ide/index
> -* fb/index
> -* fpga/index
> -* hid/index
> -* i2c/index
> -* isdn/index
> -* leds/index
> -* netlabel/index
> -* networking/index
> -* pcmcia/index
> -* target/index
> -* timers/index
> -* spi/index
> -* w1/index
> -* watchdog/index
> -* input/index
> -* hwmon/index
> -* gpu/index
> -* security/index
> -* crypto/index
> -* bpf/index
> -* usb/index
> -* scsi/index
> -* misc-devices/index
> -* mhi/index
> -
> -体系结构无关文档
> -----------------
> -
> -TODOList:
> +* 内核构建系统 <kbuild/index>
> +* 用户空间工具 <tools/index>
> +* userspace-api/index
>   
> -* asm-annotations
> +固件相关文档
> +------------
>   
> -特定体系结构文档
> -----------------
> +下列文档描述了内核需要的平台固件相关信息。
>   
>   .. toctree::
>      :maxdepth: 2
>   
> -   mips/index
> -   arm64/index
> -   riscv/index
> -   openrisc/index
> -   parisc/index
> -   loongarch/index
> +   devicetree/index
>   
>   TODOList:
>   
> -* arm/index
> -* ia64/index
> -* m68k/index
> -* nios2/index
> -* powerpc/index
> -* s390/index
> -* sh/index
> -* sparc/index
> -* x86/index
> -* xtensa/index
> +* firmware-guide/index
> +
> +体系结构文档
> +------------
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   arch
>   
>   其他文档
>   --------
> @@ -195,9 +128,9 @@ TODOList:
>   TODOList:
>   
>   * staging/index
> -* watch_queue
>   
> -目录和表格
> +
> +索引和表格
>   ----------
>   
>   * :ref:`genindex`

