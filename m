Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11022625A88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKKMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:36:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B90804299B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:36:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFEEF1FB;
        Fri, 11 Nov 2022 04:37:01 -0800 (PST)
Received: from [10.57.38.243] (unknown [10.57.38.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14363F534;
        Fri, 11 Nov 2022 04:36:53 -0800 (PST)
Message-ID: <370142aa-8eae-8424-826d-c1fc21e4ea0f@arm.com>
Date:   Fri, 11 Nov 2022 12:36:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
 <3a7f5cdf-640b-f9d4-a25e-8be845abd7ba@linux.intel.com>
 <Y2wK6kWHE1iah/IG@char.us.oracle.com>
 <0f1ad424-18b0-c27f-dbf6-745801182bd2@linux.intel.com>
 <Y21mitQsO2RG652t@char.us.oracle.com>
 <e03aaca5-b62d-451c-85e0-53c28e8eea82@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e03aaca5-b62d-451c-85e0-53c28e8eea82@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-11 02:31, Baolu Lu wrote:
> On 2022/11/11 5:00, Konrad Rzeszutek Wilk wrote:
>> On Thu, Nov 10, 2022 at 02:39:53PM +0800, Baolu Lu wrote:
>>> On 2022/11/10 4:17, Konrad Rzeszutek Wilk wrote:
>>>> On Wed, Nov 09, 2022 at 09:16:53PM +0800, Baolu Lu wrote:
>>>>> On 2022/11/9 20:16, Harshit Mogalapalli wrote:
>>>>>>
>>>>>>
>>>>>> On 09/11/22 12:35 pm, Baolu Lu wrote:
>>>>>>> On 2022/11/8 20:58, Harshit Mogalapalli wrote:
>>>>>>>> It is likely that modern intel motherboard will not ship with a
>>>>>>>> floppy connection anymore, so let us disable it by default, as it
>>>>>>>> gets turned on when we do a make defconfig.
>>>>>>>>
>>>>>>>> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>>>> Signed-off-by: Harshit Mogalapalli 
>>>>>>>> <harshit.m.mogalapalli@oracle.com>
>>>>>>>> ---
>>>>>>>>     drivers/iommu/intel/Kconfig | 2 +-
>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iommu/intel/Kconfig 
>>>>>>>> b/drivers/iommu/intel/Kconfig
>>>>>>>> index b7dff5092fd2..c783ae85ca9b 100644
>>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>>> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>>>>>           option is removed in the 2.6.32 kernel.
>>>>>>>>     config INTEL_IOMMU_FLOPPY_WA
>>>>>>>> -    def_bool y
>>>>>>>> +    def_bool n
>>>>>>>>         depends on X86
>>>>>>>>         help
>>>>>>>>           Floppy disk drivers are known to bypass DMA API calls
>>>>>>>
>>>>>>> Nobody selects or depends on this. How about removing this bool? 
>>>>>>> Only
>>>>>>> less than 10 lines of code are impacted and are not in any 
>>>>>>> performance
>>>>>>> path.
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/intel/Kconfig 
>>>>>>> b/drivers/iommu/intel/Kconfig
>>>>>>> index b7dff5092fd2..5e077d1c5f5d 100644
>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>>>>           to use physical addresses for DMA, at least until this
>>>>>>>           option is removed in the 2.6.32 kernel.
>>>>>>>
>>>>>>> -config INTEL_IOMMU_FLOPPY_WA
>>>>>>> -    def_bool y
>>>>>>> -    depends on X86
>>>>>>> -    help
>>>>>>> -      Floppy disk drivers are known to bypass DMA API calls
>>>>>>> -      thereby failing to work when IOMMU is enabled. This
>>>>>>> -      workaround will setup a 1:1 mapping for the first
>>>>>>> -      16MiB to make floppy (an ISA device) work.
>>>>>>> -
>>>>>>>     config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>>>>>>         bool "Enable Intel IOMMU scalable mode by default"
>>>>>>>         default y
>>>>>>> diff --git a/drivers/iommu/intel/iommu.c 
>>>>>>> b/drivers/iommu/intel/iommu.c
>>>>>>> index 48cdcd0a5cf3..22801850f339 100644
>>>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>>>> @@ -4567,7 +4567,6 @@ static void
>>>>>>> intel_iommu_get_resv_regions(struct device *device,
>>>>>>>         }
>>>>>>>         rcu_read_unlock();
>>>>>>>
>>>>>>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>>>>>         if (dev_is_pci(device)) {
>>>>>>>             struct pci_dev *pdev = to_pci_dev(device);
>>>>>>>
>>>>>>> @@ -4579,7 +4578,6 @@ static void
>>>>>>> intel_iommu_get_resv_regions(struct device *device,
>>>>>>>                     list_add_tail(&reg->list, head);
>>>>>>>             }
>>>>>>>         }
>>>>>>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>>>>>>
>>>>>>>         reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>>>>>>                           IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>>>>>>>
>>>>>>
>>>>>> Hi Baolu,
>>>>>>
>>>>>> I have a question:
>>>>>> Shouldn't we remove the code between ifdef-endif statements?
>>>>>>
>>>>>> I mean something like this:
>>>>>>
>>>>>> diff --git a/drivers/iommu/intel/Kconfig 
>>>>>> b/drivers/iommu/intel/Kconfig
>>>>>> index b7dff5092fd2..5e077d1c5f5d 100644
>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>>>              to use physical addresses for DMA, at least until this
>>>>>>              option is removed in the 2.6.32 kernel.
>>>>>>
>>>>>> -config INTEL_IOMMU_FLOPPY_WA
>>>>>> -       def_bool y
>>>>>> -       depends on X86
>>>>>> -       help
>>>>>> -         Floppy disk drivers are known to bypass DMA API calls
>>>>>> -         thereby failing to work when IOMMU is enabled. This
>>>>>> -         workaround will setup a 1:1 mapping for the first
>>>>>> -         16MiB to make floppy (an ISA device) work.
>>>>>> -
>>>>>>     config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>>>>>            bool "Enable Intel IOMMU scalable mode by default"
>>>>>>            default y
>>>>>> diff --git a/drivers/iommu/intel/iommu.c 
>>>>>> b/drivers/iommu/intel/iommu.c
>>>>>> index 48cdcd0a5cf3..2c416ad3204e 100644
>>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>>> @@ -4567,20 +4567,6 @@ static void 
>>>>>> intel_iommu_get_resv_regions(struct
>>>>>> device *device,
>>>>>>            }
>>>>>>            rcu_read_unlock();
>>>>>>
>>>>>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>>>> -       if (dev_is_pci(device)) {
>>>>>> -               struct pci_dev *pdev = to_pci_dev(device);
>>>>>> -
>>>>>> -               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
>>>>>> -                       reg = iommu_alloc_resv_region(0, 1UL << 
>>>>>> 24, prot,
>>>>>> -                                       IOMMU_RESV_DIRECT_RELAXABLE,
>>>>>> -                                       GFP_KERNEL);
>>>>>> -                       if (reg)
>>>>>> -                               list_add_tail(&reg->list, head);
>>>>>> -               }
>>>>>> -       }
>>>>>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>>>>> -
>>>>>>            reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>>>>>                                          IOAPIC_RANGE_END -
>>>>>> IOAPIC_RANGE_START + 1,
>>>>>>                                          0, IOMMU_RESV_MSI, 
>>>>>> GFP_KERNEL);
>>>>>>
>>>>>> This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: 
>>>>>> Expose ISA
>>>>>> direct mapping region via iommu_get_resv_regions")
>>>>>
>>>>> As long as floppy driver exists in the tree, we have to include above
>>>>> code. Otherwise, floppy drivers don't work. At least we can easily 
>>>>> find
>>>>> drivers/block/floppy.c which is still maintained (check 
>>>>> MAINTAINERS).:-)
>>>>
>>>> But this requires a machine with Intel IOMMU and ISA:
>>>>
>>>>>>> -      16MiB to make floppy (an ISA device) work.
>>>>
>>>> ISA device? I don't believe there are any Intel machines with an IOMMU
>>>> and an ISA device?
>>>
>>> This workaround was introduced by commit 49a0429e53f2 ("Intel IOMMU:
>>> Iommu floppy workaround") in 2007. I can't remember what happened 15
>>> years ago, but I believe there must have been corresponding hardware
>>> configurations at that time, and the Linux kernel has been maintained it
>>> to now.
>>
>> At what point can this be removed then?
> 
> No floppy block drivers in the tree or all floppy drivers' DMA going
> through the kernel DMA APIs.

Presumably the point of the config is that ISA bridges aren't expected 
on IA-64, so a tiny code saving can be made there, but at this point is 
anyone really that bothered about any more? There's already tons more 
code all through the driver to support newer features that aren't 
meaningful to old IA-64 hardware, so in my opinion, meh. Given that this 
already won't affect systems that truly can't have any ISA devices, I 
don't see any issue with simply making it unconditional.

Note that plenty of chipsets still have an "ISA" bridge to an LPC 
interface, so ISA DMA is not necessarily as dead as one might like to think.

Robin.
