Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9F728EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbjFIDzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIDzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:55:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7D401BE2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:55:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxNumnooJkLuEAAA--.925S3;
        Fri, 09 Jun 2023 11:55:19 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxjcqmooJkirIJAA--.21536S3;
        Fri, 09 Jun 2023 11:55:18 +0800 (CST)
Message-ID: <2367a21b-507a-5635-260e-73929497275b@loongson.cn>
Date:   Fri, 9 Jun 2023 11:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 0/8] drm/etnaviv: add pci device driver support
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20230607105551.568639-1-15330273260@189.cn>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230607105551.568639-1-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxjcqmooJkirIJAA--.21536S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw18Wr45ZFWkCw1xuw1fKrX_yoW8tF4kpF
        47JFyYkry8ZrW7K347AFn8JF93G3WxWF9Yk3srt3sI9w45ZFyjvryqka15Jr9xXr1fAr42
        qr1a9r13WF15ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
        Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2T
        KZDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Any ideas ? I change it together at next version?


@lucas

@christian


On 2023/6/7 18:55, Sui Jingfeng wrote:
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
> v8:
> 	* Fix typos and remove unnecessary header included (Bjorn).
> 	* Add a dedicated function to create the virtual master platform
> 	  device.
>
> Sui Jingfeng (8):
>    drm/etnaviv: add a dedicated function to register an irq handler
>    drm/etnaviv: add a dedicated function to get various clocks
>    drm/etnaviv: add dedicated functions to create and destroy platform
>      devices
>    drm/etnaviv: add helpers for private data construction and destruction
>    drm/etnaviv: allow bypass component framework
>    drm/etnaviv: add driver support for the PCI devices
>    drm/etnaviv: add support for the dma coherent device
>    drm/etnaviv: add a dedicated function to create the virtual master
>
>   drivers/gpu/drm/etnaviv/Kconfig             |  10 +
>   drivers/gpu/drm/etnaviv/Makefile            |   2 +
>   drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 257 ++++++++++++++------
>   drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  10 +
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  22 +-
>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 168 ++++++++-----
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.h       |   9 +
>   drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c   |  75 ++++++
>   drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h   |   9 +
>   include/uapi/drm/etnaviv_drm.h              |   1 +
>   11 files changed, 440 insertions(+), 130 deletions(-)
>   create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
>   create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
>
-- 
Jingfeng

