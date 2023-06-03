Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2601720FE9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjFCLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 07:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFCLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 07:20:48 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31BDB180
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 04:20:45 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxhPANIntko+wDAA--.8367S3;
        Sat, 03 Jun 2023 19:20:45 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLL4LIntk9DuHAA--.21806S3;
        Sat, 03 Jun 2023 19:20:43 +0800 (CST)
Message-ID: <af174b6c-3330-c054-23e4-32c41972eb53@loongson.cn>
Date:   Sat, 3 Jun 2023 19:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 0/7] drm/etnaviv: add pci device driver support
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20230603105943.3042766-1-15330273260@189.cn>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230603105943.3042766-1-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLL4LIntk9DuHAA--.21806S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuryxtr1UJry7AFW7CF1kuFg_yoW5WrWkpF
        47JFyYyry8ZrW7Kw17AFn8XFyfGa4xWF9Yk3srt3sI9ws0vFyjvry8KFs8Ar9xXr1fJr42
        qr1a9r1fWF13ArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        byAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjcxG6x
        CI17CEII8vrVW3JVW8Jr1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1l
        IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bjyCJUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Sorry for sending duplicated patches.  Please don't get angry by me.

I'm just sending a patch set, which contain 7 patch. The command is as 
following:


git send-email V7/ --to "Lucas Stach <l.stach@pengutronix.de>" --to 
"Christian Gmeiner <christian.gmeiner@gmail.com>" --to "Daniel Vetter 
<daniel@ffwll.ch>" --to "Bjorn Helgaas <bhelgaas@google.com>" --cc 
"linux-kernel@vger.kernel.org" --cc "etnaviv@lists.freedesktop.org" --cc 
"dri-devel@lists.freedesktop.org" --cc "loongson-kernel@lists.loongnix.cn"


After run the above about command with my company's mailbox,  the 
termial report  "Too many commands"

which cause the last few patch of the whole patch set did not get send 
out(get lost).


Then,  I changed to another mail to send the patch with the same 
command, then its works finally.

Please don't get angry by me. Thanks.


On 2023/6/3 18:59, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> There is a Vivante GC1000 (v5037) in LS2K1000 and LS7A1000, this GPU is a
> PCI device, and it has 2D and 3D cores in the same core. Thus, this patch
> set is trying to add PCI device driver support to etnaviv.
>
> v6:
> 	* Fix build issue on system without CONFIG_PCI enabled
> v7:
> 	* Add a separate patch for the platform driver rearrangement (Bjorn)
> 	* Switch to runtime check if the GPU is dma coherent or not (Lucas)
> 	* Add ETNAVIV_PARAM_GPU_COHERENT to allow userspace to query (Lucas)
> 	* Remove etnaviv_gpu.no_clk member (Lucas)
> 	* Various Typos and coding style fixed (Bjorn)
>
> Sui Jingfeng (7):
>    drm/etnaviv: add a dedicated function to register an irq handler
>    drm/etnaviv: add a dedicated function to get various clocks
>    drm/etnaviv: add dedicated functions to create and destroy platform
>      devices
>    drm/etnaviv: add helpers for private data construction and destruction
>    drm/etnaviv: allow bypass component framework
>    drm/etnaviv: add driver support for the PCI devices
>    drm/etnaviv: add support for the dma coherent device
>
>   drivers/gpu/drm/etnaviv/Kconfig             |   9 +
>   drivers/gpu/drm/etnaviv/Makefile            |   2 +
>   drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 228 +++++++++++++++-----
>   drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  10 +
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  22 +-
>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 170 ++++++++++-----
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.h       |   9 +
>   drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c   |  75 +++++++
>   drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h   |   9 +
>   include/uapi/drm/etnaviv_drm.h              |   1 +
>   11 files changed, 422 insertions(+), 120 deletions(-)
>   create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
>   create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
>
-- 
Jingfeng

