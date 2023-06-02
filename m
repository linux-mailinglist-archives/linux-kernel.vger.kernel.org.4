Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C271F788
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFBBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjFBBKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:10:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1CDBE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:10:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Dx_+txQXlkQ3gDAA--.7525S3;
        Fri, 02 Jun 2023 09:10:09 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_7NwQXlkNhmFAA--.19292S3;
        Fri, 02 Jun 2023 09:10:08 +0800 (CST)
Message-ID: <9405d7b7-081c-cbe9-8aa7-701b4b1d8b96@loongson.cn>
Date:   Fri, 2 Jun 2023 09:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <87zg5lj1yb.ffs@tglx>
Content-Language: en-US
From:   "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <87zg5lj1yb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_7NwQXlkNhmFAA--.19292S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFW5Gw4fZr48CF1DCrW8Xrb_yoW8WrWrpa
        yUJ3WS9FsxKrW2krn3tw4rWry0yFZ5Gr45Xr95Kr1qk3s7Jr9avrsrtr4Y9a43Cwn8Ca4j
        vFyFgFyUJryUAFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/30 23:03, Thomas Gleixner 写道:
> On Tue, May 30 2023 at 16:34, Huacai Chen wrote:
>> On Tue, May 30, 2023 at 4:19 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>> Let's take a step back and look at the larger picture:
>>>
>>>  1) A PCI/MSI irqdomain is attached to a PCI bus
>>>
>>>  2) The number of PCI devices on that PCI bus is usually known at boot
>>>     time _before_ the first device driver is probed.
>>>
>>>     That's not entirely true for PCI hotplug devices, but that's hardly
>>>     relevant for an architecture which got designed less than 10 years
>>>     ago and the architects decided that 256 MSI vectors are good enough
>>>     for up to 256 CPUs. The concept of per CPU queues was already known
>>>     at that time, no?
>> Does this solution depend on the per-device msi domain? Can we do that
>> if we use the global msi domain?
> 
> In principle it should not depend on per-device MSI domains, but I
> really don't want to add new functionality to the old operating models
> as that does not create an incentive for people to convert their stuff
> over.
> 
>>> So the irqdomain can tell the PCI/MSI core the maximum number of vectors
>>> available for a particular bus, right?
>>>
>>> The default, i.e if the irqdomain does not expose that information,
>>> would be "unlimited", i.e. ULONG_MAX.
>> OK, thanks, but how to expose? By msi_domain_info::hwsize?
> 
> Probably. Needs a proper helper around it.

It is not common issue, command line and documentation explanation
is not suitable here.

Can we add weak function like this?
int __weak arch_set_max_msix_vectors(void)

Regards
Bibo, mao
> 
> Thanks,
> 
>         tglx

