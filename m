Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98472A1CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjFISIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFISID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:08:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFDE530FE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:08:01 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Ax3eqAaoNkJFYBAA--.3692S3;
        Sat, 10 Jun 2023 02:08:00 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxduR+aoNkljUMAA--.36552S3;
        Sat, 10 Jun 2023 02:07:59 +0800 (CST)
Message-ID: <79e07134-4f89-22dd-5a9c-3c8dfac50bf2@loongson.cn>
Date:   Sat, 10 Jun 2023 02:07:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 6/8] drm/etnaviv: add driver support for the PCI
 devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sui Jingfeng <15330273260@189.cn>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230609175201.GA1253027@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230609175201.GA1253027@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxduR+aoNkljUMAA--.36552S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1furWfXw15Wry7Kw1fKrX_yoW8AFy7pr
        WYva409a17tr1xJr1Ivw1kWF95tw4rA3s0vas8ur18KrnY93Z0gFy0vF4DWryagr1UJa4I
        yw43ZFy3AanrW3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fsqJUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/10 01:52, Bjorn Helgaas wrote:
> On Fri, Jun 09, 2023 at 09:37:02AM +0800, Sui Jingfeng wrote:
>> On 2023/6/9 01:32, Bjorn Helgaas wrote:
>>> On Wed, Jun 07, 2023 at 06:55:49PM +0800, Sui Jingfeng wrote:
>>>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>>>
>>>> This patch adds PCI driver support on top of what we already have. Take
>>>> the GC1000 in LS7A1000/LS2K1000 as the first instance of the PCI device
>>>> driver. There is only one GPU core for the GC1000 in the LS7A1000 and
>>>> LS2K1000. Therefore, component frameworks can be avoided.
>>>> +	{PCI_VENDOR_ID_LOONGSON, 0x7a15, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>>>> +	{PCI_VENDOR_ID_LOONGSON, 0x7a05, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>>> PCI_VDEVICE()
>> This make it impossible to hook device-specific data in the future.
>>
>> But currently there no device specific data associated with the
>> 0x7a05 and 0x7a15,
>>
>> so it's acceptable for now. Thanks.
> Haha, ISTR having this conversation before, sorry for repeating it.
>
> Indeed, it's fine as-is.  But PCI_VDEVICE() actually *does* allow for
> vendor-specific data because it doesn't include the data element,
> which defaults to zero if you don't specify it.
>
> So for example, drivers/net/ethernet/realtek/r8169_main.c has this:
>
>    { PCI_VDEVICE(REALTEK, 0x8129) },
>    { PCI_VDEVICE(REALTEK, 0x8136), RTL_CFG_NO_GBIT },
>
> where 0x8129 has no driver_data (it defaults to zero), but 0x8136
> does.

Yeah, I'm wrong.

PCI_VDEVICE macro end with two zero. (I thought it was three)

Thanks for the education.

With those lessons learned, I somewhat know how to create patch.

It should meet community's requirement before sending.

I'm too naive in the before.

Thanks a lot, really.

> Bjorn

-- 
Jingfeng

